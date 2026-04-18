#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# graphgenerator_curves.py
# 曲線の弧長・面積の問題のグラフを生成
# 実行: python3 graphgenerator_curves.py

import os
import sys
import math
import numpy as np
import matplotlib as mpl
mpl.use("Agg")
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from common import sanitize_tex_for_mathtext, plot_integral_area_beta

N_PLOT = 1000

def plot_parametric_curve(x_func, y_func, t_range, title, out_path, highlight_range=None, fill_area=False, aspect_ratio=None):
    """
    パラメトリック曲線を描画
    
    Parameters:
    - x_func: x(t) の関数
    - y_func: y(t) の関数
    - t_range: (t_min, t_max) のタプル
    - title: グラフのタイトル（TeX形式）
    - out_path: 出力パス
    - highlight_range: 強調表示するtの範囲 (t_start, t_end) のタプル、Noneの場合は強調なし
    - fill_area: Trueの場合、曲線とx軸の間の面積を塗りつぶす
    """
    t_min, t_max = t_range
    t = np.linspace(t_min, t_max, N_PLOT)
    
    x = x_func(t)
    y = y_func(t)
    
    # 有効な値のみを抽出
    valid = ~(np.isnan(x) | np.isnan(y) | np.isinf(x) | np.isinf(y))
    x = x[valid]
    y = y[valid]
    
    if len(x) == 0:
        print(f"Warning: No valid points for {out_path}")
        return
    
    fig, ax = plt.subplots(figsize=(8, 8))
    
    # 全体の曲線を描画
    ax.plot(x, y, 'b-', linewidth=2, zorder=3)
    
    # 強調表示する範囲がある場合
    if highlight_range is not None:
        t_start, t_end = highlight_range
        t_highlight = np.linspace(t_start, t_end, N_PLOT)
        x_highlight = x_func(t_highlight)
        y_highlight = y_func(t_highlight)
        valid_highlight = ~(np.isnan(x_highlight) | np.isnan(y_highlight) | 
                          np.isinf(x_highlight) | np.isinf(y_highlight))
        x_highlight = x_highlight[valid_highlight]
        y_highlight = y_highlight[valid_highlight]
        if len(x_highlight) > 0:
            ax.plot(x_highlight, y_highlight, 'r-', linewidth=3, zorder=4)
    
    # 面積を塗りつぶす場合
    if fill_area and highlight_range is not None:
        t_start, t_end = highlight_range
        t_fill = np.linspace(t_start, t_end, N_PLOT)
        x_fill = x_func(t_fill)
        y_fill = y_func(t_fill)
        valid_fill = ~(np.isnan(x_fill) | np.isnan(y_fill) | 
                      np.isinf(x_fill) | np.isinf(y_fill))
        x_fill = x_fill[valid_fill]
        y_fill = y_fill[valid_fill]
        if len(x_fill) > 0:
            ax.fill_between(x_fill, 0, y_fill, alpha=0.3, color='yellow', zorder=1)
    
    ax.axhline(0, color='black', linewidth=0.8)
    ax.axvline(0, color='black', linewidth=0.8)
    ax.grid(True, linestyle=':', alpha=0.6)
    ax.set_xlabel('x', fontsize=12)
    ax.set_ylabel('y', fontsize=12)
    
    # タイトルを設定
    safe_title = sanitize_tex_for_mathtext(title or "")
    try:
        if safe_title.strip():
            ax.set_title(rf"${safe_title}$", fontsize=13)
    except Exception:
        pass
    
    # 軸の範囲を設定（縦横比を1:1にするため、範囲を調整）
    x_margin = (np.max(x) - np.min(x)) * 0.1 if len(x) > 0 else 1.0
    y_margin = (np.max(y) - np.min(y)) * 0.1 if len(y) > 0 else 1.0
    x_min = np.min(x) - x_margin
    x_max = np.max(x) + x_margin
    y_min = np.min(y) - y_margin
    y_max = np.max(y) + y_margin
    
    # サイクロイド（y = 1 - cos t）の場合、y方向の余白を小さくする
    # yの範囲が0から2の間にある場合、サイクロイドと判断
    is_cycloid = len(y) > 0 and np.min(y) >= -0.1 and np.max(y) <= 2.1
    if is_cycloid:
        y_min = -0.1  # 少し下に余白を取る
        y_max = 2.1   # 少し上に余白を取る
    
    # 縦横比を調整（aspect_ratioが指定されている場合は調整しない）
    if aspect_ratio is None:
        x_range = x_max - x_min
        y_range = y_max - y_min
        if x_range > y_range:
            # サイクロイドの場合は、y範囲を固定したままx範囲を調整しない
            if not is_cycloid:
                center_y = (y_min + y_max) / 2
                y_min = center_y - x_range / 2
                y_max = center_y + x_range / 2
        else:
            center_x = (x_min + x_max) / 2
            x_min = center_x - y_range / 2
            x_max = center_x + y_range / 2
    
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    # 縦横比の設定
    if aspect_ratio is not None:
        # 明示的に縦横比が指定されている場合
        ax.set_aspect(aspect_ratio, adjustable='box')
    elif is_cycloid:
        # サイクロイドの場合は縦横比を1:1にする
        ax.set_aspect('equal', adjustable='box')
        # サイクロイドの場合、メモリをx, yともに1刻みにする
        x_ticks = np.arange(np.floor(x_min), np.ceil(x_max) + 1, 1)
        y_ticks = np.arange(np.floor(y_min), np.ceil(y_max) + 1, 1)
        ax.set_xticks(x_ticks)
        ax.set_yticks(y_ticks)
    else:
        ax.set_aspect('equal', adjustable='box')
    
    try:
        fig.tight_layout()
    except Exception:
        fig.subplots_adjust(top=0.88)
    
    try:
        fig.savefig(out_path, dpi=200, bbox_inches='tight')
    except Exception:
        try:
            ax.set_title((title or "").replace("\n", " "), fontsize=10)
            fig.savefig(out_path, dpi=200, bbox_inches='tight')
        except Exception:
            plt.close(fig)
            raise
    
    plt.close(fig)


