#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# graphgenerator_riemann_limits.py
# リーマン和極限問題のグラフ生成

import os
import math
import numpy as np
from limit_common import plot_limit_function, plot_limit_sequence

# リーマン和極限問題の関数定義
def one_over_n_times_sum_of_k_over_n_squared(n):
    """(1/n) Σ(k/n)² の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(1, n + 1, 1)
            return np.sum((k/n)**2) / n
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(1, int(ni) + 1, 1)
                    result[i] = np.sum((k/ni)**2) / ni
            return result

def one_over_n_times_sum_of_k_over_n_cubed(n):
    """(1/n) Σ(k/n)³ の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(1, n + 1, 1)
            return np.sum((k/n)**3) / n
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(1, int(ni) + 1, 1)
                    result[i] = np.sum((k/ni)**3) / ni
            return result

def one_over_n_times_sum_of_sqrt_k_over_n(n):
    """(1/n) Σ√(k/n) の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(1, n + 1, 1)
            return np.sum(np.sqrt(k/n)) / n
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(1, int(ni) + 1, 1)
                    result[i] = np.sum(np.sqrt(k/ni)) / ni
            return result

def one_over_n_times_sum_of_n_over_n_plus_k(n):
    """(1/n) Σ(n/(n+k)) の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(1, n + 1, 1)
            return np.sum(n/(n + k)) / n
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(1, int(ni) + 1, 1)
                    result[i] = np.sum(ni/(ni + k)) / ni
            return result

def one_over_n_times_sum_of_one_over_k_plus_n(n):
    """(1/n) Σ(1/(k+n)) の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(1, n + 1, 1)
            return np.sum(1/(k + n)) / n
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(1, int(ni) + 1, 1)
                    result[i] = np.sum(1/(k + ni)) / ni
            return result

def one_over_n_times_sum_of_sin_pi_k_over_n(n):
    """(1/n) Σ sin(πk/n) の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(1, n + 1, 1)
            return np.sum(np.sin(np.pi * k / n)) / n
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(1, int(ni) + 1, 1)
                    result[i] = np.sum(np.sin(np.pi * k / ni)) / ni
            return result

def one_over_n_times_sum_of_cos_pi_k_over_n(n):
    """(1/n) Σ cos(πk/n) の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(1, n + 1, 1)
            return np.sum(np.cos(np.pi * k / n)) / n
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(1, int(ni) + 1, 1)
                    result[i] = np.sum(np.cos(np.pi * k / ni)) / ni
            return result

def one_over_n_times_sum_of_e_to_the_k_over_n(n):
    """(1/n) Σ e^(k/n) の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(1, n + 1, 1)
            return np.sum(np.exp(k/n)) / n
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(1, int(ni) + 1, 1)
                    result[i] = np.sum(np.exp(k/ni)) / ni
            return result

def one_over_n_times_sum_of_log_k_over_n(n):
    """(1/n) Σ log(k/n) の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(1, n + 1, 1)
            return np.sum(np.log(k/n)) / n
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(1, int(ni) + 1, 1)
                    result[i] = np.sum(np.log(k/ni)) / ni
            return result

def one_over_n_times_sum_of_one_over_one_plus_k_over_n_squared(n):
    """(1/n) Σ(1/(1+(k/n)²)) の数列"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(1, n + 1, 1)
            return np.sum(1/(1 + (k/n)**2)) / n
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(1, int(ni) + 1, 1)
                    result[i] = np.sum(1/(1 + (k/ni)**2)) / ni
            return result

