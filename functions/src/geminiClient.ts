import {buildGeminiContents, buildSystemInstruction} from "./prompt";
import {AiChatRequest} from "./types";
import {HttpError} from "./http";

const model = "gemini-2.5-flash";
const endpoint =
  `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent`;

export async function generateAiChatReply(
  apiKey: string,
  request: AiChatRequest,
): Promise<string> {
  const response = await fetch(`${endpoint}?key=${encodeURIComponent(apiKey)}`, {
    method: "POST",
    headers: {"Content-Type": "application/json"},
    body: JSON.stringify({
      system_instruction: {
        parts: [{text: buildSystemInstruction(request)}],
      },
      contents: buildGeminiContents(request),
      generationConfig: {
        temperature: 0.25,
        maxOutputTokens: 700,
        thinkingConfig: {
          thinkingBudget: 1024,
        },
      },
    }),
  });

  const body = await response.json().catch(() => null) as GeminiResponse | null;
  if (!response.ok) {
    const message = body?.error?.message ?? "Gemini APIの呼び出しに失敗しました。";
    throw new HttpError(response.status, "gemini_error", message);
  }

  const text = body?.candidates?.[0]?.content?.parts
    ?.map((part) => part.text ?? "")
    .join("")
    .trim();
  if (text == null || text.length === 0) {
    throw new HttpError(502, "empty_gemini_response", "AIから空の応答が返されました。");
  }
  return text;
}

interface GeminiResponse {
  candidates?: Array<{
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
