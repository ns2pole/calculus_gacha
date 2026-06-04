import * as assert from "node:assert/strict";
import {describe, it} from "node:test";

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

describe("\\text to ext corruption probes", () => {
  it("latex decoder preserves \\text when backslash-t are two chars in JSON source", () => {
    const raw = String.raw`{"text": "$f_p(t) = \text{sin}(3t)$", "quickReplies": []}`;
    const reply = parseAiChatStructuredResponse(raw, minimalRequest());
    assert.equal(reply.text.includes("\t"), false);
    assert.equal(reply.text.includes("\\text{sin}"), true);
    assert.equal(reply.textRaw?.includes("\\text{sin}"), true);
  });

  it("JSON.parse turns JSON \\t in \\text into TAB (simulates Gemini HTTP pre-parse)", () => {
    const modelJson = "{\"text\": \"$f_p(t) = \\text{sin}(3t)$\"}";
    const parsed = JSON.parse(modelJson) as {text: string};
    assert.equal(parsed.text.includes("\t"), true);
    assert.equal(parsed.text.includes("ext{sin}"), true);
    assert.equal(parsed.text.includes("\\text"), false);
  });

  it("repair restores TAB-corrupted \\text in structured JSON", () => {
    const tab = "\t";
    const corruptedWrapper =
      `{"text": "$f_p(t) = ${tab}ext{sin}(3t) - ${tab}ext{cos}(3t)$", "quickReplies": []}`;
    const reply = parseAiChatStructuredResponse(corruptedWrapper, minimalRequest());
    assert.equal(reply.text.includes("\\text{sin}"), true);
    assert.equal(reply.text.includes("\\text{cos}"), true);
    assert.equal(reply.text.includes("\t"), false);
    assert.equal(reply.text.includes(`${tab}ext`), false);
    assert.equal(reply.textRaw?.includes("\\text{sin}"), true);
  });

  it("repair restores TAB-corrupted plain fallback text", () => {
    const tab = "\t";
    const textOnly = `$f_p(t) = ${tab}ext{sin}(3t)$`;
    assert.equal(parseAiChatGeminiJson(textOnly), null);
    const fallback = parseAiChatStructuredResponse(textOnly, minimalRequest());
    assert.equal(fallback.text.includes("\\text{sin}"), true);
    assert.equal(fallback.text.includes("\t"), false);
    assert.equal(fallback.textRaw?.includes("\\text{sin}"), true);
  });

  it("doubled backslash \\\\text in JSON source (prompt-correct) survives", () => {
    const raw = String.raw`{"text": "$f_p(t) = \\text{sin}(3t)$", "quickReplies": []}`;
    const reply = parseAiChatStructuredResponse(raw, minimalRequest());
    assert.equal(reply.text.includes("\\text{sin}"), true);
    assert.equal(reply.textRaw?.includes("\\text{sin}"), true);
    assert.equal(reply.text.includes("\t"), false);
  });

  it("repair + latex decode preserves \\nabla and real newlines in same field", () => {
    const tab = "\t";
    const raw = `{"text": "段落1。\\n\\n段落2。$\\\\nabla f$ と ${tab}ext{注}", "quickReplies": []}`;
    const reply = parseAiChatStructuredResponse(raw, minimalRequest());
    assert.equal(reply.text.includes("\n\n"), true);
    assert.equal(reply.text.includes("\\nabla"), true);
    assert.equal(reply.text.includes("\\text{注}"), true);
    assert.equal(reply.text.includes("\t"), false);
  });

  it("does not corrupt \\textbf when only \\text was TAB-damaged in mix", () => {
    const tab = "\t";
    const raw = String.raw`{"text": "${tab}ext{内} と \\textbf{外}", "quickReplies": []}`;
    const reply = parseAiChatStructuredResponse(raw, minimalRequest());
    assert.equal(reply.text.includes("\\text{内}"), true);
    assert.equal(reply.text.includes("\\textbf{外}"), true);
    assert.equal(reply.text.includes("\t"), false);
  });
});
