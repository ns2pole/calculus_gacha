import math
import numpy as np
import matplotlib as mpl
mpl.use("Agg")
import matplotlib.pyplot as plt
import re

N_PLOT = 500  # 共通で使用

# 全公開関数で共通に使う fill_spec
DEFAULT_FILL_SPEC = {
    "pos_color": "#FFEB3B",
    "neg_color": "#00bfff",
    "pos_alpha": 0.45,
    "neg_alpha": 0.45,
    "pos_condition": ">=",
    "neg_condition": "<="
}


def sanitize_tex_for_mathtext(tex: str) -> str:
    r"""
    matplotlib.mathtext に渡す前に TeX をできるだけ安全な形に正規化する。
    - \left, \right, \bigl 等、mathtext が理解しない修飾子を削除
    - \frac12 のような中カッコ無し表記を \frac{1}{2} に正規化
    - 不要な TeX 空白コマンドを除去
    - それでも無理な場合は最終的にフォールバック処理でプレーンテキストにする
    """
    if not tex:
        return ""

    # 入力を str として扱い、まずは行末・不要文字を整理
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

    # mathtext が苦手または未サポートのコマンドを除去（括弧は残す）
    s = re.sub(r"\\(?:left|right)\s*", "", s)  # \left \right
    s = re.sub(r"\\(?:bigl|bigr|biggl|biggr|Bigl|Bigr|Biggl|Biggr|big|Big)\s*", "", s)

    # \bigl や \left などをさらに念のため削る
    s = re.sub(r"\\(?:left|right|bigl|bigr|biggl|biggr|Bigl|Bigr|BigGL|BigGR)\b", "", s)

    # \frac の諸表記を \frac{num}{den} に統一する
    # 1) 正しい形式はそのまま（余白をトリム）
    s = re.sub(r"\\frac\s*\{\s*([^}]+?)\s*\}\s*\{\s*([^}]+?)\s*\}", r"\\frac{\1}{\2}", s)
    # 2) a/b style: \frac 1/2
    s = re.sub(r"\\frac\s*([0-9]+)\s*/\s*([0-9]+)", r"\\frac{\1}{\2}", s)
    # 3) contiguous like \frac12 -> \frac{1}{2}
    s = re.sub(r"\\frac([0-9]+)([0-9]+)", r"\\frac{\1}{\2}", s)
    # 4) spaced tokens: \frac 1 2 -> \frac{1}{2}
    s = re.sub(r"\\frac\s+([^\s\{\}]+)\s+([^\s\{\}]+)", r"\\frac{\1}{\2}", s)

    # \displaystyle は取り除く（mathtext は独自扱いする）
    s = s.replace(r"\displaystyle", "")

    # 小さな TeX 残骸を整理
    s = s.replace("\\\\", "\\")  # 重複バックスラッシュを潰す
    s = re.sub(r"\s+", " ", s).strip()
    
    # 空の括弧や不正な構文をチェック
    if not s or s.isspace():
        return ""
    
    # 基本的な構文チェック
    if s.count('{') != s.count('}'):
        # 括弧の不整合がある場合は安全な形に変換
        s = re.sub(r'\{[^}]*$', '', s)  # 閉じていない括弧を削除
        s = re.sub(r'^[^{]*\}', '', s)  # 開いていない括弧を削除
    
    return s


# -------------------------
# 共通ヘルパ
# -------------------------

def _apply_user_xlim(xmin, xmax, x_min_computed, x_max_computed):
    """
    ユーザーが xmin/xmax を指定した場合に既定値を上書きして返す。
    xmin/xmax が None の場合は既定値をそのまま返す。
    また xmin >= xmax の時は自動で入れ替える。
    """
    if xmin is None and xmax is None:
        return x_min_computed, x_max_computed
    new_min = x_min_computed if xmin is None else float(xmin)
    new_max = x_max_computed if xmax is None else float(xmax)
    if new_min >= new_max:
        new_min, new_max = new_max, new_min
    return new_min, new_max


