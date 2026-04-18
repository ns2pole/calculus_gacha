import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// ============================================================================
/// 漸化式問題
/// ============================================================================

const sequenceProblems = <MathProblem>[

  // ────────────────────────────────
  // 問題 1: 1階線形漸化式（基本形）
  // ────────────────────────────────
  MathProblem(
    id: "7D0760FF-946D-469A-842D-60D426A01724",
    no: 1,
    category: '漸化式',
    level: '初級',
    question: r"""a_{n+1} = 2a_n + 3, \quad a_1 = 1""",
    answer: r"""a_n = 2^{n+1} - 3""",
    imageAsset: 'assets/graphs/sequences/problem_1.png',
    equation: r"""a_{n+1} = 2a_n + 3""",
    conditions: r"""a_1 = 1""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{右辺が定数なので解の一つを定数列} A \text{ の形で求め、これを使ってただの等比数列の式に帰着させる。}"""),
      StepItem(tex: r"""\textbf{【解法】}"""),
      StepItem(tex: r"""\text{解の形を定数列}A \text{と仮定して、元の漸化式に代入すると、} A = 2A + 3 \text{ である。}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ A = 2A + 3 \\
    &\Leftrightarrow A = -3
    \end{aligned}"""),
      StepItem(tex: r"""\text{解 } A = -3 \text{ を元の漸化式に代入すると、} -3 = 2 \cdot (-3) + 3 \cdots (1) \text{ である。}"""),
      StepItem(tex: r"""\text{ここで、元の漸化式から(1)を引いて、新たな数列}b_n = a_n + 3\text{ を定義すると、等比数列の形に帰着させることができる。実際、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      a_{n+1} &= 2a_n + 3 \\
      -3 &= 2 \cdot (-3) + 3 \\
      \hline
      \ \ \ \ \ a_{n+1} - (-3) &= 2a_n + 3 - (2 \cdot (-3) + 3) \\
      \Leftrightarrow a_{n+1} + 3 &= 2a_n + 3 - (-6 + 3) \\
      \Leftrightarrow a_{n+1} + 3 &= 2(a_n + 3)
      \end{aligned}
      """),
      StepItem(tex: r"""\text{よって、 } b_n  = a_n + 3 \text{ とおくと、}"""),
      StepItem(tex: r"""\begin{aligned}
      \begin{cases}
    \ b_{n+1} = 2b_n \\
    \ b_1 = a_1 + 3 = 4
    \end{cases}
    \end{aligned}"""),
    StepItem(tex: r"""\text{上の漸化式は等比数列の形で、} b_n = 4 \cdot 2^{n-1} = 2^{n+1} \text{ なので、}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ a_n = b_n - 3 \\
    &\Leftrightarrow a_n = 2^{n+1} - 3
    \end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 2: 1階線形漸化式（係数あり）
  // ────────────────────────────────
  MathProblem(
    id: "3F26B444-EA86-4FF8-830B-2AC464BDE3E6",
    no: 2,
    category: '漸化式',
    level: '初級',
    question: r"""a_{n+1} = 3a_n - 4, \quad a_1 = 1""",
    answer: r"""a_n = - 3^{n-1} + 2 """,
    imageAsset: 'assets/graphs/sequences/problem_2.png',
    equation: r"""a_{n+1} = 3a_n - 4""",
    conditions: r"""a_1 = 1""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{右辺が定数なので解の一つを定数列} A \text{ の形で求め、これを使ってただの等比数列の式に帰着させる。}"""),
      StepItem(tex: r"""\textbf{【解法】}"""),
      StepItem(tex: r"""\text{解の形を}A \text{と仮定して、元の漸化式に代入すると、} A = 3A - 4 \text{ である。}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ A = 3A - 4 \\
    &\Leftrightarrow A = 2
    \end{aligned}"""),
      StepItem(tex: r"""\text{定数解 } A = 2 \text{ を元の漸化式に代入すると、} 2 = 3 \cdot 2 - 4 \cdots (1) \text{ である。}"""),
      StepItem(tex: r"""\text{ここで、元の漸化式から(1)を引いて、新たな数列}b_n = a_n - 2\text{ を定義すると、等比数列の形に帰着させることができる。実際、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      a_{n+1} &= 3a_n - 4 \\
      2 &= 3 \cdot 2 - 4 \\
      \hline
      \ \ \ \ \ a_{n+1} - 2 &= 3a_n - 4 - (3 \cdot 2 - 4) \\
      \Leftrightarrow a_{n+1} - 2 &= 3a_n - 4 - 2 \\
      \Leftrightarrow a_{n+1} - 2 &= 3(a_n - 2)
      \end{aligned}
      """),
      StepItem(tex: r"""\text{ } b_n = a_n - 2 \text{ とおくと、}"""),
      StepItem(tex: r"""\text{ } b_1 = a_1 - 2 = 1 - 2 = -1 \text{ だから、}"""),
      StepItem(tex: r"""\begin{aligned}
    \begin{cases}
    \ b_{n+1} = 3b_n \\
    \ b_1 = -1
    \end{cases}
    \end{aligned}"""),
    StepItem(tex: r"""\text{上の漸化式は等比数列の形で、} b_n = -1 \cdot 3^{n-1} = -3^{n-1} \text{ なので、}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ a_n = b_n + 2 \\
    &\Leftrightarrow a_n = -3^{n-1} + 2
    \end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 3: 1階線形漸化式（非斉次項：1次式）
  // ────────────────────────────────
  MathProblem(
    id: "0E10892B-45E0-4994-9281-EDB35CE38498",
    no: 3,
    category: '漸化式',
    level: '中級',
    question: r"""a_{n+1} = 2a_n + n + 1, \quad a_1 = 1""",
    answer: r"""a_n = 2^{n+1} - n - 2""",
    imageAsset: 'assets/graphs/sequences/problem_3.png',
    equation: r"""a_{n+1} = 2a_n + n + 1""",
    conditions: r"""a_1 = 1""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{右辺が1次式なので解の一つを1次関数}  An + B \text{ の形で求め、これを使ってただの等比数列の式に帰着させる。}"""),
      StepItem(tex: r"""\textbf{【解法】}"""),
      StepItem(tex: r"""\text{解の形を} An + B \text{と仮定して、元の漸化式に代入すると、}"""),
      StepItem(tex: r"""\begin{aligned}
    \ \ \ \ \ A(n+1) + B &= 2(An + B) + n + 1 \\
    \Leftrightarrow An + A + B &= 2An + 2B + n + 1 \\
    \Leftrightarrow An + A + B &= (2A + 1)n + 2B + 1
    \end{aligned}"""),
      StepItem(tex: r"""\text{係数を比較すると、} A = 2A + 1, \ A + B = 2B + 1 \text{ より、} A = -1, \ B = -2 \text{ である。}"""),
      StepItem(tex: r"""\text{よって、解の一つは } -n - 2 \text{ である。}"""),
      StepItem(tex: r"""\text{求まった解を元の漸化式に代入すると、} -(n+1) - 2 = 2(-n - 2) + n + 1 \cdots (1) \text{ である。}"""),
      StepItem(tex: r"""\text{ここで、元の漸化式から(1)を引いて、新たな数列}b_n = a_n + n + 2\text{ を定義すると、等比数列の形に帰着させることができる。実際、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      a_{n+1} &= 2a_n + n + 1 \\
      -(n+1) - 2 &= 2(-n - 2) + n + 1 \\
      \hline
      \ \ \ \ \ a_{n+1} - (-(n+1) - 2) &= 2a_n + n + 1 - (2(-n - 2) + n + 1) \\
      \Leftrightarrow a_{n+1} + (n+1) + 2 &= 2a_n + n + 1 - 2(-n - 2) - n - 1 \\
      \Leftrightarrow a_{n+1} + (n+1) + 2 &= 2(a_n + n + 2)
      \end{aligned}
      """),
      StepItem(tex: r"""\text{ } b_n = a_n + n + 2 \text{ とおくと、} b_{n+1} = 2b_n \text{ である。}"""),
      StepItem(tex: r"""\text{ } a_1 = 1 \text{ より、} b_1 = a_1 + 1 + 2 = 1 + 1 + 2 = 4 \text{ だから、}"""),
      StepItem(tex: r"""\begin{aligned}
    \begin{cases}
    \ b_{n+1} = 2b_n \\
    \ b_1 = 4
    \end{cases}
    \end{aligned}"""),
      StepItem(tex: r"""\text{上の漸化式は等比数列の形で、} b_n = 4 \cdot 2^{n-1} = 2^{n+1} \text{ なので、}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ a_n = b_n - n - 2 \\
    &\Leftrightarrow a_n = 2^{n+1} - n - 2
    \end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 4: 1階線形漸化式（非斉次項：2次式）
  // ────────────────────────────────
  MathProblem(
    id: "98C763E5-86DB-47A3-B2EF-D070244EC978",
    no: 4,
    category: '漸化式',
    level: '初級',
    question: r"""a_{n+1} = 2a_n + n^2 + 1, \quad a_1 = 1""",
    answer: r"""a_n = 2^{n+2} - n^2 - 2n - 4""",
    imageAsset: 'assets/graphs/sequences/problem_4.png',
    equation: r"""a_{n+1} = 2a_n + n^2 + 1""",
    conditions: r"""a_1 = 1""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{右辺が2次式なので解の一つを} An^2 + Bn + C \text{ の形で求め、これを使ってただの等比数列の式に帰着させる。}"""),
      StepItem(tex: r"""\textbf{【解法】}"""),
      StepItem(tex: r"""\text{解の形を} An^2 + Bn + C \text{と仮定して、元の漸化式に代入すると、}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ A(n+1)^2 + B(n+1) + C = 2(An^2 + Bn + C) + n^2 + 1 \\
    &\Leftrightarrow A(n^2 + 2n + 1) + Bn + B + C = 2An^2 + 2Bn + 2C + n^2 + 1 \\
    &\Leftrightarrow An^2 + 2An + A + Bn + B + C = (2A + 1)n^2 + 2Bn + 2C + 1
    \end{aligned}"""),
      StepItem(tex: r"""\text{係数を比較すると、}"""),
      StepItem(tex: r"""\begin{aligned}
    &\begin{cases}
    A = 2A + 1 \\
    2A + B = 2B \\
    A + B + C = 2C + 1
    \end{cases} \\
    &\Leftrightarrow \begin{cases}
    A = -1 \\
    B = -2 \\
    C = -4
    \end{cases}
    \end{aligned}"""),
      StepItem(tex: r"""\text{よって、解の一つは} \textcolor{green}{-n^2 - 2n - 4} \text{である。}"""),
      StepItem(tex: r"""\text{求まった解を元の漸化式に代入すると、} -(n+1)^2 - 2(n+1) - 4 = 2(-n^2 - 2n - 4) + n^2 + 1 \cdots (1) \text{ である。}"""),
      StepItem(tex: r"""\text{ここで、元の漸化式から(1)を引いて、新たな数列}b_n = a_n + n^2 + 2n + 4\text{ を定義すると、等比数列の形に帰着させることができる。実際、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      a_{n+1} &= 2a_n + n^2 + 1 \\
      -(n+1)^2 - 2(n+1) - 4 &= 2(-n^2 - 2n - 4) + n^2 + 1 \\
      \hline
      \ \ \ \ \ a_{n+1} - (-(n+1)^2 - 2(n+1) - 4) &= 2a_n + n^2 + 1 - (2(-n^2 - 2n - 4) + n^2 + 1) \\
      \Leftrightarrow a_{n+1} + (n+1)^2 + 2(n+1) + 4 &= 2a_n + n^2 + 1 - 2(-n^2 - 2n - 4) - n^2 - 1 \\
      \Leftrightarrow a_{n+1} + (n+1)^2 + 2(n+1) + 4 &= 2(a_n + n^2 + 2n + 4)
      \end{aligned}
      """),
      StepItem(tex: r"""\text{ } b_n = a_n + n^2 + 2n + 4 \text{ とおくと、} b_{n+1} = 2b_n \text{ である。}"""),
      StepItem(tex: r"""\text{ } a_1 = 1 \text{ より、} b_1 = a_1 + 1^2 + 2 \cdot 1 + 4 = 1 + 1 + 2 + 4 = 8 \text{ だから、}"""),
      StepItem(tex: r"""\begin{aligned}
    \begin{cases}
    \ b_{n+1} = 2b_n \\
    \ b_1 = 8
    \end{cases}
    \end{aligned}"""),
      StepItem(tex: r"""\text{上の漸化式は等比数列の形で、} b_n = 8 \cdot 2^{n-1} = 2^{n+2} \text{ なので、}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ a_n = b_n - n^2 - 2n - 4 \\
    &\Leftrightarrow a_n = 2^{n+2} - n^2 - 2n - 4 \\
    \end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 5: 1階線形漸化式（非斉次項：指数関数）
  // ────────────────────────────────
  MathProblem(
    id: "9F9BF526-C923-4508-A690-C5E04D27A79E",
    no: 5,
    category: '漸化式',
    level: '中級',
    question: r"""a_{n+1} = 2a_n + 3^n, \quad a_1 = 1""",
    answer: r"""a_n = 3^n - 2^n""",
    imageAsset: 'assets/graphs/sequences/problem_5.png',
    equation: r"""a_{n+1} = 2a_n + 3^n""",
    conditions: r"""a_1 = 1""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{右辺が指数関数なので解の一つを指数関数} A \cdot 3^{n} \text{ の形で求め、これを使ってただの等比数列の式に帰着させる。}"""),
      StepItem(tex: r"""\textbf{【解法】}"""),
      StepItem(tex: r"""\text{解の形を}A \cdot 3^n \text{と仮定して、元の漸化式に代入すると、} A \cdot 3^n = 2 \cdot A \cdot 3^{n-1} + 3^n \text{ である。}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ A \cdot 3^n = 2 \cdot A \cdot 3^{n-1} + 3^n \\
    &\Leftrightarrow A \cdot 3^n = \displaystyle \frac{2A}{3} \cdot 3^n + 3^n \\
    &\Leftrightarrow A = \displaystyle \frac{2A}{3} + 1 \\
    &\Leftrightarrow 3A = 2A + 3 \\
    &\Leftrightarrow A = 3
    \end{aligned}"""),
      StepItem(tex: r"""\text{よって、一つの解は }  3 \cdot 3^{n-1} = 3^n \text{ である。}"""),
      StepItem(tex: r"""\text{求まった解を元の漸化式に代入すると、} 3^{n+1} = 2 \cdot 3^n + 3^n \cdots (1) \text{ である。}"""),
      StepItem(tex: r"""\text{ここで、元の漸化式から(1)を引いて、新たな数列}b_n = a_n - 3^n\text{ を定義すると、等比数列の形に帰着させることができる。実際、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      a_{n+1} &= 2a_n + 3^n \\
      3^{n+1} &= 2 \cdot 3^n + 3^n \\
      \hline
      \ \ \ \ \ a_{n+1} - 3^{n+1} &= 2a_n + 3^n - (2 \cdot 3^n + 3^n) \\
      \Leftrightarrow a_{n+1} - 3^{n+1} &= 2a_n + 3^n - 2 \cdot 3^n - 3^n \\
      \Leftrightarrow a_{n+1} - 3^{n+1} &= 2(a_n - 3^n)
      \end{aligned}
      """),
      StepItem(tex: r"""\text{ } b_n = a_n - 3^n \text{ とおくと、} b_{n+1} = 2b_n, \ b_1 = a_1 - 3^1 = 1 - 3 = -2 \text{ だから、}"""),
      StepItem(tex: r"""\begin{aligned}
        \begin{cases}
         b_{n+1} = 2b_n \\
          b_1 = = -2 
          \end{cases}
          \end{aligned}
          """),
      StepItem(tex: r"""\text{上の漸化式は等比数列の形で、} b_n = -2 \cdot 2^{n-1} = -2^n \text{ なので、}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ a_n = b_n + 3^n \\
    &\Leftrightarrow a_n = -2^n + 3^n \\
    &\Leftrightarrow a_n = 3^n - 2^n
    \end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 6: 分数型漸化式
  // ────────────────────────────────
  MathProblem(
    id: "BE1669B0-E7C4-4855-B98E-2F2AE53B7981",
    no: 6,
    category: '漸化式',
    level: '初級',
    question: r"""a_{n+1} = \displaystyle \frac{a_n}{a_n + 1}, \quad a_1 = 1""",
    answer: r"""a_n = \displaystyle \frac{1}{n}""",
    imageAsset: 'assets/graphs/sequences/problem_6.png',
    equation: r"""a_{n+1} = \displaystyle \frac{a_n}{a_n + 1}""",
    conditions: r"""a_1 = 1""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{逆数を取る。}"""),
      StepItem(tex: r"""\textbf{【解法】}"""),
      StepItem(tex: r"""\text{両辺の逆数を取ると、}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ \displaystyle \frac{1}{a_{n+1}} = \displaystyle \frac{a_n + 1}{a_n} \\
    &\Leftrightarrow \displaystyle \frac{1}{a_{n+1}} = 1 + \displaystyle \frac{1}{a_n}
    \end{aligned}"""),
      StepItem(tex: r"""\text{ } b_n = \displaystyle \frac{1}{a_n} \text{ とおくと、} b_{n+1} = b_n + 1, \ b_1 = \displaystyle \frac{1}{a_1} = 1 \text{ である。}"""),
      StepItem(tex: r"""\text{よって、} b_n = 1 + (n-1) \cdot 1 = n \text{ なので、}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ a_n = \displaystyle \frac{1}{b_n} \\
    &\Leftrightarrow a_n = \displaystyle \frac{1}{n}
    \end{aligned}"""),
    ],
  ),

  // // ────────────────────────────────
  // // 問題 7: 分数型漸化式（2次分数型）
  // // ────────────────────────────────
  MathProblem(
    id: "8CF61D01-3229-4ABF-BC3F-46A7681BBFEF",
    no: 7,
    category: '漸化式',
    level: '上級',
    question: r"""a_{n+1} = \displaystyle \frac{4a_n + 3}{a_n + 2}, \quad a_1 = 2""",
    answer: r"""a_n = 3 - \displaystyle \frac{4}{3 \cdot 5^{n-1} + 1}""",
    imageAsset: 'assets/graphs/sequences/problem_7.png',
    equation: r"""a_{n+1} = \displaystyle \frac{4a_n + 3}{a_n + 2}""",
    conditions: r"""a_1 = 2""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{定数解を } A \text{ の形で求め、これを使ってただの等比数列の式に帰着させる。}"""),
      StepItem(tex: r"""\textbf{【解法】}"""),
      StepItem(tex: r"""\text{解の形を}A \text{と仮定して、元の漸化式に代入すると、} A = \displaystyle \frac{4A + 3}{A + 2} \text{ である。}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ \ A(A + 2) = 4A + 3 \\
    &\Leftrightarrow A^2 + 2A = 4A + 3 \\
    &\Leftrightarrow A^2 - 2A - 3 = 0 \\
    &\Leftrightarrow (A - 3)(A + 1) = 0
    \end{aligned}"""),
      StepItem(tex: r"""\text{よって、定数解は } A = 3 \text{ または } A = -1 \text{ である。}"""),
      StepItem(tex: r"""\text{一つの解 } A = 3 \text{ を選んで、元の漸化式に代入すると、} 3 = \displaystyle \frac{4 \cdot 3 + 3}{3 + 2} \cdots (1) \text{ である。}"""),
      StepItem(tex: r"""\text{ここで命題1より、新たな数列}b_n = a_n - 3 \text{ を定義すると、分子の定数をなくした形に帰着させられる事が分かる。実際、元の漸化式から(1)を引いて、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      a_{n+1} &= \displaystyle \frac{4a_n + 3}{a_n + 2}  \\
      3 &= \displaystyle \frac{4 \cdot 3 + 3}{3 + 2} \cdots (1) \\
      \hline
      \ \ \ \ \ a_{n+1} - 3 &= \displaystyle \frac{4a_n + 3}{a_n + 2} - \displaystyle \frac{4 \cdot 3 + 3}{3 + 2} \\
      \Leftrightarrow a_{n+1} - 3 &= \displaystyle \frac{4a_n + 3}{a_n + 2} - 3 \\
      \Leftrightarrow a_{n+1} - 3 &= \displaystyle \frac{4a_n + 3 - 3(a_n + 2)}{a_n + 2} \\
      \Leftrightarrow a_{n+1} - 3 &= \displaystyle \frac{4a_n + 3 - 3a_n - 6}{a_n + 2} \\
      \Leftrightarrow a_{n+1} - 3 &= \displaystyle \frac{a_n - 3}{a_n + 2}
      \end{aligned}
      """),
      StepItem(tex: r"""\text{ } b_n = a_n - 3 \text{ とおくと、} b_1 = a_1 - 3 = 2 - 3 = -1,\text{であり、}a_n = b_n + 3 \text{ である。これを代入すると、}"""),
      StepItem(tex: r"""\begin{aligned}
    b_{n+1} &= \displaystyle \frac{b_n + 3 - 3}{b_n + 3 + 2} \\
    &= \displaystyle \frac{b_n}{b_n + 5}
    \end{aligned}"""),
      StepItem(tex: r"""\text{両辺の逆数を取ると、}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ \displaystyle \frac{1}{b_{n+1}} = \displaystyle \frac{b_n + 5}{b_n} \\
    &\Leftrightarrow \displaystyle \frac{1}{b_{n+1}} = 1 + \displaystyle \frac{5}{b_n}
    \end{aligned}"""),
      StepItem(tex: r"""\text{ } c_n = \displaystyle \frac{1}{b_n} \text{ とおくと、} c_{n+1} = 1 + 5c_n, c_1 = \frac 1 {b_1} = \frac 1 {-1} = -1  \text{ である。これを解くと、} c_n = -\displaystyle \frac{3 \cdot 5^{n-1} + 1}{4}"""),
      StepItem(tex: r"""\text{よって、}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ b_n = \displaystyle \frac{1}{c_n} \\
    &\Leftrightarrow b_n = -\displaystyle \frac{4}{3 \cdot 5^{n-1} + 1}
    \end{aligned}"""),
    StepItem(tex: r"""\text{ここから、} a_n = b_n + 3 \text{ より、}a_n\text{を求めると、}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ a_n = b_n + 3 \\
    &\Leftrightarrow a_n = 3 - \displaystyle \frac{4}{3 \cdot 5^{n-1} + 1}
    \end{aligned}"""),
      StepItem(tex: r"""\textbf{【命題1】}"""),
      StepItem(tex: r"""\text{分数型の漸化式 } a_{n+1} = \displaystyle \frac{pa_n + q}{ra_n + s} \text{ が与えられたとき、定数解 } A \text{ を } A = \displaystyle \frac{pA + q}{rA + s} \text{ を満たすものとする。}"""),
      StepItem(tex: r"""\text{このとき、} b_n = a_n - A \text{ とおくと、} b_{n+1} = \displaystyle \frac{(p - rA)b_n}{rb_n + rA + s} \text{ となり、分子の定数項がない漸化式に帰着する。}"""),
      StepItem(tex: r"""\textbf{【証明】}"""),
      StepItem(tex: r"""\text{定数解 } A \text{ は } A = \displaystyle \frac{pA + q}{rA + s} \text{ を満たすとする。両辺に } rA + s \text{ をかけると、}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ A(rA + s) = pA + q \\
    &\Leftrightarrow rA^2 + sA = pA + q \\
    &\Leftrightarrow rA^2 + (s - p)A - q = 0 \\
    &\Leftrightarrow rA^2 + (s - p)A - q = 0 \cdots (1)
    \end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} b_n = a_n - A \text{ とおくと、} a_n = b_n + A \text{ である。これを元の漸化式に代入すると、}"""),
      StepItem(tex: r"""\begin{aligned}
    b_{n+1} + A &= \displaystyle \frac{p(b_n + A) + q}{r(b_n + A) + s} \\
    &= \displaystyle \frac{pb_n + pA + q}{rb_n + rA + s}
    \end{aligned}"""),
      StepItem(tex: r"""\begin{aligned}
    b_{n+1} &= \displaystyle \frac{pb_n + pA + q}{rb_n + rA + s} - A \\
    &= \displaystyle \frac{pb_n + pA + q - A(rb_n + rA + s)}{rb_n + rA + s} \\
    &= \displaystyle \frac{pb_n  - rAb_n - (rA^2 + (s-p)A - q) }{rb_n + rA + s} \\
    \end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} A\text{は、(1)を満たし、分子の}rA^2 + (s-p)A - q\text{は0であるから、}"""),
      StepItem(tex: r"""\begin{aligned}
      &=\displaystyle \frac{pb_n  - rAb_n}{rb_n + rA + s} \\
      &= \displaystyle \frac{(p - rA)b_n}{rb_n + rA + s} \\
    \end{aligned}"""),
    StepItem(tex: r"""\text{よって、} b_{n+1} = \displaystyle \frac{(p - rA)b_n}{rb_n + rA + s} \text{ となり、分子の定数項がない漸化式に帰着し、命題が示された。}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 8: 分数型漸化式（2次分数型）
  // ────────────────────────────────
  MathProblem(
    id: "A8B9C0D1-2E3F-4A5B-6C7D-8E9F0A1B2C3",
    no: 8,
    category: '漸化式',
    level: '上級',
    question: r"""a_{n+1} = \displaystyle \frac{a_n - 9}{a_n - 5}, \quad a_1 = 2""",
    answer: r"""a_n = \displaystyle \frac{3n + 1}{n+1}""",
    imageAsset: 'assets/graphs/sequences/problem_8.png',
    equation: r"""a_{n+1} = \displaystyle \frac{a_n - 9}{a_n - 5}""",
    conditions: r"""a_1 = 2""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{定数解を } A \text{ の形で求め、これを使ってただの等比数列の式に帰着させる。}"""),
      StepItem(tex: r"""\textbf{【解法】}"""),
      StepItem(tex: r"""\text{解の形を}A \text{と仮定して、元の漸化式に代入すると、} A = \displaystyle \frac{A - 9}{A - 5} \text{ である。}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ A(A - 5) = A - 9 \\
    &\Leftrightarrow A^2 - 5A = A - 9 \\
    &\Leftrightarrow A^2 - 6A + 9 = 0 \\
    &\Leftrightarrow (A - 3)^2 = 0 \\
    &\Leftrightarrow A = 3
    \end{aligned}"""),
      StepItem(tex: r"""\text{解 } A = 3 \text{ を選んで、元の漸化式に代入すると、} 3 = \displaystyle \frac{3 - 9}{3 - 5} \cdots (1) \text{ である。}"""),
      StepItem(tex: r"""\text{ここで命題1より、新たな数列}b_n = a_n - 3 \text{ を定義すると、分子の定数をなくした形に帰着させられる事が分かる。実際、元の漸化式から(1)を引いて、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      a_{n+1} &= \displaystyle \frac{a_n - 9}{a_n - 5}  \\
      3 &= \displaystyle \frac{3 - 9}{3 - 5} \cdots (1) \\
      \hline
      \ \ \ \ \ a_{n+1} - 3 &= \displaystyle \frac{a_n - 9}{a_n - 5} - \displaystyle \frac{3 - 9}{3 - 5} \\
      \Leftrightarrow a_{n+1} - 3 &= \displaystyle \frac{a_n - 9}{a_n - 5} - 3 \\
      \Leftrightarrow a_{n+1} - 3 &= \displaystyle \frac{a_n - 9 - 3(a_n - 5)}{a_n - 5} \\
      \Leftrightarrow a_{n+1} - 3 &= \displaystyle \frac{a_n - 9 - 3a_n + 15}{a_n - 5} \\
      \Leftrightarrow a_{n+1} - 3 &= \displaystyle \frac{-2a_n + 6}{a_n - 5} \\
      \Leftrightarrow a_{n+1} - 3 &= \displaystyle \frac{-2(a_n - 3)}{a_n - 5}
      \end{aligned}
      """),
      StepItem(tex: r"""\text{ } b_n = a_n - 3 \text{ とおくと、} b_1 = a_1 - 3 = 2 - 3 = -1,\text{であり、}a_n = b_n + 3 \text{ である。これを代入すると、}"""),
      StepItem(tex: r"""\begin{aligned}
    b_{n+1} &= \displaystyle \frac{-2(b_n + 3 - 3)}{b_n + 3 - 5} \\
    &= \displaystyle \frac{-2b_n}{b_n - 2}
    \end{aligned}"""),
      StepItem(tex: r"""\text{両辺の逆数を取ると、}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ \displaystyle \frac{1}{b_{n+1}} = \displaystyle \frac{b_n - 2}{-2b_n} \\
    &\Leftrightarrow \displaystyle \frac{1}{b_{n+1}} = -\displaystyle \frac{1}{2} + \displaystyle \frac{1}{b_n}
    \end{aligned}"""),
      StepItem(tex: r"""\text{ } c_n = \displaystyle \frac{1}{b_n} \text{ とおくと、} c_{n+1} = -\displaystyle \frac{1}{2} + c_n, c_1 = \frac{1}{b_1} = \frac{1}{-1} = -1 \text{ である。}"""),
      StepItem(tex: r"""\text{これを解くと、} c_n = -1 + (n-1) \cdot \left(-\displaystyle \frac{1}{2}\right) = -\displaystyle \frac{n+1}{2}"""),
      StepItem(tex: r"""\text{よって、}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ b_n = \displaystyle \frac{1}{c_n} \\
    &\Leftrightarrow b_n = -\displaystyle \frac{2}{n+1}
    \end{aligned}"""),
    StepItem(tex: r"""\text{ここから、} a_n = b_n + 3 \text{ より、}a_n\text{を求めると、}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ a_n = b_n + 3 \\
    &\Leftrightarrow a_n = 3 - \displaystyle \frac{2}{n+1} \\
    &\Leftrightarrow a_n = \displaystyle \frac{3(n+1) - 2}{n+1} \\
    &\Leftrightarrow a_n = \displaystyle \frac{3n + 1}{n+1}
    \end{aligned}"""),
      StepItem(tex: r"""\textbf{【命題1】}"""),
      StepItem(tex: r"""\text{分数型の漸化式 } a_{n+1} = \displaystyle \frac{pa_n + q}{ra_n + s} \text{ が与えられたとき、定数解 } A \text{ を } A = \displaystyle \frac{pA + q}{rA + s} \text{ を満たすものとする。}"""),
      StepItem(tex: r"""\text{このとき、} b_n = a_n - A \text{ とおくと、} b_{n+1} = \displaystyle \frac{(p - rA)b_n}{rb_n + rA + s} \text{ となり、分子の定数項がない漸化式に帰着する。}"""),
      StepItem(tex: r"""\textbf{【証明】}"""),
      StepItem(tex: r"""\text{定数解 } A \text{ は } A = \displaystyle \frac{pA + q}{rA + s} \text{ を満たすとする。両辺に } rA + s \text{ をかけると、}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ A(rA + s) = pA + q \\
    &\Leftrightarrow rA^2 + sA = pA + q \\
    &\Leftrightarrow rA^2 + (s - p)A - q = 0 \\
    &\Leftrightarrow rA^2 + (s - p)A - q = 0 \cdots (1)
    \end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} b_n = a_n - A \text{ とおくと、} a_n = b_n + A \text{ である。これを元の漸化式に代入すると、}"""),
      StepItem(tex: r"""\begin{aligned}
    b_{n+1} + A &= \displaystyle \frac{p(b_n + A) + q}{r(b_n + A) + s} \\
    &= \displaystyle \frac{pb_n + pA + q}{rb_n + rA + s}
    \end{aligned}"""),
      StepItem(tex: r"""\begin{aligned}
    b_{n+1} &= \displaystyle \frac{pb_n + pA + q}{rb_n + rA + s} - A \\
    &= \displaystyle \frac{pb_n + pA + q - A(rb_n + rA + s)}{rb_n + rA + s} \\
    &= \displaystyle \frac{pb_n  - rAb_n - (rA^2 + (s-p)A - q) }{rb_n + rA + s} \\
    \end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} A\text{は、(1)を満たし、分子の}rA^2 + (s-p)A - q\text{は0であるから、}"""),
      StepItem(tex: r"""\begin{aligned}
      &=\displaystyle \frac{pb_n  - rAb_n}{rb_n + rA + s} \\
      &= \displaystyle \frac{(p - rA)b_n}{rb_n + rA + s} \\
    \end{aligned}"""),
    StepItem(tex: r"""\text{よって、} b_{n+1} = \displaystyle \frac{(p - rA)b_n}{rb_n + rA + s}\cdot(2) \text{ となり、分子の定数項がない漸化式に帰着し、命題が示された。}"""),
    StepItem(tex: r"""\text{【特に重解の場合】}"""),
    StepItem(tex: r"""\text{重解の場合、判別式が0となるため、} (s-p)^2 + 4rq = 0 \text{ が成り立ち、解の公式より、} A = \displaystyle \frac{-(s-p)}{2r} = \displaystyle \frac{p-s}{2r} \text{ となる。}"""),
    StepItem(tex: r"""\text{これを変形すると、} 2rA = p-s \Leftrightarrow rA + s = p -rA"""),
    StepItem(tex: r"""\text{(2)について両辺の逆数をとると、} \displaystyle \frac{1}{b_{n+1}} = \displaystyle \frac{rb_n + rA + s}{(p - rA)b_n}"""),
    StepItem(tex: r"""\text{ここで、} rA + s = p - rA \text{ より、} \displaystyle \frac{1}{b_{n+1}} = \displaystyle \frac{rb_n + (p - rA)}{(p - rA)b_n} = \displaystyle \frac{r}{p - rA} + \displaystyle \frac{1}{b_n}"""),
    StepItem(tex: r"""\text{また、} p - rA = p - r \cdot \displaystyle \frac{p-s}{2r} = \displaystyle \frac{p+s}{2} \text{ であるから、} \displaystyle \frac{1}{b_{n+1}} = \displaystyle \frac{2r}{p+s} + \displaystyle \frac{1}{b_n}"""),
    StepItem(tex: r"""\text{よって、} \displaystyle \frac{1}{b_n} \text{ は公差 } \displaystyle \frac{2r}{p+s} \text{ の等差数列となる。}"""),
    
    ],
  ),

  // ────────────────────────────────
  // 問題 9: 階差数列型
  // ────────────────────────────────
  MathProblem(
    id: "D31DD01A-20D0-49DA-9EAD-E9571974B0DB",
    no: 9,
    category: '数列',
    level: '初級',
    question: r"""a_{n+1} = a_n + 2n + 1, \quad a_1 = 1""",
    answer: r"""a_n = n^2""",
    imageAsset: 'assets/graphs/sequences/problem_8.png',
    equation: r"""a_{n+1} = a_n + 2n + 1""",
    conditions: r"""a_1 = 1""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{階差数列 } b_n = a_{n+1} - a_n = 2n + 1 \text{ を用いて一般項を求める。}"""),
      StepItem(tex: r"""\textbf{【解法】}"""),
      StepItem(tex: r"""\text{ } \textcolor{blue}{n \ge 2} \textcolor{blue}{ のとき}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ a_n = a_1 + \displaystyle \sum_{k=1}^{n-1} (a_{k+1} - a_k) \\
    &\Leftrightarrow a_n = 1 + \displaystyle \sum_{k=1}^{n-1} (2k + 1) \\
    &\Leftrightarrow a_n = 1 + 2 \displaystyle \sum_{k=1}^{n-1} k + \displaystyle \sum_{k=1}^{n-1} 1 \\
    &\Leftrightarrow a_n = 1 + 2 \cdot \displaystyle \frac{(n-1)n}{2} + (n-1) \\
    &\Leftrightarrow a_n = 1 + n(n-1) + n - 1 \\
    &\Leftrightarrow a_n = n^2 - n + n \\
    &\Leftrightarrow a_n = n^2
    \end{aligned}"""),
          StepItem(tex: r"""\text{ } \textcolor{blue}{n = 1} \textcolor{blue}{ のとき}"""),
      StepItem(tex: r""" a_1 = 1 = 1^2 """),
      StepItem(tex: r"""\text{よって} a_n \text{はまとめて、} a_n = n^2 (n \ge 1)\text{と書ける。}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 10: 和と一般項の関係
  // ────────────────────────────────
  MathProblem(
    id: "D8CA1CE8-6921-47E2-8A45-728DED579EB0",
    no: 10,
    category: '数列',
    level: '初級',
    question: r"""\displaystyle \ \displaystyle \sum_{k=1}^{n} a_k = n^2 + 2n""",
    answer: r"""    a_n  = 2n + 1""",
    imageAsset: 'assets/graphs/sequences/problem_9.png',
    equation: r"""\displaystyle \  \displaystyle \sum_{k=1}^{n} a_k = n^2 + 2n""",
    conditions: r"""""",
    steps: [
      StepItem(tex: r"""\textbf{【解法】}"""),
      StepItem(tex: r"""\text{ } \textcolor{blue}{n \ge 2} \textcolor{blue}{ のとき}"""),
      StepItem(tex: r"""a_n = S_n - S_{n-1} \text{ なので、}"""),
      StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ a_n = S_n - S_{n-1} \\
    &\Leftrightarrow a_n = (n^2 + 2n) - \{(n-1)^2 + 2(n-1)\} \\
    &\Leftrightarrow a_n = n^2 + 2n - (n^2 - 2n + 1 + 2n - 2) \\
    &\Leftrightarrow a_n = n^2 + 2n - n^2 + 2n - 1 - 2n + 2 \\
    &\Leftrightarrow a_n = 2n + 1
    \end{aligned}"""),
      StepItem(tex: r"""\text{ } \textcolor{blue}{n = 1} \textcolor{blue}{ のとき}"""),
      StepItem(tex: r""" a_1 = S_1 = 1^2 + 2 \cdot 1 = 3 = 2 \cdot 1 + 1"""),
      StepItem(tex: r"""\text{よって} a_n \text{はまとめて、} a_n  = 2n + 1 (n \ge 1)\text{と書ける。}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 11: ３項間漸化式（具体例1）
  // ────────────────────────────────
  MathProblem(
    id: "417F69AB-5A9E-4488-9692-AA67DE3BCFF2",
    no: 11,
    category: '数列（３項間漸化式）',
    level: '中級',
    question: r"""
a_{n+2} + 3 a_{n+1} - 4 a_n = 0, \quad a_1 = 1,\ a_2 = 2
""",
    answer: r"""a_n = \displaystyle \frac{6}{5} - \displaystyle \frac{1}{5}(-4)^{\,n-1}""",
    imageAsset: 'assets/graphs/sequences/problem_10.png',
    equation: r"""a_{n+2} + 3 a_{n+1} - 4 a_n = 0""",
    conditions: r"""a_1 = 1,\ a_2 = 2""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】} 
      \text{特性方程式} x^2+ 3x - 4 = 0 \text{を解き、解}r_1,r_2\text{を求めて、}a_n = A r_1^{n-1} + B r_2^{n-1} \text{と置き、初期条件を代入して実数} A,B\text{を求める。(なぜこう置く事ができるかは解説の命題1を参照。)}"""),
      StepItem(tex: r"""\textbf{【解法】} """),
      StepItem(tex: r""" \text{特性方程式 }"""),
      StepItem(tex: r"""
      \begin{aligned}
      &\ \ \ \ \ r^2 + 3r - 4 = 0 \\
      &\Leftrightarrow (r - 1)(r + 4) = 0 \\
      &\Leftrightarrow r = 1 \text{ または } r = -4
      \end{aligned}
      """),
      StepItem(tex: r"""\text{よって命題(1)より、解は} a_n = A \cdot 1^{\,n-1} + B \cdot (-4)^{\,n-1}\text{と表す事ができる。}"""),
      StepItem(tex: r"""\text{(2) 初期条件から } A,B \text{ を求める}"""),
      StepItem(tex: r"""\text{初期条件 } a_1=1,\ a_2=2 \text{ より、}"""),
      StepItem(tex: r"""\begin{aligned}
      \begin{cases}
        1 = A + B \\
        2 = A - 4B
      \end{cases}
      & \Leftrightarrow
      \begin{cases}
        A = \displaystyle \frac{6}{5} \\[6pt]
        B = -\displaystyle \frac{1}{5}
      \end{cases}
      \end{aligned}"""),
      StepItem(tex: r"""\textcolor{green}{したがって} \textcolor{green}{a_n = \displaystyle \frac{6}{5} - \displaystyle \frac{1}{5}(-4)^{\,n-1}}"""),

         // 命題の「宣言」
      StepItem(tex: r"""\textbf{【命題1】}"""),
      StepItem(tex: r"""\text{漸化式 } a_{n+2} + p a_{n+1} + q a_n = 0 \text{と、実数の初期条件} a_1,a_2\text{が与えられたとする。}"""),
      StepItem(tex: r"""\text{この時、漸化式に対して定まる二次方程式} r^2 + p r + q = 0 \text{の互いに異なる2根を} r_1,r_2 \text{とすると、一般項} a_n \textcolor{green}{はある実数} \textcolor{green}{A,B} \textcolor{green}{を用いて}"""),
      StepItem(tex: r"""\textcolor{green}{a_n = A r_1^{\,n-1} + B r_2^{\,n-1}} \textcolor{green}{ と表す事ができる。}"""),
      StepItem(tex: r"""\text{※ ただし、} A,B \text{ は初期条件}a_1, a_2\text{によって定まる実数。}"""),
      // 命題の「証明（流れ）」
      StepItem(tex: r"""\textbf{【証明】}
\text{解と係数の関係より、}r_1+r_2= -p, r_1r_2= q\text{であるから、次の式が成り立つ：}
\begin{aligned}
  &a_{n+2}-r_1 a_{n+1} = r_2\bigl(a_{n+1}-r_1 a_n\bigr)\\
  &a_{n+2}-r_2 a_{n+1} = r_1\bigl(a_{n+1}-r_2 a_n\bigr)
\end{aligned}
\text{ここで}
b_n := a_{n+1}-r_1 a_n,\quad  c_n := a_{n+1}-r_2 a_n
\text{と置くと，上の恒等式から}
  b_{n+1}=r_2 b_n,\quad c_{n+1}=r_1 c_n
\text{が成り立つ。したがって初項}
  b_1 = a_2 - r_1 a_1,\quad  c_1 = a_2 - r_2 a_1
\text{に対して、}
  b_n = b_1 r_2^{\,n-1},\quad c_n = c_1 r_1^{\,n-1} \quad\cdots(1)
\text{である。}

\text{一方，} b_n,c_n \text{の定義から}
\begin{aligned}
  c_n - b_n &= (a_{n+1}-r_2 a_n) - (a_{n+1}-r_1 a_n)\\[5pt]
            &= (r_1-r_2)a_n
\end{aligned}
\text{よって}
a_n = \displaystyle \frac{c_n-b_n}{r_1-r_2}
\text{(1) を適用して展開すると，}
\quad = \displaystyle \frac{c_1 r_1^{\,n-1} - b_1 r_2^{\,n-1}}{r_1-r_2}
\text{ここで } b_1,c_1 \text{ の値を代入すると，}
\quad = \displaystyle \frac{(a_2 - r_2 a_1)\,r_1^{\,n-1} - (a_2 - r_1 a_1)\,r_2^{\,n-1}}{r_1-r_2}
\text{右辺について，}
\displaystyle A=\displaystyle \frac{a_2 - r_2 a_1}{r_1-r_2},\quad  B=\displaystyle \frac{r_1 a_1-a_2 }{r_1-r_2}
\text{とおくと明らかに}A,B\text{は実数で、}
  a_n = A r_1^{\,n-1} + B r_2^{\,n-1}
\text{の形で書ける。これで命題の主張が示された。Q.E.D}"""),
      StepItem(tex: r"""\textbf{【注意】}"""),
      StepItem(tex: r"""r_1=r_2 \text{ の重解の場合は上の議論は使えないため別扱いで，重根 } r \text{ に対して解が} a_n=(A+Bn)r^{\,n-1} \text{の形になることを別途示す必要がある。}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 12: ３項間漸化式（具体例2）
  // ────────────────────────────────
  MathProblem(
    id: "E460F72E-E848-4B8F-B481-9D3E820FEBAE",
    no: 12,
    category: '数列（３項間漸化式）',
    level: '中級',
    question: r"""
a_{n+2} - a_{n+1} - 6 a_n = 0, \quad a_1 = 1,\ a_2 = 2
""",
    answer: r"""a_n = \displaystyle \frac{4}{5} 3^{\,n-1} + \displaystyle \frac{1}{5}(-2)^{\,n-1}""",
    imageAsset: 'assets/graphs/sequences/problem_11.png',
    equation: r"""a_{n+2} - a_{n+1} - 6 a_n = 0""",
    conditions: r"""a_1 = 1,\ a_2 = 2""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】} 
      \text{特性方程式} x^2 - x - 6 = 0 \text{を解き、解}r_1,r_2\text{を求めて、}a_n = A r_1^{n-1} + B r_2^{n-1} \text{と置き、初期条件を代入して実数} A,B\text{を求める。(なぜこう置く事ができるかは解説の命題1を参照。)}"""),
      StepItem(tex: r"""\textbf{【解法】} """),
      StepItem(tex: r""" \text{特性方程式 }"""),
      StepItem(tex: r"""
      \begin{aligned}
      &\ \ \ \ \ r^2 - r - 6 = 0 \\
      &\Leftrightarrow (r - 3)(r + 2) = 0 \\
      &\Leftrightarrow r = 3 \text{ または } r = -2
      \end{aligned}
      """),
      StepItem(tex: r"""\text{よって命題(1)より、解は} a_n = A \cdot 3^{\,n-1} + B \cdot (-2)^{\,n-1}\text{と表す事ができる。}"""),
      StepItem(tex: r"""\text{(2) 初期条件から } A,B \text{ を求める}"""),
      StepItem(tex: r"""\text{初期条件 } a_1=1,\ a_2=2 \text{ より、}"""),
      StepItem(tex: r"""\begin{aligned}
      \begin{cases}
        1 = A + B \\
        2 = 3A - 2B
      \end{cases}
      & \Leftrightarrow
      \begin{cases}
        A = \displaystyle \frac{4}{5} \\[6pt]
        B = \displaystyle \frac{1}{5}
      \end{cases}
      \end{aligned}"""),
      StepItem(tex: r"""\textcolor{green}{したがって} \textcolor{green}{a_n = \displaystyle \frac{4}{5} \cdot 3^{\,n-1} + \displaystyle \frac{1}{5}(-2)^{\,n-1}}"""),

         // 命題の「宣言」
      StepItem(tex: r"""\textbf{【命題1】}"""),
      StepItem(tex: r"""\text{漸化式 } a_{n+2} + p a_{n+1} + q a_n = 0 \text{と、実数の初期条件} a_1,a_2\text{が与えられたとする。}"""),
      StepItem(tex: r"""\text{この時、漸化式に対して定まる二次方程式} r^2 + p r + q = 0 \text{の互いに異なる2根を} r_1,r_2 \text{とすると、一般項} a_n \textcolor{green}{はある実数} \textcolor{green}{A,B} \textcolor{green}{を用いて}"""),
      StepItem(tex: r"""\textcolor{green}{a_n = A r_1^{\,n-1} + B r_2^{\,n-1}} \textcolor{green}{ と表す事ができる。}"""),
      StepItem(tex: r"""\text{※ ただし、} A,B \text{ は初期条件}a_1, a_2\text{によって定まる実数。}"""),
      // 命題の「証明（流れ）」
      StepItem(tex: r"""\textbf{【証明】}
\text{解と係数の関係より、}r_1+r_2= -p, r_1r_2= q\text{であるから、次の式が成り立つ：}
\begin{aligned}
  &a_{n+2}-r_1 a_{n+1} = r_2\bigl(a_{n+1}-r_1 a_n\bigr)\\
  &a_{n+2}-r_2 a_{n+1} = r_1\bigl(a_{n+1}-r_2 a_n\bigr)
\end{aligned}
\text{ここで}
b_n := a_{n+1}-r_1 a_n,\quad  c_n := a_{n+1}-r_2 a_n
\text{と置くと，上の恒等式から}
  b_{n+1}=r_2 b_n,\quad c_{n+1}=r_1 c_n
\text{が成り立つ。したがって初項}
  b_1 = a_2 - r_1 a_1,\quad  c_1 = a_2 - r_2 a_1
\text{に対して、}
  b_n = b_1 r_2^{\,n-1},\quad c_n = c_1 r_1^{\,n-1} \quad\cdots(1)
\text{である。}

\text{一方，} b_n,c_n \text{の定義から}
\begin{aligned}
  c_n - b_n &= (a_{n+1}-r_2 a_n) - (a_{n+1}-r_1 a_n)\\[5pt]
            &= (r_1-r_2)a_n
\end{aligned}
\text{よって}
a_n = \displaystyle \frac{c_n-b_n}{r_1-r_2}
\text{(1) を適用して展開すると，}
\quad = \displaystyle \frac{c_1 r_1^{\,n-1} - b_1 r_2^{\,n-1}}{r_1-r_2}
\text{ここで } b_1,c_1 \text{ の値を代入すると，}
\quad = \displaystyle \frac{(a_2 - r_2 a_1)\,r_1^{\,n-1} - (a_2 - r_1 a_1)\,r_2^{\,n-1}}{r_1-r_2}
\text{右辺について，}
\displaystyle A=\displaystyle \frac{a_2 - r_2 a_1}{r_1-r_2},\quad  B=\displaystyle \frac{r_1 a_1-a_2 }{r_1-r_2}
\text{とおくと明らかに}A,B\text{は実数で、}
  a_n = A r_1^{\,n-1} + B r_2^{\,n-1}
\text{の形で書ける。これで命題の主張が示された。Q.E.D}"""),
      StepItem(tex: r"""\textbf{【注意】}"""),
      StepItem(tex: r"""r_1=r_2 \text{ の重解の場合は上の議論は使えないため別扱いで，重根 } r \text{ に対して解が} a_n=(A+Bn)r^{\,n-1} \text{の形になることを別途示す必要がある。}"""),
    ],
  ),

  // ────────────────────────────────
// 問題 13: ３項間漸化式（重解の具体例）
// ────────────────────────────────
MathProblem(
  id: "73D06F52-2C0D-4118-84C6-662FAA49A553",
    no: 13,
    category: '数列（３項間漸化式）',
    level: '中級',
  question: r"""
a_{n+2} - 4a_{n+1} + 4a_n = 0, \quad a_1 = 1,\ a_2 = 6
""",
  answer: r"""a_n = (-1 + 2n)2^{\,n-1}""",
  imageAsset: 'assets/graphs/sequences/problem_12.png',
  equation: r"""a_{n+2} - 4a_{n+1} + 4a_n = 0""",
  conditions: r"""a_1 = 1,\ a_2 = 6""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{特性方程式 } r^2 - 4r + 4 = 0 \text{ の重根 } r \text{ を用い，} a_n = (A+Bn)r^{n-1} \text{ と書いて係数を決定する。(なぜこう置く事ができるかは解説の命題（重解版）を参照。)}"""),
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""\text{特性方程式 }"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ r^2 - 4r + 4 = 0 \\
    &\Leftrightarrow (r - 2)^2 = 0 \\
    &\Leftrightarrow r = 2 \text{ （重根）}
    \end{aligned}"""),
    StepItem(tex: r"""\text{よって命題（重解版）より、解は} a_n = (A + Bn) \cdot 2^{\,n-1}\text{と表す事ができる。}"""),
    StepItem(tex: r"""\text{(2) 初期条件から } A,B \text{ を求める}"""),
    StepItem(tex: r"""\text{初期条件 } a_1=1,\ a_2=6 \text{ より、}"""),
    StepItem(tex: r"""\begin{aligned}
    \begin{cases}
      1 = A + B \\
      6 = (A + 2B) \cdot 2
    \end{cases}
    & \Leftrightarrow
    \begin{cases}
      A = -1 \\
      B = 2
    \end{cases}
    \end{aligned}"""),
    StepItem(tex: r"""\textcolor{green}{したがって} \textcolor{green}{a_n = (-1 + 2n) \cdot 2^{\,n-1}}"""),
         // 命題の「宣言」
      StepItem(tex: r"""\textbf{【命題（重解版）】}"""),
      StepItem(tex: r"""\text{漸化式 } a_{n+2} + p a_{n+1} + q a_n = 0 \text{と、実数の初期条件} a_1,a_2\text{が与えられたとする。}"""),
      StepItem(tex: r"""\text{この時、漸化式に対して定まる二次方程式} r^2 + p r + q = 0 \text{が重根 } r \text{を持つとき、一般項} a_n \textcolor{green}{はある実数} \textcolor{green}{A,B} \textcolor{green}{を用いて}"""),
      StepItem(tex: r"""\textcolor{green}{a_n = (A + B n) r^{\,n-1}} \textcolor{green}{ と表す事ができる。}"""),
      StepItem(tex: r"""\text{※ ただし、} A,B \text{ は初期条件}a_1, a_2\text{によって定まる実数。}"""),
      // 命題の「証明（流れ）」
      StepItem(tex: r"""\textbf{【証明】}
\text{特性方程式が重根 } r \text{ を持つとき、解と係数の関係より } 2r = -p, r^2 = q \text{であるから、次の式が成り立つ：}
\begin{aligned}
  &a_{n+2}-r a_{n+1} = r\bigl(a_{n+1}-r a_n\bigr)
\end{aligned}
\text{ここで}
b_n := a_{n+1}-r a_n
\text{と置くと，上の恒等式から}
  b_{n+1}=r b_n
\text{が成り立つ。したがって初項}
  b_1 = a_2 - r a_1
\text{に対して、}
  b_n = b_1 r^{\,n-1} \quad\cdots(1)
\text{である。}

\text{一方，} b_n \text{の定義から}
\begin{aligned}
  a_{n+1} - r a_n &= b_1 r^{\,n-1}
\end{aligned}
\text{この両辺を } r^{n+1} \text{ で割ると（ } r \neq 0 \text{ を仮定）、}
\begin{aligned}
  \displaystyle \frac{a_{n+1}}{r^{n+1}} - \displaystyle \frac{a_n}{r^n} &= \displaystyle \frac{b_1}{r^2}
\end{aligned}
\text{ここで } u_n := \displaystyle \frac{a_n}{r^n} \text{ と置くと，}
\begin{aligned}
  u_{n+1} - u_n &= \displaystyle \frac{b_1}{r^2}
\end{aligned}
\text{従って } (u_n) \text{ は公差 } \displaystyle \frac{b_1}{r^2} \text{ の等差数列であり，初項 } u_1 = \displaystyle \frac{a_1}{r} \text{ を用いて}
  u_n = \displaystyle \frac{a_1}{r} + (n-1)\displaystyle \frac{b_1}{r^2}
\text{である。}

\text{元に戻すと（ } b_1 = a_2 - r a_1 \text{ ）}
\begin{aligned}
  a_n &= u_n r^n \\
  &= \left(\displaystyle \frac{a_1}{r} + (n-1)\displaystyle \frac{b_1}{r^2}\right) r^{n} \\
  &= \left(a_1 + (n-1)\displaystyle \frac{a_2 - r a_1}{r}\right) r^{\,n-1} \\
  &= \left( \left(a_1 - \displaystyle \frac{a_2 - r a_1}{r}\right) + \left(\displaystyle \frac{a_2 - r a_1}{r}\right)n \right)r^{\,n-1} \\
  &= \left( \left(2a_1 - \displaystyle \frac{a_2}{r}\right) + \left(\displaystyle \frac{a_2}{r} - a_1\right)n \right)r^{\,n-1}
\end{aligned}
\text{右辺について，}
\begin{aligned}
  A = 2a_1 - \displaystyle \frac{a_2}{r} , \quad B = \displaystyle \frac{a_2}{r} - a_1
\end{aligned}
\text{とおくと明らかに}A,B\text{は実数で、}
  a_n = (A + B n) r^{n-1}
\text{の形で書ける。これで命題の主張が示された。Q.E.D}"""),
      StepItem(tex: r"""\textbf{【注意】}"""),
      StepItem(tex: r"""r_1 \neq r_2 \text{ の互いに異なる解の場合は上の議論は使えないため別扱いで，そのときは } a_n = A r_1^{n-1} + B r_2^{n-1} \text{ の形になる。}"""),
  ],
),

// ────────────────────────────────
// 問題 14: 連立漸化式（３項間に帰着 → 特性方程式の解が整数になる例）
// ────────────────────────────────
MathProblem(
  id: "37B80E92-3E58-4BAF-A56B-7425004B28E0",
  no: 14,
  category: '数列（連立漸化式）',
  level: '上級',
  question: r"""a_{n+1} = 4a_n + b_n,\\[4pt]
b_{n+1} = -2a_n + b_n,\\[4pt]
a_1 = 2,\ b_1 = 1 \qquad (n\ge1)""",
  answer: r"""\begin{cases}
  a_n = -3\cdot 2^{\,n-1} + 5\cdot 3^{\,n-1}\\[5pt]
  b_n = 6\cdot 2^{\,n-1} - 5\cdot 3^{\,n-1}\end{cases}""",
  imageAsset: 'assets/graphs/sequences/problem_14.png',
  equation: r"""a_{n+1} = 4a_n + b_n\\[4pt]
b_{n+1} = -2a_n + b_n""",
  conditions: r"""a_1 = 2,\ b_1 = 1""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{連立漸化式から } b_n \text{ を消去して３項間漸化式に帰着させ、特性方程式を解いて、根 } r_1,r_2 \text{ に対して } a_n=A r_1^{n-1}+B r_2^{n-1}\text{ と置く。}"""),
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""\text{(1) 第1式から } b_n = a_{n+1} - 4a_n \text{ と表せる。また、}n\text{を}n+1\text{とすると、} b_{n+1} =  a_{n+2} - 4a_{n+1}  \text{も成り立つ。これを第2式に代入すると、}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ b_{n+1} = -2a_n + b_n \\
    &\Leftrightarrow a_{n+2} - 4a_{n+1} = -2a_n + (a_{n+1} - 4a_n) \\
    &\Leftrightarrow a_{n+2} - 5a_{n+1} + 6a_n = 0
    \end{aligned}"""),
    StepItem(tex: r"""\text{これで、}a_n\text{についての3項間漸化式に帰着できた。}"""),
    StepItem(tex: r"""\text{特性方程式 }"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ r^2 -5r +6 = 0 \\
    &\Leftrightarrow r = 2,\ 3
    \end{aligned}"""),
    StepItem(tex: r"""\text{よって命題(1)より、解は} a_n = A \cdot 2^{\,n-1} + B \cdot 3^{\,n-1}\text{と表す事ができる。}"""),
    StepItem(tex: r"""\text{(2) 初期条件から } A,B \text{ を求める}"""),
    StepItem(tex: r"""\text{初期条件 } a_1=2,\ b_1=1 \text{ より、} a_2 = 4a_1 + b_1 = 9 \text{ である。}"""),
    StepItem(tex: r"""\text{したがって}"""),
    StepItem(tex: r"""\begin{aligned}
    \begin{cases}
      2 = A + B \\
      9 = 2A + 3B
    \end{cases}
    & \Leftrightarrow
    \begin{cases}
      A = -3 \\
      B = 5
    \end{cases}
    \end{aligned}"""),
    StepItem(tex: r"""\textcolor{green}{したがって} \textcolor{green}{ a_n = -3\cdot 2^{\,n-1} + 5\cdot 3^{\,n-1}}"""),
    StepItem(tex: r"""\text{(3) } b_n \text{ を明示的に求める（第1式より）}"""),
    StepItem(tex: r"""\text{第1式 } a_{n+1}=4a_n+b_n \text{ より } b_n = a_{n+1}-4a_n \text{。一般項 } a_n = -3\cdot 2^{n-1} + 5\cdot 3^{n-1} \text{ を用いて計算すると，}"""),
    StepItem(tex: r"""\begin{aligned}
b_n
&= \bigl(-3\cdot 2^{n} + 5\cdot 3^{n}\bigr)
   -4\bigl(-3\cdot 2^{n-1} + 5\cdot 3^{n-1}\bigr)\\[6pt]
&= -3\cdot 2^{n} + 5\cdot 3^{n} + 12\cdot 2^{n-1} -20\cdot 3^{n-1}\\[6pt]
&= \textcolor{green}{6\cdot 2^{\,n-1} -5\cdot 3^{\,n-1}}
\end{aligned}"""),
    // 命題の「宣言」
    StepItem(tex: r"""\textbf{【命題1】}"""),
    StepItem(tex: r"""\text{漸化式 } a_{n+2} + p a_{n+1} + q a_n = 0 \text{と、実数の初期条件} a_1,a_2\text{が与えられたとする。}"""),
    StepItem(tex: r"""\text{この時、漸化式に対して定まる二次方程式} r^2 + p r + q = 0 \text{の互いに異なる2根を} r_1,r_2 \text{とすると、一般項} a_n \textcolor{green}{はある実数} \textcolor{green}{A,B} \textcolor{green}{を用いて}"""),
    StepItem(tex: r"""\textcolor{green}{a_n = A r_1^{\,n-1} + B r_2^{\,n-1}} \textcolor{green}{ と表す事ができる。}"""),
    StepItem(tex: r"""\text{※ ただし、} A,B \text{ は初期条件}a_1, a_2\text{によって定まる実数。}"""),
    // 命題の「証明（流れ）」
    StepItem(tex: r"""\textbf{【証明】}
\text{解と係数の関係より、}r_1+r_2= -p, r_1r_2= q\text{であるから、次の式が成り立つ：}
\begin{aligned}
  &a_{n+2}-r_1 a_{n+1} = r_2\bigl(a_{n+1}-r_1 a_n\bigr)\\
  &a_{n+2}-r_2 a_{n+1} = r_1\bigl(a_{n+1}-r_2 a_n\bigr)
\end{aligned}
\text{ここで}
b_n := a_{n+1}-r_1 a_n,\quad  c_n := a_{n+1}-r_2 a_n
\text{と置くと，上の恒等式から}
  b_{n+1}=r_2 b_n,\quad c_{n+1}=r_1 c_n
\text{が成り立つ。したがって初項}
  b_1 = a_2 - r_1 a_1,\quad  c_1 = a_2 - r_2 a_1
\text{に対して、}
  b_n = b_1 r_2^{\,n-1},\quad c_n = c_1 r_1^{\,n-1} \quad\cdots(1)
\text{である。}

\text{一方，} b_n,c_n \text{の定義から}
\begin{aligned}
  c_n - b_n &= (a_{n+1}-r_2 a_n) - (a_{n+1}-r_1 a_n)\\[5pt]
            &= (r_1-r_2)a_n
\end{aligned}
\text{よって}
a_n = \displaystyle \frac{c_n-b_n}{r_1-r_2}
\text{(1) を適用して展開すると，}
\quad = \displaystyle \frac{c_1 r_1^{\,n-1} - b_1 r_2^{\,n-1}}{r_1-r_2}
\text{ここで } b_1,c_1 \text{ の値を代入すると，}
\quad = \displaystyle \frac{(a_2 - r_2 a_1)\,r_1^{\,n-1} - (a_2 - r_1 a_1)\,r_2^{\,n-1}}{r_1-r_2}
\text{右辺について，}
\displaystyle A=\displaystyle \frac{a_2 - r_2 a_1}{r_1-r_2},\quad  B=\displaystyle \frac{r_1 a_1-a_2 }{r_1-r_2}
\text{とおくと明らかに}A,B\text{は実数で、}
  a_n = A r_1^{\,n-1} + B r_2^{\,n-1}
\text{の形で書ける。これで命題の主張が示された。Q.E.D}"""),
    StepItem(tex: r"""\textbf{【注意】}"""),
    StepItem(tex: r"""r_1=r_2 \text{ の重解の場合は上の議論は使えないため別扱いで，重根 } r \text{ に対して解が} a_n=(A+Bn)r^{\,n-1} \text{の形になることを別途示す必要がある。}"""),
  ],
),



