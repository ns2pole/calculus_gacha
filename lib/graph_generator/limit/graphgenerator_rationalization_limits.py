#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# graphgenerator_rationalization_limits.py
# 有理化問題のグラフ生成

import os
import math
import numpy as np
from limit_common import plot_limit_function, plot_limit_sequence

# 有理化問題の関数定義
def sqrt_1_plus_2x_minus_sqrt_1_plus_x_over_x(x):
    """(√(1+2x) - √(1+x))/x の関数"""
    with np.errstate(all='ignore'):
        return np.where(x != 0, (np.sqrt(1 + 2*x) - np.sqrt(1 + x)) / x, 0.5)

def sqrt_1_plus_x_minus_1_over_x(x):
    """(√(1+x) - 1)/x の関数"""
    with np.errstate(all='ignore'):
        return np.where(x != 0, (np.sqrt(1 + x) - 1) / x, 0.5)

def sqrt_1_plus_ax_minus_sqrt_1_plus_bx_over_x(x, a=2, b=3):
    """(√(1+ax) - √(1+bx))/x の関数"""
    with np.errstate(all='ignore'):
        return np.where(x != 0, (np.sqrt(1 + a*x) - np.sqrt(1 + b*x)) / x, (a-b)/2)

def sqrt_1_plus_x_minus_sqrt_1_minus_x_over_x(x):
    """(√(1+x) - √(1-x))/x の関数"""
    with np.errstate(all='ignore'):
        return np.where(x != 0, (np.sqrt(1 + x) - np.sqrt(1 - x)) / x, 1.0)

def sqrt_1_plus_x_minus_sqrt_1_minus_x_over_sin_x(x):
    """(√(1+x) - √(1-x))/sin(x) の関数"""
    with np.errstate(all='ignore'):
        return np.where(x != 0, (np.sqrt(1 + x) - np.sqrt(1 - x)) / np.sin(x), 1.0)

def sqrt_n_squared_plus_n_minus_n(n):
    """√(n²+n) - n の数列"""
    with np.errstate(all='ignore'):
        # 数値的安定性のため、有理化した形を使用
        # √(n²+n) - n = n / (√(n²+n) + n)
        return n / (np.sqrt(n**2 + n) + n)

def n_times_sqrt_n_squared_plus_n_minus_n(n):
    """n(√(n²+n) - n) の数列"""
    with np.errstate(all='ignore'):
        return n * (np.sqrt(n**2 + n) - n)

def n_times_sqrt_n_plus_1_minus_sqrt_n(n):
    """n(√(n+1) - √n) の数列"""
    with np.errstate(all='ignore'):
        return n * (np.sqrt(n + 1) - np.sqrt(n))

def sqrt_n_comparison(n):
    """√n の比較関数"""
    with np.errstate(all='ignore'):
        return np.sqrt(n)

