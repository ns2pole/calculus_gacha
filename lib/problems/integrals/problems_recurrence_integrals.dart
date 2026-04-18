import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// 漸化式系の積分問題一覧3問（改善版）
/// - 各問題に「【方針】」「【ポイント】」「【解説】」「【補足】」を明確に区分
/// - すべての answer は数値（π, e, ルート, log, 分数, 累乗 などの記号は可）で記載
/// - 解説は式変形を一切省略せず、\begin{aligned} を用いて丁寧に記載
/// - 逆三角関数・双曲線関数は解答では用いず、必要なら補足で言及
const recurrenceIntegralProblems = <MathProblem>[
  MathProblem(
    id: "4E69F402-F551-49E7-A295-047AD1C75481",
    no: 1,
    category: '漸化式系の積分',
    level: '中級',
    question: r"""I_{n}=\displaystyle \int_{0}^{ \frac {\pi} {2}}\sin^n x\,dx\quad (n\ge 0)
\quad
I_{0},\,I_{1}\text{ を求めよ}
""",
    answer: r""" 
I_{0} = \displaystyle \frac{\pi}{2},\quad I_{1} = 1
""",
    imageAsset: 'assets/graphs/basic_definite_integral_areas/problem_1.png',
    hint: r"""\text{定義に従い }n=0,1\text{ の積分を直接計算する。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{定義に従い }n=0,1\text{ の積分を直接計算する。}"""),

      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\text{基本積分：}\ \displaystyle \int 1\,dx = x,\ \displaystyle \int \sin x\,dx = -\cos x\ \text{。評価区間は }[0,\displaystyle \frac{\pi}{2}]\text{。}"""),

      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(
        tex: r"""\begin{aligned}
I_{0}
&= \displaystyle \int_{0}^{ \frac{\pi}{2}} 1\,dx \\
&= \left[ x \right]_{0}^{ \frac{\pi}{2}} \\
&= \displaystyle \frac{\pi}{2} - 0 \\
&= \displaystyle \frac{\pi}{2}
\end{aligned}
""",
      ),
      StepItem(
        tex: r"""\begin{aligned}
I_{1}
&= \displaystyle \int_{0}^{ \frac{\pi}{2}} \sin x\,dx \\
&= \left[ -\cos x \right]_{0}^{ \frac{\pi}{2}} \\
&= \left(-\cos \displaystyle \frac{\pi}{2}\right) - \left(-\cos 0\right) \\
&= 0 - (-1) \\
&= 1
\end{aligned}
""",
      ),

      StepItem(tex: r"""\textbf{【補足】}"""),
      StepItem(tex: r"""\text{本問は直接計算のみで十分である。ベータ関数でも評価可能だが、ここでは用いない。}"""),
    ],
  ),

  MathProblem(
    id: "E4E57A29-3A93-42B0-85A5-D5098551A8AC",
    no: 2,
    category: '漸化式系の積分',
    level: '中級',
    question: r"""J_{n}=\displaystyle \int_{0}^{ \frac {\pi} {2}}\cos^{2n}x\,dx
\quad
J_{n-1}\text{ から }J_{n}\text{ を表せ}
""",
    answer: r""" 
J_{n} = \displaystyle \frac{\pi}{2}\cdot\displaystyle \frac{(2n)!}{2^{2n}\,(n!)^{2}}
""",
    imageAsset: 'assets/graphs/basic_definite_integral_areas/problem_2.png',
    hint: r"""\text{部分積分で漸化式 }J_{n}=\displaystyle \frac{2n-1}{2n}J_{n-1}\text{ を導出し、}J_{0}=\displaystyle \frac{\pi}{2}\text{ から積を展開して閉じた形を得る。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{部分積分で漸化式 }J_{n}=\displaystyle \frac{2n-1}{2n}J_{n-1}\text{ を導出し、}J_{0}=\displaystyle \frac{\pi}{2}\text{ から積を展開して閉じた形を得る。}"""),

      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\text{部分積分の設定： }u=\cos^{2n-1}x,\ dv=\cos x\,dx\ (\Rightarrow\ du=-(2n-1)\cos^{2n-2}x\sin x\,dx,\ v=\sin x)。"""),
      StepItem(tex: r"""\text{境界項は }x=0,\ \displaystyle \frac{\pi}{2}\text{ で } \cos^{2n-1}x\sin x=0\ \text{となり消える。}"""),
      StepItem(tex: r"""\text{恒等式 } \sin^{2}x=1-\cos^{2}x \text{ を用いて }J_{n-1},J_{n}\text{ に分離する。}"""),

      StepItem(tex: r"""\textbf{【解説】（漸化式の導出）}"""),
      StepItem(
        tex: r"""\begin{aligned}
J_{n}
&= \displaystyle \int_{0}^{ \frac{\pi}{2}} \cos^{2n}x\,dx \\
&= \displaystyle \int_{0}^{ \frac{\pi}{2}} \cos^{2n-1}x\cdot\cos x\,dx \\
&= \left[ \cos^{2n-1}x\cdot\sin x \right]_{0}^{ \frac{\pi}{2}}
   - \displaystyle \int_{0}^{ \frac{\pi}{2}} \sin x \cdot \left(-(2n-1)\cos^{2n-2}x\sin x\right)\,dx \\
&= 0 + (2n-1)\displaystyle \int_{0}^{ \frac{\pi}{2}} \cos^{2n-2}x\,\sin^{2}x\,dx \\
&= (2n-1)\displaystyle \int_{0}^{ \frac{\pi}{2}} \cos^{2n-2}x\,(1-\cos^{2}x)\,dx \\
&= (2n-1)\displaystyle \int_{0}^{ \frac{\pi}{2}} \cos^{2n-2}x\,dx
   - (2n-1)\displaystyle \int_{0}^{ \frac{\pi}{2}} \cos^{2n}x\,dx \\
&= (2n-1)J_{n-1} - (2n-1)J_{n}
\end{aligned}
""",
      ),
      StepItem(
        tex: r"""\begin{aligned}
J_{n} + (2n-1)J_{n}
&= (2n-1)J_{n-1} \\
2n\,J_{n}
&= (2n-1)J_{n-1} \\
J_{n}
&= \displaystyle \frac{2n-1}{2n}\,J_{n-1}
\end{aligned}
""",
      ),

      StepItem(tex: r"""\textbf{【解説】（初期値と積の展開）}"""),
      StepItem(
        tex: r"""\begin{aligned}
J_{0}
&= \displaystyle \int_{0}^{ \frac{\pi}{2}} 1\,dx \\
&= \left[ x \right]_{0}^{ \frac{\pi}{2}} \\
&= \displaystyle \frac{\pi}{2}
\end{aligned}
""",
      ),
      StepItem(
        tex: r"""\begin{aligned}
J_{n}
&= \displaystyle \frac{2n-1}{2n}\cdot \displaystyle \frac{2n-3}{2n-2}\cdots \displaystyle \frac{1}{2}\cdot J_{0} \\
&= \left( \prod_{k=1}^{n} \displaystyle \frac{2k-1}{2k} \right)\cdot \displaystyle \frac{\pi}{2}
\end{aligned}
""",
      ),

      StepItem(tex: r"""\textbf{【解説】（積を階乗で表す）}"""),
      StepItem(
        tex: r"""\begin{aligned}
\prod_{k=1}^{n} (2k-1)
&= 1\cdot 3 \cdot 5 \cdots (2n-1) \\
&= \displaystyle \frac{1\cdot 2 \cdot 3 \cdots (2n)}{2\cdot 4 \cdot 6 \cdots (2n)} \\
&= \displaystyle \frac{(2n)!}{2^{n}\,n!}
\end{aligned}
""",
      ),
      StepItem(
        tex: r"""\begin{aligned}
\prod_{k=1}^{n} (2k)
&= 2\cdot 4 \cdot 6 \cdots (2n) \\
&= 2^{n}\,n!
\end{aligned}
""",
      ),
      StepItem(
        tex: r"""\begin{aligned}
\prod_{k=1}^{n} \displaystyle \frac{2k-1}{2k}
&= \displaystyle \frac{\prod_{k=1}^{n} (2k-1)}{\prod_{k=1}^{n} (2k)} \\
&= \displaystyle \frac{\displaystyle \frac{(2n)!}{2^{n}\,n!}}{2^{n}\,n!} \\
&= \displaystyle \frac{(2n)!}{2^{2n}\,(n!)^{2}}
\end{aligned}
""",
      ),
      StepItem(
        tex: r"""\begin{aligned}
J_{n}
&= \displaystyle \frac{\pi}{2}\cdot \displaystyle \frac{(2n)!}{2^{2n}\,(n!)^{2}}
\end{aligned}
""",
      ),

      StepItem(tex: r"""\textbf{【補足】}"""),
      StepItem(tex: r"""\text{ベータ関数 }B(p,q)\text{ を用いると }J_{n}=\displaystyle \frac{1}{2}B\!\left(\displaystyle \frac{1}{2},\,n+\displaystyle \frac{1}{2}\right)\text{ とも書けるが、ここでは用いない。}"""),
    ],
  ),

  MathProblem(
    id: "FF359933-B62F-49DE-8469-0B676607D489",
    no: 3,
    category: '漸化式系の積分',
    level: '上級',
    question: r"""I_{n}=\displaystyle \int_{0}^{1}x^n\log  x\,dx
\quad
I_{n-1}\text{ で表せ}
""",
    answer: r""" 
I_{n} = -\displaystyle \frac{1}{(n+1)^2}
""",
    imageAsset: 'assets/graphs/basic_definite_integral_areas/problem_3.png',
    hint: r"""\text{部分積分で } \log x \text{ を微分し、冪関数 }x^n\text{ を積分する。端点 }x=0,1\text{ の極限を厳密に確認する。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{部分積分で } \log x \text{ を微分し、冪関数 }x^n\text{ を積分する。端点 }x=0,1\text{ の極限を厳密に確認する。}"""),

      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(
        tex: r"""\text{設定：}\ 
u=\log x,\ dv=x^n\,dx
\ \Rightarrow\
du=\displaystyle \frac{1}{x}\,dx,\ v=\displaystyle \frac{x^{n+1}}{n+1}.
\ \text{境界項 } \left[\displaystyle \frac{x^{n+1}}{n+1}\log x\right]_{0}^{1} \text{ は }0\text{ になる。}
""",
      ),

      StepItem(tex: r"""\textbf{【解説】（端点 }x\to 0^{+}\text{ の極限）}"""),
      StepItem(
        tex: r"""\begin{aligned}
\lim_{x\to 0^{+}} x^{n+1}\log x
&= \lim_{x\to 0^{+}} \displaystyle \frac{\log x}{x^{-(n+1)}} \\
&= \lim_{x\to 0^{+}} \displaystyle \frac{\displaystyle \frac{d}{dx}(\log x)}{\displaystyle \frac{d}{dx}\left(x^{-(n+1)}\right)} \\
&= \lim_{x\to 0^{+}} \displaystyle \frac{1/x}{-(n+1)\,x^{-(n+2)}} \\
&= \lim_{x\to 0^{+}} \left(-\displaystyle \frac{1}{n+1}\,x^{n+1}\right) \\
&= 0
\end{aligned}
""",
      ),

      StepItem(tex: r"""\textbf{【解説】（本計算）}"""),
      StepItem(
        tex: r"""\begin{aligned}
I_{n}
&= \displaystyle \int_{0}^{1} x^{n}\log x\,dx \\
&= \left[ \displaystyle \frac{x^{n+1}}{n+1}\,\log x \right]_{0}^{1}
   - \displaystyle \int_{0}^{1} \displaystyle \frac{x^{n+1}}{n+1}\cdot \displaystyle \frac{1}{x}\,dx \\
&= 0 - \displaystyle \frac{1}{n+1}\displaystyle \int_{0}^{1} x^{n}\,dx \\
&= -\displaystyle \frac{1}{n+1}\left[ \displaystyle \frac{x^{n+1}}{n+1} \right]_{0}^{1} \\
&= -\displaystyle \frac{1}{n+1}\left( \displaystyle \frac{1^{\,n+1}}{n+1} - \displaystyle \frac{0^{\,n+1}}{n+1} \right) \\
&= -\displaystyle \frac{1}{n+1}\cdot \displaystyle \frac{1}{n+1} \\
&= -\displaystyle \frac{1}{(n+1)^{2}}
\end{aligned}
""",
      ),

      StepItem(tex: r"""\textbf{【補足】}"""),
      StepItem(
        tex: r"""\text{閉じた形 }I_{n}=-\displaystyle \frac{1}{(n+1)^{2}}\text{ から }
\begin{aligned}
I_{n-1}
&= -\displaystyle \frac{1}{n^{2}},\\
I_{n}
&= \displaystyle \frac{n^{2}}{(n+1)^{2}}\,I_{n-1}
\end{aligned}
\text{ が従う。ベータ関数やパラメータ微分でも導けるが、ここでは用いない。}
""",
      ),
    ],
  ),
];