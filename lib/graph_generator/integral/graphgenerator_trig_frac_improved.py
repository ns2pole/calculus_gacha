#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# minimalist plot_trig_fraction_problems_colored.py
# Run: python3 plot_trig_fraction_problems_colored.py

import os, math
import numpy as np
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from common import plot_integral_area

N_PLOT = 3000

# integrands
def f1(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        denom = 1.0 + np.sin(x)
        return np.where(np.abs(denom) < 1e-12, np.nan, 1.0 / denom)

def f2(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        c = np.cos(x)
        return np.where(np.abs(c) < 1e-12, np.nan, np.sin(x) / (c ** 3))

def f3(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        denom = 1.0 + np.sin(x) ** 2
        return np.where(np.abs(denom) < 1e-12, np.nan, np.cos(x) / denom)

def f4(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        t = np.tan(x)
        denom = 1.0 + t
        out = np.where(np.abs(denom) < 1e-12, np.nan, 1.0 / denom)
        out = np.where(np.abs(np.cos(x)) < 1e-8, np.nan, out)
        return out

def f5(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        denom = np.sin(x) + np.cos(x)
        return np.where(np.abs(denom) < 1e-12, np.nan, 1.0 / denom)

def f6(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        denom = 5.0 * np.sin(x) + 3.0
        return np.where(np.abs(denom) < 1e-12, np.nan, 1.0 / denom)

def f7(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        s = np.sin(x)
        return np.where(np.abs(s) < 1e-12, np.nan, 1.0 / (s ** 4))

def f8(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        s = np.sin(x)
        return np.where(np.abs(s) < 1e-12, np.nan, 1.0 / s)

def f9(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        c = np.cos(x)
        return np.where(np.abs(c) < 1e-12, np.nan, 1.0 / c)

def f10(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        c = np.cos(x)
        return np.where(np.abs(c) < 1e-12, np.nan, 1.0 / (c ** 2))

def f11(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        denom = 2.0 * np.sin(x) + 3.0
        return np.where(np.abs(denom) < 1e-12, np.nan, 1.0 / denom)

def f12(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        c = np.cos(x)
        return np.where(np.abs(c) < 1e-12, np.nan, 1.0 / (c ** 3))

def f11_variant(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        denom = 2.0 + np.sin(x)
        return np.where(np.abs(denom) < 1e-12, np.nan, 1.0 / denom)

def f13(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        c = np.cos(3.0 * x)
        return np.where(np.abs(c) < 1e-12, np.nan, 1.0 / (c ** 2))

# problems
PROBLEMS = [
    {
        "question": r"\displaystyle \int \displaystyle \frac{dx}{1+\sin x}",
        "a": -6.0, "b": 6.0, "func": f1, "filename": "problem_1.png",
        "is_indefinite": True,
    },
    {
        "question": r"\displaystyle \int \displaystyle \frac{\sin x}{\cos^3 x}\,dx",
        "a": -6.0, "b": 6.0, "func": f2, "filename": "problem_2.png",
        "is_indefinite": True,
    },
    {
        "question": r"\displaystyle \int \displaystyle \frac{\cos x}{1+\sin^2 x}\,dx",
        "a": -6.0, "b": 6.0, "func": f3, "filename": "problem_3.png",
        "is_indefinite": True,
    },
    {
        "question": r"\displaystyle \int_{0}^{ \frac{\pi}{2}} \displaystyle \frac{dx}{1+\tan x}",
        "a": 0.0, "b": math.pi / 2.0, "func": f4, "filename": "problem_4.png",
        "is_indefinite": False,
    },
    {
        "question": r"\displaystyle \int \displaystyle \frac{dx}{\sin x + \cos x}",
        "a": -6.0, "b": 6.0, "func": f5, "filename": "problem_5.png",
        "is_indefinite": True,
    },
    {
        "question": r"\displaystyle \int_{ \frac {\pi} {12}}^{ \frac {\pi} {6}}\displaystyle \frac{dx}{5\sin x+3}",
        "a": math.pi / 12.0, "b": math.pi / 6.0, "func": f6, "filename": "problem_6.png",
        "is_indefinite": False,
    },
    {
        "question": r"\displaystyle \int_{ \frac {\pi} {6}}^{ \frac {\pi} {2}}\displaystyle \frac{dx}{\sin^{4}x}",
        "a": math.pi / 6.0, "b": math.pi / 2.0, "func": f7, "filename": "problem_7.png",
        "is_indefinite": False,
    },
    {
        "question": r"\displaystyle \int_{\frac{\pi}{6}}^{\frac{\pi}{2}} \frac{dx}{\sin x}",
        "a": math.pi / 6.0, "b": math.pi / 2.0, "func": f8, "filename": "problem_8.png",
        "is_indefinite": False,
        "xmin": math.pi / 12.0,
        "xmax": 2.0 * math.pi / 3.0,
    },
    {
        "question": r"\displaystyle \int_{0}^{\frac{\pi}{4}} \frac{dx}{\cos x}",
        "a": 0.0, "b": math.pi / 4.0, "func": f9, "filename": "problem_9.png",
        "is_indefinite": False,
    },
    {
        "question": r"\displaystyle \int_{0}^{\frac{\pi}{4}} \frac{dx}{\cos^2 x}",
        "a": 0.0, "b": math.pi / 4.0, "func": f10, "filename": "problem_10.png",
        "is_indefinite": False,
    },
    {
        "question": r"\displaystyle \int_{0}^{\frac{\pi}{2}} \frac{dx}{2\sin x + 3}",
        "a": 0.0, "b": math.pi / 2.0, "func": f11, "filename": "problem_11.png",
        "is_indefinite": False,
    },
    {
        "question": r"\displaystyle \int_{-\frac{\pi}{6}}^{\frac{\pi}{6}} \frac{dx}{\cos^3 x}",
        "a": -math.pi / 6.0, "b": math.pi / 6.0, "func": f12, "filename": "problem_12.png",
        "is_indefinite": False,
    },
    {
        "question": r"\displaystyle \int_{0}^{\frac{\pi}{2}} \frac{dx}{2 + \sin x}",
        "a": 0.0, "b": math.pi / 2.0, "func": f11_variant, "filename": "problem_11_variant.png",
        "is_indefinite": False,
    },
    {
        "question": r"\displaystyle \int_{-\frac{\pi}{12}}^{\frac{\pi}{12}} \frac{dx}{\cos^2(3x)}",
        "a": -math.pi / 12.0, "b": math.pi / 12.0, "func": f13, "filename": "problem_13.png",
        "is_indefinite": False,
        "xmin": -0.4,
        "xmax": 0.4,
    },
]


def main():
    out_dir = "../../../assets/graphs/integral/problems_trig_fraction"
    os.makedirs(out_dir, exist_ok=True)
    for p in PROBLEMS:
        out_path = os.path.join(out_dir, p["filename"])
        xmin = p.get("xmin")
        xmax = p.get("xmax")
        plot_integral_area(p["func"], p["a"], p["b"], p["question"], out_path, is_indef=p.get("is_indefinite", False), xmin=xmin, xmax=xmax)

if __name__ == "__main__":
    main()