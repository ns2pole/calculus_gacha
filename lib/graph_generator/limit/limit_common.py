import math
import numpy as np
import matplotlib as mpl
mpl.use("Agg")
import matplotlib.pyplot as plt
import re

N_PLOT = 500  # 共通で使用

# 極限問題用のデフォルト設定
DEFAULT_LIMIT_SPEC = {
    "line_color": "#2196F3",
    "line_width": 2,
    "point_color": "#FF5722",
    "point_size": 50,
    "grid_alpha": 0.6
}

def sanitize_tex_for_mathtext(tex: str) -> str:
    """
    matplotlib.mathtext に渡す前に TeX をできるだけ安全な形に正規化する。
    """
    if not tex:
        return ""

    s = str(tex)
    s = s.replace("\n", " ")
    s = s.replace("&", " ")
    s = re.sub(r"\s+", " ", s).strip()

    # TeX の空白コマンドを半角スペースに
    s = s.replace(r"\,", " ")
    s = s.replace(r"\;", " ")
    s = s.replace(r"\:", " ")
    s = s.replace(r"\quad", " ")
    s = s.replace(r"\qquad", " ")
    pattern = (
        r'\\'                                    # \ から始まり
        r'(sin|cos|tan|log|ln|exp|sinh|cosh|tanh'
        r'|arcsin|arccos|arctan|sec|csc|cot'
        r'|max|min|sup|inf|lim|det|ker|dim|arg|gcd|lcm)'  # 関数名
        r'(?:\s*(\^\{[^}]*\}|\^\w|_\{[^}]*\}|_\w))?'      # 任意の ^ と _
        r'(?:\s*\\(?:!|,|:|;|quad|qquad))*'               # 直後の空白調整(\!, \, など)は吸収
        r'\s*\('                                          # ( の直前まで
    )
    replacement = r'\\\1\2 ('   # 関数名(+ ^/_ があれば) の直後に「半角スペース + (」

    s = re.sub(pattern, replacement, s)
    # mathtext が苦手なコマンドを除去
    s = re.sub(r"\\(?:left|right)\s*", "", s)
    s = re.sub(r"\\(?:bigl|bigr|biggl|biggr|Bigl|Bigr|Biggl|Biggr|big|Big)\s*", "", s)
    s = re.sub(r"\\(?:left|right|bigl|bigr|biggl|biggr|Bigl|Bigr|BigGL|BigGR)\b", "", s)

    # \frac の正規化
    s = re.sub(r"\\frac\s*\{\s*([^}]+?)\s*\}\s*\{\s*([^}]+?)\s*\}", r"\\frac{\1}{\2}", s)
    s = re.sub(r"\\frac\s*([0-9]+)\s*/\s*([0-9]+)", r"\\frac{\1}{\2}", s)
    s = re.sub(r"\\frac([0-9]+)([0-9]+)", r"\\frac{\1}{\2}", s)
    s = re.sub(r"\\frac\s+([^\s\{\}]+)\s+([^\s\{\}]+)", r"\\frac{\1}{\2}", s)

    s = s.replace(r"\displaystyle", "")
    s = s.replace("\\\\", "\\")
    s = re.sub(r"\s+", " ", s).strip()

    return s

def _set_title_safe(ax, tex, fontsize, fallback_fs):
    safe_tex = sanitize_tex_for_mathtext(tex or "")
    try:
        ax.set_title(rf"${safe_tex}$", fontsize=fontsize)
    except Exception:
        ax.set_title((tex or "").replace("\n", " "), fontsize=fallback_fs)

