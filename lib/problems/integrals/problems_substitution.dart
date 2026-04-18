import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// ============================================================================
/// 置換積分および関連する積分問題 11問
/// ============================================================================


/// - 各問題は「【方針】」「【ポイント】」「【解説】」「【補足】」の順で整理。
/// - 数式は \begin{aligned} ... \end{aligned} を用いて段階的に全変形を記載。
/// - 逆三角関数は【解答】には用いず、【補足】としてのみ記載。
/// - cot, csc, sec は使用しない（必要な恒等式は 1+\tan^2\theta を用いる）。
const substitutionProblems = <MathProblem>[
  // 1) ∫ sin x cos x dx
  MathProblem(
    id: "680C8A2D-4E18-4E76-97F7-5F59531CD4DD",
    no: 1,
    category: '置換積分',
    level: '初級',
    question: r"\displaystyle \int_{0}^{\frac{\pi}{4}} \sin x \cos x \,dx",
    answer: r"\displaystyle \frac{1}{4}",
    imageAsset: 'assets/graphs/integral/problems_substitution/problem_1.png',
    hint: r"""\; u=\sin x \,\textbf{ と置く。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\; u=\sin x \,\textbf{ と置く。}"""
      ),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r""" du=\cos x\,dx \text{なので、}"""),
      StepItem(tex: r"""\text{積分範囲の変換：}"""),
      StepItem(tex: r"""\begin{aligned}
\begin{cases}
x=0 \Leftrightarrow u=\sin 0=0,\\[5pt]
x=\displaystyle\frac{\pi}{4} \Leftrightarrow u=\sin\displaystyle\frac{\pi}{4}=\displaystyle\frac{\sqrt{2}}{2}
\end{cases}
\end{aligned}"""),
      StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{0}^{\frac{\pi}{4}} \sin x \cos x\,dx
=&\displaystyle \int_{0}^{\frac{\sqrt{2}}{2}} u\,du\\
=&\left[\displaystyle\frac{1}{2}u^{2}\right]_{0}^{\frac{\sqrt{2}}{2}}\\
=&\displaystyle\frac{1}{2}\left(\displaystyle\frac{\sqrt{2}}{2}\right)^{2}-\displaystyle\frac{1}{2}\cdot 0^{2}\\
=&\displaystyle\frac{1}{2}\cdot\displaystyle\frac{2}{4}\\
=&\displaystyle\frac{1}{4}
\end{aligned}"""
      ),
    ],
  ),

  // 2) ∫₀^√3 x / √(1 + x^2) dx
  MathProblem(
    id: "183166B0-C425-4604-B488-2D51C73267D5",
    no: 2,
    category: '置換積分',
    level: '初級',
    question: r"\displaystyle \int_{0}^{\sqrt{3}} \displaystyle \frac{x}{\sqrt{1+x^{2}}}\,dx",
    answer: r"1",
    imageAsset: 'assets/graphs/integral/problems_substitution/problem_2.png',
    hint: r"""\; u=1+x^{2} \,\textbf{と置く。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\; u=1+x^{2} \,\textbf{と置く。}"""
      ),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r""" du=2x\,dx \,\textbf{なので}"""),
      StepItem(tex: r"""\text{積分範囲の変換：}"""),
      StepItem(tex: r"""\begin{aligned}
\begin{cases}
x=0 \Leftrightarrow u=1+0^{2}=1,\\[5pt]
x=\sqrt{3} \Leftrightarrow u=1+(\sqrt{3})^{2}=1+3=4
\end{cases}
\end{aligned}"""),
      StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{0}^{\sqrt{3}} \displaystyle \frac{x}{\sqrt{1+x^{2}}}\,dx
=&\displaystyle \int_{0}^{\sqrt{3}} \displaystyle\frac1 2 \frac{2x}{\sqrt{1+x^{2}}}\,dx\\
=&\displaystyle \displaystyle \frac{1}{2} \int_{1}^{4} \displaystyle \frac{1}{\sqrt{u}}\cdot \,du\\
=&\displaystyle \frac{1}{2}\displaystyle \int_{1}^{4} u^{- \frac{1}{2}}\,du\\
=&\displaystyle \frac{1}{2}\left[\displaystyle \frac{u^{ \frac{1}{2}}}{\displaystyle \frac{1}{2}}\right]_{1}^{4}\\
=&\left[\sqrt{u}\right]_{1}^{4}\\
=&\sqrt{4}-\sqrt{1}\\
=&2-1\\
=&1
\end{aligned}"""
      ),
    ],
  ),

  // 予備問題は problems_substitution_reserve.dart に移動しました
  // コメントアウトを外すと問題リストに追加されます

  // arccos を原始関数にするバージョン（no:7 — 修正版）
