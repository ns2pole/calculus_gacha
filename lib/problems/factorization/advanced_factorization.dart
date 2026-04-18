import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// ============================================================================
/// 因数分解問題 - 上級
/// ============================================================================

const advancedFactorizationProblems = <MathProblem>[
  // ────────────────────────────────
  // 問題 12: 2変数2次式の因数分解
  // ────────────────────────────────
  MathProblem(
    id: "BE5B4E1D-4297-4F80-98BC-F74655BF03F9",
    no: 12,
    category: '因数分解',
    level: '中級',
    question: r"""2x^2 + 5xy + 2y^2 - 5x - y - 3""",
    answer: r"""(2x + y + 1)(x + 2y - 3)""",
    imageAsset: '',
    hint: r"""\text{ } x \text{ について整理し、たすきがけを用いて因数分解する。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{ } x \text{ について整理し、たすきがけを用いて因数分解する。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ 2x^2 + 5xy + 2y^2 - 5x - y - 3 \\
&= 2x^2 + x(5y - 5) + (2y^2 - y - 3) \\
&= 2x^2 + x(5y - 5) + (y+1)(2y-3) \\
&= (2x + y + 1)(x + 2y - 3)
\end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 13: 3変数の対称式
  // ────────────────────────────────
  MathProblem(
    id: "CE7A2246-F134-4248-86EA-31A0502F58F1",
    no: 13,
    category: '因数分解',
    level: '中級',
    question: r"""a^2(b-c) + b^2(c-a) + c^2(a-b)""",
    answer: r"""-(a-b)(b-c)(c-a)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\text{対称式で、どの文字についても次数は同じなので、任意の文字を選んで降べきに整理する。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ a^2(b-c) + b^2(c-a) + c^2(a-b) \\
&= a^2(b-c) - a b^2 + b^2 c + a c^2 - c^2 b \\
&= a^2(b-c) - a(b^2- c^2) + (b^2 c - c^2 b) \\
&= a^2(b-c) - a(b-c)(b+c) + bc(b-c) \\
&= (b-c)\bigl(a^2 - (b+c)a + bc\bigr) \\
&= (b-c)(a-b)(a-c) \\
&= -(a-b)(b-c)(c-a)
\end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 14: 4次式の因数分解（複雑）
  // ────────────────────────────────
  MathProblem(
    id: "703AE189-789C-4F2D-83A4-55C68DD65991",
    no: 14,
    category: '因数分解',
    level: '中級',
    question: r"""x^4 + x^2 + 1""",
    answer: r"""(x^2 + x + 1)(x^2 - x + 1)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
x^4 + x^2 + 1 &= (x^2 + 1)^2 - x^2 \\
&= (x^2 + 1 + x)(x^2 + 1 - x)\\
&= (x^2 + x + 1)(x^2 - x + 1)
\end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 15: 立方差
  // ────────────────────────────────
  MathProblem(
    id: "DB124FEE-EBB5-4940-B445-2D08B1B87E9A",
    no: 15,
    category: '因数分解',
    level: '初級',
    question: r"""27x^3 - 8y^3""",
    answer: r"""(3x - 2y)(9x^2 + 6xy + 4y^2)""",
    imageAsset: '',
    hint: r"""\text{立方差の公式 } a^3 - b^3 = (a-b)(a^2 + ab + b^2) \text{ を用いる。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{立方差の公式 } a^3 - b^3 = (a-b)(a^2 + ab + b^2) \text{ を用いる。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
27x^3 - 8y^3 &= (3x)^3 - (2y)^3 \\
&= (3x - 2y)(9x^2 + 6xy + 4y^2)
\end{aligned}"""),
    ],
  ),


  // ────────────────────────────────
  // 問題 16: 4次式の因数分解（複雑）
  // ────────────────────────────────
  MathProblem(
    id: "1EC3C384-44E0-4C3B-8FE4-2E3814FD7CB3",
    no: 16,
    category: '因数分解',
    level: '中級',
    question: r"""x^4 + 4""",
    answer: r"""(x^2 - 2x + 2)(x^2 + 2x + 2)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
x^4 + 4 &= (x^2 + 2)^2 - 4x^2 \\
&= (x^2 + 2)^2 - (2x)^2 \\
&= (x^2 + 2 - 2x)(x^2 + 2 + 2x) \\
&= (x^2 - 2x + 2)(x^2 + 2x + 2)
\end{aligned}"""),
    ],
  ),


  // ────────────────────────────────
  // 問題 17: 3変数の立方和と3倍の積
  // ────────────────────────────────
  MathProblem(
    id: "09338EE1-388B-4048-ABC3-CD11A1297220",
    no: 17,
    category: '因数分解',
    level: '上級',
    question: r"""x^3 + y^3 + z^3 - 3xyz""",
    answer: r"""(x + y + z)(x^2 + y^2 + z^2 - xy - yz - zx)""",
    imageAsset: '',
    hint: r"""\text{恒等式 } a^3 + b^3 = (a+b)^3 - 3ab(a+b) \text{ を2回使う。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{恒等式 } a^3 + b^3 = (a+b)^3 - 3ab(a+b) \text{ を2回使う。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\text{1回目： } x^3 + y^3 = (x+y)^3 - 3xy(x+y) \text{ より、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ x^3 + y^3 + z^3 - 3xyz \\
&= (x + y)^3 - 3xy(x + y) + z^3 - 3xyz \\
&= (x + y)^3 + z^3 - 3xy(x + y + z)
\end{aligned}"""),
      StepItem(tex: r"""\text{2回目： } x + y = A \text{ と置くと、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ A^3 + z^3 - 3xy(A + z) \\
&= (A + z)^3 - 3Az(A + z) - 3xy(A + z) \\
&= (A + z)\{(A + z)^2 - 3Az - 3xy\} \\
&= (A + z)(A^2 + 2Az + z^2 - 3Az - 3xy) \\
&= (A + z)(A^2 - Az + z^2 - 3xy)
\end{aligned}"""),
      StepItem(tex: r"""\text{ } A = x + y \text{ に戻すと、}"""),
      StepItem(tex: r"""\begin{aligned}
&= (x + y + z)\{(x + y)^2 - (x + y)z + z^2 - 3xy\} \\
&= (x + y + z)(x^2 + 2xy + y^2 - xz - yz + z^2 - 3xy) \\
&= (x + y + z)(x^2 + y^2 + z^2 - xy - yz - zx)
\end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 18: 3変数の立方和と3倍の積（応用）
  // ────────────────────────────────
  MathProblem(
    id: "24D47C58-831B-4D01-A30E-3BD84A0D741E",
    no: 18,
    category: '因数分解',
    level: '上級',
    question: r"""x^3 - 9xy + 27y^3 + 1""",
    answer: r"""(x + 3y + 1)(x^2 + 9y^2 + 1  - 3xy - 3y - x)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
StepItem(tex: r"""\text{恒等式 } a^3 + b^3 = (a+b)^3 - 3ab(a+b) \text{ を2回使う。}"""),
StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\text{1回目： } x^3 + (3y)^3 = (x+3y)^3 - 3x(3y)(x+3y) \text{ より、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ x^3 - 9xy + 27y^3 + 1 \\
&= x^3 + (3y)^3 + 1 - 9xy \\
&= (x + 3y)^3 - 3x(3y)(x + 3y) + 1 - 9xy \\
&= (x + 3y)^3 - 9xy(x + 3y) + 1 - 9xy \\
&= (x + 3y)^3 + 1 - 9xy(x + 3y + 1)
\end{aligned}"""),
      StepItem(tex: r"""\text{2回目： } x + 3y = A \text{ と置くと、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ A^3 + 1 - 9xy(A + 1) \\
&= (A + 1)^3 - 3A(A + 1) - 9xy(A + 1) \\
&= (A + 1)\{(A + 1)^2 - 3A - 9xy\} \\
&= (A + 1)(A^2 + 2A + 1 - 3A - 9xy) \\
&= (A + 1)(A^2 - A + 1 - 9xy)
\end{aligned}"""),
      StepItem(tex: r"""\text{ } A = x + 3y \text{ に戻すと、}"""),
      StepItem(tex: r"""\begin{aligned}
&= (x + 3y + 1)\{(x + 3y)^2 - (x + 3y) + 1 - 9xy\} \\
&= (x + 3y + 1)(x^2 + 6xy + 9y^2 - x - 3y + 1 - 9xy) \\
&= (x + 3y + 1)(x^2 + 9y^2 + 1  - 3xy - 3y - x)
\end{aligned}"""),

    StepItem(tex: r"""\textbf{【早い方法】}"""),
    StepItem(tex: r"""\text{因数分解}a^3 + b^3 + c^3 - 3abc = (a + b + c)(a^2 + b^2 + c^2 - ab - bc - ca) \text{を用いる。}"""),
    StepItem(tex: r"""\text{ここで } a = x, b = 3y, c = 1 \text{ とおくと、}"""),
    StepItem(tex: r"""\begin{aligned}
x^3 - 9xy + 27y^3 + 1 &= x^3 + (3y)^3 + 1^3 - 3x(3y)(1) \\
&= (x + 3y + 1)(x^2 + (3y)^2 + 1^2 - x(3y) - 3y(1) - 1(x)) \\
&= (x + 3y + 1)(x^2 + 9y^2 + 1 - 3xy - 3y - x) \\
\end{aligned}"""),
    ],
  ),

  

  // ────────────────────────────────
  // 問題 19: 4次式の因数分解（係数比較・詳細）
  // ────────────────────────────────
  MathProblem(
    id: "1BD1750A-06EA-42B5-81DB-57091773730C",
    no: 19,
    category: '因数分解',
    level: '上級',
    question: r"""x^4 + 9x^3 + 16x^2 - x - 3""",
    answer: r"""(x^2 + 2x - 1)(x^2 + 7x + 3)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""f(x) = x^4 + 9x^3 + 16x^2 - x - 3\text{とおいて、まずは、因数定理を用い、候補（±1, ±3）を代入して、1次式の因数を持たないことを認識したら、その後、2次式×2次式の形で係数比較を行うのが自然。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\text{因数定理の候補を代入すると、}"""),
      StepItem(tex: r"""\begin{aligned}
f(1) &= 1 + 9 + 16 - 1 - 3 = 22 \neq 0 \\
f(-1) &= 1 - 9 + 16 + 1 - 3 = 6 \neq 0 \\
f(3) &= 81 + 243 + 144 - 3 - 3 = 462 \neq 0 \\
f(-3) &= 81 - 243 + 144 + 3 - 3 = -18 \neq 0
\end{aligned}"""),
      StepItem(tex: r"""\text{よって、1次式の因数を持たない。よって2次式×2次式の因数分解を探す。}"""),
      StepItem(tex: r"""\text{整数係数で } f(x) = (x^2 + ax + b)(x^2 + cx + d) \text{ とおく。}"""),
      StepItem(tex: r"""\textcolor{red}{実は計算すると、下記のように計算できる。}"""),
      StepItem(tex: r"""\textcolor{red}{a = 2,\ b = -1,\ c = 7,\ d = 3}"""),
      StepItem(tex: r"""\textcolor{red}{以下ではこの証明を行う。}"""),
      StepItem(tex: r"""\textbf{【証明】}"""),
      StepItem(tex: r"""\text{ここで } x^4 + 9x^3 + 16x^2 - x - 3 \text{ の定数項が } -3 \text{ であることから、 } (b, d) = (1, -3), (-1, 3) \text{ の場合に分けて解を探す。}"""),
      StepItem(tex: r"""\textcolor{blue}{1. } \textcolor{blue}{(b, d) = (1, -3)} \textcolor{blue}{の場合}"""),
      StepItem(tex: r"""\text{ } f(x) = (x^2 + ax + 1)(x^2 + cx - 3) \text{ とおくと、}"""),
      StepItem(tex: r"""\begin{aligned}
x^4 + 9x^3 + 16x^2 - x - 3 &= (x^2 + ax + 1)(x^2 + cx - 3) \\
&= x^4 + (a+c)x^3 + (ac - 2)x^2 + (-3a + c)x - 3
\end{aligned}"""),
      StepItem(tex: r"""\text{係数比較より、}"""),
      StepItem(tex: r"""
      \begin{aligned}
&\text{3次: } a + c = 9\ \cdots (1) \\[2pt]
&\text{2次: } ac - 2 = 16\ \ \cdots (2) \\[2pt]
&\text{1次: } -3a + c = -1\ \ \cdots (3)
\end{aligned}"""),
      StepItem(tex: r"""\text{(2),(1) より } ac = 18, a + c = 9 \text{ であるから、}"""),
      StepItem(tex: r"""\text{ } (a = 6, c = 3) \text{ または } (a = 3, c = 6) \text{ を得る。}"""),
      StepItem(tex: r"""\text{これを(3)に代入すると、}"""),
      StepItem(tex: r"""-3a + c = -3 \cdot 6 + 3 = -15"""),
      StepItem(tex: r"""-3a + c = -3 \cdot 3 + 6 = -3"""),
      StepItem(tex: r"""\textcolor{red}{よって、これらはいずれも -1 にならず、(3)を満たさない。}"""),

      StepItem(tex: r"""\textcolor{blue}{2. } \textcolor{blue}{(b, d) = (-1, 3)}\textcolor{blue}{ の場合}"""),
      StepItem(tex: r"""\text{ } f(x) = (x^2 + ax - 1)(x^2 + cx + 3) \text{ とおくと、}"""),
      StepItem(tex: r"""\begin{aligned}
x^4 + 9x^3 + 16x^2 - x - 3 &= (x^2 + ax - 1)(x^2 + cx + 3) \\
&= x^4 + (a+c)x^3 + (ac + 2)x^2 + (3a - c)x - 3
\end{aligned}"""),
      StepItem(tex: r"""\text{係数比較より、}"""),
      StepItem(tex: r"""
      \begin{aligned}
&\text{3次: } a + c = 9\ \cdots (1) \\[2pt]
&\text{2次: } ac + 2 = 16\ \ \cdots (2) \\[2pt]
&\text{1次: } 3a - c = -1\ \ \cdots (3)
\end{aligned}"""),
      StepItem(tex: r"""\text{(2),(1) より } ac = 14, a + c = 9 \text{ であるから、}"""),
      StepItem(tex: r"""\text{ } (a = 7, c = 2) \text{ または } (a = 2, c = 7) \text{ を得る。}"""),
      StepItem(tex: r"""\text{これを(3)に代入すると、}"""),
      StepItem(tex: r"""3a - c = 3 \cdot 7 - 2 = 19"""),
      StepItem(tex: r"""3a - c = 3 \cdot 2 - 7 = -1"""),
      StepItem(tex: r"""\text{よって、1つ目は 19 になり -1 にならず、(3)を満たさない。2つ目は -1 になり、(3)を満たす。}"""),
      StepItem(tex: r"""\textcolor{green}{したがって、 }(a, b, c, d) = (2, -1, 7, 3)\text{である。}"""),
      StepItem(tex: r"""\textcolor{green}{\begin{aligned}
x^4 + 9x^3 + 16x^2 - x - 3 &= (x^2 + 2x - 1)(x^2 + 7x + 3)
\end{aligned}}"""),
    ],
  ),

   // 問題 20: 5次式の因数分解（因数定理）
  // ────────────────────────────────
  MathProblem(
    id: "3A5214AB-C386-4C28-AA01-886809BDE55A",
    no: 20,
    category: '因数分解',
    level: '上級',
    question: r"""x^5 + x^4 + x^3 + x^2 + x + 1""",
    answer: r"""(x + 1)(x^2 + x + 1)(x^2 - x + 1)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{因数定理を用いる。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\text{ } x = -1 \text{ を代入すると、}"""),
      StepItem(tex: r"""\begin{aligned}
\ \ \ \ &(-1)^5 + (-1)^4 + (-1)^3 + (-1)^2 + (-1) + 1 \\
&= -1 + 1 - 1 + 1 - 1 + 1 \\
&= 0
\end{aligned}"""),
      StepItem(tex: r"""\text{よって、 } x + 1 \text{ を因数にもち、下記のように分解される。}"""),
      StepItem(tex: r"""\begin{aligned}
x^5 + x^4 + x^3 + x^2 + x + 1 &= (x + 1) \textcolor{blue}{(x^4 + x^2 + 1)}
\end{aligned}"""),
      StepItem(tex: r"""\text{次に、 } x^4 + x^2 + 1 \text{ を因数分解する。}"""),
      StepItem(tex: r"""\begin{aligned}
\textcolor{blue}{x^4 + x^2 + 1} &= (x^2 + 1)^2 - x^2 \\
&= (x^2 + 1 + x)(x^2 + 1 - x) \\
&= \textcolor{red}{(x^2 + x + 1)(x^2 - x + 1)}
\end{aligned}"""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
x^5 + x^4 + x^3 + x^2 + x + 1= (x + 1)\textcolor{red}{(x^2 + x + 1)}\textcolor{red}{(x^2 - x + 1)}
\end{aligned}"""),
    ],
  ),

//   ────────────────────────────────
//   問題 21: 5次式の因数分解（因数定理）
//   ────────────────────────────────
  MathProblem(
    id: "227D1ED5-9BAE-49E1-BD62-02531FB8ADF1",
    no: 21,
    category: '因数分解',
    level: '上級',
    question: r"""x^5 - x^4 - 1""",
    answer: r"""(x^2 - x + 1)(x^3 - x - 1)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""f(x) = x^5 - x^4 - 1\text{とおいて、まずは、因数定理を用い、候補（±1）を代入して、1次式の因数を持たないことを認識したら、その後、2次式×3次式の形で係数比較を行うのが自然。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\text{因数定理の候補を代入すると、}"""),
      StepItem(tex: r"""\begin{aligned}
f(1) &= 1 - 1 - 1 = -1 \neq 0 \\
f(-1) &= -1 - 1 - 1 = -3 \neq 0
\end{aligned}"""),
      StepItem(tex: r"""\text{よって、1次式の因数を持たない。よって2次式×3次式の因数分解を探す。}"""),
      StepItem(tex: r"""\text{整数係数で } f(x) = (x^2 + ax + \alpha)(x^3 + bx^2 + cx + \beta) \text{ とおく。}"""),
      StepItem(tex: r"""\textcolor{red}{実は計算すると、下記のように計算できる。}"""),
      StepItem(tex: r"""\textcolor{red}{a = -1,\ b = 0,\ c = -1,\ \alpha = 1,\ \beta = -1}"""),
      StepItem(tex: r"""\textcolor{red}{以下ではこの証明を行う。}"""),
      StepItem(tex: r"""\textbf{【証明】}"""),
      StepItem(tex: r"""\text{ここで } x^5 - x^4 - 1 \text{ の定数項が } -1 \text{ であることから、 } \alpha\beta = -1 \text{ であるため、 } (\alpha, \beta) = (1, -1), (-1, 1) \text{ の場合に分けて解を探す。}"""),
      StepItem(tex: r"""\textcolor{blue}{1. } \textcolor{blue}{(\alpha, \beta) = (1, -1)} \textcolor{blue}{の場合}"""),
      StepItem(tex: r"""\text{ } f(x) = (x^2 + ax + 1)(x^3 + bx^2 + cx - 1) \text{ とおくと、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ x^5 - x^4 - 1 \\
&= (x^2 + ax + 1)(x^3 + bx^2 + cx - 1) \\
&= x^5 + (a+b)x^4 + (ab + c + 1)x^3 + (ac + b - 1)x^2 + (- a + c)x - 1
\end{aligned}"""),
      StepItem(tex: r"""\text{係数比較より、}"""),
      StepItem(tex: r"""
      \begin{aligned}
&\text{4次: } a + b = -1\ \cdots (1) \\[2pt]
&\text{3次: } ab + c + 1 = 0\ \ \cdots (2) \\[2pt]
&\text{2次: } ac + b - 1 = 0\ \ \cdots (3) \\[2pt]
&\text{1次: } -a + c = 0\ \ \cdots (4)
\end{aligned}"""),
      StepItem(tex: r"""\text{(4),(1) より } c = a , b = -1 - a \text{これを(2)に代入して、}"""),
      StepItem(tex: r"""a(-1 - a) + a + 1 = -a - a^2 + a + 1 = -a^2 + 1 = 0 \text{、すなわち } a^2 = 1"""),
      StepItem(tex: r"""\text{これより } a = 1 \text{ または } a = -1 \text{ を得る。}"""),
      StepItem(tex: r"""\textcolor{blue}{(i) } \textcolor{blue}{a = 1 のとき}"""),
      StepItem(tex: r"""\text{ } b = -2, c = 1 \text{、このとき (3) より、}"""),
      StepItem(tex: r"""\begin{aligned}
ac + b - 1 &= 1 \cdot 1 + (-2) - 1 = -2 \neq 0
\end{aligned}"""),
      StepItem(tex: r"""\textcolor{red}{したがってこの場合は(3)を満たさない。}"""),
      StepItem(tex: r"""\textcolor{blue}{(ii) } \textcolor{blue}{a = -1 のとき}"""),
      StepItem(tex: r"""\text{ } b = 0, c = -1 \text{、このとき (3) より、}"""),
      StepItem(tex: r"""\begin{aligned}
ac + b - 1 &= (-1) \cdot (-1) + 0 - 1 = 0
\end{aligned}"""),
      StepItem(tex: r"""\textcolor{green}{であるので、(3)を満たし、(1),(2),(3),(4)の連立方程式の解は}"""),
      StepItem(tex: r"""\textcolor{green}{a = -1, \quad b = 0, \quad c = -1}"""),
      StepItem(tex: r"""\textcolor{green}{したがって、}\textcolor{green}{ (a, b, c, \alpha, \beta) = (-1, 0, -1, 1, -1)}\textcolor{green}{となり、答えは}"""),
      StepItem(tex: r"""\textcolor{green}{ x^5 - x^4 - 1 = (x^2 - x + 1)(x^3 - x - 1)} """),
      StepItem(tex: r"""\textcolor{brown}{\large{これで答えは得られたが、一応、}}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{他に解がないことを下記で確認しておく。}}"""),
      StepItem(tex: r"""\textcolor{blue}{2. } \textcolor{blue}{(\alpha, \beta) = (-1, 1)} \textcolor{blue}{の場合}"""),
      StepItem(tex: r"""\text{ } f(x) = (x^2 + ax - 1)(x^3 + bx^2 + cx + 1) \text{ とおくと、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ x^5 - x^4 - 1 \\
&= (x^2 + ax - 1)(x^3 + bx^2 + cx + 1) \\
&= x^5 + (a+b)x^4 + (ab + c - 1)x^3 + (ac - b + 1)x^2 + (a - c)x - 1
\end{aligned}"""),
      StepItem(tex: r"""\text{係数比較より、}"""),
      StepItem(tex: r"""
      \begin{aligned}
&\text{4次: } a + b = -1\ \cdots (1) \\[2pt]
&\text{3次: } ab + c - 1 = 0\ \ \cdots (2) \\[2pt]
&\text{2次: } ac - b + 1 = 0\ \ \cdots (3) \\[2pt]
&\text{1次: } a - c = 0\ \ \cdots (4)
\end{aligned}"""),
      StepItem(tex: r"""\text{(4),(1) より } c = a , b = -1 - a \text{これを(2)に代入して、}"""),
      StepItem(tex: r"""a(-1 - a) + a - 1 = -a - a^2 + a - 1 = -a^2 - 1 = 0 \text{、すなわち } a^2 = -1"""),
      StepItem(tex: r"""\textcolor{red}{これは実数解を持たない。}"""),
    ],
  ),

];

