import * as admin from "firebase-admin";
import {Request} from "firebase-functions/v2/https";
import {HttpError, readBearerToken} from "./http";
import {UsageIdentity} from "./types";

const aiTutorEntitlementId = "ai_tutor_subsc";
const aiTutorProductId = "ai_tutor_subsc_500yen";
const revenueCatSubscriberBaseUrl = "https://api.revenuecat.com/v1/subscribers";
const inactiveEventTypes = new Set([
  "EXPIRATION",
  "BILLING_ISSUE",
  "PRODUCT_CHANGE",
]);

export async function hasAiTutorEntitlement(
  db: FirebaseFirestore.Firestore,
  identity: UsageIdentity,
): Promise<boolean> {
  if (identity.source !== "firebase") return false;

  const ref = entitlementRef(db, identity.id);
  const snapshot = await ref.get();
  if (!snapshot.exists) return false;

  const active = snapshot.get("active") === true;
  const expiresAt = snapshot.get("expiresAt");
  if (!active) return false;
  if (expiresAt == null) return true;
  if (expiresAt instanceof admin.firestore.Timestamp) {
    return expiresAt.toMillis() > Date.now();
  }
  return false;
}

export async function applyRevenueCatWebhook(
  db: FirebaseFirestore.Firestore,
  request: Request,
  authSecret: string,
): Promise<void> {
  assertWebhookAuthorized(request, authSecret);

  const event = parseRevenueCatEvent(request.body);
  if (!isAiTutorEvent(event)) return;

  const active = isEntitlementActive(event);
  const expiresAt = event.expirationAtMs == null ?
    null :
    admin.firestore.Timestamp.fromMillis(event.expirationAtMs);
  const userIds = collectRevenueCatUserIds(event);

  await Promise.all(userIds.map((userId) => entitlementRef(db, userId).set({
    active,
    entitlementId: aiTutorEntitlementId,
    productId: event.productId,
    eventType: event.type,
    revenueCatEventId: event.id,
    expiresAt,
    purchasedAt: event.purchasedAtMs == null ?
      null :
      admin.firestore.Timestamp.fromMillis(event.purchasedAtMs),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  }, {merge: true})));
}

export async function syncAiTutorEntitlementFromRevenueCat(
  db: FirebaseFirestore.Firestore,
  userId: string,
  revenueCatApiKey: string,
): Promise<boolean> {
  if (revenueCatApiKey.length === 0) {
    throw new HttpError(500, "revenuecat_api_key_missing", "RevenueCat API key is not configured.");
  }

  const event = await fetchRevenueCatAiTutorEntitlement(userId, revenueCatApiKey);
  const active = event != null && isEntitlementActive(event);
  await entitlementRef(db, userId).set({
    active,
    entitlementId: aiTutorEntitlementId,
    productId: event?.productId ?? aiTutorProductId,
    eventType: "CLIENT_SYNC",
    revenueCatEventId: null,
    expiresAt: event?.expirationAtMs == null ?
      null :
      admin.firestore.Timestamp.fromMillis(event.expirationAtMs),
    purchasedAt: event?.purchasedAtMs == null ?
      null :
      admin.firestore.Timestamp.fromMillis(event.purchasedAtMs),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  }, {merge: true});

  return active;
}

function entitlementRef(db: FirebaseFirestore.Firestore, userId: string) {
  return db
    .collection("users")
    .doc(userId)
    .collection("entitlements")
    .doc(aiTutorEntitlementId);
}

function assertWebhookAuthorized(request: Request, authSecret: string): void {
  if (authSecret.length === 0) {
    throw new HttpError(500, "webhook_secret_missing", "Webhook secret is not configured.");
  }

  const token = readBearerToken(request) ?? request.header("authorization") ?? "";
  if (token !== authSecret) {
    throw new HttpError(401, "unauthorized", "Webhook authorization failed.");
  }
}

