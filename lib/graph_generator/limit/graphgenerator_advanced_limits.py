#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
上級極限問題のグラフ生成器
"""

import sys
import os
import math
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from limit_common import plot_limit_function
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as patches

# 日本語フォントの設定
plt.rcParams['font.family'] = ['DejaVu Sans', 'Hiragino Sans', 'Yu Gothic', 'Meiryo', 'Takao', 'IPAexGothic', 'IPAPGothic', 'VL PGothic', 'Noto Sans CJK JP']

# フォント検索の警告を無効化
import warnings
import logging

# すべての警告を無効化
warnings.filterwarnings('ignore')
logging.getLogger('matplotlib.font_manager').setLevel(logging.ERROR)

# matplotlibのフォント検索警告を完全に無効化
import matplotlib
matplotlib.rcParams['font.family'] = ['DejaVu Sans']

def problem_20_sqrt_difference():
    """
    問題20: lim n→∞ n(√(n+1) - √n) = ∞
    不定形の解消の可視化
    """
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # 数列 n(√(n+1) - √n)
    n_values = np.arange(1, 16, 1)
    y_values = [n * (math.sqrt(n + 1) - math.sqrt(n)) for n in n_values]
    
    ax.plot(n_values, y_values, 'bo-', linewidth=2, markersize=4, label='$n(\\sqrt{n+1} - \\sqrt{n})$')
    
    # √n/2 の比較線を追加
    sqrt_n_over_2_values = [math.sqrt(n) / 2 for n in n_values]
    ax.plot(n_values, sqrt_n_over_2_values, 'r-', linewidth=2, label='$\\frac{\\sqrt{n}}{2}$')
    
    ax.set_xlabel('n')
    ax.set_ylabel('value')
    ax.set_title('$n(\\sqrt{n+1} - \\sqrt{n})$')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(1, 15)
    
    # x軸のメモリを1刻みで設定
    ax.set_xticks(range(1, 16))
    
    plt.tight_layout()
    return fig

def problem_21_exponential_vs_polynomial():
    """
    問題21: lim n→∞ n²/2ⁿ = 0
    指数関数と多項式の比較
    """
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # 数列 a_n = n²/2ⁿ
    n_values = np.arange(1, 16, 1)
    a_values = [(n**2) / (2**n) for n in n_values]
    
    ax.plot(n_values, a_values, 'ro-', linewidth=2, markersize=4, label='$a_n = \\frac{n^2}{2^n}$')
    ax.axhline(y=0, color='g', linestyle='--')
    ax.set_xlabel('n')
    ax.set_ylabel('$a_n$')
    ax.set_title('$\\frac{n^2}{2^n}$')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(0.5, 15.5)  # 左右に余裕を持たせる
    
    # x軸のメモリを1刻みで設定
    ax.set_xticks(range(1, 16))
    
    plt.tight_layout()
    return fig

def problem_21_ratio_analysis():
    """
    問題21: 比の評価 a_{n+1}/a_n
    """
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    n_values = np.arange(1, 16, 1)
    ratio_values = []
    
    for n in n_values:
        if n > 0:
            ratio = (1/2) * ((n + 1) / n) ** 2
            ratio_values.append(ratio)
        else:
            ratio_values.append(0)
    
    ax.plot(n_values, ratio_values, 'bo-', linewidth=2, markersize=4, label='$\\frac{a_{n+1}}{a_n}$')
    ax.axhline(y=0.75, color='g', linestyle='--', label='$r = \\frac{3}{4}$')
    ax.axhline(y=0.5, color='r', linestyle='--', label='$\\frac{1}{2}$')
    ax.set_xlabel('n')
    ax.set_ylabel('ratio value')
    ax.set_title('$\\frac{a_{n+1}}{a_n}$')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(1, 15)
    ax.set_ylim(0, 1)
    
    # x軸のメモリを1刻みで設定
    ax.set_xticks(range(1, 16))
    
    # y軸のメモリを0.1刻みで設定
    ax.set_yticks([i/10 for i in range(0, 11)])
    
    plt.tight_layout()
    return fig

def problem_21_squeeze_theorem():
    """
    問題21: はさみうちの定理の可視化
    """
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    n_values = np.arange(1, 16, 1)
    
    # 元の数列
    a_values = [(n**2) / (2**n) for n in n_values]
    
    # 上界: a_5 * (3/4)^(n-5) for n >= 5
    a_5 = (5**2) / (2**5)  # 25/32
    upper_bound = []
    for n in n_values:
        if n >= 5:
            upper_bound.append(a_5 * ((3/4) ** (n - 5)))
        else:
            upper_bound.append(a_values[n-1])  # n < 5 の場合は元の値
    
    # 下界（0）
    lower_bound = [0] * len(n_values)
    
    # プロット
    ax.plot(n_values, a_values, 'ro-', linewidth=2, markersize=4, label='$a_n = \\frac{n^2}{2^n}$')
    ax.plot(n_values, upper_bound, 'b--', linewidth=2, label='upper bound: $a_5 \\cdot (\\frac{3}{4})^{n-5}$')
    ax.plot(n_values, lower_bound, 'g--', linewidth=2, label='lower bound: $0$')
    
    # n=5の点を強調
    ax.plot([5], [a_5], 'ko', markersize=8, label='$a_5 = \\frac{25}{32}$')
    
    ax.set_xlabel('n')
    ax.set_ylabel('value')
    ax.set_title('Squeeze Theorem')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(1, 15)
    
    # x軸のメモリを1刻みで設定
    ax.set_xticks(range(1, 16))
    
    # 対数スケールで表示
    ax.set_yscale('log')
    
    # y軸のメモリを1刻みで設定（分数表記）
    import matplotlib.ticker as ticker
    ax.yaxis.set_major_formatter(ticker.FuncFormatter(lambda x, p: f'1/{int(1/x)}' if x < 1 and x > 0 else f'{x:.0f}'))
    ax.yaxis.set_major_locator(ticker.LogLocator(base=10, numticks=10))
    
    plt.tight_layout()
    return fig

def problem_1_polynomial_factorization():
    """問題1: lim x→1 (x^5 - 1)/(x - 1) = 5"""
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # 関数 (x^m - 1)/(x - 1) for m=5
    x = np.linspace(0.5, 1.5, 1000)
    x = x[x != 1]  # x=1を除外
    m = 5
    y = (x**m - 1) / (x - 1)
    
    ax.plot(x, y, 'b-', linewidth=2, label=f'$\\frac{{x^{{{m}}}-1}}{{x-1}}$')
    ax.axhline(y=m, color='r', linestyle='--', label=f'{m}')
    ax.set_xlabel('x')
    ax.set_ylabel('y')
    ax.set_title(f'$\\frac{{x^{{{m}}}-1}}{{x-1}}$ (m={m})')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(0.5, 1.5)
    
    plt.tight_layout()
    return fig

def problem_2_telescoping_series():
    """問題2: lim n→∞ ∑(k=1 to n) 1/(k(k+1)) = 1"""
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # 数列 1/(k(k+1)) の部分和
    n_values = np.arange(1, 16, 1)
    partial_sums = []
    for n in n_values:
        sum_val = sum(1/(k*(k+1)) for k in range(1, int(n)+1))
        partial_sums.append(sum_val)
    
    ax.plot(n_values, partial_sums, 'bo-', linewidth=2, markersize=4, label='$\\displaystyle \\sum_{k=1}^{n}\\frac{1}{k(k+1)}$')
    ax.axhline(y=1, color='r', linestyle='--', alpha=0.7)
    
    ax.set_xlabel('n')
    ax.set_ylabel('$a_n$')
    ax.set_title('$\\displaystyle \\sum_{k=1}^{n}\\frac{1}{k(k+1)}$')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(1, 15)
    
    # 縦方向の余裕を増やす
    y_min, y_max = min(partial_sums), max(partial_sums)
    y_range = y_max - y_min
    if y_range == 0:
        y_range = 0.1
    margin = 0.2 * y_range
    ax.set_ylim(y_min - margin, y_max + margin)
    
    plt.tight_layout()
    return fig

def problem_3_telescoping_series_offset():
    """問題3: lim n→∞ ∑(k=1 to n) 1/(k(k+2)) = 3/4"""
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # 数列 1/(k(k+2)) の部分和
    n_values = np.arange(1, 51, 1)
    partial_sums = []
    for n in n_values:
        sum_val = sum(1/(k*(k+2)) for k in range(1, int(n)+1))
        partial_sums.append(sum_val)
    
    ax.plot(n_values, partial_sums, 'bo-', linewidth=2, markersize=4, label='$\\displaystyle \\sum_{k=1}^{n}\\frac{1}{k(k+2)}$')
    ax.axhline(y=3/4, color='r', linestyle='--', alpha=0.7)
    
    ax.set_xlabel('n')
    ax.set_ylabel('$a_n$')
    ax.set_title('$\\displaystyle \\sum_{k=1}^{n}\\frac{1}{k(k+2)}$')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(1, 50)
    
    # 縦方向の余裕を増やす
    y_min, y_max = min(partial_sums), max(partial_sums)
    y_range = y_max - y_min
    if y_range == 0:
        y_range = 0.1
    margin = 0.2 * y_range
    ax.set_ylim(y_min - margin, y_max + margin)
    
    plt.tight_layout()
    return fig

def problem_4_factorial_vs_power():
    """問題4: lim n→∞ n!/n^n = 0"""
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # 数列 n!/n^n
    n_values = np.arange(1, 11, 1)  # 1刻みで10まで
    y_values = []
    for n in n_values:
        factorial = math.factorial(int(n))
        power = n**n
        y_values.append(factorial / power)
    
    ax.plot(n_values, y_values, 'bo-', linewidth=2, markersize=4, label='$\\frac{n!}{n^n}$')
    ax.axhline(y=0, color='r', linestyle='--', alpha=0.7)
    
    ax.set_xlabel('n')
    ax.set_ylabel('$a_n$')
    ax.set_title('$\\frac{n!}{n^n}$')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(1, 10)
    
    # x軸のメモリを1刻みで設定
    ax.set_xticks(range(1, 11))
    
    plt.tight_layout()
    return fig

def problem_5_log_vs_linear():
    """問題5: lim n→∞ log(n)/n = 0"""
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # 数列 log(n)/n
    n_values = np.arange(1, 201, 1)
    y_values = [math.log(n) / n for n in n_values]
    
    ax.plot(n_values, y_values, 'b.', markersize=2, label='$\\frac{\\log n}{n}$')
    ax.axhline(y=0, color='r', linestyle='--', alpha=0.7, label='0')
    
    ax.set_xlabel('n')
    ax.set_ylabel('value')
    ax.set_title('$\\frac{\\log n}{n}$')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(1, 200)
    
    plt.tight_layout()
    return fig

def problem_6_monotonic_convergence():
    """問題6: a_1 ∈ (0,1), a_{n+1} = √(a_n), lim a_n = 1"""
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # 漸化式 a_{n+1} = sqrt(a_n)
    n_values = np.arange(0, 16, 1)
    a_values = [0.5]  # 初期値
    for i in range(1, 16):
        a_values.append(math.sqrt(a_values[-1]))
    
    ax.plot(n_values, a_values, 'bo-', linewidth=2, markersize=4, label='$a_n$')
    ax.axhline(y=1, color='r', linestyle='--', alpha=0.7)
    
    ax.set_xlabel('n')
    ax.set_ylabel('$a_n$')
    ax.set_title('$a_{n+1} = \\sqrt{a_n}$ ($a_1 = 0.5$)')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(0, 15)
    
    plt.tight_layout()
    return fig

def problem_7_linear_recurrence():
    """問題7: a_1 ∈ ℝ, a_{n+1} = (a_n + 3)/4, lim a_n = 1"""
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # 漸化式 a_{n+1} = (a_n + 3)/4
    n_values = np.arange(0, 16, 1)
    a_values = [0]  # 初期値
    for i in range(1, 16):
        a_values.append((a_values[-1] + 3) / 4)
    
    ax.plot(n_values, a_values, 'bo-', linewidth=2, markersize=4, label='$a_n$')
    ax.axhline(y=1, color='r', linestyle='--', alpha=0.7)
    
    ax.set_xlabel('n')
    ax.set_ylabel('$a_n$')
    ax.set_title('$a_{n+1} = \\frac{a_n + 3}{4}$ ($a_1 = 0$)')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(0, 15)
    
    plt.tight_layout()
    return fig

def problem_10_log_over_x():
    """問題10: lim x→∞ log(x)/x = 0"""
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # 関数 log(x)/x (x=1から200まで)
    x = np.linspace(1, 200, 1000)
    y = np.log(x) / x
    
    ax.plot(x, y, 'b-', linewidth=2, label='$\\frac{\\log x}{x}$')
    ax.axhline(y=0, color='r', linestyle='--', alpha=0.7, label='0')
    
    ax.set_xlabel('x')
    ax.set_ylabel('value')
    ax.set_title('$\\frac{\\log x}{x}$')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(1, 200)
    
    plt.tight_layout()
    return fig

def problem_10_sqrt_minus_log():
    """問題10補足: f(x) = √x - log x のグラフ (x=0~30)"""
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # x=0.01から30まで（log(0)は定義されないため、小さな値から開始）
    x = np.linspace(0.01, 30, 1000)
    y = np.sqrt(x) - np.log(x)
    
    ax.plot(x, y, 'b-', linewidth=2, label='$f(x) = \\sqrt{x} - \\log x$')
    ax.axhline(y=0, color='r', linestyle='--', alpha=0.7, label='$y = 0$')
    
    # x=4の点を強調（最小値の点）
    x_min = 4
    y_min = math.sqrt(4) - math.log(4)
    
    ax.set_xlabel('x')
    ax.set_ylabel('$f(x)$')
    ax.set_title('$f(x) = \\sqrt{x} - \\log x$')
    ax.grid(True, alpha=0.3)
    ax.set_xlim(0, 30)
    
    # y軸の範囲を適切に設定
    y_min_val = min(y)
    y_max_val = max(y)
    margin = (y_max_val - y_min_val) * 0.1
    ax.set_ylim(y_min_val - margin, y_max_val + margin)
    
    # 既存の目盛を取得して、x=4とy=2-log2を追加
    x_ticks = list(ax.get_xticks())
    y_ticks = list(ax.get_yticks())
    
    # x=4を目盛に追加（まだ含まれていない場合）
    if x_min not in x_ticks:
        x_ticks.append(x_min)
        x_ticks.sort()
    
    # y=2-log2を目盛に追加（まだ含まれていない場合）
    if y_min not in y_ticks:
        y_ticks.append(y_min)
        y_ticks.sort()
    
    # 目盛を設定
    ax.set_xticks(x_ticks)
    ax.set_yticks(y_ticks)
    
    # 目盛ラベルのカスタマイズ（x=4とy=2-log2を特別に表示）
    x_labels = []
    for tick in x_ticks:
        if abs(tick - x_min) < 0.01:  # x=4の場合
            x_labels.append('$4$')
        else:
            x_labels.append(f'${tick:.0f}$' if tick == int(tick) else f'${tick:.1f}$')
    
    y_labels = []
    for tick in y_ticks:
        if abs(tick - y_min) < 0.01:  # y=2-log2の場合
            y_labels.append('$2-\\log 2$')
        else:
            y_labels.append(f'${tick:.1f}$')
    
    ax.set_xticklabels(x_labels)
    ax.set_yticklabels(y_labels)
    
    # x=4の点をプロット
    ax.plot([x_min], [y_min], 'ro', markersize=8)
    
    ax.legend()
    
    plt.tight_layout()
    return fig

def main():
    """メイン実行関数"""
    # 出力ディレクトリを作成
    output_dir = "../../../assets/graphs/limit/problems_advanced_limits"
    os.makedirs(output_dir, exist_ok=True)
    
    print("上級極限問題のグラフを生成中...")
    
    # 問題1: 因数分解／等比和
    print("1. 問題1のグラフを生成中...")
    fig1 = problem_1_polynomial_factorization()
    fig1.savefig(os.path.join(output_dir, 'problem_1.png'), dpi=300, bbox_inches='tight')
    plt.close(fig1)
    
    # 問題2: 望遠和（テレスコープ）
    print("2. 問題2のグラフを生成中...")
    fig2 = problem_2_telescoping_series()
    fig2.savefig(os.path.join(output_dir, 'problem_2.png'), dpi=300, bbox_inches='tight')
    plt.close(fig2)
    
    # 問題3: 望遠和（ズレ2）
    print("3. 問題3のグラフを生成中...")
    fig3 = problem_3_telescoping_series_offset()
    fig3.savefig(os.path.join(output_dir, 'problem_3.png'), dpi=300, bbox_inches='tight')
    plt.close(fig3)
    
    # 問題4: 比較（階乗と多項式）
    print("4. 問題4のグラフを生成中...")
    fig4 = problem_4_factorial_vs_power()
    fig4.savefig(os.path.join(output_dir, 'problem_4.png'), dpi=300, bbox_inches='tight')
    plt.close(fig4)
    
    # 問題5: 比較（対数と一次）
    print("5. 問題5のグラフを生成中...")
    fig5 = problem_5_log_vs_linear()
    fig5.savefig(os.path.join(output_dir, 'problem_5.png'), dpi=300, bbox_inches='tight')
    plt.close(fig5)
    
    # 問題6: 単調収束（漸化式）
    print("6. 問題6のグラフを生成中...")
    fig6 = problem_6_monotonic_convergence()
    fig6.savefig(os.path.join(output_dir, 'problem_6.png'), dpi=300, bbox_inches='tight')
    plt.close(fig6)
    
    # 問題7: 一次漸化式（等比化）
    print("7. 問題7のグラフを生成中...")
    fig7 = problem_7_linear_recurrence()
    fig7.savefig(os.path.join(output_dir, 'problem_7.png'), dpi=300, bbox_inches='tight')
    plt.close(fig7)
    
    # 問題8: 不定形の解消
    print("8. 問題8のグラフを生成中...")
    fig8 = problem_20_sqrt_difference()
    fig8.savefig(os.path.join(output_dir, 'problem_8.png'), dpi=300, bbox_inches='tight')
    plt.close(fig8)
    
    # 問題9: 比較（指数と多項式）
    print("9. 問題9のグラフを生成中...")
    fig9 = problem_21_exponential_vs_polynomial()
    fig9.savefig(os.path.join(output_dir, 'problem_9.png'), dpi=300, bbox_inches='tight')
    plt.close(fig9)
    
    # 問題9: 比の評価
    print("10. 問題9の比の評価を生成中...")
    fig10 = problem_21_ratio_analysis()
    fig10.savefig(os.path.join(output_dir, 'problem_9_ratio.png'), dpi=300, bbox_inches='tight')
    plt.close(fig10)
    
    # 問題9: はさみうちの定理
    print("11. 問題9のはさみうちの定理を生成中...")
    fig11 = problem_21_squeeze_theorem()
    fig11.savefig(os.path.join(output_dir, 'problem_9_squeeze.png'), dpi=300, bbox_inches='tight')
    plt.close(fig11)
    
    # 問題10: log x / x の極限
    print("12. 問題10のグラフを生成中...")
    fig12 = problem_10_log_over_x()
    fig12.savefig(os.path.join(output_dir, 'problem_10.png'), dpi=300, bbox_inches='tight')
    plt.close(fig12)
    
    # 問題10補足: √x - log x のグラフ
    print("13. 問題10補足のグラフを生成中...")
    fig13 = problem_10_sqrt_minus_log()
    fig13.savefig(os.path.join(output_dir, 'problem_10_supplement.png'), dpi=300, bbox_inches='tight')
    plt.close(fig13)
    
    print(f"完了！13個のグラフを生成しました。")
    print(f"出力先: {output_dir}")

if __name__ == "__main__":
    main()