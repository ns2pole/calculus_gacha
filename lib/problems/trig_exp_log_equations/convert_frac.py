#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
\fracの表示ルールを適用するスクリプト
- 通常の\fracは\displaystyle\fracに変更
- ^や_の中の\fracで、分母や分子がさらに分数の場合は\displaystyleを付けない
"""

import re
import sys

def has_nested_frac(text, start_pos):
    """指定位置から始まる\fracの分母や分子に\fracが含まれているかチェック"""
    # \frac{...}{...}の構造を解析
    depth = 0
    brace_count = 0
    in_numerator = True
    numerator_start = None
    denominator_start = None
    
    i = start_pos + 5  # \fracの後
    if i >= len(text) or text[i] != '{':
        return False
    
    # 分子の開始
    i += 1
    numerator_start = i
    brace_count = 1
    
    # 分子の終了まで
    while i < len(text) and brace_count > 0:
        if text[i] == '{':
            brace_count += 1
        elif text[i] == '}':
            brace_count -= 1
        i += 1
    
    if i >= len(text) or text[i] != '{':
        return False
    
    # 分母の開始
    i += 1
    denominator_start = i
    brace_count = 1
    
    # 分母の終了まで
    while i < len(text) and brace_count > 0:
        if text[i] == '{':
            brace_count += 1
        elif text[i] == '}':
            brace_count -= 1
        i += 1
    
    # 分子と分母に\fracが含まれているかチェック
    numerator_text = text[numerator_start:denominator_start-1]
    denominator_text = text[denominator_start:i-1]
    
    return '\\frac' in numerator_text or '\\frac' in denominator_text

def process_frac_in_superscript_subscript(text):
    """^や_の中の\fracを処理"""
    result = []
    i = 0
    
    while i < len(text):
        # ^や_を探す
        if text[i] in ['^', '_']:
            result.append(text[i])
            i += 1
            
            # 次の文字が{かどうか
            if i < len(text) and text[i] == '{':
                # {から対応する}までを処理
                brace_start = i
                brace_count = 1
                i += 1
                
                while i < len(text) and brace_count > 0:
                    if text[i] == '{':
                        brace_count += 1
                    elif text[i] == '}':
                        brace_count -= 1
                    i += 1
                
                # この範囲内の\fracを処理
                inner_text = text[brace_start+1:i-1]
                processed_inner = process_fracs(inner_text, in_superscript=True)
                result.append('{' + processed_inner + '}')
            else:
                # 単一文字
                if i < len(text):
                    result.append(text[i])
                    i += 1
        else:
            result.append(text[i])
            i += 1
    
    return ''.join(result)

def process_fracs(text, in_superscript=False):
    """\fracを処理"""
    result = []
    i = 0
    
    while i < len(text):
        # \fracを探す
        if i + 4 < len(text) and text[i:i+5] == '\\frac':
            # \fracが見つかった
            if in_superscript:
                # ^や_の中の場合、ネストされた分数かチェック
                if has_nested_frac(text, i):
                    # ネストされた分数の場合は\displaystyleを付けない
                    result.append('\\frac')
                    i += 5
                else:
                    # ネストされていない場合は\displaystyleを付ける
                    result.append('\\displaystyle\\frac')
                    i += 5
            else:
                # 通常の場合は\displaystyleを付ける
                result.append('\\displaystyle\\frac')
                i += 5
        else:
            result.append(text[i])
            i += 1
    
    return ''.join(result)

def convert_file(input_file, output_file):
    """ファイルを変換"""
    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # まず^や_の中を処理
    # 正規表現で^や_の中を抽出して処理
    def replace_superscript_subscript(match):
        prefix = match.group(1)  # ^または_
        brace_content = match.group(2)  # { }の中身
        processed = process_fracs(brace_content, in_superscript=True)
        return prefix + '{' + processed + '}'
    
    # ^{...}や_{...}のパターンを処理
    pattern = r'([\^_])\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}'
    content = re.sub(pattern, replace_superscript_subscript, content)
    
    # 通常の\fracを処理（^や_の中以外）
    # これは複雑なので、より単純なアプローチを取る
    # まず全ての\fracを\displaystyle\fracに変更
    content = re.sub(r'\\frac', r'\\displaystyle\\frac', content)
    
    # 次に、^や_の中のネストされた分数の\displaystyleを削除
    # ^{...}や_{...}の中を探す
    def remove_displaystyle_from_nested(match):
        prefix = match.group(1)
        inner = match.group(2)
        # ネストされた\frac（分母や分子に\fracがある）の\displaystyleを削除
        # \displaystyle\frac{...\frac...}{...} や \displaystyle\frac{...}{...\frac...} のパターン
        inner = re.sub(r'\\displaystyle\\frac\{([^{}]*\\frac[^{}]*)\}', r'\\frac{\1}', inner)
        inner = re.sub(r'\\displaystyle\\frac\{[^{}]*\}\{([^{}]*\\frac[^{}]*)\}', r'\\frac{\1}', inner)
        # より正確に処理する必要があるが、簡略化
        return prefix + '{' + inner + '}'
    
    # より正確な処理のために、再度パターンマッチング
    pattern = r'([\^_])\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}'
    def process_nested_fracs(match):
        prefix = match.group(1)
        inner = match.group(2)
        # ネストされた\fracの\displaystyleを削除
        # \displaystyle\frac{...\frac...}{...} のパターン
        def remove_displaystyle(m):
            frac_content = m.group(0)
            # 分母や分子に\fracがある場合は\displaystyleを削除
            if '\\frac' in frac_content.replace('\\displaystyle\\frac', '', 1):
                return frac_content.replace('\\displaystyle\\frac', '\\frac', 1)
            return frac_content
        inner = re.sub(r'\\displaystyle\\frac\{[^{}]*(?:\{[^{}]*\}[^{}]*)*\}\{[^{}]*(?:\{[^{}]*\}[^{}]*)*\}', remove_displaystyle, inner)
        return prefix + '{' + inner + '}'
    
    content = re.sub(pattern, process_nested_fracs, content)
    
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"変換完了: {input_file} -> {output_file}")

if __name__ == '__main__':
    input_file = 'trig_exp_log_equations.dart'
    output_file = 'trig_exp_log_equations.dart'
    convert_file(input_file, output_file)