def one_over_n_times_sum_of_sqrt_one_minus_k_over_n_squared(n):
    """(1/n) Σ√(1-(k/n)²) の数列 (k=-n to n)"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(-n, n + 1, 1)  # k=-nからnまで
            return np.sum(np.sqrt(1 - (k/n)**2)) / n
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(-int(ni), int(ni) + 1, 1)  # k=-nからnまで
                    result[i] = np.sum(np.sqrt(1 - (k/ni)**2)) / ni
            return result

def one_over_n_times_sum_of_cos_pi_k_over_n_from_0_to_2n(n):
    """(1/n) Σ cos(πk/n) の数列 (k=0 to 2n)"""
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            k = np.arange(0, 2*n + 1, 1)  # k=0から2nまで
            return np.sum(np.cos(np.pi * k / n)) / n
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    k = np.arange(0, 2*int(ni) + 1, 1)  # k=0から2nまで
                    result[i] = np.sum(np.cos(np.pi * k / ni)) / ni
            return result

def _simpson_integral(func, a, b, n_points=1000):
    """シンプソン法による数値積分"""
    if a >= b:
        return 0.0
    
    x = np.linspace(a, b, n_points)
    y = func(x)
    
    # NaNや無限大を0に置き換え
    y = np.where(np.isfinite(y), y, 0.0)
    
    # シンプソン法の公式
    h = (b - a) / (n_points - 1)
    result = h / 3.0 * (y[0] + y[-1] + 4 * np.sum(y[1:-1:2]) + 2 * np.sum(y[2:-1:2]))
    
    return result if np.isfinite(result) else 0.0

def _adaptive_integral_tan_2n(func, a, b, n_val):
    """適応的積分（π/4付近で細かく分割）"""
    pi_4 = math.pi / 4.0
    
    # nが大きいほど、π/4付近を細かく分割する必要がある
    # 区間を複数に分割して精度を向上
    if n_val <= 5:
        # nが小さい場合は均等分割で十分
        n_points = 3000
        return _simpson_integral(func, a, b, n_points)
    elif n_val <= 15:
        # 中間：最後の20%を細かく
        split = a + 0.8 * (b - a)
        n1 = 2000
        n2 = 5000
        return (_simpson_integral(func, a, split, n1) + 
                _simpson_integral(func, split, b, n2))
    else:
        # nが大きい：最後の10%を非常に細かく
        split1 = a + 0.85 * (b - a)
        split2 = a + 0.95 * (b - a)
        n1 = 3000  # 最初の85%
        n2 = 5000  # 中間の10%
        n3 = 10000  # 最後の5%（π/4付近）- 大幅に増加
        return (_simpson_integral(func, a, split1, n1) + 
                _simpson_integral(func, split1, split2, n2) +
                _simpson_integral(func, split2, b, n3))

def integral_of_tan_to_2n(n):
    """∫₀^(π/4) tan^(2n)(x) dx の数列"""
    def integrand(x, n_val):
        """被積分関数"""
        with np.errstate(all='ignore'):
            tan_x = np.tan(x)
            # tan^(2n)(x) = (tan(x))^(2n)
            # xがπ/4に近いとtan(x)が大きくなるので、適切に処理
            result = tan_x ** (2 * n_val)
            # 無限大やNaNを0に置き換え
            result = np.where(np.isfinite(result), result, 0.0)
            # 値が大きすぎる場合は0に
            result = np.where(result < 1e10, result, 0.0)
            return result
    
    a = 0.0
    b = math.pi / 4.0
    
    with np.errstate(all='ignore'):
        if np.isscalar(n):
            try:
                # 適応的積分を使用
                result = _adaptive_integral_tan_2n(lambda x: integrand(x, n), a, b, n)
                return result if np.isfinite(result) else 0.0
            except:
                return 0.0
        else:
            result = np.zeros_like(n, dtype=float)
            for i, ni in enumerate(n):
                if ni > 0:
                    try:
                        val = _adaptive_integral_tan_2n(lambda x: integrand(x, ni), a, b, ni)
                        result[i] = val if np.isfinite(val) else 0.0
                    except:
                        result[i] = 0.0
            return result

# 問題定義（riemann_limits.dartの3問に合わせる）
PROBLEMS = [
    {
        "question": r"""\displaystyle \lim_{n\to\infty}\frac{1}{n}\displaystyle \sum_{k=-n}^{n}\sqrt{1-\left(\frac{k}{n}\right)^{2}}""",
        "func": one_over_n_times_sum_of_sqrt_one_minus_k_over_n_squared,
        "filename": "problem_1.png",
        "n_min": 1,
        "n_max": 50,
        "limit_value": math.pi/2,  # ∫₋₁¹ √(1-x²) dx = π/2
        "is_sequence": True,
        "blue_label": r"$\frac{1}{n}\displaystyle \sum_{k=-n}^{n}\sqrt{1-\left(\frac{k}{n}\right)^{2}}$",
        "red_label": r"$\frac{\pi}{2} \fallingdotseq 1.571$",
        "legend_loc": "lower right"
    },
    {
        "question": r"""\displaystyle \lim_{n \to \infty} \frac{1}{n} \displaystyle \sum_{k=1}^{n} \frac{n}{n+k}""",
        "func": one_over_n_times_sum_of_n_over_n_plus_k,
        "filename": "problem_2.png",
        "n_min": 1,
        "n_max": 50,
        "limit_value": math.log(2),  # ∫₀¹ 1/(1+x) dx = log 2
        "is_sequence": True,
        "blue_label": r"$\frac{1}{n}\displaystyle \sum_{k=1}^{n}\frac{n}{n+k}$",
        "red_label": r"$\log 2 \fallingdotseq 0.693$",
        "legend_loc": "lower right"
    },
    {
        "question": r"""\displaystyle \lim_{n \to \infty} \frac{1}{n} \displaystyle \sum_{k=1}^{n} \frac{1}{n+k}""",
        "func": one_over_n_times_sum_of_one_over_k_plus_n,
        "filename": "problem_3.png",
        "n_min": 1,
        "n_max": 50,
        "limit_value": 0,  # 極限値は0
        "is_sequence": True,
        "blue_label": r"$\frac{1}{n}\displaystyle \sum_{k=1}^{n}\frac{1}{n+k}$",
        "red_label": "0"
    },
    {
        "question": r"""\displaystyle \lim_{n\to\infty}\frac{1}{n}\displaystyle \sum_{k=0}^{2n}\cos\!\left(\frac{\pi k}{n}\right)""",
        "func": one_over_n_times_sum_of_cos_pi_k_over_n_from_0_to_2n,
        "filename": "problem_4.png",
        "n_min": 1,
        "n_max": 50,
        "limit_value": 0,  # 極限値は0
        "is_sequence": True,
        "blue_label": r"$\frac{1}{n}\displaystyle \sum_{k=0}^{2n}\cos\left(\frac{\pi k}{n}\right)$",
        "red_label": "0"
    },
    {
        "question": r"""\displaystyle \lim_{n\to\infty}\int_{0}^{\frac{\pi}{4}}\tan^{2n}x\,dx""",
        "func": integral_of_tan_to_2n,
        "filename": "problem_5.png",
        "n_min": 1,
        "n_max": 30,
        "limit_value": 0,  # 極限値は0
        "is_sequence": True,
        "blue_label": r"$\int_{0}^{\frac{\pi}{4}}\tan^{2n}x\,dx$",
        "red_label": "0",
        "legend_loc": "upper right"
    }
]

def main():
    """メイン実行関数"""
    # 出力ディレクトリを作成
    output_dir = "../../../assets/graphs/limit/problems_riemann_limits"
    os.makedirs(output_dir, exist_ok=True)
    
    print("リーマン和極限問題のグラフを生成中...")
    
    for i, problem in enumerate(PROBLEMS, 1):
        print(f"問題 {i}: {problem['filename']}")
        
        out_path = os.path.join(output_dir, problem['filename'])
        
        if problem.get('is_sequence', False):
            # 数列の極限問題
            plot_limit_sequence(
                func=problem['func'],
                tex=problem['question'],
                out_path=out_path,
                n_min=problem['n_min'],
                n_max=problem['n_max'],
                show_limit_value=True,
                limit_value=problem.get('limit_value'),
                blue_label=problem.get('blue_label'),
                red_label=problem.get('red_label'),
                legend_loc=problem.get('legend_loc')
            )
        else:
            # 関数の極限問題
            plot_limit_function(
                func=problem['func'],
                tex=problem['question'],
                out_path=out_path,
                x_min=problem['x_min'],
                x_max=problem['x_max'],
                limit_point=problem['limit_point'],
                limit_value=problem['limit_value'],
                blue_label=problem.get('blue_label'),
                red_label=problem.get('red_label')
            )
    
    print(f"完了！{len(PROBLEMS)}個のグラフを生成しました。")
    print(f"出力先: {output_dir}")

if __name__ == "__main__":
    main()
