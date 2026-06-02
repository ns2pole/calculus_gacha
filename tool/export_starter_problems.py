#!/usr/bin/env python3
"""Export problem manifests for starter quick-reply code generation (excludes mod/congruence)."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

# Reuse extractors from generate_problem_id_pairs.py
ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from generate_problem_id_pairs import (  # noqa: E402
    extract_congruence_problems,
    extract_problems_from_dart_file,
)

PROBLEM_FILES: list[tuple[str, str]] = [
    # Integrals (matches all_problems.dart, including reserve)
    ("integrals/problems_abs_definite.dart", "math"),
    ("integrals/problems_abs_definite_reserve.dart", "math"),
    ("integrals/problems_basic_formula.dart", "math"),
    ("integrals/problems_beta_function.dart", "math"),
    ("integrals/problems_exponential_fraction.dart", "math"),
    ("integrals/problems_exponential_fraction_reserve.dart", "math"),
    ("integrals/problems_integration_by_parts.dart", "math"),
    ("integrals/problems_linear_radical.dart", "math"),
    ("integrals/problems_linear_radical_reserve.dart", "math"),
    ("integrals/problems_others.dart", "math"),
    ("integrals/problems_polynomial_fraction.dart", "math"),
    ("integrals/problems_quadratic_radical.dart", "math"),
    ("integrals/problems_substitution.dart", "math"),
    ("integrals/problems_substitution_reserve.dart", "math"),
    ("integrals/problems_trig_polynomial.dart", "math"),
    ("integrals/problems_trig_polynomial_reserve.dart", "math"),
    ("integrals/problems_trig_fraction.dart", "math"),
    ("integrals/problems_curves.dart", "math"),
    ("integrals/problems_curves_reserve.dart", "math"),
    # Limits
    ("limits/basic_limits.dart", "math"),
    ("limits/rationalization_limits.dart", "math"),
    ("limits/trigonometric_limits.dart", "math"),
    ("limits/exponential_limits.dart", "math"),
    ("limits/squeeze_limits.dart", "math"),
    ("limits/riemann_limits.dart", "math"),
    ("limits/advanced_limits.dart", "math"),
    ("limits/famous_limits.dart", "math"),
    ("limits/problems_e_limit_variations.dart", "math"),
    ("limits/log_limits.dart", "math"),
    ("limits/mean_value_theorem_limits.dart", "math"),
    # Physics math (大学 keyword filtered in extractor)
    ("physics_math/uniform_acceleration_problems.dart", "math"),
    ("physics_math/simple_harmonic_motion_problems.dart", "math"),
    ("physics_math/first_order_exponential_problems.dart", "math"),
    ("physics_math/second_order_no_damping_problems.dart", "math"),
    ("physics_math/rlc_series_discharge_problems.dart", "math"),
    ("physics_math/rlc_series_voltage_critical_problems.dart", "math"),
    ("physics_math/rlc_series_voltage_overdamped_problems.dart", "math"),
    ("physics_math/rlc_series_voltage_underdamped_problems.dart", "math"),
    # Factorization
    ("factorization/basic_factorization.dart", "math"),
    ("factorization/basic_factorization_reserve.dart", "math"),
    ("factorization/mid_factorization.dart", "math"),
    ("factorization/mid_factorization_reserve.dart", "math"),
    ("factorization/advanced_factorization.dart", "math"),
    ("factorization/advanced_factorization_reserve.dart", "math"),
    # Others
    ("indeterminate_equations/indeterminate_equations.dart", "math"),
    ("sequences/sequences.dart", "math"),
    ("trig_exp_log_equations/trig_exp_log_equations.dart", "math"),
]


def _read_field(block: str, name: str) -> str | None:
    triple = re.search(rf"{name}:\s*r?\"\"\"(.*?)\"\"\"", block, re.DOTALL)
    if triple:
        return triple.group(1).strip()
    single = re.search(rf'{name}:\s*r?"([^"]*)"', block, re.DOTALL)
    if single:
        return single.group(1).strip()
    return None


def _extract_rich_problem(file_path: Path, raw: dict) -> dict | None:
    try:
        content = file_path.read_text(encoding="utf-8")
    except OSError:
        return None

    problem_id = raw["id"]
    pattern = rf'id:\s*"{re.escape(problem_id)}"'
    match = re.search(pattern, content)
    if not match:
        return None

    start = content.rfind("MathProblem(", 0, match.start())
    if start < 0:
        return None

    depth = 0
    end = start
    for i in range(start, len(content)):
        ch = content[i]
        if ch == "(":
            depth += 1
        elif ch == ")":
            depth -= 1
            if depth == 0:
                end = i + 1
                break
    block = content[start:end]

    category = _read_field(block, "category") or ""
    level = _read_field(block, "level") or ""
    question = _read_field(block, "question") or raw.get("question", "")
    answer = _read_field(block, "answer") or ""
    hint = _read_field(block, "hint")
    equation = _read_field(block, "equation")
    conditions = _read_field(block, "conditions")

    question_parts: list[str] = []
    if equation:
        question_parts.append(equation)
    if conditions:
        question_parts.append(conditions)
    if not question_parts and question:
        question_parts = [
            part.strip()
            for part in re.split(r"\s*\n+\s*", question)
            if part.strip()
        ]

    reference_solution = hint or ""
    steps_match = re.search(r"steps:\s*\[(.*?)\]\s*,", block, re.DOTALL)
    if steps_match:
        step_texts = re.findall(r'tex:\s*r?"""(.*?)"""', steps_match.group(1), re.DOTALL)
        if not step_texts:
            step_texts = re.findall(r'tex:\s*r?"([^"]*)"', steps_match.group(1), re.DOTALL)
        for tex in step_texts[:3]:
            text = tex.strip()
            if text:
                reference_solution += ("\n" if reference_solution else "") + text

    if len(reference_solution) > 6000:
        reference_solution = reference_solution[:6000]

    return {
        "id": problem_id,
        "category": category,
        "level": level,
        "questionText": "\n".join(question_parts),
        "referenceAnswer": answer,
        "referenceSolution": reference_solution or None,
        "hintShown": False,
        "answerShown": False,
    }


def main() -> None:
    base_dir = ROOT / "lib/problems"
    by_id: dict[str, dict] = {}

    for rel_path, file_type in PROBLEM_FILES:
        full_path = base_dir / rel_path
        if not full_path.exists():
            print(f"Warning: missing {rel_path}", file=sys.stderr)
            continue

        if file_type == "math":
            raw_problems = extract_problems_from_dart_file(str(full_path))
        else:
            raw_problems = []

        for raw in raw_problems:
            rich = _extract_rich_problem(full_path, raw)
            if rich is None:
                continue
            by_id[rich["id"]] = rich

    entries = sorted(by_id.values(), key=lambda item: item["id"])
    out_path = ROOT / "tool" / "starter_problems_manifest.json"
    out_path.write_text(
        json.dumps(entries, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    print(f"Wrote {len(entries)} problems to {out_path}", file=sys.stderr)


if __name__ == "__main__":
    main()