function parseRevenueCatEvent(body: unknown): RevenueCatEvent {
  if (!isRecord(body) || !isRecord(body.event)) {
    throw new HttpError(400, "invalid_webhook", "RevenueCat webhook payload is invalid.");
  }

  const event = body.event;
  return {
    id: readString(event.id) ?? readString(event.event_id) ?? "",
    type: readString(event.type) ?? "",
    appUserId: readString(event.app_user_id) ?? "",
    aliases: readStringArray(event.aliases),
    productId: readString(event.product_id),
    entitlementIds: readStringArray(event.entitlement_ids),
    expirationAtMs: readNumber(event.expiration_at_ms),
    purchasedAtMs: readNumber(event.purchased_at_ms),
  };
}

function isAiTutorEvent(event: RevenueCatEvent): boolean {
  return event.productId === aiTutorProductId ||
    event.entitlementIds.includes(aiTutorEntitlementId);
}

function isEntitlementActive(event: RevenueCatEvent): boolean {
  if (inactiveEventTypes.has(event.type)) return false;
  if (event.expirationAtMs == null) return true;
  return event.expirationAtMs > Date.now();
}

function collectRevenueCatUserIds(event: RevenueCatEvent): string[] {
  return Array.from(new Set([event.appUserId, ...event.aliases]
    .map(sanitizeFirebaseDocId)
    .filter((value) => value.length > 0)));
}

function sanitizeFirebaseDocId(value: string): string {
  return value.replace(/\//g, "_").slice(0, 128);
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null;
}

function readString(value: unknown): string | null {
  return typeof value === "string" ? value : null;
}

function readNumber(value: unknown): number | null {
  return typeof value === "number" && Number.isFinite(value) ? value : null;
}

function readStringArray(value: unknown): string[] {
  return Array.isArray(value) ?
    value.filter((item): item is string => typeof item === "string") :
    [];
}

async function fetchRevenueCatAiTutorEntitlement(
  userId: string,
  revenueCatApiKey: string,
): Promise<RevenueCatEvent | null> {
  const encodedUserId = encodeURIComponent(userId);
  const response = await fetch(`${revenueCatSubscriberBaseUrl}/${encodedUserId}`, {
    headers: {
      "Authorization": `Bearer ${revenueCatApiKey}`,
      "Accept": "application/json",
    },
  });

  if (response.status === 404) return null;
  if (!response.ok) {
    throw new HttpError(502, "revenuecat_lookup_failed", "RevenueCat entitlement lookup failed.");
  }

  const body = await response.json() as unknown;
  if (!isRecord(body) || !isRecord(body.subscriber)) return null;

  const subscriber = body.subscriber;
  const entitlement = readEntitlement(subscriber, aiTutorEntitlementId);
  if (entitlement != null) return entitlement;

  return readSubscription(subscriber, aiTutorProductId);
}

function readEntitlement(
  subscriber: Record<string, unknown>,
  entitlementId: string,
): RevenueCatEvent | null {
  const entitlements = subscriber.entitlements;
  if (!isRecord(entitlements)) return null;

  const entitlement = entitlements[entitlementId];
  if (!isRecord(entitlement)) return null;

  return {
    id: "",
    type: "CLIENT_SYNC",
    appUserId: "",
    aliases: [],
    productId: readString(entitlement.product_identifier),
    entitlementIds: [entitlementId],
    expirationAtMs: readDateMs(entitlement.expires_date),
    purchasedAtMs: readDateMs(entitlement.purchase_date),
  };
}

function readSubscription(
  subscriber: Record<string, unknown>,
  productId: string,
): RevenueCatEvent | null {
  const subscriptions = subscriber.subscriptions;
  if (!isRecord(subscriptions)) return null;

  const subscription = subscriptions[productId];
  if (!isRecord(subscription)) return null;

  return {
    id: "",
    type: "CLIENT_SYNC",
    appUserId: "",
    aliases: [],
    productId,
    entitlementIds: [aiTutorEntitlementId],
    expirationAtMs: readDateMs(subscription.expires_date),
    purchasedAtMs: readDateMs(subscription.purchase_date),
  };
}

function readDateMs(value: unknown): number | null {
  if (typeof value !== "string" || value.length === 0) return null;

  const ms = Date.parse(value);
  return Number.isFinite(ms) ? ms : null;
}

interface RevenueCatEvent {
  id: string;
  type: string;
  appUserId: string;
  aliases: string[];
  productId: string | null;
  entitlementIds: string[];
  expirationAtMs: number | null;
  purchasedAtMs: number | null;
}
