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
 *   --ids-file PATH   only process IDs listed in the file (one per line)
 *   --force      regenerate even if already in progress
 *   --merge-dart merge into dart after each success (use with --ids-file)
 */

import {execFileSync} from "node:child_process";
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
const force = args.includes("--force");
const mergeDart = args.includes("--merge-dart");
const limitIndex = args.indexOf("--limit");
const limit = limitIndex >= 0 ? Number(args[limitIndex + 1]) : Infinity;
const idIndex = args.indexOf("--id");
const singleId = idIndex >= 0 ? args[idIndex + 1] : null;
const idsFileIndex = args.indexOf("--ids-file");
const idsFile = idsFileIndex >= 0 ? args[idsFileIndex + 1] : null;

/** Matches CloudAiChatClient installation id format (fixed for reproducible codegen). */
const CODEGEN_INSTALLATION_ID = "starterCodegenInstallId0";

const manifest = JSON.parse(readFileSync(manifestPath, "utf8"));
const manifestById = new Map(manifest.map((problem) => [problem.id, problem]));

let targetIdList = null;
if (idsFile != null) {
  targetIdList = readFileSync(idsFile, "utf8")
    .split(/\r?\n/)
    .map((line) => line.trim())
    .filter((line) => line.length > 0 && !line.startsWith("#"));
}
const targetIds = targetIdList != null ? new Set(targetIdList) : null;

let progress = {};
if (existsSync(progressPath)) {
  progress = JSON.parse(readFileSync(progressPath, "utf8"));
}
if (force && targetIds != null) {
  for (const id of targetIds) {
    delete progress[id];
  }
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

function buildStarterRequest(problem) {
  return {
    context: {
      title: problem.title ?? problem.id,
      questionText: problem.questionText,
      category: problem.category ?? null,
      level: problem.level ?? null,
      referenceAnswer: problem.referenceAnswer ?? null,
      referenceSolution: problem.referenceSolution ?? null,
      hintShown: problem.hintShown === true,
      answerShown: problem.answerShown === true,
      attachmentsEnabled: problem.attachmentsEnabled === true,
    },
    clientInstallationId: CODEGEN_INSTALLATION_ID,
    locale: "ja",
  };
}

function runMergeDart() {
  const mergeScript = join(__dirname, "merge_starter_replies_into_dart.py");
  if (!existsSync(mergeScript)) return;
  const mergeArgs = idsFile != null ? [mergeScript, idsFile] : [mergeScript];
  execFileSync("python3", mergeArgs, {stdio: "inherit", cwd: root});
}

let processed = 0;
const problemsToRun =
  targetIdList != null
    ? targetIdList
        .map((id) => {
          const entry = manifestById.get(id);
          if (entry == null) {
            process.stderr.write(`Warning: no manifest entry for ${id}\n`);
          }
          return entry;
        })
        .filter(Boolean)
    : manifest;

for (const problem of problemsToRun) {
  if (singleId != null && problem.id !== singleId) continue;
  if (targetIds != null && !targetIds.has(problem.id)) continue;
  if (resume && progress[problem.id] && !force) continue;
  if (processed >= limit) break;

  const request = buildStarterRequest(problem);

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
  if (!mergeDart) {
    emitDart(progress);
  }
  await sleep(2000);
}

if (mergeDart) {
  runMergeDart();
} else {
  emitDart(progress);
}
process.stderr.write(
  `Done. ${processed} processed; progress has ${Object.keys(progress).length} problem(s).\n`,
);
