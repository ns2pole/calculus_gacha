// squeeze_limits.dart
// 挟みうち原理問題集（7問）


import '../../models/math_problem.dart';
import '../../models/step_item.dart';

const squeeze_limits = <MathProblem>[
  MathProblem(
    id: "C1F3E989-594D-446A-8E94-FD7E70C7450F",
    no: 1,
    category: 'はさみうち',
    level: '初級',
    question: r"""\displaystyle \lim_{x\to 0}x\sin\!\left(\frac{1}{x}\right)""",
    answer: r"""\displaystyle 0""",
    imageAsset: 'assets/graphs/limit/problems_squeeze_limits/problem_1.png',
    hint: r"""はさみうちの原理を用いる""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""はさみうちの原理を用いる"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\begin{aligned}
      -1
      &\le \sin\!\left(\frac{1}{x}\right)\le 1 \\[6pt]
      \Leftrightarrow \ -|x|
      &\le x\sin\!\left(\frac{1}{x}\right)\le |x|
      \end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} \lim_{x\to 0}|x| = 0 \text{なので、はさみうちの原理より、}"""),
      StepItem(tex: r""" \lim_{x\to 0}x\sin\!\left(\frac{1}{x}\right)=0"""),

    ],
  ),


  MathProblem(
    id: "A60C22EA-24D4-4C3B-A60A-90996784D9C5",
    no: 2,
    category: '比較（指数と階乗）',
    level: '中級',
    question: r"""\displaystyle \lim_{n\to\infty}\frac{2^{n}}{n!}""",
    answer: r"""\displaystyle 0""",
    imageAsset: 'assets/graphs/limit/problems_squeeze_limits/problem_2.png',
    hint: r"""\frac{2^{n}}{n!}=\prod_{k=1}^{n}\frac{2}{k} と書き，3 \le k \text{ では } \displaystyle \frac{2}{k} \le \frac{2}{3} \text{ が成り立つ事を用いて、はさみうちにする。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""), 
      StepItem(tex: r"""\frac{2^{n}}{n!}=\prod_{k=1}^{n}\frac{2}{k} と書き，"""),
      StepItem(tex: r"""3 \le k \text{ では } \displaystyle \frac{2}{k} \le \frac{2}{3} \text{ が成り立つ事を用いて、はさみうちにする。}"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\begin{aligned}
  0 &\le \frac{2^{n}}{n!}\\[6pt]
  &= \prod_{k=1}^{n}\frac{2}{k} \\[6pt]
  &= \left(\frac{2}{1}\cdot \frac{2}{2}\right)\cdot \prod_{k=3}^{n}\frac{2}{k} \\[6pt]
  &\le 2\cdot \left(\frac{2}{3}\right)^{\,n-2}
  \end{aligned}
  """),
  StepItem(tex: r"""\displaystyle \lim_{n\to\infty} 2 \cdot \left(\frac{2}{3}\right)^{\,n-2} = 0\text{ なので、はさみうちより、} \displaystyle \lim_{n\to\infty} \frac{2^{n}}{n!} = 0"""),
      StepItem(tex: r""""""),
      StepItem(tex: r"""\textbf{【補足：総乗記号】}
      """),StepItem(tex: r""" \displaystyle \prod_{k=m}^{n} a_k \ \ ( m\le n) \text{ は } a_m a_{m+1}\cdots a_n \text{ を表す。}"""),
      StepItem(tex: r"""\textbf{【補足：総乗記号の例】}"""),
      StepItem(tex: r"""
      \begin{aligned}
  \prod_{k=1}^{4} k
  &= 1\cdot 2\cdot 3\cdot 4 \\[4pt]
  &= 24 \\[10pt]
  \prod_{k=1}^{4}\frac{2}{k}
  &= \frac{2}{1}\cdot \frac{2}{2}\cdot \frac{2}{3}\cdot \frac{2}{4} \\[4pt]
  &= \frac{2^{4}}{1\cdot 2\cdot 3\cdot 4} \\[4pt]
  &= \frac{16}{24} \\[4pt]
  &= \frac{2}{3}
  \end{aligned}"""),
    ],
  ),

// MathProblem(
//   id: "BA602879-97B8-4390-9C29-51F3F35F1A49",
//   no: 3,
//   category: '合成関数の評価',
//   level: '中級',
//   question: r"""\displaystyle \lim_{x\to 0}\frac{\log(\cos x)}{x^{2}}""",
//   answer: r"""\displaystyle -\frac{1}{2}""",
//   imageAsset: 'assets/graphs/limit/problems_squeeze_limits/problem_3.png',
//   steps: [
//     StepItem(tex: r"""\textbf{【方針】 }"""),
//     StepItem(tex: r"""1-\cos x\le \displaystyle \frac{x^{2}}{2}\ \Rightarrow\ \log(\cos x)=\log\!\bigl(1-(1-\cos x)\bigr)."""),
//     StepItem(tex: r"""\textbf{【解答】}"""),
//     StepItem(tex: r"""\begin{aligned}
//     0
//     &\le 1-\cos x \\[4pt]
//     &\le \displaystyle \frac{x^{2}}{2} \\[6pt]
//     \Rightarrow\ \log(\cos x)
//     &= \log\!\bigl(1-(1-\cos x)\bigr) \\[4pt]
//     &\le -(1-\cos x) \\[4pt]
//     &\le -\displaystyle \frac{x^{2}}{2} \\[6pt]
//     \text{同様に下からも評価して極限を挟むと}
// \displaystyle \lim_{x\to 0}\frac{\log(\cos x)}{x^{2}} \\[4pt]
//     &= -\displaystyle \frac{1}{2}
//     \end{aligned}"""),
//   ],
// ),



// MathProblem(
//   id: "4B230368-1412-4DCA-A4BB-F20858B287B8",
//   no: 5,
//   category: '高次項抽出（対数）',
//   level: '中級',
//   question: r"""\displaystyle \lim_{x\to 0}\frac{\log(1+x)-x+\frac{x^{2}}{2}}{x^{3}}""",
//   answer: r"""\displaystyle \frac{1}{3}""",
//   imageAsset: 'assets/graphs/limit/problems_squeeze_limits/problem_5.png',
//   steps: [
//     StepItem(tex: r"""\textbf{【方針】 }"""),
//     StepItem(tex: r""" \log(1+x)\le x-\displaystyle \frac{x^{2}}{2}+\frac{x^{3}}{3}\text{等の不等式で挟む}"""),
//     StepItem(tex: r"""\textbf{【解答】}"""),
//     StepItem(tex: r"""\begin{aligned}
//     \frac{\log(1+x)-x+\frac{x^{2}}{2}}{x^{3}}
//     &\to \displaystyle \frac{1}{3}\quad(\text{詳細は両側からの評価で示す})
//     \end{aligned}"""),
//   ],
// ),

// MathProblem(
//   id: "4647C909-D762-4F20-9CA7-A575D58640B2",
//   no: 6,
//   category: '調和級数（差の極限）',
//   level: '上級',
//   question: r"""\displaystyle \lim_{n\to\infty}\left(\displaystyle \sum_{k=1}^{2n}\frac{1}{k}-\displaystyle \sum_{k=1}^{n}\frac{1}{k}\right)""",
//   answer: r"""\displaystyle \log 2""",
//   imageAsset: 'assets/graphs/limit/problems_squeeze_limits/problem_6.png',
//   steps: [
//     StepItem(tex: r"""\textbf{【方針】 }"""),
//     StepItem(tex: r""" \displaystyle \sum_{k=n+1}^{2n}\frac{1}{k}\ を\ \int_{n}^{2n}\dfrac{dx}{x}\ で挟む"""),
//     StepItem(tex: r"""\textbf{【解答】}"""),
//     StepItem(tex: r"""\begin{aligned}
//     \int_{n}^{2n}\frac{dx}{x}
//     &\le \displaystyle \sum_{k=n+1}^{2n}\frac{1}{k} \\[4pt]
//     &\le \int_{n-1}^{2n-1}\frac{dx}{x} \\[6pt]
//     \Rightarrow\ \log 2
//     &\le \displaystyle \sum_{k=n+1}^{2n}\frac{1}{k} \\[4pt]
//     &\le \log\!\left(\frac{2n-1}{n-1}\right) \\[6pt]
//     &\underset{n\to\infty}{\longrightarrow} \displaystyle \sum_{k=n+1}^{2n}\frac{1}{k} = \log 2
//     \end{aligned}"""),
//   ],
// ),

MathProblem(
  id: "26E37810-7237-4FC5-8876-910F55F7133E",
  no: 7,
  category: '左右極限の判定',
  level: '初級',
  question: r"""\displaystyle \lim_{x\to 0}\frac{|\sin x|}{x}""",
  answer: r"""\textbf{極限は存在しない}""",
  imageAsset: 'assets/graphs/limit/problems_squeeze_limits/problem_7.png',
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{右極限と左極限を比較する。}"""),
    StepItem(tex: r"""\textbf{【解答】}"""),
    StepItem(tex: r"""\begin{aligned}
    \lim_{x\to +0}\frac{|\sin x|}{x} & =\lim_{x\to +0}\frac{\sin x}{x} =1 \\[8pt]
    \lim_{x\to -0}\frac{|\sin x|}{x} & =\lim_{x\to -0}\frac{-\sin x}{x} =-1
    \end{aligned}"""),
    StepItem(tex: r"""\text{よって、右極限と左極限が一致しないため、極限は存在しない。}"""),
  ],
),

MathProblem(
  id: "A4F3C2D1-7B6E-4C2A-9E3B-1D8C0E7F5A12",
  no: 8,
  category: 'log n! の極限',
  level: '上級',
  question: r"""\displaystyle \lim_{n\to\infty}\frac{\log(n!)}{n\log n-n}""",
  answer: r"""\displaystyle 1""",
  imageAsset: 'assets/graphs/limit/problems_log_factorial/problem_1.png',
  hint: r"""\text{和 }\log(n!)=\displaystyle \sum_{k=1}^n\log k\text{ を }\int\log x\,dx\text{ ではさみうち}""",
  steps: [

    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{(1) }\log(n!)=\displaystyle \sum_{k=1}^n\log k\text{ とおく。}"""),
    StepItem(tex: r"""\text{(2) 単調増加関数 }\log x\text{ に対する積分評価で }\sum\log k\text{ をはさみうちする。}"""),
    StepItem(tex: r"""\text{(3) 主要項 }n\log n-n\text{ で割ってはさみうちし、極限を出す。}"""),

    StepItem(tex: r"""\textbf{【解答】}"""),
    StepItem(tex: r"""\text{まず }S_n:=\log(n!)=\displaystyle \sum_{k=1}^n\log k\text{ とおく。}"""),

    StepItem(tex: r"""\textbf{【積分ではさみうち】}"""),
    StepItem(tex: r"""\text{関数 }f(x)=\log x\text{ は }x>0\text{ で単調増加である。}"""),
    StepItem(tex: r"""\text{よって各 }k\ge1\text{ について区間 }[k,k+1]\text{ で } \log k\le \log x\le \log(k+1)\text{。}"""),

    StepItem(tex: r"""\text{両辺を }[k,k+1]\text{ で積分すると}"""),
    StepItem(tex: r"""\begin{aligned}
\log k
&\le \int_k^{k+1}\log x\,dx
\le \log(k+1).
\end{aligned}"""),

    StepItem(tex: r"""\text{これを }k=1,2,\dots,n\text{ で和をとると}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \sum_{k=1}^n \log k
&\le \int_{1}^{n+1}\log x\,dx
\le \displaystyle \sum_{k=1}^n \log(k+1).
\end{aligned}"""),

    StepItem(tex: r"""\text{右端の和は}\displaystyle \sum_{k=1}^n\log(k+1)=\displaystyle \sum_{j=2}^{n+1}\log j=\log((n+1)!) \text{ だから}"""),
    StepItem(tex: r"""\boxed{\displaystyle
\log(n!)\le \int_{1}^{n+1}\log x\,dx \le \log((n+1)!)
}"""),

    StepItem(tex: r"""\text{同様に区間 }[k-1,k]\text{ を用いると } \int_{1}^{n}\log x\,dx \le \log(n!)\text{ も得られる。}"""),
    StepItem(tex: r"""\text{よって}"""),
    StepItem(tex: r"""\boxed{\displaystyle
 \displaystyle \int_{1}^{n}\log x\,dx \le \log(n!)\le \int_{1}^{n+1}\log x\,dx
}"""),

    StepItem(tex: r"""\textbf{【積分の計算】}"""),
    StepItem(tex: r"""\displaystyle \int \log x\,dx = x\log x - x + C\text{ より}"""),
    StepItem(tex: r"""\begin{aligned}
\int_{1}^{n}\log x\,dx
&=\bigl[x\log x-x\bigr]_{1}^{n}
= n\log n-n+1,\\
\int_{1}^{n+1}\log x\,dx
&=\bigl[x\log x-x\bigr]_{1}^{n+1}
=(n+1)\log(n+1)-(n+1)+1.
\end{aligned}"""),

    StepItem(tex: r"""\text{したがって}"""),
    StepItem(tex: r"""\begin{aligned}
n\log n-n+1
\le \log(n!)
\le (n+1)\log(n+1)-(n+1)+1.
\end{aligned}"""),

    StepItem(tex: r"""\textbf{【はさみうち】}"""),
    StepItem(tex: r"""\text{両辺を }n\log n-n\ (>0)\text{ で割ると}"""),
    StepItem(tex: r"""\box{\begin{aligned}
\frac{n\log n-n+1}{n\log n-n}
\le \frac{\log(n!)}{n\log n-n}
\le \frac{(n+1)\log(n+1)-(n+1)+1}{n\log n-n}.
\end{aligned}}"""),

    StepItem(tex: r"""\textcolor{green}{左端は、 } \displaystyle 1+\frac{1}{n\log n-n}\to 1\ (n\to\infty)"""),
    StepItem(tex: r"""\textcolor{green}{右端は、 } \log(n+1)=\log n+\log\!\left(1+\frac1n\right)\text{ を用いて整理する。}"""),
StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \frac{(n+1)\log(n+1)-(n+1)+1}{n\log n-n}\\[5pt]
&=\frac{(n+1)\bigl(\log n+\log(1+\frac1n)\bigr)-(n+1)+1}{n\log n-n}\\[5pt]
&=\frac{(n+1)\log n+(n+1)\log(1+\frac1n)-n}{n\log n-n}\\[5pt]
&=\frac{n\log n-n+\log n+(n+1)\log(1+\frac1n)}{n\log n-n}\\[5pt]
&=1+\frac{\log n+(n+1)\log(1+\frac1n)}{n\log n-n}\\[5pt]
&=1+\frac{n\log(1+\frac1n)}{n\log n-n}
+\frac{\log n}{n\log n-n}
+\frac{\log(1+\frac1n)}{n\log n-n}\\[5pt]
&=1+\frac{\log(1+\frac1n)}{\log n-1}
+\frac{\log n}{n}\frac{1}{\log n-1}
+\frac{\log(1+\frac1n)}{n(\log n-1)}\\[5pt]
&=1+0 +0+0 = 1
\end{aligned}"""),


    StepItem(tex: r"""\text{よって}"""),
    StepItem(tex: r"""\boxed{\displaystyle 
\lim_{n\to\infty}\frac{(n+1)\log(n+1)-(n+1)+1}{n\log n-n}=1
}"""),
    StepItem(tex: r"""\text{したがって右端も }1\text{ に収束する。}"""),
    StepItem(tex: r"""\text{ゆえに、はさみうちより}"""),
    StepItem(tex: r"""\boxed{\displaystyle \lim_{n\to\infty}\frac{\log(n!)}{n\log n-n}=1}"""),
  ],
),



];
