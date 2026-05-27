import * as admin from "firebase-admin";
import {hashValue} from "./auth";
import {UsageIdentity, UsageLimit} from "./types";

const defaultPolicy = {
  freeMonthlyLimit: 10,
  paidMonthlyLimit: 500,
};

export class RateLimitExceededError extends Error {
  constructor(readonly limit: UsageLimit) {
    super(
      limit.tier === "paid" ?
        `今月のAIチャット利用上限 (${limit.limit}回) に達しました。` :
        `今月の無料AIチャット利用上限 (${limit.limit}回) に達しました。`,
    );
  }
}

export function resolveUsageLimit(
  isPremiumUser: boolean,
): UsageLimit {
  const now = new Date();
  if (isPremiumUser) {
    return {
      tier: "paid",
      period: "monthly",
      limit: defaultPolicy.paidMonthlyLimit,
      periodKey: formatJstMonth(now),
    };
  }

  return {
    tier: "free",
    period: "monthly",
    limit: defaultPolicy.freeMonthlyLimit,
    periodKey: formatJstMonth(now),
  };
}

export async function consumeUsage(
  db: FirebaseFirestore.Firestore,
  identity: UsageIdentity,
  limit: UsageLimit,
): Promise<number> {
  const key = hashValue(`${identity.source}:${identity.id}:${limit.periodKey}`);
  const ref = db.collection("ai_chat_usage").doc(key);

  return db.runTransaction(async (transaction) => {
    const snapshot = await transaction.get(ref);
    const current = snapshot.exists ? Number(snapshot.get("count") ?? 0) : 0;
    if (current >= limit.limit) {
      throw new RateLimitExceededError(limit);
    }

    const next = current + 1;
    transaction.set(ref, {
      count: next,
      identitySource: identity.source,
      tier: limit.tier,
      period: limit.period,
      periodKey: limit.periodKey,
      limit: limit.limit,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      createdAt: snapshot.exists ?
        snapshot.get("createdAt") :
        admin.firestore.FieldValue.serverTimestamp(),
    }, {merge: true});
    return next;
  });
}

function formatJstMonth(date: Date): string {
  return formatJst(date, {
    year: "numeric",
    month: "2-digit",
  });
}

function formatJst(date: Date, options: Intl.DateTimeFormatOptions): string {
  return new Intl.DateTimeFormat("sv-SE", {
    ...options,
    timeZone: "Asia/Tokyo",
  }).format(date);
}
