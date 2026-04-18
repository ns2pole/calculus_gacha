import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// ============================================================================
/// 不定方程式問題
/// ============================================================================

const indeterminateEquationProblems = <MathProblem>[
  // ────────────────────────────────
  // 問題 1: 1次不定方程式
  // ────────────────────────────────
  MathProblem(
    id: "DB513B4F-55DC-4AB9-87B7-1BCF5F47DC6A",
    no: 1,
    category: '不定方程式',
    level: '初級',
    question: r"""3x + 5y = 2""",
    answer: r"""x = 5k + 4,\ y = -3k - 2 \quad (kは整数)""",
    imageAsset: 'assets/graphs/indeterminate_equations/problem_1.png',
    steps: [
      StepItem(tex: r"""\textbf{【解法】}"""),
      StepItem(tex: r"""\text{ } 3x + 5y = 2 \text{ の解として } x = 4, y = -2 \text{ が見つかる。}"""),
      StepItem(tex: r"""\text{よって} 3\cdot 4 + 5\cdot (-2) = 2"""),
      StepItem(tex: r"""\text{ここで、元の式} 3x + 5y = 2 \text{から} 3\cdot 4 + 5\cdot (-2) = 2 \text{を引くと、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      3x + 5y = 2 \\
      3 \cdot 4 + 5 \cdot (-2) = 2 \\
      \hline
      3(x - 4) + 5(y + 2) = 0 
      \end{aligned}
      """),
      StepItem(tex: r"""3,5 \text{は互いに素なので} x-4 = 5k \text{ と } y+2 = -3k \text{となる整数} k \text{が存在する。よって、}"""),
  StepItem(tex: r"""\begin{aligned}
  &\ \ \ \ \  \begin{cases}
  x - 4 = 5k \\
  y + 2 = -3k
  \end{cases} \\
  &\Leftrightarrow \begin{cases}
  x = 5k + 4 \\
  y = -3k - 2
  \end{cases}
  \end{aligned} \quad (kは整数)"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 2: 1次不定方程式
  // ────────────────────────────────
  MathProblem(
    id: "E2B55755-0658-4FBE-911F-C18148799924",
    no: 2,
    category: '不定方程式',
    level: '初級',
    question: r"""4x - 7y = 1""",
    answer: r"""x = 7k + 2,\ y = 4k + 1 \quad (kは整数)""",
    imageAsset: 'assets/graphs/indeterminate_equations/problem_2.png',
    steps: [
      StepItem(tex: r"""\textbf{【解法】}"""),
      StepItem(tex: r"""\text{ } 4x - 7y = 1 \text{ の解として } x = 2, y = 1 \text{ が見つかる。}"""),
      StepItem(tex: r"""\text{よって} 4\cdot 2 - 7\cdot 1 = 1"""),
      StepItem(tex: r"""\text{ここで、元の式} 4x - 7y = 1 \text{から} 4\cdot 2 - 7\cdot 1 = 1 \text{を引くと、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      4x - 7y = 1 \\
      4 \cdot 2 - 7 \cdot 1 = 1 \\
      \hline
      4(x - 2) - 7(y - 1) = 0 
      \end{aligned}
      """),
      StepItem(tex: r"""4,7 \text{は互いに素なので} x-2 = 7k \text{ と } y-1 = 4k \text{となる整数} k \text{が存在する。よって、}"""),
      StepItem(tex: r"""\begin{aligned}
      &\ \ \ \ \  \begin{cases}
      x - 2 = 7k \\
      y - 1 = 4k
      \end{cases} \\
      &\Leftrightarrow \begin{cases}
      x = 7k + 2 \\
      y = 4k + 1
      \end{cases}
      \end{aligned} \quad (kは整数)"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 3: 1次不定方程式
  // ────────────────────────────────
  MathProblem(
    id: "4F6568BE-B67F-46E7-859C-F22766018567",
    no: 3,
    category: '不定方程式',
    level: '中級',
    question: r"""391x + 287y = 1""",
    answer: r"""x = 69 + 287k,\ y = -94 - 391k \quad (kは整数)""",
    imageAsset: 'assets/graphs/indeterminate_equations/problem_3.png',
    hint: r"""\text{互除法を用いて } 391x + 287y = 1 \text{ を満たす解を1つ求める。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{互除法を用いて } 391x + 287y = 1 \text{ を満たす解を1つ求める。}"""),
      StepItem(tex: r"""\textbf{【解法】}"""),
      StepItem(tex: r"""\text{互除法により、}"""),
      StepItem(tex: r"""\begin{aligned}
391 &= 287 \cdot 1 + 104 \\
287 &= 104 \cdot 2 + 79 \\
104 &= 79 \cdot 1 + 25 \\
79 &= 25 \cdot 3 + 4 \\
25 &= 4 \cdot 6 + 1 \\
4 &= 1 \cdot 4 + 0
\end{aligned}"""),
      StepItem(tex: r"""\text{逆算すると、}"""),
      StepItem(tex: r"""\begin{aligned}
1 &= 25 - 4 \cdot 6 \\
&= 25 - (79 - 25 \cdot 3) \cdot 6 \\
&= 25 \cdot 19 - 79 \cdot 6 \\
&= (104 - 79) \cdot 19 - 79 \cdot 6 \\
&= 104 \cdot 19 - 79 \cdot 25 \\
&= 104 \cdot 19 - (287 - 104 \cdot 2) \cdot 25 \\
&= 104 \cdot 69 - 287 \cdot 25 \\
&= (391 - 287) \cdot 69 - 287 \cdot 25 \\
&= 391 \cdot 69 - 287 \cdot 94
\end{aligned}"""),
      StepItem(tex: r"""\text{よって、 } 391 \cdot 69 + 287 \cdot (-94) = 1 \text{ であるから、}"""),
      StepItem(tex: r"""\text{1つの解は } (x_0, y_0) = (69, -94) \text{ である。}"""),
      StepItem(tex: r"""\text{よって} 391\cdot 69 + 287\cdot (-94) = 1"""),
      StepItem(tex: r"""\text{ここで、元の式} 391x + 287y = 1 \text{から} 391\cdot 69 + 287\cdot (-94) = 1 \text{を引くと、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      391x + 287y = 1 \\
      391 \cdot 69 + 287 \cdot (-94) = 1 \\
      \hline
      391(x - 69) + 287(y + 94) = 0 
      \end{aligned}
      """),
      StepItem(tex: r"""391,287 \text{は互いに素なので} x-69 = 287k \text{ と } y+94 = -391k \text{となる整数} k \text{が存在する。よって、}"""),
      StepItem(tex: r"""\begin{aligned}
      &\ \ \ \ \  \begin{cases}
      x - 69 = 287k \\
      y + 94 = -391k
      \end{cases} \\
      &\Leftrightarrow \begin{cases}
      x = 287k + 69 \\
      y = -391k - 94
      \end{cases}
      \end{aligned} \quad (kは整数)"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 4: 1次不定方程式
  // ────────────────────────────────
  MathProblem(
    id: "16F18597-C6FC-4AE9-B600-B230BB5F5405",
    no: 4,
    category: '不定方程式',
    level: '中級',
    question: r"""842x + 495y = 1""",
    answer: r"""x = -97 + 495k,\ y = 165 - 842k \quad (tは整数)""",
    imageAsset: 'assets/graphs/indeterminate_equations/problem_4.png',
    hint: r"""\text{互除法を用いて } 842x + 495y = 1 \text{ を満たす解を1つ求める。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{互除法を用いて } 842x + 495y = 1 \text{ を満たす解を1つ求める。}"""),
      StepItem(tex: r"""\textbf{【解法】}"""),
      StepItem(tex: r"""\text{互除法により、}"""),
      StepItem(tex: r"""\begin{aligned}
842 &= 495 \cdot 1 + 347 \\
495 &= 347 \cdot 1 + 148 \\
347 &= 148 \cdot 2 + 51 \\
148 &= 51 \cdot 2 + 46 \\
51 &= 46 \cdot 1 + 5 \\
46 &= 5 \cdot 9 + 1 \\
5 &= 1 \cdot 5 + 0
\end{aligned}"""),
      StepItem(tex: r"""\text{逆算すると、}"""),
      StepItem(tex: r"""\begin{aligned}
1 &= 46 - 5 \cdot 9 \\
&= 46 - (51 - 46) \cdot 9 \\
&= 46 \cdot 10 - 51 \cdot 9 \\
&= (148 - 51 \cdot 2) \cdot 10 - 51 \cdot 9 \\
&= 148 \cdot 10 - 51 \cdot 29 \\
&= 148 \cdot 10 - (347 - 148 \cdot 2) \cdot 29 \\
&= 148 \cdot 68 - 347 \cdot 29 \\
&= (495 - 347) \cdot 68 - 347 \cdot 29 \\
&= 495 \cdot 68 - 347 \cdot 97 \\
&= 495 \cdot 68 - (842 - 495) \cdot 97 \\
&= 842 \cdot (-97) + 495 \cdot 165
\end{aligned}"""),
      StepItem(tex: r"""\text{よって、 } 842 \cdot (-97) + 495 \cdot 165 = 1 \text{ であるから、}"""),
      StepItem(tex: r"""\text{1つの解は } (x_0, y_0) = (-97, 165) \text{ である。}"""),
      StepItem(tex: r"""\text{よって} 842\cdot (-97) + 495\cdot 165 = 1"""),
      StepItem(tex: r"""\text{ここで、元の式} 842x + 495y = 1 \text{から} 842\cdot (-97) + 495\cdot 165 = 1 \text{を引くと、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      842x + 495y = 1 \\
      842 \cdot (-97) + 495 \cdot 165 = 1 \\
      \hline
      842(x + 97) + 495(y - 165) = 0 
      \end{aligned}
      """),
      StepItem(tex: r"""842,495 \text{は互いに素なので} x+97 = 495k \text{ と } y-165 = -842k \text{となる整数} k \text{が存在する。よって、}"""),
      StepItem(tex: r"""\begin{aligned}
      &\ \ \ \ \  \begin{cases}
      x + 97 = 495k \\
      y - 165 = -842k
      \end{cases} \\
      &\Leftrightarrow \begin{cases}
      x = 495k - 97 \\
      y = -842k + 165
      \end{cases}
      \end{aligned} \quad (kは整数)"""),
    ],
  ),


// ────────────────────────────────
// 問題 6: x^2 + 2xy + 3y^2 = 27  （元 (14)）
// ────────────────────────────────
// MathProblem(
//   id: "1DBC903A-5066-44C5-B5D7-46E94C864775",
//   no: 6,
//   category: '二次形式',
//   level: '中級',
//   question: r"""x^2 + 2xy + 3y^2 = 18""",
//   answer: r"""{(x,y)=(4,1),(-6,1),(6,-1),(-4,-1),(0,3),(-6,3),(6,-3),(0,-3)}""",
//   imageAsset: '',
//   steps: [
//     StepItem(tex: r"""\textbf{【方針】}"""),
//     StepItem(tex: r"""\text{平方完成する。}"""),
//     StepItem(tex: r"""\textbf{【解法】}"""),
//     StepItem(tex: r"""\begin{aligned}
// x^2+2xy+3y^2 &= (x+y)^2 + 2y^2 = 27
// \end{aligned}"""),
//     StepItem(tex: r"""\text{ }(x+y)^2 = 27 - 2y^2\text{ より }27-2y^2\ge0\Leftrightarrow |y|\le3"""),
//     StepItem(tex: r"""\text{ }(x+y)^2 \text{は平方数なので、}y=0,\pm2 \text{は不定方程式の解にならない。}"""),
//     StepItem(tex: r"""\text{ 残りの場合について考える。}"""),
//     StepItem(tex: r"""\textcolor{blue}{y=1}\ \textcolor{blue}{ の場合}"""),
//     StepItem(tex: r"""\text{ }(x+1)^2=27-2\cdot 1^2=27-2=25\text{ より }x+1=\pm5 \Leftrightarrow \textcolor{green} {x=4}\textcolor{green}{または } \textcolor{green}{x=-6}"""),
//     StepItem(tex: r"""\textcolor{blue}{y=-1}\ \textcolor{blue}{ の場合}"""),
//     StepItem(tex: r"""\text{ }(x-1)^2=27-2\cdot (-1)^2=27-2=25\text{ より }x-1=\pm5 \Leftrightarrow \textcolor{green} { x=6}\textcolor{green}{または } \textcolor{green}{x=-4}"""),
//     StepItem(tex: r"""\textcolor{blue}{y=3}\ \textcolor{blue}{ の場合}"""),
//     StepItem(tex: r"""\text{ }(x+3)^2=27-2\cdot 3^2=27-18=9\text{ より }x+3=\pm3 \Leftrightarrow \textcolor{green} {x=0}\textcolor{green}{または } \textcolor{green}{x=-6}"""),
//     StepItem(tex: r"""\textcolor{blue}{y=-3}\ \textcolor{blue}{ の場合}"""),
//     StepItem(tex: r"""\text{ }(x-3)^2=27-2\cdot (-3)^2=27-18=9\text{ より }x-3=\pm3 \Leftrightarrow \textcolor{green} {x=6}\textcolor{green}{または } \textcolor{green}{x=0}"""),
//     StepItem(tex: r"""\text{よって }(x,y)=(4,1),(-6,1),(6,-1),(-4,-1),(0,3),(-6,3),(6,-3),(0,-3)"""),
//   ],
// ),

// ────────────────────────────────
// 問題 7: x^2 + xy + 2y^2 = 11  （元 (13)）
// ────────────────────────────────
MathProblem(
  id: "00E2A046-7CC1-48D5-ADCB-A48C3F5A250B",
  no: 7,
  category: '二次同次方程式',
  level: '中級',
  question: r"""x^2 + xy + 2y^2 = 11""",
  answer: r"""{(x,y)=(1,2),(-3,2),(3,-2),(-1,-2)}""",
  imageAsset: 'assets/graphs/indeterminate_equations/problem_7.png',
  hint: r"""\text{分数を避けて平方完成する。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{分数を避けて平方完成する。}"""),
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""\text{両辺を4倍すると、}"""),
    StepItem(tex: r"""\begin{aligned}
4x^2+4xy+8y^2 &= 44 \\
\Leftrightarrow (2x+y)^2+7y^2 &= 44
\end{aligned}"""),
    StepItem(tex: r"""\text{ }(2x+y)^2 = 44 - 7y^2\text{ より }44-7y^2\ge0\Leftrightarrow |y|\le2"""),
    StepItem(tex: r"""\text{※} (2x+y)^2 \text{は平方数なので、}y=2, -2 \text{のときを調べる。)}y=0\text{のときは、}44-0 =44, y=1\text{のときは} 44-7=37 \text{なので、平方数ではない。}"""),
    StepItem(tex: r"""\textcolor{blue}{y=2}\ \textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{ }(2x+2)^2=44-28=16\text{ より }2x+2=\pm4"""),
    StepItem(tex: r"""
    \begin{aligned}
    \begin{cases}
    &2x+2=4\Leftrightarrow \textcolor{green} {x=1}\text{ または }\\
    &2x+2=-4\Leftrightarrow \textcolor{green} {x=-3}
    \end{cases}
    \end{aligned}"""),
    StepItem(tex: r"""\textcolor{blue}{y=-2}\ \textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{ }(2x-2)^2=44-28=16\text{ より }2x-2=\pm4"""),
    StepItem(tex: r"""
    \begin{aligned}
    \begin{cases}
    &2x-2=4\Leftrightarrow \textcolor{green} {x=3}\text{ または }\\
    &2x-2=-4\Leftrightarrow \textcolor{green} {x=-1}
    \end{cases}
    \end{aligned}
    """),
    StepItem(tex: r"""\text{よって }(x,y)=(1,2),(-3,2),(3,-2),(-1,-2)\text{ である。}"""),
  ],
),

  // ────────────────────────────────
// 問題 8: xy + 3x - 8y = 33  （元 (6)）
// ────────────────────────────────
MathProblem(
  id: "EBA0562C-23C6-4DE1-95C1-94FB618E1073",
  no: 8,
  category: '不定方程式',
  level: '初級',
  question: r"""xy + 3x - 8y = 33""",
  answer: r"""{(x,y)=(9,6), (17,-2), (7,-12), (-1,-4), (11, 0), (5,-6)}\textcolor{green}{　6つ}""",
  imageAsset: 'assets/graphs/indeterminate_equations/problem_8.png',
  hint: r"""\text{1次式への因数分解を利用する。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{1次式への因数分解を利用する。}"""),
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""\text{恒等式 }xy+3x-8y = (x-8)(y+3)+24 \text{ を用いると、}"""),
    StepItem(tex: r"""\begin{aligned}
      &\ \ \ \ \ xy+3x-8y = 33 \\
      &  \Leftrightarrow (x-8)(y+3)+24 = 33 \\
      &  \Leftrightarrow (x-8)(y+3) = 9
      \end{aligned}
      """),
    StepItem(tex: r"""\text{ }9 \text{の約数の組を考えると、}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ (x-8,y+3)=(1,9),(9,1),(-1,-9),(-9,-1),(3,3),(-3,-3)\\[5pt]
    & \Leftrightarrow (x,y) = (9,6), (17,-2), (7,-12), (-1,-4), (11, 0), (5,-6)
      \end{aligned}"""),
  ],
),

// ────────────────────────────────
// 問題 9: xy - 2x - y = 5  （元 (7)）
// ────────────────────────────────
MathProblem(
  id: "AA271833-9840-40EE-924F-1D94AD63FEB6",
  no: 9,
  category: '不定方程式',
  level: '初級',
  question: r"""xy - 2x - y = 5""",
  answer: r"""{(x,y)=(2,9),(8,3),(0,-5),(-6,1)}\textcolor{green}{　4つ}""",
  imageAsset: 'assets/graphs/indeterminate_equations/problem_9.png',
  hint: r"""\text{1次式への因数分解を利用する。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{1次式への因数分解を利用する。}"""),
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""\text{恒等式 }xy-2x-y = (x-1)(y-2)-2 \text{ を用いると、}"""),
    StepItem(tex: r"""\begin{aligned}
      &\ \ \ \ \ xy-2x-y = 5 \\
      &  \Leftrightarrow (x-1)(y-2)-2 = 5 \\
      &  \Leftrightarrow (x-1)(y-2) = 7
      \end{aligned}
      """),
    StepItem(tex: r"""\text{ }7 \text{の約数の組を考えると、}"""),
    
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ (x-1,y-2)=(1,7),(7,1),(-1,-7),(-7,-1)\\
      & \Leftrightarrow (x,y) = (2,9), (8,3), (0,-5), (-6,1)
      \end{aligned}"""),
  ],
),

// ────────────────────────────────
// 問題 10: 1/x + 1/y = 1/7  （元 (8)）
// ────────────────────────────────
MathProblem(
  id: "70FFD2EF-5335-4593-86B4-0060A4295D31",
  no: 10,
  category: '有理方程式 → 不定方程式',
  level: '初級',
  question: r"""\frac{1}{x} + \frac{1}{y} = \frac{1}{7}""",
  answer: r"""(8,56),(14,14),(56,8),
        (6,-42),(-42,6)\textcolor{green}{　5つ}""",
  imageAsset: 'assets/graphs/indeterminate_equations/problem_10.png',
  hint: r"""\text{通分して1次式への因数分解を利用する。ただし、}x\neq0,\ y\neq0\text{ に注意する。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{通分して1次式への因数分解を利用する。ただし、}x\neq0,\ y\neq0\text{ に注意する。}"""),
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""\begin{aligned}
\frac{1}{x}+\frac{1}{y}&=\frac{1}{7} \\
\Leftrightarrow \frac{x+y}{xy}&=\frac{1}{7} \quad \text{かつ }\ x,y\neq0 \\
\Leftrightarrow 7(x+y)&=xy \quad \text{かつ }\ x,y\neq0 \\
\Leftrightarrow xy-7x-7y&=0 \quad \text{かつ }\ x,y\neq0
\end{aligned}"""),
    StepItem(tex: r"""\text{恒等式 }xy-7x-7y = (x-7)(y-7)-49 \text{ を用いると、}"""),
    StepItem(tex: r"""\begin{aligned}
      & \Leftrightarrow (x-7)(y-7)-49 = 0 \quad \text{かつ }\ x,y\neq0\\
      & \Leftrightarrow (x-7)(y-7) = 49\quad \text{かつ }\ x,y\neq0
    \end{aligned}
    """),
    StepItem(tex: r"""\text{ここで、} x \neq 0 , y \neq 0 \text{に注意して、} 49 \text{の約数の組を考えると、}"""),
    
    StepItem(tex: r"""\begin{aligned}
     &\ \ \ \ \ (x-7,y-7)=(1,49),(49,1),(-1,-49),(-49,-1),(-7,-7)\\
      & \Leftrightarrow (x,y) = (8,56), (56,8), (6,-42), (-42,6), (14,14)
      \end{aligned}"""),
  ],
),

// ────────────────────────────────
// 問題 12: 4x^2 - y^2 = 32
// ────────────────────────────────
MathProblem(
  id: "5B9CCE39-6329-4F9D-8E86-20D97B7760A2",
  no: 12,
  category: '二次式の因数分解',
  level: '初級',
  question: r"""4x^2 - y^2 = 32""",
  answer: r"""(3,2),(3,-2),(-3,2),(-3,-2)\textcolor{green}{　4つ}""",
  imageAsset: 'assets/graphs/indeterminate_equations/problem_12.png',
  hint: r"""\text{左辺を因数分解する。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{左辺を因数分解する。}"""),
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ 4x^2-y^2 =32 \\
&\Leftrightarrow (2x-y)(2x+y) =32
\end{aligned}"""),
    StepItem(tex: r"""\text{ }(2x-y)+(2x+y)=4x\text{ より、}2x-y\text{ と }2x+y\text{ の和は4の倍数でなければならない。}"""),
    StepItem(tex: r"""\text{ }32 \text{の約数の組のうち、和が4の倍数になるのは }(2x-y,2x+y)=(4,8),(8,4),(-4,-8),(-8,-4)\text{ のみ。これを解いて、}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ 2x-y=4 \\
    &\ \ \ \ \ 2x+y=8 \\
    &\Leftrightarrow \textcolor{green}{x=3,y=2}
    \end{aligned}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ 2x-y=8 \\
    &\ \ \ \ \ 2x+y=4 \\
    &\Leftrightarrow \textcolor{green}{x=3,y=-2}
    \end{aligned}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ 2x-y=-4 \\
    &\ \ \ \ \ 2x+y=-8 \\
    &\Leftrightarrow \textcolor{green}{x=-3,y=2}
    \end{aligned}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ 2x-y=-8 \\
    &\ \ \ \ \ 2x+y=-4 \\
    &\Leftrightarrow \textcolor{green}{x=-3,y=-2}
    \end{aligned}"""),
    StepItem(tex: r"""\text{よって、 }(x,y)=(3,2),(3,-2),(-3,2),(-3,-2)\text{ である。}"""),
  ],
),