def plot_function_curve(func, x_range, title, out_path, highlight_range=None, fill_area=False):
    """
    通常の関数 y = f(x) を描画
    
    Parameters:
    - func: y = f(x) の関数
    - x_range: (x_min, x_max) のタプル
    - title: グラフのタイトル（TeX形式）
    - out_path: 出力パス
    - highlight_range: 強調表示するxの範囲 (x_start, x_end) のタプル、Noneの場合は強調なし
    - fill_area: Trueの場合、曲線とx軸の間の面積を塗りつぶす
    """
    x_min, x_max = x_range
    x = np.linspace(x_min, x_max, N_PLOT)
    
    with np.errstate(all='ignore'):
        y = func(x)
    
    # 有効な値のみを抽出
    valid = ~(np.isnan(y) | np.isinf(y))
    x = x[valid]
    y = y[valid]
    
    if len(x) == 0:
        print(f"Warning: No valid points for {out_path}")
        return
    
    fig, ax = plt.subplots(figsize=(8, 8))
    
    # 全体の曲線を描画
    ax.plot(x, y, 'b-', linewidth=2, zorder=3)
    
    # 強調表示する範囲がある場合
    if highlight_range is not None:
        x_start, x_end = highlight_range
        x_highlight = np.linspace(x_start, x_end, N_PLOT)
        with np.errstate(all='ignore'):
            y_highlight = func(x_highlight)
        valid_highlight = ~(np.isnan(y_highlight) | np.isinf(y_highlight))
        x_highlight = x_highlight[valid_highlight]
        y_highlight = y_highlight[valid_highlight]
        if len(x_highlight) > 0:
            ax.plot(x_highlight, y_highlight, 'r-', linewidth=3, zorder=4)
    
    # 面積を塗りつぶす場合
    if fill_area and highlight_range is not None:
        x_start, x_end = highlight_range
        x_fill = np.linspace(x_start, x_end, N_PLOT)
        with np.errstate(all='ignore'):
            y_fill = func(x_fill)
        valid_fill = ~(np.isnan(y_fill) | np.isinf(y_fill))
        x_fill = x_fill[valid_fill]
        y_fill = y_fill[valid_fill]
        if len(x_fill) > 0:
            ax.fill_between(x_fill, 0, y_fill, alpha=0.3, color='yellow', zorder=1)
    
    ax.axhline(0, color='black', linewidth=0.8)
    ax.axvline(0, color='black', linewidth=0.8)
    ax.grid(True, linestyle=':', alpha=0.6)
    ax.set_xlabel('x', fontsize=12)
    ax.set_ylabel('y', fontsize=12)
    
    # タイトルを設定
    safe_title = sanitize_tex_for_mathtext(title or "")
    try:
        if safe_title.strip():
            ax.set_title(rf"${safe_title}$", fontsize=13)
    except Exception:
        pass
    
    # 軸の範囲を設定（縦横比を1:1にするため、範囲を調整）
    x_margin = (np.max(x) - np.min(x)) * 0.1 if len(x) > 0 else 1.0
    y_margin = (np.max(y) - np.min(y)) * 0.1 if len(y) > 0 else 1.0
    x_min = np.min(x) - x_margin
    x_max = np.max(x) + x_margin
    if len(y) > 0 and np.min(y) >= 0:
        y_min = -y_margin
        y_max = np.max(y) + y_margin
    else:
        y_min = np.min(y) - y_margin
        y_max = np.max(y) + y_margin
    
    # 縦横比を1:1にするため、範囲を調整
    x_range = x_max - x_min
    y_range = y_max - y_min
    if x_range > y_range:
        center_y = (y_min + y_max) / 2
        y_min = center_y - x_range / 2
        y_max = center_y + x_range / 2
    else:
        center_x = (x_min + x_max) / 2
        x_min = center_x - y_range / 2
        x_max = center_x + y_range / 2
    
    ax.set_xlim(x_min, x_max)
    ax.set_ylim(y_min, y_max)
    ax.set_aspect('equal', adjustable='box')
    
    try:
        fig.tight_layout()
    except Exception:
        fig.subplots_adjust(top=0.88)
    
    try:
        fig.savefig(out_path, dpi=200, bbox_inches='tight')
    except Exception:
        try:
            ax.set_title((title or "").replace("\n", " "), fontsize=10)
            fig.savefig(out_path, dpi=200, bbox_inches='tight')
        except Exception:
            plt.close(fig)
            raise
    
    plt.close(fig)


