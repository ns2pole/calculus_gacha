import '../../models/math_problem.dart';

/// ============================================================================
/// 三角関数の多項式積分 予備問題
/// ============================================================================
/// 
/// このファイルに保存されている問題は、コメントアウトを外すと
/// all_problems.dart の allIntegralProblems リストに追加されます。

/// 予備問題リスト
/// コメントアウトを外すと問題リストに追加されます
const trigPolynomialReserveProblems = <MathProblem>[
  // 10) ∫₀^{2π} sin(mx) sin(nx) dx（フーリエ級数の直交性）
  // コメントアウトを外すと問題が追加されます
  // MathProblem(
  //   id: "3FC3F98E-E3D9-42B7-BD88-95AA0B2A7B17",
  //   no: 10,
  //   category: '積和公式',
  //   level: '初級',
  //   question: r"""\displaystyle \int_0^{2\pi}\sin(2x)\sin(5x)\,dx""",
  //   answer: r"""0""",
  //   imageAsset: 'assets/graphs/integral/problems_trig_polynomial/problem_10.png',
  //   hint: r"""\text{積和公式を用いて、三角関数の1次式に帰着する。}""",
  //   steps: [
  //     StepItem(tex: r"""\textbf{【方針】}"""),
  //     StepItem(tex: r"""\text{積和公式を用いて、三角関数の1次式に帰着する。}"""),
  //     StepItem(tex: r"""\textbf{【解説】}"""),
  //     StepItem(tex: r"""\text{積和公式 } \sin A\sin B = \displaystyle\frac{1}{2}\left(\cos(A-B)-\cos(A+B)\right) \text{ を用いると、}"""),
  //     StepItem(tex: r"""\begin{aligned}
  // \displaystyle &\int_0^{2\pi}\sin(2x)\sin(5x)\,dx\\[5pt]
  // =& \displaystyle\frac{1}{2}\displaystyle \int_0^{2\pi}\left(\cos((2-5)x)-\cos((2+5)x)\right)dx\\[5pt]
  // =& \displaystyle\frac{1}{2}\displaystyle \int_0^{2\pi}\left(\cos(-3x)-\cos(7x)\right)dx\\[5pt]
  // =& \displaystyle\frac{1}{2}\displaystyle \int_0^{2\pi}\left(\cos(3x)-\cos(7x)\right)dx\\[5pt]
  // =& \displaystyle\frac{1}{2}\left[\displaystyle\frac{\sin(3x)}{3}-\displaystyle\frac{\sin(7x)}{7}\right]_0^{2\pi}\\[5pt]
  // =& \displaystyle\frac{1}{2}\left(\displaystyle\frac{1}{3}(\sin(6\pi)-\sin 0)-\displaystyle\frac{1}{7}(\sin(14\pi)-\sin 0)\right)\\[5pt]
  // =& \displaystyle\frac{1}{2}(0-0)\\[5pt]
  // =& 0
  // \end{aligned}"""),
  //     StepItem(tex: r"""\textbf{【補足】}"""),
  //     StepItem(tex: r"""\text{この結果はフーリエ級数という数学に登場し、一般に下記が成立する。}"""),
  //     StepItem(tex: r"""\displaystyle \int_0^{2\pi}\sin(mx)\sin(nx)\,dx = \begin{cases}0 & (m\ne n)\\[4pt]\pi & (m=n)\end{cases}
  // """),
  //   ],
  // ),
];

