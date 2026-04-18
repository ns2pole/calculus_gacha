#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# minimalist plot_polynomial_fraction_problems.py
# Run: python3 plot_polynomial_fraction_problems.py

import os
import math
import numpy as np
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from common import plot_integral_area

N_PLOT = 2500

def h1(x):
    denom = 1.0 + x ** 3
    with np.errstate(divide="ignore", invalid="ignore"):
        return np.where(denom != 0.0, 1.0 / denom, np.nan)

def h2(x):
    denom = x ** 2 + 2.0 * x + 5.0
    with np.errstate(divide="ignore", invalid="ignore"):
        return np.where(denom != 0.0, 1.0 / denom, np.nan)

def h3(x):
    denom = x ** 2 - 4.0
    with np.errstate(divide="ignore", invalid="ignore"):
        return np.where(denom != 0.0, 1.0 / denom, np.nan)

def h4(x):
    denom = x ** 2 + 3.0
    with np.errstate(divide="ignore", invalid="ignore"):
        return np.where(denom != 0.0, 1.0 / denom, np.nan)

PROBLEMS = [
    {
        "question": r"""\displaystyle \int_{1}^{\sqrt{3}}\displaystyle \frac{1}{x^{2}+3}\,dx""",
        "a": 1.0,
        "b": math.sqrt(3.0),
        "func": h4,
        "filename": "problem_1.png",
    },
    {
        "question": r"""\displaystyle \int_{-1}^{1}\displaystyle \frac{1}{x^{2}+2x+5}\,dx""",
        "a": -1.0,
        "b": 1.0,
        "func": h2,
        "filename": "problem_2.png",
    },
    {
        "question": r"""\displaystyle \int_{3}^{6}\displaystyle \frac{1}{x^{2}-4}\,dx""",
        "a": 3.0,
        "b": 6.0,
        "func": h3,
        "filename": "problem_3.png",
        "xmin": 2.5,
        "xmax": 6.5,
    },
    {
        "question": r"""\displaystyle \int_{0}^{1}\displaystyle \frac{1}{1+x^{3}}\,dx""",
        "a": 0.0,
        "b": 1.0,
        "func": h1,
        "filename": "problem_4.png",
    },
]

def main():
    out_dir = "../../../assets/graphs/integral/problems_polynomial_fraction"
    os.makedirs(out_dir, exist_ok=True)
    for p in PROBLEMS:
        out_path = os.path.join(out_dir, p["filename"])
        xmin = p.get("xmin")
        xmax = p.get("xmax")
        plot_integral_area(p["func"], p["a"], p["b"], p["question"], out_path, xmin=xmin, xmax=xmax)

if __name__ == "__main__":
    main()