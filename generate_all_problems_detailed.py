#!/usr/bin/env python3
"""
全問題について、完全な問題と答えを記載したファイルを生成するスクリプト
（...で省略しない完全版）
"""
import re
import os
import sys
from pathlib import Path

def extract_problems_from_dart_file(file_path):
    """Dartファイルから問題を抽出"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"Error reading {file_path}: {e}", file=sys.stderr)
        return []
    
    problems = []
    lines = content.split('\n')
    in_problem = False
    problem_lines = []
    comment_depth = 0
    brace_depth = 0
    
    for i, line in enumerate(lines):
        stripped = line.strip()
        if stripped.startswith('//'):
            continue
        if '/*' in line:
            comment_depth += line.count('/*')
        if '*/' in line:
            comment_depth -= line.count('*/')
        if comment_depth > 0:
            continue
            
        line_for_counting = line
        if '),' in line:
            line_for_counting = line.replace('),', ') )')
        elif ');' in line:
            line_for_counting = line.replace(');', ') );')
        
        brace_depth += line_for_counting.count('(') - line_for_counting.count(')')
        
        if 'MathProblem(' in line and not stripped.startswith('//'):
            in_problem = True
            problem_lines = [line]
            if '),' in line:
                line_for_init = line.replace('),', ') )')
            elif ');' in line:
                line_for_init = line.replace(');', ') );')
            else:
                line_for_init = line
            brace_depth = line_for_init.count('(') - line_for_init.count(')')
        elif in_problem:
            problem_lines.append(line)
            
            is_end = False
            if brace_depth <= 0:
                stripped_line = line.strip()
                if stripped_line.endswith('),') or stripped_line.endswith(');'):
                    is_end = True
                elif stripped_line.endswith(')'):
                    if i + 1 < len(lines):
                        next_line = lines[i + 1].strip()
                        if next_line.startswith('];'):
                            is_end = True
                    elif i == len(lines) - 1:
                        is_end = True
            
            if is_end:
                problem_text = '\n'.join(problem_lines)
                
                id_match = re.search(r'id:\s*"([^"]+)"', problem_text)
                no_match = re.search(r'no:\s*(\d+|"[^"]+")', problem_text)
                category_match = re.search(r"category:\s*'([^']+)'", problem_text)
                question_match = re.search(r'question:\s*r?"""(.*?)"""', problem_text, re.DOTALL)
                if not question_match:
                    question_match = re.search(r'question:\s*r?"([^"]*)"', problem_text, re.DOTALL)
                answer_match = re.search(r'answer:\s*r?"""(.*?)"""', problem_text, re.DOTALL)
                if not answer_match:
                    answer_match = re.search(r'answer:\s*r?"([^"]*)"', problem_text, re.DOTALL)
                
                keywords_match = re.search(r'keywords:\s*\[(.*?)\]', problem_text, re.DOTALL)
                keywords = []
                if keywords_match:
                    keywords_text = keywords_match.group(1)
                    keywords = re.findall(r"'([^']+)'", keywords_text)
                
                if '大学' in keywords:
                    in_problem = False
                    problem_lines = []
                    brace_depth = 0
                    continue
                
                if id_match and (question_match or answer_match):
                    no_str = no_match.group(1) if no_match else '0'
                    if no_str.startswith('"'):
                        no_value = 1000 + int(re.search(r'\d+', no_str).group(0)) if re.search(r'\d+', no_str) else 0
                    else:
                        no_value = int(no_str) if no_match else 0
                    
                    problems.append({
                        'id': id_match.group(1),
                        'no': no_value,
                        'category': category_match.group(1) if category_match else '不明',
                        'question': question_match.group(1).strip() if question_match else '',
                        'answer': answer_match.group(1).strip() if answer_match else '',
                        'file': os.path.basename(file_path),
                    })
                in_problem = False
                problem_lines = []
                brace_depth = 0
    
    return problems

def extract_congruence_problems(file_path):
    """合同方程式問題を抽出（CongruenceProblem形式）"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"Error reading {file_path}: {e}", file=sys.stderr)
        return []
    
    problems = []
    lines = content.split('\n')
    in_problem = False
    problem_lines = []
    comment_depth = 0
    brace_depth = 0
    
    for i, line in enumerate(lines):
        stripped = line.strip()
        if stripped.startswith('//'):
            continue
        if '/*' in line:
            comment_depth += line.count('/*')
        if '*/' in line:
            comment_depth -= line.count('*/')
        if comment_depth > 0:
            continue
            
        brace_depth += line.count('(') - line.count(')')
        
        if 'CongruenceProblem(' in line and not stripped.startswith('//'):
            in_problem = True
            problem_lines = [line]
            brace_depth = line.count('(') - line.count(')')
        elif in_problem:
            problem_lines.append(line)
            brace_depth += line.count('(') - line.count(')')
            
            if brace_depth <= 0 and (line.strip().endswith('),') or line.strip().endswith(');')):
                problem_text = '\n'.join(problem_lines)
                
                id_match = re.search(r'id:\s*"([^"]+)"', problem_text)
                no_match = re.search(r'no:\s*(\d+)', problem_text)
                question_match = re.search(r'question:\s*r?"([^"]*)"', problem_text)
                answer_match = re.search(r'answer:\s*(\d+)', problem_text)
                modulus_match = re.search(r'modulus:\s*(\d+)', problem_text)
                
                if id_match and no_match and question_match and answer_match:
                    answer_value = int(answer_match.group(1))
                    modulus_value = int(modulus_match.group(1)) if modulus_match else None
                    answer_str = f"{answer_value}"
                    if modulus_value:
                        answer_str += f" \\pmod{{{modulus_value}}}"
                    
                    problems.append({
                        'id': id_match.group(1),
                        'no': int(no_match.group(1)),
                        'category': '合同方程式',
                        'question': question_match.group(1).strip(),
                        'answer': answer_str,
                        'file': os.path.basename(file_path),
                    })
                in_problem = False
                problem_lines = []
                brace_depth = 0
    
    return problems