// ────────────────────────────────
// 問題 13: x^2 - 2xy - 2x + 6y - 6 = 0
// ────────────────────────────────
MathProblem(
  id: "B8F9C5D2-4E6A-4F8B-9C1D-3A5B7C9D1E2F",
  no: 13,
  category: '二変数二次方程式（判別式）',
  level: '上級',
  question: r"""x^2 - 2xy - 2x + 6y - 6 = 0""",
  answer: r"""{(x,y)=(4,1),(6,3),(2,3),(0,1)}\textcolor{green}{　4つ}""",
  imageAsset: 'assets/graphs/indeterminate_equations/problem_13.png',
  hint: r"""\text{二次・一次項に注目し、二つの一次式の積に分解する。定数は後で調整する。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{二次・一次項に注目し、二つの一次式の積に分解する。定数は後で調整する。}"""),
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""x^2 - 2xy - 2x + 6y = (ax+by+c)(dx+ey+f) -cf\text{ とおく。すると、}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ x^2 - 2xy - 2x + 6y \\
    &= (ax+by+c)(dx+ey+f) -cf \\
    &= ad x^2 + (ae+bd) xy + (af+cd)x \\
    &\quad + be y^2 + (bf+ce) y + cf
    \end{aligned}"""),
    StepItem(tex: r"""\text{となる。二次・一次項の係数を比較すると、}"""),
    StepItem(tex: r"""\begin{cases}
    \textcolor{blue}{ad=1 \cdots} \textcolor{blue}{(1)}\\
    \textcolor{blue}{ae+bd=-2 \cdots} \textcolor{blue}{(2)}\\
    \textcolor{blue}{af+cd=-2 \cdots} \textcolor{blue}{(3)}\\
    \textcolor{blue}{be=0 \cdots} \textcolor{blue}{(4)}\\
    \textcolor{blue}{bf+ce=6 \cdots} \textcolor{blue}{(5)}
    \end{cases}"""),
    StepItem(tex: r"""\textcolor{blue}{(1)}\text{ より、}ad=1\text{ については }(1,1),(-1,-1)\text{ のいずれを選んでも符号が交換するだけなので、} \textcolor{green}{(a,d)=(1,1)} \text{とする。}"""),
    StepItem(tex: r"""\textcolor{blue}{(4)}\text{ より、}be=0\text{ なので }b=0\text{ または }e=0\text{ である。}"""),
    StepItem(tex: r"""\textcolor{blue}{(2)}\text{ より、}ae+bd=-2\text{ なので、}b=0\text{ とすると }e=-2\text{ となる。}"""),
    StepItem(tex: r"""\textcolor{blue}{(3)}\text{ より、}af+cd=-2 \Leftrightarrow f+c=-2"""),
    StepItem(tex: r"""\textcolor{blue}{(5)}\text{ より、}bf+ce=6 \Leftrightarrow -2c=6 \Leftrightarrow \textcolor{green}{c=-3}"""),
    StepItem(tex: r"""\text{ }f+c=-2\text{ より }f=1\text{ となる。}"""),
    StepItem(tex: r"""\text{したがって連立方程式(1)~(5)の整数解は }"""),
    StepItem(tex: r"""\begin{aligned}
    \textcolor{green} {(a,b,c,d,e,f)=(1,0,-3,1,-2,1)}
    \end{aligned}"""),
    StepItem(tex: r"""\text{したがって一次因子は } x-3 \text{ と } x-2y+1 \text{ である。}"""),
    StepItem(tex: r"""\text{よって、} x^2 - 2xy - 2x + 6y = (x-3)(x-2y+1) + 3"""),
    StepItem(tex: r"""\text{従って、元の方程式は } """),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ x^2-2xy-2x+6y-6=0 \\
    &  \Leftrightarrow (x-3)(x-2y+1) + 3 - 6=0 \\
    &  \Leftrightarrow (x-3)(x-2y+1)=3 \\ 
    &  \Leftrightarrow (x-3,x-2y+1)=(1,3),(3,1),(-1,-3),(-3,-1) \\ 
    \end{aligned}"""),
    StepItem(tex: r"""\text{各場合について連立方程式を解く。}"""),
    StepItem(tex: r"""\textcolor{blue}{(x-3,x-2y+1)=(1,3)}\text{ の場合}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ x-3=1 \\
    &\ \ \ \ \ x-2y+1=3 \\
    &\Leftrightarrow x=4,\ 4-2y+1=3 \\
    &\Leftrightarrow -2y=-2 \\
    &\Leftrightarrow \textcolor{green}{y=1,\ x=4}
    \end{aligned}"""),
    StepItem(tex: r"""\textcolor{blue}{(x-3,x-2y+1)=(3,1)}\text{ の場合}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ x-3=3 \\
    &\ \ \ \ \ x-2y+1=1 \\
    &\Leftrightarrow x=6,\ 6-2y+1=1 \\
    &\Leftrightarrow -2y=-6 \\
    &\Leftrightarrow \textcolor{green}{y=3,\ x=6}
    \end{aligned}"""),
    StepItem(tex: r"""\textcolor{blue}{(x-3,x-2y+1)=(-1,-3)}\text{ の場合}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ x-3=-1 \\
    &\ \ \ \ \ x-2y+1=-3 \\
    &\Leftrightarrow x=2,\ 2-2y+1=-3 \\
    &\Leftrightarrow -2y=-6 \\
    &\Leftrightarrow \textcolor{green}{y=3,\ x=2}
    \end{aligned}"""),
    StepItem(tex: r"""\textcolor{blue}{(x-3,x-2y+1)=(-3,-1)}\text{ の場合}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ x-3=-3 \\
    &\ \ \ \ \ x-2y+1=-1 \\
    &\Leftrightarrow x=0,\ 0-2y+1=-1 \\
    &\Leftrightarrow -2y=-2 \\
    &\Leftrightarrow \textcolor{green}{y=1,\ x=0}
    \end{aligned}"""),
    StepItem(tex: r"""\text{よって、整数解は }(x,y)=(4,1),(6,3),(2,3),(0,1)\text{ である。}"""),
  ],
),

