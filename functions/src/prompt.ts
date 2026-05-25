import {AiChatRequest} from "./types";

export function buildSystemInstruction(request: AiChatRequest): string {
  const context = request.context;
  return [
    "あなたはJoyMathの数学チューターです。",
    "生徒が自力で解けるように、答えを急がず、短く論理的な次の一歩を示してください。",
    "日本語で回答してください。",
    "数式はLaTeXで書いてください。",
    "回答は長くしすぎず、必ず文と段落を完結させてください。",
    "ユーザーが答えを直接求めていない場合、最終答えをいきなり出さないでください。",
    "誤った式変形を避け、条件・定義域・極限操作・積分区間を丁寧に確認してください。",
    "",
    "問題情報:",
    `タイトル: ${context.title}`,
    `カテゴリ: ${context.category ?? "未設定"}`,
    `レベル: ${context.level ?? "未設定"}`,
    `問題: ${context.questionText}`,
    `ヒント表示済み: ${context.hintShown === true ? "はい" : "いいえ"}`,
    `答え表示済み: ${context.answerShown === true ? "はい" : "いいえ"}`,
  ].join("\n");
}

export function buildGeminiContents(request: AiChatRequest): GeminiContent[] {
  const history: GeminiContent[] = request.history.slice(-12).map((message) => ({
    role: message.role === "assistant" ? "model" : "user",
    parts: [{text: message.text}],
  }));

  const last = history[history.length - 1];
  if (last?.role === "user" && last.parts[0]?.text === request.userMessage.text) {
    return history;
  }

  const userContent: GeminiContent = {
    role: "user",
    parts: [{text: request.userMessage.text}],
  };

  return [
    ...history,
    userContent,
  ];
}

export interface GeminiContent {
  role: "user" | "model";
  parts: Array<{text: string}>;
}