def _compute_b_and_limits(a, b, improper=False, trunc_b=None, use_abs_width=False, beta_style=False):
    if beta_style:
        width = (b - a) if (b is not None and a is not None) else 1.0
        if width == 0:
            x_min = a - 1.0
            x_max = b + 1.0
        else:
            x_min = a - width * 0.66
            x_max = b + width * 0.66
        b_effective = b
        return b_effective, x_min, x_max

    if improper:
        if trunc_b is None:
            trunc_b = 8.0 if (b is None or (isinstance(b, (int, float)) and math.isinf(b))) else b
        b_effective = trunc_b
        width = b_effective - a
    else:
        b_effective = b
        width = (b - a) if (b is not None and a is not None) else 1.0

    width_for_pad = abs(width) if use_abs_width else width
    pad = (2.0 / 3.0) * width_for_pad if width_for_pad != 0 else 1.0
    x_min = (a - pad) if (a is not None) else -pad
    x_max = (b_effective + pad) if (b_effective is not None) else pad
    return b_effective, x_min, x_max


def _eval_func_on_array(func, x, params=None, params_as_pos=False):
    if params is None:
        return func(x)
    if params_as_pos:
        return func(x, params)
    if isinstance(params, dict):
        return func(x, **params)
    try:
        return func(x, **params)
    except Exception:
        return func(x, params)


def _compute_xy(func, a, b_effective, x_min, x_max, params=None, params_as_pos=False):
    x = np.linspace(x_min, x_max, N_PLOT)
    with np.errstate(all="ignore"):
        y = _eval_func_on_array(func, x, params=params, params_as_pos=params_as_pos)
    x_fill = np.linspace(a, b_effective, N_PLOT)
    with np.errstate(all="ignore"):
        y_fill = _eval_func_on_array(func, x_fill, params=params, params_as_pos=params_as_pos)
    return x, y, x_fill, y_fill


def _set_title_safe(ax, tex, fontsize, fallback_fs):
    safe_tex = sanitize_tex_for_mathtext(tex or "")
    try:
        # より安全なタイトル設定
        if safe_tex.strip():
            ax.set_title(rf"${safe_tex}$", fontsize=fontsize)
        else:
            ax.set_title("Integral", fontsize=fallback_fs)
    except Exception:
        # mathtext に失敗したらプレーンテキストで再設定（改行削除）
        clean_tex = (tex or "").replace("\n", " ").replace("\\", "").strip()
        if clean_tex:
            ax.set_title(clean_tex, fontsize=fallback_fs)
        else:
            ax.set_title("Integral", fontsize=fallback_fs)


def _calc_and_set_ylim(ax, y, y_fill=None):
    finite_y = y[~np.isnan(y) & ~np.isinf(y)]
    if finite_y.size == 0 and y_fill is not None:
        finite_y = y_fill[~np.isnan(y_fill) & ~np.isinf(y_fill)]
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
    # 重要な値（e, e^2など）がある場合は特別に余裕を増やす
    margin_factor = 0.05  # デフォルトの余裕
    if (abs(y_max - math.e) < 1e-10 or abs(y_min - math.e) < 1e-10 or
        abs(y_max - math.e**2) < 1e-10 or abs(y_min - math.e**2) < 1e-10 or
        abs(y_max - math.e**3) < 1e-10 or abs(y_min - math.e**3) < 1e-10 or
        abs(y_max - math.e**(-1)) < 1e-10 or abs(y_min - math.e**(-1)) < 1e-10 or
        abs(y_max - math.pi/4) < 1e-10 or abs(y_min - math.pi/4) < 1e-10 or
        abs(y_max - math.log(2)) < 1e-10 or abs(y_min - math.log(2)) < 1e-10):
        margin_factor = 0.15  # 重要な値の場合は15%の余裕を追加
    ax.set_ylim(y_min - margin_factor * y_range, y_max + margin_factor * y_range)


