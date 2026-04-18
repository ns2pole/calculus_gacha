#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# minimalist plot_integration_by_parts_integrals_colored.py
# Run: python3 plot_integration_by_parts_integrals_colored.py

import os, math
import numpy as np
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from common import plot_integral_area2

N_PLOT = 3000

def f1(x):
    return x * np.cos(x)

def f2(x):
    return (x ** 2) * np.exp(x)

def f3(x):
    return x * np.sin(x)

def f4(x):
    return np.exp(x) * np.sin(x)

def f5(x):
    return x * np.exp(-x) * np.sin(2.0 * x)

def f6(x):
    return x * np.exp(x) * np.sin(x)

def f7(x):
    return (x + 1.0) * np.exp(-x)

def f8(x):
    return (x ** 2) * np.cos(x)

def f9(x):
    return np.exp(-2.0 * x) * np.cos(5.0 * x)

PROBLEMS = [
    {
        "tex": r"\displaystyle \int_0^{\pi} x\cos x \,dx",
        "a": 0.0,
        "b": math.pi,
        "func": f1,
        "filename": "problem_1.png",
    },
    {
        "tex": r"\displaystyle \int x^2 e^x \,dx",
        "a": -2.0,
        "b": 2.0,
        "func": f2,
        "filename": "problem_2.png",
    },
    {
        "tex": r"\displaystyle \int_{0}^{\pi} x\sin x \,dx",
        "a": 0.0,
        "b": math.pi,
        "func": f3,
        "filename": "problem_3.png",
    },
    {
        "tex": r"\displaystyle \int e^x \sin x \,dx",
        "a": -4.0,
        "b": 4.0,
        "func": f4,
        "filename": "problem_4.png",
    },
    {
        "tex": r"\displaystyle \int_{0}^{\infty} x e^{-x}\sin 2x\,dx",
        "a": 0.0,
        "b": math.inf,
        "func": f5,
        "improper": True,
        "trunc_b": 8.0,
        "filename": "problem_5.png",
    },
    {
        "tex": r"\displaystyle \int_{ \frac {\pi} {4}}^{\pi} x e^{x}\sin x \,dx",
        "a": math.pi / 4.0,
        "b": math.pi,
        "func": f6,
        "filename": "problem_6.png",
    },
    {
        "tex": r"""\displaystyle
\displaystyle \int_{0}^{\log 2} \displaystyle \frac{x+1}{e^{x}}\,dx""",
        "a": -0.5,
        "b": 1.0,
        "func": f7,
        "filename": "problem_7.png",
    },
    {
        "tex": r"\displaystyle \int_0^{\frac{\pi}{2}} x^2 \cos x \,dx",
        "a": 0.0,
        "b": math.pi / 2.0,
        "func": f8,
        "filename": "problem_9.png",
    },
    {
        "tex": r"\displaystyle \int_{0}^{\frac{\pi}{5}} e^{-2x}\cos 5x \,dx",
        "a": 0.0,
        "b": math.pi / 5.0,
        "func": f9,
        "filename": "problem_10.png",
        "xmin": -1.0,
        "xmax": 1.5,
    },
]

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(os.path.dirname(os.path.dirname(script_dir)))
    out_dir = os.path.join(project_root, "assets", "graphs", "integral", "problems_integration_by_parts")
    os.makedirs(out_dir, exist_ok=True)
    for p in PROBLEMS:
        out_path = os.path.join(out_dir, p["filename"])
        xmin = p.get("xmin")
        xmax = p.get("xmax")
        plot_integral_area2(
            p["func"], p["a"], p["b"], p["tex"], out_path,
            improper=p.get("improper", False), trunc_b=p.get("trunc_b", None),
            xmin=xmin, xmax=xmax
        )

if __name__ == "__main__":
    main()