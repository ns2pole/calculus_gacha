#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# graphgenerator_e_limit_variations.py
# eに関する極限問題のバリエーションのグラフ生成

import os
import math
import numpy as np
from limit_common import plot_limit_function, plot_limit_sequence

# 問題1: lim_{h→0}(1+h)^{1/h} = e
def problem_1_func(h):
    """(1+h)^{1/h} の関数"""
    with np.errstate(all='ignore'):
        # h=0の近くで計算が不安定になるため、hが小さい場合はeに近い値を返す
        result = np.where(np.abs(h) > 1e-10, (1 + h)**(1/h), math.e)
        # 無効な値をeで置き換え
        result = np.where(np.isnan(result) | np.isinf(result), math.e, result)
        return result

# 問題2: lim_{h→0}(1+2h)^{1/h} = e^2
def problem_2_func(h):
    """(1+2h)^{1/h} の関数"""
    with np.errstate(all='ignore'):
        result = np.where(np.abs(h) > 1e-10, (1 + 2*h)**(1/h), math.e**2)
        result = np.where(np.isnan(result) | np.isinf(result), math.e**2, result)
        return result

# 問題3: lim_{x→∞}(1+1/x)^x = e
def problem_3_func(x):
    """(1+1/x)^x の関数（x→∞）"""
    with np.errstate(all='ignore'):
        # xが大きい場合の処理
        result = np.where(x > 0, (1 + 1/x)**x, np.nan)
        result = np.where(np.isnan(result) | np.isinf(result), math.e, result)
        return result

# 問題4: lim_{x→-∞}(1+1/x)^x = e
def problem_4_func(x):
    """(1+1/x)^x の関数（x→-∞）"""
    with np.errstate(all='ignore'):
        # xが負で大きい場合の処理
        result = np.where(x < -1, (1 + 1/x)**x, np.nan)
        result = np.where(np.isnan(result) | np.isinf(result), math.e, result)
        return result

# 問題5: lim_{x→∞}(1+1/x)^{2x} = e^2
def problem_5_func(x):
    """(1+1/x)^{2x} の関数（x→∞）"""
    with np.errstate(all='ignore'):
        result = np.where(x > 0, (1 + 1/x)**(2*x), np.nan)
        result = np.where(np.isnan(result) | np.isinf(result), math.e**2, result)
        return result

# 問題6: lim_{h→+0}(1+1/h)^h = 1
def problem_6_func(h):
    """(1+1/h)^h の関数（h→+0）"""
    with np.errstate(all='ignore'):
        # hが正で小さい場合
        result = np.where((h > 0) & (h < 1), (1 + 1/h)**h, np.nan)
        result = np.where(np.isnan(result) | np.isinf(result), 1.0, result)
        return result

# 問題7: lim_{h→∞}(1+h)^{1/h} = 1
def problem_7_func(h):
    """(1+h)^{1/h} の関数（h→∞）"""
    with np.errstate(all='ignore'):
        # hが大きい場合
        result = np.where(h > 0, (1 + h)**(1/h), np.nan)
        result = np.where(np.isnan(result) | np.isinf(result), 1.0, result)
        return result

