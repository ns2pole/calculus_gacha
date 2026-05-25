import * as admin from "firebase-admin";
import {defineSecret} from "firebase-functions/params";
import {onRequest} from "firebase-functions/v2/https";
import {resolveUsageIdentity} from "./auth";
import {applyRevenueCatWebhook, hasAiTutorEntitlement} from "./entitlements";
import {generateAiChatReply} from "./geminiClient";
import {assertPost, HttpError, sendJson} from "./http";
import {consumeUsage, RateLimitExceededError, resolveUsageLimit} from "./rateLimiter";
import {parseAiChatRequest} from "./requestValidator";

admin.initializeApp();

const geminiApiKey = defineSecret("GEMINI_API_KEY");
const revenueCatWebhookAuth = defineSecret("REVENUECAT_WEBHOOK_AUTH");

export const aiChat = onRequest({
  cors: true,
  region: "asia-northeast1",
  secrets: [geminiApiKey],
}, async (request, response) => {
  try {
    assertPost(request);

    const chatRequest = parseAiChatRequest(request.body);
    const identity = await resolveUsageIdentity(request, chatRequest);
    const isPremiumUser = await hasAiTutorEntitlement(admin.firestore(), identity);
    const limit = resolveUsageLimit(chatRequest, isPremiumUser);
    const usageCount = await consumeUsage(admin.firestore(), identity, limit);
    const text = await generateAiChatReply(geminiApiKey.value(), chatRequest);

    sendJson(response, 200, {
      message: {role: "assistant", text},
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
