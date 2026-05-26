export type AiChatRole = "user" | "assistant";

export interface AiChatContext {
  title: string;
  questionText: string;
  category?: string | null;
  level?: string | null;
  referenceAnswer?: string | null;
  referenceSolution?: string | null;
  hintShown?: boolean;
  answerShown?: boolean;
  attachmentsEnabled?: boolean;
}

export interface AiChatMessage {
  role: AiChatRole;
  text: string;
  choiceId?: string | null;
}

export type AiChatLocale = "ja" | "en";

export interface AiChatRequest {
  context: AiChatContext;
  history: AiChatMessage[];
  userMessage: AiChatMessage;
  clientInstallationId: string;
  locale: AiChatLocale;
}

export interface UsageIdentity {
  id: string;
  source: "firebase" | "installation" | "ip";
}

export interface UsageLimit {
  tier: "free" | "paid";
  period: "daily" | "monthly";
  limit: number;
  periodKey: string;
}
