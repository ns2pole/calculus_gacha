#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# minimalist plot_linear_radical_problems_colored.py
# Run: python3 plot_linear_radical_problems_colored.py

import os
import numpy as np
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from common import plot_integral_area_lin

N_PLOT = 2000

def g1(x):
    val = 1.0 + 2.0 * x
    with np.errstate(invalid="ignore"):
        return np.where(val >= 0.0, np.sqrt(val), np.nan)

def g2(x, a=1.0, b=1.0):
    val = a * x + b
    with np.errstate(invalid="ignore", divide="ignore"):
        return np.where(val > 0.0, 1.0 / np.sqrt(val), np.nan)

def g3(x):
    val = 1.0 - 2.0 * x
    with np.errstate(invalid="ignore"):
        return np.where(val >= 0.0, np.sqrt(val), np.nan)

PROBLEMS = [
    {
        "question": r"\displaystyle \int_{0}^{1} \sqrt{1+2x}\,dx",
        "a": 0.0,
        "b": 1.0,
        "func": g1,
        "filename": "problem_1.png",
        "is_indefinite": False,
    },
    {
        "question": r"\displaystyle \int_{0}^{2} \displaystyle \frac{dx}{\sqrt{2x + 5}}",
        "a": 0.0,
        "b": 2.0,
        "func": g2,
        "params": {"a": 2.0, "b": 5.0},
        "filename": "problem_2.png",
        "is_indefinite": False,
    },
    {
        "question": r"\displaystyle \int_{0}^{\frac{1}{2}} \sqrt{1 - 2x}\,dx",
        "a": 0.0,
        "b": 0.5,
        "func": g3,
        "filename": "problem_3.png",
    },
]

def main():
    out_dir = "../../../assets/graphs/integral/problems_linear_radical"
    os.makedirs(out_dir, exist_ok=True)
    for idx, p in enumerate(PROBLEMS, start=1):
        out_path = os.path.join(out_dir, p["filename"])
        params = p.get("params", None)
        plot_integral_area_lin(
            p["func"], p["a"], p["b"], p["question"], out_path,
            params=params,
            is_indef=p.get("is_indefinite", False)
        )

if __name__ == "__main__":
    main()