// ────────────────────────────────
// 問題 15: 連立漸化式（３項間に帰着 → 特性方程式が重解 5）
// ────────────────────────────────
MathProblem(
  id: "863C1DB8-6D69-4926-93D3-24FE77194C4D",
  no: 15,
  category: '数列（連立漸化式）',
  level: '上級',
  question: r"""a_{n+1} = 6a_n + b_n,\\[4pt]
b_{n+1} = -a_n + 4b_n,\\[4pt]
a_1 = 1,\ b_1 = 2 \qquad (n\ge1)""",
  answer: r"""\begin{cases}
  a_n = (2 + 3n)5^{\,n-2}\\[5pt]
  b_n = (13 - 3n)5^{\,n-2}\end{cases}""",
  imageAsset: 'assets/graphs/sequences/problem_15.png',
  equation: r"""a_{n+1} = 6a_n + b_n\\[4pt]
b_{n+1} = -a_n + 4b_n""",
  conditions: r"""a_1 = 1,\ b_1 = 2""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{連立漸化式の一方を用いて他方を消去し，}a_n\text{ のみの３項間漸化式に帰着させる。得られた漸化式の特性方程式が重根 } r=5 \text{ になるので，重解版の命題を適用して一般項を求める。}"""),

    StepItem(tex: r"""\textbf{【解法】}"""),

    StepItem(tex: r"""\text{(1) 第一式から } b_n = a_{n+1} - 6a_n \text{ と表せる。また、}n\text{を}n+1\text{とすると、} b_{n+1} =  a_{n+2} - 6a_{n+1}  \text{も成り立つ。これを第二式に代入すると、}"""),
    StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ b_{n+1} = -a_n + 4b_n \\
