#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# graphgenerator_sequences.py
# 数列漸化式問題のグラフ生成

import os
import sys
import math
import numpy as np
import matplotlib as mpl
mpl.use("Agg")
import matplotlib.pyplot as plt

# limit_common をインポートするためにパスを追加
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'limit'))
from limit_common import plot_limit_sequence, sanitize_tex_for_mathtext

# 各問題の一般項を計算する関数

def problem_1_sequence(n):
    """問題1: a_{n+1} = 2a_n + 3, a_1 = 1 → a_n = 2^{n+1} - 3"""
    with np.errstate(all='ignore'):
        return 2**(n + 1) - 3

def problem_2_sequence(n):
    """問題2: a_{n+1} = 3a_n - 4, a_1 = 1 → a_n = -3^{n-1} + 2"""
    with np.errstate(all='ignore'):
        return -3**(n - 1) + 2

def problem_3_sequence(n):
    """問題3: a_{n+1} = 2a_n + n + 1, a_1 = 1 → a_n = 2^{n+1} - n - 2"""
    with np.errstate(all='ignore'):
        return 2**(n + 1) - n - 2

def problem_4_sequence(n):
    """問題4: a_{n+1} = 2a_n + n^2 + 1, a_1 = 1 → a_n = 2^{n+2} - n^2 - 2n - 4"""
    with np.errstate(all='ignore'):
        return 2**(n + 2) - n**2 - 2*n - 4

def problem_5_sequence(n):
    """問題5: a_{n+1} = 2a_n + 3^n, a_1 = 1 → a_n = 3^n - 2^n"""
    with np.errstate(all='ignore'):
        return 3**n - 2**n

def problem_6_sequence(n):
    """問題6: a_{n+1} = a_n/(a_n + 1), a_1 = 1 → a_n = 1/n"""
    with np.errstate(all='ignore'):
        return 1.0 / n

def problem_7_sequence(n):
    """問題7: a_{n+1} = (4a_n + 3)/(a_n + 2), a_1 = 2 → a_n = 3 - 4/(3*5^{n-1} + 1)"""
    with np.errstate(all='ignore'):
        return 3.0 - 4.0 / (3.0 * (5.0 ** (n - 1)) + 1.0)

def problem_8_sequence(n):
    """問題8: a_{n+1} = (a_n - 9)/(a_n - 5), a_1 = 2 → a_n = (3n + 1)/(n+1)"""
    with np.errstate(all='ignore'):
        return (3.0 * n + 1.0) / (n + 1.0)

def problem_9_sequence(n):
    """問題9: sum_{k=1}^{n} a_k = n^2 + 2n → a_n = 2n + 1"""
    with np.errstate(all='ignore'):
        return 2*n + 1

def problem_10_sequence(n):
    """問題10: a_{n+2} + 3a_{n+1} - 4a_n = 0, a_1 = 1, a_2 = 2 → a_n = 6/5 - (1/5)(-4)^(n-1)"""
    with np.errstate(all='ignore'):
        return 6.0/5.0 - (1.0/5.0) * ((-4.0) ** (n - 1))

def problem_11_sequence(n):
    """問題11: a_{n+2} - a_{n+1} - 6a_n = 0, a_1 = 1, a_2 = 2 → a_n = (4/5)3^(n-1) + (1/5)(-2)^(n-1)"""
    with np.errstate(all='ignore'):
        return (4.0/5.0) * (3.0 ** (n - 1)) + (1.0/5.0) * ((-2.0) ** (n - 1))

def problem_12_sequence(n):
    """問題12: a_{n+2} - 4a_{n+1} + 4a_n = 0, a_1 = 1, a_2 = 6 → a_n = (-1 + 2n)2^(n-1)"""
    with np.errstate(all='ignore'):
        return (-1.0 + 2.0 * n) * (2.0 ** (n - 1))

def problem_14_sequence(n):
    """問題14: 連立漸化式 → a_n = -3*2^(n-1) + 5*3^(n-1)"""
    with np.errstate(all='ignore'):
        return -3.0 * (2.0 ** (n - 1)) + 5.0 * (3.0 ** (n - 1))

