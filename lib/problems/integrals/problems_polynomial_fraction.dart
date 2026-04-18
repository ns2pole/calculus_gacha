import '../../models/math_problem.dart';
import '../../models/step_item.dart';
/// ============================================================================
/// 有理関数の問題4問
/// ============================================================================

const polynomialFractionProblems = <MathProblem>[



MathProblem(
  id: "4E93591C-AFE6-41F0-A2E9-4A32C796D02B",
  no: 1,
  category: '有理関数',
  level: '初級',
  question: r"""\displaystyle \int_{1}^{\sqrt{3}}\displaystyle \frac{1}{x^{2}+3}\,dx""",
  answer: r""" \displaystyle \frac{\pi}{12\sqrt{3}}""",
  imageAsset: 'assets/graphs/integral/problems_polynomial_fraction/problem_1.png',
  hint: r"""x=\sqrt{3}\tan\theta \left(\theta\in(0,\displaystyle \frac{\pi}{2})\right) \text{を用いて置換積分する。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""x=\sqrt{3}\tan\theta \left(\theta\in(0,\displaystyle \frac{\pi}{2})\right) \text{を用いて置換積分する。}"""),
    StepItem(tex: r"""\textbf{【置換と範囲変換】}"""),
    StepItem(tex: r"""\text{ここで、} x=\sqrt{3}\tan\theta \text{とおくと、} dx=\sqrt{3}\displaystyle \frac{1}{\cos^2\theta}\,d\theta \text{より、積分範囲は} x=1\rightarrow \sqrt{3} \text{の時、} \tan\theta=\displaystyle \frac{1}{\sqrt{3}}\rightarrow 1 \text{より、} \theta=\displaystyle \frac{\pi}{6}\rightarrow \displaystyle \frac{\pi}{4} \text{と対応させる。}"""),
    StepItem(tex: r"""\textbf{【計算】}"""),
    StepItem(tex: r"""\text{置換 } x=\sqrt{3}\tan\theta \text{ より、} dx=\sqrt{3}\displaystyle \frac{1}{\cos^2\theta}\,d\theta \text{ である。また、}"""),
    StepItem(tex: r"""\begin{aligned}
x^2+3 &= (\sqrt{3}\tan\theta)^2 + 3\\
&= 3\tan^2\theta + 3\\
&= 3(\tan^2\theta + 1)\\
&= 3\cdot\displaystyle \frac{1}{\cos^2\theta}
\end{aligned}
"""),
    StepItem(tex: r"""\text{したがって、} x=\sqrt{3}\tan\theta \text{ と } dx=\displaystyle \frac{dx}{d\theta}d\theta=\sqrt{3}\displaystyle \frac{1}{\cos^2\theta}\,d\theta \text{ を代入すると、}"""),
    StepItem(tex: r"""\begin{aligned}
&\displaystyle \int_{1}^{\sqrt{3}}\displaystyle \frac{1}{x^{2}+3}\,dx\\
&=\displaystyle \int_{\frac \pi 6}^{\frac \pi 4}\displaystyle \frac{1}{3\cdot\displaystyle \frac{1}{\cos^2\theta}}\cdot\sqrt{3}\displaystyle \frac{1}{\cos^2\theta}\,d\theta\\[6pt]
&=\displaystyle \int_{\frac \pi 6}^{\frac \pi 4}\displaystyle \frac{\cos^2\theta}{3}\cdot\sqrt{3}\displaystyle \frac{1}{\cos^2\theta}\,d\theta\\[6pt]
&=\displaystyle \int_{\frac \pi 6}^{\frac \pi 4}\displaystyle \frac{\sqrt{3}}{3}\,d\theta\\[6pt]
&=\displaystyle \frac{1}{\sqrt{3}}\displaystyle \int_{\frac \pi 6}^{\frac \pi 4} d\theta\\[6pt]
&=\displaystyle \frac{1}{\sqrt{3}}\left(\displaystyle \frac{\pi}{4}-\displaystyle \frac{\pi}{6}\right)\\[6pt]
&=\displaystyle \frac{1}{\sqrt{3}}\cdot\displaystyle \frac{\pi}{12}\\[6pt]
&=\displaystyle \frac{\pi}{12\sqrt{3}}
\end{aligned}
"""),
    StepItem(tex: r"""\textbf{【補足（逆三角関数）】}"""),
    StepItem(tex: r"""\text{逆正接関数 } \arctan x \text{を用いる。 }\arctan x \text{の定義域は } (-\infty, \infty) \text{、値域は } \left(-\displaystyle \frac{\pi}{2}, \displaystyle \frac{\pi}{2}\right) \text{ である。}"""),
    StepItem(tex: r"""\text{公式 } \displaystyle \int\displaystyle \frac{dx}{x^2+a^2}=\displaystyle \frac{1}{a}\arctan\displaystyle \frac{x}{a}+C \text{ を用いる。ここで、} x^2+3=x^2+(\sqrt{3})^2 \text{ より、} a=\sqrt{3} \text{ である。}"""),
    StepItem(tex: r"""\text{まず不定積分を求める。}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \int\displaystyle \frac{dx}{x^2+3}
&= \displaystyle \int\displaystyle \frac{dx}{x^2+(\sqrt{3})^2}\\
&= \displaystyle \frac{1}{\sqrt{3}}\arctan\displaystyle \frac{x}{\sqrt{3}} + C
\end{aligned}
"""),
    StepItem(tex: r"""\text{したがって、定積分は、}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{1}^{\sqrt{3}}\displaystyle \frac{1}{x^{2}+3}\,dx
&= \left[\displaystyle \frac{1}{\sqrt{3}}\arctan\displaystyle \frac{x}{\sqrt{3}}\right]_{1}^{\sqrt{3}}\\
&= \displaystyle \frac{1}{\sqrt{3}}\left(\arctan\displaystyle \frac{\sqrt{3}}{\sqrt{3}} - \arctan\displaystyle \frac{1}{\sqrt{3}}\right)\\
&= \displaystyle \frac{1}{\sqrt{3}}\left(\arctan 1 - \arctan\displaystyle \frac{1}{\sqrt{3}}\right)\\
&= \displaystyle \frac{1}{\sqrt{3}}\left(\displaystyle \frac{\pi}{4} - \displaystyle \frac{\pi}{6}\right)\\
&= \displaystyle \frac{1}{\sqrt{3}}\cdot\displaystyle \frac{\pi}{12}\\
&= \displaystyle \frac{\pi}{12\sqrt{3}}
\end{aligned}
"""),
  ],
),