def plot_3d_surface_of_revolution(x_func, y_func, t_range, title, out_path, axis='x', n_theta=50, x_range=None, y_range=None, force_aspect_1_1=False, surface_alpha=None, curve_label=None, curve_linewidth=None):
    """
    パラメトリック曲線を軸の周りに回転させた3D立体を描画
    
    Parameters:
    - x_func: x(t) の関数
    - y_func: y(t) の関数（y >= 0 を仮定）
    - t_range: (t_min, t_max) のタプル
    - title: グラフのタイトル（TeX形式）
    - out_path: 出力パス
    - axis: 回転軸 ('x' または 'y')
    - n_theta: 回転方向の分割数
    - x_range: x軸の範囲 (x_min, x_max) のタプル（オプション）
    - y_range: y軸の範囲 (y_min, y_max) のタプル（オプション）
    - surface_alpha: 表面の透明度（0.0-1.0、Noneの場合はデフォルト0.15）
    - curve_label: 元の曲線のラベル（オプション）
    - curve_linewidth: 元の曲線の線の太さ（オプション、デフォルトは3）
    """
    t_min, t_max = t_range
    t = np.linspace(t_min, t_max, N_PLOT)
    
    x_curve = x_func(t)
    y_curve = y_func(t)
    
    # 有効な値のみを抽出
    valid = ~(np.isnan(x_curve) | np.isnan(y_curve) | np.isinf(x_curve) | np.isinf(y_curve))
    x_curve = x_curve[valid]
    y_curve = y_curve[valid]
    
    if len(x_curve) == 0:
        print(f"Warning: No valid points for {out_path}")
        return
    
    # y >= 0 のみを使用
    if axis == 'x':
        # X軸の周りに回転: yを半径として使用
        y_curve = np.abs(y_curve)  # 負の値は無視
        theta = np.linspace(0, 2*math.pi, n_theta)
        T, Theta = np.meshgrid(t[valid], theta)
        X = x_func(T)
        Y = y_func(T) * np.cos(Theta)
        Z = y_func(T) * np.sin(Theta)
    else:
        # Y軸の周りに回転: xを半径として使用
        x_curve = np.abs(x_curve)  # 負の値は無視
        theta = np.linspace(0, 2*math.pi, n_theta)
        T, Theta = np.meshgrid(t[valid], theta)
        X = x_func(T) * np.cos(Theta)
        Y = y_func(T)
        Z = x_func(T) * np.sin(Theta)
    
    fig = plt.figure(figsize=(12, 10))
    ax = fig.add_subplot(111, projection='3d')
    
    # 表面を描画（色を薄く、編目を入れる）
    alpha_value = surface_alpha if surface_alpha is not None else 0.15
    ax.plot_surface(X, Y, Z, alpha=alpha_value, color='lightblue', 
                    linewidth=1.5, antialiased=True, shade=True, edgecolor='gray', edgecolors='gray')
    
    # 元の曲線を描画（強調表示）
    linewidth_value = curve_linewidth if curve_linewidth is not None else 3
    label_text = curve_label if curve_label is not None else 'Original curve'
    if axis == 'x':
        ax.plot(x_curve, y_curve, np.zeros_like(x_curve), 'r-', linewidth=linewidth_value, label=label_text)
        ax.plot(x_curve, -y_curve, np.zeros_like(x_curve), 'r-', linewidth=linewidth_value)
    else:
        ax.plot(x_curve, y_curve, np.zeros_like(x_curve), 'r-', linewidth=linewidth_value, label=label_text)
        ax.plot(-x_curve, y_curve, np.zeros_like(x_curve), 'r-', linewidth=linewidth_value)
    
    # 軸の設定
    ax.set_xlabel('x', fontsize=14, labelpad=10)
    ax.set_ylabel('y', fontsize=14, labelpad=10)
    ax.set_zlabel('z', fontsize=14, labelpad=10)
    
    # タイトルを設定
    safe_title = sanitize_tex_for_mathtext(title or "")
    try:
        if safe_title.strip():
            ax.set_title(rf"${safe_title}$", fontsize=16, pad=20)
    except Exception:
        pass
    
    # 表示範囲の設定
    # x軸の範囲を設定
    if x_range is not None:
        # 明示的にx軸の範囲が指定されている場合（問題10のサイクロイド用）
        x_lim_min, x_lim_max = x_range
        x_margin = 0
    else:
        # x軸の範囲はt_rangeに基づいて設定（サイクロイドの場合は0から2π）
        t_min, t_max = t_range
        # x(t)の範囲を計算
        x_min, x_max = np.min(x_curve), np.max(x_curve)
        
        # サイクロイドの場合、x(t) = t - sin(t)なので、t=0でx=0、t=2πでx=2π
        # t_rangeが(0, 2π)の場合は、x軸の範囲を0から2πに固定
        if abs(t_min) < 0.01 and abs(t_max - 2*math.pi) < 0.01:
            # サイクロイドの場合、x軸の範囲を0から2πに固定
            x_lim_min = 0
            x_lim_max = 2*math.pi
            # マージンは小さく（範囲を固定しているため）
            x_margin = (2*math.pi) * 0.05
        else:
            x_lim_min = x_min
            x_lim_max = x_max
            x_margin = (x_max - x_min) * 0.1
    
    # y軸とz軸の範囲を設定
    if axis == 'x':
        y_max = np.max(y_curve)
        z_max = y_max
        margin = max(x_lim_max - x_lim_min, y_max, z_max) * 0.1
        x_lim_min = x_lim_min - x_margin
        x_lim_max = x_lim_max + x_margin
        # y軸が表示されるように、y_lim_minを負の値にする
        y_lim_min = -y_max - margin
        y_lim_max = y_max + margin
        z_lim_min = -y_max - margin
        z_lim_max = y_max + margin
    else:
        # y軸の周りに回転する場合
        y_max = np.max(y_curve)
        z_max = np.max(x_curve)  # x(t)が半径になる
        
        # y軸の範囲を設定
        if y_range is not None:
            # 明示的にy軸の範囲が指定されている場合
            y_lim_min, y_lim_max = y_range
            y_margin = 0
        elif abs(t_min) < 0.01 and abs(t_max - math.pi/2) < 0.01:
            # y = sin x の場合、y軸の範囲を0から1に固定
            y_lim_min = 0
            y_lim_max = 1
            y_margin = 0.05
        else:
            y_lim_min = 0
            y_lim_max = y_max
            y_margin = y_max * 0.1
        
        margin = max(x_lim_max - x_lim_min, y_lim_max - y_lim_min, z_max) * 0.1
        x_lim_min = x_lim_min - x_margin
        x_lim_max = x_lim_max + x_margin
        y_lim_min = y_lim_min - y_margin
        y_lim_max = y_lim_max + y_margin
        z_lim_min = -z_max - margin
        z_lim_max = z_max + margin
    
    ax.set_xlim(x_lim_min, x_lim_max)
    ax.set_ylim(y_lim_min, y_lim_max)
    ax.set_zlim(z_lim_min, z_lim_max)
    
    # 軸の線を描画（x軸、y軸、z軸と原点を表示）- 端から端まで伸ばす
    # x軸（赤）- 端から端まで
    ax.plot([x_lim_min, x_lim_max], [0, 0], [0, 0], 'r-', linewidth=2, alpha=0.8, label='x-axis')
    
    # y軸（緑）- 端から端まで
    ax.plot([0, 0], [y_lim_min, y_lim_max], [0, 0], 'g-', linewidth=2, alpha=0.8, label='y-axis')
    
    # z軸（青）- 端から端まで
    ax.plot([0, 0], [0, 0], [z_lim_min, z_lim_max], 'b-', linewidth=2, alpha=0.8, label='z-axis')
    
    # 原点を表示
    if (x_lim_min <= 0 <= x_lim_max and 
        y_lim_min <= 0 <= y_lim_max and 
        z_lim_min <= 0 <= z_lim_max):
        ax.scatter([0], [0], [0], color='black', s=50, marker='o', zorder=10)
    
    # 目盛りの設定（適度な数に）
    n_ticks = 5
    x_ticks = np.linspace(x_lim_min, x_lim_max, n_ticks)
    y_ticks = np.linspace(y_lim_min, y_lim_max, n_ticks)
    z_ticks = np.linspace(z_lim_min, z_lim_max, n_ticks)
    
    ax.set_xticks(x_ticks)
    ax.set_yticks(y_ticks)
    ax.set_zticks(z_ticks)
    
    # 目盛りラベルのフォントサイズを小さく
    ax.tick_params(axis='x', labelsize=8, pad=2)
    ax.tick_params(axis='y', labelsize=8, pad=2)
    ax.tick_params(axis='z', labelsize=8, pad=2)
    
    # 1:1の縦横比を強制する場合
    if force_aspect_1_1:
        # 各軸の範囲の最大値を取得
        x_range_len = x_lim_max - x_lim_min
        y_range_len = y_lim_max - y_lim_min
        z_range_len = z_lim_max - z_lim_min
        max_range = max(x_range_len, y_range_len, z_range_len)
        
        # 各軸の中心を計算
        x_center = (x_lim_min + x_lim_max) / 2
        y_center = (y_lim_min + y_lim_max) / 2
        z_center = (z_lim_min + z_lim_max) / 2
        
        # 各軸を最大範囲に合わせて調整
        ax.set_xlim(x_center - max_range/2, x_center + max_range/2)
        ax.set_ylim(y_center - max_range/2, y_center + max_range/2)
        ax.set_zlim(z_center - max_range/2, z_center + max_range/2)
    
    # 視点の設定（見やすい角度）
    # y軸が縦になるように、elevを上げる
    if axis == 'y':
        # y軸が縦になるように、elevを上げる（上から見下ろす角度を大きく）
        # y_rangeが指定されている場合は、よりy軸が縦になるように調整
        if y_range is not None:
            ax.view_init(elev=60, azim=45)  # y軸を縦にするためelevを大きく
        else:
            ax.view_init(elev=30, azim=45)
    elif x_range is not None:
        # -1側を手前にするため、azimを調整（180度回転して反対側から見る）
        ax.view_init(elev=20, azim=225)  # 225度で-1側が手前に
    else:
        ax.view_init(elev=20, azim=45)
    
    # グリッド（控えめに）
    ax.grid(True, alpha=0.2, linestyle=':')
    
    # 凡例を表示（ラベルが指定されている場合）
    if curve_label is not None:
        ax.legend(loc='upper right', fontsize=12)
    
    try:
        fig.tight_layout()
    except Exception:
        fig.subplots_adjust(top=0.9)
    
    try:
        fig.savefig(out_path, dpi=200, bbox_inches='tight')
    except Exception:
        try:
            ax.set_title((title or "").replace("\n", " "), fontsize=12)
            fig.savefig(out_path, dpi=200, bbox_inches='tight')
        except Exception:
            plt.close(fig)
            raise
    
    plt.close(fig)