MathProblem(
    id: "BDCAAAB3-8109-4E6B-8A45-9EFD024A0B05",
  no: 4,
  category: '置換積分',
  level: '初級',
  question: r"\displaystyle \int_{2}^{2\sqrt{3}} \displaystyle \frac{dx}{\sqrt{16 - x^{2}}}",
  answer: r"\displaystyle \frac{\pi}{6}",
  imageAsset: 'assets/graphs/integral/problems_substitution/problem_4.png',
  hint: r"""\; x=4\sin\theta \textbf{ と置く。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\; x=4\sin\theta \textbf{ と置く。}"""),
    StepItem(tex: r"""\textbf{【解説】}"""),
    StepItem(tex: r"""x = 2 \rightarrow 2\sqrt{3}\text{の時、} 2=4\sin\theta \Leftrightarrow \sin\theta=\displaystyle \frac{1}{2} \text{より } \theta=\displaystyle \frac{\pi}{6} \text{であり、} 2\sqrt{3}=4\sin\theta \Leftrightarrow \sin\theta=\displaystyle \frac{\sqrt{3}}{2} \text{より } \theta=\displaystyle \frac{\pi}{3}\text{である。}"""),
    StepItem(tex: r""" 16-x^{2}=16-16\sin^{2}\theta=16(1-\sin^{2}\theta)=16\cos^{2}\theta,\ dx = \displaystyle \frac{dx}{d\theta} d\theta =4\cos \theta d\theta """),
    StepItem(tex: r"""\text{なので、}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{2}^{2\sqrt{3}} \displaystyle \frac{dx}{\sqrt{16-x^{2}}}
=&\displaystyle \int_{\frac{\pi}{6}}^{\frac{\pi}{3}}\displaystyle \frac{4\cos\theta\,d\theta}{\sqrt{16-16\sin^{2}\theta}}\\
=&\displaystyle \int_{\frac{\pi}{6}}^{\frac{\pi}{3}}\displaystyle \frac{4\cos\theta\,d\theta}{\sqrt{16\cos^{2}\theta}}\\
=&\displaystyle \int_{\frac{\pi}{6}}^{\frac{\pi}{3}}\displaystyle \frac{4\cos\theta\,d\theta}{4|\cos\theta|}\\
=&\displaystyle \int_{\frac{\pi}{6}}^{\frac{\pi}{3}}\displaystyle \frac{4\cos\theta\,d\theta}{4\cos\theta}\\
=&\displaystyle \int_{\frac{\pi}{6}}^{\frac{\pi}{3}}1\ d\theta\\
=&\left[\theta\right]_{\frac{\pi}{6}}^{\frac{\pi}{3}}\\
=&\displaystyle \frac{\pi}{3} - \displaystyle \frac{\pi}{6}\\
=&\displaystyle \frac{\pi}{6}
\end{aligned}"""
    ),
    StepItem(tex: r"""\textbf{【補足】}"""),
    StepItem(tex: r"""\text{逆正弦関数 } \arcsin x \text{を用いる。 }\arcsin x \text{の定義域は } [-1, 1] \text{、値域は } \left[-\displaystyle \frac{\pi}{2}, \displaystyle \frac{\pi}{2}\right] \text{ である。}"""),
    StepItem(tex: r"""\text{公式 } \displaystyle \int \displaystyle \frac{dx}{\sqrt{a^{2}-x^{2}}} =\arcsin\displaystyle \frac{x}{a} + C \text{ を用いる。ここで、} a=4 \text{ である。}"""),
    StepItem(tex: r"""\text{まず不定積分を求める。}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \int \displaystyle \frac{dx}{\sqrt{16-x^{2}}}
&= \displaystyle \int \displaystyle \frac{dx}{\sqrt{4^{2}-x^{2}}}\\
&= \arcsin\displaystyle \frac{x}{4} + C
\end{aligned}
"""),
    StepItem(tex: r"""\text{したがって、定積分は、}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{2}^{2\sqrt{3}} \displaystyle \frac{dx}{\sqrt{16-x^{2}}}
&= \left[\arcsin\displaystyle \frac{x}{4}\right]_{2}^{2\sqrt{3}}\\
&= \arcsin\displaystyle \frac{2\sqrt{3}}{4} - \arcsin\displaystyle \frac{2}{4}\\
&= \arcsin\displaystyle \frac{\sqrt{3}}{2} - \arcsin\displaystyle \frac{1}{2}\\
&= \displaystyle \frac{\pi}{3} - \displaystyle \frac{\pi}{6}\\
&= \displaystyle \frac{\pi}{6}
\end{aligned}
"""),
  ],
),

  // 5) ∫ₑ^(e²) dx / (x log x)
  MathProblem(
    id: "7FF2277B-44DC-480A-B1BF-7D1990121B24",
    no: 5,
    category: '置換積分',
    level: '初級',
    question: r"\displaystyle \int_{e}^{e^{2}} \displaystyle \frac{dx}{x\log x}",
    answer: r"\log 2",
    imageAsset: 'assets/graphs/integral/problems_substitution/problem_5.png',
    hint: r"""\; u=\log x \,\textbf{ と置くと、}\; du= \frac{dx}{x} \textbf{を用いる。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\; u=\log x \,\textbf{ と置くと、}\,"""),
      StepItem(tex: r"""du= \frac{dx}{x} \textbf{を用いる。}"""
      ),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{まず原始関数（不定積分）を求める。}"""),
      StepItem(tex: r"""\begin{aligned}
