// rationalization_limits.dart
// 有理化を使う極限問題集（4問）


import '../../models/math_problem.dart';
import '../../models/step_item.dart';

const rationalization_limits = <MathProblem>[
  MathProblem(
  id: "774E49FD-A51A-4756-916A-52C94A3810BA",
  no: 1,
  category: '有理化',
  level: '初級',
  question: r"""\displaystyle \lim_{x\to 0}\frac{\sqrt{1+x}-1}{x}""",
  answer: r"""\displaystyle \frac{1}{2}""",
  imageAsset: 'assets/graphs/limit/problems_rationalization_limits/problem_2.png',
  steps: [
    StepItem(tex: r"""\textbf{【解答】}"""),
    StepItem(tex: r"""\begin{aligned}
      \displaystyle \lim_{x\to 0}\frac{\sqrt{1+x}-1}{x}
      =&\displaystyle \lim_{x\to 0}\frac{x}{x\bigl(\sqrt{1+x}+1\bigr)} \\[6pt]
      =&\displaystyle \lim_{x\to 0}\frac{1}{\sqrt{1+x}+1} \\[6pt]
      =&\displaystyle \frac{1}{2}
    \end{aligned}"""),
  ],
),

MathProblem(
  id: "F7C0451B-E946-4AB6-90C4-A3B539CE4A1D",
  no: 2,
  category: '有理化',
  level: '初級',
  question: r"""\displaystyle \lim_{n\to\infty}\sqrt{n^{2}+n}-n""",
  answer: r"""\displaystyle \frac{1}{2}""",
  imageAsset: 'assets/graphs/limit/problems_rationalization_limits/problem_6.png',
  hint: r"""\text{共役な数} \sqrt{n^{2}+n}+n \text{を分母分子に掛けて不定形を解消する。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{共役な数} \sqrt{n^{2}+n}+n \text{を分母分子に掛けて不定形を解消する。}"""),
    StepItem(tex: r"""\textbf{【解答】}"""),
    StepItem(tex: r"""\begin{aligned}
      \displaystyle & \sqrt{n^{2}+n}-n \\[6pt]
      =& \frac{\Bigl(\sqrt{n^{2}+n}-n\Bigr)\Bigl(\sqrt{n^{2}+n}+n\Bigr)}{\sqrt{n^{2}+n}+n} \\[6pt]
      =& \frac{n^{2} +n - n^2}{\sqrt{n^{2}+n}+n} \\[6pt]
      =& \frac{n}{\sqrt{n^{2}+n}+n} \\[6pt]
      =& \frac{1}{\sqrt{1+\frac{1}{n}}+1} \ \underset{n\to\infty}{\longrightarrow}\  \displaystyle \frac{1}{1 + 1} = \frac 1 2
    \end{aligned}"""),
  ],
),



];
