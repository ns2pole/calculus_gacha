#!/usr/bin/env python3
"""
全問題を詳細に検証するスクリプト
各問題のquestion, answer, stepsを抽出して検証
"""
import re
import os
from pathlib import Path

def extract_full_problem(file_path):
    """Dartファイルから完全な問題情報を抽出"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    problems = []
    
    # MathProblem( から ), または ); までのブロックを抽出
    # コメントアウトされていないものを探す
    pattern = r'MathProblem\s*\([^)]*(?:\([^)]*\)[^)]*)*\)[^,)]*[,;]'
    
    # より正確な抽出：MathProblem( から始まり、対応する閉じ括弧まで
    lines = content.split('\n')
    in_problem = False
    problem_lines = []
    brace_count = 0
    paren_count = 0
    in_string = False
    string_char = None
    
    for i, line in enumerate(lines):
        stripped = line.strip()
        
        # コメント行をスキップ
        if stripped.startswith('//') and 'MathProblem' not in line:
            continue
            
        # 文字列内の処理
        for char in line:
            if char in ['"', "'"] and (i == 0 or line[i-1] != '\\'):
                if not in_string:
                    in_string = True
                    string_char = char
                elif char == string_char:
                    in_string = False
                    string_char = None
            
            if in_string:
                continue
                
            if char == '(':
                paren_count += 1
            elif char == ')':
                paren_count -= 1
            elif char == '{':
                brace_count += 1
            elif char == '}':
                brace_count -= 1
        
        if 'MathProblem(' in line and not stripped.startswith('//'):
            in_problem = True
            problem_lines = [line]
            # カウントをリセット
            paren_count = line.count('(') - line.count(')')
            brace_count = line.count('{') - line.count('}')
        elif in_problem:
            problem_lines.append(line)
            paren_count += line.count('(') - line.count(')')
            brace_count += line.count('{') - line.count('}')
            
            # 問題ブロックの終了判定
            if paren_count == 0 and brace_count == 0 and (line.strip().endswith('),') or line.strip().endswith(');')):
                problem_text = '\n'.join(problem_lines)
                
                # 問題情報を抽出
                id_match = re.search(r'id:\s*"([^"]+)"', problem_text)
                no_match = re.search(r'no:\s*(\d+)', problem_text)
                category_match = re.search(r"category:\s*'([^']+)'", problem_text)
                level_match = re.search(r"level:\s*'([^']+)'", problem_text)
                
                # questionとanswerは複数行にまたがる可能性がある
                question_match = re.search(r'question:\s*r?"""(.*?)"""', problem_text, re.DOTALL)
                if not question_match:
                    question_match = re.search(r'question:\s*r?"([^"]*)"', problem_text)
                
                answer_match = re.search(r'answer:\s*r?"""(.*?)"""', problem_text, re.DOTALL)
                if not answer_match:
                    answer_match = re.search(r'answer:\s*r?"([^"]*)"', problem_text)
                
                # stepsの有無を確認
                has_steps = 'StepItem' in problem_text or 'steps:' in problem_text
                
                if id_match and no_match:
                    problems.append({
                        'id': id_match.group(1),
                        'no': int(no_match.group(1)),
                        'category': category_match.group(1) if category_match else '不明',
                        'level': level_match.group(1) if level_match else '不明',
                        'question': question_match.group(1).strip() if question_match else '',
                        'answer': answer_match.group(1).strip() if answer_match else '',
                        'has_steps': has_steps,
                        'file': os.path.basename(file_path),
                        'line': i - len(problem_lines) + 1
                    })
                
                in_problem = False
                problem_lines = []
                paren_count = 0
                brace_count = 0
    
    return problems

def verify_problem(problem):
    """個別の問題を検証"""
    issues = []
    
    # 基本的なチェック
    if not problem['question']:
        issues.append("問題文が空")
    if not problem['answer']:
        issues.append("答えが空")
    if not problem['has_steps']:
        issues.append("解法ステップがない")
    
    return issues

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
            problems = extract_full_problem(str(full_path))
            for p in problems:
                p['category_type'] = category_type
            all_problems.extend(problems)
    
    print(f"全問題数: {len(all_problems)}問\n")
    print("=" * 80)
    print("全問題の検証結果")
    print("=" * 80)
    print()
    
    total_issues = 0
    for i, p in enumerate(all_problems, 1):
        issues = verify_problem(p)
        status = "✓" if not issues else "✗"
        
        print(f"{i}. [{status}] [{p['category_type']}] {p['file']} - No.{p['no']} ({p['category']}, {p['level']})")
        if issues:
            print(f"   警告: {', '.join(issues)}")
            total_issues += len(issues)
        print(f"   問題: {p['question'][:60]}..." if len(p['question']) > 60 else f"   問題: {p['question']}")
        print(f"   答え: {p['answer'][:60]}..." if len(p['answer']) > 60 else f"   答え: {p['answer']}")
        print()
    
    print("=" * 80)
    print(f"検証完了: {len(all_problems)}問中、{total_issues}個の警告")
    print("=" * 80)

if __name__ == '__main__':
    main()

