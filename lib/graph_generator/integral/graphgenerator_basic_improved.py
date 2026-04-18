#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# basic_formula_plotter.py
# 3 問（対数・tan・指数）をプロットし、積分領域を塗り分ける最小実装
# 実行: python3 basic_formula_plotter.py

import os
import sys
import math
import numpy as np
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from common import plot_integral_area_beta

N_PLOT = 2500

# 被積分関数
def q1(x):
    with np.errstate(divide='ignore', invalid='ignore'):
        x = np.array(x)
        out = np.where(x > 0.0, np.log(x), np.nan)
        return out

def q2(x):
    with np.errstate(all='ignore'):
        return np.tan(x)

def q3(x):
    with np.errstate(all='ignore'):
        return np.exp(x * math.log(2.0))

# 問題定義（画像出力に必要な最小情報のみ）
PROBLEMS = [
    {
        "question": r"""\int_{1}^{e} \log x \, dx""",
        "a": 1.0,
        "b": math.e,
        "func": q1,
        "filename": "problem_1.png",
    },
    {
        "question": r"""\int_{\frac{\pi}{6}}^{\frac{\pi}{4}} \tan x \, dx""",
        "a": math.pi / 6.0,
        "b": math.pi / 4.0,
        "func": q2,
        "filename": "problem_2.png",
    },
    {
        "question": r"""\int_{\frac{1}{4}}^{\frac{1}{2}} 2^{x} \, dx""",
        "a": 0.25,
        "b": 0.5,
        "func": q3,
        "filename": "problem_3.png",
    },
]

def main():
    out_dir = "../../../assets/graphs/problems_basic_formula"
    os.makedirs(out_dir, exist_ok=True)
    for p in PROBLEMS:
        out_path = os.path.join(out_dir, p["filename"])
        plot_integral_area_beta(p["func"], p["a"], p["b"], p["question"], out_path, is_indef=p.get("is_indefinite", False))

if __name__ == "__main__":
    main()