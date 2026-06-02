#!/usr/bin/env python3
"""Insert // question : gacha comments above each entry in starter_quick_replies_by_problem_id.dart."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT))

from generate_problem_id_pairs import (  # noqa: E402
    extract_congruence_problems,
    extract_problems_from_dart_file,
)

CODEGEN_DIR = Path(__file__).resolve().parent
DART_PATH = ROOT / "lib/data/ai_chat/starter_quick_replies_by_problem_id.dart"
MANIFEST_PATH = CODEGEN_DIR / "starter_problems_manifest.json"

# File path (under lib/problems) -> gacha display name
FILE_TO_GACHA: dict[str, str] = {
    # Integrals
    "integrals/problems_abs_definite.dart": "積分ガチャ",
    "integrals/problems_abs_definite_reserve.dart": "積分ガチャ",
    "integrals/problems_basic_formula.dart": "積分ガチャ",
    "integrals/problems_beta_function.dart": "積分ガチャ",
    "integrals/problems_exponential_fraction.dart": "積分ガチャ",
    "integrals/problems_exponential_fraction_reserve.dart": "積分ガチャ",
    "integrals/problems_integration_by_parts.dart": "積分ガチャ",
    "integrals/problems_linear_radical.dart": "積分ガチャ",
    "integrals/problems_linear_radical_reserve.dart": "積分ガチャ",
    "integrals/problems_others.dart": "積分ガチャ",
    "integrals/problems_polynomial_fraction.dart": "積分ガチャ",
    "integrals/problems_quadratic_radical.dart": "積分ガチャ",
    "integrals/problems_substitution.dart": "積分ガチャ",
    "integrals/problems_substitution_reserve.dart": "積分ガチャ",
    "integrals/problems_trig_polynomial.dart": "積分ガチャ",
    "integrals/problems_trig_polynomial_reserve.dart": "積分ガチャ",
    "integrals/problems_trig_fraction.dart": "積分ガチャ",
    "integrals/problems_curves.dart": "積分ガチャ",
    "integrals/problems_curves_reserve.dart": "積分ガチャ",
    # Limits
    "limits/basic_limits.dart": "極限ガチャ",
    "limits/rationalization_limits.dart": "極限ガチャ",
    "limits/trigonometric_limits.dart": "極限ガチャ",
    "limits/exponential_limits.dart": "極限ガチャ",
    "limits/squeeze_limits.dart": "極限ガチャ",
    "limits/riemann_limits.dart": "極限ガチャ",
    "limits/advanced_limits.dart": "極限ガチャ",
    "limits/famous_limits.dart": "極限ガチャ",
    "limits/problems_e_limit_variations.dart": "極限ガチャ",
    "limits/log_limits.dart": "極限ガチャ",
    "limits/mean_value_theorem_limits.dart": "極限ガチャ",
    # Physics / DE
    "physics_math/uniform_acceleration_problems.dart": "微分方程式ガチャ",
    "physics_math/simple_harmonic_motion_problems.dart": "微分方程式ガチャ",
    "physics_math/first_order_exponential_problems.dart": "微分方程式ガチャ",
    "physics_math/second_order_no_damping_problems.dart": "微分方程式ガチャ",
    "physics_math/rlc_series_discharge_problems.dart": "微分方程式ガチャ",
    "physics_math/rlc_series_voltage_critical_problems.dart": "微分方程式ガチャ",
    "physics_math/rlc_series_voltage_overdamped_problems.dart": "微分方程式ガチャ",
    "physics_math/rlc_series_voltage_underdamped_problems.dart": "微分方程式ガチャ",
    # Factorization
    "factorization/basic_factorization.dart": "因数分解ガチャ",
    "factorization/basic_factorization_reserve.dart": "因数分解ガチャ",
    "factorization/mid_factorization.dart": "因数分解ガチャ",
    "factorization/mid_factorization_reserve.dart": "因数分解ガチャ",
    "factorization/advanced_factorization.dart": "因数分解ガチャ",
    "factorization/advanced_factorization_reserve.dart": "因数分解ガチャ",
    # Others
    "indeterminate_equations/indeterminate_equations.dart": "不定方程式ガチャ",
    "sequences/sequences.dart": "漸化式ガチャ",
    "trig_exp_log_equations/trig_exp_log_equations.dart": "三角指数対数ガチャ",
    "congruence_equations/congruence_equations.dart": "modガチャ",
}


def build_id_to_gacha() -> dict[str, str]:
    base = ROOT / "lib/problems"
    out: dict[str, str] = {}
    for rel, gacha in FILE_TO_GACHA.items():
        full = base / rel
        if not full.exists():
            continue
        if rel.endswith("congruence_equations.dart"):
            problems = extract_congruence_problems(str(full))
        else:
            problems = extract_problems_from_dart_file(str(full))
        for p in problems:
            out[p["id"]] = gacha
    return out


def load_questions_from_pairs_txt() -> dict[str, str]:
    path = ROOT / "problem_id_pairs.txt"
    if not path.exists():
        return {}
    text = path.read_text(encoding="utf-8")
    out: dict[str, str] = {}
    blocks = re.split(r"\n(?=\d+\. ID: )", text)
    for block in blocks:
        id_m = re.search(r"ID:\s*(\S+)", block)
        q_m = re.search(r"問題:\s*(.+)", block, re.DOTALL)
        if id_m and q_m:
            q = q_m.group(1).strip().split("\n")[0].strip()
            out[id_m.group(1)] = q
    return out


def build_question_by_id(manifest_by_id: dict) -> dict[str, str]:
    out: dict[str, str] = {}
    for pid, entry in manifest_by_id.items():
        out[pid] = entry.get("questionText") or ""
    out.update(load_questions_from_pairs_txt())
    base = ROOT / "lib/problems"
    for rel in FILE_TO_GACHA:
        full = base / rel
        if not full.exists():
            continue
        if rel.endswith("congruence_equations.dart"):
            problems = extract_congruence_problems(str(full))
        else:
            problems = extract_problems_from_dart_file(str(full))
        for p in problems:
            out.setdefault(p["id"], p.get("question", ""))
    return out


def simplify_question(text: str) -> str:
    s = text.strip()
    s = re.sub(r"\\displaystyle\s*", "", s)
    s = re.sub(r"\\text\{([^{}]*)\}", r"\1", s)
    s = re.sub(r"\\,|\s+", " ", s)
    s = re.sub(r"\s*\n+\s*", ", ", s)
    s = re.sub(r"\\quad\b", " ", s)

    def frac_repl(m: re.Match[str]) -> str:
        num, den = m.group(1).strip(), m.group(2).strip()
        if len(num) + len(den) <= 24:
            return f"({num})/({den})"
        return m.group(0)

    s = re.sub(r"\\frac\{([^{}]*)\}\{([^{}]*)\}", frac_repl, s)
    s = re.sub(r"\s+", " ", s).strip()
    if len(s) > 140:
        s = s[:137] + "..."
    return s


def comment_for(
    problem_id: str,
    question_by_id: dict[str, str],
    gacha_by_id: dict[str, str],
) -> str:
    raw = question_by_id.get(problem_id, "")
    q = simplify_question(raw) if raw else "?"
    gacha = gacha_by_id.get(problem_id, "?")
    return f"//{q} : {gacha}"


def main() -> None:
    manifest = json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))
    manifest_by_id = {e["id"]: e for e in manifest}
    gacha_by_id = build_id_to_gacha()
    question_by_id = build_question_by_id(manifest_by_id)

    original = DART_PATH.read_text(encoding="utf-8")
    lines = original.splitlines(keepends=True)
    out: list[str] = []
    id_re = re.compile(r'^(\s*)"([^"]+)":\s*\[')
    comment_re = re.compile(r"^\s*//.+:.+$")

    i = 0
    while i < len(lines):
        line = lines[i]
        m = id_re.match(line)
        if m:
            pid = m.group(2)
            while out and (out[-1].strip() == "//" or comment_re.match(out[-1])):
                out.pop()
            out.append(comment_for(pid, question_by_id, gacha_by_id) + "\n")
            out.append(line)
        else:
            if line.strip() != "//":
                out.append(line)
        i += 1

    updated = "".join(out)
    # Safety: body (without our problem comments) must be unchanged
    def strip_problem_comments(text: str) -> str:
        return re.sub(r"^\s*//.+:.+$\n", "", text, flags=re.M)

    if strip_problem_comments(original) != strip_problem_comments(updated):
        print("ERROR: quick-reply content would change; aborting.", file=sys.stderr)
        sys.exit(1)

    DART_PATH.write_text(updated, encoding="utf-8")
    count = sum(1 for ln in out if id_re.match(ln))
    missing = sum(
        1 for ln in out if id_re.match(ln) and comment_for(id_re.match(ln).group(2), question_by_id, gacha_by_id).startswith("//?")
    )
    print(f"Updated {DART_PATH} ({count} entries, {missing} without metadata)", file=sys.stderr)


if __name__ == "__main__":
    main()
