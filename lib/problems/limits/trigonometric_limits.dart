// trigonometric_limits.dart
// 三角関数極限問題集（5問）


import '../../models/math_problem.dart';
import '../../models/step_item.dart';

const trigonometric_limits = <MathProblem>[
  MathProblem(
    id: "2D7ED2C9-2759-46FC-B597-619EB2FA6A3B",
    no: 1,
    category: '三角の基本極限',
    level: '初級',
    question: r"""\displaystyle \lim_{x\to 0}\frac{1-\cos x}{x^{2}}""",
    answer: r"""\displaystyle \frac{1}{2}""",
    imageAsset: 'assets/graphs/limit/problems_trigonometric_limits/problem_1.png',
    hint: r"""\displaystyle 1-\cos x=2\sin^{2}\!\left(\frac{x}{2}\right)\text{ を用いる}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\displaystyle 1-\cos x=2\sin^{2}\!\left(\frac{x}{2}\right)\text{ を用いる}"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\begin{aligned}
      \displaystyle & \lim_{x\to 0}\frac{1-\cos x}{x^{2}} \\[6pt]
      \displaystyle =& \lim_{x\to 0}\frac{2\sin^{2}\!\left(\frac{x}{2}\right)}{x^{2}} \\[6pt]
      \displaystyle =& \lim_{x\to 0}\frac{2\sin^{2}\!\left(\frac{x}{2}\right)}{4\cdot \left(\frac x 2 \right)^{2}} \\[6pt]
      =&\displaystyle \lim_{x\to 0} \frac 1 2 \left(\frac{\sin(\frac{x}{2})}{\frac{x}{2}}\right)^{2} \\[6pt]
      =&\displaystyle \frac{1}{2} \cdot 1^2 \\[6pt]
      =&\displaystyle \frac{1}{2}
      \end{aligned}"""),
    ],
  ),


  MathProblem(
    id: "A8B9C0D1-E2F3-4A5B-6C7D-8E9F0A1B2C3D",
    no: 2,
    category: '平行移動による変数変換',
    level: '中級',
    question: r"""\displaystyle \lim_{x\to\frac{\pi}{2}}\cos(3x)\tan(5x)""",
    answer: r"""\displaystyle -\frac{3}{5}""",
    imageAsset: 'assets/graphs/limit/problems_trigonometric_limits/problem_3.png',
    hint: r"""\text{平行移動の考え方で } t = x - \displaystyle\frac{\pi}{2} \text{ と置き、} t \to 0 \text{ として扱う}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{極限点 } x = \displaystyle\frac{\pi}{2} \text{ を原点に平行移動する。すなわち、} t = x - \displaystyle\frac{\pi}{2} \text{ と置換することで、} x \to \displaystyle\frac{\pi}{2} \text{ を } t \to 0 \text{ に変換する。}"""),
      StepItem(tex: r"""\text{この置換により、既知の極限公式 } \displaystyle \lim_{t\to 0}\frac{\sin t}{t} = 1 \text{ を直接適用できるようになる。}"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\text{変数変換 } t = x - \displaystyle\frac{\pi}{2} \text{ を行う。このとき、} x = t + \displaystyle\frac{\pi}{2} \text{ であり、} x \to \displaystyle\frac{\pi}{2} \text{ のとき } t \to 0 \text{ である。}"""),
      StepItem(tex: r"""\text{まず、} \cos(3x) \text{ を変換する：}"""),
      StepItem(tex: r"""\begin{aligned}
      \cos(3x) &= \cos\!\left(3\left(t + \displaystyle\frac{\pi}{2}\right)\right) \\[6pt]
      &= \cos\!\left(3t + \displaystyle\frac{3\pi}{2}\right) \\[6pt]
      &= \cos\!\left(3t + \pi + \displaystyle\frac{\pi}{2}\right) \\[6pt]
      &= -\cos\!\left(3t + \displaystyle\frac{\pi}{2}\right) \\[6pt]
      &= \sin(3t)
      \end{aligned}"""),
      StepItem(tex: r"""\text{次に、} \tan(5x) \text{ を変換する：}"""),
      StepItem(tex: r"""\begin{aligned}
      \tan(5x) &= \tan\!\left(5\left(t + \displaystyle\frac{\pi}{2}\right)\right) \\[6pt]
      &= \tan\!\left(5t + \displaystyle\frac{5}{2}\pi\right) \\[6pt]
      &= \tan\!\left(5t + 2\pi + \displaystyle\frac{\pi}{2}\right) \\[6pt]
      &= \tan\!\left(5t + \displaystyle\frac{\pi}{2}\right) \\[6pt]
      &= -\frac{\cos(5t)}{\sin(5t)}
      \end{aligned}"""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
      \cos(3x)\tan(5x) &= \sin(3t) \cdot \left(-\frac{\cos(5t)}{\sin(5t)}\right) \\[6pt]
      &= -\frac{\sin(3t)\cos(5t)}{\sin(5t)}
      \end{aligned}"""),
      StepItem(tex: r"""\text{よって、極限は } t \to 0 \text{ として、}"""),
      StepItem(tex: r"""\begin{aligned}
      \lim_{x\to\frac{\pi}{2}}\cos(3x)\tan(5x) &= \lim_{t\to 0}\left(-\frac{\sin(3t)\cos(5t)}{\sin(5t)}\right) \\[6pt]
      &= -\lim_{t\to 0}\frac{\sin(3t)}{\sin(5t)} \cdot \lim_{t\to 0}\cos(5t) \\[6pt]
      &= -\lim_{t\to 0}\frac{\sin(3t)}{3t} \cdot \frac{5t}{\sin(5t)} \cdot \frac{3t}{5t} \cdot 1 \\[6pt]
      &= -\frac{3}{5} \cdot \lim_{t\to 0}\frac{\sin(3t)}{3t} \cdot \lim_{t\to 0}\frac{5t}{\sin(5t)} \\[6pt]
      &= -\frac{3}{5} \cdot 1 \cdot 1 \\[6pt]
      &= -\frac{3}{5}
      \end{aligned}"""),
    ],
  ),

MathProblem(
  id: "9A2E7C44-1B3A-4D7B-9E7F-2E3C1F6B8C10",
  no: 3,
  category: '三角関数×等比型級数',
  level: '中級',
  question: r"""\displaystyle \sum_{k=1}^{\infty}\frac{1}{2^{k}}\sin\!\left(\frac{2k\pi}{3}\right)""",
  answer: r"""\displaystyle \frac{\sqrt{3}}{7}""",
  imageAsset: 'assets/graphs/limit/problems_trigonometric_series_limits/problem_3.png',
  hint: r"""\sin\!\left(\frac{2k\pi}{3}\right)\text{ は周期 }3\text{（}\frac{\sqrt3}{2},-\frac{\sqrt3}{2},0\text{）なので }S_{3M},S_{3M+1},S_{3M+2}\text{ を比較する}""",
  steps: [

    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{部分和 }\displaystyle S_N=\displaystyle \sum_{k=1}^{N}\frac{1}{2^{k}}\sin\!\left(\frac{2k\pi}{3}\right)\text{ を考え、}
N=3M,3M+1,3M+2\text{ の3通りで同じ極限に収束することを示す。}"""),

    StepItem(tex: r"""\textbf{【解答】}"""),
    StepItem(tex: r"""\sin\!\left(\frac{2k\pi}{3}\right)=
\begin{cases}
\frac{\sqrt3}{2} & (k\equiv 1\!\!\!\pmod 3)\\[6pt]
-\frac{\sqrt3}{2} & (k\equiv 2\!\!\!\pmod 3)\\[6pt]
0 & (k\equiv 0\!\!\!\pmod 3)
\end{cases}"""),

