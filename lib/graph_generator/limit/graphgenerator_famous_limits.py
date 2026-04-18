#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
有名な極限問題のグラフ生成器
"""

import sys
import os
import math
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from limit_common import plot_limit_function, plot_limit_sequence
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

def harmonic_series_integral_comparison(n_max=20):
    """
    調和級数の積分判定法の可視化
    積分 ∫(1 to n+1) 1/x dx と調和級数の部分和の比較
    """
    fig, ax = plt.subplots(1, 1, figsize=(12, 8))
    
    # 積分判定法の面積比較 - 左側を削除してx=1から開始
    x = np.linspace(1, n_max + 1, 1000)
    y = 1 / x
    
    # 積分曲線
    ax.plot(x, y, 'b-', linewidth=2)
    
    # 調和級数の矩形近似（上から押さえる）- 全体的に表示
    for n in range(1, n_max + 1):
        # 各矩形: 高さ1/n, 幅1.0, 左端n（隙間を完全になくす）
        rect = patches.Rectangle((n, 0), 1.0, 1/n, 
                               linewidth=1, edgecolor='red', 
                               facecolor='red', alpha=0.3)
        ax.add_patch(rect)
    
    # 積分の面積（下から押さえる）
    integral_x = np.linspace(1, n_max + 1, 1000)
    integral_y = 1 / integral_x
    ax.fill_between(integral_x, 0, integral_y, alpha=0.2, color='blue')
    
    # x軸の範囲を1から開始（左側を削除）
    ax.set_xlim(1, n_max + 1)
    ax.set_ylim(0, 1.2)
    ax.set_xlabel('x', fontsize=14)
    ax.set_ylabel('y', fontsize=14)
    
    # 1刻みでメモリを設定
    ax.set_xticks(range(1, n_max + 2))
    ax.set_xticklabels([str(i) for i in range(1, n_max + 2)])
    
    # タイトル部分に色ブロックを追加
    from matplotlib.patches import Rectangle
    from matplotlib.lines import Line2D
    
    # 青いブロック（積分領域）
    blue_patch = Rectangle((0, 0), 1, 1, facecolor='blue', alpha=0.3, edgecolor='blue', linewidth=2)
    # 赤いブロック（級数の部分）
    red_patch = Rectangle((0, 0), 1, 1, facecolor='red', alpha=0.3, edgecolor='red', linewidth=2)
    
    # 凡例をタイトル位置に配置 - より上に配置してスペースを確保
    legend = ax.legend(handles=[blue_patch, red_patch], 
                      labels=['$\\int_1^{n+1}\\frac{1}{x}dx$', '$\\displaystyle \\sum_{k=1}^{n}\\frac{1}{k}$'],
                      loc='upper center', 
                      bbox_to_anchor=(0.5, 1.45), ncol=1, frameon=False, 
                      fontsize=18, prop={'size': 18})
    legend.get_frame().set_facecolor('none')
    
    # グラフの上部により多くのマージンを追加
    plt.subplots_adjust(top=0.7)
    ax.grid(True, alpha=0.3)
    
    # より多くのスペースを確保
    plt.tight_layout(pad=3.0)
    return fig

def harmonic_series_partial_sum_evaluation(n_max=20):
    """
    調和級数の部分和評価（2^n での評価）
    """
    fig, ax = plt.subplots(1, 1, figsize=(12, 8))
    
    # 2^n での部分和
    n_powers = np.arange(1, int(math.log2(n_max)) + 2, 1)
    powers_of_2 = 2 ** n_powers
    
    # 調和級数の部分和
    harmonic_sums = []
    lower_bounds = []
    
    for n in n_powers:
        # 実際の調和級数の部分和
        sum_val = sum(1/k for k in range(1, 2**n + 1))
        harmonic_sums.append(sum_val)
        
        # 下界: 1 + n/2
        lower_bounds.append(1 + n/2)
    
    ax.plot(powers_of_2, harmonic_sums, 'ro-', label='$\\displaystyle \\sum_{k=1}^{2^n}\\frac{1}{k}$', markersize=6)
    ax.plot(powers_of_2, lower_bounds, 'bo-', label='$1 + \\frac{n}{2}$', markersize=6)
    
    # 対数スケールで表示
    ax.set_xscale('log')
    ax.set_xlabel('n')
    ax.set_ylabel('値')
    ax.set_title('')
    ax.legend()
    ax.grid(True, alpha=0.3)
    
    return fig

def mercator_series_visualization(n_max=50):
    """
    メルカトル級数の収束の可視化
    """
    def mercator_series_func(n):
        """メルカトル級数の部分和"""
        if np.isscalar(n):
            return sum((-1)**(k+1) / k for k in range(1, int(n) + 1))
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                result[i] = sum((-1)**(k+1) / k for k in range(1, int(ni) + 1))
            return result
    
    tex = r"""\displaystyle \lim_{n\to\infty}\displaystyle \sum_{k=1}^{n}\frac{(-1)^{k+1}}{k}"""
    out_path = "../../../assets/graphs/limit/problems_famous_limits/problem_1.png"
    
    return plot_limit_sequence(
        mercator_series_func, 
        tex, 
        out_path, 
        n_min=1, 
        n_max=n_max,
        limit_value=math.log(2),
        blue_label=r"$\displaystyle \sum_{k=1}^{n}\frac{(-1)^{k+1}}{k}$",
        red_label=r"$\log 2 \fallingdotseq 0.693$"
    )

def leibniz_series_visualization(n_max=50):
    """
    ライプニッツ級数の収束の可視化
    """
    def leibniz_series_func(n):
        """ライプニッツ級数の部分和"""
        if np.isscalar(n):
            return sum((-1)**(k-1) / (2*k-1) for k in range(1, int(n) + 1))
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                result[i] = sum((-1)**(k-1) / (2*k-1) for k in range(1, int(ni) + 1))
            return result
    
    tex = r"""\displaystyle \lim_{n\to\infty}\displaystyle \sum_{k=1}^{n}\frac{(-1)^{k-1}}{2k-1}"""
    out_path = "../../../assets/graphs/limit/problems_famous_limits/problem_2.png"
    
    return plot_limit_sequence(
        leibniz_series_func, 
        tex, 
        out_path, 
        n_min=1, 
        n_max=n_max,
        limit_value=math.pi/4,
        blue_label=r"$\displaystyle \sum_{k=1}^{n}\frac{(-1)^{k-1}}{2k-1}$",
        red_label=r"$\frac{\pi}{4} \fallingdotseq 0.785$"
    )

def sqrt_series_integral_comparison(n_max=20):
    """
    1/√n 級数の積分判定法の可視化
    積分 ∫(1 to n+1) 1/√x dx と級数の部分和の比較
    """
    fig, ax = plt.subplots(1, 1, figsize=(12, 8))
    
    # 積分判定法の面積比較
    x = np.linspace(1, n_max + 1, 1000)
    y = 1 / np.sqrt(x)
    
    # 積分曲線
    ax.plot(x, y, 'b-', linewidth=2)
    
    # 級数の矩形近似（上から押さえる）
    for n in range(1, n_max + 1):
        # 各矩形: 高さ1/√n, 幅1.0, 左端n
        rect = patches.Rectangle((n, 0), 1.0, 1/np.sqrt(n), 
                               linewidth=1, edgecolor='red', 
                               facecolor='red', alpha=0.3)
        ax.add_patch(rect)
    
    # 積分の面積（下から押さえる）
    integral_x = np.linspace(1, n_max + 1, 1000)
    integral_y = 1 / np.sqrt(integral_x)
    ax.fill_between(integral_x, 0, integral_y, alpha=0.2, color='blue')
    
    # x軸の範囲を1から開始
    ax.set_xlim(1, n_max + 1)
    ax.set_ylim(0, 1.2)
    ax.set_xlabel('x', fontsize=14)
    ax.set_ylabel('y', fontsize=14)
    
    # 1刻みでメモリを設定
    ax.set_xticks(range(1, n_max + 2))
    ax.set_xticklabels([str(i) for i in range(1, n_max + 2)])
    
    # タイトル部分に色ブロックを追加
    from matplotlib.patches import Rectangle
    
    # 青いブロック（積分領域）
    blue_patch = Rectangle((0, 0), 1, 1, facecolor='blue', alpha=0.3, edgecolor='blue', linewidth=2)
    # 赤いブロック（級数の部分）
    red_patch = Rectangle((0, 0), 1, 1, facecolor='red', alpha=0.3, edgecolor='red', linewidth=2)
    
    # 凡例をタイトル位置に配置
    legend = ax.legend(handles=[blue_patch, red_patch], 
                      labels=[r'$\int_1^{n+1}\frac{1}{\sqrt{x}}dx$', r'$\displaystyle \sum_{k=1}^{n}\frac{1}{\sqrt{k}}$'],
                      loc='upper center', 
                      bbox_to_anchor=(0.5, 1.45), ncol=1, frameon=False, 
                      fontsize=18, prop={'size': 18})
    legend.get_frame().set_facecolor('none')
    
    # グラフの上部により多くのマージンを追加
    plt.subplots_adjust(top=0.7)
    ax.grid(True, alpha=0.3)
    
    # より多くのスペースを確保
    plt.tight_layout(pad=3.0)
    return fig

def main():
    """メイン実行関数"""
    # 出力ディレクトリを作成
    output_dir = "../../../assets/graphs/limit/problems_famous_limits"
    os.makedirs(output_dir, exist_ok=True)
    
    print("有名な極限問題のグラフを生成中...")
    
    # メルカトル級数の可視化
    print("1. メルカトル級数を生成中...")
    fig1 = mercator_series_visualization(50)
    fig1.savefig(os.path.join(output_dir, 'problem_1.png'), dpi=300, bbox_inches='tight')
    plt.close(fig1)
    
    # ライプニッツ級数の可視化
    print("2. ライプニッツ級数を生成中...")
    fig2 = leibniz_series_visualization(50)
    fig2.savefig(os.path.join(output_dir, 'problem_2.png'), dpi=300, bbox_inches='tight')
    plt.close(fig2)
    
    # 調和級数の積分判定法
    print("3. 調和級数の積分判定法を生成中...")
    fig3 = harmonic_series_integral_comparison(20)
    fig3.savefig(os.path.join(output_dir, 'problem_3.png'), dpi=300, bbox_inches='tight')
    plt.close(fig3)
    
    # 問題4: 1/√n 級数の積分判定法
    print("4. 問題4のグラフを生成中...")
    fig4 = sqrt_series_integral_comparison(20)
    fig4.savefig(os.path.join(output_dir, 'problem_4.png'), dpi=300, bbox_inches='tight')
    plt.close(fig4)
    
    print(f"完了！4個のグラフを生成しました。")
    print(f"出力先: {output_dir}")

if __name__ == "__main__":
    main()
