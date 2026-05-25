import * as admin from "firebase-admin";
import {Request} from "firebase-functions/v2/https";
import {createHash} from "crypto";
import {readBearerToken} from "./http";
import {AiChatRequest, UsageIdentity} from "./types";

export async function resolveUsageIdentity(
  request: Request,
  chatRequest: AiChatRequest,
): Promise<UsageIdentity> {
  const token = readBearerToken(request);
  if (token != null) {
    try {
      const decoded = await admin.auth().verifyIdToken(token);
      return {id: decoded.uid, source: "firebase"};
    } catch {
      // Invalid tokens are ignored so free users can still use device-based quota.
    }
  }

  if (chatRequest.clientInstallationId.length > 0) {
    return {id: chatRequest.clientInstallationId, source: "installation"};
  }

  const ip = request.ip ?? request.header("x-forwarded-for") ?? "unknown";
  return {id: hashValue(ip), source: "ip"};
}

export function hashValue(value: string): string {
  return createHash("sha256").update(value).digest("hex");
}
