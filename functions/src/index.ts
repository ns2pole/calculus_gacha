import * as admin from "firebase-admin";
import {defineSecret} from "firebase-functions/params";
import {onRequest, Request} from "firebase-functions/v2/https";
import {deleteFirebaseUserAccount} from "./accountDeletion";
import {resolveUsageIdentity} from "./auth";
import {
  applyRevenueCatWebhook,
  hasAiTutorEntitlement,
  syncAiTutorEntitlementFromRevenueCat,
} from "./entitlements";
import {generateAiChatReply} from "./geminiClient";
import {assertPost, HttpError, readBearerToken, sendJson} from "./http";
import {consumeUsage, RateLimitExceededError, resolveUsageLimit} from "./rateLimiter";
import {parseAiChatRequest} from "./requestValidator";

admin.initializeApp();

const geminiApiKey = defineSecret("GEMINI_API_KEY");
const revenueCatWebhookAuth = defineSecret("REVENUECAT_WEBHOOK_AUTH");
const revenueCatRestApiKey = defineSecret("REVENUECAT_REST_API_KEY");

export const aiChat = onRequest({
  cors: true,
  region: "asia-northeast1",
  secrets: [geminiApiKey],
}, async (request, response) => {
  try {
    assertPost(request);
    await assertAppCheckAuthorized(request);

    const chatRequest = parseAiChatRequest(request.body);
    const identity = await resolveUsageIdentity(request, chatRequest);
    const isPremiumUser = await hasAiTutorEntitlement(admin.firestore(), identity);
    const limit = resolveUsageLimit(isPremiumUser);
    const usageCount = await consumeUsage(admin.firestore(), identity, limit);
    const reply = await generateAiChatReply(geminiApiKey.value(), chatRequest);

    sendJson(response, 200, {
      message: {role: "assistant", text: reply.text},
      quickReplies: reply.quickReplies,
      usage: {
        count: usageCount,
        limit: limit.limit,
        tier: limit.tier,
        period: limit.period,
        periodKey: limit.periodKey,
      },
    });
  } catch (error) {
    if (error instanceof RateLimitExceededError) {
      sendJson(response, 429, {
        error: {
          code: "rate_limited",
          message: error.message,
          tier: error.limit.tier,
          limit: error.limit.limit,
        },
      });
      return;
    }

    if (error instanceof HttpError) {
      sendJson(response, error.status, {
        error: {
          code: error.code,
          message: error.message,
        },
      });
      return;
    }

    console.error(error);
    sendJson(response, 500, {
      error: {
        code: "internal",
        message: "AIチャットの処理中にエラーが発生しました。",
      },
    });
  }
});

async function assertAppCheckAuthorized(request: Request): Promise<void> {
  const token = request.header("X-Firebase-AppCheck");
  if (token == null || token.length === 0) {
    throw new HttpError(401, "app_check_required", "App Check token is required.");
  }

  try {
    await admin.appCheck().verifyToken(token);
  } catch {
    throw new HttpError(401, "app_check_failed", "App Check verification failed.");
  }
}

export const revenueCatWebhook = onRequest({
  cors: false,
  region: "asia-northeast1",
  secrets: [revenueCatWebhookAuth],
}, async (request, response) => {
  try {
    assertPost(request);
    await applyRevenueCatWebhook(
      admin.firestore(),
      request,
      revenueCatWebhookAuth.value(),
    );
    sendJson(response, 200, {ok: true});
  } catch (error) {
    if (error instanceof HttpError) {
      sendJson(response, error.status, {
        error: {
          code: error.code,
          message: error.message,
        },
      });
      return;
    }

    console.error(error);
    sendJson(response, 500, {
      error: {
        code: "internal",
        message: "Webhook processing failed.",
      },
    });
  }
});

export const syncAiTutorEntitlement = onRequest({
  cors: true,
  region: "asia-northeast1",
  secrets: [revenueCatRestApiKey],
}, async (request, response) => {
  try {
    assertPost(request);
    await assertAppCheckAuthorized(request);

    const uid = await requireFirebaseUid(request);
    const active = await syncAiTutorEntitlementFromRevenueCat(
      admin.firestore(),
      uid,
      revenueCatRestApiKey.value(),
    );

    sendJson(response, 200, {active});
  } catch (error) {
    if (error instanceof HttpError) {
      sendJson(response, error.status, {
        error: {
          code: error.code,
          message: error.message,
        },
      });
      return;
    }

    console.error(error);
    sendJson(response, 500, {
      error: {
        code: "internal",
        message: "Entitlement sync failed.",
      },
    });
  }
});

export const deleteMyAccount = onRequest({
  cors: true,
  region: "asia-northeast1",
}, async (request, response) => {
  try {
    assertPost(request);
    await assertAppCheckAuthorized(request);

    const uid = await requireFirebaseUid(request);
    await deleteFirebaseUserAccount(admin.firestore(), uid);

    sendJson(response, 200, {ok: true});
  } catch (error) {
    if (error instanceof HttpError) {
      sendJson(response, error.status, {
        error: {
          code: error.code,
          message: error.message,
        },
      });
      return;
    }

    console.error(error);
    sendJson(response, 500, {
      error: {
        code: "internal",
        message: "Account deletion failed.",
      },
    });
  }
});

async function requireFirebaseUid(request: Request): Promise<string> {
  const token = readBearerToken(request);
  if (token == null) {
    throw new HttpError(401, "auth_required", "Firebase authentication is required.");
  }

  try {
    const decoded = await admin.auth().verifyIdToken(token);
    return decoded.uid;
  } catch {
    throw new HttpError(401, "auth_failed", "Firebase authentication failed.");
  }
}