\displaystyle \int \displaystyle \frac{dx}{x\log x}
&= \displaystyle \int \displaystyle \frac{1}{u}\,du\\
&= \log|u|+C\\
&= \log|\log x|+C
\end{aligned}"""
      ),
      StepItem(tex: r"""\text{したがって、定積分は、}"""),
      StepItem(tex: r"""\text{積分範囲の変換：}"""),
      StepItem(tex: r"""\begin{aligned}
\begin{cases}
x=e \Leftrightarrow u=\log e=1,\\[5pt]
x=e^{2} \Leftrightarrow u=\log(e^{2})=2
\end{cases}
\end{aligned}"""),
      StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{e}^{e^{2}} \displaystyle \frac{dx}{x\log x}
&= \int_{1}^{2} \displaystyle \frac{1}{u}\,du\\
&= \left[\log|u|\right]_{1}^{2}\\
&= \log 2 - \log 1\\
&= \log 2 - 0\\
&= \log 2
\end{aligned}"""
      ),
      StepItem(tex: r"""\textbf{【補足】}"""),
      StepItem(tex: r"""\text{定義域 } x>1 \text{（} x>0 \text{で } \log x \text{が定義され、さらに } x>1 \text{で } \log x>0 \text{ となる）}"""
      ),
    ],
  ),

  // 6) ∫₀^(π/6) sin²x cos x dx
  MathProblem(
    id: "BED49300-099F-4DD3-9DC6-1AB5635BEC1B",
    no: 6,
    category: '置換積分',
    level: '初級',
    question: r"\displaystyle \int_{0}^{\frac{\pi}{6}} \sin^{2}x \cos x \,dx",
    answer: r"\displaystyle \frac{1}{24}",
    imageAsset: 'assets/graphs/integral/problems_substitution/problem_6.png',
    hint: r"""\; u=\sin x \,\textbf{と置く。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\; u=\sin x \,\textbf{と置く。}"""
      ),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r""" u=\sin x , du=\cos x\,dx \,\textbf{となるので、}"""),
      StepItem(tex: r"""\text{積分範囲の変換：}"""),
      StepItem(tex: r"""\begin{aligned}
\begin{cases}
x=0 \Leftrightarrow u=\sin 0=0,\\[5pt]
x=\displaystyle\frac{\pi}{6} \Leftrightarrow u=\sin\displaystyle\frac{\pi}{6}=\displaystyle\frac{1}{2}
\end{cases}
\end{aligned}"""),
      StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{0}^{\frac{\pi}{6}} \sin^{2}x \cos x\,dx
