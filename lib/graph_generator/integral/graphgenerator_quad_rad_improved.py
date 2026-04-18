#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# plot_quadratic_radical_problems_colored.py
# Run: python3 plot_quadratic_radical_problems_colored.py

import os
import numpy as np
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from common import plot_integral_area_for_quad

N_PLOT = 2500


# functions to plot
def q1(x):
    with np.errstate(invalid="ignore"):
        return np.sqrt(x**2 + 1.0)

def q2(x):
    val = 1.0 - x**2
    with np.errstate(divide="ignore", invalid="ignore"):
        return np.where(val > 0.0, 1.0 / np.sqrt(val), np.nan)

def q3(x):
    with np.errstate(invalid="ignore"):
        return np.sqrt(x**2 + 4.0*x + 5.0)

def q4(x):
    denom = np.sqrt(x**2 + 1.0)
    with np.errstate(invalid="ignore", divide="ignore"):
        return np.where(denom != 0.0, (x**2) / denom, np.nan)

def q5(x, a=1.0):
    val = x**2 - a**2
    with np.errstate(divide="ignore", invalid="ignore"):
        return np.where(val > 0.0, 1.0 / np.sqrt(val), np.nan)

def q7(x):
    denom = x**2 + 2.0
    with np.errstate(divide="ignore", invalid="ignore"):
        return np.where(denom != 0.0, 1.0 / (denom * np.sqrt(denom)), np.nan)

def q9(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        return 1.0 / np.sqrt(x**2 + 1.0)

def q10(x):
    with np.errstate(invalid="ignore", divide="ignore"):
        return 1.0 / (x + np.sqrt(x**2 + 1.0))

def q11(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        return 1.0 / np.sqrt(x**2 + 9.0)

def q12(x):
    denom = 4.0 + x**2
    with np.errstate(divide="ignore", invalid="ignore"):
        return np.where(denom != 0.0, 1.0 / (denom * np.sqrt(denom)), np.nan)

PROBLEMS = [
    {
        "question": r"""\displaystyle \int \sqrt{x^2+1}\,dx""",
        "a": -4.0,
        "b": 4.0,
        "func": q1,
        "filename": "problem_1.png",
    },
    {
        "question": r"""\displaystyle \int_{-1}^{1} \displaystyle \frac{dx}{\sqrt{1-x^2}}""",
        "a": -1.0,
        "b": 1.0,
        "func": q2,
        "filename": "problem_2.png",
    },
    {
        "question": r"""\displaystyle \int \sqrt{x^2+4x+5}\,dx""",
        "a": -4.0,
        "b": 4.0,
        "func": q3,
        "filename": "problem_3.png",
    },
    {
        "question": r"""\displaystyle \int \displaystyle \frac{x^2}{\sqrt{x^2+1}}\,dx""",
        "a": -4.0,
        "b": 4.0,
        "func": q4,
        "filename": "problem_4.png",
    },
    {
        "question": r"""\displaystyle \int \displaystyle \frac{dx}{\sqrt{x^2 - a^2}}\quad (x>a>0)""",
        "params": {"a": 1.0},
        "a": 1.01,
        "b": 6.0,
        "func": q5,
        "filename": "problem_5.png",
    },
    {
        "question": r"""\displaystyle \int_{-1}^{1}\displaystyle \frac{dx}{(x^2+2)\sqrt{x^2+2}}""",
        "a": -1.0,
        "b": 1.0,
        "func": q7,
        "filename": "problem_7.png",
    },
    {
        "question": r"""\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{\sqrt{x^{2}+1}}""",
        "a": 0.0,
        "b": 1.0,
        "func": q9,
        "filename": "problem_9.png",
    },
    {
        "question": r"""\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{x+\sqrt{x^{2}+1}}""",
        "a": 0.0,
        "b": 1.0,
        "func": q10,
        "filename": "problem_10.png",
    },
    {
        "question": r"""\displaystyle \int_{0}^{3} \frac{dx}{\sqrt{x^2+9}}""",
        "a": 0.0,
        "b": 3.0,
        "func": q11,
        "filename": "problem_11.png",
    },
    {
        "question": r"""\displaystyle \int_{0}^{2} \frac{dx}{(4+x^2)^{3/2}}""",
        "a": 0.0,
        "b": 2.0,
        "func": q12,
        "filename": "problem_12.png",
    },
]

def main():
    out_dir = "../../../assets/graphs/integral/problems_quadratic_radical"
    os.makedirs(out_dir, exist_ok=True)
    for p in PROBLEMS:
        out_path = os.path.join(out_dir, p["filename"])
        plot_integral_area_for_quad(p["func"], p["a"], p["b"], p["question"], out_path, params=p.get("params"))

if __name__ == "__main__":
    main()