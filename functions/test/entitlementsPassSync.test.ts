import * as assert from "node:assert/strict";
import {describe, it} from "node:test";

import {AI_TUTOR_ENTITLEMENT_ID, AI_TUTOR_LEGACY_ENTITLEMENT_ID, AI_TUTOR_LEGACY_PRODUCT_ID, AI_TUTOR_PRODUCT_ID} from "../src/aiTutorPasses";
import {collectPassPurchaseEventsFromSubscriber} from "../src/entitlements";

const purchasedAtIso = "2023-11-14T22:13:20Z";
const purchasedAtMs = Date.parse(purchasedAtIso);
const expiresAtIso = "2024-11-14T22:13:20Z";

function subscriberWithSinglePurchase(
  overrides: Record<string, unknown> = {},
): Record<string, unknown> {
  return {
    non_subscriptions: {
      [AI_TUTOR_PRODUCT_ID]: [
        {
          id: "purchase-rc-id",
          purchase_date: purchasedAtIso,
          store_transaction_id: "GPA.1234-5678",
        },
      ],
    },
    entitlements: {
      [AI_TUTOR_ENTITLEMENT_ID]: {
        product_identifier: AI_TUTOR_PRODUCT_ID,
        purchase_date: purchasedAtIso,
        expires_date: expiresAtIso,
        store_transaction_id: "GPA.1234-5678",
      },
    },
    ...overrides,
  };
}

describe("collectPassPurchaseEventsFromSubscriber", () => {
  it("reads consumable purchases from non_subscriptions only", () => {
    const events = collectPassPurchaseEventsFromSubscriber(
      subscriberWithSinglePurchase(),
    );

    assert.equal(events.length, 1);
    assert.equal(events[0]?.productId, AI_TUTOR_PRODUCT_ID);
    assert.equal(events[0]?.purchasedAtMs, purchasedAtMs);
    assert.equal(events[0]?.transactionId, "GPA.1234-5678");
    assert.equal(events[0]?.type, "CLIENT_SYNC");
  });

  it("does not double-count entitlement mirror for the same consumable purchase", () => {
    const events = collectPassPurchaseEventsFromSubscriber(
      subscriberWithSinglePurchase({
        entitlements: {
          [AI_TUTOR_ENTITLEMENT_ID]: {
            product_identifier: AI_TUTOR_PRODUCT_ID,
            purchase_date: purchasedAtIso,
            expires_date: expiresAtIso,
            original_transaction_id: "legacy-txn-id",
          },
        },
      }),
    );

    assert.equal(events.length, 1);
    assert.equal(events[0]?.transactionId, "GPA.1234-5678");
  });

  it("returns one event per distinct non_subscription purchase", () => {
    const events = collectPassPurchaseEventsFromSubscriber({
      non_subscriptions: {
        [AI_TUTOR_PRODUCT_ID]: [
          {
            id: "purchase-1",
            purchase_date: "2023-11-14T22:13:20Z",
            store_transaction_id: "GPA.1111",
          },
          {
            id: "purchase-2",
            purchase_date: "2024-01-10T12:00:00Z",
            store_transaction_id: "GPA.2222",
          },
        ],
      },
    });

    assert.equal(events.length, 2);
    assert.deepEqual(
      events.map((event) => event.transactionId).sort(),
      ["GPA.1111", "GPA.2222"],
    );
  });

  it("dedupes duplicate non_subscription rows with the same transaction id", () => {
    const events = collectPassPurchaseEventsFromSubscriber({
      non_subscriptions: {
        [AI_TUTOR_PRODUCT_ID]: [
          {
            id: "purchase-a",
            purchase_date: purchasedAtIso,
            store_transaction_id: "GPA.1234-5678",
          },
          {
            id: "purchase-b",
            purchase_date: purchasedAtIso,
            store_transaction_id: "GPA.1234-5678",
          },
        ],
      },
    });

    assert.equal(events.length, 1);
  });

  it("returns empty list when non_subscriptions is missing", () => {
    const events = collectPassPurchaseEventsFromSubscriber({
      entitlements: {
        [AI_TUTOR_ENTITLEMENT_ID]: {
          product_identifier: AI_TUTOR_PRODUCT_ID,
          purchase_date: purchasedAtIso,
          expires_date: expiresAtIso,
          store_transaction_id: "GPA.1234-5678",
        },
      },
    });

    assert.deepEqual(events, []);
  });

  it("includes legacy subscription from subscriptions", () => {
    const events = collectPassPurchaseEventsFromSubscriber({
      subscriptions: {
        [AI_TUTOR_LEGACY_PRODUCT_ID]: {
          purchase_date: purchasedAtIso,
          expires_date: expiresAtIso,
          store_transaction_id: "GPA.legacy-sub",
        },
      },
    });

    assert.equal(events.length, 1);
    assert.equal(events[0]?.productId, AI_TUTOR_LEGACY_PRODUCT_ID);
    assert.equal(events[0]?.purchasedAtMs, purchasedAtMs);
    assert.equal(events[0]?.transactionId, "GPA.legacy-sub");
  });

  it("includes legacy entitlement from entitlements", () => {
    const events = collectPassPurchaseEventsFromSubscriber({
      entitlements: {
        [AI_TUTOR_LEGACY_ENTITLEMENT_ID]: {
          product_identifier: AI_TUTOR_LEGACY_PRODUCT_ID,
          purchase_date: purchasedAtIso,
          expires_date: expiresAtIso,
          store_transaction_id: "GPA.legacy-ent",
        },
      },
    });

    assert.equal(events.length, 1);
    assert.equal(events[0]?.productId, AI_TUTOR_LEGACY_PRODUCT_ID);
    assert.equal(events[0]?.transactionId, "GPA.legacy-ent");
  });

  it("dedupes legacy subscription and entitlement mirror", () => {
    const events = collectPassPurchaseEventsFromSubscriber({
      subscriptions: {
        [AI_TUTOR_LEGACY_PRODUCT_ID]: {
          purchase_date: purchasedAtIso,
          expires_date: expiresAtIso,
          store_transaction_id: "GPA.legacy-same",
        },
      },
      entitlements: {
        [AI_TUTOR_LEGACY_ENTITLEMENT_ID]: {
          product_identifier: AI_TUTOR_LEGACY_PRODUCT_ID,
          purchase_date: purchasedAtIso,
          expires_date: expiresAtIso,
          store_transaction_id: "GPA.legacy-same",
        },
      },
    });

    assert.equal(events.length, 1);
  });
});
