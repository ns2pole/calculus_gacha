#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
基本極限問題のグラフ生成器
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

def problem_1_sin_3x_over_x():
    """
    問題1: lim x→0 sin(3x)/x = 3
    """
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # 関数 sin(3x)/x
    x = np.linspace(-5, 5, 1000)
    x = x[x != 0]  # x=0を除外
    y = np.sin(3*x) / x
    
    ax.plot(x, y, 'b-', linewidth=2, label='$\\frac{\\sin(3x)}{x}$')
    ax.axhline(y=3, color='r', linestyle='--', label='3')
    ax.set_xlabel('x')
    ax.set_ylabel('y')
    ax.set_title('$\\frac{\\sin(3x)}{x}$')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(-5, 5)
    
    plt.tight_layout()
    return fig

def problem_2_tan_x_over_x():
    """
    問題2: lim x→0 tan(x)/x = 1
    """
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # 関数 tan(x)/x
    x = np.linspace(-5, 5, 1000)
    x = x[x != 0]  # x=0を除外
    # tan(x)の定義域を考慮
    x = x[abs(x) < np.pi/2 - 0.1]
    y = np.tan(x) / x
    
    ax.plot(x, y, 'b-', linewidth=2, label='$\\frac{\\tan(x)}{x}$')
    ax.axhline(y=1, color='r', linestyle='--', label='1')
    ax.set_xlabel('x')
    ax.set_ylabel('y')
    ax.set_title('$\\frac{\\tan(x)}{x}$')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(-5, 5)
    
    plt.tight_layout()
    return fig

def problem_3_x_sin_one_over_x():
    """
    問題3: lim x→∞ x sin(1/x) = 1
    """
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # 関数 x * sin(1/x)
    # x→∞なので、xは大きい値から始める
    x = np.linspace(0.1, 20, 1000)
    y = x * np.sin(1/x)
    
    ax.plot(x, y, 'b-', linewidth=2, label='$x \\sin\\left(\\frac{1}{x}\\right)$')
    ax.axhline(y=1, color='r', linestyle='--', label='1')
    ax.set_xlabel('x')
    ax.set_ylabel('y')
    ax.set_title('$\\lim_{x\\to \\infty} x \\sin\\left(\\frac{1}{x}\\right)$')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(0, 20)
    ax.set_ylim(0.5, 1.2)
    
    plt.tight_layout()
    return fig

def problem_4_sin_x_over_x_plus_sin_x():
    """
    問題4: lim x→0 sin(x)/(x+sin(x)) = 1/2
    """
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    x = np.linspace(-5, 5, 1000)
    x = x[x != 0]  # x=0を除外
    y = np.sin(x) / (x + np.sin(x))
    
    ax.plot(x, y, 'b-', linewidth=2, label='$\\frac{\\sin(x)}{x + \\sin(x)}$')
    ax.axhline(y=0.5, color='r', linestyle='--', label='$\\frac{1}{2}$')
    ax.set_xlabel('x')
    ax.set_ylabel('y')
    ax.set_title('$\\frac{\\sin(x)}{x + \\sin(x)}$')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(-5, 5)
    
    plt.tight_layout()
    return fig

def problem_5_one_minus_e_negative_x_over_x():
    """
    問題5: lim x→0 (1-e^(-x))/x = 1
    """
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # 関数 (1-e^(-x))/x
    x = np.linspace(-3, 3, 1000)
    x = x[x != 0]  # x=0を除外
    # 数値的安定性のため、xが負で大きすぎる場合は制限
    x = x[x > -10]  # x > -10で制限
    y = (1 - np.exp(-x)) / x
    
    ax.plot(x, y, 'b-', linewidth=2, label='$\\frac{1 - e^{-x}}{x}$')
    ax.axhline(y=1, color='r', linestyle='--', label='1')
    ax.set_xlabel('x')
    ax.set_ylabel('y')
    ax.set_title('$\\frac{1 - e^{-x}}{x}$')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(-3, 3)
    ax.set_ylim(-2, 3)  # y軸の範囲も制限
    
    plt.tight_layout()
    return fig

