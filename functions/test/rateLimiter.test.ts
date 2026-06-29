import * as assert from "node:assert/strict";
import {describe, it} from "node:test";

import {PASS_LIMIT} from "../src/aiTutorPasses";
import {legacyMigrationPassId} from "../src/legacyPassMigration";
import {
  consumeUsage,
  getUsageSummary,
  RateLimitExceededError,
} from "../src/rateLimiter";
import {UsageIdentity} from "../src/types";
import {createInMemoryFirestore} from "./helpers/inMemoryFirestore";
import {
  readFreeUsageCount,
  readLegacyEntitlementActive,
  readPassUsageCount,
  seedFreeUsage,
  seedLegacyEntitlement,
  seedLegacyMonthlyUsage,
  seedPass,
} from "./helpers/seedAiTutorUsage";

const userId = "user-test-1";
const identity: UsageIdentity = {id: userId, source: "firebase"};
const now = Date.now();
const oneYearMs = 365 * 24 * 60 * 60 * 1000;

describe("rateLimiter free-first consumption", () => {
  it("getUsageSummary returns free and pass remaining when both exist", async () => {
    const db = createInMemoryFirestore();
    await seedFreeUsage(db, identity, 5);
    await seedPass(db, userId, "pass-a", {
      purchasedAtMs: now,
      expiresAtMs: now + oneYearMs,
    });

    const summary = await getUsageSummary(db, identity);

    assert.equal(summary.free?.remaining, 10);
    assert.equal(summary.free?.limit, 15);
    assert.equal(summary.passes?.length, 1);
    assert.equal(summary.passes?.[0]?.remaining, PASS_LIMIT);
    assert.equal(summary.remaining, 10 + PASS_LIMIT);
    assert.equal(summary.tier, "free");
  });

  it("getUsageSummary returns full free remaining when pass exists but unused", async () => {
    const db = createInMemoryFirestore();
    await seedPass(db, userId, "pass-a", {
      purchasedAtMs: now,
      expiresAtMs: now + oneYearMs,
    });

    const summary = await getUsageSummary(db, identity);

    assert.equal(summary.free?.remaining, 15);
    assert.equal(summary.passes?.[0]?.remaining, PASS_LIMIT);
    assert.equal(summary.remaining, 15 + PASS_LIMIT);
  });

  it("consumeUsage deducts free quota before pass when free remains", async () => {
    const db = createInMemoryFirestore();
    await seedFreeUsage(db, identity, 5);
    await seedPass(db, userId, "pass-a", {
      purchasedAtMs: now,
      expiresAtMs: now + oneYearMs,
    });

    const summary = await consumeUsage(db, identity);

    assert.equal(await readFreeUsageCount(db, identity), 6);
    assert.equal(await readPassUsageCount(db, identity, "pass-a"), 0);
    assert.equal(summary.free?.remaining, 9);
    assert.equal(summary.passes?.[0]?.remaining, PASS_LIMIT);
    assert.equal(summary.remaining, 9 + PASS_LIMIT);
    assert.equal(summary.tier, "free");
  });

  it("consumeUsage deducts pass when free quota is exhausted", async () => {
    const db = createInMemoryFirestore();
    await seedFreeUsage(db, identity, 15);
    await seedPass(db, userId, "pass-a", {
      purchasedAtMs: now,
      expiresAtMs: now + oneYearMs,
    });

    const summary = await consumeUsage(db, identity);

    assert.equal(await readFreeUsageCount(db, identity), 15);
    assert.equal(await readPassUsageCount(db, identity, "pass-a"), 1);
    assert.equal(summary.free?.remaining, 0);
    assert.equal(summary.passes?.[0]?.remaining, PASS_LIMIT - 1);
    assert.equal(summary.tier, "paid");
  });

  it("consumeUsage throws when free and all passes are exhausted", async () => {
    const db = createInMemoryFirestore();
    await seedFreeUsage(db, identity, 15);
    await seedPass(db, userId, "pass-a", {
      purchasedAtMs: now,
      expiresAtMs: now + oneYearMs,
    });
    const passUsageRef = db.collection("ai_chat_usage").doc(
      (await import("../src/aiTutorPasses")).buildPassUsageDocId(identity, "pass-a"),
    );
    await passUsageRef.set({count: PASS_LIMIT});

    await assert.rejects(
      () => consumeUsage(db, identity),
      (error: unknown) => {
        assert.ok(error instanceof RateLimitExceededError);
        assert.equal(error.limit.tier, "paid");
        return true;
      },
    );
  });
});

describe("rateLimiter legacy migration", () => {
  it("migrates legacy entitlement on getUsageSummary and carries monthly usage", async () => {
    const db = createInMemoryFirestore();
    await seedLegacyEntitlement(db, userId, {
      active: true,
      purchasedAtMs: now,
      expiresAtMs: now + oneYearMs,
    });
    await seedLegacyMonthlyUsage(db, identity, 120);

    const summary = await getUsageSummary(db, identity);

    assert.equal(await readLegacyEntitlementActive(db, userId), false);
    assert.equal(summary.free?.remaining, 15);
    assert.equal(summary.passes?.length, 1);
    assert.equal(summary.passes?.[0]?.passId, legacyMigrationPassId(userId));
    assert.equal(summary.passes?.[0]?.remaining, 380);
    assert.equal(summary.remaining, 15 + 380);
  });

  it("consumes from migrated pass after free quota is exhausted", async () => {
    const db = createInMemoryFirestore();
    await seedLegacyEntitlement(db, userId, {
      active: true,
      purchasedAtMs: now,
      expiresAtMs: now + oneYearMs,
    });
    await seedLegacyMonthlyUsage(db, identity, 120);

    for (let i = 0; i < 15; i++) {
      await consumeUsage(db, identity);
    }

    const passId = legacyMigrationPassId(userId);
    assert.equal(await readPassUsageCount(db, identity, passId), 120);

    const summary = await consumeUsage(db, identity);

    assert.equal(await readPassUsageCount(db, identity, passId), 121);
    assert.equal(summary.free?.remaining, 0);
    assert.equal(summary.passes?.[0]?.remaining, 379);
    assert.equal(summary.tier, "paid");
  });
});
