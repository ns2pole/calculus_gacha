#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
三角関数極限問題のグラフ生成器
"""

import sys
import os
import math
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from limit_common import plot_limit_function
import numpy as np
import matplotlib.pyplot as plt

def tan_x_over_x(x):
    """tan(x) / x の関数"""
    with np.errstate(all='ignore'):
        return np.tan(x) / x

def one_minus_cos_x_over_x_squared(x):
    """(1 - cos(x)) / x^2 の関数"""
    with np.errstate(all='ignore'):
        return (1 - np.cos(x)) / (x**2)

def sin_x_over_x(x):
    """sin(x) / x の関数"""
    with np.errstate(all='ignore'):
        return np.sin(x) / x

def cos_x_minus_one_over_x(x):
    """(cos(x) - 1) / x の関数"""
    with np.errstate(all='ignore'):
        return (np.cos(x) - 1) / x

def sin_x_minus_x_over_x_cubed(x):
    """(sin(x) - x) / x^3 の関数"""
    with np.errstate(all='ignore'):
        return (np.sin(x) - x) / (x**3)

def tan_x_minus_x_over_x_cubed(x):
    """(tan(x) - x) / x^3 の関数"""
    with np.errstate(all='ignore'):
        return (np.tan(x) - x) / (x**3)

def sin_pi_k_over_n_sum(n):
    """(1/n) Σ sin(πk/n) の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(1, n + 1, 1)
            return np.sum(np.sin(np.pi * k / n)) / n
        else:
            # 配列の場合
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(1, int(ni) + 1, 1)
                    result[i] = np.sum(np.sin(np.pi * k / ni)) / ni
            return result

def cos_pi_k_over_n_sum(n):
    """(1/n) Σ cos(πk/n) の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(1, n + 1, 1)
            return np.sum(np.cos(np.pi * k / n)) / n
        else:
            # 配列の場合
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(1, int(ni) + 1, 1)
                    result[i] = np.sum(np.cos(np.pi * k / ni)) / ni
            return result

def k_over_n_squared_sum(n):
    """(1/n) Σ k/n² の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(1, n + 1, 1)
            return np.sum(k / (n**2)) / n
        else:
            # 配列の場合
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(1, int(ni) + 1, 1)
                    result[i] = np.sum(k / (ni**2)) / ni
            return result

def k_squared_over_n_cubed_sum(n):
    """(1/n) Σ k²/n³ の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(1, n + 1, 1)
            return np.sum((k**2) / (n**3)) / n
        else:
            # 配列の場合
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(1, int(ni) + 1, 1)
                    result[i] = np.sum((k**2) / (ni**3)) / ni
            return result

def two_to_n_over_n_factorial(n):
    """2^n / n! の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            if n <= 0:
                return 0
            return (2**n) / np.math.factorial(int(n))
        else:
            # 配列の場合
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    result[i] = (2**ni) / math.factorial(int(ni))
            return result

def sin_a_plus_h_minus_sin_a_minus_h_over_2h(h, a=1):
    """sin(a+h) - sin(a-h) / (2h) の関数"""
    with np.errstate(all='ignore'):
        return np.where(h != 0, (np.sin(a + h) - np.sin(a - h)) / (2 * h), np.cos(a))

def cos_3x_tan_5x(x):
    """cos(3x)tan(5x) の関数"""
    with np.errstate(all='ignore'):
        return np.cos(3 * x) * np.tan(5 * x)

def problem_3_cos_3x_tan_5x():
    """問題3: lim x→π/2 cos(3x)tan(5x) = -3/5"""
    import math
    
    x_min, x_max = 1.0, 2.0
    limit_point = math.pi / 2
    limit_value = -3/5
    
    x = np.linspace(x_min, x_max, 1000)
    y = cos_3x_tan_5x(x)
    
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # 関数をプロット
    ax.plot(x, y, 'b-', linewidth=2, label=r'$\cos(3x)\tan(5x)$')
    
    # 極限値の水平線
    ax.axhline(y=limit_value, color='r', linestyle='--', alpha=0.7, label=r'$-\frac{3}{5}$')
    
    # 軸線
    ax.axhline(0.0, color='black', lw=1, zorder=1)
    ax.axvline(0.0, color='black', lw=1, zorder=1)
    
    ax.set_xlabel('x')
    ax.set_ylabel('f(x)')
    ax.set_title(r'$f(x) = \cos(3x)\tan(5x)$')
    ax.grid(True, alpha=0.3)
    ax.set_xlim(x_min, x_max)
    
    # y軸の範囲を適切に設定
    finite_y = y[~np.isnan(y) & ~np.isinf(y)]
    if finite_y.size > 0:
        y_min_val = float(np.min(finite_y))
        y_max_val = float(np.max(finite_y))
        margin = (y_max_val - y_min_val) * 0.15
        ax.set_ylim(y_min_val - margin, y_max_val + margin)
    
    # 既存の目盛を取得して、y=-3/5を追加
    y_ticks = list(ax.get_yticks())
    
    # y=-3/5を目盛に追加（まだ含まれていない場合）
    if limit_value not in y_ticks:
        y_ticks.append(limit_value)
        y_ticks.sort()
    
    # 目盛を設定
    ax.set_yticks(y_ticks)
    
    # 目盛ラベルのカスタマイズ（y=-3/5を特別に表示）
    y_labels = []
    for tick in y_ticks:
        if abs(tick - limit_value) < 0.01:  # y=-3/5の場合
            y_labels.append(r'$-\frac{3}{5}$')
        else:
            y_labels.append(f'${tick:.1f}$')
    
    ax.set_yticklabels(y_labels)
    
    # -3/5のラベルのフォントサイズを大きくする
    for i, tick in enumerate(y_ticks):
        if abs(tick - limit_value) < 0.01:
            ax.get_yticklabels()[i].set_fontsize(12)  # デフォルトより少し大きく
    
    ax.legend()
    plt.tight_layout()
    return fig