&\Leftrightarrow a_{n+2} - 6a_{n+1} = -a_n + 4(a_{n+1}-6a_n) \\
&\Leftrightarrow a_{n+2} -10 a_{n+1} +25 a_n = 0
\end{aligned}"""),
    StepItem(tex: r"""\text{これで、}a_n\text{についての3項間漸化式に帰着できた。}"""),
    StepItem(tex: r"""\text{特性方程式 }"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ r^2 - 10 r + 25 = 0 \\
    &\Leftrightarrow (r-5)^2 = 0 \\
    &\Leftrightarrow r = 5
    \end{aligned}"""),
    StepItem(tex: r"""\text{よって補足命題（重解版）より、解は} a_n = (A + Bn) \cdot 5^{\,n-1}\text{と表す事ができる。}"""),
    StepItem(tex: r"""\text{(2) 初期条件から } A,B \text{ を求める}"""),
    StepItem(tex: r"""\text{初期条件 } a_1=1,\ b_1=2 \text{ より、} a_2 = 6a_1 + b_1 = 8 \text{ である。}"""),
    StepItem(tex: r"""\text{したがって}"""),
    StepItem(tex: r"""\begin{aligned}
    \begin{cases}
      1 = A + B \\
      8 = (A + 2B) \cdot 5
    \end{cases}
    & \Leftrightarrow
    \begin{cases}
      A = \displaystyle \frac{2}{5} \\[6pt]
      B = \displaystyle \frac{3}{5}
    \end{cases}
    \end{aligned}"""),
    StepItem(tex: r"""\textcolor{green}{したがって} \textcolor{green}{ a_n = \left(\displaystyle \frac{2}{5} + \displaystyle \frac{3}{5}n\right)5^{\,n-1} = (2+3n)5^{\,n-2}}"""),
    StepItem(tex: r"""\text{(3) } b_n \text{ を明示的に求める（第1式より）}"""),
    StepItem(tex: r"""\text{第1式 } a_{n+1}=6a_n+b_n \text{ より } b_n = a_{n+1}-6a_n \text{。一般項 } a_n = (2+3n)5^{\,n-2} \text{ を用いて計算すると，}"""),
    StepItem(tex: r"""\begin{aligned}
