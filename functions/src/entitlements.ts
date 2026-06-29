import {Request} from "firebase-functions/v2/https";
import {HttpError, readBearerToken} from "./http";
import {
  AI_TUTOR_LEGACY_ENTITLEMENT_ID,
  AI_TUTOR_LEGACY_PRODUCT_ID,
  AI_TUTOR_PRODUCT_ID,
  dedupePassPurchaseEvents,
  isAiTutorEntitlementId,
  isAiTutorProductId,
  listPassRecords,
  PassPurchaseEvent,
  upsertPassFromPurchaseEvent,
} from "./aiTutorPasses";
import {migrateLegacyEntitlementToPassIfNeeded} from "./legacyPassMigration";
import {UsageIdentity} from "./types";

const revenueCatSubscriberBaseUrl = "https://api.revenuecat.com/v1/subscribers";

export async function hasActiveAiTutorPasses(
  db: FirebaseFirestore.Firestore,
  identity: UsageIdentity,
): Promise<boolean> {
  if (identity.source !== "firebase") return false;
  const passes = await listPassRecords(db, identity.id);
  return passes.length > 0;
}

export async function applyRevenueCatWebhook(
  db: FirebaseFirestore.Firestore,
  request: Request,
  authSecret: string,
): Promise<void> {
  assertWebhookAuthorized(request, authSecret);

  const event = parseRevenueCatEvent(request.body);
  if (!isAiTutorEvent(event)) return;

  const userIds = collectRevenueCatUserIds(event);
  const purchaseEvent = toPassPurchaseEvent(event);
  await Promise.all(userIds.map(async (userId) => {
    await upsertPassFromPurchaseEvent(db, userId, purchaseEvent);
  }));
}

export async function syncAiTutorEntitlementFromRevenueCat(
  db: FirebaseFirestore.Firestore,
  userId: string,
  revenueCatApiKey: string,
): Promise<boolean> {
  if (revenueCatApiKey.length === 0) {
    throw new HttpError(500, "revenuecat_api_key_missing", "RevenueCat API key is not configured.");
  }

  const purchaseEvents = await fetchRevenueCatPassPurchases(userId, revenueCatApiKey);
  await Promise.all(purchaseEvents.map((event) =>
    upsertPassFromPurchaseEvent(db, userId, event),
  ));

  await migrateLegacyEntitlementToPassIfNeeded(db, userId);

  const passes = await listPassRecords(db, userId);
  return passes.length > 0;
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
    transactionId: readString(event.transaction_id) ??
      readString(event.original_transaction_id),
  };
}

function toPassPurchaseEvent(event: RevenueCatEvent): PassPurchaseEvent {
  return {
    id: event.id,
    type: event.type,
    productId: event.productId,
    expirationAtMs: event.expirationAtMs,
    purchasedAtMs: event.purchasedAtMs,
    transactionId: event.transactionId,
  };
}

function isAiTutorEvent(event: RevenueCatEvent): boolean {
  return isAiTutorProductId(event.productId) ||
    event.entitlementIds.some(isAiTutorEntitlementId);
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
  return typeof value === "object" && value != null;
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

async function fetchRevenueCatPassPurchases(
  userId: string,
  revenueCatApiKey: string,
): Promise<PassPurchaseEvent[]> {
  const subscriber = await fetchRevenueCatSubscriber(userId, revenueCatApiKey);
  if (subscriber == null) return [];

  return collectPassPurchaseEventsFromSubscriber(subscriber);
}

export function collectPassPurchaseEventsFromSubscriber(
  subscriber: Record<string, unknown>,
): PassPurchaseEvent[] {
  const events: PassPurchaseEvent[] = [
    ...readNonSubscriptionPurchases(subscriber, AI_TUTOR_PRODUCT_ID),
    ...readNonSubscriptionPurchases(subscriber, AI_TUTOR_LEGACY_PRODUCT_ID),
  ];

  const legacyEntitlement = readEntitlement(subscriber, AI_TUTOR_LEGACY_ENTITLEMENT_ID);
  if (legacyEntitlement != null) {
    events.push(toPassPurchaseEvent(legacyEntitlement));
  }

  const legacySubscription = readSubscription(subscriber, AI_TUTOR_LEGACY_PRODUCT_ID);
  if (legacySubscription != null) {
    events.push(toPassPurchaseEvent(legacySubscription));
  }

  return dedupePassPurchaseEvents(events);
}

async function fetchRevenueCatSubscriber(
  userId: string,
  revenueCatApiKey: string,
): Promise<Record<string, unknown> | null> {
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
  return body.subscriber;
}

function readNonSubscriptionPurchases(
  subscriber: Record<string, unknown>,
  productId: string,
): PassPurchaseEvent[] {
  const nonSubscriptions = subscriber.non_subscriptions;
  if (!isRecord(nonSubscriptions)) return [];

  const purchases = nonSubscriptions[productId];
  if (!Array.isArray(purchases)) return [];

  return purchases
    .filter(isRecord)
    .map((purchase): PassPurchaseEvent => ({
      id: readString(purchase.id) ?? "",
      type: "CLIENT_SYNC",
      productId,
      expirationAtMs: null,
      purchasedAtMs: readDateMs(purchase.purchase_date),
      transactionId: readString(purchase.store_transaction_id) ??
        readString(purchase.id),
    }))
    .filter((event) => event.purchasedAtMs != null);
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
    transactionId: readString(entitlement.store_transaction_id) ??
      readString(entitlement.original_transaction_id),
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
    entitlementIds: [AI_TUTOR_LEGACY_ENTITLEMENT_ID],
    expirationAtMs: readDateMs(subscription.expires_date),
    purchasedAtMs: readDateMs(subscription.purchase_date),
    transactionId: readString(subscription.store_transaction_id) ??
      readString(subscription.original_transaction_id),
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
  transactionId: string | null;
}