def problem_14_sequence_b(n):
    """問題14: 連立漸化式 → b_n = 6*2^(n-1) - 5*3^(n-1)"""
    with np.errstate(all='ignore'):
        return 6.0 * (2.0 ** (n - 1)) - 5.0 * (3.0 ** (n - 1))

def problem_15_sequence(n):
    """問題15: 連立漸化式（重解） → a_n = (2 + 3n)5^(n-2)"""
    with np.errstate(all='ignore'):
        return (2.0 + 3.0 * n) * (5.0 ** (n - 2))

def problem_15_sequence_b(n):
    """問題15: 連立漸化式（重解） → b_n = (13 - 3n)5^(n-2)"""
    with np.errstate(all='ignore'):
        return (13.0 - 3.0 * n) * (5.0 ** (n - 2))

def problem_16_sequence(n):
    """問題16: 変数係数漸化式 → a_n = 4/(n(n+1))"""
    with np.errstate(all='ignore'):
        return 4.0 / (n * (n + 1))

def problem_17_sequence(n):
    """問題17: 変数係数・非斉次 → a_n = -6/((n+1)(n+2)) + 2"""
    with np.errstate(all='ignore'):
        return -6.0 / ((n + 1) * (n + 2)) + 2.0

def problem_18_sequence(n):
    """問題18: 非線形（平方根） → a_n = 16 * 2^(-(1/2)^(n-1))"""
    with np.errstate(all='ignore'):
        exp = -(1.0 / 2.0) ** (n - 1)
        return 16.0 * (2.0 ** exp)

def problem_19_sequence(n):
    """問題19: 非線形（べき） → a_n = 2 * (5/2)^(2^(n-1))"""
    with np.errstate(all='ignore'):
        exp = 2.0 ** (n - 1)
        return 2.0 * ((5.0 / 2.0) ** exp)

