// trigonometric_limits.dart
// 三角関数極限問題集（5問）


import '../../models/math_problem.dart';
import '../../models/step_item.dart';

const log_limits = <MathProblem>[
  MathProblem(
    id: "C9E8A1B2-4D7F-4A91-9F5C-2B6E3A1D8C77",
    no: 1,
    category: 'P系の極限',
    level: '中級',
    question: r"""\displaystyle \lim_{n\to\infty}\frac{1}{n}\sqrt[n]{{}_{2n}P_n}""",
    answer: r"""\displaystyle \frac{4}{e}""",
    imageAsset: 'assets/graphs/limit/problems_permutation/problem_1.png',
    hint: r"""\text{まず }\log\text{ を取り，積を和に直して平均 }\to\text{ 積分 } \int_1^2\log x\,dx\text{ を用いる}""",
    steps: [

      StepItem(tex: r"""\textbf{【流れ】}"""),
      StepItem(tex: r"""\text{(1) }{}_ {2n}P_n=(2n)(2n-1)\cdots(n+1)\text{ を用いて }\log\text{ を取る。}"""),
      StepItem(tex: r"""\text{(2)}\log \text{で変形した和の表式が区分求積の形になる。}"""),
      StepItem(tex: r"""\text{(3)}\log \text{を指数関数で元に戻す。}"""),

      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\text{まず順列を積の形で表すと}"""),

      StepItem(tex: r"""\begin{aligned}
  &\log\!\left(\frac{1}{n}\sqrt[n]{{}_{2n}P_n}\right)\\[6pt]
  &=\log\!\left(\frac{1}{n}\sqrt[n]{(n+1)(n+2)\cdots (2n-1)(2n)}\right)\\[6pt]
  &=\frac1n\displaystyle \sum_{k=n+1}^{2n}\log k-\log n
  \end{aligned}"""),
      StepItem(tex: r"""\text{ここで }\displaystyle \log k=\log n+\log\frac{k}{n}\text{ を用いると}"""),
      StepItem(tex: r"""\begin{aligned}
  &\ \ \ \ \ \frac 1 n \displaystyle \sum_{k=n+1}^{2n}\log k\\[5pt]
  &=\frac 1 n ( \displaystyle \sum_{k=n+1}^{2n} (\log n+ \log\frac{k}{n} ))\\[5pt]
  &=\frac 1 n n (\log n +\frac1n \displaystyle \sum_{k=n+1}^{2n}\log\frac{k}{n}\\[5pt]
  &=\log n+\frac1n\displaystyle \sum_{k=n+1}^{2n}\log\frac{k}{n}
  \end{aligned}"""),

      StepItem(tex: r"""\text{したがって}"""),
      StepItem(tex: r"""\begin{aligned}
  \log\!\left(\frac{1}{n}\sqrt[n]{{}_{2n}P_n}\right)
  =\frac1n\displaystyle \sum_{k=n+1}^{2n}\log\frac{k}{n}
  \end{aligned}"""),

      StepItem(tex: r"""\text{右辺は }"""),

      StepItem(tex: r"""\begin{aligned}
  &\ \ \ \ \ \lim_{n\to \infty} \frac1n\displaystyle \sum_{k=n+1}^{2n}\log\frac{k}{n}\\[6pt]
&=\lim_{n\to \infty} \int_1^2\log x\,dx\\[6pt]
  &=\bigl[x\log x-x\bigr]_1^2\\[6pt]
  &=2\log2-1
  \end{aligned}"""),

      StepItem(tex: r"""\text{よって}"""),
      StepItem(tex: r"""\begin{aligned}
  \lim_{n\to \infty} \log\!\left(\frac{1}{n}\sqrt[n]{{}_{2n}P_n}\right)= 2\log2-1
  \end{aligned}"""),

    StepItem(tex: r"""\log \text{ は連続関数なので、}"""),
    StepItem(tex: r"""\begin{aligned}
\lim_{n\to \infty} \log\!\left(\frac{1}{n}\sqrt[n]{{}_{2n}P_n}\right) &= \log\!\left( \lim_{n\to \infty} \frac{1}{n}\sqrt[n]{{}_{2n}P_n}\right)\\[5pt]
\end{aligned}"""),

StepItem(tex: r"""\text{とも書ける。以上でfへい得られた式 } 
\log\!\left(\lim_{n\to \infty} \frac{1}{n}\sqrt[n]{{}_{2n}P_n}\right)
= 2\log2-1
\text{ の両辺に指数関数を作用させると}"""),
    StepItem(tex: r"""\begin{aligned}
    &e^{\log\!( \lim_{n\to \infty} \frac{1}{n}\sqrt[n]{{}_{2n}P_n})} = e^{2\log2-1}\\[6pt]
\Leftrightarrow & \lim_{n\to \infty}\frac{1}{n}\sqrt[n]{{}_{2n}P_n} = \frac{4}{e}
\end{aligned}"""),
    ],
  ),


];