=&\displaystyle \int_{0}^{\frac{1}{2}} u^{2}\,du\\
=&\left[\displaystyle\frac{1}{3}u^{3}\right]_{0}^{\frac{1}{2}}\\
=&\displaystyle\frac{1}{3}\left(\displaystyle\frac{1}{2}\right)^{3}-\displaystyle\frac{1}{3}\cdot 0^{3}\\
=&\displaystyle\frac{1}{3}\cdot\displaystyle\frac{1}{8}\\
=&\displaystyle\frac{1}{24}
\end{aligned}"""
      ),
    ],
  ),

  // 7) ∫₀¹ dx / (1 + x²) — 三角置換
  MathProblem(
    id: "76E997DF-6492-444C-91C9-F3EC13EB7F41",
    no: 7,
    category: '置換積分',
    level: '初級',
    question: r"\displaystyle \int_{0}^{1} \displaystyle \frac{dx}{1 + x^{2}}",
    answer: r"\displaystyle \frac{\pi}{4}",
    imageAsset: 'assets/graphs/integral/problems_substitution/problem_7.png',
    hint: r"""\; x=\tan\theta \,\textbf{ と置換する。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\; x=\tan\theta \,\textbf{ と置換する。}"""
      ),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""x=\tan\theta\text{とすると、}"""),
      StepItem(tex: r"""dx =\displaystyle  \frac{dx}{d\theta} d\theta =\displaystyle \frac{1}{\cos ^2 \theta} d\theta"""),
      StepItem(tex: r"""x = 0 \rightarrow 1 \text{の時、} \tan \theta =0\rightarrow \displaystyle \frac {\pi}{4}\text{より、}"""),
      StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{1+x^{2}}
=&\displaystyle \int_{0}^{ \frac{\pi}{4}}\displaystyle \frac{1}{1+\tan^{2}\theta} \frac{1}{\cos^{2}\theta} d\theta\\
=&\displaystyle \int_{0}^{ \frac{\pi}{4}}\displaystyle \frac{1}{1+\tan^{2}\theta} (1+\tan^{2}\theta) d\theta\\
=&\displaystyle \int_{0}^{ \frac{\pi}{4}}1\,d\theta\\
=&\left.\theta\right|_{0}^{ \frac{\pi}{4}}\\
=&\displaystyle \frac{\pi}{4}
\end{aligned}"""
      ),
      StepItem(tex: r"""\textbf{【補足】}"""),
      StepItem(tex: r"""\; tan\text{の逆関数}\arctan \text{を用いると、} \displaystyle \int \displaystyle \frac{dx}{1+x^{2}}=\arctan x + C \text{であり、これを用いると早い。}"""
      ),
    ],
  ),



  // 8) ∫_{1/4}^{3/4} dx / √[x(1-x)]
  MathProblem(
    id: "17D1526C-1324-4C82-8D05-59B9308E14D2",
    no: 8,
    category: '置換積分',
    level: '上級',
    question: r"\displaystyle \int_{\frac{1}{4}}^{\frac{3}{4}} \displaystyle \frac{dx}{\sqrt{x(1-x)}}",
    answer: r"\displaystyle \frac{\pi}{3}",
    imageAsset: 'assets/graphs/integral/problems_substitution/problem_8.png',
    hint: r"""\; x=\sin^{2}\theta \,\textbf{と置換する。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\; x=\sin^{2}\theta \,\textbf{と置換する。}"""
      ),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""x=\sin^{2}\theta \text{と置くと、} x=\displaystyle \frac{1}{4}\rightarrow \displaystyle \frac{3}{4} \text{の時、} \sin^{2}\theta=\displaystyle \frac{1}{4}\rightarrow \displaystyle \frac{3}{4} \text{より、} \sin\theta=\displaystyle \frac{1}{2}\rightarrow \displaystyle \frac{\sqrt{3}}{2} \text{なので、} \theta=\displaystyle \frac{\pi}{6}\rightarrow \displaystyle \frac{\pi}{3} \text{と対応させる。} """),
      StepItem(tex: r"""\text{また、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      \sqrt{x(1-x)}=&\sqrt{\sin^{2}\theta(1-\sin^{2}\theta)} \\
      =& |\sin \theta \cos \theta|\\
      \underset{\frac{\pi}{6}\le \theta \le \frac{\pi}{3} }{=}&\sin \theta \cos \theta
      \end{aligned}"""
      ),
      StepItem(tex: r"""\text{さらに、}dx= \displaystyle \frac{dx}{d\theta}d\theta = 2\sin \theta \cos \theta d\theta \text{となるので、}"""),
      StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{\frac{1}{4}}^{\frac{3}{4}} \displaystyle \frac{dx}{\sqrt{x(1-x)}}
