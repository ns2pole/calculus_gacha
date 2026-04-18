import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// ============================================================================
/// 因数分解問題 - 上級（予備問題）
/// ============================================================================

const advancedFactorizationReserveProblems = <MathProblem>[
  // 予備問題: 2変数2次式の因数分解
  MathProblem(
    id: "656CDF93-3968-4527-81AE-9376B3E5B66B",
    no: "op12",
    category: '因数分解',
    level: '中級',
    question: r"""3x^2 + 8xy + 4y^2 - 11x - 6y - 4""",
    answer: r"""(3x + 2y + 1)(x + 2y - 4)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{ } x \text{ について整理し、たすきがけを用いて因数分解する。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
 &\ \ 3x^2 + 8xy + 4y^2 - 11x - 6y - 4 \\
 &= 3x^2 + x(8y - 11) + (4y^2 - 6y - 4) \\
 &= 3x^2 + x(8y - 11) + 2(2y+1)(y-2) \\
 &= (3x + 2y + 1)(x + 2y - 4)
 \end{aligned}"""),
    ],
  ),

  // 予備問題: 3変数の対称式
  MathProblem(
    id: "FAA00A56-4049-4921-A9C8-93B3F420DA1C",
    no: "op13",
    category: '因数分解',
    level: '中級',
    question: r"""a(b^2+c^2) + b(c^2+a^2) + c(a^2+b^2) + 2abc""",
    answer: r"""(a+b)(b+c)(c+a)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\text{対称式で、どの文字についても次数は同じなので、任意の文字を選んで降べきに整理する。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\text{ } a \text{ について整理すると、}"""),
      StepItem(tex: r"""\begin{aligned}
 &\ \ a(b^2+c^2) + b(c^2+a^2) + c(a^2+b^2) + 2abc \\
 &= ab^2 + ac^2 + bc^2 + ba^2 + ca^2 + cb^2 + 2abc \\
 &= a^2(b+c) + a(b^2 + c^2 + 2bc) + bc(b+c) \\
 &= a^2(b+c) + a(b+c)^2 + bc(b+c) \\
 &= (b+c)\bigl(a^2 + a(b+c) + bc\bigr) \\
 &= (b+c)(a+b)(a+c) \\
 &= (a+b)(b+c)(c+a)
 \end{aligned}"""),
    ],
  ),

  // 予備問題: 4次式の因数分解（複雑）
  MathProblem(
    id: "CAF59AF0-A107-4D21-B0E3-2C3D888A83D2",
    no: "op14",
    category: '因数分解',
    level: '中級',
    question: r"""x^4 + 5x^2 + 9""",
    answer: r"""(x^2 + x + 3)(x^2 - x + 3)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
 x^4 + 5x^2 + 9 &= (x^2 + 3)^2 - x^2 \\
 &= (x^2 + 3 + x)(x^2 + 3 - x) \\
 &= (x^2 + x + 3)(x^2 - x + 3)
 \end{aligned}"""),
    ],
  ),

  // 予備問題: 立方差
  MathProblem(
    id: "7AF1A86F-615F-4E44-AEE8-F3BA22B7E6CC",
    no: "op15",
    category: '因数分解',
    level: '初級',
    question: r"""64x^3 - 27y^3""",
    answer: r"""(4x - 3y)(16x^2 + 12xy + 9y^2)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{立方差の公式 } a^3 - b^3 = (a-b)(a^2 + ab + b^2) \text{ を用いる。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
 64x^3 - 27y^3 &= (4x)^3 - (3y)^3 \\
 &= (4x - 3y)(16x^2 + 12xy + 9y^2)
 \end{aligned}"""),
    ],
  ),

  // 予備問題: 4次式の因数分解（複雑）
  MathProblem(
    id: "E406BD56-74DE-4603-9695-AE08B0757BE7",
    no: "op16",
    category: '因数分解',
    level: '中級',
    question: r"""x^4 + 4y^4""",
    answer: r"""(x^2 - 2xy + 2y^2)(x^2 + 2xy + 2y^2)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
 x^4 + 4y^4 &= (x^2 + 2y^2)^2 - 4x^2y^2 \\
 &= (x^2 + 2y^2)^2 - (2xy)^2 \\
 &= (x^2 + 2y^2 - 2xy)(x^2 + 2y^2 + 2xy) \\
 &= (x^2 - 2xy + 2y^2)(x^2 + 2xy + 2y^2)
 \end{aligned}"""),
    ],
  ),

  // 予備問題: 3変数の立方和
  MathProblem(
    id: "F1A2B3C4-D5E6-F7A8-B9C0-D1E2F3A4B5C6",
    no: "op17",
    category: '因数分解',
    level: '上級',
    question: r"""(y-z)^3+(z-x)^3+(x-y)^3""",
    answer: r"""3(y-z)(z-x)(x-y)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{恒等式 } a^3 + b^3 + c^3 - 3abc = (a+b+c)(a^2+b^2+c^2-ab-bc-ca) \text{ を用いる。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\text{ } a = y-z, b = z-x, c = x-y \text{ とおくと、}"""),
      StepItem(tex: r"""\begin{aligned}
     a + b + c &= (y-z) + (z-x) + (x-y) \\
     &= y - z + z - x + x - y \\
     &= 0
     \end{aligned}"""),
      StepItem(tex: r"""\text{よって、恒等式より、}"""),
      StepItem(tex: r"""\begin{aligned}
     &\ \ \ \ \  a^3 + b^3 + c^3 - 3abc &= 0 \\
     &\Leftrightarrow a^3 + b^3 + c^3 &= 3abc \\
     &\Leftrightarrow (y-z)^3 + (z-x)^3 + (x-y)^3 &= 3(y-z)(z-x)(x-y)
     \end{aligned}"""),
    ],
  ),

  // 予備問題: 3変数の立方和と3倍の積（応用）
  MathProblem(
    id: "6C4F2FA4-742F-474E-8103-E3BA3E979350",
    no: "op18",
    category: '因数分解',
    level: '上級',
    question: r"""a^3 + 18ab - 8b^3 + 27""",
    answer: r"""(a - 2b + 3)(a^2 + 4b^2 + 9 + 2ab - 3a + 6b)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{恒等式 } a^3 + b^3 = (a+b)^3 - 3ab(a+b) \text{ を2回使う。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\text{1回目： } a^3 + (-2b)^3 = (a-2b)^3 - 3a(-2b)(a-2b) \text{ より、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ a^3 + 18ab - 8b^3 + 27 \\
&= a^3 + (-2b)^3 + 27 + 18ab \\
&= (a - 2b)^3 - 3a(-2b)(a - 2b) + 27 + 18ab \\
&= (a - 2b)^3 + 6ab(a - 2b) + 27 + 18ab \\
&= (a - 2b)^3 + 27 + 6ab(a - 2b + 3)
\end{aligned}"""),
      StepItem(tex: r"""\text{2回目： } a - 2b = A \text{ と置くと、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ A^3 + 27 + 6ab(A + 3) \\
&= (A + 3)^3 - 3A(A + 3) + 6ab(A + 3) \\
&= (A + 3)\{(A + 3)^2 - 3A + 6ab\} \\
&= (A + 3)(A^2 + 6A + 9 - 3A + 6ab) \\
&= (A + 3)(A^2 + 3A + 9 + 6ab)
\end{aligned}"""),
      StepItem(tex: r"""\text{ } A = a - 2b \text{ に戻すと、}"""),
      StepItem(tex: r"""\begin{aligned}
&= (a - 2b + 3)\{(a - 2b)^2 + 3(a - 2b) + 9 + 6ab\} \\
&= (a - 2b + 3)(a^2 - 4ab + 4b^2 + 3a - 6b + 9 + 6ab) \\
&= (a - 2b + 3)(a^2 + 4b^2 + 9 + 2ab - 3a + 6b)
\end{aligned}"""),

      StepItem(tex: r"""\textbf{【早い方法】}"""),
      StepItem(tex: r"""\text{因数分解}a^3 + b^3 + c^3 - 3abc = (a + b + c)(a^2 + b^2 + c^2 - ab - bc - ca) \text{を用いる。}"""),
      StepItem(tex: r"""\text{ここで } a = a, b = -2b, c = 3 \text{ とおくと、}"""),
      StepItem(tex: r"""\begin{aligned}
a^3 + 18ab - 8b^3 + 27 &= a^3 + (-2b)^3 + 3^3 - 3a(-2b)(3) \\
&= (a - 2b + 3)(a^2 + (-2b)^2 + 3^2 - a(-2b) - (-2b)(3) - 3a) \\
&= (a - 2b + 3)(a^2 + 4b^2 + 9 + 2ab + 6b - 3a) \\
&= (a - 2b + 3)(a^2 + 4b^2 + 9 + 2ab - 3a + 6b)
\end{aligned}"""),
    ],
  ),

  // 予備問題: 4次式の因数分解（係数比較・詳細）
  MathProblem(
    id: "C66CEC49-FCD7-42E2-9FF5-628A431A8550",
    no: "op19",
    category: '因数分解',
    level: '上級',
    question: r"""x^4 - 4x^3 + 5x^2 - 4x + 1""",
    answer: r"""(x^2 - x + 1)(x^2 - 3x + 1)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""f(x) = x^4 - 4x^3 + 5x^2 - 4x + 1\text{とおいて、まずは、因数定理を用い、候補（±1）を代入して、1次式の因数を持たないことを認識したら、その後、2次式×2次式の形で係数比較を行うのが自然。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\text{因数定理の候補を代入すると、}"""),
      StepItem(tex: r"""\begin{aligned}
 f(1) &= 1 - 4 + 5 - 4 + 1 = -1 \neq 0 \\
 f(-1) &= 1 + 4 + 5 + 4 + 1 = 15 \neq 0
 \end{aligned}"""),
      StepItem(tex: r"""\text{よって、1次式の因数を持たない。よって2次式×2次式の因数分解を探す。}"""),
      StepItem(tex: r"""\text{整数係数で } f(x) = (x^2 + ax + b)(x^2 + cx + d) \text{ とおく。}"""),
      StepItem(tex: r"""\textcolor{red}{実は計算すると、下記のように計算できる。}"""),
      StepItem(tex: r"""\textcolor{red}{a = -1,\ b = 1,\ c = -3,\ d = 1}"""),
      StepItem(tex: r"""\textcolor{red}{以下ではこの証明を行う。}"""),
      StepItem(tex: r"""\textbf{【証明】}"""),
      StepItem(tex: r"""\text{ここで } x^4 - 4x^3 + 5x^2 - 4x + 1 \text{ の定数項が } 1 \text{ であることから、 } (b, d) = (-1, -1), (1, 1) \text{ の場合に分けて解を探す。}"""),
      StepItem(tex: r"""\textcolor{blue}{1. } \textcolor{blue}{(b, d) = (-1, -1)} \textcolor{blue}{の場合}"""),
      StepItem(tex: r"""\text{ } f(x) = (x^2 + ax - 1)(x^2 + cx - 1) \text{ とおくと、}"""),
      StepItem(tex: r"""\begin{aligned}
 x^4 - 4x^3 + 5x^2 - 4x + 1 &= (x^2 + ax - 1)(x^2 + cx - 1) \\
 &= x^4 + (a+c)x^3 + (ac - 2)x^2 + (-a - c)x + 1
 \end{aligned}"""),
      StepItem(tex: r"""\text{係数比較より、}"""),
      StepItem(tex: r"""
      \begin{aligned}
 &\text{3次: } a + c = -4\ \cdots (1) \\[2pt]
 &\text{2次: } ac - 2 = 5\ \ \cdots (2) \\[2pt]
 &\text{1次: } -a - c = -4\ \ \cdots (3)
 \end{aligned}"""),
      StepItem(tex: r"""\text{(3) より } -a - c = -4 \text{、すなわち } a + c = 4"""),
      StepItem(tex: r"""\textcolor{red}{しかし (1) より } a + c = -4 \text{ であるから、これは矛盾する。}"""),
      StepItem(tex: r"""\textcolor{red}{したがってこの場合は解なし。}"""),
      StepItem(tex: r"""\textcolor{blue}{2. } \textcolor{blue}{(b, d) = (1, 1)} \textcolor{blue}{の場合}"""),
      StepItem(tex: r"""\text{ } f(x) = (x^2 + ax + 1)(x^2 + cx + 1) \text{ とおくと、}"""),
      StepItem(tex: r"""\begin{aligned}
 x^4 - 4x^3 + 5x^2 - 4x + 1 &= (x^2 + ax + 1)(x^2 + cx + 1) \\
 &= x^4 + (a+c)x^3 + (ac + 2)x^2 + (a + c)x + 1
 \end{aligned}"""),
      StepItem(tex: r"""\text{係数比較より、}"""),
      StepItem(tex: r"""
      \begin{aligned}
 &\text{3次: } a + c = -4\ \cdots (1) \\[2pt]
 &\text{2次: } ac + 2 = 5\ \ \cdots (2) \\[2pt]
 &\text{1次: } a + c = -4\ \ \cdots (3)
 \end{aligned}"""),
      StepItem(tex: r"""\text{(2),(1) より } ac = 3, a + c = -4 \text{ であるから、}"""),
      StepItem(tex: r"""\text{ } (a = -1, c = -3) \text{ または } (a = -3, c = -1) \text{ を得る。}"""),
      StepItem(tex: r"""\textcolor{green}{最終的に2つの解 } (a, b, c, d) = (-1, 1, -3, 1) \text{ と } (a, b, c, d) = (-3, 1, -1, 1) \text{ が見つかったが、どちらを選んでも因数分解の結果は同じになる。}"""),
      StepItem(tex: r"""\textcolor{green}{したがって、}"""),
      StepItem(tex: r"""\textcolor{green}{\begin{aligned}
 x^4 - 4x^3 + 5x^2 - 4x + 1 &= (x^2 - x + 1)(x^2 - 3x + 1)
 \end{aligned}}"""),
    ],
  ),

  // 予備問題: 7次式の因数分解（因数定理）
  MathProblem(
    id: "B38E9107-4CB3-4966-AAA8-6966FC3F8B17",
    no: "op20",
    category: '因数分解',
    level: '上級',
    question: r"""x^7 + x^6 + x^5 + x^4 + x^3 + x^2 + x + 1""",
    answer: r"""(x + 1)(x^4 + 1)(x^2 + 1)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{因数定理を用いる。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\text{ } x = -1 \text{ を代入すると、}"""),
      StepItem(tex: r"""\begin{aligned}
 &\ \ \ \ (-1)^7 + (-1)^6 + (-1)^5 + (-1)^4 + (-1)^3 + (-1)^2 + (-1) + 1 \\
 &= -1 + 1 - 1 + 1 - 1 + 1 - 1 + 1 \\
 &= 0
 \end{aligned}"""),
      StepItem(tex: r"""\text{よって、 } x + 1 \text{ を因数にもち、下記のように分解される。}"""),
      StepItem(tex: r"""\begin{aligned}
 x^7 + x^6 + x^5 + x^4 + x^3 + x^2 + x + 1 &= (x + 1) \textcolor{blue}{(x^6 + x^4 + x^2 + 1)}
 \end{aligned}"""),
      StepItem(tex: r"""\text{次に、 } x^6 + x^4 + x^2 + 1 \text{ を因数分解する。}"""),
      StepItem(tex: r"""\begin{aligned}
 \textcolor{blue}{x^6 + x^4 + x^2 + 1} &= (x^6 + x^4) + (x^2 + 1) \\
 &= x^4(x^2 + 1) + (x^2 + 1) \\
 &= (x^4 + 1)(x^2 + 1) \\
 &= \textcolor{red}{(x^4 + 1)(x^2 + 1)}
 \end{aligned}"""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
 x^7 + x^6 + x^5 + x^4 + x^3 + x^2 + x + 1 &= (x + 1)\textcolor{red}{(x^4 + 1)}\textcolor{red}{(x^2 + 1)}
 \end{aligned}"""),
    ],
  ),

  // 予備問題: 5次式の因数分解（因数定理）
  MathProblem(
    id: "8207893B-5988-4EF1-80C7-74D75FECFE3E",
    no: "op21",
    category: '因数分解',
    level: '上級',
    question: r"""x^5 + x^4 + 1""",
    answer: r"""(x^2 + x + 1)(x^3 - x + 1)""",
    imageAsset: '',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""f(x) = x^5+x^4 +1\text{とおいて、まずは、因数定理を用い、候補（±1）を代入して、1次式の因数を持たないことを認識したら、その後、2次式×3次式の形で係数比較を行うのが自然。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\text{因数定理の候補を代入すると、}"""),
      StepItem(tex: r"""\begin{aligned}
 f(1) &= 1 + 1 + 1 = 3 \neq 0 \\
 f(-1) &= -1 + 1 + 1 = 1 \neq 0
 \end{aligned}"""),
      StepItem(tex: r"""\text{よって、1次式の因数を持たない。よって2次式×3次式の因数分解を探す。}"""),
      StepItem(tex: r"""\text{整数係数で } f(x) = (x^2 + ax + \alpha)(x^3 + bx^2 + cx + \beta) \text{ とおく。}"""),
      StepItem(tex: r"""\textcolor{red}{実は計算すると、下記のように計算できる。}"""),
      StepItem(tex: r"""\textcolor{red}{a = 1,\ b = 0,\ c = -1,\ \alpha = 1,\ \beta = 1}"""),
      StepItem(tex: r"""\textcolor{red}{以下ではこの証明を行う。}"""),
      StepItem(tex: r"""\textbf{【証明】}"""),
      StepItem(tex: r"""\text{ここで } x^5 + x^4 + 1 \text{ の定数項が } 1 \text{ であることから、 } \alpha\beta = 1 \text{ であるため、 } (\alpha, \beta) = (1, 1), (-1, -1) \text{ の場合に分けて解を探す。}"""),
      StepItem(tex: r"""\textcolor{blue}{1. } \textcolor{blue}{(\alpha, \beta) = (1, 1)} \textcolor{blue}{の場合}"""),
      StepItem(tex: r"""\text{ } f(x) = (x^2 + ax + 1)(x^3 + bx^2 + cx + 1) \text{ とおくと、}"""),
      StepItem(tex: r"""\begin{aligned}
 &\ \ \ \ x^5 + x^4 + 1 \\
 &= (x^2 + ax + 1)(x^3 + bx^2 + cx + 1) \\
 &= x^5 + (a+b)x^4 + (ab + c + 1)x^3 + (ac + b + 1)x^2 + (a + c)x + 1
 \end{aligned}"""),
      StepItem(tex: r"""\text{係数比較より、}"""),
      StepItem(tex: r"""
      \begin{aligned}
 &\text{4次: } a + b = 1\ \cdots (1) \\[2pt]
 &\text{3次: } ab + c + 1 = 0\ \ \cdots (2) \\[2pt]
 &\text{2次: } ac + b + 1 = 0\ \ \cdots (3) \\[2pt]
 &\text{1次: } a + c = 0\ \ \cdots (4)
 \end{aligned}"""),
      StepItem(tex: r"""\text{(4),(1) より } c = -a, b = 1 - a \text{これを(2)に代入して、}"""),
      StepItem(tex: r"""a(1 - a) - a + 1 = a - a^2 - a + 1 = -a^2 + 1 = 0 \text{、すなわち } a^2 = 1"""),
      StepItem(tex: r"""\text{これより } a = 1 \text{ または } a = -1 \text{ を得る。}"""),
      StepItem(tex: r"""\textcolor{blue}{(i) } \textcolor{blue}{a = 1 のとき}"""),
      StepItem(tex: r"""\text{ } b = 0, c = -1 \text{、このとき (3) より、}"""),
      StepItem(tex: r"""\begin{aligned}
 ac + b + 1 &= 1 \cdot (-1) + 0 + 1 = 0
 \end{aligned}"""),
      StepItem(tex: r"""\text{であるので、(3)を満たし、(1),(2),(3),(4)の連立方程式の解は}"""),
      StepItem(tex: r"""\textcolor{green}{\begin{aligned}
 a = 1, \quad b = 0, \quad c = -1
 \end{aligned}}"""),
      StepItem(tex: r"""\textcolor{green}{したがって、} \textcolor{green}{(a, b, c, \alpha, \beta) = (1, 0, -1, 1, 1)}\textcolor{green}{となり、答えは}"""),
      StepItem(tex: r"""\textcolor{green}{ x^5 + x^4 + 1 = (x^2 + x + 1)(x^3 - x + 1) }"""),
      StepItem(tex: r"""\textcolor{brown}{\large{これで答えは得られたが、一応、}}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{他に解がないことを下記で確認しておく。}}"""),
      StepItem(tex: r"""\textcolor{blue}{(ii) } \textcolor{blue}{a = -1 のとき}"""),
      StepItem(tex: r"""\text{ } b = 2, c = 1 \text{、このとき (3) より、}"""),
      StepItem(tex: r"""\begin{aligned}
 ac + b + 1 &= (-1) \cdot 1 + 2 + 1 = 2 \neq 0
 \end{aligned}"""),
      StepItem(tex: r"""\textcolor{red}{したがってこの場合は(3)を満たさない。}"""),
      StepItem(tex: r"""\textcolor{blue}{2. } \textcolor{blue}{(\alpha, \beta) = (-1, -1)} \textcolor{blue}{の場合}"""),
      StepItem(tex: r"""\text{ } f(x) = (x^2 + ax - 1)(x^3 + bx^2 + cx - 1) \text{ とおくと、}"""),
      StepItem(tex: r"""\begin{aligned}
 &\ \ \ \ x^5 + x^4 + 1 \\
 &= (x^2 + ax - 1)(x^3 + bx^2 + cx - 1) \\
 &= x^5 + (a+b)x^4 + (ab + c - 1)x^3 + (ac - b - 1)x^2 + (a + c)x + 1
 \end{aligned}"""),
      StepItem(tex: r"""\text{係数比較より、}"""),
      StepItem(tex: r"""
      \begin{aligned}
 &\text{4次: } a + b = 1\ \cdots (1) \\[2pt]
 &\text{3次: } ab + c - 1 = 0\ \ \cdots (2) \\[2pt]
 &\text{2次: } ac - b - 1 = 0\ \ \cdots (3) \\[2pt]
 &\text{1次: } a + c = 0\ \ \cdots (4)
 \end{aligned}"""),
      StepItem(tex: r"""\text{(4),(1) より } c = -a, b = 1 - a \text{これを(2)に代入して、}"""),
      StepItem(tex: r"""\text{(2) より } a(1 - a) - a - 1 = a - a^2 - a - 1 = -a^2 - 1 = 0 \text{、すなわち } a^2 = -1"""),
      StepItem(tex: r"""\textcolor{red}{これは実数解を持たない。}"""),
    ],
  ),
];
