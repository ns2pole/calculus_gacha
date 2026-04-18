#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# basic_formula_plotter_updated_min.py
# 9 問（β関数系統の定積分）のグラフと積分領域を画像出力する最小構成

import os
import numpy as np
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from common import plot_integral_area_beta
N_PLOT = 2500

# 被積分関数
def f1(x, params=None):
    alpha = params.get("alpha", 0.0) if params else 0.0
    beta = params.get("beta", 1.0) if params else 1.0
    x = np.array(x)
    return (x - alpha) * (beta - x)

def f2(x, params=None):
    return f1(x, params)

def f3(x, params=None):
    alpha = params.get("alpha", 0.0) if params else 0.0
    beta = params.get("beta", 1.0) if params else 1.0
    x = np.array(x)
    return (x - alpha) * (beta - x) ** 2

def f4(x, params=None):
    return f3(x, params)

def f5(x, params=None):
    return f3(x, params)

def f6(x, params=None):
    alpha = params.get("alpha", 1.0) if params else 1.0
    beta = params.get("beta", 3.0) if params else 3.0
    x = np.array(x)
    return (x - alpha) ** 2 * (beta - x) ** 2

def f7(x, params=None):
    return f6(x, params)

def f8(x, params=None):
    return f6(x, params)

def f9(x, params=None):
    m = int(params.get("m", 3)) if params else 3
    n = int(params.get("n", 4)) if params else 4
    x = np.array(x)
    with np.errstate(all="ignore"):
        return np.where((x >= 0.0) & (x <= 1.0), (x ** (m - 1)) * ((1.0 - x) ** (n - 1)), np.nan)

# 問題定義（画像出力に必要な最小情報）
PROBLEMS = [
    {
        "question": r"\displaystyle \int_{\alpha}^{\beta}(x-\alpha)\,(\beta-x)\,dx",
        "func": f1,
        "params": {"alpha": 0.0, "beta": 1.0},
        "a": 0.0,
        "b": 1.0,
        "filename": "problem_1.png",
    },
    {
        "question": r"\displaystyle \int_{2}^{5}(x-2)(5-x)\,dx",
        "func": f2,
        "params": {"alpha": 2.0, "beta": 5.0},
        "a": 2.0,
        "b": 5.0,
        "filename": "problem_2.png",
        "xmin": 0.5,
        "xmax": 6.5,
    },
    {
        "question": r"\displaystyle \int_{ \frac12}^{ \frac32}\left(x-\displaystyle \frac12\right)\left(\displaystyle \frac32-x\right)^2\,dx",
        "func": f3,
        "params": {"alpha": 0.5, "beta": 1.5},
        "a": 0.5,
        "b": 1.5,
        "filename": "problem_3.png",
        "xmin": 0,
        "xmax": 2.0,
    },
    {
        "question": r"\displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)^2\,dx",
        "func": f4,
        "params": {"alpha": 0.0, "beta": 1.0},
        "a": 0.0,
        "b": 1.0,
        "filename": "problem_4.png",
    },
    {
        "question": r"\displaystyle \int_{1}^{4}(x-1)(4-x)^2\,dx",
        "func": f5,
        "params": {"alpha": 1.0, "beta": 4.0},
        "a": 1.0,
        "b": 4.0,
        "filename": "problem_5.png",
        "xmin": -0.5,
        "xmax":  5.5,
    },
    {
        "question": r"\displaystyle \int_{1}^{3}(x-1)^2(3-x)^2\,dx",
        "func": f6,
        "params": {"alpha": 1.0, "beta": 3.0},
        "a": 1.0,
        "b": 3.0,
        "filename": "problem_6.png",
        "xmin":  0.0,
        "xmax":  4.0,
    },
    {
        "question": r"\displaystyle \int_{\alpha}^{\beta}(x-\alpha)^2(\beta-x)^2\,dx",
        "func": f7,
        "params": {"alpha": 0.0, "beta": 1.0},
        "a": 0.0,
        "b": 1.0,
        "filename": "problem_7.png",
        "xmin": -0.5,
        "xmax":  1.5,
    },
    {
        "question": r"\displaystyle \int_{2}^{5}(x-2)^2(5-x)^2\,dx",
        "func": f8,
        "params": {"alpha": 2.0, "beta": 5.0},
        "a": 2.0,
        "b": 5.0,
        "filename": "problem_8.png",
        "xmin":  0.5,
        "xmax":  6.5,
    },
    {
        "question": r"\displaystyle \int_{0}^{1}x^{m-1}(1-x)^{n-1}\,dx\quad(m,n\in\mathbb{Z}_{>0})",
        "func": f9,
        "params": {"m": 3, "n": 4},
        "a": 0.0,
        "b": 1.0,
        "filename": "problem_9.png",
    },
]


def main():
    out_dir = "../../../assets/graphs/problems_beta_function"
    os.makedirs(out_dir, exist_ok=True)
    for p in PROBLEMS:
        out_path = os.path.join(out_dir, p["filename"])
        xmin = p.get("xmin")
        xmax = p.get("xmax")
        plot_integral_area_beta(
            p["func"],
            p["a"],
            p["b"],
            p["question"],
            out_path,
            params=p.get("params", None),
            is_indef=p.get("is_indefinite", False),
            xmin=xmin,
            xmax=xmax,
        )

if __name__ == "__main__":
    main()