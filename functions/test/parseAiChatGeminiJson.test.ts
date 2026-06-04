import * as assert from "node:assert/strict";
import {describe, it} from "node:test";

import {repairTabCorruptedLatex} from "../src/latexSafeJsonString";
import {parseAiChatGeminiJson} from "../src/parseAiChatGeminiJson";
import {parseAiChatStructuredResponse} from "../src/quickReplies";
import {AiChatRequest} from "../src/types";

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

describe("parseAiChatGeminiJson", () => {
  it("extracts text with LaTeX-safe decode", () => {
    const raw = String.raw`
      {"text": "$x \to \infty$ のとき \\frac{1}{x}$", "quickReplies": []}
    `.trim();
    const extracted = parseAiChatGeminiJson(raw);
    assert.ok(extracted != null);
    assert.equal(extracted.text, String.raw`$x \to \infty$ のとき \frac{1}{x}$`);
    assert.equal(extracted.quickReplies.length, 0);
  });

  it("extracts quickReplies label and sendText with LaTeX", () => {
    const raw = String.raw`
      {
        "text": "説明です",
        "quickReplies": [
          {
            "label": "$\\lim_{\\theta \\to 0}$ の意味",
            "sendText": "$\\lim_{\\theta \\to 0} \\frac{\\sin \\theta}{\\theta}$ の公式の意味を教えて",
            "actionId": "hint"
          }
        ]
      }
    `.trim();
    const extracted = parseAiChatGeminiJson(raw);
    assert.ok(extracted != null);
    assert.equal(extracted.quickReplies.length, 1);
    assert.equal(
      extracted.quickReplies[0].label,
      String.raw`$\lim_{\theta \to 0}$ の意味`,
    );
    assert.equal(
      extracted.quickReplies[0].sendText,
      String.raw`$\lim_{\theta \to 0} \frac{\sin \theta}{\theta}$ の公式の意味を教えて`,
    );
    assert.equal(extracted.quickReplies[0].actionId, "hint");
  });

  it("returns null when text and quickReplies are both empty", () => {
    assert.equal(parseAiChatGeminiJson(String.raw`{"quickReplies": []}`), null);
  });

  it("parses quickReplies-only starter JSON", () => {
    const raw = String.raw`
      {
        "quickReplies": [
          {"label": "ヒントをもらう", "actionId": "hint"}
        ]
      }
    `.trim();
    const extracted = parseAiChatGeminiJson(raw);
    assert.ok(extracted != null);
    assert.equal(extracted.text, "");
    assert.equal(extracted.quickReplies.length, 1);
    assert.equal(extracted.quickReplies[0].actionId, "hint");
  });

  it("parses starter quickReply label with \\text after TAB repair", () => {
    const tab = "\t";
    const raw =
      `{"quickReplies": [{"label": "$f = ${tab}ext{sin}$", "actionId": "hint"}]}`;
    const corrupted = parseAiChatGeminiJson(raw);
    assert.ok(corrupted != null);
    assert.equal(corrupted.quickReplies[0].label.includes("ext{sin}"), true);
    assert.equal(corrupted.quickReplies[0].label.includes("\t"), true);

    const repaired = repairTabCorruptedLatex(raw);
    const extracted = parseAiChatGeminiJson(repaired);
    assert.ok(extracted != null);
    assert.equal(extracted.quickReplies[0].label.includes("\\text{sin}"), true);
    assert.equal(extracted.quickReplies[0].label.includes("\t"), false);
  });
});

describe("parseAiChatStructuredResponse integration", () => {
  it("returns textRaw before normalizeDoubleEscapedLatex", () => {
    const raw = String.raw`{"text": "\\\\frac{1}{x}", "quickReplies": []}`;
    const reply = parseAiChatStructuredResponse(raw, minimalRequest());
    assert.ok(reply.textRaw != null);
    assert.equal(reply.textRaw, String.raw`\\frac{1}{x}`);
    assert.equal(reply.text, String.raw`\frac{1}{x}`);
  });

  it("msg17-style bare \\theta outside dollars stays intact", () => {
    const raw = String.raw`
      {"text": "グラフで、$y = \\sin \\theta$ と、\\theta が $0$ に近づく", "quickReplies": []}
    `.trim();
    const reply = parseAiChatStructuredResponse(raw, minimalRequest());
    assert.equal(reply.text.includes("\\theta"), true);
    assert.equal(reply.text.includes("y = heta"), false);
    assert.equal(reply.text.includes("\t"), false);
  });

  it("msg19-style corruption is avoided without tab repair", () => {
    const raw = String.raw`
      {
        "text": "まず、$y = \\theta$ と $y = \\text{sin } \\theta$、$\\frac{\\text{sin } \\theta}{\\theta}$",
        "quickReplies": []
      }
    `.trim();
    const reply = parseAiChatStructuredResponse(raw, minimalRequest());
    assert.equal(reply.text.includes("\\theta"), true);
    assert.equal(reply.text.includes("\\text{sin }"), true);
    assert.equal(reply.text.includes("y = heta"), false);
    assert.equal(reply.text.includes("y = ext{"), false);
  });

  it("msg5-style \\( \\) delimiters are preserved in text", () => {
    const raw = String.raw`
      {
        "text": "はい！ $x \\to \\infty$ のとき、\\( \\displaystyle \\lim_{\\theta \\to 0} \\frac{\\sin \\theta}{\\theta} = 1 \\) という公式",
        "quickReplies": []
      }
    `.trim();
    const reply = parseAiChatStructuredResponse(raw, minimalRequest());
    assert.equal(reply.text.includes(String.raw`\(`), true);
    assert.equal(reply.text.includes("\\theta"), true);
  });

  it("falls back to plain text for invalid JSON", () => {
    const reply = parseAiChatStructuredResponse("not json at all", minimalRequest());
    assert.equal(reply.text, "not json at all");
    assert.equal(reply.quickReplies.length, 0);
  });
});

describe("parseAiChatStructuredResponse textRaw", () => {
  it("textRaw reflects LaTeX-safe decode not JSON.parse tab corruption", () => {
    const raw = String.raw`{"text": "$n + k = n \times (\text{何か})$", "quickReplies": []}`;
    const reply = parseAiChatStructuredResponse(raw, minimalRequest());
    assert.ok(reply.textRaw != null);
    assert.equal(reply.textRaw.includes("\t"), false);
    assert.equal(reply.textRaw.includes("\\times"), true);
    assert.equal(reply.textRaw.includes("\\text{"), true);
  });
});