MathProblem(
  id: "C08EC860-F248-4E0A-90FD-F321E66616A4",
  no: 2,
  category: '有理関数（平方完成）',
  level: '中級',
  question: r"""\displaystyle \int_{-1}^{1}\displaystyle \frac{1}{x^{2}+2x+5}\,dx""",
  answer: r"""\displaystyle \displaystyle \frac{\pi}{8}
""",
    imageAsset: 'assets/graphs/integral/problems_polynomial_fraction/problem_2.png',
  steps: [
    StepItem(tex: r"""\textbf{【解説】}"""),
    StepItem(tex: r"""\text{分母} = (x+1)^2+4\text{より、置換} x+1=2\tan\theta\text{を行う。}"""),
    StepItem(tex: r"""  \begin{aligned} dx &= \displaystyle \frac{dx}{d\theta} d\theta = 2\displaystyle \frac{1}{\cos ^2 \theta} d \theta \\
    &= 2\left( 1 + \tan ^2 \theta \right) d \theta
    \end{aligned}  """
    ),
    StepItem(tex: r"""\text{より、}x=-1\rightarrow 1 \text{の時、}\tan \theta = 0 \rightarrow 1 \Leftrightarrow \theta= 0 \rightarrow \displaystyle \frac \pi 4 \text{よって、}"""),
    StepItem(tex: r"""\begin{aligned}
&\displaystyle \int_{-1}^{1}\displaystyle \frac{1}{(x+1)^2+4}\,dx\\
&=\displaystyle \int_{0}^{\pi/4}\displaystyle \frac{1}{(2\tan\theta)^2+4}\cdot 2(1+\tan^2\theta)\,d\theta\\
&=\displaystyle \int_{0}^{\pi/4}\displaystyle \frac{2(1+\tan^2\theta)}{4(1+\tan^2\theta)}\,d\theta\\
&=\displaystyle \int_{0}^{\pi/4}\displaystyle \frac{1}{2}\,d\theta\\
&=\displaystyle \frac{1}{2}\theta\Big|_{0}^{\pi/4}\\
&=\displaystyle \frac{1}{2}\cdot\displaystyle \frac{\pi}{4}\\
&=\displaystyle \frac{\pi}{8}.
\end{aligned}
"""),
    StepItem(tex: r"""\textbf{【補足】}"""),
    StepItem(tex: r"""\tan \text{の逆関数} \arctan \text{を使うと、}"""),
    StepItem(tex: r"""\begin{aligned}
&\theta=\arctan\displaystyle \frac{x+1}{2} \\ 
&\displaystyle \int\displaystyle \frac{1}{(x+1)^2+4}\,dx=\displaystyle \frac{1}{2}\arctan\displaystyle \frac{x+1}{2}+C.
\end{aligned}
"""),
  ],
),

