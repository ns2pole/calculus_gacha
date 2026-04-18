#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# plot_abs_definite_integrals.py
# Run: python3 plot_abs_definite_integrals.py

import os, math
import numpy as np
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from common import plot_integral_area

N_PLOT = 4000

def f1(x):
    return np.abs(x)

def f2(x):
    return np.abs(np.sin(x))

def f3(x):
    return np.abs(x * x - 0.25)

def f4(x):
    return np.abs(x - 1.0) ** 3

PROBLEMS = [
    {
        "tex": r"\displaystyle \int_{-2}^{3} |x|\,dx",
        "a": -2.0,
        "b": 3.0,
        "func": f1,
        "filename": "problem_1.png",
    },
    {
        "tex": r"\displaystyle \int_{0}^{2\pi} |\sin x|\,dx",
        "a": 0.0,
        "b": 2.0 * math.pi,
        "func": f2,
        "filename": "problem_2.png",
    },
    {
        "tex": r"\displaystyle \int_{-1}^{1} \left| x^2 - \displaystyle \frac{1}{4} \right| \, dx",
        "a": -1.0,
        "b": 1.0,
        "func": f3,
        "filename": "problem_3.png",
    },
    {
        "tex": r"\displaystyle \int_{0}^{2} |x-1|^3\,dx",
        "a": 0.0,
        "b": 2.0,
        "func": f4,
        "filename": "problem_4.png",
    },
]

def main():
    out_dir = "../../../assets/graphs/problems_abs_definite"
    os.makedirs(out_dir, exist_ok=True)
    for p in PROBLEMS:
        out_path = os.path.join(out_dir, p["filename"])
        plot_integral_area(p["func"], p["a"], p["b"], p["tex"], out_path, is_indef=p.get("is_indefinite", False))

if __name__ == "__main__":
    main()