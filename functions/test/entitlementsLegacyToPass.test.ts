import * as assert from "node:assert/strict";
import {describe, it} from "node:test";
import {Request} from "firebase-functions/v2/https";

import {
  AI_TUTOR_LEGACY_ENTITLEMENT_ID,
  AI_TUTOR_LEGACY_PRODUCT_ID,
  legacyEntitlementRef,
  listPassRecords,
  PASS_VALIDITY_MS,
} from "../src/aiTutorPasses";
import {applyRevenueCatWebhook} from "../src/entitlements";
import {createInMemoryFirestore} from "./helpers/inMemoryFirestore";

const authSecret = "test-webhook-secret";
const userId = "user-webhook-legacy";
const purchasedAtMs = Date.now() - 60_000;
const expiresAtMs = purchasedAtMs + PASS_VALIDITY_MS;

function mockWebhookRequest(body: unknown): Request {
  return {
    header: (name: string) => name === "authorization" ? authSecret : undefined,
    body,
  } as unknown as Request;
}

describe("applyRevenueCatWebhook legacy to pass", () => {
  it("creates pass doc only for legacy INITIAL_PURCHASE webhook", async () => {
    const db = createInMemoryFirestore();
    await applyRevenueCatWebhook(db, mockWebhookRequest({
      event: {
        id: "evt-legacy-1",
        type: "INITIAL_PURCHASE",
        app_user_id: userId,
        product_id: AI_TUTOR_LEGACY_PRODUCT_ID,
        entitlement_ids: [AI_TUTOR_LEGACY_ENTITLEMENT_ID],
        purchased_at_ms: purchasedAtMs,
        expiration_at_ms: expiresAtMs,
        transaction_id: "txn-legacy-1",
      },
    }), authSecret);

    const passes = await listPassRecords(db, userId);
    assert.equal(passes.length, 1);
    assert.equal(passes[0]?.productId, AI_TUTOR_LEGACY_PRODUCT_ID);
    assert.equal(passes[0]?.passId, "txn-legacy-1");

    const entitlement = await legacyEntitlementRef(db, userId).get();
    assert.equal(entitlement.exists, false);
  });
});