MathProblem(
  id: "AF7A04F4-3FFC-435D-ACF7-C0741E7B23F8",
  no: 14,
  category: '二変数二次方程式（判別式）',
  level: '中級',
  question: r"""2x^2 + 11xy + 12y^2 - 5y - 5 = 0""",
  answer: r"""{(x,y)=(4,-1)}\textcolor{green}{　1つ}""",
  imageAsset: 'assets/graphs/indeterminate_equations/problem_14.png',
  hint: r"""\text{二次・一次項に注目し、二つの一次式の積に分解する。定数は後で調整する。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{二次・一次項に注目し、二つの一次式の積に分解する。定数は後で調整する。}"""),
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""2x^2 + 11xy + 12y^2 - 5y = (ax+by+c)(dx+ey+f) -cf\text{ とおく。すると、}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ 2x^2 + 11xy + 12y^2 - 5y \\
    &= (ax+by+c)(dx+ey+f) -cf \\
    &= ad x^2 + (ae+bd) xy + (af+cd)x \\
    &\quad + be y^2 + (bf+ce) y + cf
    \end{aligned}"""),
    StepItem(tex: r"""\text{となる。二次・一次項の係数を比較すると、}"""),
    StepItem(tex: r"""\begin{cases}
    \textcolor{blue}{ad=2 \cdots} \textcolor{blue}{(1)}\\
    \textcolor{blue}{ae+bd=11 \cdots} \textcolor{blue}{(2)}\\
    \textcolor{blue}{af+cd=0 \cdots} \textcolor{blue}{(3)}\\
    \textcolor{blue}{be=12 \cdots} \textcolor{blue}{(4)}\\
    \textcolor{blue}{bf+ce=-5 \cdots} \textcolor{blue}{(5)}
    \end{cases}"""),
    StepItem(tex: r"""\textcolor{blue}{(1)}\text{ より、}ad=2\text{ については }(1,2),(2,1),(-1,-2),(-2,-1)\text{ のいずれを選んでも符号や順序が交換するだけなので、} \textcolor{green}{(a,d)=(1,2)} \text{とする。}"""),
    StepItem(tex: r"""\textcolor{blue}{(2)}\text{ と }\textcolor{blue}{(4)}\text{ より、}be=12\text{ かつ }e+2b=11\text{ となる正の整数の組を探す。}"""),
    StepItem(tex: r"""b,e\text{どちらの正の数であるので候補を列挙すると }(b,e)=(1,12),(2,6),(3,4),(4,3),(6,2),(12,1)"""),
    StepItem(tex: r"""\text{条件 }e+2b=11\text{ を満たすのは }\textcolor{green}{(b,e)=(4,3)}\text{ のみ。}"""),
    StepItem(tex: r"""\textcolor{blue}{(3)}\text{ より、}af+cd=0 \Leftrightarrow f+2c=0 \Leftrightarrow f=-2c"""),
    StepItem(tex: r"""\textcolor{blue}{(5)}\text{ より、}bf+ce=-5 \Leftrightarrow 4f+3c=-5"""),
    StepItem(tex: r"""\text{ }f=-2c\text{ を代入して }4(-2c)+3c=-5 \Leftrightarrow -5c=-5 \Leftrightarrow \textcolor{green}{c=1}\text{よって} \textcolor{green}{f=-2}"""),
    StepItem(tex: r"""\text{したがって連立方程式(1)~(5)の整数解は }"""),
    StepItem(tex: r"""\begin{aligned}
    \textcolor{green} {(a,b,c,d,e,f)=(1,4,1,2,3,-2)}
    \end{aligned}"""),
    StepItem(tex: r"""\text{したがって一次因子は } x+4y+1 \text{ と } 2x+3y-2 \text{ である。}"""),
    StepItem(tex: r"""\text{よって、} 2x^2 + 11xy + 12y^2 - 5y = (x+4y+1)(2x+3y-2) + 2"""),
    StepItem(tex: r"""\text{従って、元の方程式は } """),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ 2x^2+11xy+12y^2-5y-5=0 \\
    &  \Leftrightarrow (x+4y+1)(2x+3y-2) + 2 - 5=0 \\
    &  \Leftrightarrow (x+4y+1)(2x+3y-2)=3 \\ 
    &  \Leftrightarrow (x+4y+1,2x+3y-2)=(1,3),(3,1),(-1,-3),(-3,-1) \\ 
    \end{aligned}"""),
    StepItem(tex: r"""\text{各場合について連立方程式を解く。}"""),
    StepItem(tex: r"""\textcolor{blue}{(x+4y+1,2x+3y-2)=(1,3)}\text{ の場合}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ x+4y+1=1 \\
    &\ \ \ \ \ 2x+3y-2=3 \\
    &\Leftrightarrow x+4y=0,\ 2x+3y=5 \\
    &\Leftrightarrow x=-4y\text{ を第2式に代入して }2(-4y)+3y=5 \\
    &\Leftrightarrow -5y=5 \\
    &\Leftrightarrow \textcolor{green}{y=-1,\ x=4}
    \end{aligned}"""),
    StepItem(tex: r"""\textcolor{blue}{(x+4y+1,2x+3y-2)=(3,1)}\text{ の場合}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ x+4y+1=3 \\
    &\ \ \ \ \ 2x+3y-2=1 \\
    &\Leftrightarrow x+4y=2,\ 2x+3y=3 \\
    &\Leftrightarrow \text{第1式×2: }2x+8y=4 \\
    &\Leftrightarrow \text{第2式から引いて }5y=1 \\
    &\Leftrightarrow y=\frac{1}{5}\textcolor{red}{（整数でない）}
    \end{aligned}"""),
    StepItem(tex: r"""\textcolor{blue}{(x+4y+1,2x+3y-2)=(-1,-3)}\text{ の場合}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ x+4y+1=-1 \\
    &\ \ \ \ \ 2x+3y-2=-3 \\
    &\Leftrightarrow x+4y=-2,\ 2x+3y=-1 \\
    &\Leftrightarrow \text{第1式×2: }2x+8y=-4 \\
    &\Leftrightarrow \text{第2式から引いて }5y=3 \\
    &\Leftrightarrow y=\frac{3}{5}\textcolor{red}{（整数でない）}
    \end{aligned}"""),
    StepItem(tex: r"""\textcolor{blue}{(x+4y+1,2x+3y-2)=(-3,-1)}\text{ の場合}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ x+4y+1=-3 \\
    &\ \ \ \ \ 2x+3y-2=-1 \\
    &\Leftrightarrow x+4y=-4,\ 2x+3y=1 \\
    &\Leftrightarrow \text{第1式×2: }2x+8y=-8 \\
    &\Leftrightarrow \text{第2式から引いて }5y=9 \\
    &\Leftrightarrow y=\frac{9}{5}\textcolor{red}{（整数でない）}
    \end{aligned}"""),
    StepItem(tex: r"""\text{よって、整数解は }(x,y)=(4,-1)\text{ のみ。}"""),
  ],
),


