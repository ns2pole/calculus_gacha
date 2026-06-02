#!/usr/bin/env python3
"""Ensure every problem has first_step and hint as the first two starter quick replies."""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
DART_PATH = ROOT / "lib/data/ai_chat/starter_quick_replies_by_problem_id.dart"

REQUIRED = (
    ('label: "最初の一歩は何をすればいいですか？"', 'actionId: "first_step"'),
    ('label: "ヒントをください"', 'actionId: "hint"'),
)
REQUIRED_ACTION_IDS = frozenset({"first_step", "hint"})
DE_GACHA_MARKER = "微分方程式ガチャ"
DE_GACHA_THIRD = (
    'label: "この微分方程式が出てくる物理現象を知りたい"',
    'actionId: "physics_phenomenon"',
)
DE_GACHA_THIRD_ACTION_IDS = frozenset(
    {
        "physics_phenomenon",
        "physical_meaning",
        "rlc_connection",
        "physics_context",
    }
)
DE_GACHA_THIRD_LABEL_PATTERNS = (
    "物理現象",
    "物理的な意味",
    "物理的意味",
    "RLC回路",
)
COMMENT_LINE = re.compile(r"^\s*//.+:.+$")

REPLY_LINE = re.compile(r'^(\s*)AiChatQuickReply\((.*)\),?\s*$')
ACTION_ID = re.compile(r'actionId:\s*"([^"]+)"')
ID_LINE = re.compile(r'^(\s*)"([^"]+)":\s*\[\s*$')


def emit_reply(indent: str, label: str, action_id: str) -> str:
    return f'{indent}AiChatQuickReply({label}, {action_id}),\n'


def is_de_physics_duplicate(body: str) -> bool:
    action_match = ACTION_ID.search(body)
    action_id = action_match.group(1) if action_match else None
    if action_id in DE_GACHA_THIRD_ACTION_IDS:
        return True
    label_match = re.search(r'label:\s*"((?:\\.|[^"\\])*)"', body)
    if not label_match:
        return False
    label = label_match.group(1)
    return any(pattern in label for pattern in DE_GACHA_THIRD_LABEL_PATTERNS)


def main() -> None:
    lines = DART_PATH.read_text(encoding="utf-8").splitlines(keepends=True)
    out: list[str] = []
    index = 0
    updated = 0
    de_updated = 0
    last_gacha_comment = ""

    while index < len(lines):
        line = lines[index]
        if COMMENT_LINE.match(line) and f": {DE_GACHA_MARKER}" in line:
            last_gacha_comment = line
        elif COMMENT_LINE.match(line):
            last_gacha_comment = line

        match = ID_LINE.match(line)
        if not match:
            out.append(line)
            index += 1
            continue

        is_de_gacha = DE_GACHA_MARKER in last_gacha_comment
        indent = match.group(1)
        reply_indent = indent + "  "
        out.append(line)
        index += 1

        extras: list[str] = []
        while index < len(lines) and lines[index].strip() != "],":
            reply_match = REPLY_LINE.match(lines[index].rstrip("\n"))
            if reply_match:
                body = reply_match.group(2)
                action_match = ACTION_ID.search(body)
                action_id = action_match.group(1) if action_match else None
                if action_id not in REQUIRED_ACTION_IDS and not (
                    is_de_gacha and is_de_physics_duplicate(body)
                ):
                    extras.append(lines[index])
            index += 1

        for label, action_id in REQUIRED:
            out.append(emit_reply(reply_indent, label, action_id))
        if is_de_gacha:
            out.append(emit_reply(reply_indent, *DE_GACHA_THIRD))
            de_updated += 1
        out.extend(extras)

        if index < len(lines):
            out.append(lines[index])
            index += 1

        updated += 1

    DART_PATH.write_text("".join(out), encoding="utf-8")
    print(
        f"Ensured required starters for {updated} problems "
        f"({de_updated} with DE physics chip) in {DART_PATH}",
        file=sys.stderr,
    )


if __name__ == "__main__":
    main()