StepItem(tex: r"""\textcolor{green}{まず } \textcolor{green}{N=3M} \textcolor{green}{ のとき}"""),
    StepItem(tex: r"""\begin{aligned}
S_{3M}
&=\displaystyle \sum_{m=0}^{M-1}\left(
\frac{1}{2^{3m+1}}\sin\!\left(\frac{2(3m+1)\pi}{3}\right)
+\frac{1}{2^{3m+2}}\sin\!\left(\frac{2(3m+2)\pi}{3}\right)
+\frac{1}{2^{3m+3}}\sin\!\left(\frac{2(3m+3)\pi}{3}\right)
\right)\\
&=\displaystyle \sum_{m=0}^{M-1}\left(
\frac{1}{2^{3m+1}}\cdot\frac{\sqrt3}{2}
+\frac{1}{2^{3m+2}}\cdot\left(-\frac{\sqrt3}{2}\right)
+\frac{1}{2^{3m+3}}\cdot 0
\right)\\
&=\frac{\sqrt3}{2}\displaystyle \sum_{m=0}^{M-1}\left(\frac{1}{2^{3m+1}}-\frac{1}{2^{3m+2}}\right)
\end{aligned}"""),

    StepItem(tex: r"""\text{ここで } \displaystyle \frac{1}{2^{3m+1}}-\frac{1}{2^{3m+2}}=\frac{1}{2^{3m+2}}\text{ なので}"""),
    StepItem(tex: r"""\begin{aligned}
S_{3M}
&=\frac{\sqrt3}{2}\displaystyle \sum_{m=0}^{M-1}\frac{1}{2^{3m+2}}
=\frac{\sqrt3}{2}\cdot\frac{1}{4}\displaystyle \sum_{m=0}^{M-1}\left(\frac{1}{8}\right)^m
\end{aligned}"""),

    StepItem(tex: r"""\text{等比数列の和より}"""),
    StepItem(tex: r"""\begin{aligned}
S_{3M}&=\frac{\sqrt3}{8}\cdot\frac{1-(\frac18)^M}{1-\frac18}\\[5pt]
&=\frac{\sqrt3}{8}\cdot\frac{1-(\frac18)^M}{\frac78}\\[5pt]
&=\frac{\sqrt3}{7}\left(1-\left(\frac18\right)^M\right)
\end{aligned}"""),

    StepItem(tex: r"""\text{したがって } \displaystyle \lim_{M\to\infty}S_{3M}=\frac{\sqrt3}{7}"""),