b_n
&= \bigl((2+3(n+1))5^{\,n-1}\bigr)
   -6\bigl((2+3n)5^{\,n-2}\bigr)\\[6pt]
&= (5+3n)5^{\,n-1} - (12+18n)5^{\,n-2}\\[6pt]
&= (5+3n) \cdot 5 \cdot 5^{\,n-2} - (12+18n)5^{\,n-2}\\[6pt]
&= (25+15n)5^{\,n-2} - (12+18n)5^{\,n-2}\\[6pt]
&= \textcolor{green}{(13 - 3n)5^{\,n-2}}
\end{aligned}"""),
    // --- 命題（重解版）と証明（ユーザー提供の内容をそのまま使用） ---
    StepItem(tex: r"""\textbf{【補足命題（重解版）】}"""),
    StepItem(tex: r"""\text{漸化式 } a_{n+2} + p a_{n+1} + q a_n = 0 \text{と、実数の初期条件} a_1,a_2\text{が与えられたとする。}"""),
    StepItem(tex: r"""\text{この時、漸化式に対して定まる二次方程式} r^2 + p r + q = 0 \text{が重根 } r \text{を持つとき、一般項} a_n \textcolor{green}{はある実数} \textcolor{green}{A,B} \textcolor{green}{を用いて}"""),
    StepItem(tex: r"""\textcolor{green}{a_n = (A + B n) r^{\,n-1}} \textcolor{green}{ と表す事ができる。}"""),
    StepItem(tex: r"""\text{※ ただし、} A,B \text{ は初期条件}a_1, a_2\text{によって定まる実数。}"""),
    StepItem(tex: r"""\textbf{【証明】}
