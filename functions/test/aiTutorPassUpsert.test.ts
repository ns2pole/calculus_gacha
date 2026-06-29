import * as admin from "firebase-admin";
import * as assert from "node:assert/strict";
import {describe, it} from "node:test";

import {
  AI_TUTOR_PRODUCT_ID,
  hasPassMatchingPurchase,
  listPassRecords,
  PASS_LIMIT,
  PASS_VALIDITY_MS,
  PassPurchaseEvent,
  summarizePassUsage,
  upsertPassFromPurchaseEvent,
  attachPassUsage,
} from "../src/aiTutorPasses";
import {createInMemoryFirestore} from "./helpers/inMemoryFirestore";

const purchasedAtMs = Date.now() - 60_000;
const expiresAtMs = purchasedAtMs + PASS_VALIDITY_MS;

function purchaseEvent(overrides: Partial<PassPurchaseEvent> = {}): PassPurchaseEvent {
  return {
    id: "evt-1",
    type: "NON_SUBSCRIPTION_PURCHASE",
    productId: AI_TUTOR_PRODUCT_ID,
    expirationAtMs: null,
    purchasedAtMs,
    transactionId: "txn-store-1",
    ...overrides,
  };
}

async function seedPass(
  db: FirebaseFirestore.Firestore,
  userId: string,
  passId: string,
  options: {
    purchasedAtMs: number;
    expiresAtMs?: number;
    productId?: string;
  },
): Promise<void> {
  await db
    .collection("users")
    .doc(userId)
    .collection("ai_tutor_passes")
    .doc(passId)
    .set({
      passId,
      purchasedAt: admin.firestore.Timestamp.fromMillis(options.purchasedAtMs),
      expiresAt: admin.firestore.Timestamp.fromMillis(
        options.expiresAtMs ?? options.purchasedAtMs + PASS_VALIDITY_MS,
      ),
      limit: PASS_LIMIT,
      productId: options.productId ?? AI_TUTOR_PRODUCT_ID,
    });
}

describe("upsertPassFromPurchaseEvent duplicate prevention", () => {
  it("creates a pass on first purchase", async () => {
    const db = createInMemoryFirestore();
    const created = await upsertPassFromPurchaseEvent(db, "user-1", purchaseEvent());
    assert.equal(created, true);

    const passes = await listPassRecords(db, "user-1");
    assert.equal(passes.length, 1);
    assert.equal(passes[0]?.passId, "txn-store-1");
    assert.equal(passes[0]?.limit, PASS_LIMIT);
  });

  it("skips duplicate upsert with the same transaction id", async () => {
    const db = createInMemoryFirestore();
    assert.equal(await upsertPassFromPurchaseEvent(db, "user-1", purchaseEvent()), true);
    assert.equal(await upsertPassFromPurchaseEvent(db, "user-1", purchaseEvent()), false);

    const passes = await listPassRecords(db, "user-1");
    assert.equal(passes.length, 1);
  });

  it("skips webhook + sync duplicate when transaction ids differ but purchase time matches", async () => {
    const db = createInMemoryFirestore();
    const webhookEvent = purchaseEvent({
      id: "evt-webhook-uuid",
      type: "NON_SUBSCRIPTION_PURCHASE",
      transactionId: "txn-store-1",
    });
    const syncEvent = purchaseEvent({
      id: "purchase-rc-id",
      type: "CLIENT_SYNC",
      transactionId: "purchase-rc-id",
    });

    assert.equal(await upsertPassFromPurchaseEvent(db, "user-1", webhookEvent), true);
    assert.equal(await upsertPassFromPurchaseEvent(db, "user-1", syncEvent), false);

    const passes = await listPassRecords(db, "user-1");
    assert.equal(passes.length, 1);
    assert.equal(passes[0]?.passId, "txn-store-1");
  });

  it("allows two separate purchases at different times", async () => {
    const db = createInMemoryFirestore();
    const first = purchaseEvent({
      transactionId: "txn-1",
      purchasedAtMs,
    });
    const second = purchaseEvent({
      id: "evt-2",
      transactionId: "txn-2",
      purchasedAtMs: purchasedAtMs + 10_000,
    });

    assert.equal(await upsertPassFromPurchaseEvent(db, "user-1", first), true);
    assert.equal(await upsertPassFromPurchaseEvent(db, "user-1", second), true);

    const passes = await listPassRecords(db, "user-1");
    assert.equal(passes.length, 2);

    const passDetails = await attachPassUsage(db, {source: "firebase", id: "user-1"}, passes);
    const totals = summarizePassUsage(passDetails);
    assert.equal(totals.totalCapacity, PASS_LIMIT * 2);
    assert.equal(totals.totalRemaining, PASS_LIMIT * 2);
  });

  it("detects existing pass via hasPassMatchingPurchase within fingerprint window", async () => {
    const db = createInMemoryFirestore();
    await seedPass(db, "user-1", "existing-pass", {purchasedAtMs});

    const matches = await hasPassMatchingPurchase(db, "user-1", purchaseEvent({
      transactionId: "different-txn",
      purchasedAtMs: purchasedAtMs + 2_000,
    }));
    assert.equal(matches, true);
  });

  it("does not treat purchases more than 5 seconds apart as duplicates", async () => {
    const db = createInMemoryFirestore();
    await seedPass(db, "user-1", "existing-pass", {purchasedAtMs});

    const matches = await hasPassMatchingPurchase(db, "user-1", purchaseEvent({
      transactionId: "different-txn",
      purchasedAtMs: purchasedAtMs + 6_000,
    }));
    assert.equal(matches, false);
  });

  it("stores one year validity from purchase date", async () => {
    const db = createInMemoryFirestore();
    await upsertPassFromPurchaseEvent(db, "user-1", purchaseEvent());

    const passes = await listPassRecords(db, "user-1");
    assert.equal(passes[0]?.purchasedAtMs, purchasedAtMs);
    assert.equal(passes[0]?.expiresAtMs, expiresAtMs);
  });
});
