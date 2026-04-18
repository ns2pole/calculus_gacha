#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# graphgenerator_squeeze_limits.py
# はさみうちの原理問題のグラフ生成

import os
import math
import numpy as np
from limit_common import plot_limit_function, plot_limit_sequence

# はさみうちの原理問題の関数定義
def x_sin_one_over_x(x):
    """x sin(1/x) の関数"""
    with np.errstate(all='ignore'):
        return np.where(x != 0, x * np.sin(1/x), 0)

def log_one_plus_x_minus_x_plus_half_x_squared_over_x_cubed(x):
    """(log(1+x) - x + x²/2)/x³ の関数"""
    with np.errstate(all='ignore'):
        return np.where(x != 0, (np.log(1 + x) - x + x**2/2) / x**3, 1/3)

def two_to_n_over_n_factorial(n):
    """2^n / n! の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            if n <= 0:
                return 0
            result = 1
            for i in range(1, int(n) + 1):
                result *= 2 / i
            return result
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    temp = 1
                    for j in range(1, int(ni) + 1):
                        temp *= 2 / j
                    result[i] = temp
            return result

def one_over_n_times_sum_of_one_over_k(n):
    """(1/n) Σ(1/k) の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(1, n + 1, 1)
            return np.sum(1/k) / n
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(1, int(ni) + 1, 1)
                    result[i] = np.sum(1/k) / ni
            return result

def one_over_n_times_sum_of_one_over_k_squared(n):
    """(1/n) Σ(1/k²) の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(1, n + 1, 1)
            return np.sum(1/k**2) / n
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(1, int(ni) + 1, 1)
                    result[i] = np.sum(1/k**2) / ni
            return result

def one_over_n_times_sum_of_sin_k_over_n(n):
    """(1/n) Σ sin(k/n) の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(1, n + 1, 1)
            return np.sum(np.sin(k/n)) / n
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(1, int(ni) + 1, 1)
                    result[i] = np.sum(np.sin(k/ni)) / ni
            return result

def one_over_n_times_sum_of_cos_k_over_n(n):
    """(1/n) Σ cos(k/n) の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(1, n + 1, 1)
            return np.sum(np.cos(k/n)) / n
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(1, int(ni) + 1, 1)
                    result[i] = np.sum(np.cos(k/ni)) / ni
            return result

# 問題定義
PROBLEMS = [
    {
        "question": r"""$f(x) = x\sin\!\left(\frac{1}{x}\right)$""",
        "func": x_sin_one_over_x,
        "filename": "problem_1.png",
        "x_min": -0.5,
        "x_max": 0.5,
        "limit_point": 0,
        "limit_value": 0,
        "xlabel": "x", "ylabel": "f(x)",
        "blue_label": r"$x\sin\left(\frac{1}{x}\right)$",
        "red_label": "0"
    },
    {
        "question": r"""$a_n = \frac{2^{n}}{n!}$""",
        "func": two_to_n_over_n_factorial,
        "filename": "problem_2.png",
        "n_min": 1,
        "n_max": 20,
        "limit_value": 0,  # 0に収束
        "is_sequence": True,
        "blue_label": r"$\frac{2^{n}}{n!}$",
        "red_label": "0"
    },
    {
        "question": r"""$f(x) = \frac{\log(\cos x)}{x^2}$""",
        "func": lambda x: np.where(x != 0, np.log(np.cos(x)) / x**2, -0.5),
        "filename": "problem_3.png",
        "x_min": -0.5,
        "x_max": 0.5,
        "limit_point": 0,
        "limit_value": -0.5,
        "xlabel": "x", "ylabel": "f(x)",
        "blue_label": r"$\frac{\log(\cos x)}{x^2}$",
        "red_label": r"$-\frac{1}{2}$"
    },
    {
        "question": r"""$f(x) = \frac{\log(1+x) - x + \frac{x^2}{2}}{x^3}$""",
        "func": lambda x: np.where(x != 0, (np.log(1+x) - x + x**2/2) / x**3, 1/3),
        "filename": "problem_4.png",
        "x_min": -0.5,
        "x_max": 0.5,
        "limit_point": 0,
        "limit_value": 1/3,
        "xlabel": "x", "ylabel": "f(x)",
        "blue_label": r"$\frac{\log(1+x) - x + \frac{x^2}{2}}{x^3}$",
        "red_label": r"$\frac{1}{3}$"
    },
    {
        "question": r"""$a_n = \displaystyle \sum_{k=1}^{2n}\frac{1}{k} - \displaystyle \sum_{k=1}^{n}\frac{1}{k}$""",
        "func": lambda n: np.array([sum(1/k for k in range(1, 2*int(ni)+1)) - sum(1/k for k in range(1, int(ni)+1)) for ni in n]) if not np.isscalar(n) else sum(1/k for k in range(1, 2*int(n)+1)) - sum(1/k for k in range(1, int(n)+1)),
        "filename": "problem_5.png",
        "n_min": 1,
        "n_max": 50,
        "limit_value": np.log(2),
        "is_sequence": True,
        "blue_label": r"$\displaystyle \sum_{k=1}^{2n}\frac{1}{k} - \displaystyle \sum_{k=1}^{n}\frac{1}{k}$",
        "red_label": r"$\log 2 \fallingdotseq 0.693$",
        "legend_loc": "lower right"
    },
    {
        "question": r"""$f(x) = \frac{|\sin x|}{x}$""",
        "func": lambda x: np.where(x != 0, np.abs(np.sin(x)) / x, np.nan),
        "filename": "problem_6.png",
        "x_min": -0.5,
        "x_max": 0.5,
        "limit_point": 0,
        "limit_value": np.nan,  # 極限は存在しない
        "xlabel": "x", "ylabel": "f(x)",
        "blue_label": r"$\frac{|\sin x|}{x}$",
        "red_label": "極限は存在しない"
    }
]

def main():
    """メイン実行関数"""
    # 出力ディレクトリを作成
    output_dir = "../../../assets/graphs/limit/problems_squeeze_limits"
    os.makedirs(output_dir, exist_ok=True)
    
    print("はさみうちの原理問題のグラフを生成中...")
    
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
                xlabel=problem['xlabel'],
                ylabel=problem['ylabel'],
                blue_label=problem.get('blue_label'),
                red_label=problem.get('red_label'),
                legend_loc=problem.get('legend_loc', 'upper right')
            )
    
    print(f"完了！{len(PROBLEMS)}個のグラフを生成しました。")
    print(f"出力先: {output_dir}")

if __name__ == "__main__":
    main()