\text{特性方程式が重根 } r \text{ を持つとき、解と係数の関係より } 2r = -p, r^2 = q \text{であるから、次の式が成り立つ：}
\begin{aligned}
  &a_{n+2}-r a_{n+1} = r\bigl(a_{n+1}-r a_n\bigr)
\end{aligned}
\text{ここで}
b_n := a_{n+1}-r a_n
\text{と置くと，上の恒等式から}
  b_{n+1}=r b_n
\text{が成り立つ。したがって初項}
  b_1 = a_2 - r a_1
\text{に対して、}
  b_n = b_1 r^{\,n-1} \quad\cdots(1)
\text{である。}

\text{一方，} b_n \text{の定義から}
\begin{aligned}
  a_{n+1} - r a_n &= b_1 r^{\,n-1}
\end{aligned}
\text{この両辺を } r^{n+1} \text{ で割ると（ } r \neq 0 \text{ を仮定）、}
\begin{aligned}
  \displaystyle \frac{a_{n+1}}{r^{n+1}} - \displaystyle \frac{a_n}{r^n} &= \displaystyle \frac{b_1}{r^2}
\end{aligned}
\text{ここで } u_n := \displaystyle \frac{a_n}{r^n} \text{ と置くと，}
\begin{aligned}
  u_{n+1} - u_n &= \displaystyle \frac{b_1}{r^2}
