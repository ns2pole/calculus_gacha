#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
物理数学問題のグラフ生成器
"""

import sys
import os
import math
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

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

def problem_1_differential_equation():
    """
    問題1: dy/dx = 2xy + x の解の可視化
    """
    fig, ax = plt.subplots(1, 1, figsize=(8, 4.8))
    
    # 解の族: y = Ce^(x^2) - 1/2
    x = np.linspace(-2, 2, 1000)
    C_values = [-2, -1, 0, 1, 2]  # 異なる定数Cの値
    
    for i, C in enumerate(C_values):
        y = C * np.exp(x**2) - 0.5
        ax.plot(x, y, 'b-', linewidth=2, alpha=0.7, label=f'C = {C}' if i < 3 else '')
    
    # 特解 y = -1/2 (C=0の場合)
    y_special = -0.5 * np.ones_like(x)
    ax.plot(x, y_special, 'r--', linewidth=2, label='y = -1/2 (special solution)')
    
    # 極限値のラベルを右上に表示
    ax.text(0.98, 0.98, 'limit = -1/2 (special solution)', fontsize=10, 
           verticalalignment='top', horizontalalignment='right',
           bbox=dict(boxstyle='round,pad=0.3', facecolor='white', alpha=0.9))
    
    ax.set_xlabel('x')
    ax.set_ylabel('y')
    ax.set_title('$\\frac{dy}{dx} = 2xy + x$ (solution family)')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xlim(-2, 2)
    ax.set_ylim(-3, 5)
    
    plt.tight_layout()
    return fig

def main():
    """メイン実行関数"""
    # 出力ディレクトリを作成
    output_dir = "../../../assets/graphs/physics_math"
    os.makedirs(output_dir, exist_ok=True)
    
    print("物理数学問題のグラフを生成中...")
    
    # 問題1: 微分方程式
    print("1. 問題1のグラフを生成中...")
    fig1 = problem_1_differential_equation()
    fig1.savefig(os.path.join(output_dir, 'problem_1.png'), dpi=300, bbox_inches='tight')
    plt.close(fig1)
    
    print("完了！1個のグラフを生成しました。")
    print(f"出力先: {output_dir}")

if __name__ == "__main__":
    main()