# 問題定義（problems_e_limit_variations.dartの7問に対応）
PROBLEMS = [
    {
        "question": r"""\displaystyle \lim_{h\to 0}(1+h)^{\frac{1}{h}}""",
        "func": problem_1_func,
        "filename": "problem_1.png",
        "x_min": -0.5,
        "x_max": 0.5,
        "limit_point": 0,
        "limit_value": math.e,
        "blue_label": r"$(1+h)^{\frac{1}{h}}$",
        "red_label": r"$e \fallingdotseq 2.718$",
        "legend_loc": "upper right"
    },
    {
        "question": r"""\displaystyle \lim_{h\to 0}(1+2h)^{\frac{1}{h}}""",
        "func": problem_2_func,
        "filename": "problem_2.png",
        "x_min": -0.3,
        "x_max": 0.3,
        "limit_point": 0,
        "limit_value": math.e**2,
        "blue_label": r"$(1+2h)^{\frac{1}{h}}$",
        "red_label": r"$e^{2} \fallingdotseq 7.389$",
        "legend_loc": "upper right"
    },
    {
        "question": r"""\displaystyle \lim_{x\to \infty}\left(1+\frac{1}{x}\right)^{x}""",
        "func": problem_3_func,
        "filename": "problem_3.png",
        "x_min": 1,
        "x_max": 50,
        "limit_point": None,
        "limit_value": math.e,
        "is_sequence": False,
        "blue_label": r"$\left(1+\frac{1}{x}\right)^{x}$",
        "red_label": r"$e \fallingdotseq 2.718$",
        "legend_loc": "lower right"
    },
    {
        "question": r"""\displaystyle \lim_{x\to -\infty}\left(1+\frac{1}{x}\right)^{x}""",
        "func": problem_4_func,
        "filename": "problem_4.png",
        "x_min": -50,
        "x_max": -1,
        "limit_point": None,
        "limit_value": math.e,
        "is_sequence": False,
        "blue_label": r"$\left(1+\frac{1}{x}\right)^{x}$",
        "red_label": r"$e \fallingdotseq 2.718$",
        "legend_loc": "upper right"
    },
    {
        "question": r"""\displaystyle \lim_{x\to \infty}\left(1+\frac{1}{x}\right)^{2x}""",
        "func": problem_5_func,
        "filename": "problem_5.png",
        "x_min": 1,
        "x_max": 50,
        "limit_point": None,
        "limit_value": math.e**2,
        "is_sequence": False,
        "blue_label": r"$\left(1+\frac{1}{x}\right)^{2x}$",
        "red_label": r"$e^{2} \fallingdotseq 7.389$",
        "legend_loc": "lower right"
    },
    {
        "question": r"""\displaystyle \lim_{h\to +0}\left(1+\frac{1}{h}\right)^{h}""",
        "func": problem_6_func,
        "filename": "problem_6.png",
        "x_min": 0.0,
        "x_max": 0.5,
        "limit_point": 0,
        "limit_value": 1.0,
        "blue_label": r"$\left(1+\frac{1}{h}\right)^{h}$",
        "red_label": "1",
        "legend_loc": "upper left"
    },
    {
        "question": r"""\displaystyle \lim_{h\to \infty}(1+h)^{\frac{1}{h}}""",
        "func": problem_7_func,
        "filename": "problem_7.png",
        "x_min": 1,
        "x_max": 50,
        "limit_point": None,
        "limit_value": 1.0,
        "is_sequence": True,
        "blue_label": r"$(1+h)^{\frac{1}{h}}$",
        "red_label": "1",
        "legend_loc": "upper right"
    },
]

def main():
    """メイン実行関数"""
    # 出力ディレクトリを作成
    output_dir = "../../../assets/graphs/limit/problems_e_limit_variations"
    os.makedirs(output_dir, exist_ok=True)
    
    print("eに関する極限問題のバリエーションのグラフを生成中...")
    
    for i, problem in enumerate(PROBLEMS, 1):
        print(f"問題 {i}: {problem['filename']}")
        
        out_path = os.path.join(output_dir, problem['filename'])
        
        if problem.get('is_sequence', False):
            # 数列の極限問題
            plot_limit_sequence(
                func=problem['func'],
                tex=problem['question'],
                out_path=out_path,
                n_min=int(problem['x_min']),
                n_max=int(problem['x_max']),
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
                limit_point=problem.get('limit_point'),
                limit_value=problem.get('limit_value'),
                blue_label=problem.get('blue_label'),
                red_label=problem.get('red_label'),
                legend_loc=problem.get('legend_loc', 'upper right')
            )
    
    print(f"完了！{len(PROBLEMS)}個のグラフを生成しました。")
    print(f"出力先: {output_dir}")

if __name__ == "__main__":
    main()

