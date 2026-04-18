import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// ============================================================================
/// 因数分解問題 - 初級
/// ============================================================================

const basicFactorizationProblems = <MathProblem>[
  // ────────────────────────────────
  // 問題 1: 完全平方（2変数）
  // ────────────────────────────────
  MathProblem(
    id: "5F7F2DCD-4A6E-4BA1-B97A-1F9B7B6809A4",
    no: 1,
    category: '因数分解',
    level: '初級',
    question: r"""x^2 + 6xy + 9y^2""",
    answer: r"""(x + 3y)^2""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
x^2 + 6xy + 9y^2 &= x^2 + (2\cdot 3y)x + (3y)^2 \\
&= (x + 3y)^2
\end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 3: 平方の差
  // ────────────────────────────────
  MathProblem(
    id: "897713C5-D885-4103-937C-62F11F4E5C18",
    no: 3,
    category: '因数分解',
    level: '初級',
    question: r"""36x^2 - 25y^2""",
    answer: r"""(6x - 5y)(6x + 5y)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
36x^2 - 25y^2 &= (6x)^2 - (5y)^2 \\
&= (6x - 5y)(6x + 5y)
\end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 4: 2次式の因数分解（たすきがけ）
  // ────────────────────────────────
  MathProblem(
    id: "E0D650DF-7B76-4A37-A0FE-B18A8A041E0B",
    no: 4,
    category: '因数分解',
    level: '初級',
    question: r"""x^2 - 9x - 22""",
    answer: r"""(x - 11)(x + 2)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\text{たすきがけを用いて、積が } -22 \text{、和が } -9 \text{ となる2数を探す。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
x^2 - 9x - 22 = (x - 11)(x + 2)
\end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 5: 共通因数と平方の差
  // ────────────────────────────────
  MathProblem(
    id: "546F77A4-9EED-4FED-92F4-8E22927D77C8",
    no: 5,
    category: '因数分解',
    level: '初級',
    question: r"""9x^3y - 16xy^3""",
    answer: r"""xy(3x-4y)(3x+4y)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\text{共通因数 } xy \text{ をくくり出す。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
9x^3y - 16xy^3 &= xy(9x^2 - 16y^2) \\
&= xy(3x-4y)(3x+4y)
\end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 2: 完全平方（係数あり）
  // ────────────────────────────────
  MathProblem(
    id: "15CEC271-B2C8-40A9-9B84-C64590472E61",
    no: 2,
    category: '因数分解',
    level: '初級',
    question: r"""4x^2 - 20xy + 25y^2""",
    answer: r"""(2x - 5y)^2""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
4x^2 - 20xy + 25y^2 &= (2x)^2 - 2(2x)(5y) + (5y)^2 \\
&= (2x - 5y)^2
\end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 6: 3次の因数定理
  // ────────────────────────────────
  MathProblem(
    id: "8B1C27DD-2BAC-41F5-8D5B-2B1F58AB12ED",
    no: 6,
    category: '因数分解',
    level: '中級',
    question: r"""x^3 + 2x^2 - 5x - 6""",
    answer: r"""(x+1)(x+3)(x-2)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\text{因数定理を用いる。定数項が } -6 \text{ なので、} \pm 1, \pm 2, \pm 3, \pm 6 \text{が候補。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\begin{aligned}
f(-1) &= (-1)^3 + 2 \cdot (-1)^2 - 5 \cdot (-1) - 6 \\
&= -1 + 2 + 5 - 6 = 0
\end{aligned}"""),
      StepItem(tex: r"""\text{よって、} x + 1 \text{ が因数。}"""),
      StepItem(tex: r"""\text{ } x^3 + 2x^2 - 5x - 6 \text{ を } x + 1 \text{ で割ると、}"""),
      StepItem(tex: r"""\begin{aligned}
x^3 + 2x^2 - 5x - 6 &= (x + 1)(x^2 + x - 6) \\
&= (x + 1)(x + 3)(x - 2)
\end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 7: 4変数の因数分解
  // ────────────────────────────────
  MathProblem(
    id: "A1B2C3D4-E5F6-A7B8-C9D0-E1F2A3B4C5D6",
    no: 7,
    category: '因数分解',
    level: '初級',
    question: r"""xy-yz+zu-ux""",
    answer: r"""(x-z)(y-u)""",
    imageAsset: '',
    hint: r"""\text{ } x \text{ と } z \text{ について整理する。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{ } x \text{ と } z \text{ について整理する。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
      xy - yz + zu - ux &= xy - ux - yz + zu \\
      &= x(y - u) - z(y - u) \\
      &= (x - z)(y - u)
      \end{aligned}"""),
    ],
  ),



];

