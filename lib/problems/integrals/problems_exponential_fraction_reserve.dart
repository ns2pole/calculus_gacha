import '../../models/math_problem.dart';

/// ============================================================================
/// 指数関数の分数式 予備問題
/// ============================================================================
/// 
/// このファイルに保存されている問題は、コメントアウトを外すと
/// all_problems.dart の allIntegralProblems リストに追加されます。

/// 予備問題リスト
/// コメントアウトを外すと問題リストに追加されます
const exponentialFractionReserveProblems = <MathProblem>[
  // No.2 (初級)
  // ∫_0^{log 2} 1 / (1 + e^{-x}) dx
  // コメントアウトを外すと問題が追加されます
  // MathProblem(
  //     id: "9C1AF019-A9BA-4C1A-B3ED-4BA5638B1D07",
  //   no: 2,
  //   category: '指数関数の分数式',
  //   level: '初級',
  //   question: r"""\displaystyle \int_{0}^{\log 2} \displaystyle \frac{1}{1+e^{-x}}\,dx""",
  //   answer: r"""\log\!\left(\displaystyle \frac{3}{2}\right)
  // """,
  //   imageAsset: 'assets/graphs/integral/problems_exponential_fraction/problem_2.png',
  //   hint: r"""\textcolor{red}{被積分関数に} \textcolor{red}{e^x} \textcolor{red}{ を掛けて、} \ \displaystyle \frac{e^x}{1+e^x} \text{ に変形して、置換積分する。}""",
  //   steps: [
  //     StepItem(tex: r"""\textbf{【方針】}"""),
  //     StepItem(tex: r"""\textcolor{red}{被積分関数に} \textcolor{red}{e^x} \textcolor{red}{ を掛けて、} \ \displaystyle \frac{e^x}{1+e^x} \text{ に変形して、置換積分する。．}"""),
  //     StepItem(tex: r"""\textbf{【解説】}"""),
  //     StepItem(tex: r"""\text{まず不定積分を求める。被積分関数を変形すると、}"""),
  //     StepItem(tex: r"""\begin{aligned}
  // \displaystyle \int \displaystyle \frac{1}{1+e^{-x}}\,dx
  // &= \displaystyle \int \displaystyle \frac{e^x}{1+e^x}\,dx
  // \end{aligned}
  // """),
  //     StepItem(tex: r"""\text{ここで、置換 } u=1+e^x,\; du=e^x\,dx \text{ により、}"""),
  //     StepItem(tex: r"""\begin{aligned}
  // \displaystyle \int \displaystyle \frac{e^x}{1+e^x}\,dx
  // &= \displaystyle \int \displaystyle \frac{du}{u}\\
  // &= \log u + C\\
  // &= \log(1+e^x) + C
  // \end{aligned}
  // """),
  //     StepItem(tex: r"""\text{したがって、定積分は、}"""),
  //     StepItem(tex: r"""\begin{aligned}
  // \displaystyle \int_{0}^{\log 2}\displaystyle \frac{1}{1+e^{-x}}\,dx
  // &= \left[\log(1+e^x)\right]_{0}^{\log 2}\\
  // &= \log(1+e^{\log 2}) - \log(1+e^0)\\
  // &= \log(1+2) - \log(1+1)\\
  // &= \log 3 - \log 2\\
  // &= \log\!\left(\displaystyle \frac{3}{2}\right)
  // \end{aligned}
  // """),
  //   ],
  // ),
];

