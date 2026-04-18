import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// ============================================================================
/// 因数分解問題 - 中級（予備問題）
/// ============================================================================

const midFactorizationReserveProblems = <MathProblem>[
  // 予備問題: 3変数の因数分解
  MathProblem(
    id: "A5BA5B5C-1557-48C1-B4D3-7C57FC5E3A41",
    no: "op8",
    category: '因数分解',
    level: '中級',
    question: r"""a^3 - 4a b^2 - 4b^2 c + a^2 c""",
    answer: r"""(a-2b)(a+2b)(a+c)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{最低次の変数 } c \text{ について整理する。(aについては3次,bについては2次,cについては1次)}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\text{ } c \text{ について整理すると、}"""),
      StepItem(tex: r"""\begin{aligned}
 &\ \ a^3 - 4a b^2 - 4b^2 c + a^2 c \\
 &= c(a^2 - 4b^2) + a^3 - 4a b^2 \\
 &= c(a^2 - 4b^2) + a(a^2 - 4b^2)  \\
 &= (c + a) (a^2 - 4b^2)\\
 &= (a+c)(a-2b)(a+2b)
 \end{aligned}"""),
    ],
  ),

  // 予備問題: 4次式の因数分解
  MathProblem(
    id: "34A820FC-E504-47F2-BBF4-741670A417AE",
    no: "op9",
    category: '因数分解',
    level: '中級',
    question: r"""x^4 + 3x^2 - 4""",
    answer: r"""(x^2 + 4)(x - 1)(x + 1)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{ } x^2 = t \text{ と置いて、2次式として因数分解して、それから} x \text{ の式に戻す。 }"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\text{ } x^2 = t \text{ と置くと、}"""),
      StepItem(tex: r"""\begin{aligned}
 x^4 + 3x^2 - 4 &= t^2 + 3t - 4 \\
 &= (t + 4)(t - 1)
 \end{aligned}"""),
      StepItem(tex: r"""\text{ } t = x^2 \text{ に戻すと、}"""),
      StepItem(tex: r"""\begin{aligned}
 &= (x^2 + 4)(x^2 - 1) \\
 &= (x^2 + 4)(x - 1)(x + 1)
 \end{aligned}"""),
    ],
  ),

  // 予備問題: 立方和
  MathProblem(
    id: "A60F2EC9-A23B-420B-89BE-6D8708B0DFA8",
    no: "op10",
    category: '因数分解',
    level: '初級',
    question: r"""x^3 + 64""",
    answer: r"""(x + 4)(x^2 - 4x + 16)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{立方和の公式 } a^3 + b^3 = (a+b)(a^2 - ab + b^2) \text{ を用いる。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
 x^3 + 64 &= x^3 + 4^3 \\
 &= (x + 4)(x^2 - 4x + 16)
 \end{aligned}"""),
    ],
  ),

  // 予備問題: 4次式の因数分解（因数定理）
  MathProblem(
    id: "8C5A89E9-86F8-4300-9179-3C9CF22FDF90",
    no: "op11",
    category: '因数分解',
    level: '中級',
    question: r"""x^4 - 3x^3 + 3x^2 - 3x + 2""",
    answer: r"""(x - 1)(x - 2)(x^2 + 1)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{因数定理を使う。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\text{ } x = 1 \text{ を代入すると、}"""),
      StepItem(tex: r"""\begin{aligned}
 &1^4 - 3 \cdot 1^3 + 3 \cdot 1^2 - 3 \cdot 1 + 2 \\
 &= 1 - 3 + 3 - 3 + 2 \\
 &= 0
 \end{aligned}"""),
      StepItem(tex: r"""\text{よって、} x^4 - 3x^3 + 3x^2 - 3x + 2 \text{は} x - 1 \text{ を因数にもつ。実際、} x^4 - 3x^3 + 3x^2 - 3x + 2 \text{を} x - 1 \text{で割ると、} x^3 - 2x^2 + x - 2 \text{ となる。ゆえに、}"""),
      StepItem(tex: r"""\begin{aligned}
 x^4 - 3x^3 + 3x^2 - 3x + 2 &= (x - 1)\textcolor{blue}{(x^3 - 2x^2 + x - 2)}\\[7pt]
 \end{aligned}"""),
      StepItem(tex: r"""\text{次に、 } x^3 - 2x^2 + x - 2 \text{ について、 } x = 2 \text{ を代入すると、}"""),
      StepItem(tex: r"""\begin{aligned}
 2^3 - 2 \cdot 2^2 + 2 - 2 &= 8 - 8 + 2 - 2 \\
 &= 0
 \end{aligned}"""),
      StepItem(tex: r"""\text{よって、} x^3 - 2x^2 + x - 2　\text{は} x - 2 \text{ を因数にもつ。実際、} x^3 - 2x^2 + x - 2 \text{を} x - 2 \text{で割ると、} x^2 + 1 \text{ となる。ゆえに、}"""),
      StepItem(tex: r"""\textcolor{blue}{x^3 - 2x^2 + x - 2} = \textcolor{red}{(x - 2)(x^2 + 1)}"""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
 x^4 - 3x^3 + 3x^2 - 3x + 2 &= (x - 1)\textcolor{blue}{(x^3 - 2x^2 + x - 2)} \\
 &= (x - 1)\textcolor{red}{(x - 2)}\textcolor{red}{(x^2 + 1)} \\
 &= (x - 1)(x - 2)(x^2 + 1)
 \end{aligned}"""),
    ],
  ),
];

