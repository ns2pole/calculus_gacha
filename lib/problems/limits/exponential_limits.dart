// exponential_limits.dart
// 指数・対数極限問題集（10問）


import '../../models/math_problem.dart';
import '../../models/step_item.dart';

const exponential_limits = <MathProblem>[
// MathProblem(
//   id: "B79A4A4F-6B5F-440A-9103-9E9C5BCB09D1",
//   no: 1,
//   category: '指数の基本極限（平均値の定理）',
//   level: '初級',
//   question: r"""\displaystyle \lim_{x\to 0}\frac{e^{x}-1}{x}""",
//   answer: r"""\displaystyle 1""",
//   imageAsset: 'assets/graphs/limit/problems_exponential_limits/problem_1.png',
//   steps: [
//     StepItem(tex: r"""\textbf{【方針】 平均値の定理 }(\exists\,\xi)\text{ により }\dfrac{e^{x}-1}{x}=e^{\xi}"""),
//     StepItem(tex: r"""\begin{aligned}
//       \frac{e^{x}-1}{x}
//       &= e^{\xi}\quad(\xi\in(0,x)\ \text{または}\ (\!x,0\!)) \\[6pt]
//       \lim_{x\to 0}\frac{e^{x}-1}{x}
//       &= 1
//     \end{aligned}"""),
//   ],
// ),

// MathProblem(
//   id: "9716186B-D344-46B3-86B7-015ECFC26BEF",
//   no: 2,
//   category: '定数 e の極限（対数で挟み撃ち）',
//   level: '初級',
//   question: r"""\displaystyle \lim_{n\to\infty}\left(1+\frac{1}{n}\right)^{n}""",
//   answer: r"""\displaystyle e""",
//   imageAsset: 'assets/graphs/limit/problems_exponential_limits/problem_2.png',
//   steps: [
//     StepItem(tex: r"""\textbf{【方針】 } \log(1+u)\text{ の不等式 }\displaystyle \frac{u}{1+u}\le \log(1+u)\le u\ (u>-1)\text{で }u=\frac{1}{n}"""),
//     StepItem(tex: r"""\begin{aligned}
//       \frac{1}{1+\frac{1}{n}}
//       &\le n\,\log\!\Bigl(1+\frac{1}{n}\Bigr) \\[6pt]
//       &\le 1 \\[6pt]
//       &\underset{n\to\infty}{\longrightarrow} n\,\log\!\Bigl(1+\frac{1}{n}\Bigr) = 1 \\[6pt]
//       \Rightarrow\ &\underset{n\to\infty}{\longrightarrow} \Bigl(1+\frac{1}{n}\Bigr)^{n} = e
//     \end{aligned}"""),
//   ],
// ),

// MathProblem(
//   id: "C2C5B1E9-4C1B-4B8F-9DD5-8A2A1FD9D103",
//   no: 3,
//   category: '定数 e の極限（指数の微調整）',
//   level: '初級',
//   question: r"""\displaystyle \lim_{n\to\infty}\left(1+\frac{1}{n}\right)^{\,n+1}""",
//   answer: r"""\displaystyle e""",
//   imageAsset: 'assets/graphs/limit/problems_exponential_limits/problem_3.png',
//   steps: [
//     StepItem(tex: r"""\textbf{【方針】 } \left(1+\frac{1}{n}\right)^{n+1}=\left(1+\frac{1}{n}\right)^{n}\!\cdot\left(1+\frac{1}{n}\right)"""),
//     StepItem(tex: r"""\begin{aligned}
//       &\underset{n\to\infty}{\longrightarrow} \left(1+\frac{1}{n}\right)^{n+1}
//       =\left(\underset{n\to\infty}{\longrightarrow} \left(1+\frac{1}{n}\right)^{n}\right)\!\cdot\!\left(\underset{n\to\infty}{\longrightarrow} \left(1+\frac{1}{n}\right)\right)\\[4pt]
//       &= e\cdot 1 = e
//     \end{aligned}"""),
//   ],
// ),


// MathProblem(
//   id: "7C3E8A4D-9B07-4638-9C8D-0A6D9E3B1B7F",
//   no: 4,
//   category: '定数 e の極限（指数倍）',
//   level: '初級',
//   question: r"""\displaystyle \lim_{n\to\infty}\left(1+\frac{1}{n}\right)^{\,2n}""",
//   answer: r"""\displaystyle e^{2}""",
//   imageAsset: 'assets/graphs/limit/problems_exponential_limits/problem_4.png',
//   steps: [
//     StepItem(tex: r"""\textbf{【解答】}"""),
//     StepItem(tex: r"""\begin{aligned}
//       &\underset{n\to\infty}{\longrightarrow} \left(1+\frac{1}{n}\right)^{2n}
//       = \left(\underset{n\to\infty}{\longrightarrow} \left(1+\frac{1}{n}\right)^{n}\right)^{2}\\[6pt]
//       &= e^{2}
//     \end{aligned}"""),
//   ],
// ),

// MathProblem(
//   id: "D1455B62-14C6-4B5B-8A78-8A6700CCCA90",
//   no: 5,
//   category: '指数極限の微差',
//   level: '上級',
//   question: r"""\displaystyle \lim_{n\to\infty} n\!\left(\Bigl(1+\frac{1}{n}\Bigr)^{n}-e\right)""",
//   answer: r"""\displaystyle -\frac{e}{2}""",
//   imageAsset: 'assets/graphs/limit/problems_exponential_limits/problem_5.png',
//   steps: [
//     StepItem(tex: r"""\textbf{【方針】 } n\log(1+\frac{1}{n})=1-\frac{1}{2n}+o(\frac{1}{n})"""),
//     StepItem(tex: r"""\begin{aligned}
//       \Bigl(1+\frac{1}{n}\Bigr)^{n}
//       &= e\Bigl(1-\frac{1}{2n}+o\!\left(\frac{1}{n}\right)\Bigr) \\[6pt]
//       \Rightarrow\ n\!\left(\cdots\right)
//       &\to -\displaystyle \frac{e}{2}
//     \end{aligned}"""),
//   ],
// ),


// MathProblem(
//   id: "F5F0C2A9-1C9D-45CE-9F50-1B9B2E2E4D66",
//   no: 6,
//   category: '定数 e の極限（一般係数）',
//   level: '初級',
//   question: r"""\displaystyle \lim_{n\to\infty}\left(1+\frac{3}{n}\right)^{\,n}""",
//   answer: r"""\displaystyle e^{3}""",
//   imageAsset: 'assets/graphs/limit/problems_exponential_limits/problem_6.png',
//   steps: [
//     StepItem(tex: r"""\textbf{【方針】 } \left(1+\frac{c}{n}\right)^{n}\to e^{c}\ \ (c=3)"""),
//     StepItem(tex: r"""\begin{aligned}
//       &\underset{n\to\infty}{\longrightarrow} \left(1+\frac{3}{n}\right)^{n}
//       = \exp\!\left(\underset{n\to\infty}{\longrightarrow} n\log\!\left(1+\frac{3}{n}\right)\right) \\[4pt]
//       &= \exp\!\left(\underset{n\to\infty}{\longrightarrow} 3\,\frac{\log\!\left(1+\frac{3}{n}\right)}{\frac{3}{n}}\right)
//       = \exp(3)=e^{3}
//     \end{aligned}"""),
//   ],
// ),

// MathProblem(
//   id: "9B8A1F47-0D7B-4DE0-9F11-2E7A4BE6D2B2",
//   no: 7,
//   category: '定数 e の極限（負の係数）',
//   level: '初級',
//   question: r"""\displaystyle \lim_{n\to\infty}\left(1-\frac{1}{n}\right)^{\,n}""",
//   answer: r"""\displaystyle e^{-1}""",
//   imageAsset: 'assets/graphs/limit/problems_exponential_limits/problem_7.png',
//   steps: [
//     StepItem(tex: r"""\textbf{【方針】} \left(1+\frac{c}{n}\right)^{n}\to e^{c}\ を\ c=-1\ で適用"""),
//     StepItem(tex: r"""\begin{aligned}
//       &\underset{n\to\infty}{\longrightarrow} \left(1-\frac{1}{n}\right)^{n}
//       = \exp\!\left(\underset{n\to\infty}{\longrightarrow} n\log\!\left(1-\frac{1}{n}\right)\right) \\[4pt]
//       &= \exp\!\left(\underset{n\to\infty}{\longrightarrow} \frac{\log\!\left(1-\frac{1}{n}\right)}{-\frac{1}{n}}\right)
//       = \exp(-1)=e^{-1}
//     \end{aligned}"""),
//   ],
// ),
MathProblem(
  id: "7A1F3B90-6E2C-4D8A-9B4F-1C2D3E4F5A33",
  no: 1,
  category: 'ガンマ関数の極限',
  level: '中級',
  question: r"""\displaystyle \lim_{x\to\infty}\int_{0}^{x}t^{5}e^{-t}\,dt""",
  answer: r"""\displaystyle 120""",
  steps: [
    StepItem(tex: r"""\color{black}\textbf{【解答】}"""),
    StepItem(tex: r"""\color{black}\displaystyle \int_{0}^{x}t^{5}e^{-t}\,dt =\Bigl[-t^{5}e^{-t}\Bigr]_{0}^{x}+5\int_{0}^{x}t^{4}e^{-t}\,dt"""),
    StepItem(tex: r"""\color{black}\text{ここで }t=0\text{ のとき }t^{5}e^{-t}=0\text{ なので}"""),
    StepItem(tex: r"""\color{black} \ \ \ \ \ =-x^{5}e^{-x}+5\int_{0}^{x}t^{4}e^{-t}\,dt"""),

    StepItem(tex: r"""\color{black}\textbf{【もう1度、部分積分】}"""),
    
    StepItem(tex: r"""\color{black}\displaystyle \int_{0}^{x}t^{4}e^{-t}\,dt=\Bigl[-t^{4}e^{-t}\Bigr]_{0}^{x}+4\int_{0}^{x}t^{3}e^{-t}\,dt"""),
    StepItem(tex: r"""\color{black}\text{ }t=0\text{ では }t^{4}e^{-t}=0\text{ なので}"""),
    StepItem(tex: r"""\color{black}\ \ \ \ \ =-x^{4}e^{-x}+4\int_{0}^{x}t^{3}e^{-t}\,dt"""),
    StepItem(tex: r"""\color{black}\text{よって、 }"""),
    StepItem(tex: r"""\color{black}\begin{aligned}
 \int_{0}^{x}t^{5}e^{-t}\,dt
 &= -x^{5}e^{-x}+5\int_{0}^{x}t^{4}e^{-t}\,dt \\[4pt]
&= -x^{5}e^{-x}
+5\Bigl(-x^{4}e^{-x}
+4\int_{0}^{x}t^{3}e^{-t}\,dt\Bigr)\\[4pt]
&= -x^{5}e^{-x}-5x^{4}e^{-x}
+5\cdot4\int_{0}^{x}t^{3}e^{-t}\,dt
\end{aligned}"""),
    StepItem(tex: r"""\color{black}\text{以後も同様にして、積分の次数を }5,4,3,2,1,0\text{ と下げていける。}"""),
    StepItem(tex: r"""\color{black}\text{すると最終的に次の形になる。(第一項はすぐに後述するように、limを取ると消える)}"""),
    StepItem(tex: r"""\color{black}\begin{aligned}
\int_{0}^{x}t^{5}e^{-t}\,dt
&= -e^{-x}\Bigl(x^{5}+5x^{4}+5\cdot4x^{3}+5\cdot4\cdot3x^{2}+5\cdot4\cdot3\cdot2x+5!\Bigr)\\[4pt]
&\quad +5!\int_{0}^{x}e^{-t}\,dt
\end{aligned}"""),

    StepItem(tex: r"""\color{black}\textbf{【}x\to\infty\textbf{ とする】}"""),
    StepItem(tex: r"""\color{black}\text{ }e^{-x}\text{ は非常に速く }0\text{ に近づくので、}e^{-x}\times(\text{多項式})\to0\text{より、}"""),
    StepItem(tex: r"""\begin{aligned}
    \displaystyle \lim_{x\to \infty } \int_{0}^{x}t^{5}e^{-t}\,dt  &= 0 + 5!\int_{0}^{x}e^{-t}\,dt\\[5pt]
    &= 5!\int_{0}^{x}e^{-t}\,dt \\[5pt]
    &= 5!\lim_{x\to \infty } \Bigl[-e^{-t}\Bigr]_{0}^{x}\\[6pt]
    &= 5!\lim_{x\to \infty } (1-e^{-x}) \\[6pt]
    &= 5!(1-0)\\[6pt]
    &=\textcolor{green}{120}
    \end{aligned}
    """),
    StepItem(tex: r"""\color{black}\textbf{【補足：一般の }n\textbf{ とガンマ関数】}"""),
    StepItem(tex: r"""\color{black}\text{自然数 }n\text{ に対して }\displaystyle I_n(x)=\int_{0}^{x}t^{n}e^{-t}\,dt\text{ とおく。}"""),
    StepItem(tex: r"""\color{black}\text{ 部分積分より}"""),
    StepItem(tex: r"""\begin{aligned}
    I_n(x)&=\Bigl[-t^{n}e^{-t}\Bigr]_{0}^{x}+n\int_{0}^{x}t^{n-1}e^{-t}\,dt\\[6pt]
    &=-x^{n}e^{-x}+nI_{n-1}(x)
    \end{aligned}
    """),
    StepItem(tex: r"""\color{black}\text{この関係を繰り返し用いて }x\to\infty\text{ とすると、}\lim_{x\to\infty}I_n(x)=n!\text{ が得られる。}"""),
    StepItem(tex: r"""\color{black}\text{ガンマ関数は }\Gamma(s)=\displaystyle \int_{0}^{\infty}t^{s-1}e^{-t}\,dt\ (s>0)\text{ と定義され、}"""),
    StepItem(tex: r"""\color{black}\text{自然数 }n\text{ に対して }\Gamma(n+1)=n!\text{ が成り立つ。}"""),
  ],
),


// MathProblem(
//   id: "BA707FB0-6792-4F52-A32D-691C3C4C728C",
//   no: 9,
//   category: '級数による漸近（テイラー展開）',
//   level: '中級',
//   question: r"""\displaystyle \lim_{n\to\infty} n\!\left(\log\Bigl(1+\frac{1}{n}\Bigr)-\frac{1}{n}\right)""",
//   answer: r"""\displaystyle 0""",
//   imageAsset: 'assets/graphs/limit/problems_exponential_limits/problem_9.png',
//   steps: [
//     StepItem(tex: r"""\textbf{【方針】 } \log(1+u)\text{ のテイラー展開を用いる}"""),
//     StepItem(tex: r"""\begin{aligned}
//       \log\!\Bigl(1+\frac{1}{n}\Bigr)
//       &= \frac{1}{n} - \frac{1}{2n^{2}} + \frac{1}{3n^{3}} - \frac{1}{4n^{4}} + \cdots \\[6pt]
//       \log\!\Bigl(1+\frac{1}{n}\Bigr) - \frac{1}{n}
//       &= -\frac{1}{2n^{2}} + \frac{1}{3n^{3}} - \frac{1}{4n^{4}} + \cdots
//     \end{aligned}"""),
//     StepItem(tex: r"""\begin{aligned}
//       n\!\left(\log\Bigl(1+\frac{1}{n}\Bigr)-\frac{1}{n}\right)
//       &= -\frac{1}{2n} + \frac{1}{3n^{2}} - \frac{1}{4n^{3}} + \cdots \\[6pt]
//       &\underset{n\to\infty}{\longrightarrow} n\!\left(\log\Bigl(1+\frac{1}{n}\Bigr)-\frac{1}{n}\right) = 0
//     \end{aligned}"""),
//   ],
// ),

// MathProblem(
//   id: "631DB9BF-2CEB-4ABF-B179-E73A34061E42",
//   no: 10,
//   category: '追い出し（挟み撃ち）',
//   level: '中級',
//   question: r"""\displaystyle \lim_{n\to\infty} n\,\log\!\left(1+\frac{1}{n}\right)""",
//   answer: r"""\displaystyle 1""",
//   imageAsset: 'assets/graphs/limit/problems_exponential_limits/problem_10.png',
//   steps: [
//     StepItem(tex: r"""\textbf{【方針】 } \dfrac{u}{1+u}\le \log(1+u)\le u\ (u>-1) \text{ を } u=\dfrac{1}{n}\ に適用"""),
//     StepItem(tex: r"""\begin{aligned}
//       \frac{\frac{1}{n}}{1+\frac{1}{n}}
//       &\le \log\!\left(1+\frac{1}{n}\right) \\[6pt]
//       &\le \frac{1}{n} \\[6pt]
//       \Rightarrow\ \frac{1}{1+\frac{1}{n}}
//       &\le n\,\log\!\left(1+\frac{1}{n}\right) \\[6pt]
//       &\le 1 \\[6pt]
//       &\underset{n\to\infty}{\longrightarrow} n\,\log\!\left(1+\frac{1}{n}\right) = \displaystyle 1
//     \end{aligned}"""),
//   ],
// ),
];