def plot_coupled_sequence(a_func, b_func, tex, out_path, n_min=1, n_max=10,
                          figsize=(8, 8), a_label=None, b_label=None):
    """
    連立漸化式の2次元プロット（a_nを横軸、b_nを縦軸）
    
    Args:
        a_func: a_nの関数
        b_func: b_nの関数
        tex: タイトル用のTeX文字列
        out_path: 出力パス
        n_min, n_max: nの範囲
        figsize: 図のサイズ
        a_label: a_nのラベル
        b_label: b_nのラベル
    """
    n = np.arange(n_min, n_max + 1, 1)
    with np.errstate(all="ignore"):
        a_values = a_func(n)
        b_values = b_func(n)
    
    # 有効な値のみを抽出
    valid = ~(np.isnan(a_values) | np.isnan(b_values) | 
              np.isinf(a_values) | np.isinf(b_values))
    a_values = a_values[valid]
    b_values = b_values[valid]
    n_valid = n[valid]
    
    if len(a_values) == 0:
        print(f"Warning: No valid points for {out_path}")
        return
    
    # 問題14と問題15かどうかを判定（ファイル名から）
    is_problem_14 = 'problem_14' in out_path
    is_problem_15 = 'problem_15' in out_path
    is_coupled_with_special_layout = is_problem_14 or is_problem_15
    
    fig, ax = plt.subplots(figsize=figsize)
    
    # 軸の設定：横軸a（右が正）、縦軸b（上が正）
    ax.spines['left'].set_position('zero')
    ax.spines['bottom'].set_position('zero')
    ax.spines['right'].set_color('none')
    ax.spines['top'].set_color('none')
    ax.xaxis.set_ticks_position('bottom')
    ax.yaxis.set_ticks_position('left')
    
    # 点列をプロット（線でつなぐ）
    ax.plot(a_values, b_values, 'o-', color='#2196F3', 
            linewidth=2, markersize=8, zorder=2)
    
    # 各点にnの値を表示
    for i, (a_val, b_val, n_val) in enumerate(zip(a_values, b_values, n_valid)):
        ax.annotate(f'n={int(n_val)}', (a_val, b_val), 
                   xytext=(5, 5), textcoords='offset points',
                   fontsize=10, alpha=0.7)
    
    # ラベルとタイトル
    ax.set_xlabel(r"$a_n$", fontsize=14)
    ax.set_ylabel(r"$b_n$", fontsize=14)
    
    # タイトル
    safe_tex = sanitize_tex_for_mathtext(tex)
    try:
        ax.set_title(rf"${safe_tex}$", fontsize=16)
    except Exception:
        ax.set_title((tex or "").replace("\n", " "), fontsize=14)
    
    # グリッド
    ax.grid(True, linestyle=":", alpha=0.6)
    
    # 問題15の場合、b軸の正方向に50の目盛りを追加
    if is_problem_15:
        # 現在のy軸の目盛りを取得
        y_ticks = ax.get_yticks()
        # 50が含まれていない場合、追加
        if 50 not in y_ticks:
            y_ticks = list(y_ticks) + [50]
            ax.set_yticks(sorted(y_ticks))
    
    # a_nとb_nの式を表示（問題14と問題15の場合は第一象限の内側、それ以外は右上）
    if a_label or b_label:
        # グラフの範囲を取得
        x_min, x_max = ax.get_xlim()
        y_min, y_max = ax.get_ylim()
        
        if is_coupled_with_special_layout:
            # 第一象限の内側（グラフの左下あたり）に配置
            text_x = x_max * 0.05  # 左から5%の位置
            y_range = y_max - y_min
            text_y = y_min + y_range * 0.15  # 下から15%の位置
        else:
            # 右上の位置を計算（画像高さの1/5下、つまり上から20%下）
            text_x = x_max * 0.95
            y_range = y_max - y_min
            text_y = y_max - y_range * 0.2  # 画像高さの1/5下
        
        # ラベルをそのまま使用（matplotlibのmathtextでは\phantomが使えないため）
        a_label_aligned = a_label if a_label else None
        b_label_aligned = b_label if b_label else None
        
        # テキストを縦に並べて表示
        text_lines = []
        if a_label_aligned:
            text_lines.append(a_label_aligned)
        if b_label_aligned:
            text_lines.append(b_label_aligned)
        
        if len(text_lines) > 0:
            # 各行を縦に並べて表示
            text_str = '\n'.join(text_lines)
            if is_coupled_with_special_layout:
                # 第一象限の内側に配置（左下揃え）
                ax.text(text_x, text_y, text_str, 
                       fontsize=14, 
                       verticalalignment='bottom',
                       horizontalalignment='left',
                       bbox=dict(boxstyle='round', facecolor='wheat', alpha=0.8),
                       transform=ax.transData)
            else:
                # 右上に配置（左揃え）
                ax.text(text_x, text_y, text_str, 
                       fontsize=10, 
                       verticalalignment='top',
                       horizontalalignment='left',
                       bbox=dict(boxstyle='round', facecolor='wheat', alpha=0.8),
                       transform=ax.transData)
    
    # レイアウト調整
    plt.tight_layout()
    fig.savefig(out_path, dpi=150, bbox_inches='tight')
    plt.close(fig)