# 問題定義
PROBLEMS = [
    {
        "question": r"""\displaystyle \lim_{x\to 0}\frac{\sqrt{1+2x}-\sqrt{1+x}}{x}""",
        "func": sqrt_1_plus_2x_minus_sqrt_1_plus_x_over_x,
        "filename": "problem_1.png",
        "x_min": -1,
        "x_max": 1,
        "limit_point": 0,
        "limit_value": 0.5,
        "blue_label": r"$\frac{\sqrt{1+2x}-\sqrt{1+x}}{x}$",
        "red_label": r"$\frac{1}{2}$"
    },
    {
        "question": r"""\displaystyle \lim_{x\to 0}\frac{\sqrt{1+x}-1}{x}""",
        "func": sqrt_1_plus_x_minus_1_over_x,
        "filename": "problem_2.png",
        "x_min": -1,
        "x_max": 1,
        "limit_point": 0,
        "limit_value": 0.5,
        "blue_label": r"$\frac{\sqrt{1+x}-1}{x}$",
        "red_label": r"$\frac{1}{2}$"
    },
    {
        "question": r"""\displaystyle \lim_{x\to 0}\frac{\sqrt{1+x}-\sqrt{1-x}}{x}""",
        "func": sqrt_1_plus_x_minus_sqrt_1_minus_x_over_x,
        "filename": "problem_3.png",
        "x_min": -1,
        "x_max": 1,
        "limit_point": 0,
        "limit_value": 1.0,
        "blue_label": r"$\frac{\sqrt{1+x}-\sqrt{1-x}}{x}$",
        "red_label": "1"
    },
    {
        "question": r"""\displaystyle \lim_{x\to 0}\frac{\sqrt{1+x}-\sqrt{1-x}}{\sin x}""",
        "func": sqrt_1_plus_x_minus_sqrt_1_minus_x_over_sin_x,
        "filename": "problem_5.png",
        "x_min": -1,
        "x_max": 1,
        "limit_point": 0,
        "limit_value": 1.0,
        "blue_label": r"$\frac{\sqrt{1+x}-\sqrt{1-x}}{\sin x}$",
        "red_label": "1"
    },
    {
        "question": r"""\displaystyle \lim_{n\to\infty}\Bigl(\sqrt{n^{2}+n}-n\Bigr)""",
        "func": sqrt_n_squared_plus_n_minus_n,
        "filename": "problem_6.png",
        "n_min": 1,
        "n_max": 50,
        "limit_value": 0.5,
        "is_sequence": True,
        "blue_label": r"$\sqrt{n^{2}+n}-n$",
        "red_label": r"$\frac{1}{2}$",
        "legend_loc": "lower right"
    },
    {
        "question": r"""\displaystyle \lim_{n\to\infty} n\left(\sqrt{n^2+n}-n\right)""",
        "func": n_times_sqrt_n_squared_plus_n_minus_n,
        "filename": "problem_7.png",
        "n_min": 1,
        "n_max": 50,
        "is_sequence": True,
        "blue_label": r"$n(\sqrt{n^2+n}-n)$",
        "red_label": r"$\frac{1}{2}$"
    },
    {
        "question": r"""\displaystyle \lim_{n\to\infty} n\!\left(\sqrt{n+1}-\sqrt{n}\right)""",
        "func": n_times_sqrt_n_plus_1_minus_sqrt_n,
        "filename": "problem_8.png",
        "n_min": 1,
        "n_max": 50,
        "is_sequence": True,
        "comparison_func": sqrt_n_comparison,
        "comparison_label": "$\\sqrt{n}$",
        "blue_label": r"$n(\sqrt{n+1}-\sqrt{n})$",
        "red_label": r"$\frac{1}{2}$"
    }
]

def main():
    """メイン実行関数"""
    # 出力ディレクトリを作成
    output_dir = "../../../assets/graphs/limit/problems_rationalization_limits"
    os.makedirs(output_dir, exist_ok=True)
    
    print("有理化問題のグラフを生成中...")
    
    for i, problem in enumerate(PROBLEMS, 1):
        print(f"問題 {i}: {problem['filename']}")
        
        out_path = os.path.join(output_dir, problem['filename'])
        
        if problem.get('is_sequence', False):
            # 数列の極限問題
            plot_limit_sequence(
                func=problem['func'],
                tex=problem['question'],
                out_path=out_path,
                n_min=problem['n_min'],
                n_max=problem['n_max'],
                show_limit_value=True,
                limit_value=problem.get('limit_value'),
                comparison_func=problem.get('comparison_func'),
                comparison_label=problem.get('comparison_label'),
                blue_label=problem.get('blue_label'),
                red_label=problem.get('red_label'),
                legend_loc=problem.get('legend_loc', 'upper right')
            )
        else:
            # 関数の極限問題
            plot_limit_function(
                func=problem['func'],
                tex=problem['question'],
                out_path=out_path,
                x_min=problem['x_min'],
                x_max=problem['x_max'],
                limit_point=problem['limit_point'],
                limit_value=problem['limit_value'],
                blue_label=problem.get('blue_label'),
                red_label=problem.get('red_label'),
                legend_loc=problem.get('legend_loc', 'upper right')
            )
    
    print(f"完了！{len(PROBLEMS)}個のグラフを生成しました。")
    print(f"出力先: {output_dir}")

if __name__ == "__main__":
    main()
