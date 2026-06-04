import * as assert from "node:assert/strict";
import {describe, it} from "node:test";

import {
  repairTabCorruptedLatex,
} from "../src/latexSafeJsonString";
import {parseAiChatStructuredResponse} from "../src/quickReplies";
import {AiChatRequest} from "../src/types";

const tab = "\t";

/** TAB + suffix → `\` + `t` + suffix (same contract as Dart). */
const repairCases: ReadonlyArray<{
  suffix: string;
  corrupted: string;
  expected: string;
}> = [
  {suffix: "ext", corrupted: `x^2 + ${tab}ext{日本語}`, expected: String.raw`x^2 + \text{日本語}`},
  {suffix: "extbf", corrupted: `${tab}extbf{太字}`, expected: String.raw`\textbf{太字}`},
  {suffix: "extit", corrupted: `${tab}extit{斜体}`, expected: String.raw`\textit{斜体}`},
  {suffix: "extnormal", corrupted: `${tab}extnormal{x}`, expected: String.raw`\textnormal{x}`},
  {suffix: "extrm", corrupted: `${tab}extrm{x}`, expected: String.raw`\textrm{x}`},
  {suffix: "imes", corrupted: `a ${tab}imes b`, expected: String.raw`a \times b`},
  {suffix: "heta", corrupted: `${tab}heta`, expected: String.raw`\theta`},
  {suffix: "riangle", corrupted: `${tab}riangle ABC`, expected: String.raw`\triangle ABC`},
  {suffix: "frac", corrupted: `${tab}frac{1}{2}`, expected: String.raw`\tfrac{1}{2}`},
  {suffix: "ilde", corrupted: `${tab}ilde{x}`, expected: String.raw`\tilde{x}`},
  {suffix: "au", corrupted: `${tab}au`, expected: String.raw`\tau`},
  {suffix: "an", corrupted: `${tab}an x`, expected: String.raw`\tan x`},
  {suffix: "o", corrupted: `${tab}o \\infty`, expected: String.raw`\to \infty`},
];

function minimalRequest(): AiChatRequest {
  return {
    locale: "ja",
    userMessage: {role: "user", text: "test"},
    history: [],
    context: {
      title: "問題1",
      questionText: "q",
      category: "c",
      level: "l",
      hintShown: false,
      answerShown: false,
    },
    clientInstallationId: "install-test",
  };
}

describe("repairTabCorruptedLatex", () => {
  for (const {suffix, corrupted, expected} of repairCases) {
    it(`restores TAB+${suffix} to backslash-t+${suffix}`, () => {
      assert.equal(repairTabCorruptedLatex(corrupted), expected);
      assert.equal(repairTabCorruptedLatex(expected), expected);
    });
  }

  it("is idempotent on already-correct LaTeX", () => {
    const ok = String.raw`$y = \text{sin } \theta$ and \frac{\text{a}}{\theta}`;
    assert.equal(repairTabCorruptedLatex(ok), ok);
    assert.equal(repairTabCorruptedLatex(repairTabCorruptedLatex(ok)), ok);
  });

  it("returns input unchanged when no TAB", () => {
    const plain = "区分求積法のポイントです";
    assert.equal(repairTabCorruptedLatex(plain), plain);
  });

  it("leaves TAB not followed by a TeX suffix", () => {
    const input = `列1${tab}列2${tab}データ`;
    assert.equal(repairTabCorruptedLatex(input), input);
  });

  it("repairs multiple TAB-corrupted macros in one string", () => {
    const corrupted =
      `$f_p(t) = ${tab}ext{sin}(3t) - ${tab}ext{cos}(3t) + ${tab}heta$`;
    const repaired = repairTabCorruptedLatex(corrupted);
    assert.equal(repaired.includes("\\text{sin}"), true);
    assert.equal(repaired.includes("\\text{cos}"), true);
    assert.equal(repaired.includes("\\theta"), true);
    assert.equal(repaired.includes(tab), false);
    assert.equal(repaired.includes(`${tab}ext`), false);
  });

  it("does not treat TAB+ext inside already-correct \\text as double-repair", () => {
    const ok = String.raw`\text{sin}`;
    assert.equal(repairTabCorruptedLatex(ok), ok);
  });
});

