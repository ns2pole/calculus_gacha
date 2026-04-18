#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# minimalist plot_others_problems.py
# Run: python3 plot_others_problems.py

import os, math
import numpy as np
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from common import plot_integral_area_other

N_PLOT = 2000

def h1(x):
    return (x ** 4) * (np.sin(x) ** 5)

def h2(x):
    return np.sqrt(np.maximum(0.0, 1.0 + np.sin(x)))

def h3(x):
    return x * np.sin(x) / (3.0 + np.sin(x))

PROBLEMS = [
    {
        "question": r"\int_{-2}^{2} x^4 \sin^5 x \, dx",
        "a": -2.0,
        "b": 2.0,
        "func": h1,
        "filename": "problem_1.png",
        # optional: 描画範囲を指定したいときだけ追加する
        "xmin": -3.0,
        "xmax":  3.0,
    },
    {
        "question": r"\int_{\frac{\pi}{2}}^{\frac{5\pi}{2}} \sqrt{1+\sin x}\,dx",
        "a": math.pi / 2.0,
        "b": 5.0 * math.pi / 2.0,
        "func": h2,
        "filename": "problem_2.png",
    },
    {
        "question": r"\int_{0}^{\pi} \frac{x\sin x}{3+\sin x}\,dx",
        "a": 0.0,
        "b": math.pi,
        "func": h3,
        "filename": "problem_3.png",
    },
]



def main():
    out_dir = "../../../assets/graphs/problems_others"
    os.makedirs(out_dir, exist_ok=True)
    for p in PROBLEMS:
        out_path = os.path.join(out_dir, p["filename"])
        # dict.get を使ってキーが無ければ None を渡す（関数側は None でデフォルト動作）
        xmin = p.get("xmin")
        xmax = p.get("xmax")
        plot_integral_area_other(
            p["func"],
            p["a"],
            p["b"],
            p["question"],
            out_path,
            params=p.get("params"),        # 既に使っていればそのまま
            improper=p.get("improper", False),
            trunc_b=p.get("trunc_b"),
            xmin=xmin,
            xmax=xmax,
        )


if __name__ == "__main__":
    main()