StepItem(tex: r"""\textcolor{green}{次に } \textcolor{green}{N=3M+1} \textcolor{green}{ のとき}"""),
StepItem(tex: r"""\begin{aligned}
S_{3M+1}
&=S_{3M}+\frac{1}{2^{3M+1}}\sin\!\left(\frac{2(3M+1)\pi}{3}\right)\\[5pt]
&=S_{3M}+\frac{1}{2^{3M+1}}\cdot\frac{\sqrt3}{2}\\[5pt]
&= S_{3M}+\frac{\sqrt3}{2^{3M+2}}
\end{aligned}"""),
StepItem(tex: r"""\text{よって }
\begin{aligned}
\displaystyle \lim_{M\to\infty}S_{3M+1}
&=\lim_{M\to\infty}\left(S_{3M}+\frac{\sqrt3}{2^{3M+2}}\right)\\[5pt]
&=\displaystyle \frac{\sqrt3}{7}
\end{aligned}"""),

StepItem(tex: r"""\textcolor{green}{同様に } \textcolor{green}{N=3M+2} \textcolor{green}{ のとき}"""),
StepItem(tex: r"""\begin{aligned}
S_{3M+2}
&=S_{3M+1}+\frac{1}{2^{3M+2}}\sin\!\left(\frac{2(3M+2)\pi}{3}\right)\\
&=S_{3M+1}+\frac{1}{2^{3M+2}}\cdot\left(-\frac{\sqrt3}{2}\right)\\
&=S_{3M+1}-\frac{\sqrt3}{2^{3M+3}}
\end{aligned}"""),
StepItem(tex: r"""\text{したがって } 
\begin{aligned}
\displaystyle \lim_{M\to\infty}S_{3M+2}&=\lim_{M\to\infty}\left(S_{3M+1}-\frac{\sqrt3}{2^{3M+3}}
\right)\\[5pt]
&=\displaystyle \frac{\sqrt3}{7}
\end{aligned}"""),
StepItem(tex: r"""\text{以上より }S_{3M},S_{3M+1},S_{3M+2}\text{ はいずれも }\displaystyle \frac{\sqrt3}{7}\text{ に収束する。}"""),
StepItem(tex: r"""\boxed{\displaystyle \sum_{k=1}^{\infty}\frac{1}{2^{k}}\sin\!\left(\frac{2k\pi}{3}\right)=\frac{\sqrt3}{7}}"""),

  ],
),