def _finalize_and_save(fig, ax, x, y, x_fill, y_fill, a, b_eff, tex,
                       out_path, figsize=(8, 4.8),
                       fill_spec=None, plot_zorder=2,
                       fill_always=False, fill_when=None,
                       draw_vertical_lines=True, skip_ylim=False):
    ax.plot(x, y, lw=2, zorder=plot_zorder)
    ax.axhline(0.0, color="black", lw=1)

    # use provided fill_spec or fallback to DEFAULT_FILL_SPEC
    fs = fill_spec if fill_spec is not None else DEFAULT_FILL_SPEC

    if x_fill is not None and y_fill is not None and (fill_always or (fill_when is None) or fill_when):
        pos_cond = fs.get("pos_condition", ">=")
        neg_cond = fs.get("neg_condition", "<=")
        if pos_cond == ">=":
            mask_pos = (~np.isnan(y_fill)) & (y_fill >= 0.0)
        else:
            mask_pos = (~np.isnan(y_fill)) & (y_fill > 0.0)
        if neg_cond == "<=":
            mask_neg = (~np.isnan(y_fill)) & (y_fill <= 0.0)
        else:
            mask_neg = (~np.isnan(y_fill)) & (y_fill < 0.0)

        if fs.get("pos_color") is not None:
            ax.fill_between(x_fill, 0.0, y_fill, where=mask_pos,
                            color=fs.get("pos_color"), alpha=fs.get("pos_alpha", 0.35),
                            interpolate=True, zorder=fs.get("pos_zorder", 1))
        if fs.get("neg_color") is not None:
            ax.fill_between(x_fill, 0.0, y_fill, where=mask_neg,
                            color=fs.get("neg_color"), alpha=fs.get("neg_alpha", 0.35),
                            interpolate=True, zorder=fs.get("neg_zorder", 1))

    # 定積分の場合のみ縦の点線を描画
    if draw_vertical_lines and a is not None and b_eff is not None:
        ax.axvline(a, color="#888888", lw=1.5, linestyle="--")
        ax.axvline(b_eff, color="#888888", lw=1.5, linestyle="--")

    ax.set_xlabel("x")
    ax.set_ylabel("y")

    if not skip_ylim:
        _calc_and_set_ylim(ax, y, y_fill=y_fill)

    ax.set_xlim(min(x), max(x))
    ax.grid(True, linestyle=":", alpha=0.6)

    # 積分範囲がeからe^2の場合、x軸にeとe^2の目盛りを追加
    if a is not None and b_eff is not None:
        e_val = math.e
        e2_val = math.e ** 2
        # aとbがeとe^2に近い場合（誤差0.01以内）
        if (abs(a - e_val) < 0.01 and abs(b_eff - e2_val) < 0.01) or \
           (abs(a - e2_val) < 0.01 and abs(b_eff - e_val) < 0.01):
            # 既存のx軸目盛りを取得
            x_ticks = list(ax.get_xticks())
            # eとe^2を目盛りに追加（まだ含まれていない場合）
            if not any(abs(tick - e_val) < 0.01 for tick in x_ticks):
                x_ticks.append(e_val)
            if not any(abs(tick - e2_val) < 0.01 for tick in x_ticks):
                x_ticks.append(e2_val)
            x_ticks.sort()
            ax.set_xticks(x_ticks)
            
            # 目盛りラベルのカスタマイズ（eとe^2を特別に表示）
            x_labels = []
            for tick in x_ticks:
                if abs(tick - e_val) < 0.01:
                    x_labels.append('$e$')
                elif abs(tick - e2_val) < 0.01:
                    x_labels.append('$e^2$')
                else:
                    # 整数の場合は整数表示、それ以外は小数点1桁
                    if abs(tick - round(tick)) < 0.01:
                        x_labels.append(f'${int(round(tick))}$')
                    else:
                        x_labels.append(f'${tick:.1f}$')
            ax.set_xticklabels(x_labels)

    try:
        fig.tight_layout()
    except Exception:
        fig.subplots_adjust(top=0.88)

    # save with fallback: mathtext の描画エラーが出たらタイトルをプレーンテキストにして再保存
    try:
        fig.savefig(out_path, dpi=200)
    except Exception:
        try:
            ax.set_title((tex or "").replace("\n", " "), fontsize=10)
            fig.savefig(out_path, dpi=200)
        except Exception:
            plt.close(fig)
            raise
    plt.close(fig)


# -------------------------
# 公開関数（元挙動を維持、ただし共通 fill_spec を使用）
# 各関数にオプションで xmin, xmax を追加（デフォルト None）
# -------------------------

def plot_integral_area(func, a, b, tex, out_path, is_indef=False, xmin: float | None = None, xmax: float | None = None):
    b_eff, x_min, x_max = _compute_b_and_limits(a, b, improper=False, trunc_b=None, use_abs_width=True)
    x_min, x_max = _apply_user_xlim(xmin, xmax, x_min, x_max)
    x, y, x_fill, y_fill = _compute_xy(func, a, b_eff, x_min, x_max)

    fig, ax = plt.subplots(figsize=(9, 5))
    _set_title_safe(ax, tex, fontsize=13, fallback_fs=11)
    _finalize_and_save(fig, ax, x, y, x_fill, y_fill, a, b_eff, tex,
                       out_path, figsize=(9, 5),
                       fill_spec=DEFAULT_FILL_SPEC,
                       plot_zorder=3,
                       fill_always=False,
                       fill_when=(not is_indef),
                       draw_vertical_lines=(not is_indef))


