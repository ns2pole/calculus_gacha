import * as admin from "firebase-admin";

import {hashValue} from "../../src/auth";
import {
  AI_TUTOR_LEGACY_ENTITLEMENT_ID,
  AI_TUTOR_LEGACY_PRODUCT_ID,
  AI_TUTOR_PRODUCT_ID,
  buildPassUsageDocId,
  legacyEntitlementRef,
  PASS_LIMIT,
  passesCollectionRef,
} from "../../src/aiTutorPasses";
import {UsageIdentity} from "../../src/types";

const FREE_MONTHLY_LIMIT = 15;

function formatJstMonth(date: Date): string {
  return new Intl.DateTimeFormat("sv-SE", {
    year: "numeric",
    month: "2-digit",
    timeZone: "Asia/Tokyo",
  }).format(date);
}

export function buildFreeUsageDocId(identity: UsageIdentity, date = new Date()): string {
  const periodKey = formatJstMonth(date);
  return hashValue(`${identity.source}:${identity.id}:${periodKey}`);
}

export async function seedFreeUsage(
  db: FirebaseFirestore.Firestore,
  identity: UsageIdentity,
  count: number,
  date = new Date(),
): Promise<void> {
  const periodKey = formatJstMonth(date);
  const ref = db.collection("ai_chat_usage").doc(buildFreeUsageDocId(identity, date));
  await ref.set({
    count,
    identitySource: identity.source,
    tier: "free",
    period: "monthly",
    periodKey,
    limit: FREE_MONTHLY_LIMIT,
  });
}

export async function seedPass(
  db: FirebaseFirestore.Firestore,
  userId: string,
  passId: string,
  options: {
    purchasedAtMs: number;
    expiresAtMs: number;
    limit?: number;
    productId?: string;
  },
): Promise<void> {
  const ref = passesCollectionRef(db, userId).doc(passId);
  await ref.set({
    productId: options.productId ?? AI_TUTOR_PRODUCT_ID,
    limit: options.limit ?? PASS_LIMIT,
    purchasedAt: admin.firestore.Timestamp.fromMillis(options.purchasedAtMs),
    expiresAt: admin.firestore.Timestamp.fromMillis(options.expiresAtMs),
    revenueCatEventId: null,
  });
}

export async function readPassUsageCount(
  db: FirebaseFirestore.Firestore,
  identity: UsageIdentity,
  passId: string,
): Promise<number> {
  const ref = db.collection("ai_chat_usage").doc(buildPassUsageDocId(identity, passId));
  const snapshot = await ref.get();
  if (!snapshot.exists) return 0;
  return Number(snapshot.get("count") ?? 0);
}

export async function readFreeUsageCount(
  db: FirebaseFirestore.Firestore,
  identity: UsageIdentity,
  date = new Date(),
): Promise<number> {
  const ref = db.collection("ai_chat_usage").doc(buildFreeUsageDocId(identity, date));
  const snapshot = await ref.get();
  if (!snapshot.exists) return 0;
  return Number(snapshot.get("count") ?? 0);
}

export async function seedLegacyEntitlement(
  db: FirebaseFirestore.Firestore,
  userId: string,
  options: {
    active: boolean;
    purchasedAtMs: number;
    expiresAtMs: number | null;
  },
): Promise<void> {
  await legacyEntitlementRef(db, userId).set({
    active: options.active,
    entitlementId: AI_TUTOR_LEGACY_ENTITLEMENT_ID,
    productId: AI_TUTOR_LEGACY_PRODUCT_ID,
    purchasedAt: admin.firestore.Timestamp.fromMillis(options.purchasedAtMs),
    expiresAt: options.expiresAtMs == null ?
      null :
      admin.firestore.Timestamp.fromMillis(options.expiresAtMs),
  });
}

export async function readLegacyEntitlementActive(
  db: FirebaseFirestore.Firestore,
  userId: string,
): Promise<boolean> {
  const snapshot = await legacyEntitlementRef(db, userId).get();
  if (!snapshot.exists) return false;
  return snapshot.get("active") === true;
}

export async function seedLegacyMonthlyUsage(
  db: FirebaseFirestore.Firestore,
  identity: UsageIdentity,
  count: number,
  date = new Date(),
): Promise<void> {
  const periodKey = new Intl.DateTimeFormat("sv-SE", {
    year: "numeric",
    month: "2-digit",
    timeZone: "Asia/Tokyo",
  }).format(date);
  const key = hashValue(`${identity.source}:${identity.id}:${periodKey}`);
  await db.collection("ai_chat_usage").doc(key).set({
    count,
    identitySource: identity.source,
    tier: "paid",
    period: "monthly",
    periodKey,
    limit: PASS_LIMIT,
  });
}
