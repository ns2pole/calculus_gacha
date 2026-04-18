#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# exponential_fraction_plotter_min.py
# 実行: python3 exponential_fraction_plotter_min.py

import os
import sys
import numpy as np
import math
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from common import plot_integral_area

N_PLOT = 2500

# 被積分関数
def f1(x, params=None):
    x = np.array(x, dtype=float)
    with np.errstate(all='ignore'):
        ex = np.exp(x)
        return (ex * ex) / (1.0 + ex) ** 2

def f2(x, params=None):
    x = np.array(x, dtype=float)
    with np.errstate(all='ignore'):
        return 1.0 / (1.0 + np.exp(-x))

def f3(x, params=None):
    x = np.array(x, dtype=float)
    with np.errstate(all='ignore', divide='ignore'):
        return 2.0 / (np.exp(x) + np.exp(-x))

# プロット対象
PROBLEMS = [
    {
        "question": r"""\int_{0}^{\log 2} \frac{e^{2x}}{(1+e^x)^2}\,dx""",
        "a": 0.0,
        "b": math.log(2.0),
        "func": f1,
        "filename": "problem_1.png",
    },
    {
        "question": r"""\int_{0}^{\log 2} \frac{1}{1+e^{-x}}\,dx""",
        "a": 0.0,
        "b": math.log(2.0),
        "func": f2,
        "filename": "problem_2.png",
    },
    {
        "question": r"""\int_{0}^{\frac{\log 3}{2}} \frac{2\,dx}{e^x+e^{-x}}""",
        "a": 0.0,
        "b": math.log(3.0) / 2.0,
        "func": f3,
        "filename": "problem_3.png",
    },
]

def main():
    out_dir = "../../../assets/graphs/integral/problems_exponential_fraction"
    os.makedirs(out_dir, exist_ok=True)
    for p in PROBLEMS:
        out_path = os.path.join(out_dir, p["filename"])
        plot_integral_area(p["func"], p["a"], p["b"], p["question"], out_path)

if __name__ == "__main__":
    main()