def plot_integral_area2(func, a, b, tex, out_path, improper=False, trunc_b=None, xmin: float | None = None, xmax: float | None = None):
    if not improper:
        b_eff, x_min, x_max = _compute_b_and_limits(a, b, improper=False, trunc_b=None)
    else:
        b_eff, x_min, x_max = _compute_b_and_limits(a, b, improper=True, trunc_b=trunc_b)

    x_min, x_max = _apply_user_xlim(xmin, xmax, x_min, x_max)
    x, y, x_fill, y_fill = _compute_xy(func, a, b_eff, x_min, x_max)

    fig, ax = plt.subplots(figsize=(8, 4.8))
    # raw 文字列でエスケープ警告を回避
    has_limits = (r"\displaystyle \int_" in (tex or ""))
    do_fill = has_limits and (not improper) and (not np.isinf(a)) and (not np.isinf(b))
    draw_lines = has_limits and (not improper) and (not np.isinf(a)) and (not np.isinf(b))
    _set_title_safe(ax, tex, fontsize=14, fallback_fs=12)
    _finalize_and_save(fig, ax, x, y, x_fill, y_fill, a, b_eff, tex,
                       out_path, figsize=(8, 4.8),
                       fill_spec=DEFAULT_FILL_SPEC,
                       plot_zorder=2,
                       fill_always=False,
                       fill_when=do_fill,
                       draw_vertical_lines=draw_lines)


def plot_integral_area_for_quad(func, a, b, tex, out_path, params=None, improper=False, trunc_b=None, xmin: float | None = None, xmax: float | None = None):
    if improper:
        if trunc_b is None:
            trunc_b = b if b is not None and not math.isinf(b) else (a + 8.0)
        b_effective = trunc_b
        width = b_effective - a
    else:
        b_effective = b
        width = b - a

    pad = (2.0 / 3.0) * width if width != 0 else 1.0
    x_min = a - pad
    x_max = b_effective + pad

    x_min, x_max = _apply_user_xlim(xmin, xmax, x_min, x_max)

    x, y, x_fill, y_fill = _compute_xy(func, a, b_effective, x_min, x_max, params=params, params_as_pos=False)

    fig, ax = plt.subplots(figsize=(8, 4.8))
    tex_str = tex or ""
    has_limits = (r"\displaystyle \int_" in tex_str) and ("^" in tex_str)
    is_indef_local = (not has_limits) or improper or (
        (a is None) or (b is None) or
        (isinstance(a, (int, float)) and math.isinf(a)) or
        (isinstance(b, (int, float)) and math.isinf(b))
    )
    _set_title_safe(ax, tex, fontsize=12, fallback_fs=10)
    _finalize_and_save(fig, ax, x, y, x_fill, y_fill, a, b_effective, tex,
                       out_path, figsize=(8, 4.8),
                       fill_spec=DEFAULT_FILL_SPEC,
                       plot_zorder=2,
                       fill_always=False,
                       fill_when=(not is_indef_local),
                       draw_vertical_lines=(not is_indef_local))


def plot_integral_area_lin(func, a, b, tex, out_path, params=None, improper=False, trunc_b=None, is_indef=False, xmin: float | None = None, xmax: float | None = None):
    if improper:
        if trunc_b is None:
            trunc_b = b if b is not None and not math.isinf(b) else (a + 8.0)
        b_effective = trunc_b
    else:
        b_effective = b

    pad = (2.0 / 3.0) * (b_effective - a) if (b_effective - a) != 0 else 1.0
    x_min = a - pad
    x_max = b_effective + pad

    x_min, x_max = _apply_user_xlim(xmin, xmax, x_min, x_max)

    x, y, x_fill, y_fill = _compute_xy(func, a, b_effective, x_min, x_max, params=params, params_as_pos=False)

    fig, ax = plt.subplots(figsize=(8, 4.8))
    do_fill = not (is_indef or improper or (math.isinf(a) or math.isinf(b)))
    draw_lines = not (is_indef or improper or (math.isinf(a) or math.isinf(b)))
    _set_title_safe(ax, tex, fontsize=14, fallback_fs=12)
    _finalize_and_save(fig, ax, x, y, x_fill, y_fill, a, b_effective, tex,
                       out_path, figsize=(8, 4.8),
                       fill_spec=DEFAULT_FILL_SPEC,
                       plot_zorder=2,
                       fill_always=False,
                       fill_when=do_fill,
                       draw_vertical_lines=draw_lines)