// ────────────────────────────────
// 問題 17: 3x^2−2xy+2y^2−2x+4y−1 = 0  （元 (17)）
// ────────────────────────────────
MathProblem(
  id: "595AEE6D-B85D-45AE-AB48-641EC064B6EB",
  no: 17,
  category: '二変数二次方程式（判別式）',
  level: '中級',
  question: r"""3x^2−2xy+2y^2−2x+4y−1=0""",
  answer: r"""{(x,y)=(-1,-2),(-1,-1),(1,-1),(1,0)}\textcolor{green}{　4つ}""",
  imageAsset: 'assets/graphs/indeterminate_equations/problem_17.png',
  hint: r"""\text{方程式を x の二次方程式と見て、判別式が平方数となる y を探索する。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{方程式を x の二次方程式と見て、判別式が平方数となる y を探索する。}"""),
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""\text{方程式を x について整理すると、}"""),
    StepItem(tex: r"""\begin{aligned}
    3x^2 - 2xy + 2y^2 - 2x + 4y - 1 &= 0 \\
    \Leftrightarrow 3x^2 - (2y+2)x + (2y^2+4y-1) &= 0
    \end{aligned}"""),
    StepItem(tex: r"""\text{解の公式より、}"""),
    StepItem(tex: r"""\begin{aligned}
    x &= \frac{(2y+2) \pm \sqrt{(2y+2)^2 - 12(2y^2+4y-1)}}{2 \cdot 3} \\
    &= \textcolor{blue}{\frac{2y+2 \pm \sqrt{\Delta}}{6}\cdots(1)}
    \end{aligned}"""),
    StepItem(tex: r"""\text{ここで、ルートの内部（判別式）は、}"""),
    StepItem(tex: r"""\begin{aligned}
    \Delta &= (2y+2)^2 - 12(2y^2+4y-1) \\
    &= 4y^2 + 8y + 4 - 24y^2 - 48y + 12 \\
    &= -20y^2 - 40y + 16\\
    &= -20(y^2 + 2y) + 16 \\
    &= -20\{(y + 1)^2 - 1\} + 16 \\
    &= -20(y + 1)^2 + 20 + 16 \\
    &= -20(y + 1)^2 + 36
    \end{aligned}"""),
    StepItem(tex: r"""\text{ }x \text{ が整数となるためには、} \Delta \ge 0 \text{ かつ } \Delta \text{ が平方数である必要がある。}"""),
    StepItem(tex: r"""\text{ }\Delta = -20(y + 1)^2 + 36 \ge 0 \text{ より、} (y + 1)^2 \le \frac{36}{20} = \frac{9}{5} = 1.8"""),
    StepItem(tex: r"""\text{よって、} y = -2, -1, 0 \text{ が候補である。}"""),
    StepItem(tex: r"""\text{各場合について } \Delta \text{ が平方数になるか調べる。}"""),
    StepItem(tex: r"""\textcolor{blue}{y = -2}\textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{ }\Delta = -20(-2 + 1)^2 + 36 = -20 + 36 = 16\text{（平方数）}"""),
    StepItem(tex: r"""\text{このとき、}\textcolor{blue}{(1)式}\  \textcolor{blue}{x =\frac{2y+2 \pm \sqrt{\Delta}}{6}}\text{に} y=-2\text{を代入して、} x = \frac{2(-2)+2 \pm \sqrt{16}}{6} = \frac{-2 \pm 4}{6} = -\frac{1}{3}, -1"""),
    StepItem(tex: r"""\text{整数解は } \textcolor{green}{x = -1} \text{ である。よって、} \textcolor{green}{(x,y) = (-1,-2)}"""),
    StepItem(tex: r"""\textcolor{blue}{y = -1}\textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{ }\Delta = -20(-1 + 1)^2 + 36 = 36 \text{（平方数）}"""),
    StepItem(tex: r"""\text{このとき、} y=-2\text{の場合と同様に、(1)にyの値を代入して、} x = \frac{2(-1)+2 \pm \sqrt{36}}{6} = \frac{0 \pm 6}{6} = 1, -1"""),
    StepItem(tex: r"""\text{整数解は } \textcolor{green}{x = -1, 1} \text{ である。よって、} \textcolor{green}{(x,y) = (-1,-1), (1,-1)}"""),
    StepItem(tex: r"""\text{ }\Delta = -20(0 + 1)^2 + 36 = -20 + 36 = 16 \text{（平方数）}"""),
    StepItem(tex: r"""\text{同様に(1)にyの値を代入して、} x = \frac{2 \cdot 0 + 2 \pm \sqrt{16}}{6} = \frac{2 \pm 4}{6} = 1, -\frac{1}{3}"""),
    StepItem(tex: r"""\text{整数解は } \textcolor{green}{x = 1} \text{ である。よって、} \textcolor{green}{(x,y) = (1,0)}"""),
    StepItem(tex: r"""\text{よって、整数解は } (x,y) = (-1,-2), (-1,-1), (1,-1), (1,0) \text{ である。}"""),
  ],
),

// ────────────────────────────────
// 問題 18: 5x^2 + 2xy + y^2 - 12x + 4y + 11 = 0  （元 (18)）
// ────────────────────────────────
MathProblem(
  id: "6ED3659C-A465-4E25-A2B2-4CAF4FEAEDA5",
  no: 18,
  category: '二変数二次方程式（判別式）',
  level: '中級',
  question: r"""5x^2 + 2xy + y^2 - 12x + 4y + 11 = 0""",
  answer: r"""{(x,y)=(2,-1),(2,-7)}\textcolor{green}{　2つ}""",
  imageAsset: 'assets/graphs/indeterminate_equations/problem_18.png',
  hint: r"""\text{方程式を y の二次方程式と見て，判別式が平方数になる整数 x を探索する。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{方程式を y の二次方程式と見て，判別式が平方数になる整数 x を探索する。}"""),
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""\text{方程式を y について整理すると、}"""),
    StepItem(tex: r"""\begin{aligned}
    5x^2 + 2xy + y^2 - 12x + 4y + 11 &= 0 \\
    \Leftrightarrow y^2 + (2x+4)y + (5x^2-12x+11) &= 0
    \end{aligned}"""),
    StepItem(tex: r"""\text{判別式を求めると、}"""),
    StepItem(tex: r"""\begin{aligned}
    \Delta &= (2x+4)^2 - 4(5x^2-12x+11) \\
    &= 4x^2 + 16x + 16 - 20x^2 + 48x - 44 \\
    &= -16x^2 + 64x - 28 \\
    &= -16(x^2 - 4x) - 28 \\
    &= -16\{(x - 2)^2 - 4\} - 28 \\
    &= -16(x - 2)^2 + 64 - 28 \\
    &= -16(x - 2)^2 + 36
    \end{aligned}"""),
    StepItem(tex: r"""x\text{が整数のとき、}\Delta\text{は、平方数であることが必要なので} -16(x - 2)^2 + 36 \ge 0 \text{ より、}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ -16(x - 2)^2 + 36 \ge 0 \\
    &\Leftrightarrow 16(x - 2)^2 \le 36 \\
    &\Leftrightarrow (x - 2)^2 \le \frac{9}{4} \\
    &\Leftrightarrow |x - 2| \le \frac{3}{2} \\
    &\Leftrightarrow \text{x は } 1, 2, 3 \text{ のいずれかである。}
    \end{aligned}"""),
    StepItem(tex: r"""x\text{が3通りに絞り込めたので、各場合について } \Delta = -16(x - 2)^2 + 36 \text{ が平方数になるか調べればよい。。}"""),
    StepItem(tex: r"""\textcolor{blue}{x = 1}\textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{ }\Delta = -16(1 - 2)^2 + 36 = 20 \text{（平方数でない）}"""),
    StepItem(tex: r"""\textcolor{blue}{x = 2}\textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{ }\Delta = -16(2 - 2)^2 + 36 = 36 \text{（平方数）}"""),
    StepItem(tex: r"""\text{このとき、方程式} 5x^2 + 2xy + y^2 - 12x + 4y + 11 = 0 \text{に}x =2\text{を代入すると}"""),
    StepItem(tex: r"""\begin{aligned}
    5 \cdot 2^2 + 2 \cdot 2 \cdot y + y^2 - 12 \cdot 2 + 4y + 11 = 0 \\
    \Leftrightarrow 20 + 4y + y^2 - 24 + 4y + 11 = 0 \\
    \Leftrightarrow y^2 + 8y +7 = 0 \\
    \Leftrightarrow \textcolor{green} {y = -1, -7}
    \end{aligned}"""),
    StepItem(tex: r"""\textcolor{blue}{x = 3}\textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{ }\Delta = -16(3 - 2)^2 + 36  = 20 \text{（平方数でない）}"""),
    StepItem(tex: r"""\text{よって、整数解は }(x,y)=(2,-1), (2,-7) \text{ である。}"""),
  ],
),