def calculate_unit(expr, defs):
    """式から単位を計算"""
    # 複合単位のマッピング（1文字単位 → 基本単位）
    single_unit_map = {
        'J': {'kg': 1, 'm': 2, 's': -2},
        'N': {'kg': 1, 'm': 1, 's': -2},
        'W': {'kg': 1, 'm': 2, 's': -3},
        'Pa': {'kg': 1, 'm': -1, 's': -2},
        'Hz': {'s': -1},
        'C': {'A': 1, 's': 1},
        'V': {'kg': 1, 'm': 2, 's': -3, 'A': -1},
        'Ω': {'kg': 1, 'm': 2, 's': -3, 'A': -2},
        'F': {'kg': -1, 'm': -2, 's': 4, 'A': 2},
        'H': {'kg': 1, 'm': 2, 's': -2, 'A': -2},
        'T': {'kg': 1, 's': -2, 'A': -1},
        'Wb': {'kg': 1, 'm': 2, 's': -2, 'A': -1},
    }
    
    # 記号のマッピングを作成
    symbol_map = {}
    for def_item in defs:
        symbol = def_item['symbol']
        base_units_str = def_item.get('baseUnits', '')
        # baseUnitsをパース（例: "kg·m·s^-2" → {'kg': 1, 'm': 1, 's': -2}）
        units = {}
        if base_units_str:
            # · や * で分割
            parts = re.split(r'[·*]', base_units_str)
            for part in parts:
                part = part.strip()
                if not part:
                    continue
                # 累乗を抽出（例: "s^-2" → ('s', -2)）
                match = re.match(r'^([A-Za-z]+)(?:\^(-?\d+))?$', part)
                if match:
                    unit = match.group(1)
                    power_str = match.group(2)
                    power = int(power_str) if power_str else 1
                    units[unit] = power
        symbol_map[symbol] = units
    
    # 式をパース
    expr = expr.replace(' ', '')
    
    # 累乗を処理（例: v^2）
    power_map = {}
    power_regex = re.compile(r'(\w+)\^(\d+(?:\.\d+)?)')
    for match in power_regex.finditer(expr):
        symbol = match.group(1)
        power = float(match.group(2))
        power_map[symbol] = (power_map.get(symbol, 1.0) * power)
        expr = expr.replace(match.group(0), symbol)
    
    # 乗算と除算を処理
    parts = []
    operators = []
    current = ''
    for char in expr:
        if char in ['*', '/']:
            if current:
                parts.append(current)
                current = ''
            operators.append(char)
        else:
            current += char
    if current:
        parts.append(current)
    
    # 各記号の単位を取得して計算
    result_units = {}
    
    for i, part in enumerate(parts):
        if not part:
            continue
        
        # 数値定数をスキップ（例: 0.5, 2）
        if re.match(r'^\d+(\.\d+)?$', part):
            continue
        
        # 記号の単位を取得
        if part not in symbol_map:
            continue
        
        units = symbol_map[part].copy()
        
        # 累乗を適用
        power = power_map.get(part, 1.0)
        if power != 1.0:
            for unit_key in units:
                units[unit_key] = int(units[unit_key] * power)
        
        # 演算を適用
        if i == 0:
            result_units = units
        else:
            op = operators[i - 1] if i - 1 < len(operators) else '*'
            if op == '*':
                # 乗算
                for unit_key, value in units.items():
                    result_units[unit_key] = result_units.get(unit_key, 0) + value
            elif op == '/':
                # 除算
                for unit_key, value in units.items():
                    result_units[unit_key] = result_units.get(unit_key, 0) - value
    
    # 0の指数を削除
    result_units = {k: v for k, v in result_units.items() if v != 0}
    
    # 1文字単位に変換できるかチェック
    for single_unit, base_units in single_unit_map.items():
        if result_units == base_units:
            return single_unit
    
    # 基本単位系で返す
    if not result_units:
        return '1（無次元）'
    
    # kg, m, s, A の順にソート
    unit_order = ['kg', 'm', 's', 'A', 'K']
    parts = []
    for ordered_unit in unit_order:
        if ordered_unit in result_units:
            value = result_units[ordered_unit]
            if value == 1:
                parts.append(ordered_unit)
            elif value == -1:
                parts.append(f'{ordered_unit}^-1')
            else:
                parts.append(f'{ordered_unit}^{value}')
    # 順序にない単位も追加
    for unit_key in sorted(result_units.keys()):
        if unit_key not in unit_order:
            value = result_units[unit_key]
            if value == 1:
                parts.append(unit_key)
            elif value == -1:
                parts.append(f'{unit_key}^-1')
            else:
                parts.append(f'{unit_key}^{value}')
    
    return ' '.join(parts)

