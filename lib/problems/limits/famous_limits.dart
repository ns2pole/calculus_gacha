// famous_limits.dart
// 有名な極限問題集（4問）


import '../../models/math_problem.dart';
import '../../models/step_item.dart';

const famous_limits = <MathProblem>[
  MathProblem(
    id: "AF028FDC-E4ED-4B5D-907A-FD053AA682F0",
    no: 1,
    category: 'メルカトル（交代）',
    level: '上級',
    question: r"""\displaystyle \lim_{n\to\infty}\displaystyle \sum_{k=1}^{n}\frac{(-1)^{k+1}}{k}""",
    answer: r"""\displaystyle \log 2""",
    imageAsset: 'assets/graphs/limit/problems_famous_limits/problem_1.png',
    hint: r"""\text{解答1：偶数部分和を変形して区分求積}\quad/\quad\text{解答2：積分表示と等比和で評価}""",
    steps: [
      StepItem(tex: r"""\textbf{【命題】}"""),
      StepItem(tex: r"""\displaystyle \sum_{k=1}^{\infty}\frac{(-1)^{k+1}}{k}=\log 2"""),

      // =========================
      // 解答1（今回作った方：区分求積）
      // =========================
      StepItem(tex: r"""\textbf{【解答1】（偶数部分和→区分求積）}"""),
      StepItem(tex: r"""\text{部分和 } S_n=\displaystyle \sum_{k=1}^{n}\frac{(-1)^{k+1}}{k}\text{ とおく。まず偶数部分和 }S_{2N}\text{ を調べる。}"""),

      StepItem(tex: r"""\textbf{【補題】}\ \displaystyle \sum_{k=1}^{2N}\frac{(-1)^{k+1}}{k}=\displaystyle \sum_{k=1}^{N}\frac{1}{N+k}"""),
     StepItem(tex: r"""\textbf{【補題の証明】}"""),
     StepItem(tex: r"""
\text{交代和}
\displaystyle \  1-\frac12+\frac13-\frac14+\cdots-\frac{1}{2N}
\text{ を考える。}\text{まずすべて正として足すと}"""),
     StepItem(tex: r"""
\displaystyle \  1+\frac12+\frac13+\frac14+\cdots+\frac{1}{2N}
"""),
     StepItem(tex: r"""\text{ここから負号が付いていた項} \displaystyle \  \frac12,\frac14,\ldots,\frac{1}{2N} \text{を2回引くと}"""),
StepItem(tex: r"""
\begin{aligned}
&\ \displaystyle \ \ \ \ \ \displaystyle \sum_{k=1}^{2N}\frac{(-1)^{k+1}}{k}\\[6pt]
&\displaystyle = 1-\frac12+\frac13-\frac14+\cdots-\frac{1}{2N}\\[6pt]
&\displaystyle =\left(1+\frac12+\cdots+\frac{1}{2N}\right)
-2\left(\frac12+\frac14+\cdots+\frac{1}{2N}\right)\\[6pt]
&\displaystyle =\left(1+\frac12+\cdots+\frac{1}{2N}\right)
-\left(1+\frac12+\cdots+\frac{1}{N}\right)\\[6pt]
& \displaystyle =\frac{1}{N+1}+\frac{1}{N+2}+\cdots+\frac{1}{2N}\\[6pt]
& \displaystyle  =\displaystyle \sum_{k=1}^{N}\frac{1}{N+k}
\end{aligned} \quad \text{Q.E.D}"""),
      StepItem(tex: r"""\text{補題より } S_{2N}=\displaystyle \sum_{k=1}^{N}\frac{1}{N+k} \text{これを }N\text{ で割って}"""),
      StepItem(tex: r"""\begin{aligned}
  S_{2N}
  &=\displaystyle \sum_{k=1}^{N}\frac{1}{N+k}
  =\frac1N\displaystyle \sum_{k=1}^{N}\frac{1}{1+\frac{k}{N}}.
  \end{aligned}"""),

      StepItem(tex: r"""\text{右辺は } \displaystyle f(x)=\frac{1}{1+x}\text{ の区間 }[0,1]\text{ 上のリーマン和であるから}"""),
      StepItem(tex: r"""\begin{aligned}
  \lim_{N\to\infty}S_{2N}   &=\lim_{N\to\infty}\frac1N\displaystyle \sum_{k=1}^{N}\frac{1}{1+\frac{k}{N}}\\[6pt]
  &=\int_{0}^{1}\frac{1}{1+x}\,dx\\[6pt]
  &=\Bigl[\log(1+x)\Bigr]_{0}^{1}\\[6pt]
  &=\log 2
  \end{aligned}"""),

      StepItem(tex: r"""\textbf{【注意：}S_{2N+1}\textbf{も同じ極限】}"""),
      StepItem(tex: r"""\begin{aligned}
  S_{2N+1} &=\displaystyle \sum_{k=1}^{2N+1}\frac{(-1)^{k+1}}{k}\\[6pt]
  &=\displaystyle \sum_{k=1}^{2N}\frac{(-1)^{k+1}}{k}+\frac{1}{2N+1}\\[6pt]
  &= S_{2N}+\frac{1}{2N+1}
  \end{aligned}"""),
      StepItem(tex: r"""\text{よって }\displaystyle S_{2N+1}-S_{2N}=\frac{1}{2N+1}\to 0 \ (N\to\infty)\text{したがって}"""),
      StepItem(tex: r"""\lim_{N\to\infty}S_{2N}=\log 2 \ \Rightarrow\ \lim_{N\to\infty}S_{2N+1}=\log 2 \text{ でもある。}"""),
      StepItem(tex: r"""\text{偶数・奇数の部分和が同じ極限 } \log 2 \text{ に収束するので、全体の部分和 }S_n\text{ も } \log 2 \text{ に収束する。}"""),

      // =========================
      // 解答2（既存no=1の方：積分表示）
      // =========================
      StepItem(tex: r"""\textbf{【解答2】（積分表示→等比数列の和）}"""),
      StepItem(tex: r"""\text{各項は } \displaystyle \frac{(-1)^{k+1}}{k}=\int_0^1 (-t)^{k-1}\,dt \text{ と表せる。}"""),
      StepItem(tex: r"""\begin{aligned}
  S_n&=\displaystyle \sum_{k=1}^{n}\frac{(-1)^{k+1}}{k}\\[6pt]
  &=\displaystyle \sum_{k=1}^{n}\int_0^1 (-t)^{k-1}\,dt\\[6pt]
  &=\int_0^1\displaystyle \sum_{k=0}^{n-1}(-t)^k\,dt
  \end{aligned}"""),
      StepItem(tex: r"""\text{等比数列の和より } \displaystyle \sum_{k=0}^{n-1}(-t)^k=\frac{1-(-t)^n}{1+t}\text{。よって}"""),
      StepItem(tex: r"""\begin{aligned}
  S_n&=\int_0^1\frac{1-(-t)^n}{1+t}\,dt\\[6pt]
  &=\int_0^1\frac{1}{1+t}\,dt-\int_0^1\frac{(-t)^n}{1+t}\,dt  
  \end{aligned}"""),
      StepItem(tex: r"""\int_0^1\frac{1}{1+t}\,dt=\Bigl[\log(1+t)\Bigr]_0^1=\log 2."""),
      StepItem(tex: r"""\text{また } 0<\frac{t^n}{1+t}<t^n\ (0<t<1)\text{ より}"""),
      StepItem(tex: r"""\begin{aligned}
  \left|\int_0^1\frac{(-t)^n}{1+t}\,dt\right|
  &\le \int_0^1 \frac{t^n}{1+t}\,dt
  <\int_0^1 t^n\,dt
  =\frac{1}{n+1}\to 0.
  \end{aligned}"""),
      StepItem(tex: r"""\text{したがって } \displaystyle \lim_{n\to\infty}S_n=\log 2 \text{。}"""),

      StepItem(tex: r"""\boxed{\displaystyle \sum_{k=1}^{\infty}\frac{(-1)^{k+1}}{k}=\log 2}"""),
      StepItem(tex: r"""\textbf{【補足】}"""),
      StepItem(tex: r"""\text{この級数をメルカトル級数という。}"""),
    ],
  ),

  MathProblem(
    id: "BE3EC919-60B4-4334-BE8F-389731CF565D",
    no: 2,
    category: 'ライプニッツ（交代）',
    level: '上級',
    question: r"""\displaystyle \lim_{n\to\infty}\displaystyle \sum_{k=1}^{n}\frac{(-1)^{k-1}}{2k-1}""",
    answer: r"""\displaystyle \frac{\pi}{4}""",
    imageAsset: 'assets/graphs/limit/problems_famous_limits/problem_2.png',
    hint: r"""\text{部分和を積分で表し、等比数列の和の公式を用いて評価する}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{部分和を積分で表し、等比数列の和の公式を用いて評価する}"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\text{部分和を考えると、}"""),
      StepItem(tex: r"""\begin{aligned}
      S_n &= \displaystyle \sum_{k=1}^{n}\frac{(-1)^{k-1}}{2k-1} \\[6pt]
      &= 1 - \frac{1}{3} + \frac{1}{5} - \frac{1}{7} + \cdots + \frac{(-1)^{n-1}}{2n-1}
      \end{aligned}"""),
      StepItem(tex: r"""\text{各項 } \displaystyle \frac{(-1)^{k-1}}{2k-1} \text{ は、} \int_0^1 (-t^2)^{k-1} \, dt \text{ と表せる。}"""),
      StepItem(tex: r"""\text{（例えば、} \displaystyle -\frac 1 3 = \int_0^1 (-t^2)^{1} \, dt \text{と表せる。}）"""),
      StepItem(tex: r"""\text{実際、}"""),
      StepItem(tex: r"""\begin{aligned}
      \int_0^1 (-t^2)^{k-1} \, dt &= \int_0^1 (-1)^{k-1} t^{2k-2} \, dt \\[6pt]
      &= (-1)^{k-1} \left[ \frac{t^{2k-1}}{2k-1} \right]_0^1 \\[6pt]
      &= (-1)^{k-1} \cdot \frac{1}{2k-1} \\[6pt]
      &= \frac{(-1)^{k-1}}{2k-1}
      \end{aligned}"""),
      StepItem(tex: r"""\text{したがって、部分和は積分の和として、}"""),
      StepItem(tex: r"""\begin{aligned}
      S_n &= \displaystyle \sum_{k=1}^{n} \int_0^1 (-t^2)^{k-1} \, dt \\[6pt]
      &= \displaystyle \sum_{k=0}^{n-1} \int_0^1 (-t^2)^k \, dt \\[6pt]
      &= \int_0^1 \displaystyle \sum_{k=0}^{n-1} (-t^2)^k \, dt
      \end{aligned}"""),
      StepItem(tex: r"""\text{等比数列の和の公式より、}"""),
      StepItem(tex: r"""\begin{aligned}
      \displaystyle \sum_{k=0}^{n-1} (-t^2)^k &= \frac{1-(-t^2)^n}{1-(-t^2)} \\[6pt]
      &= \frac{1-(-t^2)^n}{1+t^2}
      \end{aligned}"""),
      StepItem(tex: r"""\text{よって、}"""),
      StepItem(tex: r"""\begin{aligned}
      S_n &= \int_0^1 \frac{1-(-t^2)^n}{1+t^2} \, dt \\[6pt]
      &= \int_0^1 \frac{1}{1+t^2} \, dt - \int_0^1 \frac{(-t^2)^n}{1+t^2} \, dt
      \end{aligned}"""),
      StepItem(tex: r"""\textcolor{blue}{右辺の第1項は、}"""),
      StepItem(tex: r"""\begin{aligned}
      \int_0^1 \frac{1}{1+t^2} \, dt &= \int_0^{\frac{\pi}{4}} \frac{1}{1+\tan^2 x}\frac{1}{\cos^2 x}dx \\[6pt]
      &= \int_0^{\frac{\pi}{4}} 1 dx  \\[6pt]
      &= \frac{\pi}{4}
      \end{aligned}"""),
      StepItem(tex: r"""\textcolor{blue}{右辺の第2項は、} n \to \infty \text{ で } \textcolor{red}{0}\ \textcolor{red}{に収束する}\text{(詳しくは補足参照)}"""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\boxed{\displaystyle \sum_{k=1}^{\infty} \frac{(-1)^{k-1}}{2k-1} = \frac{\pi}{4}}"""),
      StepItem(tex: r"""\textbf{【補足】第2項の収束性を示す：}"""),
      StepItem(tex: r"""\text{} (-1)^n \text{ を外に出すと、}"""),
      StepItem(tex: r"""\frac{(-t^2)^n}{1+t^2} = (-1)^n \cdot \frac{(t^2)^n}{1+t^2}"""),
      StepItem(tex: r"""\text{0-1区間で } 0 < \displaystyle \frac{(t^2)^n}{1+t^2} < (t^2)^n \text{ より、}"""),
      StepItem(tex: r"""\begin{aligned}
      \left| \int_0^1 \frac{(-t^2)^n}{1+t^2} \, dt \right| &= \left| \int_0^1 (-1)^n \cdot \frac{(t^2)^n}{1+t^2} \, dt \right| \\[6pt]
      &= \left| (-1)^n \right| \cdot \left| \int_0^1 \frac{(t^2)^n}{1+t^2} \, dt \right| \\[6pt]
      &=  \int_0^1 \frac{(t^2)^n}{1+t^2} \, dt  \\[6pt]
      &< \int_0^1 (t^2)^n \, dt \\[6pt]
      &= \left[ \frac{t^{2n+1}} {2n+1} \right]_0^1 \\[6pt]
      &= \frac{1}{2n+1} \to 0 \quad (n \to \infty)
      \end{aligned}"""),
      StepItem(tex: r"""\text{よって、} \displaystyle a_n = \int_0^1 \frac{(-t^2)^n}{1+t^2} \, dt \text{ と見做すと、} \lim_{n\to\infty} |a_n| = 0 """),
      StepItem(tex: r"""\text{したがって第2項} \displaystyle \lim_{n\to\infty} a_n =\lim_{n\to\infty} \int_0^1 \frac{(-t^2)^n}{1+t^2} \, dt  = 0"""),
      StepItem(tex: r"""\text{（注：一般に } \lim_{n\to\infty} |a_n| = 0 \Leftrightarrow \lim_{n\to\infty} a_n = 0 \text{ が成り立つ）}"""),
      StepItem(tex: r"""\textbf{【補足】}"""),
      StepItem(tex: r"""\text{この級数をライプニッツ級数という。}"""),
    ],
  ),

  MathProblem(
    id: "4E839CEA-B995-4D8D-812D-C23546487B0E",
    no: 3,
    category: '調和級数',
    level: '上級',
    question: r"""\displaystyle \lim_{n\to\infty}\displaystyle \sum_{k=1}^{n}\frac{1}{k}""",
    answer: r"""\displaystyle \infty \text{（発散）}""",
    imageAsset: 'assets/graphs/limit/problems_famous_limits/problem_3.png',
    steps: [
      StepItem(tex: r"""\textbf{【証明1：積分判定法】}"""),
      StepItem(tex: r"""\textcolor{blue}{青い部分の面積} < \textcolor{red}{赤い部分の面積} \text{なので、}"""),
      StepItem(tex: '', imageAsset: 'assets/graphs/limit/problems_famous_limits/problem_3.png'),
      StepItem(tex: r"""\begin{aligned}
      \displaystyle \sum_{k=1}^{n}\frac{1}{k} &\geq \int_1^{n+1}\frac{1}{x}dx \\[6pt]
      &= [\log x]_1^{n+1} \\[6pt]
      &= \log(n+1) - \log 1 \\[6pt]
      &= \log(n+1)
      \end{aligned}"""),
      StepItem(tex: r"""\text{よって } \displaystyle \log(n+1) \leq \displaystyle \sum_{k=1}^{n}\frac{1}{k} """),
      StepItem(tex: r"""\text{左辺は} n \to \infty \text{で発散するので、} \displaystyle \lim_{n\to\infty} \displaystyle \sum_{k=1}^{n}\frac{1}{k} \text{は発散する。} """),
      StepItem(tex: r"""\textbf{【証明2：部分和の評価】}"""),
      StepItem(tex: r"""\begin{aligned}
      & \ \ \ \displaystyle \sum_{k=1}^{2^n}\frac{1}{k} \\[6pt] 
      &= 1 + \frac{1}{2} + \frac{1}{3} + \cdots + \frac{1}{2^n - 1} + \frac{1}{2^n} \\[6pt] 
      & = 1 + \frac{1}{2} + \left(\frac{1}{3}+\frac{1}{4}\right) + \left(\frac{1}{5}+\frac{1}{6}+\frac{1}{7}+\frac{1}{8}\right) + \cdots + \frac{1}{2^n}\\[6pt]
      &\geq 1 + \frac{1}{2} + \left(\frac{1}{4}+\frac{1}{4}\right) + \left(\frac{1}{8}+\frac{1}{8}+\frac{1}{8}+\frac{1}{8}\right) +\cdots  +  \underbrace{\left( \frac{1}{2^n}  \cdots + \frac{1}{2^n} \right)}_{2^{n-1}\ \text{個}}\\[6pt]
      & = 1 + \underbrace{\frac{1}{2} + \frac{1}{2} + \cdots + \frac{1}{2}}_{n\ \text{個}} \\[6pt]
      & = 1 + \frac{n}{2}
      \end{aligned}"""),
      StepItem(tex: r"""\text{よって } \displaystyle 1 + \frac{n}{2} \leq \displaystyle \sum_{k=1}^{2^n}\frac{1}{k} """),
      StepItem(tex: r"""\text{左辺} 1+ \dfrac{n}{2} \text{は} n \to \infty \text{で発散するので、} \displaystyle \lim_{n\to\infty} \displaystyle \sum_{k=1}^{n}\frac{1}{k} \text{は発散する。} """),
      StepItem(tex: r"""\textbf{【補足】}"""),
      StepItem(tex: r"""\text{この級数を調和級数という。}""")
    ],
  ),

  MathProblem(
    id: "D7F8E9A0-B1C2-4D3E-8F5A-6B7C8D9E0F1A",
    no: 4,
    category: '級数の発散（積分判定法）',
    level: '上級',
    question: r"""\displaystyle \lim_{n\to\infty}\displaystyle \sum_{k=1}^{n}\frac{1}{\sqrt{k}}""",
    answer: r"""\displaystyle \infty \text{（発散）}""",
    imageAsset: 'assets/graphs/limit/problems_famous_limits/problem_4.png',
    hint: r"""\text{関数 } \frac{1}{\sqrt{x}} \text{ の積分を使って評価する}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{関数 } \displaystyle \frac{1}{\sqrt{x}} \text{ の積分を使って級数を評価する。}"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\text{各 } k \text{ に対して、区間 } [k, k+1] \text{ で } \displaystyle \frac{1}{\sqrt{k}} \geq \frac{1}{\sqrt{x}} \ (k \leq x \leq k+1) \text{ が成り立つ。}"""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
      \frac{1}{\sqrt{k}} &\geq \int_{k}^{k+1}\frac{1}{\sqrt{x}}\,dx
      \end{aligned}"""),
      StepItem(tex: r"""\text{よって、}"""),
      StepItem(tex: r"""\begin{aligned}
      \displaystyle \sum_{k=1}^{n}\frac{1}{\sqrt{k}} &\geq \displaystyle \sum_{k=1}^{n}\int_{k}^{k+1}\frac{1}{\sqrt{x}}\,dx \\[6pt]
      &= \int_{1}^{n+1}\frac{1}{\sqrt{x}}\,dx \\[6pt]
      &= \left[2\sqrt{x}\right]_{1}^{n+1} \\[6pt]
      &= 2\sqrt{n+1} - 2\sqrt{1} \\[6pt]
      &= 2\sqrt{n+1} - 2
      \end{aligned}"""),
      StepItem(tex: r"""\text{したがって、}\displaystyle 2\sqrt{n+1} - 2 \leq \displaystyle \sum_{k=1}^{n}\frac{1}{\sqrt{k}}"""),
      StepItem(tex: r"""\text{左辺 } 2\sqrt{n+1} - 2 \text{ は } n \to \infty \text{ で発散するので、}\displaystyle \lim_{n\to\infty}\displaystyle \sum_{k=1}^{n}\frac{1}{\sqrt{k}} = \infty \text{（発散）}"""),
    ],
  ),
  
MathProblem(
  id: "A39DF72B-47BA-473A-83D4-5D35E8ADD533",
  no: 5,
  category: '対数変換',
  level: '中級',
  question: r"""\displaystyle \lim_{n\to\infty}\sqrt[n]{n}""",
  answer: r"""\displaystyle 1""",
  imageAsset: 'assets/graphs/limit/problems_exponential_limits/problem_8.png',
  steps: [
    StepItem(tex: r"""\textbf{【解答】}"""),
    StepItem(tex: r"""\text{対数を取ると、}\log\sqrt[n]{n} = \displaystyle \frac{\log n}{n} \ \underset{n\to\infty}{\longrightarrow} \ 0 \cdots (1)"""),
    StepItem(tex: r""" \text{よって、}\log \text{の中身は} 1 \text{に収束する。ゆえに、}\lim_{n\to\infty} \sqrt[n]{n} = 1"""),
    StepItem(tex: r""""""),
    StepItem(tex: r"""\textbf{【補足：連続関数の性質】}"""),
    StepItem(tex: r"""\text{一般に、連続関数 } f \text{ について、} \lim_{n\to\infty} f(a_n) = f\!\left(\lim_{n\to\infty} a_n\right) \text{ が成り立つ。}"""),
    StepItem(tex: r"""\text{この問題では、} \log \text{ の連続性より：}"""),
    StepItem(tex: r"""\lim_{n\to\infty} \log(\sqrt[n]{n}) = \log\!\left(\lim_{n\to\infty} \sqrt[n]{n}\right)"""),
    StepItem(tex: r"""\text{この値は }(1) \text{より } 0 \text{ なので、} \log\!\left(\lim_{n\to\infty} \sqrt[n]{n}\right) = 0"""),
    StepItem(tex: r"""\text{したがって、} \lim_{n\to\infty} \sqrt[n]{n} = 1"""),
  ],
),
  // MathProblem(
  //   id: "C5B6C66A-0A6B-4B0B-8B76-7B8C7B0D42A7",
  //   no: 5,
  //   category: 'ウォリス積',
  //   level: '上級',
  //   question: r"""\displaystyle \lim_{n\to\infty}\prod_{k=1}^{n}\frac{4k^2}{4k^2-1}""",
  //   answer: r"""\displaystyle \frac{\pi}{2}""",
  //   imageAsset: 'assets/graphs/limit/problems_famous_limits/problem_5.png',
  //   hint: r"""\text{ } I_n=\int_0^{\pi/2}\sin^n x\,dx \text{ を評価し、挟み撃ちで示す}""",
  //   steps: [
  //     StepItem(tex: r"""\textbf{【命題】}"""),
  //     StepItem(tex: r"""\displaystyle \prod_{k=1}^{n}\frac{4k^2}{4k^2-1}\\xrightarrow[n\to\infty]{}\frac{\pi}{2}"""),

  //     StepItem(tex: r"""\textbf{【方針】}"""),
  //     StepItem(tex: r"""\text{積分 } I_n=\int_0^{\pi/2}\sin^n x\,dx \text{ を用い、} I_{2n+1}\le I_{2n}\le I_{2n-1} \text{ から挟み撃ちする。}"""),

  //     StepItem(tex: r"""\textbf{【解答】}"""),
  //     StepItem(tex: r"""\text{まず } I_n=\int_0^{\pi/2}\sin^n x\,dx \text{ とおく。}"""),
  //     StepItem(tex: r"""\text{部分積分（}u=\sin^{n-1}x,\ dv=\sin x\,dx\text{）より、}"""),
  //     StepItem(tex: r"""\begin{aligned}
  //     I_n &= \int_0^{\pi/2}\sin^{n-1}x\sin x\,dx \\
  //     &= \Bigl[-\sin^{n-1}x\cos x\Bigr]_0^{\pi/2} + (n-1)\int_0^{\pi/2}\sin^{n-2}x\cos^2 x\,dx \\
  //     &= (n-1)\int_0^{\pi/2}\sin^{n-2}x(1-\sin^2x)\,dx \\
  //     &= (n-1)\left(I_{n-2}-I_n\right)
  //     \end{aligned}"""),
  //     StepItem(tex: r"""\text{よって } nI_n=(n-1)I_{n-2}\text{、すなわち}"""),
  //     StepItem(tex: r"""\boxed{\,I_n=\frac{n-1}{n}I_{n-2}\,}\qquad(n\ge2)"""),

  //     StepItem(tex: r"""\text{初期値は } I_0=\frac{\pi}{2},\ I_1=1 \text{ である。}"""),
  //     StepItem(tex: r"""\text{したがって再帰式を繰り返すと、}"""),
  //     StepItem(tex: r"""\begin{aligned}
  //     I_{2n} &= \frac{2n-1}{2n}\cdot\frac{2n-3}{2n-2}\cdots\frac{1}{2}\,I_0
  //     =\left(\prod_{k=1}^{n}\frac{2k-1}{2k}\right)\frac{\pi}{2},\\[6pt]
  //     I_{2n+1} &= \frac{2n}{2n+1}\cdot\frac{2n-2}{2n-1}\cdots\frac{2}{3}\,I_1
  //     =\prod_{k=1}^{n}\frac{2k}{2k+1}.
  //     \end{aligned}"""),

  //     StepItem(tex: r"""\text{ここで } 0\le \sin x\le 1\ (0\le x\le \pi/2)\text{ より } \sin^{2n+1}x\le\sin^{2n}x\le\sin^{2n-1}x\text{。}"""),
  //     StepItem(tex: r"""\text{両辺を }[0,\pi/2]\text{ で積分して}"""),
  //     StepItem(tex: r"""\boxed{\,I_{2n+1}\le I_{2n}\le I_{2n-1}\,}"""),

  //     StepItem(tex: r"""\text{まず } I_{2n+1}\le I_{2n} \text{ から、}"""),
  //     StepItem(tex: r"""\begin{aligned}
  //     1 \le \frac{I_{2n}}{I_{2n+1}}
  //     &= \frac{\left(\prod_{k=1}^{n}\frac{2k-1}{2k}\right)\frac{\pi}{2}}{\prod_{k=1}^{n}\frac{2k}{2k+1}}
  //     =\frac{\pi}{2}\cdot\frac{1}{\displaystyle \prod_{k=1}^{n}\frac{2k}{2k-1}\cdot\frac{2k}{2k+1}}
  //     \end{aligned}"""),
  //     StepItem(tex: r"""\text{よって } \displaystyle \prod_{k=1}^{n}\frac{2k}{2k-1}\cdot\frac{2k}{2k+1}\le\frac{\pi}{2}\text{。}"""),

  //     StepItem(tex: r"""\text{次に } I_{2n}\le I_{2n-1} \text{ から同様に計算すると、}"""),
  //     StepItem(tex: r"""\begin{aligned}
  //     \frac{\pi}{2}
  //     &\le \left(\prod_{k=1}^{n}\frac{2k}{2k-1}\cdot\frac{2k}{2k+1}\right)\cdot\frac{2n+1}{2n}
  //     \end{aligned}"""),

  //     StepItem(tex: r"""\text{以上より、ウォリス積 } W_n=\displaystyle\prod_{k=1}^{n}\frac{2k}{2k-1}\cdot\frac{2k}{2k+1}=\prod_{k=1}^{n}\frac{4k^2}{4k^2-1}\text{ は}"""),
  //     StepItem(tex: r"""\boxed{\,W_n\le\frac{\pi}{2}\le \frac{2n+1}{2n}W_n\,}"""),
  //     StepItem(tex: r"""\text{ここで } \displaystyle\frac{2n+1}{2n}\to 1\ (n\to\infty)\text{ なので挟み撃ちより } W_n\to\frac{\pi}{2}\text{。}"""),
  //     StepItem(tex: r"""\text{したがって } \displaystyle \boxed{\lim_{n\to\infty}\prod_{k=1}^{n}\frac{4k^2}{4k^2-1}=\frac{\pi}{2}}"""),
  //   ],
  // ),

];
