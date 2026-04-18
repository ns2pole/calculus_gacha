// lib/data/ft_ode_all_split_with_ids_v5.dart
// 方針：
// - prime 記法（d/dt は使わない）、引数 (t), (V), (ρ) は省略しない
// - 係数はすべて「」である旨を問題文に明記
// - 一次：積分因子法で初期値を用いて厳密解（当て推量・複素数なし）
// - 二次強制：因果 G 関数（Duhamel）で厳密導出、実関数のみ
// - 途中式は \begin{aligned} と &= で整列、途中計算の省略なし（基礎積分は先頭で完全導出）
//
// 重要：コメント行 // --- ... --- は「物理的な1フレーズ例のみ」。
//       category は「一般/数値 × 一階/二階 × 斉次/非斉次」の数学的分類のみ。


import '../../models/math_problem.dart';

// ======================================================================
// 0) 補助：実関数の積分公式（以後の問題で参照）
// ======================================================================

// --- 実指数×正弦の積分公式 ---
// const auxIntegral = MathProblem(
//   id: "26B96D2C-B75A-41EE-9C07-0E1CBE45D019",
//   no: 0,
//   category: '補助',
//   level: '参考',
//   question: r"""以降で用いる実関数の積分公式（導出を明記）""",
//   answer: r"""\displaystyle 
// \int e^{\alpha t}\cos(\beta t)\,dt=\displaystyle \frac{e^{\alpha t}}{\alpha^2+\beta^2}\big(\alpha\cos(\beta t)+\beta\sin(\beta t)\big),\quad
// \int e^{\alpha t}\sin(\beta t)\,dt=\displaystyle \frac{e^{\alpha t}}{\alpha^2+\beta^2}\big(\alpha\sin(\beta t)-\beta\cos(\beta t)\big)
// """,
//   imageAsset: '',
//   steps: [
//     StepItem(tex: r"""\textbf{分部積分の二重連立（実関数のみで導出）"""}),
//     StepItem(tex: r"""
// \begin{aligned}
// I_1(t)&\equiv \int e^{\alpha t}\cos(\beta t)\,dt,\quad
// I_2(t)\equiv \int e^{\alpha t}\sin(\beta t)\,dt.
// \end{aligned}
// """),
//     StepItem(tex: r"""I_1 の分部積分："""),
//     StepItem(tex: r"""
// \begin{aligned}
// I_1(t)
// &= \displaystyle \frac{e^{\alpha t}}{\beta}\sin(\beta t) - \displaystyle \frac{\alpha}{\beta}\int e^{\alpha t}\sin(\beta t)\,dt \\
// &= \displaystyle \frac{e^{\alpha t}}{\beta}\sin(\beta t) - \displaystyle \frac{\alpha}{\beta}\, I_2(t).
// \end{aligned}
// """),
//     StepItem(tex: r"""I_2 の分部積分："""),
//     StepItem(tex: r"""
// \begin{aligned}
// I_2(t)
// &= -\displaystyle \frac{e^{\alpha t}}{\beta}\cos(\beta t) + \displaystyle \frac{\alpha}{\beta}\int e^{\alpha t}\cos(\beta t)\,dt \\
// &= -\displaystyle \frac{e^{\alpha t}}{\beta}\cos(\beta t) + \displaystyle \frac{\alpha}{\beta}\, I_1(t).
// \end{aligned}
// """),
//     StepItem(tex: r"""I_1 に代入して連立を閉じる："""),
//     StepItem(tex: r"""
// \begin{aligned}
// I_1(t)
// &= \displaystyle \frac{e^{\alpha t}}{\beta}\sin(\beta t) + \displaystyle \frac{\alpha e^{\alpha t}}{\beta^2}\cos(\beta t) - \displaystyle \frac{\alpha^2}{\beta^2}I_1(t), \\
// \left(1+\displaystyle \frac{\alpha^2}{\beta^2}\right)I_1(t)
// &= \displaystyle \frac{e^{\alpha t}}{\beta}\sin(\beta t) + \displaystyle \frac{\alpha e^{\alpha t}}{\beta^2}\cos(\beta t), \\
// I_1(t)
// &= \displaystyle \frac{e^{\alpha t}}{\alpha^2+\beta^2}\big(\alpha\cos(\beta t)+\beta\sin(\beta t)\big).
// \end{aligned}
// """),
//     StepItem(tex: r"""I_2 も同様に得る。以降は\textbf{この公式を参照して評価する。"""),
//   ],
// );

// ======================================================================
// A) 一般（記号）セクション
// ======================================================================
const second_order_no_dampingProblems = <MathProblem>[

  // 注意: 単振動関連の問題（no. 6, 7, 8, 16, 17, 106, 107, 108, 116, 117）
  // は simple_harmonic_motion_problems.dart に移動しました。

];
