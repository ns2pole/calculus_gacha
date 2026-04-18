import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// ============================================================================
/// 1次の無理式 (Linear Radicals) ―― 3問
/// ============================================================================

/// 
/// 各問題は以下のように構成されています：
///   1. 【方針】 (Strategy)
///   2. 【ポイント】 (Key Points)
///   3. 【解説】 (Detailed Solution)
///   4. 【補足】 (Notes)
const linearRadicalProblems = <MathProblem>[
  // 予備問題は problems_linear_radical_reserve.dart に移動しました
  // コメントアウトを外すと問題リストに追加されます

  // ------------------------------------------------------------
  // 問題 2 (初級)
  // ∫₀² dx / √(2x + 5)
  // ------------------------------------------------------------
  MathProblem(
    id: "48615294-8E6C-4EFB-B9F9-5A08205FFF69",
    no: 2,
    category: '1次の無理式',
    level: '初級',
    question: r"\displaystyle \int_{0}^{2} \displaystyle \frac{dx}{\sqrt{2x + 5}}",
    answer:   r"3 - \sqrt{5}",
    imageAsset: 'assets/graphs/integral/problems_linear_radical/problem_2.png',
    hint: r"""
u=2x+5, \ \ du=2\,dx \ \ dx=\displaystyle \frac{1}{2}\,du \text{と置換する。}
""",
    steps: [
      StepItem(
        tex: r"""\textbf{【方針】}"""),
      StepItem(
        tex: r"""
u=2x+5, \ \ du=2\,dx \ \ dx=\displaystyle \frac{1}{2}\,du \text{と置換する。}
"""
      ),
      StepItem(
        tex: r"""\textbf{【計算】}"""),
            StepItem(
              tex: r""" \begin{aligned}
      \displaystyle \int_{0}^{2} \displaystyle \frac{dx}{\sqrt{2x+5}}
      &= \displaystyle \int_{x=0}^{x=2} \displaystyle \frac{1}{\sqrt{u}}\cdot \displaystyle \frac{1}{2}\,du \\
      &= \displaystyle \frac{1}{2}\displaystyle \int_{u=5}^{u=9} u^{-1/2}\,du \\
      &= \displaystyle \frac{1}{2}\left[\displaystyle \frac{u^{1/2}}{1/2}\right]_{5}^{9} \\
      &= \displaystyle \frac{1}{2}\left[2\,u^{1/2}\right]_{5}^{9} \\
      &= \left[\sqrt{u}\right]_{5}^{9} \\
      &= \sqrt{9} - \sqrt{5} \\
      &= 3 - \sqrt{5}
      \end{aligned}
      """
      ),
    ],
  ),

  // ------------------------------------------------------------
  // 問題 3 (中級, 定積分)
  // ∫₀^(1/2) √(1 − 2x)  dx
  // ------------------------------------------------------------
  MathProblem(
    id: "383DCCBD-6B56-4171-856E-F14225EC83D8",
    no: 3,
    category: '1次の無理式',
    level: '初級',
    question: r"\displaystyle \int_{0}^{\frac{1}{2}} \sqrt{1 - 2x}\,dx",
    answer:   r"\displaystyle \frac{1}{3}",
    imageAsset: 'assets/graphs/integral/problems_linear_radical/problem_3.png',
    hint: r"""u=1-2x, \ du=-2\,dx, \ dx=-\displaystyle \frac{1}{2}\,du \text{ と置換する。}""",
    steps: [
      StepItem(
        tex: r"""\textbf{【置換】}"""),
      StepItem(
        tex: r"""u=1-2x \text{ を用いて積分区間を変換し、冪関数の定積分として評価する。}"""
      ),
      StepItem(
        tex: r"""\textbf{【計算】}"""),
      StepItem(
        tex: r"""
u=1-2x, \ du=-2\,dx, \ dx=-\displaystyle \frac{1}{2}\,du \text{ より、} x=0 \rightarrow \displaystyle \frac{1}{2} \text{の時、}\ u=1 \rightarrow 0 \text{であるから、}"""),
      StepItem(
        tex: r"""
        \begin{aligned}
\displaystyle \int_{0}^{\frac{1}{2}}\sqrt{1-2x}\,dx
&= \displaystyle \int_{x=0}^{x=\frac{1}{2}}\sqrt{u}\cdot\left(-\displaystyle \frac{1}{2}\,du\right) \\
&= -\displaystyle \frac{1}{2}\displaystyle \int_{u=1}^{u=0} u^{1/2}\,du \\
&= \displaystyle \frac{1}{2}\displaystyle \int_{u=0}^{u=1} u^{1/2}\,du \\
&= \displaystyle \frac{1}{2}\left[\displaystyle \frac{u^{\frac 3 2}}{\frac 3 2}\right]_{0}^{1} \\
&= \displaystyle \frac{1}{2}\left[\displaystyle \frac{2}{3}\,u^{\frac 3 2}\right]_{0}^{1} \\
&= \displaystyle \frac{1}{2}\cdot\displaystyle \frac{2}{3}\cdot 1^{\frac 3 2} - \displaystyle \frac{1}{2}\cdot\displaystyle \frac{2}{3}\cdot 0^{\frac 3 2} \\
&= \displaystyle \frac{1}{3} - 0 \\
&= \displaystyle \frac{1}{3}
\end{aligned}"""),
    ],
  ),
];