// ────────────────────────────────
// 問題 20: 1/x + 1/y + 1/z = 1 \quad (x < y < z)  （元 (20)）
// ────────────────────────────────
MathProblem(
  id: "479E7E6E-ED63-4F1A-BB39-42C4C598782D",
  no: 20,
  category: '有理方程式（分数和）',
  level: '中級',
    question: r"""\displaystyle \frac{1}{x} + \frac{1}{y} + \frac{1}{z} = 1 \qquad (0\le x \le y \le z)""",
    answer: r"""{(x,y,z)=(2,3,6), (2,4,4), (3,3,3)}\textcolor{green}{　3つ}""",
  imageAsset: '',
  hint: r"""x \text{ の範囲を制限する。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""x \text{ の範囲を制限する。}"""),
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""x \text{がもし4以上の整数ならば、}"""),
    StepItem(tex: r"""\begin{aligned}
    \displaystyle \frac{1}{x} + \frac{1}{y} + \frac{1}{z} \le \frac{1}{x} + \frac{1}{x} + \frac{1}{x} = \displaystyle \frac{3}{x} \le \dfrac 3 4 < 1
    \end{aligned}"""),
    StepItem(tex: r"""\text{よって、} x \le 3 \text{ である。}"""),
    StepItem(tex: r"""x = 1, 2, 3 \text{ の場合を調べる。}"""),
    StepItem(tex: r"""\textcolor{blue}{x = 1}\textcolor{blue}{ のときは、} 0 < \displaystyle \frac{1}{y} ,\frac{1}{z} \text{なので方程式を満たす} y, z \text{は存在しない。}"""),
    StepItem(tex: r"""\textcolor{blue}{x = 2}\textcolor{blue}{ のとき、} \displaystyle \frac{1}{2} + \frac{1}{y} + \frac{1}{z} = 1 \text{ より } \displaystyle \frac{1}{y} + \frac{1}{z} = \frac{1}{2} \text{ である。}"""),
    StepItem(tex: r"""\begin{aligned}
    \displaystyle \frac{1}{y} + \frac{1}{z} &= \frac{1}{2} \\
    \Leftrightarrow \displaystyle \frac{y+z}{yz} &= \frac{1}{2} \\
    \Leftrightarrow 2(y+z) &= yz \\
    \Leftrightarrow yz - 2y - 2z &= 0
    \end{aligned}"""),
    StepItem(tex: r"""\text{恒等式 }yz - 2y - 2z = (y-2)(z-2) - 4 \text{ を用いると、}"""),
    StepItem(tex: r"""\begin{aligned}
    (y-2)(z-2) - 4 &= 0 \\
    \Leftrightarrow (y-2)(z-2) &= 4
    \end{aligned}"""),
    StepItem(tex: r"""\text{ここで、} 2 \le y \le z \text{ より } 0 \le y-2 \le z-2 \text{ に注意して、} 4 \text{ の約数の組を考えると、}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ (y-2,z-2)=(1,4),(2,2) \\
    & \Leftrightarrow (y,z) = (3,6), (4,4)
    \end{aligned}"""),
    StepItem(tex: r"""\text{ }2 \le y \le z \text{ の条件を満たすのは } \textcolor{green}{(y,z) = (3,6), (4,4)} \text{ である。}"""),
    StepItem(tex: r"""\textcolor{blue}{x = 3}\textcolor{blue}{ のとき、} \displaystyle \frac{1}{3} + \frac{1}{y} + \frac{1}{z} = 1 \text{ より } \displaystyle \frac{1}{y} + \frac{1}{z} = \frac{2}{3} \text{ である。}"""),
    StepItem(tex: r"""\begin{aligned}
    \displaystyle \frac{1}{y} + \frac{1}{z} &= \frac{2}{3} \\
    \Leftrightarrow \displaystyle \frac{y+z}{yz} &= \frac{2}{3} \\
    \Leftrightarrow 3(y+z) &= 2yz \\
    \Leftrightarrow 2yz - 3y - 3z &= 0
    \end{aligned}"""),
    StepItem(tex: r"""\text{恒等式 }2yz - 3y - 3z = (2y-3)(2z-3) - 9 \text{ を用いると、}"""),
    StepItem(tex: r"""\begin{aligned}
    (2y-3)(2z-3) - 9 &= 0 \\
    \Leftrightarrow (2y-3)(2z-3) &= 9
    \end{aligned}"""),
    StepItem(tex: r"""\text{ここで、} 3 \le y \le z \text{ より } 3 \le 2y-3, 3 \le 2z-3 \text{ に注意して、} 9 \text{ の約数の組を考えると、}"""),
    StepItem(tex: r"""\begin{aligned}
    &\ \ \ \ \ (2y-3,2z-3)=(3,3) \\
    & \Leftrightarrow (y,z) = (3,3)
    \end{aligned}"""),
    StepItem(tex: r"""\text{ }3 \le y \le z \text{ の条件を満たすのは } \textcolor{green}{(y,z) = (3,3)} \text{ のみである。}"""),
    StepItem(tex: r"""\text{よって、整数解は }\textcolor{green}{(x,y,z)=(2,3,6),(2,4,4), (3,3,3)} \text{ である。}"""),
    
  ],
),



// ─────────────────────────────────────────────
// 問題 19: xyz = x + y + z  (x ≤ y ≤ z)
// ────────────────────────────────
MathProblem(
  id: "E8EA2D7A-4614-47AB-8934-8C7BCF3568C1",
  no: 19,
  category: '三変数方程式（場合分け）',
  level: '中級',
  question: r"""xyz = x + y + z \qquad (0< x \le y \le z)""",
  answer: r"""(1,2,3)\textcolor{green}{　1つ}""",
  imageAsset: '',
  hint: r"""\text{ }x \le y \le z \text{ の条件を使って } x+y+z \le 3z \text{として、} x,y \text{を有限個の候補に落とし込む。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{ }x \le y \le z \text{ の条件を使って } x+y+z \le 3z \text{として、} x,y \text{を有限個の候補に落とし込む。}"""),
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""\text{ }x \le y \le z \text{ より、}"""),
    StepItem(tex: r"""\begin{aligned}
    xyz &= x + y + z \\
    &\le z + z + z = 3z
    \end{aligned}"""),
    StepItem(tex: r"""xyz \le 3z \Leftrightarrow xy \le 3 \text{ である。}"""),
    StepItem(tex: r"""\text{従って、} x \le y \text{も含めて考慮すると、}(x,y) = (1,1), (1,2), (1,3), (2,2) \text{ が候補である。}"""),
    StepItem(tex: r"""\text{方程式にこれらの候補を代入すると、}"""),
    StepItem(tex: r"""\textcolor{blue}{(x,y) = (1,1)}\textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{方程式に } x = 1, y = 1 \text{ を代入すると、}"""),
    StepItem(tex: r"""\begin{aligned}
    1 \cdot 1 \cdot z &= 1 + 1 + z
    \end{aligned}"""),
    StepItem(tex: r"""\textcolor{red}{この式は成立しない。}"""),
    StepItem(tex: r"""\textcolor{blue}{(x,y) = (1,2)}\textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{方程式に } x = 1, y = 2 \text{ を代入すると、}"""),
    StepItem(tex: r"""\begin{aligned}
    1 \cdot 2 \cdot z &= 1 + 2 + z \\
    \Leftrightarrow 2z &= 3 + z \\
    \Leftrightarrow z &= 3
    \end{aligned}"""),
    StepItem(tex: r"""\text{よって、} \textcolor{green}{(x,y,z) = (1,2,3)} \text{ は解。}"""),
    StepItem(tex: r"""\textcolor{blue}{(x,y) = (1,3)}\textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{方程式に } x = 1, y = 3 \text{ を代入すると、}"""),
    StepItem(tex: r"""\begin{aligned}
    1 \cdot 3 \cdot z &= 1 + 3 + z \\
    \Leftrightarrow 3z &= 4 + z \\
    \Leftrightarrow 2z &= 4 \\
    \Leftrightarrow z &= 2
    \end{aligned}"""),
    StepItem(tex: r"""\text{しかしながら問題文より、}y \le z \text{ よって、} \textcolor{red}{この式は成立しない。}"""),
    StepItem(tex: r"""\textcolor{blue}{(x,y) = (2,2)}\textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{方程式に } x = 2, y = 2 \text{ を代入すると、}"""),
    StepItem(tex: r"""\begin{aligned}
    2 \cdot 2 \cdot z &= 2 + 2 + z \\
    \Leftrightarrow 4z &= 4 + z \\
    \Leftrightarrow 3z &= 4 \\
    \Leftrightarrow z &= \frac{4}{3}
    \end{aligned}"""),
    StepItem(tex: r"""\text{しかしながら問題文より、}y \le z \text{ よって、} \textcolor{red}{この式は成立しない。}"""),
    StepItem(tex: r"""\textcolor{blue}{(x,y) = (2,3)}\textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{方程式に } x = 2, y = 3 \text{ を代入すると、}"""),
    StepItem(tex: r"""\begin{aligned}
    2 \cdot 3 \cdot z &= 2 + 3 + z \\
    \Leftrightarrow 6z &= 5 + z \\
    \Leftrightarrow 5z &= 5 \\
    \Leftrightarrow z &= 1
    \end{aligned}"""),
    StepItem(tex: r"""\text{しかしながら問題文より、}y \le z \text{ よって、} \textcolor{red}{この式は成立しない。}"""),
    StepItem(tex: r"""\text{よって、整数解は }(x,y,z)=(1,2,3) \text{のみ。}"""),
  ],
),