MathProblem(
  id: "3B2F6F76-9E2E-4C3A-A0C7-6E3C6E8B9B21",
  no: 4,
  category: 'sin^n の積分極限',
  level: '上級',
  question: r"""\displaystyle \lim_{n\to\infty}\sqrt{n}\,\int_{0}^{\frac{\pi}{2}}\sin^n x\,dx""",
  answer: r"""\displaystyle \sqrt{\frac{\pi}{2}}""",
  imageAsset: 'assets/graphs/limit/problems_sine_power_integral_limits/problem_1.png',
  hint: r"""\text{漸化式を立て、不変量 }(n+1)I_{n+1}I_n=\frac{\pi}{2}\text{ を作ってはさみうち}""",
  steps: [

    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{(1) }I_n=\int_0^{\frac{\pi}{2}}\sin^n x\,dx\text{ とおき、部分積分で漸化式を作る。}"""),
    StepItem(tex: r"""\text{(2) その漸化式から不変量 }(n+1)I_{n+1}I_n=\frac{\pi}{2}\text{ を得る。}"""),
    StepItem(tex: r"""\text{(3) 単調性 }I_{n+1}\le I_n\text{ を使って }\sqrt{n}\,I_n\text{ をはさみうちする。}"""),

    StepItem(tex: r"""\textbf{【解答】}"""),
    StepItem(tex: r"""\text{まず }I_n=\displaystyle\int_0^{\frac{\pi}{2}}\sin^n x\,dx\text{ とおく。}"""),

    // 漸化式
    StepItem(tex: r"""\text{部分積分（}\sin x\,dx=-(\cos x)'\,dx\text{）より}"""),
    StepItem(tex: r"""\begin{aligned}
I_n
&=\int_0^{\frac{\pi}{2}}\sin^{\,n-1}x\,\sin x\,dx
=-\int_0^{\frac{\pi}{2}}\sin^{\,n-1}x\,(\cos x)'\,dx\\
&=\Bigl[-\sin^{\,n-1}x\cos x\Bigr]_0^{\frac{\pi}{2}}
+(n-1)\int_0^{\frac{\pi}{2}}\sin^{\,n-2}x\,\cos^2x\,dx\\
&=(n-1)\int_0^{\frac{\pi}{2}}\sin^{\,n-2}x\,(1-\sin^2x)\,dx\\
&=(n-1)(I_{n-2}-I_n).
\end{aligned}"""),
    StepItem(tex: r"""\text{よって } \boxed{\,I_n=\frac{n-1}{n}I_{n-2}\,}\qquad(n\ge2)"""),

    // 不変量（ここを補完して「(n+1)I_{n+1}I_n=pi/2」まで確実に導く）
    StepItem(tex: r"""\textbf{【不変量の構成】}"""),
    StepItem(tex: r"""\text{上の漸化式の両辺に }nI_{n-1}\text{ を掛けると}"""),
        StepItem(tex: r"""\begin{aligned}
nI_nI_{n-1}=(n-1)I_{n-1}I_{n-2}
\end{aligned}"""),

    StepItem(tex: r"""\text{すなわち } \boxed{\,nI_nI_{n-1}=(n-1)I_{n-1}I_{n-2}\,}\ (n\ge2)\text{ より}"""),
    StepItem(tex: r"""\text{量 }A_n:=nI_nI_{n-1}\text{ は }A_n=A_{n-1}\text{ を満たす（}n\ge2\text{）。}"""),
    StepItem(tex: r"""\text{よって }A_n\text{ は }n\text{ によらず一定である。}"""),

    StepItem(tex: r"""\text{この定数を求めるため、}I_0,I_1\text{ を計算する。}"""),
    StepItem(tex: r"""\begin{aligned}
I_0&=\int_0^{\frac{\pi}{2}}1\,dx=\frac{\pi}{2},\\
I_1&=\int_0^{\frac{\pi}{2}}\sin x\,dx=\Bigl[-\cos x\Bigr]_0^{\frac{\pi}{2}}=1.
\end{aligned}"""),
    StepItem(tex: r"""\text{したがって }A_1=1\cdot I_1I_0=\displaystyle \frac{\pi}{2}\text{ であり、}"""),
    StepItem(tex: r"""\boxed{\,nI_nI_{n-1}=\frac{\pi}{2}\,}\qquad(n\ge1)"""),
    StepItem(tex: r"""\text{特に }n\to n+1\text{ として } \boxed{\, (n+1)I_{n+1}I_n=\frac{\pi}{2}\,}\qquad(n\ge0)"""),

    StepItem(tex: r"""\textbf{【はさみうち】}"""),
    StepItem(tex: r"""\text{区間 }[0,\frac{\pi}{2}]\text{ では }0\le \sin x\le1\text{ より } \sin^{n+1}x\le \sin^n x\text{。よって } \boxed{\,I_{n+1}\le I_n\,}\ (n\ge0)\text{、すなわち }I_n\text{ は単調減少。この事と、不変量 }\displaystyle nI_nI_{n-1}=\frac{\pi}{2}\text{ より}"""),
    StepItem(tex: r"""\begin{aligned}
\frac{\pi}{2}=nI_nI_{n-1}\ge nI_n^2
\end{aligned}"""),
    StepItem(tex: r"""\text{ゆえに } \boxed{\,\sqrt{n}\,I_n\le \sqrt{\frac{\pi}{2}}\quad(n\ge 0)\,} \cdots(1)"""),

    StepItem(tex: r"""\text{次に }I_{n+1}\le I_n\text{ と不変量 }\displaystyle (n+1)I_{n+1}I_n=\frac{\pi}{2}\text{ より}"""),
    StepItem(tex: r"""\begin{aligned}
\frac{\pi}{2}=(n+1)I_{n+1}I_n\le (n+1)I_n^2
\end{aligned}"""),
    StepItem(tex: r"""\text{ゆえに }"""),
    StepItem(tex: r"""\begin{aligned}
    & \sqrt{\frac{\pi}{2}}\le \sqrt{n+1}\,I_n \\[5pt]
    \Rightarrow & \boxed{\frac{\sqrt{n}}{\sqrt{n+1}} \sqrt{\frac{\pi}{2}}\le \,\sqrt{n}I_n \quad(n\ge 0)}\cdots(2)
  \end{aligned}"""),


    StepItem(tex: r"""\text{以上、(1),(2)より}"""),
    StepItem(tex: r"""\begin{aligned}
\sqrt{\frac{\pi}{2}}\cdot\sqrt{\frac{n}{n+1}}
\le \sqrt{n}\,I_n 
\le \sqrt{\frac{\pi}{2}}
\end{aligned}"""),
    StepItem(tex: r"""\text{ここで }\displaystyle \lim_{n\to\infty}\sqrt{\frac{n}{n+1}}=1\text{ だから、はさみうちより}"""),
    StepItem(tex: r"""\displaystyle \lim_{n\to\infty}\sqrt{n}\,I_n=\sqrt{\frac{\pi}{2}} \text{すなわち、}"""),
    StepItem(tex: r"""\displaystyle \lim_{n\to\infty}\sqrt{n}\,\int_{0}^{\frac{\pi}{2}}\sin^n x\,dx=\sqrt{\frac{\pi}{2}}"""),
  ])

