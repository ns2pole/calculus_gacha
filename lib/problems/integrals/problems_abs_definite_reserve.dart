import '../../models/math_problem.dart';

/// ============================================================================
/// 絶対値付きの定積分 予備問題
/// ============================================================================
/// 
/// このファイルに保存されている問題は、コメントアウトを外すと
/// all_problems.dart の allIntegralProblems リストに追加されます。

/// 予備問題リスト
/// コメントアウトを外すと問題リストに追加されます
const absDefiniteReserveProblems = <MathProblem>[
  /// No.1 初級 | ∫_{-2}^{3} |x| dx
  // コメントアウトを外すと問題が追加されます
  // MathProblem(
  //   id: "9CB65E9A-BFF7-4C9F-B331-B55CFA7448A1",
  //   no: 1,
  //   category: '絶対値付きの定積分',
  //   level: '初級',
  //   question: r"""\displaystyle \int_{-2}^{3} |x| \, dx""",
  //   answer: r"""\displaystyle \frac{13}{2}""",
  //   imageAsset: 'assets/graphs/integral/problems_abs_definite/problem_1.png',
  //   hint: r""" \left|x\right| \text{の分岐定義により，区間を }[-2,0]\text{と}[0,3]\text{に分割して計算する。}""",
  //   steps: [
  //     StepItem(
  //       tex: r"""\textbf{【方針】}""",
  //     ),
  //     StepItem(
  //       tex: r""" \left|x\right| \text{の分岐定義により，区間を }[-2,0]\text{と}[0,3]\text{に分割して計算する。}""",
  //     ),
  //     StepItem(
  //       tex: r"""\textbf{【ポイント】}""",
  //     ),
  //     StepItem(
  //       tex: r"""\text{絶対値の基本分岐}
  // \begin{aligned}
  // |x|=\begin{cases}-x&(x<0)\\ x&(x\ge 0)
  // \end{cases}
  // \end{aligned}""",
  //     ),
  //     StepItem(
  //       tex: r"""\text{それぞれの区間で原始関数をとり，計算する。}""",
  //     ),
  //     StepItem(
  //       tex: r"""\textbf{【解説】}""",
  //     ),
  //     StepItem(
  //       tex: r"""\begin{aligned}
  // \displaystyle \int_{-2}^{3}|x|\,dx
  // &= \displaystyle \int_{-2}^{0}(-x)\,dx + \displaystyle \int_{0}^{3}x\,dx \\
  // &= \left[-\displaystyle \frac{x^2}{2}\right]_{-2}^{0} + \left[\displaystyle \frac{x^2}{2}\right]_{0}^{3} \\
  // &= \left(-\displaystyle \frac{0^2}{2}\right) - \left(-\displaystyle \frac{(-2)^2}{2}\right) + \left(\displaystyle \frac{3^2}{2}\right) - \left(\displaystyle \frac{0^2}{2}\right) \\
  // &= 0 - \left(-\displaystyle \frac{4}{2}\right) + \displaystyle \frac{9}{2} - 0 \\
  // &= \displaystyle \frac{4}{2} + \displaystyle \frac{9}{2} \\
  // &= \displaystyle \frac{13}{2}
  // \end{aligned}
  // """,
  //     ),
  //   ],
  // ),

  /// No.2 初級 | ∫_{0}^{2π} |sin x| dx
  // コメントアウトを外すと問題が追加されます
  // MathProblem(
  //   id: "3CFA230C-2B50-4EE9-BE1B-46A6505BC279",
  //   no: 2,
  //   category: '絶対値付きの定積分',
  //   level: '初級',
  //   question: r"""\displaystyle \int_{0}^{2\pi} |\sin x| \, dx""",
  //   answer: r"""\displaystyle 4""",
  //   imageAsset: 'assets/graphs/integral/problems_abs_definite/problem_2.png',
  //   hint: r"""\text{ }\sin x\text{ の符号が }[0,\pi]\text{ で非負，}[\pi,2\pi]\text{ で非正であることを用いて区間分割する。}""",
  //   steps: [
  //     StepItem(
  //       tex: r"""\textbf{【方針】}""",
  //     ),
  //     StepItem(
  //       tex: r"""\text{ }\sin x\text{ の符号が }[0,\pi]\text{ で非負，}[\pi,2\pi]\text{ で非正であることを用いて区間分割する。}""",
  //     ),
  //     StepItem(
  //       tex: r"""\textbf{【ポイント】}""",
  //     ),
  //     StepItem(
  //       tex: r"""\begin{aligned}
  // |\sin x|=\begin{cases}\sin x&(0\le x\le \pi)\\ -\sin x&(\pi\le x\le 2\pi)\end{cases}
  // \end{aligned}""",
  //     ),
  //     StepItem(
  //       tex: r"""\text{対称性より }\displaystyle \int_{0}^{2\pi}|\sin x|\,dx=2\displaystyle \int_{0}^{\pi}\sin x\,dx \text{ と簡約できる。}""",
  //     ),
  //     StepItem(
  //       tex: r"""\textbf{【解説】}""",
  //     ),
  //     StepItem(
  //       tex: r"""\begin{aligned}
  // \displaystyle \int_{0}^{2\pi}|\sin x|\,dx
  // &= \displaystyle \int_{0}^{\pi}\sin x\,dx + \displaystyle \int_{\pi}^{2\pi}(-\sin x)\,dx \\
  // &= 2\displaystyle \int_{0}^{\pi}\sin x\,dx \\
  // &= 2\left[-\cos x\right]_{0}^{\pi} \\
  // &= 2\left( -\cos(\pi) - \left(-\cos(0)\right) \right) \\
  // &= 2\left( -(-1) - (-1) \right) \\
  // &= 2\left( 1 + 1 \right) \\
  // &= 4
  // \end{aligned}
  // """,
  //     ),
  //   ],
  // ),
];

