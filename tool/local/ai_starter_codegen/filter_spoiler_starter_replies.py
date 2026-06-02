#!/usr/bin/env python3
"""Remove starter quick replies that name the solution technique/formula upfront."""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
DART_PATH = ROOT / "lib/data/ai_chat/starter_quick_replies_by_problem_id.dart"

# actionId values that typically reveal the method before dialogue
SPOILER_ACTION_IDS = frozenset(
    {
        "about_cross_multiplication",
        "approach_check",
        "approach_specific_riemann",
        "ask_euclidean_algorithm",
        "characteristic_equation_info",
        "characteristic_equation_meaning",
        "check_even_odd",
        "confirm_technique",
        "confirm_type",
        "definition_of_e",
        "euclidean_algorithm_meaning",
        "explain_concept",
        "explain_even_odd",
        "factor_theorem",
        "formula_half_angle",
        "general_solution_form",
        "hint_formula",
        "hint_half_angle",
        "hint_lhopital",
        "hint_product_to_sum",
        "hint_substitution",
        "hint_sum_to_product",
        "hint_trig_sub",
        "how_to_form_characteristic_equation",
        "integration_by_parts_formula",
        "integration_by_parts_setup",
        "is_it_e_definition",
        "particular_solution_hint",
        "ratio_test_hint",
        "related_limit_question",
        "squeeze_theorem_hint",
        "sum_formula_hint",
        "term_definition",
        "trig_synthesis_explanation",
        "what_is_characteristic_equation",
        "assume_particular_solution",
        "how_to_integrate_logx",
        "geometric_series_hint",
        "trig_identity_hint",
        "quadratic_factorization",
        "substitution_hint",
        "undetermined_coefficients_method",
        "undetermined_coefficients_start",
        "formula_hint",
    }
)

# Label/sendText patterns (technique or named formula as the ask itself)
SPOILER_TEXT_PATTERNS = [
    r"を使う問題",
    r"を使うのでしょうか",
    r"は使えますか",
    r"は使いますか",
    r"を使いますか",
    r"の公式を教えて",
    r"の公式って",
    r"の公式を使",
    r"の公式について",
    r"公式について教え",
    r"公式を使う",
    r"公式を教えて",
    r"とは何ですか",
    r"とはなんですか",
    r"って何だっけ",
    r"って何ですか",
    r"部分積分",
    r"置換積分",
    r"変数分離",
    r"定数分離",
    r"因数定理",
    r"たすきがけ",
    r"特性方程式",
    r"互除法",
    r"ユークリッド",
    r"ロピタル",
    r"はさみうち",
    r"比の判定",
    r"区分求積",
    r"ウォリス",
    r"半角の公式",
    r"半角公式",
    r"積和の公式",
    r"和積の公式",
    r"積和公式",
    r"和積公式",
    r"六分の",
    r"1/6",
    r"六分の一",
    r"eの定義",
    r"ネイピア数",
    r"sin\s*x\s*/\s*x",
    r"三角関数を使った置換",
    r"三角関数の合成",
    r"f\(x\)とg'",
    r"g'\(x\)をどう設定",
    r"置換積分の方針",
    r"因数分解の公式を使",
    r"特殊解の求め方",
    r"特殊解を",
    r"積和公式",
    r"和積の公式を使う",
    r"減衰振動の式ですか",
    r"完全平方式の形ですか",
    r"置換積分を",
    r"二項定理",
    r"中国剰余",
    r"どんな置換が",
    r"有理化",
    r"部分分数",
    r"ベータ関数",
    r"ガンマ関数",
    r"uと置",
    r"特解を仮定",
    r"特解を",
    r"log\s*x\s*の積分",
    r"どんな.*公式",
    r"等比数列の和",
    r"2次式×2次式",
    r"2次式.?2次式",
    r"展開するべき",
    r"整数解を求める問題",
    r"因数分解の問題ですか",
    r"どんな置換",
    r"どのような置換",
    r"双曲線",
    r"未定係数",
    r"よく使う極限の公式",
    r"公式が使え",
    r"公式を使え",
]

REPLY_LINE = re.compile(
    r'^(\s*)AiChatQuickReply\((.*)\),?\s*$',
)
ACTION_ID = re.compile(r'actionId:\s*"([^"]+)"')
LABEL = re.compile(r'label:\s*"((?:\\.|[^"\\])*)"')
SEND_TEXT = re.compile(r'sendText:\s*"((?:\\.|[^"\\])*)"')


def unescape_dart_string(s: str) -> str:
    return s.replace(r"\\n", "\n").replace(r'\"', '"').replace(r"\\", "\\")


def is_spoiler(label: str, send_text: str | None, action_id: str | None) -> bool:
    if action_id and action_id in SPOILER_ACTION_IDS:
        return True
    blob = f"{label}\n{send_text or ''}"
    for pat in SPOILER_TEXT_PATTERNS:
        if re.search(pat, blob, re.IGNORECASE):
            return True
    return False


def parse_reply_line(line: str) -> tuple[str, str | None, str | None] | None:
    m = REPLY_LINE.match(line)
    if not m:
        return None
    body = m.group(2)
    lm = LABEL.search(body)
    if not lm:
        return None
    label = unescape_dart_string(lm.group(1))
    sm = SEND_TEXT.search(body)
    send_text = unescape_dart_string(sm.group(1)) if sm else None
    am = ACTION_ID.search(body)
    action_id = am.group(1) if am else None
    return label, send_text, action_id


def main() -> None:
    dry_run = "--apply" not in sys.argv
    lines = DART_PATH.read_text(encoding="utf-8").splitlines(keepends=True)
    out: list[str] = []
    removed: list[tuple[str, str]] = []
    current_id = "?"

    for line in lines:
        id_m = re.match(r'^\s*"([^"]+)":\s*\[', line)
        if id_m:
            current_id = id_m.group(1)

        parsed = parse_reply_line(line.rstrip("\n"))
        if parsed:
            label, send_text, action_id = parsed
            if is_spoiler(label, send_text, action_id):
                removed.append((current_id, label))
                continue

        out.append(line)

    # Ensure each problem block still has starter chips
    fixed_lines: list[str] = []
    i = 0
    while i < len(out):
        line = out[i]
        if re.match(r'^\s*"[^"]+":\s*\[\s*$', line):
            block_start = len(fixed_lines)
            fixed_lines.append(line)
            i += 1
            reply_count = 0
            while i < len(out) and out[i].strip() != "],":
                if "AiChatQuickReply(" in out[i]:
                    reply_count += 1
                fixed_lines.append(out[i])
                i += 1
            if reply_count == 0:
                indent = re.match(r"^(\s*)", line).group(1) + "  "
                fixed_lines.insert(
                    block_start + 1,
                    f'{indent}AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),\n',
                )
                fixed_lines.insert(
                    block_start + 2,
                    f'{indent}AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),\n',
                )
            if i < len(out):
                fixed_lines.append(out[i])
                i += 1
            continue
        fixed_lines.append(line)
        i += 1
    out = fixed_lines

    print(f"Removed {len(removed)} spoiler starter replies", file=sys.stderr)
    if removed and dry_run:
        for pid, label in removed[:30]:
            print(f"  {pid}: {label}", file=sys.stderr)
        if len(removed) > 30:
            print(f"  ... and {len(removed) - 30} more", file=sys.stderr)
        print("Dry run. Pass --apply to write.", file=sys.stderr)
        return

    if not dry_run:
        DART_PATH.write_text("".join(out), encoding="utf-8")
        print(f"Wrote {DART_PATH}", file=sys.stderr)


if __name__ == "__main__":
    main()