def _calc_and_set_ylim(ax, y):
    finite_y = y[~np.isnan(y) & ~np.isinf(y)]
    if finite_y.size == 0:
        y_min, y_max = -1.0, 1.0
    else:
        y_min, y_max = float(np.min(finite_y)), float(np.max(finite_y))
        if y_min == y_max:
            y_min -= 0.5
            y_max += 0.5
    y_range = y_max - y_min
    if y_range == 0:
        y_range = abs(y_max) if y_max != 0 else 1.0
    # 縦方向の余裕を増やす（特にeの値やπ/4がある場合）
    margin_factor = 0.15  # 15%の余裕を追加
    
    # 重要な極限値がある場合は特別に余裕を増やす
    import math
    if (abs(y_max - math.pi/4) < 1e-10 or abs(y_min - math.pi/4) < 1e-10 or
        abs(y_max - math.e) < 1e-10 or abs(y_min - math.e) < 1e-10 or
        abs(y_max - math.e**2) < 1e-10 or abs(y_min - math.e**2) < 1e-10 or
        abs(y_max - math.e**3) < 1e-10 or abs(y_min - math.e**3) < 1e-10 or
        abs(y_max - math.e**(-1)) < 1e-10 or abs(y_min - math.e**(-1)) < 1e-10 or
        abs(y_max - math.e/2) < 1e-10 or abs(y_min - math.e/2) < 1e-10 or
        abs(y_max - (-math.e/2)) < 1e-10 or abs(y_min - (-math.e/2)) < 1e-10 or
        abs(y_max - math.log(2)) < 1e-10 or abs(y_min - math.log(2)) < 1e-10 or
        abs(y_max - 2/math.pi) < 1e-10 or abs(y_min - 2/math.pi) < 1e-10 or
        abs(y_max - 3/4) < 1e-10 or abs(y_min - 3/4) < 1e-10 or
        abs(y_max - (-1/2)) < 1e-10 or abs(y_min - (-1/2)) < 1e-10 or
        abs(y_max - math.cos(2)) < 1e-10 or abs(y_min - math.cos(2)) < 1e-10):
        margin_factor = 0.35  # 重要な極限値の場合は35%の余裕を追加
    
    ax.set_ylim(y_min - margin_factor * y_range, y_max + margin_factor * y_range)

def plot_limit_function(func, tex, out_path, x_min=-5, x_max=5, 
                       limit_point=None, limit_value=None,
                       figsize=(8, 4.8), show_limit_point=True,
                       xlabel="x", ylabel="y", blue_label=None, red_label=None, legend_loc='upper right'):
    """
    極限問題の関数をプロットする
    
    Args:
        func: プロットする関数
        tex: タイトル用のTeX文字列
        out_path: 出力パス
        x_min, x_max: x軸の範囲
        limit_point: 極限を取る点（Noneの場合は0）
        limit_value: 極限値（プロット用）
        figsize: 図のサイズ
        show_limit_point: 極限点を表示するかどうか
        blue_label: 青線の凡例ラベル
        red_label: 赤線の凡例ラベル
    """
    if limit_point is None:
        limit_point = 0.0
    
    x = np.linspace(x_min, x_max, N_PLOT)
    with np.errstate(all="ignore"):
        y = func(x)
    
    fig, ax = plt.subplots(figsize=figsize)
    
    # 関数をプロット
    ax.plot(x, y, color=DEFAULT_LIMIT_SPEC["line_color"], 
            linewidth=DEFAULT_LIMIT_SPEC["line_width"], zorder=2,
            label=blue_label or '')
    
    # 極限点をプロット
    if show_limit_point and limit_point is not None:
        if not np.isnan(limit_point) and not np.isinf(limit_point):
            try:
                y_limit = func(limit_point)
                if not np.isnan(y_limit) and not np.isinf(y_limit):
                    ax.scatter([limit_point], [y_limit], 
                             color=DEFAULT_LIMIT_SPEC["point_color"],
                             s=DEFAULT_LIMIT_SPEC["point_size"], zorder=3)
            except:
                pass
    
    # 極限値の水平線を表示
    if limit_value is not None and not np.isnan(limit_value) and not np.isinf(limit_value):
        ax.axhline(y=limit_value, color='red', linestyle='--', alpha=0.7, zorder=1, 
                  label=red_label or '')
    
    # 軸線
    ax.axhline(0.0, color="black", lw=1, zorder=1)
    ax.axvline(0.0, color="black", lw=1, zorder=1)
    
    # タイトル設定
    _set_title_safe(ax, tex, fontsize=14, fallback_fs=12)
    
    # 軸ラベル
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    
    # y軸の範囲設定
    _calc_and_set_ylim(ax, y)
    
    # x軸の範囲設定
    ax.set_xlim(x_min, x_max)
    
    # グリッド
    ax.grid(True, linestyle=":", alpha=DEFAULT_LIMIT_SPEC["grid_alpha"])
    
    # 凡例を表示（ラベルがある場合のみ）
    if blue_label or red_label:
        ax.legend(loc=legend_loc, fontsize=10, framealpha=0.9, edgecolor='black', facecolor='white')
    
    # レイアウト調整
    try:
        fig.tight_layout()
    except Exception:
        fig.subplots_adjust(top=0.88)
    
    # 保存
    try:
        fig.savefig(out_path, dpi=200)
    except Exception:
        try:
            ax.set_title((tex or "").replace("\n", " "), fontsize=10)
            fig.savefig(out_path, dpi=200)
        except Exception:
            plt.close(fig)
            raise
    return fig