MathProblem(
  id: "73F50D01-0B10-4D81-A565-163E48987C2E",
  no: 21,
  category: '不定方程式',
  level: '上級',
  question: r"""x^2 + 13y^2 = 413""",
  answer: r"""(x,y)=(20,1),(20,-1),(-20,1),(-20,-1),(19,2),(19,-2),(-19,2),(-19,-2)\textcolor{green}{　8つ}""",
  imageAsset: 'assets/graphs/indeterminate_equations/problem_21.png',
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{13で割った余り(mod 13)を使う。}"""),
    
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""\text{mod 13で考えると、}"""),
    StepItem(tex: r"""\begin{aligned}
    x^2 + 13y^2 &\equiv x^2 \pmod{13} \\
    413 &= 13 \times 31 + 10 \equiv 10 \pmod{13}
    \end{aligned}"""),
    StepItem(tex: r"""\text{よって } x^2 \equiv 10 \pmod{13} \text{ が必要である。}"""),
    StepItem(tex: r"""mod\ 13\text{での}x^2\text{の余りを調べると、}"""),
    StepItem(tex: r"""\begin{aligned}
    0^2 &\equiv 0,\quad 1^2 \equiv 1,\quad 2^2 \equiv 4,\quad 3^2 \equiv 9 \\
    4^2 &\equiv 3,\quad 5^2 \equiv 12,\quad 6^2 \equiv 10,\quad 7^2 \equiv 10 \\
    8^2 &\equiv 12,\quad 9^2 \equiv 3,\quad 10^2 \equiv 9,\quad 11^2 \equiv 4,\quad 12^2 \equiv 1
    \end{aligned}"""),
    StepItem(tex: r"""\text{したがって } x \equiv \pm 6 \pmod{13} \text{ または } x \equiv \pm 7 \pmod{13} \text{ である。}"""),
    StepItem(tex: r"""\text{よって、 } x = 13k \pm 6 \text{ または } x = 13k \pm 7 \text{ と表せる。}"""),
    StepItem(tex: r"""\text{ }x^2 \le 413 \text{ より } |x| \le 20 \text{ なので、候補は } x = \pm 6, \pm 7, \pm 19, \pm 20 \text{ である。}"""),
    StepItem(tex: r"""\text{各場合について } y^2 = \frac{413 - x^2}{13} \text{ が平方数になるか調べる。}"""),
    StepItem(tex: r"""\textcolor{blue}{x = \pm 20}\textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{ }y^2 = \frac{413 - 400}{13} = \frac{13}{13} = 1 \text{ より } \textcolor{green}{y = \pm 1}"""),
    StepItem(tex: r"""\textcolor{blue}{x = \pm 19}\textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{ }y^2 = \frac{413 - 361}{13} = 4 \text{ より } \textcolor{green}{y = \pm 2}"""),
    StepItem(tex: r"""\textcolor{red}{他の候補 } \textcolor{red}{6, \pm 7} \textcolor{red}{については、} \text{それぞれ} y^2 = \frac{413 - 6^2}{13} = \frac{377}{13} = 29 \text{ と } y^2 = \frac{413 - 7^2}{13} = \frac{364}{13} = 28 \text{ となり、}\textcolor{red}{平方数にならない。}"""),
    StepItem(tex: r"""\text{よって、整数解は }(x,y)=(20,1),(20,-1),(-20,1),(-20,-1),(19,2),(19,-2),(-19,2),(-19,-2)\text{ である。}"""),
  ],
),

// ────────────────────────────────
// 問題 22: x^3 + (3y - 5)x^2 - 7yx - 2 = 0
// ────────────────────────────────
MathProblem(
  id: "3F983683-4841-44A5-8A49-2AADB866B6D9",
  no: 22,
  category: '不定方程式',
  level: '上級',
  question: r"""x^3 + (3y - 5)x^2 - 7yx - 2 = 0""",
  answer: r"""{(x,y)=(2,-7)}\textcolor{green}{　1つ}""",
  imageAsset: 'assets/graphs/indeterminate_equations/problem_22.png',
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{定数分離と因数分解を用いて整数解を探索する。定数項 } -2 \text{ に注目し、} x \text{ の候補を絞り込む。}"""),
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""\text{方程式を } y \text{ について整理すると、}"""),
    StepItem(tex: r"""\begin{aligned}
    x^3 + (3y - 5)x^2 - 7yx - 2 &= 0 \\
    \Leftrightarrow x(x^2 - 5x - 2 + 3yx - 7y) &= 2 \\
    \end{aligned}"""),
    StepItem(tex: r"""\text{定数項 } 2 \text{ に注目すると、} x \text{ の候補は}"""),
    StepItem(tex: r"""\text{ }x = 1,-1,2,-2 \text{のいずれか。}"""),
    StepItem(tex: r"""\textcolor{blue}{x = 1のとき、}"""),
    StepItem(tex: r"""\begin{aligned}
    1^3 + (3y - 5) \cdot 1^2 - 7y \cdot 1 - 2 &= 0 \\
    1 + 3y - 5 - 7y - 2 &= 0 \\
    -4y - 6 &= 0 \\
    y &= -\frac{3}{2}
    \end{aligned}"""),
    StepItem(tex: r"""\text{ }\textcolor{red}{y は整数ではない。}"""),
    StepItem(tex: r"""\textcolor{blue}{x = -1のとき、}"""),
    StepItem(tex: r"""\begin{aligned}
    (-1)^3 + (3y - 5) \cdot (-1)^2 - 7y \cdot (-1) - 2 &= 0 \\
    -1 + 3y - 5 + 7y - 2 &= 0 \\
    10y - 8 &= 0 \\
    y &= \frac{4}{5}
    \end{aligned}"""),
    StepItem(tex: r"""\text{ }\textcolor{red}{y は整数ではない。}"""),
    StepItem(tex: r"""\textcolor{blue}{x = 2のとき、}"""),
    StepItem(tex: r"""\begin{aligned}
    2^3 + (3y - 5) \cdot 2^2 - 7y \cdot 2 - 2 &= 0 \\
    8 + 4(3y - 5) - 14y - 2 &= 0 \\
    8 + 12y - 20 - 14y - 2 &= 0 \\
    -2y - 14 &= 0 \\
    y &= -7
    \end{aligned}"""),
    StepItem(tex: r"""\text{よって、} \textcolor{green}{(x, y) = (2, -7)} \text{ は整数解。}"""),
    StepItem(tex: r"""\textcolor{blue}{x = -2のとき、}"""),
    StepItem(tex: r"""\begin{aligned}
    (-2)^3 + (3y - 5) \cdot (-2)^2 - 7y \cdot (-2) - 2 &= 0 \\
    -8 + 4(3y - 5) + 14y - 2 &= 0 \\
    -8 + 12y - 20 + 14y - 2 &= 0 \\
    26y - 30 &= 0 \\
    y &= \frac{15}{13}
    \end{aligned}"""),
    StepItem(tex: r"""\text{ }\textcolor{red}{y は整数ではない。}"""),
    StepItem(tex: r"""\text{以上より、整数解は } (x, y) = (2, -7) \text{ のみである。}"""),
  ],
),