MathProblem(
  id: "8FB8536A-3433-4F7A-8B29-B44DC4186F09",
  no: 3,
  category: '部分分数分解',
  level: '中級',
  question: r"""\displaystyle \int_{3}^{6}\displaystyle \frac{1}{x^{2}-4}\,dx""",
  answer: r"""\displaystyle \frac{1}{4}\log\displaystyle \frac{5}{2}""",
  imageAsset: 'assets/graphs/integral/problems_polynomial_fraction/problem_3.png',
  hint: r"""x^2-4=(x-2)(x+2) \text{に因数分解して部分分数分解を行う。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""x^2-4=(x-2)(x+2) \text{に因数分解して部分分数分解を行う。}"""),
    StepItem(tex: r"""\textbf{【部分分数分解】}"""),
    StepItem(tex: r"""\text{分母を因数分解すると、} x^2-4=(x-2)(x+2) \text{である。}"""),
    StepItem(tex: r"""\text{部分分数分解の形を設定する：}"""),
    StepItem(tex: r"""\displaystyle \frac{1}{x^2-4}=\displaystyle \frac{A}{x-2}+\displaystyle \frac{B}{x+2}"""),
    StepItem(tex: r"""\text{両辺に } (x-2)(x+2) \text{ を掛けると、}"""),
    StepItem(tex: r"""1=A(x+2)+B(x-2)"""),
    StepItem(tex: r"""\text{右辺を展開すると、}"""),
    StepItem(tex: r"""1=(A+B)x+(2A-2B)"""),
    StepItem(tex: r"""\text{係数比較により、}"""),
    StepItem(tex: r"""\begin{cases}
A+B=0\\
2A-2B=1
\end{cases}"""),
    StepItem(tex: r"""\text{これを解くと、} A=\displaystyle \frac{1}{4}, B=-\displaystyle \frac{1}{4}"""),
    StepItem(tex: r"""\text{したがって、}"""),
    StepItem(tex: r"""\displaystyle \frac{1}{x^2-4}=\displaystyle \frac{1}{4}\cdot\displaystyle \frac{1}{x-2}-\displaystyle \frac{1}{4}\cdot\displaystyle \frac{1}{x+2}"""),
    StepItem(tex: r"""\textbf{【積分の計算】}"""),
    StepItem(tex: r"""\text{不定積分を求める：}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \int\displaystyle \frac{1}{x^{2}-4}\,dx
&=\displaystyle \int\left(\displaystyle \frac{1}{4}\cdot\displaystyle \frac{1}{x-2}-\displaystyle \frac{1}{4}\cdot\displaystyle \frac{1}{x+2}\right)dx\\[6pt]
&=\displaystyle \frac{1}{4}\int\displaystyle \frac{1}{x-2}\,dx-\displaystyle \frac{1}{4}\int\displaystyle \frac{1}{x+2}\,dx\\[6pt]
&=\displaystyle \frac{1}{4}\log|x-2|-\displaystyle \frac{1}{4}\log|x+2|+C\\[6pt]
&=\displaystyle \frac{1}{4}\log\left|\displaystyle \frac{x-2}{x+2}\right|+C
\end{aligned}
"""),
    StepItem(tex: r"""\textbf{【定積分の評価】}"""),
    StepItem(tex: r"""\text{積分範囲が } [3,6] \text{ なので、} x-2>0, x+2>0 \text{ より絶対値は不要である。}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{3}^{6}\displaystyle \frac{1}{x^{2}-4}\,dx
&=\left[\displaystyle \frac{1}{4}\log\displaystyle \frac{x-2}{x+2}\right]_{3}^{6}\\[6pt]
&=\displaystyle \frac{1}{4}\left(\log\displaystyle \frac{6-2}{6+2}-\log\displaystyle \frac{3-2}{3+2}\right)\\[6pt]
&=\displaystyle \frac{1}{4}\left(\log\displaystyle \frac{4}{8}-\log\displaystyle \frac{1}{5}\right)\\[6pt]
&=\displaystyle \frac{1}{4}\left(\log\displaystyle \frac{1}{2}-\log\displaystyle \frac{1}{5}\right)\\[6pt]
&=\displaystyle \frac{1}{4}\log\displaystyle \frac{\frac 1 2}{\frac 1 5}\\[6pt]
&=\displaystyle \frac{1}{4}\log\displaystyle \frac{5}{2}
\end{aligned}
"""),
  ],
),

