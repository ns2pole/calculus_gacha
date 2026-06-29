import * as assert from "node:assert/strict";
import {describe, it} from "node:test";

import {
  dedupePassPurchaseEvents,
  passDocIdFromEvent,
  PASS_LIMIT,
  selectFifoPass,
  shouldCreatePassFromEvent,
  summarizePassUsage,
} from "../src/aiTutorPasses";
import {PassUsageDetail} from "../src/types";

function passDetail(
  passId: string,
  purchasedAtMs: number,
  used: number,
  expiresAtMs = purchasedAtMs + 365 * 24 * 60 * 60 * 1000,
): PassUsageDetail {
  const remaining = Math.max(0, PASS_LIMIT - used);
  return {
    passId,
    purchasedAtMs,
    expiresAtMs,
    used,
    limit: PASS_LIMIT,
    remaining,
  };
}

describe("aiTutorPasses FIFO helpers", () => {
  it("summarizes stacked passes as 700 remaining when 200 + 500 left", () => {
    const totals = summarizePassUsage([
      passDetail("pass-a", 1, 300),
      passDetail("pass-b", 2, 0),
    ]);
    assert.equal(totals.totalUsed, 300);
    assert.equal(totals.totalCapacity, 1000);
    assert.equal(totals.totalRemaining, 700);
  });

  it("selects oldest pass with remaining capacity first", () => {
    const selected = selectFifoPass([
      passDetail("pass-b", 2, 0),
      passDetail("pass-a", 1, 300),
    ]);
    assert.equal(selected?.passId, "pass-a");
  });

  it("skips exhausted passes", () => {
    const selected = selectFifoPass([
      passDetail("pass-a", 1, PASS_LIMIT),
      passDetail("pass-b", 2, 0),
    ]);
    assert.equal(selected?.passId, "pass-b");
  });

  it("returns null when all passes are exhausted", () => {
    const selected = selectFifoPass([
      passDetail("pass-a", 1, PASS_LIMIT),
      passDetail("pass-b", 2, PASS_LIMIT),
    ]);
    assert.equal(selected, null);
  });

  it("creates pass id from transaction id when available", () => {
    const passId = passDocIdFromEvent({
      id: "evt-1",
      type: "INITIAL_PURCHASE",
      productId: "ai_tutor_one_year_500yen_consumable",
      expirationAtMs: null,
      purchasedAtMs: 1_700_000_000_000,
      transactionId: "txn-abc/123",
    });
    assert.equal(passId, "txn-abc_123");
  });

  it("uses purchase fingerprint when transaction id is missing", () => {
    const purchasedAtMs = 1_700_000_000_000;
    const webhookPassId = passDocIdFromEvent({
      id: "evt-webhook-uuid",
      type: "NON_SUBSCRIPTION_PURCHASE",
      productId: "ai_tutor_one_year_500yen_consumable",
      expirationAtMs: null,
      purchasedAtMs,
      transactionId: null,
    });
    const syncPassId = passDocIdFromEvent({
      id: "purchase-rc-id",
      type: "CLIENT_SYNC",
      productId: "ai_tutor_one_year_500yen_consumable",
      expirationAtMs: null,
      purchasedAtMs,
      transactionId: null,
    });
    assert.equal(
      webhookPassId,
      "purchase-ai_tutor_one_year_500yen_consumable-1700000000000",
    );
    assert.equal(webhookPassId, syncPassId);
  });

  it("dedupes webhook and sync events with the same transaction id", () => {
    const purchasedAtMs = 1_700_000_000_000;
    const deduped = dedupePassPurchaseEvents([
      {
        id: "evt-webhook-uuid",
        type: "NON_SUBSCRIPTION_PURCHASE",
        productId: "ai_tutor_one_year_500yen_consumable",
        expirationAtMs: null,
        purchasedAtMs,
        transactionId: "txn-abc",
      },
      {
        id: "purchase-rc-id",
        type: "CLIENT_SYNC",
        productId: "ai_tutor_one_year_500yen_consumable",
        expirationAtMs: null,
        purchasedAtMs,
        transactionId: "txn-abc",
      },
    ]);
    assert.equal(deduped.length, 1);
    assert.equal(deduped[0]?.transactionId, "txn-abc");
  });

  it("does not create pass from expiration events", () => {
    const shouldCreate = shouldCreatePassFromEvent({
      id: "evt-exp",
      type: "EXPIRATION",
      productId: "ai_tutor_one_year_500yen_consumable",
      expirationAtMs: Date.now() - 1,
      purchasedAtMs: Date.now() - 1000,
      transactionId: "txn-exp",
    });
    assert.equal(shouldCreate, false);
  });

  it("creates pass from initial purchase events", () => {
    const shouldCreate = shouldCreatePassFromEvent({
      id: "evt-buy",
      type: "INITIAL_PURCHASE",
      productId: "ai_tutor_one_year_500yen_consumable",
      expirationAtMs: null,
      purchasedAtMs: Date.now(),
      transactionId: "txn-buy",
    });
    assert.equal(shouldCreate, true);
  });
});