// ────────────────────────────────
// 問題 23: abcd = a + b + c + d  (0 < a, b, c, d)
// ────────────────────────────────
MathProblem(
  id: "C0367E7C-E68E-4377-B638-8C6EDB803AEB",
  no: 23,
  category: '四変数方程式（場合分け）',
  level: '中級',
  question: r"""abcd = a + b + c + d \qquad (0 < a, b, c, d)""",
  answer: r"""{(a,b,c,d)=(1,1,2,4)とその順列。すなわち、}
  \begin{aligned}
    (a,b,c,d) = &(1,1,2,4), (1,1,4,2), (1,2,1,4), (1,2,4,1),\\
    &(1,4,1,2), (1,4,2,1), (2,1,1,4), (2,1,4,1),\\
    &(2,4,1,1), (4,1,1,2), (4,1,2,1), (4,2,1,1)\textcolor{green}{　12つ}
    \end{aligned}
  """,
  imageAsset: '',
  hint: r"""\text{対称性から } a \le b \le c \le d \text{ と仮定し、範囲を絞り込む。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{対称性から } a \le b \le c \le d \text{ と仮定し、範囲を絞り込む。}"""),
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""\text{ }a \le b \le c \le d \text{ より、}"""),
    StepItem(tex: r"""\begin{aligned}
    abcd &= a + b + c + d \\
    &\le d + d + d + d = 4d
    \end{aligned}"""),
    StepItem(tex: r"""abcd \le 4d \Leftrightarrow abc \le 4\cdots(1) \text{ である。}"""),
    StepItem(tex: r"""\text{また、}a=2\text{とすると、}b,c\text{がaよりも大きい事から、}(1)\text{を満たさないので、}a=1\text{となる。}"""),
    StepItem(tex: r"""\text{ }a = 1 \text{ より、}b \le c \text{ かつ } bc \le 4 \text{ より、候補は限られる。}"""),
    StepItem(tex: r"""\textcolor{blue}{a = 1}\textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{ }bc \le 4 \text{ より、} (b,c) = (1,1), (1,2), (1,3), (1,4), (2,2) \text{ が候補。}"""),
    StepItem(tex: r"""\textcolor{blue}{(a,b,c) = (1,1,1)}\textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{方程式に代入すると、}"""),
    StepItem(tex: r"""\begin{aligned}
    1 \cdot 1 \cdot 1 \cdot d &= 1 + 1 + 1 + d \\
    \Leftrightarrow d &= 3 + d
    \end{aligned}"""),
    StepItem(tex: r"""\textcolor{red}{これは成立しない。}"""),
    StepItem(tex: r"""\textcolor{blue}{(a,b,c) = (1,1,2)}\textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{方程式に代入すると、}"""),
    StepItem(tex: r"""\begin{aligned}
    1 \cdot 1 \cdot 2 \cdot d &= 1 + 1 + 2 + d \\
    \Leftrightarrow 2d &= 4 + d \\
    \Leftrightarrow d &= 4
    \end{aligned}"""),
    StepItem(tex: r"""\text{よって、} \textcolor{green}{(a,b,c,d) = (1,1,2,4)} \text{ は解。}"""),
    StepItem(tex: r"""\textcolor{blue}{(a,b,c) = (1,1,3)}\textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{方程式に代入すると、}"""),
    StepItem(tex: r"""\begin{aligned}
    1 \cdot 1 \cdot 3 \cdot d &= 1 + 1 + 3 + d \\
    \Leftrightarrow 3d &= 5 + d \\
    \Leftrightarrow d &= \frac{5}{2}
    \end{aligned}"""),
    StepItem(tex: r"""\text{ } \textcolor{red}{d は整数解ではない。}"""),
    StepItem(tex: r"""\textcolor{blue}{(a,b,c) = (1,1,4)}\textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{方程式に代入すると、}"""),
    StepItem(tex: r"""\begin{aligned}
    1 \cdot 1 \cdot 4 \cdot d &= 1 + 1 + 4 + d \\
    \Leftrightarrow 4d &= 6 + d \\
    \Leftrightarrow d &= 2
    \end{aligned}"""),
    StepItem(tex: r"""\text{しかし } c \le d \text{ より } 4 \le 2 \text{ となり} \textcolor{red}{そもそもの場合分けの条件を満たさない。}"""),
    StepItem(tex: r"""\textcolor{blue}{(a,b,c) = (1,2,2)}\textcolor{blue}{ の場合}"""),
    StepItem(tex: r"""\text{方程式に代入すると、}"""),
    StepItem(tex: r"""\begin{aligned}
    1 \cdot 2 \cdot 2 \cdot d &= 1 + 2 + 2 + d \\
    \Leftrightarrow 4d &= 5 + d \\
    \Leftrightarrow d &= \frac{5}{3}
    \end{aligned}"""),
    StepItem(tex: r"""\text{ } \textcolor{red}{d は整数解ではない。}"""),
    StepItem(tex: r"""\text{よって、} a \le b \le c \le d \text{ の条件下では } (a,b,c,d) = (1,1,2,4) \text{ のみが解。}"""),
    StepItem(tex: r"""\text{問題は順序の制約がないため、} 1, 1, 2, 4 \text{ の順列すべてが解となる。すなわち、}"""),
    StepItem(tex: r"""\begin{aligned}
    (a,b,c,d) = &(1,1,2,4), (1,1,4,2), (1,2,1,4), (1,2,4,1),\\
    &(1,4,1,2), (1,4,2,1), (2,1,1,4), (2,1,4,1),\\
    &(2,4,1,1), (4,1,1,2), (4,1,2,1), (4,2,1,1)
    \end{aligned}"""),
  ]),

// ────────────────────────────────
// 問題 5: 17x + 29y + 61z = 3
// ────────────────────────────────
MathProblem(
  id: "FBFAA113-A701-4D94-9421-3AEF3FA2A96E",
  no: 5,
  category: '不定方程式',
  level: '上級',
  question: r"""17x + 29y + 61z = 3""",
  answer: r"""
  \begin{aligned}
  &\begin{cases}
  x = 29k + 36 - 732\ell\\
  y = -17k - 21 + 427\ell\\
  z = \ell
  \end{cases}
  \end{aligned}
  \quad (k, \ellは整数)""",
  imageAsset: null,
  hint: r"""\text{係数 }17,29\text{ の最大公約数は }1\text{ であり、このことにより任意の }z\text{ に対して，方程式 }17x+29y+61z=3\text{ の整数解 }x,y\text{ が存在する。よって適当に }z\text{ を定め、その値に対する全ての} (x,y) \text{を求めることで一般解を求める。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{係数 }17,29\text{ の最大公約数は }1\text{ であり、このことにより任意の }z\text{ に対して，方程式 }17x+29y+61z=3\text{ の整数解 }x,y\text{ が存在する。よって適当に }z\text{ を定め、その値に対する全ての} (x,y) \text{を求めることで一般解を求める。}"""),
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""\text{今，適当に 整数}z \text{ を定め，それを }\ell\text{ とする。すなわち }z=\ell \text{ とおき，方程式を}17x+29y=3-61\ell\text{ として、}\ell \text{を一つ固定してそれについて解き、一般解は全ての整数}\ell\text{を集めたものとして表す。}"""),

    StepItem(tex: r"""\textbf{【解を1つ見つける】}"""),
    StepItem(tex: r"""\text{まず，}17x+29y=1\text{ の解を互除法を用いて求める。}"""),
    StepItem(tex: r"""\text{互除法により、}"""),
    StepItem(tex: r"""\begin{aligned}
29 &= 17 \cdot 1 + 12 \\
17 &= 12 \cdot 1 + 5 \\
12 &= 5 \cdot 2 + 2 \\
5 &= 2 \cdot 2 + 1 \\
2 &= 1 \cdot 2 + 0
\end{aligned}"""),
    StepItem(tex: r"""\text{逆算すると、}"""),
    StepItem(tex: r"""\begin{aligned}
1 &= 5 - 2 \cdot 2 \\
&= 5 - (12 - 5 \cdot 2) \cdot 2 \\
&= 5 \cdot 5 - 12 \cdot 2 \\
&= (17 - 12) \cdot 5 - 12 \cdot 2 \\
&= 17 \cdot 5 - 12 \cdot 7 \\
&= 17 \cdot 5 - (29 - 17) \cdot 7 \\
&= 17 \cdot 12 - 29 \cdot 7
\end{aligned}"""),
    StepItem(tex: r"""\text{よって、 } 17 \cdot 12 + 29 \cdot (-7) = 1 \text{ であるから、}"""),
    StepItem(tex: r"""\text{1つの解は } (x, y) = (12, -7) \text{ である。}"""),
    StepItem(tex: r"""\text{したがって両辺を，} 3-61\ell \text{倍すると、} 17x+29y=3-61\ell \text{ の解}(x_0,y_0)=(12(3-61\ell),-7(3-61\ell))\text{ が見つかる。}"""),
    StepItem(tex: r"""\text{すなわち、} 17 \cdot 12(3-61\ell) + 29 \cdot (-7)(3-61\ell) = 3-61\ell"""),
    StepItem(tex: r"""\textbf{【一般解の構成】}"""),
    StepItem(tex: r"""\text{ここで、式} 17x+29y=3-61\ell \text{から} 17 \cdot 12(3-61\ell) + 29 \cdot (-7)(3-61\ell) = 3-61\ell \text{を引くと、}"""),
    StepItem(tex: r"""
    \begin{aligned}
    17x + 29y &= 3-61\ell \\
    17 \cdot 12(3-61\ell) + 29 \cdot (-7)(3-61\ell) &= 3-61\ell \\
    \hline
    17(x - 12(3-61\ell)) + 29(y - (-7)(3-61\ell)) &= 0 
    \end{aligned}
    """),
    StepItem(tex: r"""17,29 \text{は互いに素なので、}
    \begin{aligned}
    \begin{cases} 
    x-12(3-61\ell) = 29k \\
    y-(-7)(3-61\ell) = -17k
    \end{cases}
    \end{aligned}
    \text{となる整数} k \text{が存在する。よって、}"""),
    StepItem(tex: r"""
    \begin{aligned}
    &\ \ \ \ \ 
    \begin{cases} 
    x - 12(3-61\ell) = 29k \\
    y-(-7)(3-61\ell) = -17k
    \end{cases}\\
    &\Leftrightarrow
    \begin{cases} 
    x = 12(3 - 61\ell) + 29k = 29k + 36 - 732\ell\\
    y = -7(3 - 61\ell) - 17k = -17k - 21 + 427\ell
    \end{cases}
    \end{aligned}
    """),
    StepItem(tex: r"""
    \text{が与えられた、}z = \ell \text{ に対する全ての解なので、問題の方程式} 17x+29y+61z=3 \text{ の一般解は}
    \begin{cases} 
    x = 29k + 36 - 732\ell,\\
    y = -17k - 21 + 427\ell\\
    z = \ell
    \end{cases}
    \text{である。ただし、} k,\ell \text{は任意の整数。}
    """),
  ],
),