\end{aligned}
\text{従って } (u_n) \text{ は公差 } \displaystyle \frac{b_1}{r^2} \text{ の等差数列であり，初項 } u_1 = \displaystyle \frac{a_1}{r} \text{ を用いて}
  u_n = \displaystyle \frac{a_1}{r} + (n-1)\displaystyle \frac{b_1}{r^2}
\text{である。}

b_1 = a_2 - r a_1 \text{を用いて元に戻すと、}
\begin{aligned}
  a_n &= u_n r^n \\
  &= \left(\displaystyle \frac{a_1}{r} + (n-1)\displaystyle \frac{b_1}{r^2}\right) r^{n} \\
  &= \left(a_1 + (n-1)\displaystyle \frac{a_2 - r a_1}{r}\right) r^{\,n-1} \\
  &= \left( \left(a_1 - \displaystyle \frac{a_2 - r a_1}{r}\right) + \left(\displaystyle \frac{a_2 - r a_1}{r}\right)n \right)r^{\,n-1} \\
  &= \left( \left(2a_1 - \displaystyle \frac{a_2}{r}\right) + \left(\displaystyle \frac{a_2}{r} - a_1\right)n \right)r^{\,n-1}
\end{aligned}
\text{右辺について，}
\begin{aligned}
  A = 2a_1 - \displaystyle \frac{a_2}{r} , \quad B = \displaystyle \frac{a_2}{r} - a_1
