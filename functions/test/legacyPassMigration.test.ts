import * as assert from "node:assert/strict";
import {describe, it} from "node:test";

import {
  attachPassUsage,
  AI_TUTOR_LEGACY_PRODUCT_ID,
  listPassRecords,
  PASS_LIMIT,
  PASS_VALIDITY_MS,
} from "../src/aiTutorPasses";
import {
  legacyMigrationPassId,
  migrateLegacyEntitlementToPassIfNeeded,
} from "../src/legacyPassMigration";
import {UsageIdentity} from "../src/types";
import {createInMemoryFirestore} from "./helpers/inMemoryFirestore";
import {
  readLegacyEntitlementActive,
  readPassUsageCount,
  seedLegacyEntitlement,
  seedLegacyMonthlyUsage,
  seedPass,
} from "./helpers/seedAiTutorUsage";

const userId = "user-legacy-1";
const identity: UsageIdentity = {id: userId, source: "firebase"};
const now = Date.now();
const purchasedAtMs = now - 30 * 24 * 60 * 60 * 1000;
const expiresAtMs = now + 300 * 24 * 60 * 60 * 1000;

describe("legacyPassMigration", () => {
  it("migrates active legacy entitlement to a pass and deactivates entitlement", async () => {
    const db = createInMemoryFirestore();
    await seedLegacyEntitlement(db, userId, {
      active: true,
      purchasedAtMs,
      expiresAtMs,
    });

    const migrated = await migrateLegacyEntitlementToPassIfNeeded(db, userId);
    assert.equal(migrated, true);

    const passes = await listPassRecords(db, userId);
    assert.equal(passes.length, 1);
    assert.equal(passes[0]?.passId, legacyMigrationPassId(userId));
    assert.equal(passes[0]?.limit, PASS_LIMIT);
    assert.equal(passes[0]?.productId, AI_TUTOR_LEGACY_PRODUCT_ID);

    assert.equal(await readLegacyEntitlementActive(db, userId), false);
  });

  it("carries current month legacy usage into pass used count", async () => {
    const db = createInMemoryFirestore();
    await seedLegacyEntitlement(db, userId, {
      active: true,
      purchasedAtMs,
      expiresAtMs,
    });
    await seedLegacyMonthlyUsage(db, identity, 120);

    await migrateLegacyEntitlementToPassIfNeeded(db, userId);

    const passId = legacyMigrationPassId(userId);
    assert.equal(await readPassUsageCount(db, identity, passId), 120);

    const details = await attachPassUsage(db, identity, await listPassRecords(db, userId));
    assert.equal(details[0]?.remaining, 380);
  });

  it("is idempotent when run twice", async () => {
    const db = createInMemoryFirestore();
    await seedLegacyEntitlement(db, userId, {
      active: true,
      purchasedAtMs,
      expiresAtMs,
    });

    assert.equal(await migrateLegacyEntitlementToPassIfNeeded(db, userId), true);
    assert.equal(await migrateLegacyEntitlementToPassIfNeeded(db, userId), false);

    const passes = await listPassRecords(db, userId);
    assert.equal(passes.length, 1);
  });

  it("does not migrate expired legacy entitlement", async () => {
    const db = createInMemoryFirestore();
    await seedLegacyEntitlement(db, userId, {
      active: true,
      purchasedAtMs: now - PASS_VALIDITY_MS * 2,
      expiresAtMs: now - 1000,
    });

    const migrated = await migrateLegacyEntitlementToPassIfNeeded(db, userId);
    assert.equal(migrated, false);
    assert.equal((await listPassRecords(db, userId)).length, 0);
  });

  it("deactivates legacy when migration pass already exists", async () => {
    const db = createInMemoryFirestore();
    const passId = legacyMigrationPassId(userId);
    await seedPass(db, userId, passId, {
      purchasedAtMs,
      expiresAtMs,
      productId: AI_TUTOR_LEGACY_PRODUCT_ID,
    });
    await seedLegacyEntitlement(db, userId, {
      active: true,
      purchasedAtMs,
      expiresAtMs,
    });

    const migrated = await migrateLegacyEntitlementToPassIfNeeded(db, userId);
    assert.equal(migrated, false);
    assert.equal((await listPassRecords(db, userId)).length, 1);
    assert.equal(await readLegacyEntitlementActive(db, userId), false);
  });
});