// ────────────────────────────────
// 問題 24: 7x - 3y + 13z = 2
// ────────────────────────────────
MathProblem(
  id: "B1D8559E-D3F4-45DA-A889-8056A50EE5A8",
  no: 24,
  category: '不定方程式',
  level: '中級',
  question: r"""7x - 3y + 13z = 2""",
  answer: r"""
  \begin{aligned}
  x &= 3k + 2 - 13\ell,\\
  y &= 7k + 4 - 26\ell,\\
  z &= \ell 
  \end{aligned}
  \quad (k, \ellは整数)""",
  imageAsset: null,
  hint: r"""\text{係数 }3,7\text{ の最大公約数は }1\text{ であり、このことにより任意の }z\text{ に対して，方程式 }7x-3y+13z=2\text{ の整数解 }x,y\text{ が存在する。よって適当に }z\text{ を定め、その値に対する全ての} (x,y) \text{を求めることで一般解を求める。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{係数 }3,7\text{ の最大公約数は }1\text{ であり、このことにより任意の }z\text{ に対して，方程式 }7x-3y+13z=2\text{ の整数解 }x,y\text{ が存在する。よって適当に }z\text{ を定め、その値に対する全ての} (x,y) \text{を求めることで一般解を求める。}"""),
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""\text{今，適当に 整数}z \text{ を定め，それを }\ell\text{ とする。すなわち }z=\ell \text{ とおき，方程式を}7x-3y=2-13\ell\text{ として、}\ell \text{を一つ固定してそれについて解き、一般解は全ての整数}\ell\text{を集めたものとして表す。}"""),

    StepItem(tex: r"""\textbf{【解を1つ見つける】}"""),
    StepItem(tex: r"""\text{まず，}7x-3y=1\text{ の解として、}(x,y)=(1,2)\text{ が見つかる。}"""),
    StepItem(tex: r"""\text{したがって両辺を，} 2-13\ell \text{倍すると、} 7x-3y=2-13\ell \text{ の解}(x_0,y_0)=(2-13\ell,2(2-13\ell))\text{ が見つかる。}"""),
    StepItem(tex: r"""\text{すなわち、} 7 \cdot (2-13\ell) - 3 \cdot 2(2-13\ell) = 2-13\ell"""),
    StepItem(tex: r"""\textbf{【一般解の構成】}"""),
    StepItem(tex: r"""\text{ここで、式} 7x-3y=2-13\ell \text{から} 7 \cdot (2-13\ell) - 3 \cdot 2(2-13\ell) = 2-13\ell \text{を引くと、}"""),
    StepItem(tex: r"""
    \begin{aligned}
    7x - 3y &= 2-13\ell \\
    7 \cdot (2-13\ell) - 3 \cdot 2(2-13\ell) &= 2-13\ell \\
    \hline
    7(x - (2-13\ell)) - 3(y - 2(2-13\ell)) &= 0 
    \end{aligned}
    """),
    StepItem(tex: r"""7,3 \text{は互いに素なので、}
    \begin{aligned}
    \begin{cases} 
    &x-(2-13\ell) = 3k \\
    &y-2(2-13\ell) = 7k
    \end{cases}
    \end{aligned}
    \text{となる整数} k \text{が存在する。よって、}"""),
    StepItem(tex: r"""
    \begin{aligned}
    &\ \ \ \ \ 
    \begin{cases} 
    x - (2-13\ell) = 3k \\
    y-2(2-13\ell) = 7k
    \end{cases}\\
    &\Leftrightarrow
    \begin{cases} 
    x = (2 - 13\ell) + 3k = 3k + 2 - 13\ell\\
    y = 2(2 - 13\ell) + 7k = 7k + 4 - 26\ell
    \end{cases}
    \end{aligned}
    """),
    StepItem(tex: r"""
    \text{が与えられた、}z = \ell \text{ に対する全ての解なので、問題の方程式} 7x-3y+13z=2 \text{ の一般解は}
    \begin{cases} 
    x = 3k + 2 - 13\ell\\
    y = 7k + 4 - 26\ell\\
    z = \ell
    \end{cases}
    \text{である。ただし、} k,\ell \text{は任意の整数。}
    """),
  ],
),

// ────────────────────────────────
// 問題 25: x² + 6y² = 223
// ────────────────────────────────
MathProblem(
  id: "A8B9C0D1-E2F3-4A5B-6C7D-8E9F0A1B2C3",
  no: 25,
  category: '不定方程式',
  level: '上級',
  question: r"""x^2 + 6y^2 = 223""",
  answer: r"""(x,y)=(13,3),(13,-3),(-13,3),(-13,-3)\textcolor{green}{　4つ}""",
  imageAsset: 'assets/graphs/indeterminate_equations/problem_25.png',
  hint: r"""\text{mod 6で考える。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{mod 6で考える。}"""),
    
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""\text{mod 6で考えると、}"""),
    StepItem(tex: r"""\begin{aligned}
    6y^2 &\equiv 0 \pmod{6} \quad (\text{6の倍数}) \\
    223 &= 6 \times 37 + 1 \equiv 1 \pmod{6}
    \end{aligned}"""),
    StepItem(tex: r"""\text{よって、}"""),
    StepItem(tex: r"""\begin{aligned}
    x^2 + 6y^2 &\equiv x^2 \equiv 1 \pmod{6}
    \end{aligned}"""),
    StepItem(tex: r"""\text{mod 6での }x \text{ の値を調べると、}"""),
    StepItem(tex: r"""\begin{aligned}
    x \equiv 0 \pmod{6} &\Rightarrow x^2 \equiv 0 \pmod{6} \\
    x \equiv 1 \pmod{6} &\Rightarrow x^2 \equiv 1 \pmod{6} \\
    x \equiv 2 \pmod{6} &\Rightarrow x^2 \equiv 4 \pmod{6} \\
    x \equiv 3 \pmod{6} &\Rightarrow x^2 \equiv 9 \equiv 3 \pmod{6} \\
    x \equiv 4 \pmod{6} &\Rightarrow x^2 \equiv 16 \equiv 4 \pmod{6} \\
    x \equiv 5 \pmod{6} &\Rightarrow x^2 \equiv 25 \equiv 1 \pmod{6}
    \end{aligned}"""),
    StepItem(tex: r"""\text{したがって } x^2 \equiv 1 \pmod{6} \text{ より、} x \equiv 1, 5 \pmod{6} \text{ が必要である。}"""),
    StepItem(tex: r"""\text{また、} x^2 \le 223 \text{ より } |x| \le 14 \text{ である。}"""),
    StepItem(tex: r"""\text{候補は } x = \pm 1, \pm 5, \pm 7, \pm 11, \pm 13 \text{ である。}"""),
    StepItem(tex: r"""\text{各場合について } x^2 + 6y^2 = 223 \text{ を満たす整数 } y \text{ を求める。}"""),
    StepItem(tex: r"""\textcolor{blue}{x = \pm 1 の場合}"""),
    StepItem(tex: r"""\begin{aligned}
    1 + 6y^2 &= 223 \\
    6y^2 &= 222 \\
    y^2 &= 37
    \end{aligned}"""),
    StepItem(tex: r"""\text{37は平方数ではないので}\textcolor{red}{解なし}"""),
    StepItem(tex: r"""\textcolor{blue}{x = \pm 5 の場合}"""),
    StepItem(tex: r"""\begin{aligned}
    25 + 6y^2 &= 223 \\
    6y^2 &= 198 \\
    y^2 &= 33
    \end{aligned}"""),
    StepItem(tex: r"""\text{33は平方数ではないので}\textcolor{red}{解なし}"""),
    StepItem(tex: r"""\textcolor{blue}{x = \pm 7 の場合}"""),
    StepItem(tex: r"""\begin{aligned}
    49 + 6y^2 &= 223 \\
    6y^2 &= 174 \\
    y^2 &= 29
    \end{aligned}"""),
    StepItem(tex: r"""\text{29は平方数ではないので}\textcolor{red}{解なし}"""),
    StepItem(tex: r"""\textcolor{blue}{x = \pm 11 の場合}"""),
    StepItem(tex: r"""\begin{aligned}
    121 + 6y^2 &= 223 \\
    6y^2 &= 102 \\
    y^2 &= 17
    \end{aligned}"""),
    StepItem(tex: r"""\text{17は平方数ではないので}\textcolor{red}{解なし}"""),
    StepItem(tex: r"""\textcolor{blue}{x = \pm 13 の場合}"""),
    StepItem(tex: r"""\begin{aligned}
    169 + 6y^2 &= 223 \\
    6y^2 &= 54 \\
    y^2 &= 9 \\
    \textcolor{green}{y} & \textcolor{green}{= \pm 3}
    \end{aligned}"""),
    
    StepItem(tex: r"""\text{よって、整数解は }(x,y)=(13,3),(13,-3),(-13,3),(-13,-3)\text{ である。}"""),
  ],
),
];
