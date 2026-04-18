#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# minimalist plot_substitution_problems_colored.py
# Run: python3 plot_substitution_problems_colored.py

import os, math
import numpy as np
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from common import plot_integral_area_sub

N_PLOT = 2500

# integrands
def s1(x):
    return np.sin(x) * np.cos(x)

def s2(x):
    with np.errstate(invalid="ignore", divide="ignore"):
        return x / np.sqrt(1.0 + x ** 2)

def s3(x):
    val = 9.0 - x ** 2
    with np.errstate(divide="ignore", invalid="ignore"):
        return np.where(val > 0.0, 1.0 / np.sqrt(val), np.nan)

def s4(x):
    val = 16.0 - x ** 2
    with np.errstate(divide="ignore", invalid="ignore"):
        return np.where(val > 0.0, 1.0 / np.sqrt(val), np.nan)


def s5(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        mask = (x > 0.0) & (np.abs(x - 1.0) > 1e-10)  # x=1でlog(1)=0なので発散を避ける
        out = np.full_like(x, np.nan, dtype=float)
        log_x = np.log(x[mask])
        out[mask] = 1.0 / (x[mask] * log_x)
        return out

def s6(x):
    return (np.sin(x) ** 2) * np.cos(x)

def s7(x):
    return 1.0 / (1.0 + x ** 2)

def s8(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        prod = x * (1.0 - x)
        return np.where(prod > 0.0, 1.0 / np.sqrt(prod), np.nan)

def s9(x, n=2):
    with np.errstate(invalid="ignore"):
        val = 1.0 - x ** 2
        mask = val >= 0.0
        out = np.full_like(x, np.nan, dtype=float)
        out[mask] = val[mask] ** (3)
        return out

def s10(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        mask = x > 0.0
        out = np.full_like(x, np.nan, dtype=float)
        m = mask & (x != 0.0)
        out[m] = np.log(x[m]) / (x[m] ** 2)
        return out

def s11(x):
    with np.errstate(invalid="ignore", divide="ignore"):
        t = np.tan(x)
        return t ** 2 * (1.0 + t ** 2)

PROBLEMS = [
    {
        "question": r"\displaystyle \int_{0}^{\frac{\pi}{4}} \sin x \cos x \,dx",
        "a": 0.0, "b": math.pi / 4.0, "func": s1,
        "filename": "problem_1.png",
    },
    {
        "question": r"\displaystyle \int_{0}^{\sqrt{3}} \frac{x}{\sqrt{1+x^{2}}}\,dx",
        "a": 0.0, "b": math.sqrt(3.0), "func": s2,
        "filename": "problem_2.png",
    },
    {
        "question": r"\displaystyle \int_{0}^{\frac{3}{2}} \frac{dx}{\sqrt{9 - x^{2}}}",
        "a": 0.0, "b": 1.5, "func": s3,
        "filename": "problem_3.png",
    },
    {
        "question": r"\displaystyle \int_{2}^{2\sqrt{3}} \frac{dx}{\sqrt{16 - x^{2}}}",
        "a": 2.0, "b": 2.0 * math.sqrt(3.0), "func": s4,
        "filename": "problem_4.png",
    },
    {
        "question": r"\displaystyle \int_{e}^{e^{2}} \frac{dx}{x\log x}",
        "a": math.e, "b": math.e ** 2, "func": s5,
        "filename": "problem_5.png",
        "xmin": 2.0,  # グラフの表示範囲
        "xmax": 9.0,
    },
    {
        "question": r"\displaystyle \int_{0}^{\frac{\pi}{6}} \sin^{2}x \cos x \,dx",
        "a": 0.0, "b": math.pi / 6.0, "func": s6,
        "filename": "problem_6.png",
    },
    {
        "question": r"\displaystyle \int_{0}^{1} \frac{dx}{1 + x^{2}}",
        "a": 0.0, "b": 1.0, "func": s7,
        "filename": "problem_7.png",
    },
    {
        "question": r"\displaystyle \int_{\frac{1}{4}}^{\frac{3}{4}} \frac{dx}{\sqrt{x(1-x)}}",
        "a": 0.25, "b": 0.75, "func": s8,
        "filename": "problem_8.png",
    },
    {
        "question": r"\displaystyle \int_{-1}^{1}(1-x^{2})^{3}\,dx",
        "a": -1.0, "b": 1.0, "func": s9,
        "filename": "problem_9.png",
    },
    {
        "question": r"\displaystyle \int_{1}^{e}\frac{\log  x}{x^{2}}\,dx",
        "a": 1.0, "b": math.e, "func": s10,
        "filename": "problem_10.png",
    },
    {
        "question": r"\displaystyle \int_{\frac{\pi}{4}}^{\frac{\pi}{3}}\tan^{2}x\left(\tan^{2}x+1\right)\,dx",
        "a": math.pi / 3, "b": math.pi / 4, "func": s11,
        "filename": "problem_11.png",
        # ここで描画範囲を指定
        "xmin": 5 * math.pi / 24,
        "xmax": 3 * math.pi / 8,
    },
]


def main():
    # スクリプトの場所からプロジェクトルートを取得
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.join(script_dir, "..", "..", "..")
    out_dir = os.path.join(project_root, "assets", "graphs", "integral", "problems_substitution")
    os.makedirs(out_dir, exist_ok=True)
    for p in PROBLEMS:
        out_path = os.path.join(out_dir, p["filename"])
        plot_integral_area_sub(
            p["func"],
            p["a"],
            p["b"],
            p["question"],
            out_path,
            params=p.get("params"),
            improper=p.get("improper", False),
            xmin=p.get("xmin"),   # ← 追加
            xmax=p.get("xmax"),   # ← 追加
        )

if __name__ == "__main__":
    main()