// nI_nI_{n-1}=(n-1)I_{n-2}I_{n-1}.
// \end{aligned}"""),
//     StepItem(tex: r"""\text{同様に、漸化式の }n\to n-1\text{ を用いると }I_{n-1}=\frac{n-2}{n-1}I_{n-3}\text{ だから}"""),
//     StepItem(tex: r"""\begin{aligned}
// (n-1)I_{n-1}=(n-2)I_{n-3}.
// \end{aligned}"""),
//     StepItem(tex: r"""\text{これを代入して}"""),
//     StepItem(tex: r"""\begin{aligned}
// nI_nI_{n-1}=(n-2)I_{n-2}I_{n-3}.
// \end{aligned}"""),
//     StepItem(tex: r"""\text{したがって }J_n:=nI_nI_{n-1}\text{ とおけば } \boxed{\,J_n=J_{n-2}\,}\text{（1つおきに不変）}"""),
//     StepItem(tex: r"""\text{初期値 }I_1=\int_0^{\frac{\pi}{2}}\sin x\,dx=1,\quad
// I_2=\int_0^{\frac{\pi}{2}}\sin^2x\,dx=\frac{\pi}{4}\text{ より}"""),
//     StepItem(tex: r"""\begin{aligned}
// J_2=2I_2I_1=2\cdot\frac{\pi}{4}\cdot1=\frac{\pi}{2}.
// \end{aligned}"""),
//     StepItem(tex: r"""\text{ゆえに偶数・奇数どちらでも }J_n\equiv \frac{\pi}{2}\text{ が成り立つ。特に}"""),
//     StepItem(tex: r"""\boxed{\, (n+1)I_{n+1}I_n=\frac{\pi}{2}\,}\qquad(n\ge1)"""),

