#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# minimalist plot_trig_polynomial_problems_colored.py
# Run: python3 plot_trig_polynomial_problems_colored.py

import os, math
import numpy as np
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from common import plot_integral_area

N_PLOT = 3000

def f1(x):  return np.sin(x) ** 2
def f2(x):  return np.sin(x) ** 3
def f3(x):  return np.sin(x) ** 4
def f4(x):  return (np.sin(x) ** 2) * (np.cos(x) ** 2)

def f5(x):
    return np.cos(x) ** 3

def f5_1(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        c = np.cos(x)
        return np.where(np.abs(c) < 1e-12, np.nan, 1.0 / (c ** 2))

def f5_2(x):
    with np.errstate(divide="ignore", invalid="ignore"):
        t = np.tan(x)
        return np.where(np.abs(t) < 1e-12, np.nan, 1.0 / (t ** 2))

def f6(x):  return np.sin(x) * (1.0 + np.cos(x) + np.cos(x) ** 2)
def f7(x):  return np.cos(x) ** 2
def f8(x):  return np.sin(x) ** 9
def f9(x):  return np.sin(x) ** 10
def f10(x): return np.sin(2.0 * x) * np.sin(5.0 * x)
def f11(x): return np.sin(2.0 * x) * np.cos(3.0 * x)

def f12(x):
    with np.errstate(all='ignore'):
        return np.tan(x) ** 6

def f13(x):
    return (np.sin(x) ** 7) * (np.cos(x) ** 9)

PROBLEMS = [
    # no: 1 - ∫₀^π sin²x dx
    {"question": r"\displaystyle \int_0^{\pi} \sin^2 x \, dx", "a": 0.0, "b": math.pi, "func": f1, "filename": "problem_1.png"},
    # no: 2 - ∫_{0}^{π/6} sin³x dx
    {"question": r"\displaystyle \int_{0}^{\frac{\pi}{6}} \sin^3 x \, dx", "a": 0.0, "b": math.pi / 6.0, "func": f2, "filename": "problem_2.png"},
    # no: 3 - ∫₀^{π/2} sin⁴x dx
    {"question": r"\displaystyle \int_0^{ \frac{\pi}{2}} \sin^4 x \, dx", "a": 0.0, "b": math.pi / 2.0, "func": f3, "filename": "problem_3.png"},
    # no: 4 - ∫₀^(π/3) sin²x cos²x dx
    {"question": r"\displaystyle \int_0^{\frac{\pi}{3}} \sin^2 x \cos^2 x \, dx", "a": 0.0, "b": math.pi / 3.0, "func": f4, "filename": "problem_4.png"},
    # no: 5 - ∫_{π/8}^{π/4} 1/tan²x dx
    {"question": r"\displaystyle \int_{\frac{\pi}{8}}^{\frac{\pi}{4}} \frac{1}{\tan^2 x} \, dx", "a": math.pi / 8.0, "b": math.pi / 4.0, "func": f5_2, "filename": "problem_5.png", "xmax": 0.85},
    # no: 6 - ∫_{-π/4}^{π/4} cos³x dx
    {"question": r"\displaystyle \int_{-\frac{\pi}{4}}^{\frac{\pi}{4}} \cos^3 x \, dx", "a": -math.pi / 4.0, "b": math.pi / 4.0, "func": f5, "filename": "problem_6.png"},
    # no: 7 - ∫_{0}^{π/4} 1/cos²x dx
    {"question": r"\displaystyle \int_{0}^{\frac{\pi}{4}} \frac{dx}{\cos^2 x}", "a": 0.0, "b": math.pi / 4.0, "func": f5_1, "filename": "problem_7.png"},
    # no: 8 - ∫₀^{π/2} cos²x dx
    {"question": r"\displaystyle \int_0^{ \frac{\pi}{2}} \cos^2 x \, dx", "a": 0.0, "b": math.pi / 2.0, "func": f7, "filename": "problem_8.png"},
    # no: 9 - ∫₀^π sin¹⁰x dx
    {"question": r"\displaystyle \int_0^{\pi}\sin^{10}x\,dx", "a": 0.0, "b": math.pi, "func": f9, "filename": "problem_9.png"},
    # no: 10 - ∫₀^{2π} sin(2x)sin(5x) dx
    {"question": r"\displaystyle \int_0^{2\pi}\sin(2x)\sin(5x)\,dx", "a": 0.0, "b": 2.0 * math.pi, "func": f10, "filename": "problem_10.png"},
    # no: 11 - ∫₀^{2π} sin(2x)cos(3x) dx
    {"question": r"\displaystyle \int_0^{2\pi}\sin(2x)\cos(3x)\,dx", "a": 0.0, "b": 2.0 * math.pi, "func": f11, "filename": "problem_11.png"},
    # no: 12 - ∫₀^{π/4} tan⁶x dx
    {"question": r"\displaystyle \int_{0}^{\frac{\pi}{4}} \tan^6 x \, dx", "a": 0.0, "b": math.pi / 4.0, "func": f12, "filename": "problem_12.png", "xmax": 0.85},
    # no: 13 - ∫₀^{π/2} sin⁷x cos⁹x dx
    {"question": r"\displaystyle \int_{0}^{\frac{\pi}{2}} \sin^7 x \cos^9 x \, dx", "a": 0.0, "b": math.pi / 2.0, "func": f13, "filename": "problem_13.png", "xmin": -0.5, "xmax": 2.0},
]

def main():
    out_dir = "../../../assets/graphs/integral/problems_trig_polynomial"
    os.makedirs(out_dir, exist_ok=True)
    for p in PROBLEMS:
        out_path = os.path.join(out_dir, p["filename"])
        xmin = p.get("xmin")
        xmax = p.get("xmax")
        plot_integral_area(p["func"], p["a"], p["b"], p["question"], out_path, is_indef=p.get("is_indefinite", False), xmin=xmin, xmax=xmax)

if __name__ == "__main__":
    main()