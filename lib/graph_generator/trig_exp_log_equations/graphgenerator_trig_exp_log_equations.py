#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
三角指数対数方程式問題のグラフ生成器
"""

import sys
import os
import math
import numpy as np
import matplotlib.pyplot as plt

# 日本語フォントの設定
plt.rcParams['font.family'] = ['DejaVu Sans', 'Hiragino Sans', 'Yu Gothic', 'Meiryo', 'Takao', 'IPAexGothic', 'IPAPGothic', 'VL PGothic', 'Noto Sans CJK JP']

# フォント検索の警告を無効化
import warnings
import logging
warnings.filterwarnings('ignore')
logging.getLogger('matplotlib.font_manager').setLevel(logging.ERROR)
import matplotlib
matplotlib.rcParams['font.family'] = ['DejaVu Sans']

def setup_large_fonts(ax, title_fontsize=20, label_fontsize=18, tick_fontsize=16, legend_fontsize=14):
    """グラフのフォントサイズを大きく設定するヘルパー関数"""
    ax.set_xlabel(ax.get_xlabel(), fontsize=label_fontsize)
    ax.set_ylabel(ax.get_ylabel(), fontsize=label_fontsize)
    title = ax.get_title()
    if title:
        ax.set_title(title, fontsize=title_fontsize, pad=15)
    ax.tick_params(axis='both', which='major', labelsize=tick_fontsize)
    ax.tick_params(axis='both', which='minor', labelsize=tick_fontsize)
    legend = ax.get_legend()
    if legend:
        plt.setp(legend.get_texts(), fontsize=legend_fontsize)

# 問題1: sin x = 1/2
def problem_1():
    fig, ax = plt.subplots(figsize=(12, 8))
    x = np.linspace(0, 2*np.pi, 1000)
    y = np.sin(x)
    ax.plot(x, y, 'b-', linewidth=3, label=r'$y = \sin x$')
    ax.axhline(y=0.5, color='r', linestyle='--', linewidth=2, label=r'$y = \frac{1}{2}$')
    ax.axhline(y=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    ax.axvline(x=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    
    # 解をマーク
    solutions = [np.pi/6, 5*np.pi/6]
    for sol in solutions:
        ax.plot(sol, 0.5, 'ro', markersize=12, markeredgecolor='darkred', markeredgewidth=2, zorder=10)
        ax.axvline(x=sol, color='g', linestyle=':', linewidth=1.5, alpha=0.5)
    
    ax.set_xlim(0, 2*np.pi)
    ax.set_ylim(-1.2, 1.2)
    ax.set_xlabel(r'$x$', fontsize=18)
    ax.set_ylabel(r'$y$', fontsize=18)
    ax.set_title(r'$\sin x = \frac{1}{2}$', fontsize=20)
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=14, loc='upper right')
    ax.set_xticks([0, np.pi/6, np.pi/2, 5*np.pi/6, np.pi, 3*np.pi/2, 2*np.pi])
    ax.set_xticklabels(['0', r'$\frac{\pi}{6}$', r'$\frac{\pi}{2}$', r'$\frac{5\pi}{6}$', r'$\pi$', r'$\frac{3\pi}{2}$', r'$2\pi$'])
    setup_large_fonts(ax)
    plt.tight_layout()
    return fig

# 問題2: 2^(x+1) - 2^(x-1) = 3
def problem_2():
    fig, ax = plt.subplots(figsize=(12, 8))
    x = np.linspace(-2, 3, 1000)
    y = 2**(x+1) - 2**(x-1)
    ax.plot(x, y, 'b-', linewidth=3, label=r'$y = 2^{x+1} - 2^{x-1}$')
    ax.axhline(y=3, color='r', linestyle='--', linewidth=2, label=r'$y = 3$')
    ax.axhline(y=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    ax.axvline(x=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    
    # 解をマーク
    sol = 1
    ax.plot(sol, 3, 'ro', markersize=12, markeredgecolor='darkred', markeredgewidth=2, zorder=10)
    ax.axvline(x=sol, color='g', linestyle=':', linewidth=1.5, alpha=0.5)
    
    ax.set_xlim(-2, 3)
    ax.set_ylim(-1, 10)
    ax.set_xlabel(r'$x$', fontsize=18)
    ax.set_ylabel(r'$y$', fontsize=18)
    ax.set_title(r'$2^{x+1} - 2^{x-1} = 3$', fontsize=20)
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=14, loc='upper left')
    # y軸のメモリを1ずつに設定（答えが3なので）
    ax.set_yticks(range(-1, 11))
    setup_large_fonts(ax)
    plt.tight_layout()
    return fig

# 問題3: log_2(x+1) + log_2(x-1) = 3
def problem_3():
    fig, ax = plt.subplots(figsize=(12, 8))
    x = np.linspace(1.1, 5, 1000)
    y = np.log2(x+1) + np.log2(x-1)
    ax.plot(x, y, 'b-', linewidth=3, label=r'$y = \log_2(x+1) + \log_2(x-1)$')
    ax.axhline(y=3, color='r', linestyle='--', linewidth=2, label=r'$y = 3$')
    ax.axhline(y=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    ax.axvline(x=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    
    # 解をマーク
    sol = 3
    ax.plot(sol, 3, 'ro', markersize=12, markeredgecolor='darkred', markeredgewidth=2, zorder=10)
    ax.axvline(x=sol, color='g', linestyle=':', linewidth=1.5, alpha=0.5)
    
    ax.set_xlim(1, 5)
    ax.set_ylim(0, 5)
    ax.set_xlabel(r'$x$', fontsize=18)
    ax.set_ylabel(r'$y$', fontsize=18)
    ax.set_title(r'$\log_2(x+1) + \log_2(x-1) = 3$', fontsize=20)
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=14, loc='upper left')
    # y軸のメモリを1ずつに設定（答えが3なので）
    ax.set_yticks(range(0, 6))
    setup_large_fonts(ax)
    plt.tight_layout()
    return fig

# 問題4: √3 sin x + cos x = 1
def problem_4():
    fig, ax = plt.subplots(figsize=(12, 8))
    x = np.linspace(0, 2*np.pi, 1000)
    y = np.sqrt(3)*np.sin(x) + np.cos(x)
    ax.plot(x, y, 'b-', linewidth=3, label=r'$y = \sqrt{3}\sin x + \cos x$')
    ax.axhline(y=1, color='r', linestyle='--', linewidth=2, label=r'$y = 1$')
    ax.axhline(y=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    ax.axvline(x=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    
    # 解をマーク
    solutions = [0, 2*np.pi/3]
    for sol in solutions:
        ax.plot(sol, 1, 'ro', markersize=12, markeredgecolor='darkred', markeredgewidth=2, zorder=10)
        ax.axvline(x=sol, color='g', linestyle=':', linewidth=1.5, alpha=0.5)
    
    ax.set_xlim(0, 2*np.pi)
    ax.set_ylim(-4.0, 4.0)
    ax.set_xlabel(r'$x$', fontsize=18)
    ax.set_ylabel(r'$y$', fontsize=18)
    ax.set_title(r'$\sqrt{3}\sin x + \cos x = 1$', fontsize=20)
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=14, loc='upper right')
    ax.set_xticks([0, np.pi/3, 2*np.pi/3, np.pi, 4*np.pi/3, 5*np.pi/3, 2*np.pi])
    ax.set_xticklabels(['0', r'$\frac{\pi}{3}$', r'$\frac{2\pi}{3}$', r'$\pi$', r'$\frac{4\pi}{3}$', r'$\frac{5\pi}{3}$', r'$2\pi$'])
    setup_large_fonts(ax)
    plt.tight_layout()
    return fig

# 問題5: sin 3x + sin x = 0
def problem_5():
    fig, ax = plt.subplots(figsize=(12, 8))
    x = np.linspace(0, 2*np.pi, 1000)
    y = np.sin(3*x) + np.sin(x)
    ax.plot(x, y, 'b-', linewidth=3, label=r'$y = \sin 3x + \sin x$')
    ax.axhline(y=0, color='r', linestyle='--', linewidth=2, label=r'$y = 0$')
    ax.axvline(x=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    
    # 解をマーク
    solutions = [0, np.pi/2, np.pi, 3*np.pi/2]
    for sol in solutions:
        ax.plot(sol, 0, 'ro', markersize=12, markeredgecolor='darkred', markeredgewidth=2, zorder=10)
        ax.axvline(x=sol, color='g', linestyle=':', linewidth=1.5, alpha=0.5)
    
    ax.set_xlim(0, 2*np.pi)
    ax.set_ylim(-2.5, 2.5)
    ax.set_xlabel(r'$x$', fontsize=18)
    ax.set_ylabel(r'$y$', fontsize=18)
    ax.set_title(r'$\sin 3x + \sin x = 0$', fontsize=20)
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=14, loc='upper right')
    ax.set_xticks([0, np.pi/2, np.pi, 3*np.pi/2, 2*np.pi])
    ax.set_xticklabels(['0', r'$\frac{\pi}{2}$', r'$\pi$', r'$\frac{3\pi}{2}$', r'$2\pi$'])
    setup_large_fonts(ax)
    plt.tight_layout()
    return fig

# 問題6: sin x + sin 2x + sin 3x = 0
def problem_6():
    fig, ax = plt.subplots(figsize=(12, 8))
    x = np.linspace(0, 2*np.pi, 1000)
    y = np.sin(x) + np.sin(2*x) + np.sin(3*x)
    ax.plot(x, y, 'b-', linewidth=3, label=r'$y = \sin x + \sin 2x + \sin 3x$')
    ax.axhline(y=0, color='r', linestyle='--', linewidth=2, label=r'$y = 0$')
    ax.axvline(x=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    
    # 解をマーク
    solutions = [0, np.pi/2, 2*np.pi/3, np.pi, 4*np.pi/3, 3*np.pi/2]
    for sol in solutions:
        ax.plot(sol, 0, 'ro', markersize=12, markeredgecolor='darkred', markeredgewidth=2, zorder=10)
        ax.axvline(x=sol, color='g', linestyle=':', linewidth=1.5, alpha=0.5)
    
    ax.set_xlim(0, 2*np.pi)
    ax.set_ylim(-3, 3)
    ax.set_xlabel(r'$x$', fontsize=18)
    ax.set_ylabel(r'$y$', fontsize=18)
    ax.set_title(r'$\sin x + \sin 2x + \sin 3x = 0$', fontsize=20)
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=14, loc='upper right')
    ax.set_xticks([0, np.pi/2, 2*np.pi/3, np.pi, 4*np.pi/3, 3*np.pi/2, 2*np.pi])
    ax.set_xticklabels(['0', r'$\frac{\pi}{2}$', r'$\frac{2\pi}{3}$', r'$\pi$', r'$\frac{4\pi}{3}$', r'$\frac{3\pi}{2}$', r'$2\pi$'])
    setup_large_fonts(ax)
    plt.tight_layout()
    return fig

# 問題7: 2 sin² x - sin x - 1 = 0
def problem_7():
    fig, ax = plt.subplots(figsize=(12, 8))
    x = np.linspace(0, 2*np.pi, 1000)
    y = 2*np.sin(x)**2 - np.sin(x) - 1
    ax.plot(x, y, 'b-', linewidth=3, label=r'$y = 2\sin^2 x - \sin x - 1$')
    ax.axhline(y=0, color='r', linestyle='--', linewidth=2, label=r'$y = 0$')
    ax.axvline(x=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    
    # 解をマーク
    solutions = [np.pi/2, 7*np.pi/6, 11*np.pi/6]
    for sol in solutions:
        ax.plot(sol, 0, 'ro', markersize=12, markeredgecolor='darkred', markeredgewidth=2, zorder=10)
        ax.axvline(x=sol, color='g', linestyle=':', linewidth=1.5, alpha=0.5)
    
    ax.set_xlim(0, 2*np.pi)
    ax.set_ylim(-2, 2)
    ax.set_xlabel(r'$x$', fontsize=18)
    ax.set_ylabel(r'$y$', fontsize=18)
    ax.set_title(r'$2\sin^2 x - \sin x - 1 = 0$', fontsize=20)
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=14, loc='upper right')
    ax.set_xticks([0, np.pi/2, np.pi, 3*np.pi/2, 2*np.pi])
    ax.set_xticklabels(['0', r'$\frac{\pi}{2}$', r'$\pi$', r'$\frac{3\pi}{2}$', r'$2\pi$'])
    setup_large_fonts(ax)
    plt.tight_layout()
    return fig

# 問題8: log_2 x + log_2(x+2) = 3
def problem_8():
    fig, ax = plt.subplots(figsize=(12, 8))
    x = np.linspace(0.1, 5, 1000)
    y = np.log2(x) + np.log2(x+2)
    ax.plot(x, y, 'b-', linewidth=3, label=r'$y = \log_2 x + \log_2(x+2)$')
    ax.axhline(y=3, color='r', linestyle='--', linewidth=2, label=r'$y = 3$')
    ax.axhline(y=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    ax.axvline(x=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    
    # 解をマーク
    sol = 2
    ax.plot(sol, 3, 'ro', markersize=12, markeredgecolor='darkred', markeredgewidth=2, zorder=10)
    ax.axvline(x=sol, color='g', linestyle=':', linewidth=1.5, alpha=0.5)
    
    ax.set_xlim(0, 5)
    ax.set_ylim(-2, 5)
    ax.set_xlabel(r'$x$', fontsize=18)
    ax.set_ylabel(r'$y$', fontsize=18)
    ax.set_title(r'$\log_2 x + \log_2(x+2) = 3$', fontsize=20)
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=14, loc='upper left')
    # y軸のメモリを1ずつに設定（答えが3なので）
    ax.set_yticks(range(-2, 6))
    setup_large_fonts(ax)
    plt.tight_layout()
    return fig

# 問題9: log_3(x+1) - log_3(x-1) = 1
def problem_9():
    fig, ax = plt.subplots(figsize=(12, 8))
    x = np.linspace(1.1, 5, 1000)
    y = np.log(x+1)/np.log(3) - np.log(x-1)/np.log(3)
    ax.plot(x, y, 'b-', linewidth=3, label=r'$y = \log_3(x+1) - \log_3(x-1)$')
    ax.axhline(y=1, color='r', linestyle='--', linewidth=2, label=r'$y = 1$')
    ax.axhline(y=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    ax.axvline(x=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    
    # 解をマーク
    sol = 2
    ax.plot(sol, 1, 'ro', markersize=12, markeredgecolor='darkred', markeredgewidth=2, zorder=10)
    ax.axvline(x=sol, color='g', linestyle=':', linewidth=1.5, alpha=0.5)
    
    ax.set_xlim(1, 5)
    ax.set_ylim(0, 2)
    ax.set_xlabel(r'$x$', fontsize=18)
    ax.set_ylabel(r'$y$', fontsize=18)
    ax.set_title(r'$\log_3(x+1) - \log_3(x-1) = 1$', fontsize=20)
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=14, loc='upper right')
    # y軸のメモリを1ずつに設定（答えが1なので）
    ax.set_yticks(range(0, 3))
    setup_large_fonts(ax)
    plt.tight_layout()
    return fig

# 問題10: 3^x + 3^(x+1) = 9^x
def problem_10():
    fig, ax = plt.subplots(figsize=(12, 8))
    x = np.linspace(-1, 2, 1000)
    y_left = 3**x + 3**(x+1)
    y_right = 9**x
    ax.plot(x, y_left, 'b-', linewidth=3, label=r'$y = 3^x + 3^{x+1}$')
    ax.plot(x, y_right, 'r-', linewidth=3, label=r'$y = 9^x$')
    ax.axhline(y=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    ax.axvline(x=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    
    # 解をマーク（交点）
    sol = np.log(4)/np.log(3)
    y_sol = 4 * 3**sol
    ax.plot(sol, y_sol, 'go', markersize=12, markeredgecolor='darkgreen', markeredgewidth=2, zorder=10, label='Solution')
    ax.axvline(x=sol, color='g', linestyle=':', linewidth=1.5, alpha=0.5)
    
    ax.set_xlim(-1, 2)
    ax.set_ylim(0, 20)
    ax.set_xlabel(r'$x$', fontsize=18)
    ax.set_ylabel(r'$y$', fontsize=18)
    ax.set_title(r'$3^x + 3^{x+1} = 9^x$', fontsize=20)
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=14, loc='upper left')
    setup_large_fonts(ax)
    plt.tight_layout()
    return fig

# 問題11: 2^(2x+1) - 2^(x+2) = 2^x - 2
def problem_11():
    fig, ax = plt.subplots(figsize=(12, 8))
    x = np.linspace(-2, 2, 1000)
    y = 2**(2*x+1) - 2**(x+2) - 2**x + 2
    ax.plot(x, y, 'b-', linewidth=3, label=r'$y = 2^{2x+1} - 2^{x+2} - 2^x + 2$')
    ax.axhline(y=0, color='r', linestyle='--', linewidth=2, label=r'$y = 0$')
    ax.axhline(y=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    ax.axvline(x=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    
    # 解をマーク
    solutions = [-1, 1]
    for sol in solutions:
        ax.plot(sol, 0, 'ro', markersize=12, markeredgecolor='darkred', markeredgewidth=2, zorder=10)
        ax.axvline(x=sol, color='g', linestyle=':', linewidth=1.5, alpha=0.5)
    
    ax.set_xlim(-2, 2)
    ax.set_ylim(-5, 10)
    ax.set_xlabel(r'$x$', fontsize=18)
    ax.set_ylabel(r'$y$', fontsize=18)
    ax.set_title(r'$2^{2x+1} - 2^{x+2} = 2^x - 2$', fontsize=20)
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=14, loc='upper left')
    # x軸のメモリを1ずつに設定（答えが-1, 1なので）
    ax.set_xticks(range(-2, 3))
    setup_large_fonts(ax)
    plt.tight_layout()
    return fig

# 問題12: sinh x = 5 (3^x - 3^(-x))/2 = 5
def problem_12():
    fig, ax = plt.subplots(figsize=(12, 8))
    x = np.linspace(-3.2, 3.2, 1000)
    sinh_x = (3**x - 3**(-x)) / 2
    ax.plot(x, sinh_x, 'b-', linewidth=3, label=r'$y = \frac{3^x - 3^{-x}}{2}$')
    ax.axhline(y=5, color='r', linestyle='--', linewidth=2, label=r'$y = 5$')
    ax.axhline(y=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    ax.axvline(x=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    
    # 解をマーク
    sol = np.log(5 + np.sqrt(26))/np.log(3)
    ax.plot(sol, 5, 'ro', markersize=12, markeredgecolor='darkred', markeredgewidth=2, zorder=10)
    ax.axvline(x=sol, color='g', linestyle=':', linewidth=1.5, alpha=0.5)
    
    ax.set_xlim(-3.2, 3.2)
    ax.set_ylim(-16, 16)
    ax.set_xlabel(r'$x$', fontsize=18)
    ax.set_ylabel(r'$y$', fontsize=18)
    ax.set_title(r'$\frac{3^x - 3^{-x}}{2} = 5$', fontsize=20)
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=14, loc='upper left')
    setup_large_fonts(ax)
    plt.tight_layout()
    return fig

# 問題13: cosh x = 5 (3^x + 3^(-x))/2 = 5
def problem_13():
    fig, ax = plt.subplots(figsize=(12, 8))
    x = np.linspace(-3.2, 3.2, 1000)
    cosh_x = (3**x + 3**(-x)) / 2
    ax.plot(x, cosh_x, 'b-', linewidth=3, label=r'$y = \frac{3^x + 3^{-x}}{2}$')
    ax.axhline(y=5, color='r', linestyle='--', linewidth=2, label=r'$y = 5$')
    ax.axhline(y=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    ax.axvline(x=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    
    # 解をマーク
    sol1 = np.log(5 + 2*np.sqrt(6))/np.log(3)
    sol2 = -sol1
    for sol in [sol1, sol2]:
        ax.plot(sol, 5, 'ro', markersize=12, markeredgecolor='darkred', markeredgewidth=2, zorder=10)
        ax.axvline(x=sol, color='g', linestyle=':', linewidth=1.5, alpha=0.5)
    
    ax.set_xlim(-3.2, 3.2)
    ax.set_ylim(0, 16)
    ax.set_xlabel(r'$x$', fontsize=18)
    ax.set_ylabel(r'$y$', fontsize=18)
    ax.set_title(r'$\frac{3^x + 3^{-x}}{2} = 5$', fontsize=20)
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=14, loc='upper left')
    setup_large_fonts(ax)
    plt.tight_layout()
    return fig

# 問題14: tanh x = 1/5
def problem_14():
    fig, ax = plt.subplots(figsize=(12, 8))
    x = np.linspace(-3, 3, 1000)
    sinh_x = (3**x - 3**(-x)) / 2
    cosh_x = (3**x + 3**(-x)) / 2
    tanh_x = sinh_x / cosh_x
    ax.plot(x, tanh_x, 'b-', linewidth=3, label=r'$y = \frac{3^x - 3^{-x}}{3^x + 3^{-x}}$')
    ax.axhline(y=1/5, color='r', linestyle='--', linewidth=2, label=r'$y = \frac{1}{5}$')
    ax.axhline(y=1, color='orange', linestyle=':', linewidth=2, label=r'$y = 1$ (upper bound)')
    ax.axhline(y=-1, color='orange', linestyle=':', linewidth=2, label=r'$y = -1$ (lower bound)')
    ax.axhline(y=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    ax.axvline(x=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    
    # 解をマーク
    solution_x = 0.5 * np.log(3/2) / np.log(3)
    ax.plot(solution_x, 1/5, 'ro', markersize=10, markeredgecolor='darkred', markeredgewidth=2, zorder=10, label='Solution')
    ax.axvline(x=solution_x, color='g', linestyle=':', linewidth=1, alpha=0.5)
    
    ax.set_xlim(-3, 3)
    ax.set_ylim(-1.2, 1.2)
    ax.set_xlabel(r'$x$', fontsize=18)
    ax.set_ylabel(r'$y$', fontsize=18)
    ax.set_title(r'$\frac{3^x - 3^{-x}}{3^x + 3^{-x}} = \frac{1}{5}$', fontsize=20)
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=14, loc='upper right')
    setup_large_fonts(ax)
    plt.tight_layout()
    return fig

# 問題15: cos 5x = 0
def problem_15():
    fig, ax = plt.subplots(figsize=(12, 8))
    x = np.linspace(0, 2*np.pi, 1000)
    y = np.cos(5*x)
    ax.plot(x, y, 'b-', linewidth=3, label=r'$y = \cos 5x$')
    ax.axhline(y=0, color='r', linestyle='--', linewidth=2, label=r'$y = 0$')
    ax.axvline(x=0, color='k', linestyle='-', linewidth=0.5, alpha=0.3)
    
    # 解をマーク
    solutions = [np.pi/10, 3*np.pi/10, np.pi/2, 7*np.pi/10, 9*np.pi/10, 
                 11*np.pi/10, 13*np.pi/10, 3*np.pi/2, 17*np.pi/10, 19*np.pi/10]
    for sol in solutions:
        ax.plot(sol, 0, 'ro', markersize=10, markeredgecolor='darkred', markeredgewidth=2, zorder=10)
        ax.axvline(x=sol, color='g', linestyle=':', linewidth=1, alpha=0.5)
    
    ax.set_xlim(0, 2*np.pi)
    ax.set_ylim(-1.2, 1.2)
    ax.set_xlabel(r'$x$', fontsize=18)
    ax.set_ylabel(r'$y$', fontsize=18)
    ax.set_title(r'$\cos 5x = 0$', fontsize=20)
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=14, loc='upper right')
    ax.set_xticks([0, np.pi/2, np.pi, 3*np.pi/2, 2*np.pi])
    ax.set_xticklabels(['0', r'$\frac{\pi}{2}$', r'$\pi$', r'$\frac{3\pi}{2}$', r'$2\pi$'])
    setup_large_fonts(ax)
    plt.tight_layout()
    return fig

def main():
    """メイン実行関数"""
    # 出力ディレクトリを作成
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(os.path.dirname(os.path.dirname(script_dir)))
    output_dir = os.path.join(project_root, "assets", "graphs", "trig_exp_log_equations")
    os.makedirs(output_dir, exist_ok=True)
    
    print("三角指数対数方程式問題のグラフを生成中...")
    
    problems = [
        (1, problem_1, "sin x = 1/2"),
        (2, problem_2, "2^(x+1) - 2^(x-1) = 3"),
        (3, problem_3, "log_2(x+1) + log_2(x-1) = 3"),
        (4, problem_4, "√3 sin x + cos x = 1"),
        (5, problem_5, "sin 3x + sin x = 0"),
        (6, problem_6, "sin x + sin 2x + sin 3x = 0"),
        (7, problem_7, "2 sin² x - sin x - 1 = 0"),
        (8, problem_8, "log_2 x + log_2(x+2) = 3"),
        (9, problem_9, "log_3(x+1) - log_3(x-1) = 1"),
        (10, problem_10, "3^x + 3^(x+1) = 9^x"),
        (11, problem_11, "2^(2x+1) - 2^(x+2) = 2^x - 2"),
        (12, problem_12, "sinh x = 5"),
        (13, problem_13, "cosh x = 5"),
        (14, problem_14, "tanh x = 1/5"),
        (15, problem_15, "cos 5x = 0"),
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
    print("すべての三角指数対数方程式問題のグラフ生成が完了しました！")
    print(f"出力先: {output_dir}")
    print("=" * 60)

if __name__ == "__main__":
    main()

