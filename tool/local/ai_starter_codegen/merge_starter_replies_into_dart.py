#!/usr/bin/env python3
"""Merge starter_replies_progress.json entries into starter_quick_replies_by_problem_id.dart in file order."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
CODEGEN_DIR = Path(__file__).resolve().parent
DART_PATH = ROOT / "lib/data/ai_chat/starter_quick_replies_by_problem_id.dart"
PROGRESS_PATH = CODEGEN_DIR / "starter_replies_progress.json"


def emit_reply_lines(replies: list[dict], indent: str) -> list[str]:
    lines: list[str] = []
    for reply in replies:
        parts = [f'label: {json.dumps(reply["label"], ensure_ascii=False)}']
        send_text = reply.get("sendText")
        if send_text and send_text != reply["label"]:
            parts.append(f'sendText: {json.dumps(send_text, ensure_ascii=False)}')
        action_id = reply.get("actionId")
        if action_id:
            parts.append(f'actionId: {json.dumps(action_id, ensure_ascii=False)}')
        lines.append(f"{indent}AiChatQuickReply({', '.join(parts)}),\n")
    return lines


def merge_ids(ids: set[str], progress: dict[str, list]) -> None:
    lines = DART_PATH.read_text(encoding="utf-8").splitlines(keepends=True)
    out: list[str] = []
    index = 0

    id_line = re.compile(r'^(\s*)"([^"]+)":\s*\[\s*$')

    while index < len(lines):
        line = lines[index]
        match = id_line.match(line)
        if match and match.group(2) in ids:
            problem_id = match.group(2)
            indent = match.group(1)
            reply_indent = indent + "  "
            out.append(line)

            if problem_id not in progress or not progress[problem_id]:
                raise SystemExit(f"No progress replies for {problem_id}")

            out.extend(emit_reply_lines(progress[problem_id], reply_indent))

            index += 1
            while index < len(lines) and lines[index].strip() != "],":
                index += 1
            if index < len(lines):
                out.append(lines[index])
            index += 1
            continue

        out.append(line)
        index += 1

    DART_PATH.write_text("".join(out), encoding="utf-8")


def main() -> None:
    ids_path = Path(sys.argv[1]) if len(sys.argv) > 1 else None
    progress = json.loads(PROGRESS_PATH.read_text(encoding="utf-8"))

    if ids_path:
        ids = {
            line.strip()
            for line in ids_path.read_text(encoding="utf-8").splitlines()
            if line.strip() and not line.strip().startswith("#")
        }
    else:
        ids = set(progress.keys())

    merge_ids(ids, progress)
    print(f"Merged {len(ids)} problem(s) into {DART_PATH}", file=sys.stderr)


if __name__ == "__main__":
    main()
