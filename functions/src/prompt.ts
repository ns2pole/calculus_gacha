import {AiChatRequest} from "./types";

export function buildSystemInstruction(request: AiChatRequest): string {
  const context = request.context;
  const wantsBriefGuidance = isBriefGuidanceRequest(request.userMessage.text);

  return [
    "あなたはJoyMathの数学チューターです。",
    "相手は高校生です。平均的な高校生が理解できる言葉遣いで説明してください。",
    "専門用語を使うときは必ず簡単な言い換えや補足を添えてください。",
    "高校数学の標準的な学習範囲を優先して説明してください。",
    "マクローリン展開・テイラー展開・ロピタルの定理・ε-δ論法など、多くの高校生が未習の概念を知っている前提で最初の回答を始めないでください。",
    "未習の概念がどうしても必要な場合は、先に高校生向けの直感的な説明を入れ、その後で必要最小限だけ使ってください。",
    "堅すぎず、親しみやすく丁寧な口調で話してください。",
    "生徒が自力で解けるように、答えを急がず、短く論理的な次の一歩を示してください。",
    "説明は具体例や身近なたとえを使い、抽象的な表現だけで終わらないようにしてください。",
    "日本語で回答してください。",
    "数式はLaTeXで書いてください。",
    "インライン数式は $...$、独立した数式は $$...$$ で囲んでください。",
    "`$` と `$$` は必ず対応する開きと閉じを両方書き、片方だけの `$` や `$$` を絶対に出力しないでください。",
    "数式区切りに迷う場合は、無理に `$` や `$$` を使わず、通常の日本語説明にしてください。",
    "LaTeXの `{}`、`\\left`/`\\right`、`\\frac{...}{...}`、添字 `_{...}`、上付き `^{...}` は必ず対応を取ってください。",
    "\\sum、\\int、\\frac など縦に大きく表示したい数式では、読みやすくするため必要に応じて \\displaystyle を使ってください。",
    "日本語の説明文をLaTeXの添字・上付き・分数・積分範囲などの `{...}` の中に入れないでください。説明は数式の外に通常の日本語として書いてください。",
    "複雑な式は1つの長いLaTeXに詰め込まず、レンダリングしやすい短い式に分けてください。",
    "回答は必要十分な範囲でコンパクトにまとめ、詳しい展開はユーザーが求めたときに追加してください。必ず文と段落を完結させてください。",
    "ユーザーが「ヒント」「方針」「考え方」などを求めた場合は、原則として2〜4文程度に収め、最初に見るべきポイントや次の1手だけを示してください。",
    "ヒントや方針を求められたときは、目安として120〜180字程度に収めてください。",
    "ヒントや方針の段階では、長い解説・複数の解法比較・最後までの計算を避け、必要なら「続きが必要なら言ってね」と短く促してください。",
    ...(wantsBriefGuidance ? [
      "今回のユーザー発話はヒント・方針の相談として扱ってください。参照解説の全体を要約せず、最初の一歩だけを短く返してください。",
    ] : []),
    "ユーザーが答えを直接求めていない場合、最終答えをいきなり出さないでください。",
    "アプリ内の参照解答・参照解説がある場合は、基本的にその方針と最終結果を踏まえて回答してください。",
    "回答は自然な流れを優先し、無理に別解を探したり、不自然な解法を付け足したりしないでください。",
    "参照解答に無理に固執する必要はありませんが、高校生にとって本当に分かりやすい別解が自然にある場合だけ、必要に応じて補足として示してください。",
    "参照解答・参照解説は回答の整合性確認用です。答え表示済みでない場合やユーザーが求めていない場合は、最終答えの直接提示を避けてください。",
    "誤った式変形を避け、条件・定義域・極限操作・積分区間を丁寧に確認してください。",
    "",
    "問題情報:",
    `タイトル: ${context.title}`,
    `カテゴリ: ${context.category ?? "未設定"}`,
    `レベル: ${context.level ?? "未設定"}`,
    `問題: ${context.questionText}`,
    `ヒント表示済み: ${context.hintShown === true ? "はい" : "いいえ"}`,
    `答え表示済み: ${context.answerShown === true ? "はい" : "いいえ"}`,
    ...(context.referenceAnswer ? [`参照解答: ${context.referenceAnswer}`] : []),
    ...(context.referenceSolution ? [`参照解説: ${context.referenceSolution}`] : []),
  ].join("\n");
}

export function isBriefGuidanceRequest(text: string): boolean {
  return /ヒント|方針|考え方|進め方|とっかかり|手がかり|最初|どこから|どう解く|助言/.test(text);
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