MathProblem(
  id: "A36F411F-99B5-40E0-8BE1-F9126992BA14",
  no: 4,
  category: '部分分数（有理関数）',
  level: '上級',
  question: r"""\displaystyle \int_{0}^{1}\displaystyle \frac{1}{1+x^{3}}\,dx""",
  answer: r"""\displaystyle \frac{1}{3}\log 2+\displaystyle \frac{\pi}{3\sqrt{3}}""",
  imageAsset: 'assets/graphs/integral/problems_polynomial_fraction/problem_4.png',
  hint: r"""1+x^3=(1+x)(1-x+x^2) \text{ に因数分解して部分分数分解を行い，原始関数を求めてから定積分を評価する。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""1+x^3=(1+x)(1-x+x^2) \text{ に因数分解して部分分数分解を行い，原始関数を求めてから定積分を評価する。}"""),
    StepItem(tex: r"""\textbf{【部分分数分解】}"""),
    StepItem(tex: r"""\text{分母を因数分解すると、} 1+x^3=(1+x)(1-x+x^2) \text{ である。}"""),
    StepItem(tex: r"""\text{部分分数分解の形を設定する：}"""),
    StepItem(tex: r"""\displaystyle \frac{1}{1+x^3}=\displaystyle \frac{A}{1+x}+\displaystyle \frac{Bx+C}{1-x+x^2}"""),
    StepItem(tex: r"""\text{両辺に } (1+x)(1-x+x^2) \text{ を掛けると、}"""),
    StepItem(tex: r"""1=A(1-x+x^2)+(Bx+C)(1+x)"""),
    StepItem(tex: r"""\text{右辺を展開すると、}"""),
    StepItem(tex: r"""\begin{aligned}
1&=A(1-x+x^2)+(Bx+C)(1+x)\\
&=A-Ax+Ax^2+Bx+Bx^2+C+Cx\\
&=(A+C)+(-A+B+C)x+(A+B)x^2
\end{aligned}
"""),
    StepItem(tex: r"""\text{係数比較により、}"""),
    StepItem(tex: r"""\begin{cases}
A+C=1\\
-A+B+C=0\\
A+B=0
\end{cases}"""),
    StepItem(tex: r"""\text{これを解くと、} A=\displaystyle \frac{1}{3}, B=-\displaystyle \frac{1}{3}, C=\displaystyle \frac{2}{3}"""),
    StepItem(tex: r"""\text{したがって、}"""),
    StepItem(tex: r"""\displaystyle \frac{1}{1+x^3}=\displaystyle \frac{1}{3}\cdot\displaystyle \frac{1}{1+x}+\displaystyle \frac{-x+2}{3(1-x+x^2)}"""),
    StepItem(tex: r"""\textbf{【第2項の変形】}"""),
    StepItem(tex: r"""\text{第2項の分子を分母の導関数の形に分解し、積分したら}\log \text{の形になるようにすることを考える。分母 } 1-x+x^2 \text{ の導関数は } 2x-1 \text{ である。}"""),
    StepItem(tex: r"""\text{そこで、} -x+2=\alpha(2x-1)+\beta \text{ とおく。}"""),
    StepItem(tex: r"""\text{右辺を展開すると、}"""),
    StepItem(tex: r"""\begin{aligned}
-x+2&=2\alpha x-\alpha+\beta\\
&=(2\alpha)x+(-\alpha+\beta)
\end{aligned}
"""),
    StepItem(tex: r"""\text{係数比較により、}"""),
    StepItem(tex: r"""\begin{cases}
2\alpha=-1\\
-\alpha+\beta=2
\end{cases}"""),
    StepItem(tex: r"""\text{これを解くと、} \alpha=-\displaystyle \frac{1}{2}, \beta=\displaystyle \frac{3}{2}"""),
    StepItem(tex: r"""\text{したがって、}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \frac{-x+2}{3(1-x+x^2)}
&=\displaystyle \frac{-\displaystyle \frac{1}{2}(2x-1)+\displaystyle \frac{3}{2}}{3(1-x+x^2)}\\[6pt]
&=-\displaystyle \frac{1}{6}\cdot\displaystyle \frac{2x-1}{1-x+x^2}+\displaystyle \frac{1}{2}\cdot\displaystyle \frac{1}{1-x+x^2}
\end{aligned}
"""),
    StepItem(tex: r"""\textbf{【定積分の評価】}"""),
    StepItem(tex: r"""\text{部分分数分解の結果より、定積分は次の3つの積分の和として表される：}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{1+x^{3}}
&=\displaystyle \frac{1}{3}\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{1+x}-\displaystyle \frac{1}{6}\displaystyle \int_{0}^{1}\displaystyle \frac{2x-1}{1-x+x^2}dx+\displaystyle \frac{1}{2}\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{1-x+x^2}
\end{aligned}
"""),
    StepItem(tex: r"""\textcolor{blue}{\textbf{【第1項の計算】}}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{1+x}
&=\left[\log(1+x)\right]_{0}^{1}\\[6pt]
&=\log 2-\log 1\\[6pt]
&=\log 2
\end{aligned}
"""),
    StepItem(tex: r"""\textcolor{blue}{\textbf{【第2項の計算】}}"""),
    StepItem(tex: r"""\text{分母 } 1-x+x^2 \text{ の導関数は } 2x-1 \text{ である。したがって、}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{0}^{1}\displaystyle \frac{2x-1}{1-x+x^2}dx
&=\left[\log(1-x+x^2)\right]_{0}^{1}\\[6pt]
&=\log(1-1+1)-\log(1-0+0)\\[6pt]
&=\log 1-\log 1\\[6pt]
&=0
\end{aligned}
"""),
    StepItem(tex: r"""\textcolor{blue}{\textbf{【第3項の計算】}}"""),
    StepItem(tex: r"""
    \displaystyle \int_{0}^{1}\displaystyle \frac{dx}{1-x+x^2} =\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{\left(x-\displaystyle \frac{1}{2}\right)^2+\left(\displaystyle \frac{\sqrt{3}}{2}\right)^2}
    """),
    StepItem(tex: r"""\text{ここで変数変換 } x=\displaystyle \frac{1}{2}+\displaystyle \frac{\sqrt{3}}{2}u \text{ を行う。このとき、} dx=\displaystyle \frac{\sqrt{3}}{2}du \text{ である。}"""),
    StepItem(tex: r"""\text{積分範囲の変換：}
    \begin{aligned}
    \begin{cases}
    x=0 \Leftrightarrow 0=\displaystyle \frac{1}{2}+\displaystyle \frac{\sqrt{3}}{2}u \Leftrightarrow \displaystyle \frac{\sqrt{3}}{2}u=-\displaystyle \frac{1}{2} \Leftrightarrow u=-\displaystyle \frac{1}{\sqrt{3}},\\[5pt]
    x=1 \Leftrightarrow 1=\displaystyle \frac{1}{2}+\displaystyle \frac{\sqrt{3}}{2}u \Leftrightarrow \displaystyle \frac{\sqrt{3}}{2}u=\displaystyle \frac{1}{2} \Leftrightarrow u=\displaystyle \frac{1}{\sqrt{3}}
    \end{cases}
    \end{aligned}"""),
    StepItem(tex: r"""\text{したがって、}"""),
    StepItem(tex: r"""\begin{aligned}
&=\displaystyle \int_{-\frac{1}{\sqrt{3}}}^{\frac{1}{\sqrt{3}}}\displaystyle \frac{\displaystyle \frac{\sqrt{3}}{2}du}{\left(\displaystyle \frac{\sqrt{3}}{2}u\right)^2+\left(\displaystyle \frac{\sqrt{3}}{2}\right)^2}\\[6pt]
&=\displaystyle \int_{-\frac{1}{\sqrt{3}}}^{\frac{1}{\sqrt{3}}}\displaystyle \frac{\displaystyle \frac{\sqrt{3}}{2}du}{\displaystyle \frac{3u^2}{4}+\displaystyle \frac{3}{4}}\\[6pt]
&=\displaystyle \int_{-\frac{1}{\sqrt{3}}}^{\frac{1}{\sqrt{3}}}\displaystyle \frac{\displaystyle \frac{\sqrt{3}}{2}du}{\displaystyle \frac{3}{4}(u^2+1)}\\[6pt]
&=\displaystyle \frac{2}{\sqrt{3}}\displaystyle \int_{-\frac{1}{\sqrt{3}}}^{\frac{1}{\sqrt{3}}}\displaystyle \frac{du}{u^2+1}
\end{aligned}
"""),
    StepItem(tex: r"""\text{ここで、} \displaystyle \int\displaystyle \frac{du}{u^2+1} \text{ を計算するため、} u=\tan\theta \text{ とおく：}"""),
    StepItem(tex: r"""\text{積分範囲の変換：}
    \begin{aligned}
    \begin{cases}
    u=-\displaystyle \frac{1}{\sqrt{3}} \Leftrightarrow \tan\theta=-\displaystyle \frac{1}{\sqrt{3}} \Leftrightarrow \theta=-\displaystyle \frac{\pi}{6},\\[5pt]
    u=\displaystyle \frac{1}{\sqrt{3}} \Leftrightarrow \tan\theta=\displaystyle \frac{1}{\sqrt{3}} \Leftrightarrow \theta=\displaystyle \frac{\pi}{6}
    \end{cases}
    \end{aligned}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \frac{2}{\sqrt{3}}\displaystyle \int_{-\frac{1}{\sqrt{3}}}^{\frac{1}{\sqrt{3}}}\displaystyle \frac{du}{u^2+1}
&=\displaystyle \frac{2}{\sqrt{3}}\displaystyle \int_{-\frac{\pi}{6}}^{\frac{\pi}{6}}\displaystyle \frac{\displaystyle \frac{1}{\cos^2\theta}d\theta}{\tan^2\theta+1}\\[6pt]
&=\displaystyle \frac{2}{\sqrt{3}}\displaystyle \int_{-\frac{\pi}{6}}^{\frac{\pi}{6}}\displaystyle \frac{\displaystyle \frac{1}{\cos^2\theta}d\theta}{\displaystyle \frac{1}{\cos^2\theta}}\\[6pt]
&=\displaystyle \frac{2}{\sqrt{3}}\displaystyle \int_{-\frac{\pi}{6}}^{\frac{\pi}{6}}d\theta\\[6pt]
&=\displaystyle \frac{2}{\sqrt{3}}\left[\theta\right]_{-\frac{\pi}{6}}^{\frac{\pi}{6}}\\[6pt]
&=\displaystyle \frac{2}{\sqrt{3}}\left(\displaystyle \frac{\pi}{6}-\left(-\displaystyle \frac{\pi}{6}\right)\right)\\[6pt]
&=\displaystyle \frac{2}{\sqrt{3}}\cdot\displaystyle \frac{\pi}{3}\\[6pt]
&=\displaystyle \frac{2\pi}{3\sqrt{3}}
\end{aligned}
"""),
    StepItem(tex: r"""\textbf{【まとめ】}"""),
    StepItem(tex: r"""\text{3つの積分の結果をまとめると、}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{1+x^{3}}
&=\displaystyle \frac{1}{3}\cdot\log 2-\displaystyle \frac{1}{6}\cdot 0+\displaystyle \frac{1}{2}\cdot\displaystyle \frac{2\pi}{3\sqrt{3}}\\[6pt]
&=\displaystyle \frac{1}{3}\log 2+\displaystyle \frac{\pi}{3\sqrt{3}}
\end{aligned}
"""),
  ],
),
];