def problem_6_e_x_minus_e_negative_x_over_2x():
    """
    問題6: lim x→0 (e^x - e^(-x))/(2x) = 1
    """
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # 関数 (e^x - e^(-x))/(2x)
    x = np.linspace(-5, 5, 1000)
    x = x[x != 0]  # x=0を除外
    y = (np.exp(x) - np.exp(-x)) / (2*x)
    
    ax.plot(x, y, 'b-', linewidth=2, label='$\\frac{e^x - e^{-x}}{2x}$')
    ax.axhline(y=1, color='r', linestyle='--', label='1')
    ax.set_xlabel('x')
    ax.set_ylabel('y')
    ax.set_title('$\\frac{e^x - e^{-x}}{2x}$')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(-5, 5)
    
    plt.tight_layout()
    return fig

def problem_7_log_1_plus_ax_over_x():
    """
    問題7: lim x→0 log(1+2x)/x = 2
    """
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # a=2の場合 log(1+2x)/x
    a = 2
    x = np.linspace(-5, 5, 1000)
    x = x[x != 0]  # x=0を除外
    x = x[x > -1/a]  # log(1+ax)の定義域
    y = np.log(1 + a*x) / x
    
    ax.plot(x, y, 'b-', linewidth=2, label=f'$\\frac{{\\log(1+{a}x)}}{{x}}$')
    ax.axhline(y=a, color='r', linestyle='--', label=f'{a}')
    ax.set_xlabel('x')
    ax.set_ylabel('y')
    ax.set_title(f'$\\frac{{\\log(1+{a}x)}}{{x}}$ (a={a})')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(-5, 5)
    
    plt.tight_layout()
    return fig

def problem_8_log_1_plus_x_over_x():
    """
    問題8: lim x→0 log(1+x)/x = 1
    """
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    x = np.linspace(-5, 5, 1000)
    x = x[x != 0]  # x=0を除外
    x = x[x > -1]  # log(1+x)の定義域
    y = np.log(1 + x) / x
    
    ax.plot(x, y, 'b-', linewidth=2, label='$\\frac{\\log(1+x)}{x}$')
    ax.axhline(y=1, color='r', linestyle='--', label='1')
    ax.set_xlabel('x')
    ax.set_ylabel('y')
    ax.set_title('$\\frac{\\log(1+x)}{x}$')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(-5, 5)
    
    plt.tight_layout()
    return fig

def problem_9_a_x_minus_1_over_x():
    """
    問題9: lim x→0 (3^x - 1)/x = log(3)
    """
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # a=3の場合 (3^x - 1)/x
    a = 3
    x = np.linspace(-5, 5, 1000)
    x = x[x != 0]  # x=0を除外
    y = (a**x - 1) / x
    
    ax.plot(x, y, 'b-', linewidth=2, label='$\\frac{3^x - 1}{x}$')
    ax.axhline(y=np.log(a), color='r', linestyle='--', label=f'$\\log(3) \\fallingdotseq {np.log(a):.3f}$')
    ax.set_xlabel('x')
    ax.set_ylabel('y')
    ax.set_title('$\\frac{3^x - 1}{x}$')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(-5, 5)
    
    plt.tight_layout()
    return fig

