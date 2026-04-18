#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# graphgenerator_exponential_limits.py
# 指数関数極限問題のグラフ生成

import os
import math
import numpy as np
from limit_common import plot_limit_function, plot_limit_sequence

# 指数関数極限問題の関数定義（exponential_limits.dartの10問に対応）

def e_to_the_x_minus_1_over_x(x):
    """(e^x - 1)/x の関数"""
    with np.errstate(all='ignore'):
        return np.where(x != 0, (np.exp(x) - 1) / x, 1)

def one_plus_one_over_n_to_the_n(n):
    """(1 + 1/n)^n の数列"""
    with np.errstate(all='ignore'):
        return (1 + 1/n)**n

def one_plus_one_over_n_to_the_n_plus_1(n):
    """(1 + 1/n)^(n+1) の数列"""
    with np.errstate(all='ignore'):
        return (1 + 1/n)**(n + 1)

def one_plus_one_over_n_to_the_2n(n):
    """(1 + 1/n)^(2n) の数列"""
    with np.errstate(all='ignore'):
        return (1 + 1/n)**(2*n)

def n_times_one_plus_one_over_n_to_the_n_minus_e(n):
    """n((1 + 1/n)^n - e) の数列"""
    with np.errstate(all='ignore'):
        return n * ((1 + 1/n)**n - math.e)

def one_plus_three_over_n_to_the_n(n):
    """(1 + 3/n)^n の数列"""
    with np.errstate(all='ignore'):
        return (1 + 3/n)**n

def one_minus_one_over_n_to_the_n(n):
    """(1 - 1/n)^n の数列"""
    with np.errstate(all='ignore'):
        return (1 - 1/n)**n

def n_to_the_one_over_n(n):
    """n^(1/n) の数列"""
    with np.errstate(all='ignore'):
        return n**(1/n)

def n_times_log_one_plus_one_over_n_minus_one_over_n(n):
    """n(log(1 + 1/n) - 1/n) の数列"""
    with np.errstate(all='ignore'):
        return n * (np.log(1 + 1/n) - 1/n)

def n_times_log_one_plus_one_over_n(n):
    """n log(1 + 1/n) の数列"""
    with np.errstate(all='ignore'):
        return n * np.log(1 + 1/n)

# 問題定義（exponential_limits.dartの10問に対応）
PROBLEMS = [
    {
        "question": r"""\displaystyle \lim_{x\to 0}\frac{e^{x}-1}{x}""",
        "func": e_to_the_x_minus_1_over_x,
        "filename": "problem_1.png",
        "x_min": -2,
        "x_max": 2,
        "limit_point": 0,
        "limit_value": 1,
        "blue_label": r"$\frac{e^{x}-1}{x}$",
        "red_label": "1"
    },
    {
        "question": r"""\displaystyle \lim_{n\to\infty}\Bigl(1+\frac{1}{n}\Bigr)^{n}""",
        "func": one_plus_one_over_n_to_the_n,
        "filename": "problem_2.png",
        "n_min": 1,
        "n_max": 50,
        "limit_value": math.e,
        "is_sequence": True,
        "blue_label": r"$(1+\frac{1}{n})^{n}$",
        "red_label": r"$e \fallingdotseq 2.718$",
        "legend_loc": "lower right"
    },
    {
        "question": r"""\displaystyle \lim_{n\to\infty}\left(1+\frac{1}{n}\right)^{\,n+1}""",
        "func": one_plus_one_over_n_to_the_n_plus_1,
        "filename": "problem_3.png",
        "n_min": 1,
        "n_max": 50,
        "limit_value": math.e,
        "is_sequence": True,
        "blue_label": r"$\left(1+\frac{1}{n}\right)^{n+1}$",
        "red_label": r"$e \fallingdotseq 2.718$"
    },
    {
        "question": r"""\displaystyle \lim_{n\to\infty}\left(1+\frac{1}{n}\right)^{\,2n}""",
        "func": one_plus_one_over_n_to_the_2n,
        "filename": "problem_4.png",
        "n_min": 1,
        "n_max": 50,
        "limit_value": math.e**2,
        "is_sequence": True,
        "blue_label": r"$\left(1+\frac{1}{n}\right)^{2n}$",
        "red_label": r"$e^{2} \fallingdotseq 7.389$",
        "legend_loc": "lower right"
    },
    {
        "question": r"""\displaystyle \lim_{n\to\infty} n\!\left(\Bigl(1+\frac{1}{n}\Bigr)^{n}-e\right)""",
        "func": n_times_one_plus_one_over_n_to_the_n_minus_e,
        "filename": "problem_5.png",
        "n_min": 1,
        "n_max": 50,
        "limit_value": -math.e/2,
        "is_sequence": True,
        "blue_label": r"$n((1+\frac{1}{n})^{n}-e)$",
        "red_label": r"$-\frac{e}{2} \fallingdotseq -1.359$"
    },
    {
        "question": r"""\displaystyle \lim_{n\to\infty}\left(1+\frac{3}{n}\right)^{\,n}""",
        "func": one_plus_three_over_n_to_the_n,
        "filename": "problem_6.png",
        "n_min": 1,
        "n_max": 50,
        "limit_value": math.e**3,
        "is_sequence": True,
        "blue_label": r"$(1+\frac{3}{n})^{n}$",
        "red_label": r"$e^{3} \fallingdotseq 20.086$",
        "legend_loc": "lower right"
    },
    {
        "question": r"""\displaystyle \lim_{n\to\infty}\left(1-\frac{1}{n}\right)^{\,n}""",
        "func": one_minus_one_over_n_to_the_n,
        "filename": "problem_7.png",
        "n_min": 1,
        "n_max": 50,
        "limit_value": math.e**(-1),
        "is_sequence": True,
        "blue_label": r"$(1-\frac{1}{n})^{n}$",
        "red_label": r"$e^{-1} \fallingdotseq 0.368$"
    },
    {
        "question": r"""\displaystyle \lim_{n\to\infty}\sqrt[n]{n}""",
        "func": n_to_the_one_over_n,
        "filename": "problem_8.png",
        "n_min": 1,
        "n_max": 50,
        "limit_value": 1,
        "is_sequence": True
    },
    {
        "question": r"""\displaystyle \lim_{n\to\infty} n\!\left(\log\Bigl(1+\frac{1}{n}\Bigr)-\frac{1}{n}\right)""",
        "func": n_times_log_one_plus_one_over_n_minus_one_over_n,
        "filename": "problem_9.png",
        "n_min": 1,
        "n_max": 50,
        "limit_value": 0,
        "is_sequence": True,
        "blue_label": r"$n(\log(1+\frac{1}{n})-\frac{1}{n})$",
        "red_label": "0",
        "legend_loc": "lower right"
    },
    {
        "question": r"""\displaystyle \lim_{n\to\infty} n\,\log\!\left(1+\frac{1}{n}\right)""",
        "func": n_times_log_one_plus_one_over_n,
        "filename": "problem_10.png",
        "n_min": 1,
        "n_max": 50,
        "limit_value": 1,
        "is_sequence": True,
        "blue_label": r"$n\log(1+\frac{1}{n})$",
        "red_label": "1"
    }
]

def main():
    """メイン実行関数"""
    # 出力ディレクトリを作成
    output_dir = "../../../assets/graphs/limit/problems_exponential_limits"
    os.makedirs(output_dir, exist_ok=True)
    
    print("指数関数極限問題のグラフを生成中...")
    
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
