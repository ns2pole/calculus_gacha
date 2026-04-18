#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
不定方程式問題のグラフ生成器
2変数の方程式をグラフ化し、整数解（格子点）を赤丸で表示
"""

import sys
import os
import math
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from mpl_toolkits.mplot3d import Axes3D

# 日本語フォントの設定
plt.rcParams['font.family'] = ['DejaVu Sans', 'Hiragino Sans', 'Yu Gothic', 'Meiryo', 'Takao', 'IPAexGothic', 'IPAPGothic', 'VL PGothic', 'Noto Sans CJK JP']

# フォント検索の警告を無効化
import warnings
import logging
warnings.filterwarnings('ignore')
logging.getLogger('matplotlib.font_manager').setLevel(logging.ERROR)
import matplotlib
matplotlib.rcParams['font.family'] = ['DejaVu Sans']

# グラフのフォントサイズ設定を統一するヘルパー関数
def setup_large_fonts(ax, title_fontsize=20, label_fontsize=18, tick_fontsize=16, legend_fontsize=14):
    """グラフのフォントサイズを大きく設定するヘルパー関数"""
    # 軸ラベルのフォントサイズ
    ax.set_xlabel(ax.get_xlabel(), fontsize=label_fontsize)
    ax.set_ylabel(ax.get_ylabel(), fontsize=label_fontsize)
    
    # タイトルのフォントサイズ
    title = ax.get_title()
    if title:
        ax.set_title(title, fontsize=title_fontsize, pad=15)
    
    # 目盛りのフォントサイズ
    ax.tick_params(axis='both', which='major', labelsize=tick_fontsize)
    ax.tick_params(axis='both', which='minor', labelsize=tick_fontsize)
    
    # 凡例のフォントサイズ
    legend = ax.get_legend()
    if legend:
        legend.set_fontsize(legend_fontsize)

def plot_linear_equation(ax, a, b, c, x_range=(-20, 20), y_range=(-20, 20)):
    """1次方程式 ax + by = c をプロット"""
    x = np.linspace(x_range[0], x_range[1], 1000)
    if abs(b) > 1e-10:
        y = (c - a * x) / b
        ax.plot(x, y, 'b-', linewidth=3, label=f'${a}x + {b}y = {c}$', zorder=5)
    else:
        # b=0の場合、x = c/a の垂直線
        x_val = c / a if abs(a) > 1e-10 else 0
        ax.axvline(x=x_val, color='b', linewidth=3, label=f'${a}x = {c}$', zorder=5)


def plot_implicit_equation(ax, func, x_range=(-20, 20), y_range=(-20, 20), resolution=500):
    """陰関数 f(x,y) = 0 をプロット"""
    x_vals = np.linspace(x_range[0], x_range[1], resolution)
    y_vals = np.linspace(y_range[0], y_range[1], resolution)
    X, Y = np.meshgrid(x_vals, y_vals)
    
    Z = func(X, Y)
    
    # Z=0の等高線を描画（ラベルなし）
    contour = ax.contour(X, Y, Z, levels=[0], colors='b', linewidths=3, zorder=5)

def plot_integer_solutions(ax, solutions):
    """整数解を赤丸でプロット"""
    if isinstance(solutions, str):
        # 文字列から解を抽出（例: "(1,2),(-3,2)"）
        import re
        pattern = r'\((-?\d+),(-?\d+)\)'
        matches = re.findall(pattern, solutions)
        solutions = [(int(x), int(y)) for x, y in matches]
    
    for x, y in solutions:
        ax.plot(x, y, 'ro', markersize=14, markeredgecolor='darkred', markeredgewidth=3, 
                label='Integer solution' if (x, y) == solutions[0] else '', zorder=10)

def plot_lattice_points(ax, x_min, x_max, y_min, y_max, step=1, alpha=0.3):
    """格子点（整数座標の交点）を小さな点で表示"""
    # 整数の格子点を計算
    x_ints = np.arange(np.ceil(x_min), np.floor(x_max) + 1, step)
    y_ints = np.arange(np.ceil(y_min), np.floor(y_max) + 1, step)
    
    # すべての格子点をプロット
    for x in x_ints:
        for y in y_ints:
            ax.plot(x, y, 'ko', markersize=2, alpha=alpha, zorder=1)

def calculate_optimal_range(solutions, x_range=None, y_range=None, margin_ratio=0.15):
    """
    整数解と曲線の範囲から最適な表示範囲を計算
    
    Parameters:
    - solutions: 整数解のリスト [(x1, y1), (x2, y2), ...]
    - x_range: 曲線のx範囲 (x_min, x_max) または None
    - y_range: 曲線のy範囲 (y_min, y_max) または None
    - margin_ratio: マージンの比率（デフォルト0.15 = 15%）
    
    Returns:
    - (x_min, x_max, y_min, y_max): 最適な表示範囲
    """
    if not solutions:
        if x_range and y_range:
            x_min, x_max = x_range
            y_min, y_max = y_range
        else:
            return (-10, 10, -10, 10)
    else:
        sol_x = [s[0] for s in solutions]
        sol_y = [s[1] for s in solutions]
        x_min_sol = min(sol_x)
        x_max_sol = max(sol_x)
        y_min_sol = min(sol_y)
        y_max_sol = max(sol_y)
    
    # 曲線の範囲も考慮
    if x_range:
        x_min_curve, x_max_curve = x_range
        x_min = min(x_min_sol, x_min_curve) if solutions else x_min_curve
        x_max = max(x_max_sol, x_max_curve) if solutions else x_max_curve
    else:
        x_min = x_min_sol
        x_max = x_max_sol
    
    if y_range:
        y_min_curve, y_max_curve = y_range
        y_min = min(y_min_sol, y_min_curve) if solutions else y_min_curve
        y_max = max(y_max_sol, y_max_curve) if solutions else y_max_curve
    else:
        y_min = y_min_sol
        y_max = y_max_sol
    
    # マージンを追加
    x_range_size = x_max - x_min
    y_range_size = y_max - y_min
    
    if x_range_size > 0:
        x_margin = x_range_size * margin_ratio
        x_min -= x_margin
        x_max += x_margin
    else:
        x_margin = 1.0
        x_min -= x_margin
        x_max += x_margin
    
    if y_range_size > 0:
        y_margin = y_range_size * margin_ratio
        y_min -= y_margin
        y_max += y_margin
    else:
        y_margin = 1.0
        y_min -= y_margin
        y_max += y_margin
    
    return (x_min, x_max, y_min, y_max)

def problem_1():
    """問題1: 3x + 5y = 2"""
    fig, ax = plt.subplots(1, 1, figsize=(12, 9))
    
    # 整数解を計算（k=-3から3まで）
    solutions = []
    for k in range(-3, 4):
        x = 5*k + 4
        y = -3*k - 2
        solutions.append((x, y))
    
    # 描画範囲を-15から15に設定
    x_min, x_max, y_min, y_max = -15, 15, -15, 15
    
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    
    # 細かいグリッド（整数格子点）を表示
    ax.set_xticks(np.arange(np.floor(x_min), np.ceil(x_max) + 1, 1), minor=True)
    ax.set_yticks(np.arange(np.floor(y_min), np.ceil(y_max) + 1, 1), minor=True)
    ax.grid(True, which='minor', alpha=0.2, linewidth=0.5, linestyle=':')
    
    # 格子点を表示
    plot_lattice_points(ax, x_min, x_max, y_min, y_max, step=1, alpha=0.4)
    
    # 直線をプロット
    plot_linear_equation(ax, 3, 5, 2, x_range=(x_min, x_max), y_range=(y_min, y_max))
    
    # 整数解をプロット
    plot_integer_solutions(ax, solutions)
    
    # 主要なグリッド線
    step = 5
    ax.set_xticks(np.arange(np.floor(x_min/step)*step, np.ceil(x_max/step)*step + step, step))
    ax.set_yticks(np.arange(np.floor(y_min/step)*step, np.ceil(y_max/step)*step + step, step))
    ax.grid(True, which='major', alpha=0.6, linewidth=1.0)
    
    ax.set_xlabel('x', fontsize=18)
    ax.set_ylabel('y', fontsize=18)
    ax.set_title('$3x + 5y = 2$', fontsize=20, pad=15)
    ax.legend(fontsize=14)
    ax.tick_params(axis='both', which='major', labelsize=16)
    ax.tick_params(axis='both', which='minor', labelsize=14)
    plt.tight_layout()
    return fig

def problem_2():
    """問題2: 4x - 7y = 1"""
    fig, ax = plt.subplots(1, 1, figsize=(12, 9))
    
    solutions = []
    for k in range(-2, 3):
        x = 7*k + 2
        y = 4*k + 1
        solutions.append((x, y))
    
    # 描画範囲を-15から15に設定
    x_min, x_max, y_min, y_max = -15, 15, -15, 15
    
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    
    # 細かいグリッド（整数格子点）を表示
    ax.set_xticks(np.arange(np.floor(x_min), np.ceil(x_max) + 1, 1), minor=True)
    ax.set_yticks(np.arange(np.floor(y_min), np.ceil(y_max) + 1, 1), minor=True)
    ax.grid(True, which='minor', alpha=0.2, linewidth=0.5, linestyle=':')
    
    # 格子点を表示
    plot_lattice_points(ax, x_min, x_max, y_min, y_max, step=1, alpha=0.4)
    
    plot_linear_equation(ax, 4, -7, 1, x_range=(x_min, x_max), y_range=(y_min, y_max))
    
    plot_integer_solutions(ax, solutions)
    
    # 主要なグリッド線
    step = 5
    ax.set_xticks(np.arange(np.floor(x_min/step)*step, np.ceil(x_max/step)*step + step, step))
    ax.set_yticks(np.arange(np.floor(y_min/step)*step, np.ceil(y_max/step)*step + step, step))
    ax.grid(True, which='major', alpha=0.6, linewidth=1.0)
    
    ax.set_xlabel('x', fontsize=18)
    ax.set_ylabel('y', fontsize=18)
    ax.set_title('$4x - 7y = 1$', fontsize=20, pad=15)
    ax.legend(fontsize=14)
    ax.tick_params(axis='both', which='major', labelsize=16)
    ax.tick_params(axis='both', which='minor', labelsize=14)
    plt.tight_layout()
    return fig

def problem_3():
    """問題3: 391x + 287y = 1"""
    fig, ax = plt.subplots(1, 1, figsize=(12, 9))
    
    solutions = []
    for k in range(-1, 2):
        x = 69 + 287*k
        y = -94 - 391*k
        solutions.append((x, y))
    
    # 最適な範囲を計算（x, yともに-400から400まで）
    x_min, x_max, y_min, y_max = calculate_optimal_range(solutions, x_range=(-400, 400), y_range=(-400, 400))
    
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    
    # 細かいグリッド（10の倍数の格子点）を表示
    ax.set_xticks(np.arange(np.floor(x_min/10)*10, np.ceil(x_max/10)*10 + 10, 10), minor=True)
    ax.set_yticks(np.arange(np.floor(y_min/10)*10, np.ceil(y_max/10)*10 + 10, 10), minor=True)
    ax.grid(True, which='minor', alpha=0.2, linewidth=0.5, linestyle=':')
    
    # 格子点を表示（10の倍数）
    plot_lattice_points(ax, x_min, x_max, y_min, y_max, step=10, alpha=0.3)
    
    plot_linear_equation(ax, 391, 287, 1, x_range=(x_min, x_max), y_range=(y_min, y_max))
    
    plot_integer_solutions(ax, solutions)
    
    # 主要なグリッド線
    step = 100
    ax.set_xticks(np.arange(np.floor(x_min/step)*step, np.ceil(x_max/step)*step + step, step))
    ax.set_yticks(np.arange(np.floor(y_min/step)*step, np.ceil(y_max/step)*step + step, step))
    ax.grid(True, which='major', alpha=0.6, linewidth=1.0)
    
    ax.set_xlabel('x', fontsize=18)
    ax.set_ylabel('y', fontsize=18)
    ax.set_title('$391x + 287y = 1$', fontsize=20, pad=15)
    ax.legend(fontsize=14)
    ax.tick_params(axis='both', which='major', labelsize=16)
    ax.tick_params(axis='both', which='minor', labelsize=14)
    plt.tight_layout()
    return fig

def problem_4():
    """問題4: 842x + 495y = 1"""
    fig, ax = plt.subplots(1, 1, figsize=(12, 9))
    
    solutions = []
    for k in range(-1, 2):
        x = -97 + 495*k
        y = 165 - 842*k
        solutions.append((x, y))
    
    # 最適な範囲を計算
    x_min, x_max, y_min, y_max = calculate_optimal_range(solutions, x_range=(-600, 500), y_range=(-500, 600))
    
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    
    # 細かいグリッド（50の倍数の格子点）を表示
    ax.set_xticks(np.arange(np.floor(x_min/50)*50, np.ceil(x_max/50)*50 + 50, 50), minor=True)
    ax.set_yticks(np.arange(np.floor(y_min/50)*50, np.ceil(y_max/50)*50 + 50, 50), minor=True)
    ax.grid(True, which='minor', alpha=0.2, linewidth=0.5, linestyle=':')
    
    # 格子点を表示（50の倍数）
    plot_lattice_points(ax, x_min, x_max, y_min, y_max, step=50, alpha=0.3)
    
    plot_linear_equation(ax, 842, 495, 1, x_range=(x_min, x_max), y_range=(y_min, y_max))
    
    plot_integer_solutions(ax, solutions)
    
    # 主要なグリッド線
    step = 100
    ax.set_xticks(np.arange(np.floor(x_min/step)*step, np.ceil(x_max/step)*step + step, step))
    ax.set_yticks(np.arange(np.floor(y_min/step)*step, np.ceil(y_max/step)*step + step, step))
    ax.grid(True, which='major', alpha=0.6, linewidth=1.0)
    
    ax.set_xlabel('x', fontsize=18)
    ax.set_ylabel('y', fontsize=18)
    ax.set_title('$842x + 495y = 1$', fontsize=20, pad=15)
    ax.legend(fontsize=14)
    ax.tick_params(axis='both', which='major', labelsize=16)
    ax.tick_params(axis='both', which='minor', labelsize=14)
    plt.tight_layout()
    return fig

def problem_7():
    """問題7: x^2 + xy + 2y^2 = 11"""
    fig, ax = plt.subplots(1, 1, figsize=(12, 9))
    
    def func(x, y):
        return x**2 + x*y + 2*y**2 - 11
    
    solutions = [(1, 2), (-3, 2), (3, -2), (-1, -2)]
    
    # 最適な範囲を計算
    x_min, x_max, y_min, y_max = calculate_optimal_range(solutions, x_range=(-5, 5), y_range=(-5, 5))
    
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    
    # 細かいグリッド（整数格子点）を表示
    ax.set_xticks(np.arange(np.floor(x_min), np.ceil(x_max) + 1, 1), minor=True)
    ax.set_yticks(np.arange(np.floor(y_min), np.ceil(y_max) + 1, 1), minor=True)
    ax.grid(True, which='minor', alpha=0.2, linewidth=0.5, linestyle=':')
    
    # 格子点を表示
    plot_lattice_points(ax, x_min, x_max, y_min, y_max, step=1, alpha=0.4)
    
    plot_implicit_equation(ax, func, x_range=(x_min, x_max), y_range=(y_min, y_max))
    
    plot_integer_solutions(ax, solutions)
    
    # 主要なグリッド線
    step = 1
    ax.set_xticks(np.arange(np.floor(x_min/step)*step, np.ceil(x_max/step)*step + step, step))
    ax.set_yticks(np.arange(np.floor(y_min/step)*step, np.ceil(y_max/step)*step + step, step))
    ax.grid(True, which='major', alpha=0.6, linewidth=1.0)
    
    ax.set_xlabel('x', fontsize=18)
    ax.set_ylabel('y', fontsize=18)
    ax.set_title('$x^2 + xy + 2y^2 = 11$', fontsize=20, pad=15)
    ax.legend(fontsize=14)
    ax.tick_params(axis='both', which='major', labelsize=16)
    ax.tick_params(axis='both', which='minor', labelsize=14)
    plt.tight_layout()
    return fig

def problem_8():
    """問題8: xy + 3x - 8y = 33"""
    fig, ax = plt.subplots(1, 1, figsize=(12, 9))
    
    def func(x, y):
        return x*y + 3*x - 8*y - 33
    
    solutions = [(9, 6), (17, -2), (7, -12), (-1, -4), (11, 0), (5, -6)]
    
    # 最適な範囲を計算
    x_min, x_max, y_min, y_max = calculate_optimal_range(solutions, x_range=(-5, 20), y_range=(-15, 10))
    
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    
    # 細かいグリッド（整数格子点）を表示
    ax.set_xticks(np.arange(np.floor(x_min), np.ceil(x_max) + 1, 1), minor=True)
    ax.set_yticks(np.arange(np.floor(y_min), np.ceil(y_max) + 1, 1), minor=True)
    ax.grid(True, which='minor', alpha=0.2, linewidth=0.5, linestyle=':')
    
    # 格子点を表示
    plot_lattice_points(ax, x_min, x_max, y_min, y_max, step=1, alpha=0.4)
    
    plot_implicit_equation(ax, func, x_range=(x_min, x_max), y_range=(y_min, y_max))
    
    plot_integer_solutions(ax, solutions)
    
    # 主要なグリッド線
    step = 5
    ax.set_xticks(np.arange(np.floor(x_min/step)*step, np.ceil(x_max/step)*step + step, step))
    ax.set_yticks(np.arange(np.floor(y_min/step)*step, np.ceil(y_max/step)*step + step, step))
    ax.grid(True, which='major', alpha=0.6, linewidth=1.0)
    
    ax.set_xlabel('x', fontsize=18)
    ax.set_ylabel('y', fontsize=18)
    ax.set_title('$xy + 3x - 8y = 33$', fontsize=20, pad=15)
    ax.legend(fontsize=14)
    ax.tick_params(axis='both', which='major', labelsize=16)
    ax.tick_params(axis='both', which='minor', labelsize=14)
    plt.tight_layout()
    return fig

def problem_9():
    """問題9: xy - 2x - y = 5"""
    fig, ax = plt.subplots(1, 1, figsize=(12, 9))
    
    def func(x, y):
        return x*y - 2*x - y - 5
    
    solutions = [(2, 9), (8, 3), (0, -5), (-6, 1)]
    
    # 最適な範囲を計算
    x_min, x_max, y_min, y_max = calculate_optimal_range(solutions, x_range=(-10, 10), y_range=(-10, 15))
    
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    
    # 細かいグリッド（整数格子点）を表示
    ax.set_xticks(np.arange(np.floor(x_min), np.ceil(x_max) + 1, 1), minor=True)
    ax.set_yticks(np.arange(np.floor(y_min), np.ceil(y_max) + 1, 1), minor=True)
    ax.grid(True, which='minor', alpha=0.2, linewidth=0.5, linestyle=':')
    
    # 格子点を表示
    plot_lattice_points(ax, x_min, x_max, y_min, y_max, step=1, alpha=0.4)
    
    plot_implicit_equation(ax, func, x_range=(x_min, x_max), y_range=(y_min, y_max))
    
    plot_integer_solutions(ax, solutions)
    
    # 主要なグリッド線
    step = 5
    ax.set_xticks(np.arange(np.floor(x_min/step)*step, np.ceil(x_max/step)*step + step, step))
    ax.set_yticks(np.arange(np.floor(y_min/step)*step, np.ceil(y_max/step)*step + step, step))
    ax.grid(True, which='major', alpha=0.6, linewidth=1.0)
    
    ax.set_xlabel('x', fontsize=18)
    ax.set_ylabel('y', fontsize=18)
    ax.set_title('$xy - 2x - y = 5$', fontsize=20, pad=15)
    ax.legend(fontsize=14)
    ax.tick_params(axis='both', which='major', labelsize=16)
    ax.tick_params(axis='both', which='minor', labelsize=14)
    plt.tight_layout()
    return fig

def problem_10():
    """問題10: 1/x + 1/y = 1/7"""
    fig, ax = plt.subplots(1, 1, figsize=(12, 9))
    
    def func(x, y):
        with np.errstate(divide='ignore', invalid='ignore'):
            result = 1/x + 1/y - 1/7
            return np.where((np.abs(x) < 1e-10) | (np.abs(y) < 1e-10), np.nan, result)
    
    solutions = [(8, 56), (14, 14), (56, 8), (6, -42), (-42, 6)]
    
    # 描画範囲を-60から60に設定
    x_min, x_max, y_min, y_max = -60, 60, -60, 60
    
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    
    # 細かいグリッド（整数格子点）を表示
    ax.set_xticks(np.arange(np.floor(x_min), np.ceil(x_max) + 1, 1), minor=True)
    ax.set_yticks(np.arange(np.floor(y_min), np.ceil(y_max) + 1, 1), minor=True)
    ax.grid(True, which='minor', alpha=0.2, linewidth=0.5, linestyle=':')
    
    # 格子点を表示
    plot_lattice_points(ax, x_min, x_max, y_min, y_max, step=1, alpha=0.3)
    
    plot_implicit_equation(ax, func, x_range=(x_min, x_max), y_range=(y_min, y_max), resolution=600)
    
    plot_integer_solutions(ax, solutions)
    
    ax.axhline(y=0, color='gray', linestyle='--', alpha=0.5, linewidth=2)
    ax.axvline(x=0, color='gray', linestyle='--', alpha=0.5, linewidth=2)
    
    # 主要なグリッド線
    step = 10
    ax.set_xticks(np.arange(np.floor(x_min/step)*step, np.ceil(x_max/step)*step + step, step))
    ax.set_yticks(np.arange(np.floor(y_min/step)*step, np.ceil(y_max/step)*step + step, step))
    ax.grid(True, which='major', alpha=0.6, linewidth=1.0)
    
    ax.set_xlabel('x', fontsize=18)
    ax.set_ylabel('y', fontsize=18)
    ax.set_title('$\\frac{1}{x} + \\frac{1}{y} = \\frac{1}{7}$', fontsize=20, pad=15)
    ax.legend(fontsize=14)
    ax.tick_params(axis='both', which='major', labelsize=16)
    ax.tick_params(axis='both', which='minor', labelsize=14)
    plt.tight_layout()
    return fig

def problem_12():
    """問題12: 4x^2 - y^2 = 32"""
    fig, ax = plt.subplots(1, 1, figsize=(12, 9))
    
    def func(x, y):
        return 4*x**2 - y**2 - 32
    
    solutions = [(3, 2), (3, -2), (-3, 2), (-3, -2)]
    
    # 最適な範囲を計算
    x_min, x_max, y_min, y_max = calculate_optimal_range(solutions, x_range=(-5, 5), y_range=(-10, 10))
    
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    
    # 細かいグリッド（整数格子点）を表示
    ax.set_xticks(np.arange(np.floor(x_min), np.ceil(x_max) + 1, 1), minor=True)
    ax.set_yticks(np.arange(np.floor(y_min), np.ceil(y_max) + 1, 1), minor=True)
    ax.grid(True, which='minor', alpha=0.2, linewidth=0.5, linestyle=':')
    
    # 格子点を表示
    plot_lattice_points(ax, x_min, x_max, y_min, y_max, step=1, alpha=0.4)
    
    plot_implicit_equation(ax, func, x_range=(x_min, x_max), y_range=(y_min, y_max))
    
    plot_integer_solutions(ax, solutions)
    
    # 主要なグリッド線
    step = 1
    ax.set_xticks(np.arange(np.floor(x_min/step)*step, np.ceil(x_max/step)*step + step, step))
    ax.set_yticks(np.arange(np.floor(y_min/step)*step, np.ceil(y_max/step)*step + step, step))
    ax.grid(True, which='major', alpha=0.6, linewidth=1.0)
    
    ax.set_xlabel('x', fontsize=18)
    ax.set_ylabel('y', fontsize=18)
    ax.set_title('$4x^2 - y^2 = 32$', fontsize=20, pad=15)
    ax.legend(fontsize=14)
    ax.tick_params(axis='both', which='major', labelsize=16)
    ax.tick_params(axis='both', which='minor', labelsize=14)
    plt.tight_layout()
    return fig

def problem_13():
    """問題13: x^2 - 2xy - 2x + 6y - 6 = 0"""
    fig, ax = plt.subplots(1, 1, figsize=(12, 9))
    
    def func(x, y):
        return x**2 - 2*x*y - 2*x + 6*y - 6
    
    solutions = [(4, 1), (6, 3), (2, 3), (0, 1)]
    
    # 最適な範囲を計算
    x_min, x_max, y_min, y_max = calculate_optimal_range(solutions, x_range=(-2, 8), y_range=(-2, 5))
    
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    
    # 細かいグリッド（整数格子点）を表示
    ax.set_xticks(np.arange(np.floor(x_min), np.ceil(x_max) + 1, 1), minor=True)
    ax.set_yticks(np.arange(np.floor(y_min), np.ceil(y_max) + 1, 1), minor=True)
    ax.grid(True, which='minor', alpha=0.2, linewidth=0.5, linestyle=':')
    
    # 格子点を表示
    plot_lattice_points(ax, x_min, x_max, y_min, y_max, step=1, alpha=0.4)
    
    plot_implicit_equation(ax, func, x_range=(x_min, x_max), y_range=(y_min, y_max))
    
    plot_integer_solutions(ax, solutions)
    
    # 主要なグリッド線
    step = 1
    ax.set_xticks(np.arange(np.floor(x_min/step)*step, np.ceil(x_max/step)*step + step, step))
    ax.set_yticks(np.arange(np.floor(y_min/step)*step, np.ceil(y_max/step)*step + step, step))
    ax.grid(True, which='major', alpha=0.6, linewidth=1.0)
    
    ax.set_xlabel('x', fontsize=18)
    ax.set_ylabel('y', fontsize=18)
    ax.set_title('$x^2 - 2xy - 2x + 6y - 6 = 0$', fontsize=20, pad=15)
    ax.legend(fontsize=14)
    ax.tick_params(axis='both', which='major', labelsize=16)
    ax.tick_params(axis='both', which='minor', labelsize=14)
    plt.tight_layout()
    return fig

def problem_14():
    """問題14: 2x^2 + 11xy + 12y^2 - 5y - 5 = 0"""
    fig, ax = plt.subplots(1, 1, figsize=(12, 9))
    
    def func(x, y):
        return 2*x**2 + 11*x*y + 12*y**2 - 5*y - 5
    
    solutions = [(4, -1)]
    
    # 最適な範囲を計算
    x_min, x_max, y_min, y_max = calculate_optimal_range(solutions, x_range=(-2, 6), y_range=(-3, 1))
    
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    
    # 細かいグリッド（整数格子点）を表示
    ax.set_xticks(np.arange(np.floor(x_min), np.ceil(x_max) + 1, 1), minor=True)
    ax.set_yticks(np.arange(np.floor(y_min), np.ceil(y_max) + 1, 1), minor=True)
    ax.grid(True, which='minor', alpha=0.2, linewidth=0.5, linestyle=':')
    
    # 格子点を表示
    plot_lattice_points(ax, x_min, x_max, y_min, y_max, step=1, alpha=0.4)
    
    plot_implicit_equation(ax, func, x_range=(x_min, x_max), y_range=(y_min, y_max))
    
    plot_integer_solutions(ax, solutions)
    
    # 主要なグリッド線
    step = 1
    ax.set_xticks(np.arange(np.floor(x_min/step)*step, np.ceil(x_max/step)*step + step, step))
    ax.set_yticks(np.arange(np.floor(y_min/step)*step, np.ceil(y_max/step)*step + step, step))
    ax.grid(True, which='major', alpha=0.6, linewidth=1.0)
    
    ax.set_xlabel('x', fontsize=18)
    ax.set_ylabel('y', fontsize=18)
    ax.set_title('$2x^2 + 11xy + 12y^2 - 5y - 5 = 0$', fontsize=20, pad=15)
    ax.legend(fontsize=14)
    ax.tick_params(axis='both', which='major', labelsize=16)
    ax.tick_params(axis='both', which='minor', labelsize=14)
    plt.tight_layout()
    return fig

def problem_17():
    """問題17: 3x^2 - 2xy + 2y^2 - 2x + 4y - 1 = 0"""
    fig, ax = plt.subplots(1, 1, figsize=(12, 9))
    
    def func(x, y):
        return 3*x**2 - 2*x*y + 2*y**2 - 2*x + 4*y - 1
    
    solutions = [(-1, -2), (-1, -1), (1, -1), (1, 0)]
    
    # 最適な範囲を計算
    x_min, x_max, y_min, y_max = calculate_optimal_range(solutions, x_range=(-3, 3), y_range=(-3, 2))
    
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    
    # 細かいグリッド（整数格子点）を表示
    ax.set_xticks(np.arange(np.floor(x_min), np.ceil(x_max) + 1, 1), minor=True)
    ax.set_yticks(np.arange(np.floor(y_min), np.ceil(y_max) + 1, 1), minor=True)
    ax.grid(True, which='minor', alpha=0.2, linewidth=0.5, linestyle=':')
    
    # 格子点を表示
    plot_lattice_points(ax, x_min, x_max, y_min, y_max, step=1, alpha=0.4)
    
    plot_implicit_equation(ax, func, x_range=(x_min, x_max), y_range=(y_min, y_max))
    
    plot_integer_solutions(ax, solutions)
    
    # 主要なグリッド線
    step = 1
    ax.set_xticks(np.arange(np.floor(x_min/step)*step, np.ceil(x_max/step)*step + step, step))
    ax.set_yticks(np.arange(np.floor(y_min/step)*step, np.ceil(y_max/step)*step + step, step))
    ax.grid(True, which='major', alpha=0.6, linewidth=1.0)
    
    ax.set_xlabel('x', fontsize=18)
    ax.set_ylabel('y', fontsize=18)
    ax.set_title('$3x^2 - 2xy + 2y^2 - 2x + 4y - 1 = 0$', fontsize=20, pad=15)
    ax.legend(fontsize=14)
    ax.tick_params(axis='both', which='major', labelsize=16)
    ax.tick_params(axis='both', which='minor', labelsize=14)
    plt.tight_layout()
    return fig

def problem_18():
    """問題18: 5x^2 + 2xy + y^2 - 12x + 4y + 11 = 0"""
    fig, ax = plt.subplots(1, 1, figsize=(12, 9))
    
    def func(x, y):
        return 5*x**2 + 2*x*y + y**2 - 12*x + 4*y + 11
    
    solutions = [(2, -1), (2, -7)]
    
    # 最適な範囲を計算
    x_min, x_max, y_min, y_max = calculate_optimal_range(solutions, x_range=(0, 4), y_range=(-10, 0))
    
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    
    # 細かいグリッド（整数格子点）を表示
    ax.set_xticks(np.arange(np.floor(x_min), np.ceil(x_max) + 1, 1), minor=True)
    ax.set_yticks(np.arange(np.floor(y_min), np.ceil(y_max) + 1, 1), minor=True)
    ax.grid(True, which='minor', alpha=0.2, linewidth=0.5, linestyle=':')
    
    # 格子点を表示
    plot_lattice_points(ax, x_min, x_max, y_min, y_max, step=1, alpha=0.4)
    
    plot_implicit_equation(ax, func, x_range=(x_min, x_max), y_range=(y_min, y_max))
    
    plot_integer_solutions(ax, solutions)
    
    # 主要なグリッド線
    step = 1
    ax.set_xticks(np.arange(np.floor(x_min/step)*step, np.ceil(x_max/step)*step + step, step))
    ax.set_yticks(np.arange(np.floor(y_min/step)*step, np.ceil(y_max/step)*step + step, step))
    ax.grid(True, which='major', alpha=0.6, linewidth=1.0)
    
    ax.set_xlabel('x', fontsize=18)
    ax.set_ylabel('y', fontsize=18)
    ax.set_title('$5x^2 + 2xy + y^2 - 12x + 4y + 11 = 0$', fontsize=20, pad=15)
    ax.legend(fontsize=14)
    ax.tick_params(axis='both', which='major', labelsize=16)
    ax.tick_params(axis='both', which='minor', labelsize=14)
    plt.tight_layout()
    return fig

def problem_21():
    """問題21: x^2 + 13y^2 = 413"""
    fig, ax = plt.subplots(1, 1, figsize=(12, 9))
    
    def func(x, y):
        return x**2 + 13*y**2 - 413
    
    solutions = [(20, 1), (20, -1), (-20, 1), (-20, -1), (19, 2), (19, -2), (-19, 2), (-19, -2)]
    
    # 最適な範囲を計算
    x_min, x_max, y_min, y_max = calculate_optimal_range(solutions, x_range=(-25, 25), y_range=(-5, 5))
    
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    
    # 細かいグリッド（整数格子点）を表示
    ax.set_xticks(np.arange(np.floor(x_min), np.ceil(x_max) + 1, 1), minor=True)
    ax.set_yticks(np.arange(np.floor(y_min), np.ceil(y_max) + 1, 1), minor=True)
    ax.grid(True, which='minor', alpha=0.2, linewidth=0.5, linestyle=':')
    
    # 格子点を表示
    plot_lattice_points(ax, x_min, x_max, y_min, y_max, step=1, alpha=0.4)
    
    plot_implicit_equation(ax, func, x_range=(x_min, x_max), y_range=(y_min, y_max))
    
    plot_integer_solutions(ax, solutions)
    
    # 主要なグリッド線
    step = 5
    ax.set_xticks(np.arange(np.floor(x_min/step)*step, np.ceil(x_max/step)*step + step, step))
    ax.set_yticks(np.arange(np.floor(y_min/step)*step, np.ceil(y_max/step)*step + step, step))
    ax.grid(True, which='major', alpha=0.6, linewidth=1.0)
    
    ax.set_xlabel('x', fontsize=18)
    ax.set_ylabel('y', fontsize=18)
    ax.set_title('$x^2 + 13y^2 = 413$', fontsize=20, pad=15)
    ax.legend(fontsize=14)
    ax.tick_params(axis='both', which='major', labelsize=16)
    ax.tick_params(axis='both', which='minor', labelsize=14)
    plt.tight_layout()
    return fig

def problem_22():
    """問題22: x^3 + (3y - 5)x^2 - 7yx - 2 = 0"""
    fig, ax = plt.subplots(1, 1, figsize=(12, 9))
    
    def func(x, y):
        return x**3 + (3*y - 5)*x**2 - 7*y*x - 2
    
    solutions = [(2, -7)]
    
    # 最適な範囲を計算
    x_min, x_max, y_min, y_max = calculate_optimal_range(solutions, x_range=(-5, 5), y_range=(-10, 5))
    
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    
    # 細かいグリッド（整数格子点）を表示
    ax.set_xticks(np.arange(np.floor(x_min), np.ceil(x_max) + 1, 1), minor=True)
    ax.set_yticks(np.arange(np.floor(y_min), np.ceil(y_max) + 1, 1), minor=True)
    ax.grid(True, which='minor', alpha=0.2, linewidth=0.5, linestyle=':')
    
    # 格子点を表示
    plot_lattice_points(ax, x_min, x_max, y_min, y_max, step=1, alpha=0.4)
    
    plot_implicit_equation(ax, func, x_range=(x_min, x_max), y_range=(y_min, y_max))
    
    plot_integer_solutions(ax, solutions)
    
    # 主要なグリッド線
    step = 1
    ax.set_xticks(np.arange(np.floor(x_min/step)*step, np.ceil(x_max/step)*step + step, step))
    ax.set_yticks(np.arange(np.floor(y_min/step)*step, np.ceil(y_max/step)*step + step, step))
    ax.grid(True, which='major', alpha=0.6, linewidth=1.0)
    
    ax.set_xlabel('x', fontsize=18)
    ax.set_ylabel('y', fontsize=18)
    ax.set_title('$x^3 + (3y - 5)x^2 - 7yx - 2 = 0$', fontsize=20, pad=15)
    ax.legend(fontsize=14)
    ax.tick_params(axis='both', which='major', labelsize=16)
    ax.tick_params(axis='both', which='minor', labelsize=14)
    plt.tight_layout()
    return fig

def problem_24():
    """問題24: 4x - 3y + 13z = 2 (3次元グラフ)"""
    fig = plt.figure(figsize=(12, 10))
    ax = fig.add_subplot(111, projection='3d')
    
    # 平面の範囲を設定
    x_range = np.linspace(-15, 15, 50)
    y_range = np.linspace(-15, 15, 50)
    X, Y = np.meshgrid(x_range, y_range)
    
    # 平面の方程式: 4x - 3y + 13z = 2 より z = (2 - 4x + 3y) / 13
    Z = (2 - 4*X + 3*Y) / 13
    
    # 平面を描画（半透明）
    surf = ax.plot_surface(X, Y, Z, alpha=0.6, color='lightblue', 
                          linewidth=0, antialiased=True, shade=True)
    
    # 整数解を計算
    # x = 3k + 2 - 13ℓ, y = 4k + 2 - 13ℓ, z = ℓ
    solutions = []
    for k in range(-3, 4):
        for ell in range(-2, 3):
            x = 3*k + 2 - 13*ell
            y = 4*k + 2 - 13*ell
            z = ell
            # 範囲内の解のみを表示
            if -15 <= x <= 15 and -15 <= y <= 15 and -5 <= z <= 5:
                solutions.append((x, y, z))
    
    # 整数解を赤い点で表示
    if solutions:
        xs, ys, zs = zip(*solutions)
        ax.scatter(xs, ys, zs, color='red', s=100, marker='o', 
                  edgecolors='darkred', linewidths=2, label='Integer solutions', zorder=5)
    
    # 軸の設定
    ax.set_xlabel('x', fontsize=18, labelpad=10)
    ax.set_ylabel('y', fontsize=18, labelpad=10)
    ax.set_zlabel('z', fontsize=18, labelpad=10)
    ax.set_title('$4x - 3y + 13z = 2$', fontsize=20, pad=20)
    ax.tick_params(axis='both', which='major', labelsize=16)
    ax.tick_params(axis='both', which='minor', labelsize=14)
    
    # 表示範囲の設定
    ax.set_xlim(-15, 15)
    ax.set_ylim(-15, 15)
    ax.set_zlim(-5, 5)
    
    # グリッドと凡例
    ax.grid(True, alpha=0.6, linewidth=1.0)
    ax.legend(loc='upper left')
    
    # 視点の設定（見やすい角度）
    ax.view_init(elev=20, azim=45)
    
    plt.tight_layout()
    return fig

def problem_25():
    """問題25: x^2 + 6y^2 = 223"""
    fig, ax = plt.subplots(1, 1, figsize=(12, 9))
    
    def func(x, y):
        return x**2 + 6*y**2 - 223
    
    solutions = [(13, 3), (13, -3), (-13, 3), (-13, -3)]
    
    # 最適な範囲を計算
    x_min, x_max, y_min, y_max = calculate_optimal_range(solutions, x_range=(-20, 20), y_range=(-10, 10))
    
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    
    # 細かいグリッド（整数格子点）を表示
    ax.set_xticks(np.arange(np.floor(x_min), np.ceil(x_max) + 1, 1), minor=True)
    ax.set_yticks(np.arange(np.floor(y_min), np.ceil(y_max) + 1, 1), minor=True)
    ax.grid(True, which='minor', alpha=0.2, linewidth=0.5, linestyle=':')
    
    # 格子点を表示
    plot_lattice_points(ax, x_min, x_max, y_min, y_max, step=1, alpha=0.4)
    
    # 曲線をプロット
    plot_implicit_equation(ax, func, x_range=(x_min, x_max), y_range=(y_min, y_max))
    
    # 整数解をプロット
    plot_integer_solutions(ax, solutions)
    
    # 主要なグリッド線
    step = 5
    ax.set_xticks(np.arange(np.floor(x_min/step)*step, np.ceil(x_max/step)*step + step, step))
    ax.set_yticks(np.arange(np.floor(y_min/step)*step, np.ceil(y_max/step)*step + step, step))
    ax.grid(True, which='major', alpha=0.6, linewidth=1.0)
    
    ax.set_xlabel('x', fontsize=18)
    ax.set_ylabel('y', fontsize=18)
    ax.set_title('$x^2 + 6y^2 = 223$', fontsize=20, pad=15)
    ax.legend(fontsize=14)
    ax.tick_params(axis='both', which='major', labelsize=16)
    ax.tick_params(axis='both', which='minor', labelsize=14)
    plt.tight_layout()
    return fig

def main():
    """メイン実行関数"""
    # 出力ディレクトリを作成
    output_dir = "../../../assets/graphs/indeterminate_equations"
    os.makedirs(output_dir, exist_ok=True)
    
    print("不定方程式問題のグラフを生成中...")
    
    problems = [
        (1, problem_1, "3x + 5y = 2"),
        (2, problem_2, "4x - 7y = 1"),
        (3, problem_3, "391x + 287y = 1"),
        (4, problem_4, "842x + 495y = 1"),
        (7, problem_7, "x^2 + xy + 2y^2 = 11"),
        (8, problem_8, "xy + 3x - 8y = 33"),
        (9, problem_9, "xy - 2x - y = 5"),
        (10, problem_10, "1/x + 1/y = 1/7"),
        (12, problem_12, "4x^2 - y^2 = 32"),
        (13, problem_13, "x^2 - 2xy - 2x + 6y - 6 = 0"),
        (14, problem_14, "2x^2 + 11xy + 12y^2 - 5y - 5 = 0"),
        (17, problem_17, "3x^2 - 2xy + 2y^2 - 2x + 4y - 1 = 0"),
        (18, problem_18, "5x^2 + 2xy + y^2 - 12x + 4y + 11 = 0"),
        (21, problem_21, "x^2 + 13y^2 = 413"),
        (22, problem_22, "x^3 + (3y - 5)x^2 - 7yx - 2 = 0"),
        (24, problem_24, "4x - 3y + 13z = 2"),
        (25, problem_25, "x^2 + 6y^2 = 223"),
    ]
    
    for no, func, eq_name in problems:
        print(f"問題{no}: {eq_name} のグラフを生成中...")
        try:
            fig = func()
            filename = f'problem_{no}.png'
            filepath = os.path.join(output_dir, filename)
            fig.savefig(filepath, dpi=300, bbox_inches='tight')
            plt.close(fig)
            print(f"✅ 問題{no}のグラフ生成完了: {filename}")
        except Exception as e:
            print(f"❌ 問題{no}のグラフ生成でエラーが発生しました: {e}")
            import traceback
            traceback.print_exc()
    
    print("\n" + "=" * 60)
    print("すべての不定方程式問題のグラフ生成が完了しました！")
    print(f"出力先: {output_dir}")
    print("=" * 60)

if __name__ == "__main__":
    main()