# 問題定義（sequences.dartの問題に対応）
PROBLEMS = [
    {
        "question": r"""a_{n+1} = 2a_n + 3, \quad a_1 = 1""",
        "func": problem_1_sequence,
        "filename": "problem_1.png",
        "n_min": 1,
        "n_max": 10,
        "blue_label": r"$a_n = 2^{n+1} - 3$",
        "legend_loc": "upper left"
    },
    {
        "question": r"""a_{n+1} = 3a_n - 4, \quad a_1 = 1""",
        "func": problem_2_sequence,
        "filename": "problem_2.png",
        "n_min": 1,
        "n_max": 10,
        "blue_label": r"$a_n = -3^{n-1} + 2$",
        "legend_loc": "upper left"
    },
    {
        "question": r"""a_{n+1} = 2a_n + n + 1, \quad a_1 = 1""",
        "func": problem_3_sequence,
        "filename": "problem_3.png",
        "n_min": 1,
        "n_max": 10,
        "blue_label": r"$a_n = 2^{n+1} - n - 2$",
        "legend_loc": "upper left"
    },
    {
        "question": r"""a_{n+1} = 2a_n + n^2 + 1, \quad a_1 = 1""",
        "func": problem_4_sequence,
        "filename": "problem_4.png",
        "n_min": 1,
        "n_max": 6,
        "blue_label": r"$a_n = 2^{n+2} - n^2 - 2n - 4$",
        "legend_loc": "upper left"
    },
    {
        "question": r"""a_{n+1} = 2a_n + 3^n, \quad a_1 = 1""",
        "func": problem_5_sequence,
        "filename": "problem_5.png",
        "n_min": 1,
        "n_max": 10,
        "blue_label": r"$a_n = 3^n - 2^n$",
        "legend_loc": "upper left"
    },
    {
        "question": r"""a_{n+1} = \displaystyle \frac{a_n}{a_n + 1}, \quad a_1 = 1""",
        "func": problem_6_sequence,
        "filename": "problem_6.png",
        "n_min": 1,
        "n_max": 20,
        "blue_label": r"$a_n = \frac{1}{n}$",
        "legend_loc": "upper right"
    },
    {
        "question": r"""a_{n+1} = \displaystyle \frac{4a_n + 3}{a_n + 2}, \quad a_1 = 2""",
        "func": problem_7_sequence,
        "filename": "problem_7.png",
        "n_min": 1,
        "n_max": 20,
        "blue_label": r"$a_n = 3 - \frac{4}{3 \cdot 5^{n-1} + 1}$",
        "legend_loc": "upper right"
    },
    {
        "question": r"""a_{n+1} = \displaystyle \frac{a_n - 9}{a_n - 5}, \quad a_1 = 2""",
        "func": problem_8_sequence,
        "filename": "problem_8.png",
        "n_min": 1,
        "n_max": 10,
        "blue_label": r"$a_n = \frac{3n + 1}{n+1}$",
        "legend_loc": "upper right"
    },
    {
        "question": r"""\displaystyle \sum_{k=1}^{n} a_k = n^2 + 2n""",
        "func": problem_9_sequence,
        "filename": "problem_9.png",
        "n_min": 1,
        "n_max": 10,
        "blue_label": r"$a_n = 2n + 1$",
        "legend_loc": "upper left"
    },
    {
        "question": r"""a_{n+2} + 3 a_{n+1} - 4 a_n = 0, \quad a_1 = 1,\ a_2 = 2""",
        "func": problem_10_sequence,
        "filename": "problem_10.png",
        "n_min": 1,
        "n_max": 10,
        "blue_label": r"$a_n = \frac{6}{5} - \frac{1}{5}(-4)^{n-1}$",
        "legend_loc": "upper left"
    },
    {
        "question": r"""a_{n+2} - a_{n+1} - 6 a_n = 0, \quad a_1 = 1,\ a_2 = 2""",
        "func": problem_11_sequence,
        "filename": "problem_11.png",
        "n_min": 1,
        "n_max": 10,
        "blue_label": r"$a_n = \frac{4}{5} \cdot 3^{n-1} + \frac{1}{5}(-2)^{n-1}$",
        "legend_loc": "upper left"
    },
    {
        "question": r"""a_{n+2} - 4a_{n+1} + 4a_n = 0, \quad a_1 = 1,\ a_2 = 6""",
        "func": problem_12_sequence,
        "filename": "problem_12.png",
        "n_min": 1,
        "n_max": 10,
        "blue_label": r"$a_n = (-1 + 2n)2^{n-1}$",
        "legend_loc": "upper left"
    },
    {
        "question": r"""a_{n+1} = 4a_n + b_n,\ b_{n+1} = -2a_n + b_n,\ a_1 = 2,\ b_1 = 1""",
        "func": problem_14_sequence,
        "func_b": problem_14_sequence_b,
        "filename": "problem_14.png",
        "n_min": 1,
        "n_max": 5,
        "a_label": r"$a_n = -3 \cdot 2^{n-1} + 5 \cdot 3^{n-1}$",
        "b_label": r"$b_n = 6 \cdot 2^{n-1} - 5 \cdot 3^{n-1}$",
        "is_coupled": True
    },
    {
        "question": r"""a_{n+1} = 6a_n + b_n,\ b_{n+1} = -a_n + 4b_n,\ a_1 = 1,\ b_1 = 2""",
        "func": problem_15_sequence,
        "func_b": problem_15_sequence_b,
        "filename": "problem_15.png",
        "n_min": 1,
        "n_max": 5,
        "a_label": r"$a_n = (2 + 3n)5^{n-2}$",
        "b_label": r"$b_n = (13 - 3n)5^{n-2}$",
        "is_coupled": True
    },
    {
        "question": r"""(n+1)a_n = (n-1)a_{n-1}, \quad a_1 = 2""",
        "func": problem_16_sequence,
        "filename": "problem_16.png",
        "n_min": 1,
        "n_max": 20,
        "blue_label": r"$a_n = \frac{4}{n(n+1)}$",
        "legend_loc": "upper right"
    },
    {
        "question": r"""(n+2)a_n = n a_{n-1} + 4, \quad a_1 = 1""",
        "func": problem_17_sequence,
        "filename": "problem_17.png",
        "n_min": 1,
        "n_max": 10,
        "blue_label": r"$a_n = -\frac{6}{(n+1)(n+2)} + 2$",
        "legend_loc": "upper right"
    },
    {
        "question": r"""a_n = 4\sqrt{a_{n-1}}, \quad a_1 = 8""",
        "func": problem_18_sequence,
        "filename": "problem_18.png",
        "n_min": 1,
        "n_max": 10,
        "blue_label": r"$a_n = 16 \cdot 2^{-(\frac{1}{2})^{n-1}}$",
        "legend_loc": "upper right"
    },
    {
        "question": r"""a_n = \frac{1}{2}(a_{n-1})^2, \quad a_1 = 5""",
        "func": problem_19_sequence,
        "filename": "problem_19.png",
        "n_min": 1,
        "n_max": 4,  # n=4までプロット
        "blue_label": r"$a_n = 2 \cdot \left(\frac{5}{2}\right)^{2^{n-1}}$",
        "legend_loc": "upper left"
    },
]