\end{aligned}
\text{とおくと明らかに}A,B\text{は実数で、}
  a_n = (A + B n) r^{n-1}
\text{の形で書ける。これで命題の主張が示された。Q.E.D}"""),

    StepItem(tex: r"""\textbf{【注意】}"""),
    StepItem(tex: r"""\text{命題中の議論は } r\neq0 \text{ を仮定している（ここは } r=5\neq0 \text{ なので問題ない）。}"""),
  ],
),


// ─────────────────────────────────────────────────────────────
// 問題: 変数係数漸化式（ウォリス類似注記つき）
// ─────────────────────────────────────────────────────────────
MathProblem(
  id: "48F0A009-A401-42C4-9AC5-E84555D43257",
  no: 16,
  category: '数列',
  level: '中級',
  question: r"""(n+1)a_n = (n-1)a_{n-1}, \quad a_1 = 2 \quad (n\ge2)""",
  answer: r"""a_n = \dfrac{4}{n(n+1)}""",
  // アップロード済み画像ファイルのローカルパス（開発環境で URL に変換されます）
  imageAsset: 'assets/graphs/sequences/problem_16.png',
  equation: r"""(n+1)a_n = (n-1)a_{n-1}""",
  conditions: r"""a_1 = 2""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{(n+1)で両辺を割って} a_n \text{ を } a_{n-1} \text{で表し、次に} a_{n-1} \text{ を } a_{n-2} \text{で表し、次に} a_{n-2} \text{ を } a_{n-3} \text{で表し、の流れを繰り返す。}"""),
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""\text{(1) 漸化式を変形する}"""),
    StepItem(tex: r"""\begin{aligned}
a_n &= \frac{n-1}{n+1}a_{n-1} \quad (n\ge2)
\end{aligned}"""),
    StepItem(tex: r"""\text{(2) 代入を繰り返す（積の形にする）}"""),
    StepItem(tex: r"""\begin{aligned}
a_n &= \frac{n-1}{n+1}a_{n-1} \\
&= \frac{n-1}{n+1} \cdot \frac{n-2}{n}a_{n-2} \\
&= \frac{n-1}{n+1} \cdot \frac{n-2}{n} \cdot \frac{n-3}{n-1}a_{n-3} \\
&= \frac{n-1}{n+1} \cdot \frac{n-2}{n} \cdot \frac{n-3}{n-1} \cdot \frac{n-4}{n-2}a_{n-4} \\
&= \frac{n-1}{n+1} \cdot \frac{n-2}{n} \cdot \frac{n-3}{n-1} \cdot \frac{n-4}{n-2} \cdot \frac{n-5}{n-3}a_{n-5} \\
&\cdots \\
&= \frac{n-1}{n+1} \cdot \frac{n-2}{n} \cdot \frac{n-3}{n-1} \cdot \frac{n-4}{n-2} \cdot \frac{n-5}{n-3} \cdots \frac{4}{6} \cdot \frac{3}{5} \cdot \frac{2}{4} \cdot \frac{1}{3} a_1\\
&\underset{a_1= 2}{=} \frac{n-1}{n+1} \cdot \frac{n-2}{n} \cdot \frac{n-3}{n-1} \cdot \frac{n-4}{n-2} \cdot \frac{n-5}{n-3} \cdots \frac{4}{6} \cdot \frac{3}{5} \cdot \frac{2}{4} \cdot \frac{1}{3} 2\\
&= \frac{\cancel{n-1}}{n+1} \cdot \frac{\cancel{n-2}}{n} \cdot \frac{\cancel{n-3}}{\cancel{n-1}} \cdot \frac{\cancel{n-4}}{\cancel{n-2}} \cdot \frac{\cancel{n-5}}{\cancel{n-3}} \cdots \frac{\cancel{4}}{\cencel{6}} \cdot \frac{\cancel{3}}{\cancel{5}} \cdot \frac{{2}}{\cancel{4}} \cdot \frac{1}{\cancel{3}} \cdot 2\\
& = \frac{4}{n(n+1)}
\end{aligned}"""),
    StepItem(tex: r"""\text{この式は}n=1\text{でも成り立つ。}"""),
    StepItem(tex: r"""\textbf{【補足(ウォリス積分)】}"""),
    StepItem(tex: r"""\text{この問題の漸化式は数列} I_n = \displaystyle \int_0^{\frac{\pi}{2}} \sin^n x \, dx,  ( \text{(または} I_n = \displaystyle \int_0^{\frac{\pi}{2}} \cos^n x \, dx  ) \text{の計算で現れる漸化式 } I_n=\dfrac{n-1}{n}I_{n-2} \text{ と類似しており、この積分} \displaystyle \int_0^{\frac{\pi}{2}} \sin^n x \, dx \text{ および } \displaystyle \int_0^{\frac{\pi}{2}} \cos^n x \, dx \text{をウォリス積分と言う。ここではこの数列に対する漸化式を導いておく。}"""),
    StepItem(tex: r"""\textbf{【導出(補足)】}"""),
    StepItem(tex: r""" I_n = \displaystyle \int_0^{\frac{\pi}{2}} \sin^n x \, dx \text{ または } I_n = \displaystyle \int_0^{\frac{\pi}{2}} \cos^n x \, dx \text{ に対して、部分積分を用いて漸化式を導く。}"""),
    StepItem(tex: r"""n\ge 2\text{のとき、} I_n = \displaystyle \int_0^{\frac{\pi}{2}} \sin^n x \, dx \text{ の場合、}"""),
    StepItem(tex: r"""\begin{aligned}
    I_n &= \displaystyle \int_0^{\frac{\pi}{2}} \sin^n x \, dx \\
    &= \displaystyle \int_0^{\frac{\pi}{2}} \sin^{n-1} x \cdot \sin x \, dx \\
    &= \displaystyle \int_0^{\frac{\pi}{2}} \sin^{n-1} x \cdot (-\cos x)' \, dx \\
    &= \left[ -\sin^{n-1} x \cos x \right]_0^{\frac{\pi}{2}} + (n-1) \displaystyle \int_0^{\frac{\pi}{2}} \sin^{n-2} x \cdot \cos^2 x \, dx \\    
    &= \left[ -\sin^{n-1} x \cos x \right]_0^{\frac{\pi}{2}} + (n-1) \displaystyle \int_0^{\frac{\pi}{2}} \sin^{n-2} x \cdot (1 - \sin^2 x) \, dx \\
    &= 0 + (n-1) \displaystyle \int_0^{\frac{\pi}{2}} \sin^{n-2} x (1 - \sin^2 x) \, dx \\
    &= (n-1) \left( \displaystyle \int_0^{\frac{\pi}{2}} \sin^{n-2} x \, dx - \displaystyle \int_0^{\frac{\pi}{2}} \sin^n x \, dx \right) \\
    &= (n-1)(I_{n-2} - I_n)
    \end{aligned}"""),
    StepItem(tex: r"""\text{これを整理すると、}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ I_n = (n-1)(I_{n-2} - I_n) \\
    &\Leftrightarrow I_n = (n-1)I_{n-2} - (n-1)I_n \\
    &\Leftrightarrow I_n + (n-1)I_n = (n-1)I_{n-2} \\
    &\Leftrightarrow nI_n = (n-1)I_{n-2}
    \end{aligned}"""),
    StepItem(tex: r"""\text{同様に、} I_n = \displaystyle \int_0^{\frac{\pi}{2}} \cos^n x \, dx \text{ の場合も、置換積分 } x = \frac{\pi}{2} - t \text{ を行うと、}"""),
    StepItem(tex: r"""\begin{aligned}
    I_n &= \displaystyle \int_0^{\frac{\pi}{2}} \cos^n x \, dx \\
    &= \displaystyle \int_{\frac{\pi}{2}}^{0} \cos^n \left(\frac{\pi}{2} - t\right) \, (-dt) \\
    &= \displaystyle \int_0^{\frac{\pi}{2}} \sin^n t \, dt \\
    &= \displaystyle \int_0^{\frac{\pi}{2}} \sin^n x \, dx
    \end{aligned}"""),
    StepItem(tex: r"""\text{よって、} \cos^n x \text{ の積分も } \sin^n x \text{ の積分と同じ漸化式 } I_n = \dfrac{n-1}{n}I_{n-2} \text{ を満たす。}"""),
  ],
),

