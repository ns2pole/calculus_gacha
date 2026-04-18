import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// ============================================================================
/// 因数分解問題 - 中級
/// ============================================================================

const midFactorizationProblems = <MathProblem>[
  // ────────────────────────────────
  // 問題 8: 3変数の因数分解
  // ────────────────────────────────
  MathProblem(
    id: "7474E9C1-6272-4491-8807-C095BDE7AD6F",
    no: 8,
    category: '因数分解',
    level: '中級',
    question: r"""a^3 - a b^2 - b^2 c + a^2 c""",
    answer: r"""(a+c)(a-b)(a+b)""",
    imageAsset: '',
    hint: r"""\text{最低次の変数 } c \text{ について整理する。(aについては3次,bについては2次,cについては1次)}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{最低次の変数 } c \text{ について整理する。(aについては3次,bについては2次,cについては1次)}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\text{ } c \text{ について整理すると、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ a^3 - a b^2 - b^2 c + a^2 c \\
&= c(a^2 - b^2) + a(a^2 - b^2) \\
&= (c+a)(a^2 - b^2) \\
&= (a+c)(a-b)(a+b)
\end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 9: 4次式の因数分解
  // ────────────────────────────────
  MathProblem(
    id: "1F0413C9-47F5-44A8-A3C3-519334677C68",
    no: 9,
    category: '因数分解',
    level: '中級',
    question: r"""x^4 + x^2 - 2""",
    answer: r"""(x^2 + 2)(x - 1)(x + 1)""",
    imageAsset: '',
    hint: r"""\text{ } x^2 = t \text{ と置いて、2次式として因数分解して、それから} x \text{ の式に戻す。 }""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{ } x^2 = t \text{ と置いて、2次式として因数分解して、それから} x \text{ の式に戻す。 }"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\text{ } x^2 = t \text{ と置くと、}"""),
      StepItem(tex: r"""\begin{aligned}
x^4 + x^2 - 2 &= t^2 + t - 2 \\
&= (t + 2)(t - 1)
\end{aligned}"""),
      StepItem(tex: r"""\text{ } t = x^2 \text{ に戻すと、}"""),
      StepItem(tex: r"""\begin{aligned}
&= (x^2 + 2)(x^2 - 1) \\
&= (x^2 + 2)(x - 1)(x + 1)
\end{aligned}"""),
    ],
  ),


  // ────────────────────────────────
  // 問題 10: 立方和
  // ────────────────────────────────
  MathProblem(
    id: "2BC52EFA-C75B-4E77-B1E5-E7ECCA113394",
    no: 10,
    category: '因数分解',
    level: '初級',
    question: r"""x^3 + 125""",
    answer: r"""(x + 5)(x^2 - 5x + 25)""",
    imageAsset: '',
    hint: r"""\text{立方和の公式 } a^3 + b^3 = (a+b)(a^2 - ab + b^2) \text{ を用いる。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{立方和の公式 } a^3 + b^3 = (a+b)(a^2 - ab + b^2) \text{ を用いる。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
x^3 + 125 &= x^3 + 5^3 \\
&= (x + 5)(x^2 - 5x + 25)
\end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 11: 4次式の因数分解（因数定理）
  // ────────────────────────────────
  MathProblem(
    id: "79E62DF5-7FEB-4D58-A989-DF5110913E3C",
    no: 11,
    category: '因数分解',
    level: '中級',
    question: r"""x^4 + 2x^3 + 2x^2 + 2x + 1""",
    answer: r"""(x + 1)^2(x^2 + 1)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{因数定理を使う。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\text{ } x = -1 \text{ を代入すると、}"""),
      StepItem(tex: r"""\begin{aligned}
&(-1)^4 + 2(-1)^3 + 2(-1)^2 + 2(-1) + 1 \\
&= 1 - 2 + 2 - 2 + 1 \\
&= 0
\end{aligned}"""),
      StepItem(tex: r"""\text{よって、} x^4 + 2x^3 + 2x^2 + 2x + 1 \text{は} x + 1 \text{ を因数にもつ。実際、} x^4 + 2x^3 + 2x^2 + 2x + 1 \text{を} x + 1 \text{で割ると、} x^3 + x^2 + x + 1 \text{ となる。ゆえに、}"""),
      StepItem(tex: r"""\begin{aligned}
x^4 + 2x^3 + 2x^2 + 2x + 1 &= (x + 1)\textcolor{blue}{(x^3 + x^2 + x + 1)}\\[7pt]
\end{aligned}"""),
      StepItem(tex: r"""\text{次に、 } x^3 + x^2 + x + 1 \text{ について、 } x = -1 \text{ を代入すると、}"""),
      StepItem(tex: r"""\begin{aligned}
(-1)^3 + (-1)^2 + (-1) + 1 &= -1 + 1 - 1 + 1 \\
&= 0
\end{aligned}"""),
      StepItem(tex: r"""\text{よって、} x^3 + x^2 + x + 1　\text{は} x + 1 \text{ を因数にもつ。実際、} x^3 + x^2 + x + 1 \text{を} x + 1 \text{で割ると、} x^2 + 1 \text{ となる。ゆえに、}"""),
      StepItem(tex: r"""\textcolor{blue}{x^3 + x^2 + x + 1} = \textcolor{red}{(x + 1)(x^2 + 1)}"""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
x^4 + 2x^3 + 2x^2 + 2x + 1 &= (x + 1)\textcolor{blue}{(x^3 + x^2 + x + 1)} \\
&= (x + 1)\textcolor{red}{(x + 1)}\textcolor{red}{(x^2 + 1)} \\
&= (x + 1)^2(x^2 + 1)
\end{aligned}"""),
    ],
  ),

];

