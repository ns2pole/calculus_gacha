import {starterQuickRepliesSchema} from "./starterQuickRepliesSchema";
import {
  buildEnglishContext,
  buildJapaneseContext,
} from "./prompt";
import {repairTabCorruptedLatex} from "./latexSafeJsonString";
import {parseAiChatGeminiJson} from "./parseAiChatGeminiJson";
import {
  AiChatQuickReply,
  sanitizeQuickReplies,
} from "./quickReplies";
import {AiChatRequest, AiChatStarterRequest} from "./types";
import {HttpError} from "./http";

const model = "gemini-2.5-flash";
const endpoint =
  `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent`;
const maxOutputTokens = 512;
const thinkingBudget = 128;

export async function generateStarterQuickReplies(
  apiKey: string,
  request: AiChatStarterRequest,
): Promise<AiChatQuickReply[]> {
  const systemInstruction = buildStarterSystemInstruction(request);
  const userPrompt = request.locale === "en"
    ? "Generate starter quickReplies for this problem."
    : "この問題の初回クイック返信を生成してください。";

  const rawText = await requestGeminiStarterJson(
    apiKey,
    systemInstruction,
    userPrompt,
  );

  const sanitized = parseStarterResponse(rawText, request);
  if (sanitized.length === 0) {
    throw new HttpError(
      502,
      "empty_starter_quick_replies",
      "初回の選択肢を生成できませんでした。",
    );
  }
  return sanitized;
}

function parseStarterResponse(
  raw: string,
  request: AiChatStarterRequest,
): AiChatQuickReply[] {
  const trimmed = repairTabCorruptedLatex(raw.trim());
  if (trimmed.length === 0) return [];

  const extracted = parseAiChatGeminiJson(trimmed);
  if (extracted == null) return [];

  return sanitizeQuickReplies(extracted.quickReplies, asChatRequest(request));
}

function asChatRequest(request: AiChatStarterRequest): AiChatRequest {
  return {
    context: request.context,
    history: [],
    userMessage: {role: "user", text: ""},
    clientInstallationId: request.clientInstallationId,
    locale: request.locale,
  };
}

function buildStarterSystemInstruction(request: AiChatStarterRequest): string {
  const contextBlock = request.locale === "en"
    ? buildEnglishContext(request.context)
    : buildJapaneseContext(request.context);

  const instructions = request.locale === "en"
    ? buildEnglishStarterSections(request.context.answerShown === true)
    : buildJapaneseStarterSections(request.context.answerShown === true);

  return [
    ...instructions,
    "",
    ...contextBlock,
  ].join("\n");
}

function buildJapaneseStarterSections(answerShown: boolean): string[] {
  return [
    "【役割】",
    "あなたはJoyMathの数学チューターです。高校生がこの問題についてAIチャットを初めて開いたときに押せる、最初の質問候補（quickReplies）だけを生成します。",
    "説明文（text）は出力しません。JSON の quickReplies のみを返してください。",
    "",
    "【件数と内容】",
    "3〜5件。この問題の文脈に合うものだけ選んでください。",
    "例: ヒント・方針・最初の一手・問題文の用語の意味・何から確認すべきか など。",
    "毎回同じ3パターンを機械的に並べる必要はありません。",
    "label はチップ用に短く（目安40字以内）、LaTeX は使わないでください。",
    "sendText は省略可。actionId は hint / approach_only / first_step など任意。",
    ...(answerShown ? [] : [
      "答え表示前のとき、最終答え・全手順・答えだけを求める quickReplies は入れないでください。",
    ]),
    "",
    "【出力形式】",
    "{\"quickReplies\": [{\"label\": \"...\", \"sendText\": \"...\", \"actionId\": \"...\"}]} のみ。",
  ];
}

function buildEnglishStarterSections(answerShown: boolean): string[] {
  return [
    "【Role】",
    "You are a JoyMath math tutor. Generate only the first quickReplies a high school student might tap when opening AI chat for THIS problem.",
    "Do not output an explanation body (text). Return JSON with quickReplies only.",
    "",
    "【Count and content】",
    "3 to 5 items. Pick only what fits this problem.",
    "Examples: hint, strategy, first step, meaning of a term in the problem statement, what to check first, etc.",
    "Do not mechanically repeat the same three templates every time.",
    "label must be short for chips (~40 chars), no LaTeX.",
    "sendText is optional. actionId may be hint / approach_only / first_step, etc.",
    ...(answerShown ? [] : [
      "While the answer has not been shown in the app, do not include quickReplies asking for the final answer or full solution.",
    ]),
    "",
    "【Output format】",
    "JSON only: {\"quickReplies\": [{\"label\": \"...\", \"sendText\": \"...\", \"actionId\": \"...\"}]}.",
  ];
}

async function requestGeminiStarterJson(
  apiKey: string,
  systemInstruction: string,
  userPrompt: string,
): Promise<string> {
  const response = await fetch(`${endpoint}?key=${encodeURIComponent(apiKey)}`, {
    method: "POST",
    headers: {"Content-Type": "application/json"},
    body: JSON.stringify({
      system_instruction: {
        parts: [{text: systemInstruction}],
      },
      contents: [
        {
          role: "user",
          parts: [{text: userPrompt}],
        },
      ],
      generationConfig: {
        temperature: 0.35,
        maxOutputTokens,
        responseMimeType: "application/json",
        responseSchema: starterQuickRepliesSchema,
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