// ────────────────────────────────────────────────
// 問題 17: 変数係数・非斉次（二項間）
// (n+2)a_n = n a_{n-1} + 4,   a_1 = 1  (n >= 2)
// ※ 右辺が定数なので、まず定数の形で解の一つを探し、それを引いて扱いやすい形にする。
// ────────────────────────────────────────────────
MathProblem(
  id: "43D15683-AB09-49EE-8412-0CCB4D260EAF",
  no: 17,
  category: '数列（変数係数・非斉次・二項間）',
  level: '上級',
  question: r"""
(n+2)a_n = n a_{n-1} + 4,\qquad a_1 = 1 \qquad (n\ge2)
""",
  answer: r"""a_n = \displaystyle -\frac{6}{(n+1)(n+2)} + 2 """,
  imageAsset: 'assets/graphs/sequences/problem_17.png',
  equation: r"""(n+2)a_n = n a_{n-1} + 4""",
  conditions: r"""a_1 = 1""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{右辺が定数なので解の一つを定数列} A \text{ の形で求め、これを使って変数係数の漸化式に帰着させる。}"""),

    StepItem(tex: r"""\textbf{【解法】}"""),

    StepItem(tex: r"""\text{解の形を定数列}A \text{と仮定して、元の漸化式に代入すると、} (n+2)A = nA + 4 \text{ である。}"""),

    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ (n+2)A = nA + 4 \\
    &\Leftrightarrow nA + 2A = nA + 4 \\
    &\Leftrightarrow 2A = 4 \\
    &\Leftrightarrow A = 2
    \end{aligned}"""),

    StepItem(tex: r"""\text{定数解 } A = 2 \text{ を元の漸化式に代入すると、} (n+2) \cdot 2 = n \cdot 2 + 4 \cdots (1) \text{ である。}"""),

    StepItem(tex: r"""\text{ここで、元の漸化式から(1)を引いて、新たな数列}b_n = a_n - 2\text{ を定義すると、変数係数の漸化式に帰着させることができる。実際、}"""),

    StepItem(tex: r"""
      \begin{aligned}
      (n+2)a_n &= n a_{n-1} + 4 \\
      (n+2) \cdot 2 &= n \cdot 2 + 4 \\
      \hline
      \ \ \ \ \ (n+2)(a_n - 2) &= n(a_{n-1} - 2) \\
      \end{aligned}
      """),

    StepItem(tex: r"""\text{ } b_n = a_n - 2 \text{ とおくと、}"""),

    StepItem(tex: r"""\text{ } b_1 = a_1 - 2 = 1 - 2 = -1 \text{ だから、}"""),

    StepItem(tex: r"""\begin{aligned}
    \begin{cases}
    \ (n+2)b_n = n b_{n-1} \\
    \ b_1 = -1
    \end{cases}
    \end{aligned}"""),

    StepItem(tex: r"""\text{(2) 漸化式を変形する}"""),

    StepItem(tex: r"""\begin{aligned}
    b_n &= \frac{n}{n+2}b_{n-1} \quad (n\ge2)
    \end{aligned}"""),

    StepItem(tex: r"""\text{(3) 代入を繰り返す（積の形にする）}"""),

    StepItem(tex: r"""\begin{aligned}
    b_n &= \frac{n}{n+2}b_{n-1} \\
    &= \frac{n}{n+2} \cdot \frac{n-1}{n+1}b_{n-2} \\
    &= \frac{n}{n+2} \cdot \frac{n-1}{n+1} \cdot \frac{n-2}{n}b_{n-3} \\
    &= \frac{n}{n+2} \cdot \frac{n-1}{n+1} \cdot \frac{n-2}{n} \cdot \frac{n-3}{n-1}b_{n-4} \\
    &\cdots \\
    &= \frac{n}{n+2} \cdot \frac{n-1}{n+1} \cdot \frac{n-2}{n} \cdot \frac{n-3}{n-1} \cdots \frac{3}{5} \cdot \frac{2}{4}  b_1\\
    \end{aligned}"""),
    StepItem(tex: r"""b_1 = -1 \text{より、}"""),
    StepItem(tex: r"""\begin{aligned}
    &= \frac{\cancel{n}}{n+2} \cdot \frac{\cancel{n-1}}{n+1} \cdot \frac{\cancel{n-2}}{\cancel{n}} \cdot \frac{\cancel{n-3}}{\cancel{n-1}} \cdots \frac{{3}}{\cancel{5}} \cdot \frac{{2}}{\cancel{4}} \cdot (-1)\\

    &= -\frac{6}{(n+1)(n+2)}
    \end{aligned}"""),

    StepItem(tex: r"""\text{よって、} b_n = -\displaystyle \frac{6}{(n+1)(n+2)} \text{ なので、}"""),

    StepItem(tex: r"""\begin{aligned}
    a_n &= b_n + 2 = \displaystyle -\frac{6}{(n+1)(n+2)} + 2
    \end{aligned}"""),
    StepItem(tex: r"""\text{この式は}n=1\text{でも成り立つ。}""")
  ],
),

// ────────────────────────────────────────────────
// 問題 18: 非線形（平方根・同次・二項間）
// a_n = sqrt(a_{n-1}),  a_1 = 16
// 解は a_n = 16^{1/2^{\,n-1}} で、初項を整えると綺麗に表せる。
// ────────────────────────────────────────────────
MathProblem(
  id: "5AE63216-BADE-46E5-A90B-18933C16F2FE",
  no: 18,
  category: '数列（非線形・ルート・二項間）',
  level: '中級',
  question: r"""
a_n = 4\sqrt{a_{n-1}},\qquad a_1 = 8 \qquad (n\ge2)
""",
  answer: r"""a_n = 16 \cdot 2^{-(\frac{1}{2})^{n-1}}""",
  imageAsset: 'assets/graphs/sequences/problem_18.png',
  equation: r"""a_n = 4\sqrt{a_{n-1}}""",
  conditions: r"""a_1 = 8""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{対数を取る。}"""),

    StepItem(tex: r"""\textbf{【解法】}"""),

    StepItem(tex: r"""\text{両辺、底が2の対数を取ると、}"""),
    StepItem(tex: r"""\log_2(a_n) = \log_2(4\sqrt{a_{n-1}}) = \log_2 4 + \frac{1}{2}\log_2 a_{n-1} = 2 + \frac{1}{2}\log_2 a_{n-1}"""),
    StepItem(tex: r"""x_n:=\log_2 a_n \text{ とおけば、}"""),
    StepItem(tex: r"""\text{これは1階線形漸化式 } x_n = \frac{1}{2}x_{n-1} + 2 \text{ である。特性方程式 } \alpha = \frac{1}{2}\alpha + 2 \text{ より } \alpha = 4 \text{ であるから、}"""),
    StepItem(tex: r"""\begin{aligned}
x_n - 4 &= \frac{1}{2}\left(x_{n-1} - 4\right) \\
&= \left(\frac{1}{2}\right)^{n-1}\left(x_1 - 4\right) \\
&= \left(\frac{1}{2}\right)^{n-1}\left(\log_2 8 - 4\right) \\
&= \left(\frac{1}{2}\right)^{n-1}(3 - 4) \\
&= -\left(\frac{1}{2}\right)^{n-1}
\end{aligned}"""),

    StepItem(tex: r"""\text{よって、} x_n = 4 - \left(\frac{1}{2}\right)^{n-1} \text{ である。}"""),
    StepItem(tex: r"""2^{x_n}= a_n \text{を用いて元に戻すと、}"""),
    StepItem(tex: r"""\begin{aligned}
a_n &= 2^{x_n} = 2^{4 - (\frac{1}{2})^{n-1}} = 16 \cdot 2^{-(\frac{1}{2})^{n-1}}
\end{aligned}"""),


  ],
),

// ────────────────────────────────────────────────
  // 問題 19: 非線形（べき・2乗・同次・二項間）
  // a_n = (a_{n-1})^2,  a_1 = 5
  // 解は a_n = 5^{2^{\,n-1}}（対数で扱うと整然とする）
  // ────────────────────────────────────────────────
  MathProblem(
    id: "AB08A968-36A0-40E9-B392-651BAE535DA9",
    no: 19,
    category: '数列（非線形・べき・二項間）',
    level: '上級',
  question: r"""
a_n = \frac {1}{2}(a_{n-1})^2,\qquad a_1 = 5 \qquad (n\ge2)
""",
  answer: r"""a_n = 2 \cdot \left(\dfrac{5}{2}\right)^{2^{\,n-1}}""",
  imageAsset: 'assets/graphs/sequences/problem_19.png',
  equation: r"""a_n = \frac{1}{2}(a_{n-1})^2""",
  conditions: r"""a_1 = 5""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{対数を取る。}"""),

    StepItem(tex: r"""\textbf{【解法】}"""),

    StepItem(tex: r"""\text{両辺、底が2の対数を取ると、}"""),
    StepItem(tex: r"""\log_2(a_n) = \log_2 \left(\frac {1}{2}(a_{n-1})^2\right) = -1 + 2\log_2(a_{n-1})"""),
    StepItem(tex: r"""x_n:=\log_2 a_n \text{ とおけば、}"""),
    StepItem(tex: r"""\text{これは1階線形漸化式 } x_n = - 1 + 2x_{n-1}  \text{ である。特性方程式 } \alpha = 2\alpha - 1 \text{ より } \alpha = 1 \text{ であるから、}"""),
    StepItem(tex: r"""\begin{aligned}
x_n - 1 &= 2\left(x_{n-1} - 1\right) \\
&= 2^{n-1}\left(x_1 - 1\right) \\
&= 2^{n-1}\left(\log_2 5 - 1\right)
\end{aligned}"""),
    StepItem(tex: r"""\text{よって、}"""),
    StepItem(tex: r"""\begin{aligned}
x_n &= 2^{n-1}\log_2 5 - 2^{n-1} + 1 \\
&= 2^{n-1}\log_2 5 + 1 - 2^{n-1}
\end{aligned}"""),

  StepItem(tex: r"""2^{x_n}= a_n \text{を用いて元に戻すと、}"""),
  StepItem(tex: r"""\begin{aligned}
a_n &= 2^{x_n} = 2^{2^{n-1}\log_2 5 + 1 - 2^{n-1}} \\
&= 2^{2^{n-1}\log_2 5} \cdot 2^{1 - 2^{n-1}} \\
&= \left(2^{\log_2 5}\right)^{2^{n-1}} \cdot 2 \cdot 2^{-2^{n-1}} \\
&= 5^{2^{n-1}} \cdot 2 \cdot 2^{-2^{n-1}} \\
&= 2 \cdot \frac{5^{2^{n-1}}}{2^{2^{n-1}}} \\
&= 2 \cdot \left(\frac{5}{2}\right)^{2^{n-1}}
\end{aligned}"""),
    StepItem(tex: r"""\text{例えば、} n = 4 \text{ のとき、}"""),
    StepItem(tex: r"""\begin{aligned}
a_4 &= 2 \cdot \left(\frac{5}{2}\right)^{2^{3}} = 2 \cdot \left(\frac{5}{2}\right)^{8}\\[5pt]
&= 2 \cdot \frac{5^8}{2^8} = 2 \cdot \frac{390625}{256} = \frac{390625}{128} \approx 3051.76
\end{aligned}"""),

    
  ],
),


];