def extract_unit_problems(file_path):
    """単位問題を抽出（UnitProblem形式）"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"Error reading {file_path}: {e}", file=sys.stderr)
        return []
    
    problems = []
    lines = content.split('\n')
    in_problem = False
    problem_lines = []
    comment_depth = 0
    brace_depth = 0
    
    for i, line in enumerate(lines):
        stripped = line.strip()
        if stripped.startswith('//'):
            continue
        if '/*' in line:
            comment_depth += line.count('/*')
        if '*/' in line:
            comment_depth -= line.count('*/')
        if comment_depth > 0:
            continue
            
        brace_depth += line.count('(') - line.count(')')
        
        if 'UnitProblem(' in line and not stripped.startswith('//'):
            in_problem = True
            problem_lines = [line]
            brace_depth = line.count('(') - line.count(')')
        elif in_problem:
            problem_lines.append(line)
            brace_depth += line.count('(') - line.count(')')
            
            if brace_depth <= 0 and (line.strip().endswith('),') or line.strip().endswith(');')):
                problem_text = '\n'.join(problem_lines)
                
                prompt_match = re.search(r'promptJa:\s*"([^"]*)"', problem_text)
                expr_match = re.search(r'expr:\s*"([^"]*)"', problem_text)
                
                if prompt_match and expr_match:
                    expr = expr_match.group(1).strip()
                    
                    # SymbolDefを抽出
                    defs = []
                    # SymbolDefブロックを抽出
                    def_blocks = re.finditer(r'SymbolDef\([^)]+\)', problem_text)
                    for def_block in def_blocks:
                        def_text = def_block.group(0)
                        symbol_match = re.search(r'symbol:\s*"([^"]+)"', def_text)
                        base_units_match = re.search(r'baseUnits:\s*"([^"]*)"', def_text)
                        unit_symbol_match = re.search(r'unitSymbol:\s*"([^"]*)"', def_text)
                        if symbol_match:
                            defs.append({
                                'symbol': symbol_match.group(1),
                                'baseUnits': base_units_match.group(1) if base_units_match else '',
                                'unitSymbol': unit_symbol_match.group(1) if unit_symbol_match else ''
                            })
                    
                    # 単位を計算
                    if defs:
                        # 単一記号の場合はunitSymbolを優先
                        if len(defs) == 1 and expr == defs[0]['symbol']:
                            unit_symbol = defs[0].get('unitSymbol', '')
                            if unit_symbol:
                                answer = unit_symbol
                            else:
                                answer = calculate_unit(expr, defs)
                        else:
                            answer = calculate_unit(expr, defs)
                    else:
                        answer = expr + ' の単位'
                    
                    problems.append({
                        'id': f"unit_{len(problems)+1}",
                        'no': len(problems) + 1,
                        'category': '単位',
                        'question': prompt_match.group(1).strip(),
                        'answer': answer,
                        'file': os.path.basename(file_path),
                    })
                in_problem = False
                problem_lines = []
                brace_depth = 0
    
    return problems

def main():
    base_dir = Path('lib/problems')
    
    # ガチャごとのファイル定義
    gacha_files = {
        '積分ガチャ': [
            ('integrals/problems_abs_definite.dart', 'math'),
            ('integrals/problems_basic_formula.dart', 'math'),
            ('integrals/problems_beta_function.dart', 'math'),
            ('integrals/problems_curves.dart', 'math'),
            ('integrals/problems_exponential_fraction.dart', 'math'),
            ('integrals/problems_integration_by_parts.dart', 'math'),
            ('integrals/problems_linear_radical.dart', 'math'),
            ('integrals/problems_others.dart', 'math'),
            ('integrals/problems_polynomial_fraction.dart', 'math'),
            ('integrals/problems_quadratic_radical.dart', 'math'),
            ('integrals/problems_substitution.dart', 'math'),
            ('integrals/problems_trig_fraction.dart', 'math'),
            ('integrals/problems_trig_polynomial.dart', 'math'),
        ],
        '極限ガチャ': [
            ('limits/advanced_limits.dart', 'math'),
            ('limits/basic_limits.dart', 'math'),
            ('limits/exponential_limits.dart', 'math'),
            ('limits/famous_limits.dart', 'math'),
            ('limits/problems_e_limit_variations.dart', 'math'),
            ('limits/rationalization_limits.dart', 'math'),
            ('limits/riemann_limits.dart', 'math'),
            ('limits/squeeze_limits.dart', 'math'),
            ('limits/trigonometric_limits.dart', 'math'),
        ],
        '微分方程式ガチャ': [
            ('physics_math/uniform_acceleration_problems.dart', 'math'),
            ('physics_math/simple_harmonic_motion_problems.dart', 'math'),
            ('physics_math/first_order_exponential_problems.dart', 'math'),
            ('physics_math/second_order_no_damping_problems.dart', 'math'),
            ('physics_math/rlc_series_discharge_problems.dart', 'math'),
            ('physics_math/rlc_series_voltage_critical_problems.dart', 'math'),
            ('physics_math/rlc_series_voltage_overdamped_problems.dart', 'math'),
            ('physics_math/rlc_series_voltage_underdamped_problems.dart', 'math'),
        ],
        '因数分解ガチャ': [
            ('factorization/basic_factorization.dart', 'math'),
            ('factorization/basic_factorization_reserve.dart', 'math'),
            ('factorization/mid_factorization.dart', 'math'),
            ('factorization/mid_factorization_reserve.dart', 'math'),
            ('factorization/advanced_factorization.dart', 'math'),
            ('factorization/advanced_factorization_reserve.dart', 'math'),
        ],
        '不定方程式ガチャ': [
            ('indeterminate_equations/indeterminate_equations.dart', 'math'),
        ],
        'modガチャ': [
            ('congruence_equations/congruence_equations.dart', 'congruence'),
        ],
        '漸化式ガチャ': [
            ('sequences/sequences.dart', 'math'),
        ],
    }
    
    # ガチャごとに問題を集約
    gacha_problems = {}
    total_count = 0
    
    for gacha_name, file_list in gacha_files.items():
        gacha_problems[gacha_name] = []
        for file_path, file_type in file_list:
            full_path = base_dir / file_path
            if full_path.exists():
                if file_type == 'math':
                    problems = extract_problems_from_dart_file(str(full_path))
                elif file_type == 'congruence':
                    problems = extract_congruence_problems(str(full_path))
                else:
                    problems = []
                gacha_problems[gacha_name].extend(problems)
                print(f"{gacha_name} - {file_path}: {len(problems)}問", file=sys.stderr)
            else:
                print(f"Warning: {file_path} not found", file=sys.stderr)
        
        gacha_problems[gacha_name].sort(key=lambda x: (x['file'], x['no']))
        total_count += len(gacha_problems[gacha_name])
    
    # 出力ファイルに書き込み（all_problems_detailed.txt形式）
    output_file = 'all_problems_detailed.txt'
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("全問題の詳細リスト（完全版）\n")
        f.write("=" * 80 + "\n\n")
        
        problem_num = 1
        for gacha_name, problems in gacha_problems.items():
            if not problems:
                continue
            
            f.write(f"\n{'=' * 80}\n")
            f.write(f"【{gacha_name}】 ({len(problems)}問)\n")
            f.write(f"{'=' * 80}\n\n")
            
            for p in problems:
                f.write(f"{problem_num}. [{gacha_name}] {p['file']} - No.{p['no']} ({p['category']})\n")
                f.write(f"   問題: {p['question']}\n")
                f.write(f"   答え: {p['answer']}\n")
                f.write("\n")
                problem_num += 1
    
    print(f"\n全問題数: {total_count}問", file=sys.stderr)
    print(f"出力ファイル: {output_file}", file=sys.stderr)

if __name__ == '__main__':
    main()

