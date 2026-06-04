import * as assert from "node:assert/strict";
import {describe, it} from "node:test";

import {
  decodeJsonStringLiteral,
  normalizeDoubleEscapedLatex,
} from "../src/latexSafeJsonString";

describe("decodeJsonStringLiteral latex mode", () => {
  function decodeTextField(raw: string): string | null {
    const key = "\"text\":";
    const valueStart = raw.indexOf(key);
    if (valueStart < 0) return null;
    const quoteStart = raw.indexOf("\"", valueStart + key.length);
    if (quoteStart < 0) return null;
    const decoded = decodeJsonStringLiteral(raw, quoteStart, "latex");
    return decoded?.value ?? null;
  }

  it("preserves \\text and \\theta with single JSON backslashes", () => {
    const raw = String.raw`{"text": "$n + k = n \times (\text{何か})$"}`;
    const value = decodeTextField(raw);
    assert.ok(value != null);
    assert.equal(value, String.raw`$n + k = n \times (\text{何か})$`);
    assert.equal(value.includes("\t"), false);
  });

  it("preserves \\frac and \\to", () => {
    const raw = String.raw`{"text": "$x \to \infty$ and \frac{1}{2}$"}`;
    const value = decodeTextField(raw);
    assert.ok(value != null);
    assert.equal(value, String.raw`$x \to \infty$ and \frac{1}{2}$`);
  });

  it("decodes paragraph newlines but keeps \\nabla", () => {
    const raw = String.raw`{"text": "a\nb\\nabla c"}`;
    const value = decodeTextField(raw);
    assert.ok(value != null);
    assert.equal(value, "a\nb\\nabla c");
  });

  it("handles escaped quotes and backslashes", () => {
    const raw = String.raw`{"text": "say \"hi\" and \\frac{1}{2}"}`;
    const value = decodeTextField(raw);
    assert.ok(value != null);
    assert.equal(value, String.raw`say "hi" and \frac{1}{2}`);
  });
});

describe("normalizeDoubleEscapedLatex", () => {
  it("collapses double-escaped macros", () => {
    assert.equal(
      normalizeDoubleEscapedLatex(String.raw`\\frac{k}{n}`),
      String.raw`\frac{k}{n}`,
    );
  });

  it("leaves single-backslash macros unchanged", () => {
    const ok = String.raw`\theta \to \infty`;
    assert.equal(normalizeDoubleEscapedLatex(ok), ok);
  });
});

describe("decodeJsonStringLiteral standard mode", () => {
  it("decodes JSON control characters", () => {
    const raw = String.raw`{"actionId": "hint\tvalue"}`;
    const keyEnd = raw.indexOf(":") + 1;
    const start = raw.indexOf("\"", keyEnd);
    const decoded = decodeJsonStringLiteral(raw, start, "standard");
    assert.ok(decoded != null);
    assert.equal(decoded.value.includes("\t"), true);
  });
});