def plot_integral_area_sub(func, a, b, tex, out_path, params=None, improper=False, xmin: float | None = None, xmax: float | None = None):
    b_eff, x_min, x_max = _compute_b_and_limits(a, b, improper=improper, trunc_b=None)
    x_min, x_max = _apply_user_xlim(xmin, xmax, x_min, x_max)
    x, y, x_fill, y_fill = _compute_xy(func, a, b_eff, x_min, x_max, params=params, params_as_pos=False)

    fig, ax = plt.subplots(figsize=(8, 4.8))
    # raw 文字列でチェック（正規表現を使わない単純チェック）
    has_limits = (r"\displaystyle \int_{" in (tex or ""))
    is_indef_local = (not has_limits) or improper

    _set_title_safe(ax, tex, fontsize=12, fallback_fs=10)
    _finalize_and_save(fig, ax, x, y, x_fill, y_fill, a, b_eff, tex,
                       out_path, figsize=(8, 4.8),
                       fill_spec=DEFAULT_FILL_SPEC,
                       plot_zorder=2,
                       fill_always=False,
                       fill_when=(not is_indef_local),
                       draw_vertical_lines=(not is_indef_local))


def plot_integral_area_beta(func, a, b, tex, out_path, params=None, is_indef=False, xmin: float | None = None, xmax: float | None = None, figsize=None, ymin: float | None = None, ymax: float | None = None):
    b_eff, x_min, x_max = _compute_b_and_limits(a, b, improper=False, trunc_b=None, beta_style=True)
    x_min, x_max = _apply_user_xlim(xmin, xmax, x_min, x_max)
    x, y, x_fill, y_fill = _compute_xy(func, a, b_eff, x_min, x_max, params=params, params_as_pos=True)

    if figsize is None:
        figsize = (8, 4.8)
    fig, ax = plt.subplots(figsize=figsize)
    _set_title_safe(ax, tex, fontsize=12, fallback_fs=10)
    
    # y軸の範囲を設定（ユーザー指定がある場合はそれを使用）
    if ymin is not None or ymax is not None:
        y_min = ymin if ymin is not None else float(np.min(y[~np.isnan(y) & ~np.isinf(y)]))
        y_max = ymax if ymax is not None else float(np.max(y[~np.isnan(y) & ~np.isinf(y)]))
        ax.set_ylim(y_min, y_max)
    else:
        _calc_and_set_ylim(ax, y, y_fill=y_fill)
    
    _finalize_and_save(fig, ax, x, y, x_fill, y_fill, a, b_eff, tex,
                       out_path, figsize=figsize,
                       fill_spec=DEFAULT_FILL_SPEC,
                       plot_zorder=2,
                       fill_always=False,
                       fill_when=(not is_indef and y_fill is not None),
                       draw_vertical_lines=(not is_indef),
                       skip_ylim=True)  # y軸の設定をスキップ


def plot_integral_area_other(func, a, b, tex, out_path, params=None, improper=False, trunc_b=None, xmin: float | None = None, xmax: float | None = None):
    is_improper_or_indef = (
        improper
        or (a is None) or (b is None)
        or ((a is not None) and math.isinf(a))
        or ((b is not None) and math.isinf(b))
    )

    if is_improper_or_indef:
        if trunc_b is None:
            trunc_b = b if (b is not None and not math.isinf(b)) else (a + 8.0)
        b_effective = trunc_b
    else:
        b_effective = b

    pad = (2.0 / 3.0) * (b_effective - a) if (b_effective - a) != 0 else 1.0
    x_min = a - pad
    x_max = b_effective + pad

    x_min, x_max = _apply_user_xlim(xmin, xmax, x_min, x_max)

    x, y, x_fill, y_fill = _compute_xy(func, a, b_effective, x_min, x_max, params=params, params_as_pos=False)

    fig, ax = plt.subplots(figsize=(8, 4.8))
    _set_title_safe(ax, tex, fontsize=12, fallback_fs=10)
    _finalize_and_save(fig, ax, x, y, x_fill, y_fill, a, b_effective, tex,
                       out_path, figsize=(8, 4.8),
                       fill_spec=DEFAULT_FILL_SPEC,
                       plot_zorder=2,
                       fill_always=False,
                       fill_when=(not is_improper_or_indef),
                       draw_vertical_lines=(not is_improper_or_indef))