def plot_limit_sequence(func, tex, out_path, n_min=1, n_max=20,
                       figsize=(8, 4.8), show_limit_value=True, limit_value=None,
                       comparison_func=None, comparison_label=None,
                       blue_label=None, red_label=None, legend_loc='upper right'):
    """
    数列の極限問題をプロットする
    
    Args:
        func: 数列の関数 f(n)
        tex: タイトル用のTeX文字列
        out_path: 出力パス
        n_min, n_max: nの範囲
        figsize: 図のサイズ
        show_limit_value: 極限値を表示するかどうか
        limit_value: 指定された極限値（e, e², e³など）
    """
    n = np.arange(n_min, n_max + 1, 1)
    with np.errstate(all="ignore"):
        y = func(n)
    
    fig, ax = plt.subplots(figsize=figsize)
    
    # 数列をプロット
    ax.plot(n, y, 'o-', color=DEFAULT_LIMIT_SPEC["line_color"], 
            linewidth=DEFAULT_LIMIT_SPEC["line_width"], 
            markersize=6, zorder=2, label=blue_label or '')
    
    # 比較関数をプロット（赤色）
    if comparison_func is not None:
        comparison_y = comparison_func(n)
        ax.plot(n, comparison_y, 'r-', linewidth=2, 
                label=comparison_label or 'comparison', zorder=1)
    
    # 極限値を表示
    if show_limit_value:
        if limit_value is not None and not np.isnan(limit_value) and not np.isinf(limit_value):
            # 指定された極限値を使用
            ax.axhline(y=limit_value, color='red', linestyle='--', 
                     alpha=0.7, zorder=1, label=red_label or '')
            
            # 赤線の左端に極限値のテキストを表示する機能を削除
            # import math
            # # x軸の範囲を取得
            # x_min, x_max = ax.get_xlim()
            # x_left = x_min + 0.05 * (x_max - x_min)  # 左端から5%の位置に
            # 
            # if abs(limit_value - math.e) < 1e-10:
            #     ax.text(x_left, limit_value, '$e$', fontsize=10, 
            #            verticalalignment='center', horizontalalignment='left',
            #            bbox=dict(boxstyle='round,pad=0.2', facecolor='white', alpha=0.9))
            # elif abs(limit_value - math.e**2) < 1e-10:
            #     ax.text(x_left, limit_value, '$e^2$', fontsize=10, 
            #            verticalalignment='center', horizontalalignment='left',
            #            bbox=dict(boxstyle='round,pad=0.2', facecolor='white', alpha=0.9))
            # elif abs(limit_value - math.e**3) < 1e-10:
            #     ax.text(x_left, limit_value, '$e^3$', fontsize=10, 
            #            verticalalignment='center', horizontalalignment='left',
            #            bbox=dict(boxstyle='round,pad=0.2', facecolor='white', alpha=0.9))
            # elif abs(limit_value - math.e**(-1)) < 1e-10:
            #     ax.text(x_left, limit_value, '$e^{-1}$', fontsize=10, 
            #            verticalalignment='center', horizontalalignment='left',
            #            bbox=dict(boxstyle='round,pad=0.2', facecolor='white', alpha=0.9))
            # elif abs(limit_value - math.e/2) < 1e-10:
            #     ax.text(x_left, limit_value, '$\\frac{e}{2}$', fontsize=10, 
            #            verticalalignment='center', horizontalalignment='left',
            #            bbox=dict(boxstyle='round,pad=0.2', facecolor='white', alpha=0.9))
            # elif abs(limit_value - (-math.e/2)) < 1e-10:
            #     ax.text(x_left, limit_value, '$-\\frac{e}{2}$', fontsize=10, 
            #            verticalalignment='center', horizontalalignment='left',
            #            bbox=dict(boxstyle='round,pad=0.2', facecolor='white', alpha=0.9))
            # elif abs(limit_value - math.log(2)) < 1e-10:
            #     ax.text(x_left, limit_value, '$\\log 2$', fontsize=10, 
            #            verticalalignment='center', horizontalalignment='left',
            #            bbox=dict(boxstyle='round,pad=0.2', facecolor='white', alpha=0.9))
            # elif abs(limit_value - math.pi/4) < 1e-10:
            #     ax.text(x_left, limit_value, '$\\frac{\\pi}{4}$', fontsize=14, 
            #            verticalalignment='center', horizontalalignment='left',
            #            bbox=dict(boxstyle='round,pad=0.3', facecolor='white', alpha=0.9))
            # elif abs(limit_value - 2/math.pi) < 1e-10:
            #     ax.text(x_left, limit_value, '$\\frac{2}{\\pi}$', fontsize=10, 
            #            verticalalignment='center', horizontalalignment='left',
            #            bbox=dict(boxstyle='round,pad=0.2', facecolor='white', alpha=0.9))
            # elif abs(limit_value - 3/4) < 1e-10:
            #     ax.text(x_left, limit_value, '$\\frac{3}{4}$', fontsize=10, 
            #            verticalalignment='center', horizontalalignment='left',
            #            bbox=dict(boxstyle='round,pad=0.2', facecolor='white', alpha=0.9))
            # elif abs(limit_value - (-1/2)) < 1e-10:
            #     ax.text(x_left, limit_value, '$-\\frac{1}{2}$', fontsize=10, 
            #            verticalalignment='center', horizontalalignment='left',
            #            bbox=dict(boxstyle='round,pad=0.2', facecolor='white', alpha=0.9))
            # elif abs(limit_value - math.cos(2)) < 1e-10:
            #     ax.text(x_left, limit_value, '$\\cos 2$', fontsize=10, 
            #            verticalalignment='center', horizontalalignment='left',
            #            bbox=dict(boxstyle='round,pad=0.2', facecolor='white', alpha=0.9))
        else:
            try:
                # 大きなnでの値を極限値として使用
                n_large = np.arange(100, 1000, 1)
                y_large = func(n_large)
                finite_y = y_large[~np.isnan(y_large) & ~np.isinf(y_large)]
                if finite_y.size > 0:
                    limit_val = np.mean(finite_y[-10:])  # 最後の10個の平均
                    if not np.isnan(limit_val) and not np.isinf(limit_val):
                        ax.axhline(y=limit_val, color='red', linestyle='--', 
                                 alpha=0.7, zorder=1, label='')
            except:
                pass
    
    # タイトル設定
    _set_title_safe(ax, tex, fontsize=14, fallback_fs=12)
    
    # 軸ラベル
    ax.set_xlabel("n")
    ax.set_ylabel("a_n")
    
    # 範囲設定
    ax.set_xlim(n_min, n_max)
    _calc_and_set_ylim(ax, y)
    
    # グリッド
    ax.grid(True, linestyle=":", alpha=DEFAULT_LIMIT_SPEC["grid_alpha"])
    
    # 凡例を表示（ラベルがある場合のみ）
    if blue_label or red_label or comparison_label:
        ax.legend(loc=legend_loc, fontsize=10, framealpha=0.9, edgecolor='black', facecolor='white')
    
    # レイアウト調整
    try:
        fig.tight_layout()
    except Exception:
        fig.subplots_adjust(top=0.88)
    
    # 保存
    try:
        fig.savefig(out_path, dpi=200)
    except Exception:
        try:
            ax.set_title((tex or "").replace("\n", " "), fontsize=10)
            fig.savefig(out_path, dpi=200)
        except Exception:
            plt.close(fig)
            raise
    return fig
