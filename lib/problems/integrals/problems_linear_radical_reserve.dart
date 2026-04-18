import '../../models/math_problem.dart';

/// ============================================================================
/// 1次の無理式 予備問題
/// ============================================================================
/// 
/// このファイルに保存されている問題は、コメントアウトを外すと
/// all_problems.dart の allIntegralProblems リストに追加されます。

/// 予備問題リスト
/// コメントアウトを外すと問題リストに追加されます
const linearRadicalReserveProblems = <MathProblem>[
  // 問題 1 (初級)
  // ∫₀¹ √(1 + 2x)  dx
  // コメントアウトを外すと問題が追加されます
  // MathProblem(
  //   id: "D2B89DAA-E92F-42BE-84DB-BBBAA97CF300",
  //   no: 1,
  //   category: '1次の無理式',
  //   level: '初級',
  //   question: r"\displaystyle \int_{0}^{1} \sqrt{1+2x}\,dx",
  //   answer:   r"\sqrt{3} - \displaystyle \frac{1}{3}",
  //   imageAsset: 'assets/graphs/integral/problems_linear_radical/problem_1.png',
  //   hint: r"""
  // u=1+2x, \ \ du=2\,dx \ \ dx=\displaystyle \frac{1}{2}\,du \text{と置換する。}
  // """,
  //   steps: [
  //     StepItem(
  //       tex: r"""\textbf{【方針】}"""),
  // StepItem(
  //       tex: r"""
  // u=1+2x, \ \ du=2\,dx \ \ dx=\displaystyle \frac{1}{2}\,du \text{と置換する。}
  // """
  //     ),
  //     StepItem(
  //       tex: r"""\textbf{【計算】}"""),
  // StepItem(
  //       tex: r"""\begin{aligned}
  // \displaystyle \int_{0}^{1} \sqrt{1+2x}\,dx
  // &= \displaystyle \int_{x=0}^{x=1} \sqrt{u}\cdot \displaystyle \frac{1}{2}\,du \\
  // &= \displaystyle \frac{1}{2}\displaystyle \int_{u=1}^{u=3} u^{1/2}\,du \\
  // &= \displaystyle \frac{1}{2}\left[\displaystyle \frac{u^{\frac 3 2}}{\frac 3 2}\right]_{1}^{3} \\
  // &= \displaystyle \frac{1}{2}\left[\displaystyle \frac{2}{3}\,u^{\frac 3 2}\right]_{1}^{3} \\
  // &= \left[\displaystyle \frac{1}{3}\,u^{\frac 3 2}\right]_{1}^{3} \\
  // &= \displaystyle \frac{1}{3}\left(3^{\frac 3 2} - 1^{\frac 3 2}\right) \\
  // &= \displaystyle \frac{1}{3}\left(3\sqrt{3} - 1\right) \\
  // &= \sqrt{3} - \displaystyle \frac{1}{3}
  // \end{aligned}
  // """
  //     ),
  //   ],
  // ),
];

