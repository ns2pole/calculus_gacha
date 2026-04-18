import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// ============================================================================
/// 因数分解問題 - 初級（予備問題）
/// ============================================================================

const basicFactorizationReserveProblems = <MathProblem>[
  // 予備問題: 完全平方（係数あり）
  MathProblem(
    id: "14E178D7-FC09-4439-B145-92688182FC44",
    no: "op2",
    category: '因数分解',
    level: '初級',
    question: r"""9x^2 - 24xy + 16y^2""",
    answer: r"""(3x - 4y)^2""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
 9x^2 - 24xy + 16y^2 &= (3x)^2 - 2(3x)(4y) + (4y)^2 \\
 &= (3x - 4y)^2
 \end{aligned}"""),
    ],
  ),

  // 予備問題: 平方の差
  MathProblem(
    id: "7D86EF83-52D7-4F6D-9A35-E085E17DA59C",
    no: "op3",
    category: '因数分解',
    level: '初級',
    question: r"""49x^2 - 36y^2""",
    answer: r"""(7x - 6y)(7x + 6y)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
 49x^2 - 36y^2 &= (7x)^2 - (6y)^2 \\
 &= (7x - 6y)(7x + 6y)
 \end{aligned}"""),
    ],
  ),

  // 予備問題: 完全平方（2変数）
  MathProblem(
    id: "51B65EA2-37AB-48F9-ACBE-2482B9740A10",
    no: "op1",
    category: '因数分解',
    level: '初級',
    question: r"""x^2 + 8xy + 16y^2""",
    answer: r"""(x + 4y)^2""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
 x^2 + 8xy + 16y^2 &= x^2 + (2\cdot 4y)x + (4y)^2 \\
 &= (x + 4y)^2
 \end{aligned}"""),
    ],
  ),

  // 予備問題: 2次式の因数分解（たすきがけ）
  MathProblem(
    id: "3CEFDD7D-4880-48DF-ABD8-7779C2D0F2C5",
    no: "op4",
    category: '因数分解',
    level: '初級',
    question: r"""x^2 - 7x - 18""",
    answer: r"""(x - 9)(x + 2)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\text{たすきがけを用いて、積が } -18 \text{、和が } -7 \text{ となる2数を探す。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
 x^2 - 7x - 18 = (x - 9)(x + 2)
 \end{aligned}"""),
    ],
  ),

  // 予備問題: 共通因数と平方の差
  MathProblem(
    id: "93BDE66A-D463-457F-A1C0-249A521A0B81",
    no: "op5",
    category: '因数分解',
    level: '初級',
    question: r"""4x^3y - 9xy^3""",
    answer: r"""xy(2x-3y)(2x+3y)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\text{共通因数 } xy \text{ をくくり出す。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
 4x^3y - 9xy^3 &= xy(4x^2 - 9y^2) \\
 &= xy(2x-3y)(2x+3y)
 \end{aligned}"""),
    ],
  ),

  // 予備問題: 4変数の因数分解
  MathProblem(
    id: "A73464B2-66D9-47E5-8069-94AC68CDB90F",
    no: "op7",
    category: '因数分解',
    level: '初級',
    question: r"""ab - bc + cd - da""",
    answer: r"""(a-c)(b-d)""",
    imageAsset: '',
    hint: r"""\text{ } a \text{ と } c \text{ について整理する。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{ } a \text{ と } c \text{ について整理する。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
      ab - bc + cd - da &= ab - da - bc + cd \\
      &= a(b - d) - c(b - d) \\
      &= (a - c)(b - d)
      \end{aligned}"""),
    ],
  ),

  // 予備問題: 3次の因数定理
  MathProblem(
    id: "B9C0D1E2-F3A4-5B6C-7D8E-9F0A1B2C3D4",
    no: "op6",
    category: '因数分解',
    level: '中級',
    question: r"""x^3 - 2x^2 - 5x + 6""",
    answer: r"""(x - 1)(x - 3)(x + 2)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\text{因数定理を用いる。定数項が } 6 \text{ なので、} \pm 1, \pm 2, \pm 3, \pm 6 \text{が候補。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\begin{aligned}
 f(1) &= 1^3 - 2 \cdot 1^2 - 5 \cdot 1 + 6 \\
 &= 1 - 2 - 5 + 6 = 0
 \end{aligned}"""),
      StepItem(tex: r"""\text{よって、} x - 1 \text{ が因数。}"""),
      StepItem(tex: r"""\text{ } x^3 - 2x^2 - 5x + 6 \text{ を } x - 1 \text{ で割ると、}"""),
      StepItem(tex: r"""\begin{aligned}
 x^3 - 2x^2 - 5x + 6 &= (x - 1)(x^2 - x - 6) \\
 &= (x - 1)(x - 3)(x + 2)
 \end{aligned}"""),
    ],
  ),

  // 予備問題: 4次の因数定理（定数項+8）
  // コメントアウトを外すと問題が追加されます
  // MathProblem(
  //   id: "9071E13B-4683-43DD-A5FF-E79B318DD996",
  //   no: 36,
  //   category: '因数分解',
  //   level: '初級',
  //   question: r"""x^4 + x^3 - 6x^2 - 4x + 8""",
  //   answer: r"""(x - 1)(x - 2)(x + 2)^2""",
  //   imageAsset: '',
  //   steps: [
  //     StepItem(tex: r"""\textbf{【ポイント】}"""),
  //     StepItem(tex: r"""\text{因数定理を用いる。定数項が } +8 \text{ なので、} \pm 1, \pm 2, \pm 4, \pm 8 \text{ を試す。}"""),
  //     StepItem(tex: r"""\textbf{【解説】}"""),
  //     StepItem(tex: r"""\begin{aligned}
  // f(1) &= 1^4 + 1^3 - 6 \cdot 1^2 - 4 \cdot 1 + 8 \\
  // &= 1 + 1 - 6 - 4 + 8 = 0
  // \end{aligned}"""),
  //     StepItem(tex: r"""\text{したがって、} x - 1 \text{ が因数。}"""),
  //     StepItem(tex: r"""\text{ } x^4 + x^3 - 6x^2 - 4x + 8 \text{ を } x - 1 \text{ で割ると、}"""),
  //     StepItem(tex: r"""\begin{aligned}
  // x^4 + x^3 - 6x^2 - 4x + 8 &= (x - 1)(x^3 + 2x^2 - 4x - 8)
  // \end{aligned}"""),
  //     StepItem(tex: r"""\text{さらに、} x^3 + 2x^2 - 4x - 8 \text{ について因数定理を適用すると、}"""),
  //     StepItem(tex: r"""\begin{aligned}
  // g(2) &= 2^3 + 2 \cdot 2^2 - 4 \cdot 2 - 8 = 8 + 8 - 8 - 8 = 0
  // \end{aligned}"""),
  //     StepItem(tex: r"""\text{したがって、} x - 2 \text{ も因数である。}"""),
  //     StepItem(tex: r"""\begin{aligned}
  // x^3 + 2x^2 - 4x - 8 &= (x - 2)(x^2 + 4x + 4) \\
  // &= (x - 2)(x + 2)^2
  // \end{aligned}"""),
  //     StepItem(tex: r"""\begin{aligned}
  // x^4 + x^3 - 6x^2 - 4x + 8 &= (x - 1)(x - 2)(x + 2)^2
  // \end{aligned}"""),
  //   ],
  // ),
];


