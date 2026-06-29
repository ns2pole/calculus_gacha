import * as assert from "node:assert/strict";
import {describe, it} from "node:test";

import {
  AI_TUTOR_LEGACY_ENTITLEMENT_ID,
  AI_TUTOR_LEGACY_PRODUCT_ID,
  AI_TUTOR_PRODUCT_ID,
  isLegacyAiTutorEntitlementEvent,
  isLegacyAiTutorProductId,
  isLegacyEntitlementActive,
} from "../src/aiTutorPasses";

describe("legacyAiTutorEntitlement", () => {
  it("detects legacy product id", () => {
    assert.equal(isLegacyAiTutorProductId(AI_TUTOR_LEGACY_PRODUCT_ID), true);
    assert.equal(isLegacyAiTutorProductId(AI_TUTOR_PRODUCT_ID), false);
    assert.equal(isLegacyAiTutorProductId(null), false);
  });

  it("detects legacy webhook events by product or entitlement", () => {
    assert.equal(isLegacyAiTutorEntitlementEvent({
      productId: AI_TUTOR_LEGACY_PRODUCT_ID,
      entitlementIds: [],
    }), true);
    assert.equal(isLegacyAiTutorEntitlementEvent({
      productId: AI_TUTOR_PRODUCT_ID,
      entitlementIds: [AI_TUTOR_LEGACY_ENTITLEMENT_ID],
    }), true);
    assert.equal(isLegacyAiTutorEntitlementEvent({
      productId: AI_TUTOR_PRODUCT_ID,
      entitlementIds: [],
    }), false);
  });

  it("treats active legacy entitlement as active before expiration", () => {
    const future = Date.now() + 60_000;
    assert.equal(isLegacyEntitlementActive({
      type: "NON_RENEWING_PURCHASE",
      expirationAtMs: future,
    }), true);
  });

  it("marks expiration events inactive", () => {
    const future = Date.now() + 60_000;
    assert.equal(isLegacyEntitlementActive({
      type: "EXPIRATION",
      expirationAtMs: future,
    }), false);
  });
});