=&\displaystyle \int_{\frac{\pi}{6}}^{ \frac{\pi}{3}} \displaystyle \frac{2\sin\theta\cos\theta\,d\theta}{\sin\theta\cos\theta}\\
=&\displaystyle \int_{\frac{\pi}{6}}^{ \frac{\pi}{3}}2\,d\theta\\
=&\left.2\theta\right|_{\frac{\pi}{6}}^{ \frac{\pi}{3}}\\
=&2\left(\displaystyle \frac{\pi}{3}-\displaystyle \frac{\pi}{6}\right)\\
=&2 \cdot \displaystyle \frac{\pi}{6}\\
=&\displaystyle \frac{\pi}{3}
\end{aligned}"""
      ),
      StepItem(tex: r"""\textbf{【補足】}"""),
      StepItem(tex: r"""\text{大学ではベータ関数}B\!\left(\displaystyle \frac{1}{2},\displaystyle \frac{1}{2}\right)=\pi \text{として登場する。}"""
      ),
    ],
  ),
// 9) n=6 に固定（偶奇性＋展開で計算、補足でβ関数による一般論と確認）
MathProblem(
  id: "18A36D0E-7123-4A0D-8AE6-E8453099D9A9",
  no: 9,
  category: '対称性（置換）',
  level: '初級',
  question: r"\displaystyle \int_{-1}^{1}(1-x^{2})^{3}\,dx",
  answer: r"\displaystyle \frac{32}{35}",
  imageAsset: 'assets/graphs/integral/problems_substitution/problem_9.png',
  hint: r"""\; \textbf{被積分関数は偶関数なので }\left[-1,1\right] を \left[0,1\right] の2倍にし、(1-x^2)^3 を展開して項別に積分する。""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\; \textbf{被積分関数は偶関数なので }\left[-1,1\right] を \left[0,1\right] の2倍にし、(1-x^2)^3 を展開して項別に積分する。"""),
    StepItem(tex: r"""\textbf{【展開】}"""),
    StepItem(tex: r"""\;(1-x^{2})^{3}=1-3x^{2}+3x^{4}-x^{6}"""),
    StepItem(tex: r"""\textbf{【計算】}"""),
    StepItem(tex: r"""\text{被積分関数は偶関数なので、}"""),
    StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \ \displaystyle \int_{-1}^{1}(1-x^{2})^{3}\,dx\\
&= 2\displaystyle \int_{0}^{1}(1-x^{2})^{3}\,dx\\[4pt]
&= 2\displaystyle \int_{0}^{1}\bigl(1-3x^{2}+3x^{4}-x^{6}\bigr)\,dx\\[4pt]
&= 2\left(\displaystyle \int_{0}^{1}1\,dx
-3\displaystyle \int_{0}^{1}x^{2}\,dx
+3\displaystyle \int_{0}^{1}x^{4}\,dx
-\displaystyle \int_{0}^{1}x^{6}\,dx\right)
\end{aligned}"""),
    StepItem(tex: r"""\begin{alignedat}{2}
    &\displaystyle \int_{0}^{1}1\,dx &&= 1\\[4pt]
    &\displaystyle \int_{0}^{1}x^{2}\,dx &&= \dfrac{1}{3}\\[4pt]
    &\displaystyle \int_{0}^{1}x^{4}\,dx &&= \dfrac{1}{5}\\[4pt]
    &\displaystyle \int_{0}^{1}x^{6}\,dx &&= \dfrac{1}{7}
\end{alignedat}\text{　なので、}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{-1}^{1}(1-x^{2})^{3}\,dx
&= 2\left(1 -3\cdot \dfrac{1}{3} +3\cdot \dfrac{1}{5} - \dfrac{1}{7}\right)\\[6pt]
&= 2\left(1-1+\dfrac{3}{5}-\dfrac{1}{7}\right)\\[6pt]
&= 2\left(\dfrac{3}{5}-\dfrac{1}{7}\right)\\[6pt]
&= 2\cdot \dfrac{3\cdot7-1\cdot5}{35}\\[6pt]
&= 2\cdot \dfrac{21-5}{35}\\[6pt]
&= 2\cdot \dfrac{16}{35}\\[6pt]
&= \dfrac{32}{35}
\end{aligned}"""),
//     StepItem(tex: r"""\textbf{【補足(ガンマ関数)】}"""),
//     StepItem(tex: r""" 大学で習うガンマ関数を用いると、一般に"""),
// StepItem(tex: r"""
// \displaystyle \int_{-1}^{1}(1-x^{2})^{\frac{n}{2}}\,dx
// =\sqrt{\pi}\,\dfrac{\Gamma\!\left(\dfrac{n+2}{2}\right)}{\Gamma\!\left(\dfrac{n+3}{2}\right)}.
// """),
// StepItem(tex: r"""
// \(n=6\) \text{を代入すると}
// \[
// \sqrt{\pi}\,\dfrac{\Gamma(4)}{\Gamma\!\left(\frac{9}{2}\right)}
// =\sqrt{\pi}\,\dfrac{3!}{\dfrac{105}{16}\sqrt{\pi}}
// =\dfrac{6\cdot16}{105}
// =\dfrac{96}{105}
// =\dfrac{32}{35},
// \]
// となり、上の多項式展開による結果と一致する。"""),
  ],
),


  // 10) ∫₁ᵉ (log x)/x² dx
  MathProblem(
    id: "EE0E5F29-6071-4A82-BBA0-6D3DAAD6BB0C",
    no: 10,
    category: '対数（置換）',
    level: '中級',
    question: r"\displaystyle \int_{1}^{e}\displaystyle \frac{\log  x}{x^{2}}\,dx",
    answer: r"\displaystyle 1 - \displaystyle \frac{2}{e}",
    imageAsset: 'assets/graphs/integral/problems_substitution/problem_10.png',
    hint: r""" t=\log x \,\textbf{ と置き、} x=e^{t},\,dx=e^{t}dt \textbf{で指数関数に直したのち、部分積分を行う。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r""" t=\log x \,\textbf{ と置き、}
        x=e^{t},\,dx=e^{t}dt"""),
      StepItem(tex: r"""\textbf{で指数関数に直したのち、部分積分を行う。}"""
      ),
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{1}^{e}\displaystyle \frac{\log x}{x^{2}}\,dx
=&\displaystyle \int_{t=0}^{1} t\cdot e^{-2t}\cdot e^{t}\,dt\\
=&\displaystyle \int_{0}^{1} t\,e^{-t}\,dt.
\end{aligned}
"""),
      StepItem(tex: r"""\text{ここで部分積分を用いる}"""),
      StepItem(tex: r"""\begin{aligned}
&\displaystyle \int_{0}^{1} t\,e^{-t}\,dt\\
=&\displaystyle \int_{0}^{1} t\,(-e^{-t})'\,dt\\
=&\left[-t\,e^{-t}\right]_{0}^{1}+\displaystyle \int_{0}^{1} e^{-t}\,dt\\
=&\left(-e^{-1}-0\right)+\left[-e^{-t}\right]_{0}^{1}\\
=&-\displaystyle \frac{1}{e}+\left(-e^{-1}+1\right)\\
=&1-\displaystyle \frac{2}{e}
\end{aligned}"""
      ),
    ],
  ),

  // 11) ∫_{π/4}^{π/3} tan²x (tan²x + 1) dx （tan→u 置換）
  MathProblem(
    id: "A191EF43-6467-4047-8FE9-BFEE5B89D08E",
    no: 11,
    category: '置換（tan→u）',
    level: '中級',
    question: r"\displaystyle \int_{ \frac {\pi} {4}}^{\frac{\pi}{3}}\tan^{2}x\left(\tan^{2}x+1\right)\,dx",
    answer: r" \displaystyle \sqrt{3} -\displaystyle \frac{1}{3}",
    imageAsset: 'assets/graphs/integral/problems_substitution/problem_11.png',
    hint: r"""\; u=\tan x \,\textbf{と置換する。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\; u=\tan x \,\textbf{と置換する。}"""
      ),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""du = \displaystyle \frac{d u}{dx} dx = \frac{dx}{\cos^2 x} = (1+\tan^2 x) dx \text{なので、}"""),
      StepItem(tex: r"""\begin{aligned}
  &\displaystyle \int_{ \frac{\pi}{4}}^{\frac{\pi}{3}}\tan^{2}x\left(1 + \tan^{2}x\right)\,dx\\
  =&\displaystyle \int_{\tan\left(\frac{\pi}{4}\right)}^{\tan\left(\frac{\pi}{3}\right)} u^{2} \,du\\
  =&\displaystyle \int_{1}^{\sqrt{3}} u^{2} \,du\\
  =&\left[ \displaystyle \frac{u^{3}}{3}\right]_{1}^{\sqrt{3}}\\
  =&\displaystyle \frac{\sqrt{3}^3-1^3}{3}\\
  =&\displaystyle \sqrt{3}- \displaystyle \frac{1}{3}
  \end{aligned}"""
      ),
    ],
  ),
];