def main():
    """メイン実行関数"""
    # 出力ディレクトリを作成
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(os.path.dirname(os.path.dirname(script_dir)))
    output_dir = os.path.join(project_root, "assets", "graphs", "sequences")
    os.makedirs(output_dir, exist_ok=True)
    
    print("数列漸化式問題のグラフを生成中...")
    
    for i, problem in enumerate(PROBLEMS, 1):
        print(f"問題 {i}: {problem['filename']}")
        
        out_path = os.path.join(output_dir, problem['filename'])
        
        # 連立漸化式の場合は2次元プロット
        if problem.get('is_coupled', False):
            plot_coupled_sequence(
                a_func=problem['func'],
                b_func=problem['func_b'],
                tex=problem['question'],
                out_path=out_path,
                n_min=problem['n_min'],
                n_max=problem['n_max'],
                a_label=problem.get('a_label'),
                b_label=problem.get('b_label')
            )
        else:
            # 通常の数列のグラフを生成
            plot_limit_sequence(
                func=problem['func'],
                tex=problem['question'],
                out_path=out_path,
                n_min=problem['n_min'],
                n_max=problem['n_max'],
                show_limit_value=False,  # 極限値は表示しない
                blue_label=problem.get('blue_label'),
                legend_loc=problem.get('legend_loc', 'upper right')
            )
    
    print(f"完了！{len(PROBLEMS)}個のグラフを生成しました。")
    print(f"出力先: {output_dir}")

if __name__ == "__main__":
    main()

