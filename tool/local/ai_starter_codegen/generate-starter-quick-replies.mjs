#!/usr/bin/env node
/**
 * Generates lib/data/ai_chat/starter_quick_replies_by_problem_id.dart
 * using the same Gemini logic as Cloud Functions.
 *
 * Usage:
 *   cd functions && npm run build
 *   export GEMINI_API_KEY=$(firebase functions:secrets:access GEMINI_API_KEY)
 *   node tool/local/ai_starter_codegen/generate-starter-quick-replies.mjs
 *
 * Options:
 *   --resume     skip IDs already in starter_replies_progress.json (same dir)
 *   --limit N    process at most N new problems
 *   --id UUID    process a single problem id
 */

import {existsSync, readFileSync, writeFileSync, mkdirSync} from "node:fs";
import {dirname, join} from "node:path";
import {fileURLToPath} from "node:url";
import {generateStarterQuickReplies} from "../../../functions/lib/starterQuickReplies.js";

const __dirname = dirname(fileURLToPath(import.meta.url));
const root = join(__dirname, "../../..");
const manifestPath = join(__dirname, "starter_problems_manifest.json");
const progressPath = join(__dirname, "starter_replies_progress.json");
const dartOutPath = join(root, "lib/data/ai_chat/starter_quick_replies_by_problem_id.dart");

function resolveApiKey() {
  const raw = process.env.GEMINI_API_KEY?.trim() ?? "";
  if (!raw) return "";
  const line = raw
    .split(/\r?\n/)
    .map((value) => value.trim())
    .find((value) => value.startsWith("AIza"));
  return line ?? raw;
}

const apiKey = resolveApiKey();
if (!apiKey) {
  console.error("GEMINI_API_KEY is required.");
  process.exit(1);
}

const args = process.argv.slice(2);
const resume = args.includes("--resume");
const limitIndex = args.indexOf("--limit");
const limit = limitIndex >= 0 ? Number(args[limitIndex + 1]) : Infinity;
const idIndex = args.indexOf("--id");
const singleId = idIndex >= 0 ? args[idIndex + 1] : null;

const manifest = JSON.parse(readFileSync(manifestPath, "utf8"));
let progress = {};
if (resume && existsSync(progressPath)) {
  progress = JSON.parse(readFileSync(progressPath, "utf8"));
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function dartString(value) {
  return JSON.stringify(value);
}

function emitDart(map) {
  const ids = Object.keys(map).sort();
  const lines = [
    "import '../../models/ai_chat_quick_reply.dart';",
    "",
    "/// Auto-generated starter quick replies per [MathProblem.id].",
    "/// Regenerate: tool/generate-starter-quick-replies.mjs",
    "const starterQuickRepliesByProblemId = <String, List<AiChatQuickReply>>{",
  ];

  for (const id of ids) {
    const replies = map[id];
    if (!Array.isArray(replies) || replies.length === 0) continue;
    lines.push(`  ${dartString(id)}: [`);
    for (const reply of replies) {
      const parts = [`label: ${dartString(reply.label)}`];
      if (reply.sendText && reply.sendText !== reply.label) {
        parts.push(`sendText: ${dartString(reply.sendText)}`);
      }
      if (reply.actionId) {
        parts.push(`actionId: ${dartString(reply.actionId)}`);
      }
      lines.push(`    AiChatQuickReply(${parts.join(", ")}),`);
    }
    lines.push("  ],");
  }

  lines.push("};");
  lines.push("");
  lines.push("List<AiChatQuickReply>? lookupStarterQuickReplies(String problemId) {");
  lines.push("  final replies = starterQuickRepliesByProblemId[problemId];");
  lines.push("  if (replies == null || replies.isEmpty) return null;");
  lines.push("  return replies;");
  lines.push("}");
  lines.push("");

  mkdirSync(dirname(dartOutPath), {recursive: true});
  writeFileSync(dartOutPath, `${lines.join("\n")}\n`, "utf8");
}

let processed = 0;
for (const problem of manifest) {
  if (singleId != null && problem.id !== singleId) continue;
  if (progress[problem.id]) continue;
  if (processed >= limit) break;

  const request = {
    context: {
      title: problem.id,
      questionText: problem.questionText,
      category: problem.category,
      level: problem.level,
      referenceAnswer: problem.referenceAnswer,
      referenceSolution: problem.referenceSolution ?? null,
      hintShown: false,
      answerShown: false,
      attachmentsEnabled: false,
    },
    clientInstallationId: "starter-codegen",
    locale: "ja",
  };

  process.stderr.write(`[${Object.keys(progress).length + 1}/${manifest.length}] ${problem.id} ... `);
  try {
    const replies = await generateStarterQuickReplies(apiKey, request);
    progress[problem.id] = replies;
    writeFileSync(progressPath, JSON.stringify(progress, null, 2), "utf8");
    process.stderr.write(`ok (${replies.length})\n`);
  } catch (error) {
    process.stderr.write(`failed: ${error?.message ?? error}\n`);
    writeFileSync(progressPath, JSON.stringify(progress, null, 2), "utf8");
    await sleep(5000);
    continue;
  }

  processed += 1;
  emitDart(progress);
  await sleep(2000);
}

emitDart(progress);
process.stderr.write(`Done. ${Object.keys(progress).length} problems in ${dartOutPath}\n`);
