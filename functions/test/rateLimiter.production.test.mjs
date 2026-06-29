import assert from "node:assert/strict";
import {describe, it} from "node:test";

import {consumeUsage} from "../lib/rateLimiter.js";
import {createInMemoryFirestore} from "../lib/test/helpers/inMemoryFirestore.js";
import {
  readFreeUsageCount,
  readPassUsageCount,
  seedFreeUsage,
  seedPass,
} from "../lib/test/helpers/seedAiTutorUsage.js";

const userId = "user-production-path";
const identity = {id: userId, source: "firebase"};
const now = Date.now();
const oneYearMs = 365 * 24 * 60 * 60 * 1000;

describe("rateLimiter production bundle", () => {
  it("uses remaining free quota before pass after purchase", async () => {
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
    assert.equal(summary.passes?.[0]?.remaining, 500);
    assert.equal(summary.tier, "free");
  });
});