def problem_10_sum_limit():
    """
    問題10: lim n→∞ (1/n³) ∑(k=1 to n) k² = 1/3
    """
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # nの値を設定（1から100まで）
    n_values = np.arange(1, 101)
    
    # 各nに対して (1/n³) ∑(k=1 to n) k² を計算
    # ∑(k=1 to n) k² = n(n+1)(2n+1)/6 なので
    # (1/n³) ∑(k=1 to n) k² = (1/n³) * n(n+1)(2n+1)/6 = (n+1)(2n+1)/(6n²)
    # = (2n²+3n+1)/(6n²) = (2+3/n+1/n²)/6
    y_values = (n_values + 1) * (2 * n_values + 1) / (6 * n_values**2)
    
    ax.plot(n_values, y_values, 'b-', linewidth=2, label='$\\frac{1}{n^3}\\displaystyle \\sum_{k=1}^{n}k^2$')
    ax.axhline(y=1/3, color='r', linestyle='--', label='$\\frac{1}{3}$')
    ax.set_xlabel('n')
    ax.set_ylabel('y')
    ax.set_title('$\\frac{1}{n^3}\\displaystyle \\sum_{k=1}^{n}k^2$')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(1, 100)
    ax.set_ylim(0.2, 0.6)
    
    plt.tight_layout()
    return fig

def problem_11_series_2_plus_minus2_plus2():
    """
    問題11: 2+(-2+2)+(-2+2)+... = 2
    部分和は常に2
    """
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # nの値を設定（1から10まで）
    n_values = np.arange(1, 11)
    
    # 部分和は常に2
    y_values = np.full_like(n_values, 2.0, dtype=float)
    
    ax.plot(n_values, y_values, 'bo-', linewidth=2, markersize=6, label='$S_n = 2+(-2+2)+(-2+2)+\\cdots$')
    ax.set_xlabel('n')
    ax.set_ylabel('$S_n$')
    ax.set_title('$2+(-2+2)+(-2+2)+\\cdots$')
    ax.set_xticks(np.arange(1, 11, 1))
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(0.5, 10.5)
    ax.set_ylim(1.5, 2.5)
    
    plt.tight_layout()
    return fig

def problem_12_series_2_minus_2():
    """
    問題12: (2-2)+(2-2)+(2-2)+... = 0
    部分和は常に0
    """
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # nの値を設定（1から10まで）
    n_values = np.arange(1, 11)
    
    # 部分和は常に0
    y_values = np.zeros_like(n_values, dtype=float)
    
    ax.plot(n_values, y_values, 'bo-', linewidth=2, markersize=6, label='$S_n = (2-2)+(2-2)+(2-2)+\\cdots$')
    ax.set_xlabel('n')
    ax.set_ylabel('$S_n$')
    ax.set_title('$(2-2)+(2-2)+(2-2)+\\cdots$')
    ax.set_xticks(np.arange(1, 11, 1))
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(0.5, 10.5)
    ax.set_ylim(-0.5, 0.5)
    
    plt.tight_layout()
    return fig

def problem_13_series_2_minus_2_oscillating():
    """
    問題13: 2-2+2-2+2-2+... 発散（振動）
    部分和は0, 2, 0, 2, ...と振動
    """
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # nの値を設定（1から10まで）
    n_values = np.arange(1, 11)
    
    # 部分和を計算: S_n = 2-2+2-2+...
    # S_1 = 2, S_2 = 0, S_3 = 2, S_4 = 0, ...
    y_values = np.where(n_values % 2 == 1, 2.0, 0.0)
    
    ax.plot(n_values, y_values, 'bo-', linewidth=2, markersize=6, label='$S_n = 2-2+2-2+2-2+\\cdots$')
    ax.set_xlabel('n')
    ax.set_ylabel('$S_n$')
    ax.set_title('$2-2+2-2+2-2+\\cdots$')
    ax.set_xticks(np.arange(1, 11, 1))
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(0.5, 10.5)
    ax.set_ylim(-0.5, 2.5)
    
    plt.tight_layout()
    return fig

