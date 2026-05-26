import {
  buildGeminiContents,
  buildSystemInstruction,
  GeminiContent,
  isBriefGuidanceRequest,
  retryBrokenLatexMessage,
  retryTooLongMessage,
} from "./prompt";
import {AiChatRequest} from "./types";
import {HttpError} from "./http";

const model = "gemini-2.5-flash";
const endpoint =
  `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent`;
const defaultMaxOutputTokens = 1024;
const briefGuidanceMaxOutputTokens = 512;
const thinkingBudget = 256;

export async function generateAiChatReply(
  apiKey: string,
  request: AiChatRequest,
): Promise<string> {
  const systemInstruction = buildSystemInstruction(request);
  const contents = buildGeminiContents(request);
  const maxOutputTokens = resolveMaxOutputTokens(request);
  let result = await requestGeminiText(apiKey, systemInstruction, contents, maxOutputTokens);
  if (result.finishReason === "MAX_TOKENS") {
    result = await requestGeminiText(
      apiKey,
      systemInstruction,
      [
        ...contents,
        {
          role: "model",
          parts: [{text: result.text}],
        },
        {
          role: "user",
          parts: [{text: retryTooLongMessage(request.locale)}],
        },
      ],
      briefGuidanceMaxOutputTokens,
    );
  }

  const text = result.text;

  if (!hasSuspiciousLatex(text)) {
    return text;
  }

  return (await requestGeminiText(
    apiKey,
    systemInstruction,
    [
      ...contents,
      {
        role: "model",
        parts: [{text}],
      },
      {
        role: "user",
        parts: [{text: retryBrokenLatexMessage(request.locale)}],
      },
    ],
    maxOutputTokens,
  )).text;
}

async function requestGeminiText(
  apiKey: string,
  systemInstruction: string,
  contents: GeminiContent[],
  maxOutputTokens: number,
): Promise<GeminiTextResult> {
  const response = await fetch(`${endpoint}?key=${encodeURIComponent(apiKey)}`, {
    method: "POST",
    headers: {"Content-Type": "application/json"},
    body: JSON.stringify({
      system_instruction: {
        parts: [{text: systemInstruction}],
      },
      contents,
      generationConfig: {
        temperature: 0.25,
        maxOutputTokens,
        thinkingConfig: {
          thinkingBudget,
        },
      },
    }),
  });

  const body = await response.json().catch(() => null) as GeminiResponse | null;
  if (!response.ok) {
    const message = body?.error?.message ?? "Gemini APIの呼び出しに失敗しました。";
    throw new HttpError(response.status, "gemini_error", message);
  }

  const candidate = body?.candidates?.[0];
  const text = candidate?.content?.parts
    ?.map((part) => part.text ?? "")
    .join("")
    .trim();
  if (text == null || text.length === 0) {
    throw new HttpError(502, "empty_gemini_response", "AIから空の応答が返されました。");
  }
  return {
    text,
    finishReason: candidate?.finishReason,
  };
}

function resolveMaxOutputTokens(request: AiChatRequest): number {
  return isBriefGuidanceRequest(request.userMessage.text) ?
    briefGuidanceMaxOutputTokens :
    defaultMaxOutputTokens;
}

function hasSuspiciousLatex(text: string): boolean {
  const dollarCounts = countMathDelimiters(text);
  if (dollarCounts.single % 2 !== 0 || dollarCounts.double % 2 !== 0) {
    return true;
  }

  let braceDepth = 0;
  for (const char of text) {
    if (char === "{") braceDepth++;
    if (char === "}") braceDepth--;
    if (braceDepth < 0) return true;
  }
  if (braceDepth !== 0) return true;

  const leftCount = text.match(/\\left\b/g)?.length ?? 0;
  const rightCount = text.match(/\\right\b/g)?.length ?? 0;
  return leftCount !== rightCount;
}

function countMathDelimiters(text: string): {single: number; double: number} {
  let single = 0;
  let double = 0;

  for (let i = 0; i < text.length; i++) {
    if (text[i] !== "$" || isEscaped(text, i)) continue;

    if (text[i + 1] === "$") {
      double++;
      i++;
    } else {
      single++;
    }
  }

  return {single, double};
}

function isEscaped(text: string, index: number): boolean {
  let slashCount = 0;
  for (let i = index - 1; i >= 0 && text[i] === "\\"; i--) {
    slashCount++;
  }
  return slashCount % 2 === 1;
}

interface GeminiResponse {
  candidates?: Array<{
    finishReason?: string;
    content?: {
      parts?: Array<{
        text?: string;
      }>;
    };
  }>;
  error?: {
    message?: string;
  };
}

interface GeminiTextResult {
  text: string;
  finishReason?: string;
}