def main():
    # 絶対パスで出力ディレクトリを設定
    script_dir = os.path.dirname(os.path.abspath(__file__))
    # lib/graph_generator/integral/graphgenerator_curves.py から
    # プロジェクトルート (joymath/) に戻る: ../../../
    # script_dir = lib/graph_generator/integral
    # -> lib/graph = os.path.dirname(script_dir)
    # -> lib = os.path.dirname(os.path.dirname(script_dir))
    # -> project_root = os.path.dirname(os.path.dirname(os.path.dirname(script_dir)))
    project_root = os.path.dirname(os.path.dirname(os.path.dirname(script_dir)))
    out_dir = os.path.join(project_root, "assets", "graphs", "integral", "problems_curves")
    os.makedirs(out_dir, exist_ok=True)
    
    # 部分積分の問題9用の出力ディレクトリ
    out_dir_integration_by_parts = os.path.join(project_root, "assets", "graphs", "integral", "problems_curves")
    os.makedirs(out_dir_integration_by_parts, exist_ok=True)
    
    # 問題2, 3, 8, 9: サイクロイド曲線
    # x = t - sin t, y = 1 - cos t
    def cycloid_x(t):
        return t - np.sin(t)
    
    def cycloid_y(t):
        return 1 - np.cos(t)
    
    # 問題2: 積分 ∫₀²π √(2-2cos x) dx
    def integrand2(x):
        return np.sqrt(2 - 2*np.cos(x))
    
    plot_integral_area_beta(
        integrand2,
        0, 2*math.pi,
        r"\int_0^{2\pi} \sqrt{2 - 2\cos x} \, dx",
        os.path.join(out_dir, "problem_2.png")
    )
    
    # 問題2: サイクロイド曲線（別画像）
    plot_parametric_curve(
        cycloid_x, cycloid_y,
        (0, 2*math.pi),
        r"x = t - \sin t, \; y = 1 - \cos t",
        os.path.join(out_dir, "problem_2_curve.png"),
        highlight_range=(0, 2*math.pi),
        fill_area=False
    )
    
    # 問題3: 積分 ∫₀²π (1-cos x)² dx
    def integrand3(x):
        return (1 - np.cos(x))**2
    
    plot_integral_area_beta(
        integrand3,
        0, 2*math.pi,
        r"\int_0^{2\pi} (1-\cos x)^2 \, dx",
        os.path.join(out_dir, "problem_3.png")
    )
    
    # 問題3: サイクロイド曲線（面積を塗った図）
    plot_parametric_curve(
        cycloid_x, cycloid_y,
        (0, 2*math.pi),
        r"x = t - \sin t, \; y = 1 - \cos t",
        os.path.join(out_dir, "problem_3_area.png"),
        highlight_range=(0, 2*math.pi),
        fill_area=True
    )
    
    # 問題4: 放物線 y = x^2 の弧長計算で現れる積分 ∫₀¹ √(1+4x²) dx
    def integrand4(x):
        return np.sqrt(1 + 4*x**2)
    
    plot_integral_area_beta(
        integrand4,
        0, 1,
        r"\int_0^1 \sqrt{1 + 4x^2} \, dx",
        os.path.join(out_dir, "problem_4.png")
    )
    
    # 問題4: 放物線 y = x^2（別画像）
    def parabola1(x):
        return x**2
    
    plot_function_curve(
        parabola1,
        (-0.5, 1.5),
        r"y = x^2",
        os.path.join(out_dir, "problem_4_curve.png"),
        highlight_range=(0, 1),
        fill_area=False
    )
    
    # 問題5: 積分 ∫₀¹ √(1+4x²) dx
    def integrand5(x):
        return np.sqrt(1 + 4*x**2)
    
    plot_integral_area_beta(
        integrand5,
        0, 1,
        r"\int_0^1 \sqrt{1 + 4x^2} \, dx",
        os.path.join(out_dir, "problem_5.png")
    )
    
    # 問題5: 放物線 y = 1 + x^2（別画像）
    def parabola2(x):
        return 1 + x**2
    
    plot_function_curve(
        parabola2,
        (-0.5, 1.5),
        r"y = 1 + x^2",
        os.path.join(out_dir, "problem_5_curve.png"),
        highlight_range=(0, 1),
        fill_area=False
    )
    
    # 問題6, 7, 10, 11: アステロイド曲線
    # x = cos^3 t, y = sin^3 t
    def astroid_x(t):
        return np.cos(t)**3
    
    def astroid_y(t):
        return np.sin(t)**3
    
    # 問題6: 積分 ∫₀²π |sin x cos x| dx
    def integrand6(x):
        return np.abs(np.sin(x) * np.cos(x))
    
    plot_integral_area_beta(
        integrand6,
        0, 2*math.pi,
        r"\int_0^{2\pi} |\sin x \cos x| \, dx",
        os.path.join(out_dir, "problem_6.png")
    )
    
    # 問題6: アステロイド曲線（別画像）
    plot_parametric_curve(
        astroid_x, astroid_y,
        (0, 2*math.pi),
        r"x = \cos^3 t, \; y = \sin^3 t",
        os.path.join(out_dir, "problem_6_curve.png"),
        highlight_range=(0, 2*math.pi),
        fill_area=False
    )
    
    # 問題7: 積分 ∫₀^(π/2) sin⁶ x dx
    def integrand7(x):
        return np.sin(x)**6
    
    plot_integral_area_beta(
        integrand7,
        0, math.pi/2,
        r"\int_0^{\frac{\pi}{2}} \sin^6 x \, dx",
        os.path.join(out_dir, "problem_7.png")
    )
    
    # 問題7: アステロイド曲線（面積を塗った図）
    plot_parametric_curve(
        astroid_x, astroid_y,
        (0, 2*math.pi),
        r"x = \cos^3 t, \; y = \sin^3 t",
        os.path.join(out_dir, "problem_7_area.png"),
        highlight_range=(0, 2*math.pi),
        fill_area=True
    )
    
    # 問題8: 積分 ∫₀²π (1-cos x)² sin x dx
    def integrand8(x):
        return (1 - np.cos(x))**2 * np.sin(x)
    
    plot_integral_area_beta(
        integrand8,
        0, 2*math.pi,
        r"\int_0^{2\pi} (1-\cos x)^2 \sin x \, dx",
        os.path.join(out_dir, "problem_8.png")
    )
    
    # 問題8: サイクロイドのX軸回転体積の図
    plot_parametric_curve(
        cycloid_x, cycloid_y,
        (0, 2*math.pi),
        r"x = t - \sin t, \; y = 1 - \cos t",
        os.path.join(out_dir, "problem_8_volume.png"),
        highlight_range=(0, 2*math.pi),
        fill_area=False
    )
    
    # 問題9: 積分 ∫₀²π (x-sin x)² sin x dx
    def integrand9(x):
        return (x - np.sin(x))**2 * np.sin(x)
    
    plot_integral_area_beta(
        integrand9,
        0, 2*math.pi,
        r"\int_0^{2\pi} (x - \sin x)^2 \sin x \, dx",
        os.path.join(out_dir, "problem_9.png")
    )
    
    # 問題9: サイクロイドのY軸回転体積の図
    plot_parametric_curve(
        cycloid_x, cycloid_y,
        (0, 2*math.pi),
        r"x = t - \sin t, \; y = 1 - \cos t",
        os.path.join(out_dir, "problem_9_volume.png"),
        highlight_range=(0, 2*math.pi),
        fill_area=False
    )
    
    # 問題10: 積分 ∫₀²π (1-cos x)³ dx（サイクロイドのX軸回転体積）
    def integrand10(x):
        return (1 - np.cos(x))**3
    
    plot_integral_area_beta(
        integrand10,
        0, 2*math.pi,
        r"\int_0^{2\pi} (1-\cos x)^3 \, dx",
        os.path.join(out_dir, "problem_10.png")
    )
    
    # 問題10: サイクロイドの平面図（2D）- 縦横比1:1
    plot_parametric_curve(
        cycloid_x, cycloid_y,
        (0, 2*math.pi),
        r"x = t - \sin t, \; y = 1 - \cos t",
        os.path.join(out_dir, "problem_10_curve.png"),
        highlight_range=(0, 2*math.pi),
        fill_area=False
    )
    
    # 問題10: サイクロイドのX軸回転体積の3D図
    # x軸の範囲を-1から7に固定
    plot_3d_surface_of_revolution(
        cycloid_x, cycloid_y,
        (0, 2*math.pi),
        r"x = t - \sin t, \; y = 1 - \cos t \text{ (rotated around } x \text{-axis)}",
        os.path.join(out_dir, "problem_10_volume.png"),
        axis='x',
        n_theta=30,
        x_range=(-1, 7),
        force_aspect_1_1=True
    )
    
    # 問題11: 積分 ∫₀²π x sin² x dx
    def integrand11(x):
        return x * np.sin(x)**2
    
    plot_integral_area_beta(
        integrand11,
        0, 2*math.pi,
        r"\int_0^{2\pi} x \sin^2 x \, dx",
        os.path.join(out_dir, "problem_11.png")
    )
    
    # 問題11: sin^7 t cos^2 t のグラフ（アステロイド回転体積の計算過程で現れる）
    def sin7_cos2(t):
        return np.sin(t)**7 * np.cos(t)**2
    
    plot_function_curve(
        sin7_cos2,
        (0, 2*math.pi),
        r"\sin^7 t \cos^2 t",
        os.path.join(out_dir, "problem_11_volume.png"),
        highlight_range=(0, 2*math.pi),
        fill_area=False
    )

    # 問題1: sin^n xの積分とアステロイドへの応用
    # 問題1: 積分 ∫₀^(π/2) sin^9 x dx
    def integrand1(x):
        return np.sin(x)**9
    
    plot_integral_area_beta(
        integrand1,
        0, math.pi/2,
        r"\int_0^{\frac{\pi}{2}} \sin^9 x \, dx",
        os.path.join(out_dir, "problem_1_sin9.png")
    )
    
    # アステロイド曲線全体
    plot_parametric_curve(
        astroid_x, astroid_y,
        (0, 2*math.pi),
        r"x = \cos^3 t, \; y = \sin^3 t",
        os.path.join(out_dir, "sin_power_and_astroid.png"),
        highlight_range=(0, 2*math.pi),
        fill_area=False
    )
    
    # アステロイドの面積（第1象限を強調）
    plot_parametric_curve(
        astroid_x, astroid_y,
        (0, 2*math.pi),
        r"x = \cos^3 t, \; y = \sin^3 t",
        os.path.join(out_dir, "astroid_area.png"),
        highlight_range=(0, math.pi/2),
        fill_area=True
    )
    
    # アステロイドのX軸回転体積
    plot_parametric_curve(
        astroid_x, astroid_y,
        (0, 2*math.pi),
        r"x = \cos^3 t, \; y = \sin^3 t",
        os.path.join(out_dir, "astroid_volume.png"),
        highlight_range=(0, 2*math.pi),
        fill_area=False
    )
    
    # 問題9（部分積分）: y = sin x (0 ≤ x ≤ π/2) を y 軸の周りに回転させた回転体
    # パラメトリック表示: x(t) = t, y(t) = sin(t) (0 ≤ t ≤ π/2)
    def sin_curve_x(t):
        return t
    
    def sin_curve_y(t):
        return np.sin(t)
    
    # 問題9: y 軸の周りに回転させた3D図
    # 描画範囲: x=-2から2、y=0から1.5
    # ラッパみたいな部分を色で塗るため、surface_alphaを大きく
    plot_3d_surface_of_revolution(
        sin_curve_x, sin_curve_y,
        (0, math.pi/2),
        r"y = \sin x \text{ (rotated around } y \text{-axis)}",
        os.path.join(out_dir_integration_by_parts, "problem_9_volume.png"),
        axis='y',
        n_theta=30,
        x_range=(-2, 2),
        y_range=(0, 1.5),
        surface_alpha=0.4,
        curve_label=r"$y = \sin x$",
        curve_linewidth=5
    )


if __name__ == "__main__":
    main()