def main():
    """メイン実行関数"""
    # 出力ディレクトリを作成
    output_dir = "../../../assets/graphs/limit/problems_basic_limits"
    os.makedirs(output_dir, exist_ok=True)
    
    print("基本極限問題のグラフを生成中...")
    
    # 問題1: sin(3x)/x
    print("1. 問題1のグラフを生成中...")
    fig1 = problem_1_sin_3x_over_x()
    fig1.savefig(os.path.join(output_dir, 'problem_1.png'), dpi=300, bbox_inches='tight')
    plt.close(fig1)
    
    # 問題2: tan(x)/x
    print("2. 問題2のグラフを生成中...")
    fig2 = problem_2_tan_x_over_x()
    fig2.savefig(os.path.join(output_dir, 'problem_2.png'), dpi=300, bbox_inches='tight')
    plt.close(fig2)
    
    # 問題3: x sin(1/x)
    print("3. 問題3のグラフを生成中...")
    fig3 = problem_3_x_sin_one_over_x()
    fig3.savefig(os.path.join(output_dir, 'problem_3.png'), dpi=300, bbox_inches='tight')
    plt.close(fig3)
    
    # 問題4: sin(x)/(x+sin(x))
    print("4. 問題4のグラフを生成中...")
    fig4 = problem_4_sin_x_over_x_plus_sin_x()
    fig4.savefig(os.path.join(output_dir, 'problem_4.png'), dpi=300, bbox_inches='tight')
    plt.close(fig4)
    
    # 問題5: (1-e^(-x))/x
    print("5. 問題5のグラフを生成中...")
    fig5 = problem_5_one_minus_e_negative_x_over_x()
    fig5.savefig(os.path.join(output_dir, 'problem_5.png'), dpi=300, bbox_inches='tight')
    plt.close(fig5)
    
    # 問題6: (e^x - e^(-x))/(2x)
    print("6. 問題6のグラフを生成中...")
    fig6 = problem_6_e_x_minus_e_negative_x_over_2x()
    fig6.savefig(os.path.join(output_dir, 'problem_6.png'), dpi=300, bbox_inches='tight')
    plt.close(fig6)
    
    # 問題7: log(1+ax)/x
    print("7. 問題7のグラフを生成中...")
    fig7 = problem_7_log_1_plus_ax_over_x()
    fig7.savefig(os.path.join(output_dir, 'problem_7.png'), dpi=300, bbox_inches='tight')
    plt.close(fig7)
    
    # 問題8: log(1+x)/x
    print("8. 問題8のグラフを生成中...")
    fig8 = problem_8_log_1_plus_x_over_x()
    fig8.savefig(os.path.join(output_dir, 'problem_8.png'), dpi=300, bbox_inches='tight')
    plt.close(fig8)
    
    # 問題9: (a^x - 1)/x
    print("9. 問題9のグラフを生成中...")
    fig9 = problem_9_a_x_minus_1_over_x()
    fig9.savefig(os.path.join(output_dir, 'problem_9.png'), dpi=300, bbox_inches='tight')
    plt.close(fig9)
    
    # 問題10: (1/n²) ∑(k=1 to n) k
    print("10. 問題10のグラフを生成中...")
    fig10 = problem_10_sum_limit()
    fig10.savefig(os.path.join(output_dir, 'problem_10.png'), dpi=300, bbox_inches='tight')
    plt.close(fig10)
    
    # 問題11: 2+(-2+2)+(-2+2)+...
    print("11. 問題11のグラフを生成中...")
    fig11 = problem_11_series_2_plus_minus2_plus2()
    fig11.savefig(os.path.join(output_dir, 'problem_11.png'), dpi=300, bbox_inches='tight')
    plt.close(fig11)
    
    # 問題12: (2-2)+(2-2)+(2-2)+...
    print("12. 問題12のグラフを生成中...")
    fig12 = problem_12_series_2_minus_2()
    fig12.savefig(os.path.join(output_dir, 'problem_12.png'), dpi=300, bbox_inches='tight')
    plt.close(fig12)
    
    # 問題13: 2-2+2-2+2-2+...
    print("13. 問題13のグラフを生成中...")
    fig13 = problem_13_series_2_minus_2_oscillating()
    fig13.savefig(os.path.join(output_dir, 'problem_13.png'), dpi=300, bbox_inches='tight')
    plt.close(fig13)
    
    print(f"完了！13個のグラフを生成しました。")
    print(f"出力先: {output_dir}")

if __name__ == "__main__":
    main()