//     // 単調性
//     StepItem(tex: r"""\textbf{【単調性】}"""),
//     StepItem(tex: r"""\text{区間 }[0,\frac{\pi}{2}]\text{ で }0\le \sin x\le1\text{ より }\sin^{n+1}x\le \sin^{n}x\text{。}"""),
//     StepItem(tex: r"""\text{両辺を積分して } \boxed{\,I_{n+1}\le I_n\,}. """),

//     // 下から（あなたの指定：両辺に sqrt(n)/sqrt(n+1)）
//     StepItem(tex: r"""\textbf{【下からの評価】}"""),
//     StepItem(tex: r"""\text{不変量 }(n+1)I_{n+1}I_n=\frac{\pi}{2}\text{ と }I_{n+1}\le I_n\text{ より}"""),
//     StepItem(tex: r"""\begin{aligned}
// \frac{\pi}{2}=(n+1)I_{n+1}I_n \le (n+1)I_n^2.
// \end{aligned}"""),
//     StepItem(tex: r"""\text{よって } \boxed{\,\sqrt{n+1}\,I_n\ge \sqrt{\frac{\pi}{2}}\,}. """),
//     StepItem(tex: r"""\text{両辺に }\displaystyle \frac{\sqrt n}{\sqrt{n+1}}\text{ を掛けて}"""),
//     StepItem(tex: r"""\boxed{\,\sqrt n\,I_n\ge \sqrt{\frac{n}{n+1}}\sqrt{\frac{\pi}{2}}\,}. """),

//     // 上から
//     StepItem(tex: r"""\textbf{【上からの評価】}"""),
//     StepItem(tex: r"""\text{不変量 }nI_nI_{n-1}=\frac{\pi}{2}\text{ と }I_{n-1}\ge I_n\text{ より}"""),
//     StepItem(tex: r"""\begin{aligned}
// \frac{\pi}{2}=nI_nI_{n-1}\ge nI_n^2.
// \end{aligned}"""),
//     StepItem(tex: r"""\text{したがって } \boxed{\,\sqrt n\,I_n\le \sqrt{\frac{\pi}{2}}\,}. """),

//     // はさみうち
//     StepItem(tex: r"""\textbf{【はさみうち】}"""),
//     StepItem(tex: r"""\[
// \sqrt{\frac{n}{n+1}}\sqrt{\frac{\pi}{2}}
// \le \sqrt n\,I_n
// \le \sqrt{\frac{\pi}{2}}.
// \]"""),
//     StepItem(tex: r"""\text{ここで }\displaystyle \sqrt{\frac{n}{n+1}}\to1\ (n\to\infty)\text{ なので}"""),
//     StepItem(tex: r"""\boxed{\displaystyle \lim_{n\to\infty}\sqrt n\,I_n=\sqrt{\frac{\pi}{2}}}. """),
//   ],
// ),


];
