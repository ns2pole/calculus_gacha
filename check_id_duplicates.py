#!/usr/bin/env python3
"""
全問題のID重複チェックスクリプト
IDの重複とID-noペアの重複をチェックします
"""
import re
import os
from pathlib import Path
from collections import defaultdict

def extract_problems_from_dart_file(file_path):
    """Dartファイルから問題を抽出"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    problems = []
    lines = content.split('\n')
    in_problem = False
    problem_lines = []
    comment_depth = 0
    
    for i, line in enumerate(lines):
        # コメントアウトのチェック
        stripped = line.strip()
        if stripped.startswith('//'):
            continue
        if '/*' in line:
            comment_depth += line.count('/*')
        if '*/' in line:
            comment_depth -= line.count('*/')
        if comment_depth > 0:
            continue
            
        if 'MathProblem(' in line and not stripped.startswith('//'):
            in_problem = True
            problem_lines = [line]
        elif in_problem:
            problem_lines.append(line)
            if line.strip().endswith('),') or (line.strip().endswith(')') and ');' in line):
                # 問題ブロックの終了
                problem_text = '\n'.join(problem_lines)
                
                # 問題情報を抽出
                id_match = re.search(r'id:\s*"([^"]+)"', problem_text)
                no_match = re.search(r'no:\s*(\d+)', problem_text)
                
                if id_match:
                    no = int(no_match.group(1)) if no_match else None
                    problems.append({
                        'id': id_match.group(1),
                        'no': no,
                        'file': os.path.basename(file_path),
                        'file_path': str(file_path),
                        'line': i - len(problem_lines) + 1
                    })
                in_problem = False
                problem_lines = []
    
    return problems

def main():
    base_dir = Path('lib/data')
    
    # 全ての問題ファイルを検索
    all_files = []
    
    # 積分問題
    integral_files = [
        'integrals/problems_abs_definite.dart',
        'integrals/problems_abs_definite_reserve.dart',
        'integrals/problems_basic_formula.dart',
        'integrals/problems_beta_function.dart',
        'integrals/problems_curves.dart',
        'integrals/problems_curves_reserve.dart',
        'integrals/problems_exponential_fraction.dart',
        'integrals/problems_exponential_fraction_reserve.dart',
        'integrals/problems_integration_by_parts.dart',
        'integrals/problems_linear_radical.dart',
        'integrals/problems_linear_radical_reserve.dart',
        'integrals/problems_others.dart',
        'integrals/problems_polynomial_fraction.dart',
        'integrals/problems_quadratic_radical.dart',
        'integrals/problems_substitution.dart',
        'integrals/problems_substitution_reserve.dart',
        'integrals/problems_trig_fraction.dart',
        'integrals/problems_trig_polynomial.dart',
        'integrals/problems_trig_polynomial_reserve.dart',
    ]
    
    # 極限問題
    limit_files = [
        'limits/advanced_limits.dart',
        'limits/basic_limits.dart',
        'limits/exponential_limits.dart',
        'limits/famous_limits.dart',
        'limits/problems_e_limit_variations.dart',
        'limits/rationalization_limits.dart',
        'limits/riemann_limits.dart',
        'limits/squeeze_limits.dart',
        'limits/trigonometric_limits.dart',
    ]
    
    # 因数分解問題
    factorization_files = [
        'factorization/basic_factorization.dart',
        'factorization/basic_factorization_reserve.dart',
        'factorization/mid_factorization.dart',
        'factorization/mid_factorization_reserve.dart',
        'factorization/advanced_factorization.dart',
        'factorization/advanced_factorization_reserve.dart',
    ]
    
    # その他の問題
    other_files = [
        'indeterminate_equations/indeterminate_equations.dart',
        'sequences/sequences.dart',
        'trig_exp_log_equations/trig_exp_log_equations.dart',
    ]
    
    # 物理数学問題
    physics_files = [
        'physics_math/first_order_exponential_problems.dart',
        'physics_math/physics_math_problems.dart',
        'physics_math/rlc_series_discharge_problems.dart',
        'physics_math/rlc_series_voltage_critical_problems.dart',
        'physics_math/rlc_series_voltage_overdamped_problems.dart',
        'physics_math/rlc_series_voltage_underdamped_problems.dart',
        'physics_math/second_order_no_damping_problems.dart',
        'physics_math/simple_harmonic_motion_problems.dart',
        'physics_math/uniform_acceleration_problems.dart',
    ]
    
    # 単位問題
    unit_files = [
        'unit/problems.dart',
        'unit/problems_with_categories.dart',
    ]
    
    all_files = (integral_files + limit_files + factorization_files + 
                 other_files + physics_files + unit_files)
    
    # 全ての問題を抽出
    all_problems = []
    for file_path in all_files:
        full_path = base_dir / file_path
        if full_path.exists():
            problems = extract_problems_from_dart_file(str(full_path))
            all_problems.extend(problems)
            print(f"✓ {file_path}: {len(problems)}問", flush=True)
        else:
            print(f"✗ {file_path}: ファイルが見つかりません", flush=True)
    
    print(f"\n全問題数: {len(all_problems)}問\n")
    print("=" * 80)
    print("ID重複チェック結果")
    print("=" * 80)
    print()
    
    # IDの重複チェック
    id_to_problems = defaultdict(list)
    for problem in all_problems:
        id_to_problems[problem['id']].append(problem)
    
    # ID-noペアの重複チェック
    id_no_pairs = defaultdict(list)
    for problem in all_problems:
        if problem['no'] is not None:
            pair = (problem['id'], problem['no'])
            id_no_pairs[pair].append(problem)
    
    # 結果を表示
    duplicate_ids = {k: v for k, v in id_to_problems.items() if len(v) > 1}
    duplicate_pairs = {k: v for k, v in id_no_pairs.items() if len(v) > 1}
    
    if duplicate_ids:
        print("⚠️  IDの重複が見つかりました:")
        print("-" * 80)
        for problem_id, problems in sorted(duplicate_ids.items()):
            print(f"\n重複ID: {problem_id} ({len(problems)}回出現)")
            for p in problems:
                print(f"  - {p['file']}:{p['line']} (no: {p['no']})")
        print()
    else:
        print("✓ IDの重複は見つかりませんでした")
        print()
    
    if duplicate_pairs:
        print("⚠️  ID-noペアの重複が見つかりました:")
        print("-" * 80)
        for (problem_id, no), problems in sorted(duplicate_pairs.items()):
            print(f"\n重複ペア: ID={problem_id}, no={no} ({len(problems)}回出現)")
            for p in problems:
                print(f"  - {p['file']}:{p['line']}")
        print()
    else:
        print("✓ ID-noペアの重複は見つかりませんでした")
        print()
    
    # 統計情報
    print("=" * 80)
    print("統計情報")
    print("=" * 80)
    print(f"全問題数: {len(all_problems)}問")
    print(f"ユニークなID数: {len(id_to_problems)}")
    print(f"重複しているID数: {len(duplicate_ids)}")
    print(f"重複しているID-noペア数: {len(duplicate_pairs)}")
    
    if duplicate_ids or duplicate_pairs:
        print("\n❌ 重複が見つかりました。上記の詳細を確認してください。")
        return 1
    else:
        print("\n✓ 全てのIDとID-noペアは一意です。")
        return 0

if __name__ == '__main__':
    exit(main())







