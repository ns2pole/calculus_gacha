#!/usr/bin/env python3
"""
全問題を抽出して検証するスクリプト
"""
import re
import os
from pathlib import Path

def extract_problems_from_dart_file(file_path):
    """Dartファイルから問題を抽出"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    problems = []
    # MathProblem( で始まるブロックを抽出
    pattern = r'MathProblem\s*\([^)]*id:\s*"([^"]+)"[^)]*no:\s*(\d+)[^)]*category:\s*\'([^\']+)\'[^)]*level:\s*\'([^\']+)\'[^)]*question:\s*r?"""([^"]*)"""'
    
    # より詳細な抽出
    # コメントアウトされていないMathProblemを探す
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
                category_match = re.search(r"category:\s*'([^']+)'", problem_text)
                question_match = re.search(r'question:\s*r?"""([^"]*)"""', problem_text, re.DOTALL)
                answer_match = re.search(r'answer:\s*r?"""([^"]*)"""', problem_text, re.DOTALL)
                
                if id_match and no_match:
                    problems.append({
                        'id': id_match.group(1),
                        'no': int(no_match.group(1)),
                        'category': category_match.group(1) if category_match else '不明',
                        'question': question_match.group(1) if question_match else '',
                        'answer': answer_match.group(1) if answer_match else '',
                        'file': os.path.basename(file_path),
                        'line': i - len(problem_lines) + 1
                    })
                in_problem = False
                problem_lines = []
    
    return problems

def main():
    base_dir = Path('lib/data')
    
    # 検証対象ファイル
    integral_files = [
        'integrals/problems_abs_definite.dart',
        'integrals/problems_basic_formula.dart',
        'integrals/problems_beta_function.dart',
        'integrals/problems_curves.dart',
        'integrals/problems_exponential_fraction.dart',
        'integrals/problems_integration_by_parts.dart',
        'integrals/problems_linear_radical.dart',
        'integrals/problems_others.dart',
        'integrals/problems_polynomial_fraction.dart',
        'integrals/problems_quadratic_radical.dart',
        'integrals/problems_substitution.dart',
        'integrals/problems_trig_fraction.dart',
        'integrals/problems_trig_polynomial.dart',
    ]
    
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
    
    other_files = [
        'factorization/basic_factorization.dart',
        'factorization/mid_factorization.dart',
        'factorization/advanced_factorization.dart',
        'indeterminate_equations/indeterminate_equations.dart',
        'sequences/sequences.dart',
    ]
    
    all_files = [(f, '積分') for f in integral_files] + \
                [(f, '極限') for f in limit_files] + \
                [(f, 'その他') for f in other_files]
    
    all_problems = []
    for file_path, category_type in all_files:
        full_path = base_dir / file_path
        if full_path.exists():
            problems = extract_problems_from_dart_file(str(full_path))
            for p in problems:
                p['category_type'] = category_type
            all_problems.extend(problems)
            print(f"{file_path}: {len(problems)}問", flush=True)
    
    print(f"\n全問題数: {len(all_problems)}問")
    print("\n=== 全問題リスト ===\n")
    
    for i, p in enumerate(all_problems, 1):
        print(f"{i}. [{p['category_type']}] {p['file']} - No.{p['no']} ({p['category']})")
        print(f"   問題: {p['question'][:50]}...")
        print(f"   答え: {p['answer'][:50]}...")
        print()

if __name__ == '__main__':
    main()