# 問題の定義（実際のtrigonometric_limits.dartに基づく）
# 有効な問題番号: 1, 2, 3, 4
PROBLEMS = [
    {
        'problem_no': 1,
        'func': one_minus_cos_x_over_x_squared,
        'tex': r'$f(x) = \frac{1-\cos x}{x^{2}}$',
        'x_min': -10, 'x_max': 10,
        'xlabel': 'x', 'ylabel': 'f(x)',
        'limit_point': 0, 'limit_value': 0.5,
        'is_sequence': False,
        'blue_label': r'$\frac{1-\cos x}{x^{2}}$',
        'red_label': r'$\frac{1}{2}$'
    },
    {
        'problem_no': 2,
        'func': lambda x: sin_a_plus_h_minus_sin_a_minus_h_over_2h(x, a=2),
        'tex': r'$f(x) = \frac{\sin(a+x)-\sin(a-x)}{2x} \quad (a=2)$',
        'x_min': -2, 'x_max': 2,
        'xlabel': 'x', 'ylabel': 'f(x)',
        'limit_point': 0, 'limit_value': np.cos(2),
        'is_sequence': False,
        'blue_label': r'$\frac{\sin(a+x)-\sin(a-x)}{2x}$',
        'red_label': r'$\cos 2 \fallingdotseq -0.416$'
    },
    {
        'problem_no': 3,
        'func': cos_3x_tan_5x,
        'tex': r'$f(x) = \cos(3x)\tan(5x)$',
        'x_min': 1.0, 'x_max': 2.0,
        'xlabel': 'x', 'ylabel': 'f(x)',
        'limit_point': np.pi/2, 'limit_value': -3/5,
        'is_sequence': False,
        'blue_label': r'$\cos(3x)\tan(5x)$',
        'red_label': r'$-\frac{3}{5}$'
    },
    {
        'problem_no': 4,
        'func': sin_pi_k_over_n_sum,
        'tex': r'$a_n = \frac{1}{n}\displaystyle \sum_{k=1}^{n}\sin\!\left(\frac{\pi k}{n}\right)$',
        'n_min': 1, 'n_max': 50,
        'limit_value': 2/np.pi,
        'is_sequence': True,
        'blue_label': r'$\frac{1}{n}\displaystyle \sum_{k=1}^{n}\sin\left(\frac{\pi k}{n}\right)$',
        'red_label': r'$\frac{2}{\pi} \fallingdotseq 0.637$',
        'legend_loc': 'lower right'
    }
]

def main():
    print("三角関数極限問題のグラフを生成中...")
    
    # 出力ディレクトリ
    output_dir = "../../../assets/graphs/limit/problems_trigonometric_limits"
    os.makedirs(output_dir, exist_ok=True)
    
    for problem in PROBLEMS:
        problem_no = problem['problem_no']
        print(f"問題 {problem_no}: problem_{problem_no}.png")
        
        if problem_no == 3:
            # 問題3は専用の関数を使用
            fig = problem_3_cos_3x_tan_5x()
            fig.savefig(f"{output_dir}/problem_{problem_no}.png", dpi=300, bbox_inches='tight')
            plt.close(fig)
        elif problem['is_sequence']:
            # 数列の場合
            from limit_common import plot_limit_sequence
            plot_limit_sequence(
                func=problem['func'],
                n_min=problem['n_min'],
                n_max=problem['n_max'],
                tex=problem['tex'],
                out_path=f"{output_dir}/problem_{problem_no}.png",
                limit_value=problem.get('limit_value'),
                blue_label=problem.get('blue_label'),
                red_label=problem.get('red_label'),
                legend_loc=problem.get('legend_loc', 'upper right')
            )
        else:
            # 関数の場合
            plot_limit_function(
                func=problem['func'],
                tex=problem['tex'],
                out_path=f"{output_dir}/problem_{problem_no}.png",
                x_min=problem['x_min'],
                x_max=problem['x_max'],
                xlabel=problem['xlabel'],
                ylabel=problem['ylabel'],
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