describe("repairTabCorruptedLatex + parseAiChatStructuredResponse", () => {
  it("simulates Gemini HTTP: JSON.parse on model text then repair+parse", () => {
    const modelJson = "{\"text\": \"$f_p(t) = \\text{sin}(3t)$\"}";
    const corruptedText = (JSON.parse(modelJson) as {text: string}).text;
    assert.equal(corruptedText.includes(tab), true);

    const wrapper =
      `{"text": ${JSON.stringify(corruptedText)}, "quickReplies": []}`;
    const reply = parseAiChatStructuredResponse(wrapper, minimalRequest());
    assert.equal(reply.text, "$f_p(t) = \\text{sin}(3t)$");
    assert.equal(reply.textRaw, "$f_p(t) = \\text{sin}(3t)$");
    assert.equal(reply.text.includes(tab), false);
  });

  it("preserves \\times when JSON source has two-char backslash-t", () => {
    const raw = String.raw`{"text": "$a \times b$", "quickReplies": []}`;
    const reply = parseAiChatStructuredResponse(raw, minimalRequest());
    assert.equal(reply.text.includes("\\times"), true);
    assert.equal(reply.text.includes(tab), false);
  });

  it("repairs TAB-corrupted \\times in JSON wrapper", () => {
    const corrupted = `$a ${tab}imes b$`;
    const wrapper = `{"text": ${JSON.stringify(corrupted)}, "quickReplies": []}`;
    const reply = parseAiChatStructuredResponse(wrapper, minimalRequest());
    assert.equal(reply.text.includes("\\times"), true);
    assert.equal(reply.text.includes(tab), false);
  });

  it("quickReplies-only JSON after repair yields labels with \\text", () => {
    const tabLabel = `$f = ${tab}ext{sin}$`;
    const raw =
      `{"quickReplies": [{"label": ${JSON.stringify(tabLabel)}, "actionId": "hint"}]}`;
    const reply = parseAiChatStructuredResponse(raw, minimalRequest());
    assert.equal(reply.text, "");
    assert.equal(reply.quickReplies.length, 1);
    assert.equal(reply.quickReplies[0].label, "$f = \\text{sin}$");
    assert.equal(reply.quickReplies[0].label.includes(tab), false);
  });

  it("msg19 assistant JSON keeps \\text{sin } and \\frac{\\text{...}}", () => {
    const raw = String.raw`
      {
        "text": "まず、$y = \\theta$ と $y = \\text{sin } \\theta$、$\\frac{\\text{sin } \\theta}{\\theta}$",
        "quickReplies": []
      }
    `.trim();
    const reply = parseAiChatStructuredResponse(raw, minimalRequest());
    assert.equal(reply.text.includes("\\text{sin }"), true);
    assert.equal(reply.text.includes("\\frac{\\text{sin }"), true);
    assert.equal(reply.text.includes(tab), false);
    assert.equal(reply.text.includes(`${tab}ext`), false);
  });

  it("RLC-style equation with \\text and no dollars survives parse", () => {
    const raw = String.raw`
      {
        "text": "\\alpha f'(t)+\\gamma f(t)=F\\sin(\\omega t) \\ \\ \\text{の定常状態の }f'(t)",
        "quickReplies": []
      }
    `.trim();
    const reply = parseAiChatStructuredResponse(raw, minimalRequest());
    assert.equal(reply.text.includes("\\text{の定常状態の }"), true);
    assert.equal(reply.text.includes(tab), false);
  });

  it("invalid JSON still repair-corrupted plain fallback", () => {
    const corrupted = `式: ${tab}ext{注}`;
    const reply = parseAiChatStructuredResponse(corrupted, minimalRequest());
    assert.equal(reply.text, `式: \\text{注}`);
    assert.equal(reply.quickReplies.length, 0);
  });
});
