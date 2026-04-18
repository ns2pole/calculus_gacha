// advanced_limits.dart
// 上級極限問題集（10問）

import '../../models/math_problem.dart';
import '../../models/step_item.dart';

const advanced_limits = <MathProblem>[
MathProblem(
  id: "81279279-68BC-46E4-96E8-C6188AD7617D",
  no: 1,
  category: '因数分解／等比和',
  level: '中級',
  question: r"""\displaystyle \lim_{x\to 1}\frac{x^{5}-1}{x-1}""",
  answer: r"""\displaystyle 5""",
  imageAsset: 'assets/graphs/limit/problems_advanced_limits/problem_1.png',
  hint: r"""x^{5}-1=(x-1)\bigl(x^{4}+x^{3}+x^{2}+x+1\bigr)""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】 }"""),
    StepItem(tex: r"""x^{5}-1=(x-1)\bigl(x^{4}+x^{3}+x^{2}+x+1\bigr)"""),
    StepItem(tex: r"""と因数分解してから、x\to 1 の極限をとる。"""),
    StepItem(tex: r"""\begin{aligned}
    \frac{x^{5}-1}{x-1}
    =&x^{4}+x^{3}+x^{2}+x+1
    \end{aligned}"""),
    StepItem(tex: r"""\begin{aligned}
    \ \therefore\  & \lim_{x\to 1}\frac{x^{5}-1}{x-1} \\[6pt]
    =&\lim_{x\to 1} \left( x^{4}+x^{3}+x^{2}+x+1 \right)\\[6pt]
    =&1+1+1+1+1 \\[5pt]
    =&\displaystyle 5
    \end{aligned}"""),
  ],
),

// MathProblem(
//   id: "50932692-D037-4E74-8000-6FF211AB235B",
//   no: 2,
//   category: r"""\displaystyle \sum_{k=1}^{n}\frac{1}{k(k+1)}""",
//   level: '中級',
//   question: r"""\displaystyle \lim_{n\to\infty}\displaystyle \sum_{k=1}^{n}\frac{1}{k(k+1)}""",
//   answer: r"""\displaystyle 1""",
//   imageAsset: 'assets/graphs/limit/problems_advanced_limits/problem_2.png',
//   steps: [
//     StepItem(tex: r"""\textbf{【方針】}"""),
//     StepItem(tex: r"""部分分数分解で打ち消し合いを作る"""),
//     StepItem(tex: r"""\textbf{【解答】}"""),
//     StepItem(tex: r"""\begin{aligned}
//     \frac{1}{k(k+1)}
//     &= \frac{1}{k}-\frac{1}{k+1} \\[6pt]
//     \displaystyle \sum_{k=1}^{n}\frac{1}{k(k+1)}
//     &= 1-\frac{1}{n+1} \ \underset{n\to\infty}{\longrightarrow} \ 1
//     \end{aligned}"""),
//   ],
// ),

MathProblem(
  id: "E3253228-3C96-488F-BD6E-A89DC18E84CA",
  no: 3,
  category: r"""\displaystyle \sum_{k=1}^{n}\frac{1}{k(k+2)}""",
  level: '初級',
  question: r"""\displaystyle \lim_{n\to\infty}\displaystyle \sum_{k=1}^{n}\frac{1}{k(k+2)}""",
  answer: r"""\displaystyle \frac{3}{4}""",
  imageAsset: 'assets/graphs/limit/problems_advanced_limits/problem_3.png',
  hint: r""" \dfrac{1}{k(k+2)}=\dfrac{1}{2}\!\left(\dfrac{1}{k}-\dfrac{1}{k+2}\right)""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】 }"""),
    StepItem(tex: r""" \dfrac{1}{k(k+2)}=\dfrac{1}{2}\!\left(\dfrac{1}{k}-\dfrac{1}{k+2}\right)"""),
    StepItem(tex: r"""\begin{aligned}
    \displaystyle \sum_{k=1}^{n}\frac{1}{k(k+2)}
    &= \frac{1}{2}\displaystyle \sum_{k=1}^{n}\left(\frac{1}{k}-\frac{1}{k+2}\right) \\[6pt]
    &= \frac{1}{2}\left(1+\frac{1}{2}-\frac{1}{n+1}-\frac{1}{n+2}\right) \\[6pt]
    &\underset{n\to\infty}{\longrightarrow} \ \displaystyle\  \frac{3}{4}
    \end{aligned}"""),
  ],
),

MathProblem(
  id: "48677C5D-732B-4C47-B4AA-645616D8C392",
  no: 4,
  category: '比較（階乗と多項式）',
  level: '上級',
  question: r"""\displaystyle \lim_{n\to\infty}\frac{n!}{n^{n}}""",
  answer: r"""\displaystyle 0""",
  imageAsset: 'assets/graphs/limit/problems_advanced_limits/problem_4.png',
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""), 
    StepItem(tex: r"""\displaystyle \frac{n!}{n^n}=\prod_{k=1}^{n}\frac{k}{n} \text{ と書き、 } \displaystyle k \le \frac{n}{2} \text{ では } \displaystyle \frac{k}{n} \le \frac{1}{2} \text{ が成り立つ事を用いて、はさみうちにする。}"""),
    StepItem(tex: r"""\textbf{【解答】}"""),
    StepItem(tex: r"""\ \textbf{[1]}\ n\textbf{ が偶数のとき：}"""),
    StepItem(tex: r"""\begin{aligned}
  0 &\le \frac{n!}{n^n} = \prod_{k=1}^{n}\frac{k}{n} = \prod_{k=1}^{\frac n 2}\frac{k}{n} \cdot \prod_{k=\frac {n} {2} +1}^{n}\frac{k}{n} \\[6pt]
  &\le \left(\frac{1}{2}\right)^{\frac n 2} \cdot 1^{\frac n 2} =  \left(\frac{1}{2}\right)^{\frac n 2} 
  \end{aligned}
  """),
    StepItem(tex: r"""\displaystyle \lim_{n\to\infty} \left(\frac{1}{2}\right)^{n/2} = 0\text{ なので、はさみうちより、} \displaystyle \lim_{n\to\infty} \frac{n!}{n^{n}} = 0"""),
    StepItem(tex: r"""\ \textbf{[2]}\ n\textbf{ が奇数のとき：}"""),
    StepItem(tex: r"""\begin{aligned}
  0 &\le \frac{n!}{n^n} = \prod_{k=1}^{n}\frac{k}{n} = \prod_{k=1}^{\frac{n-1}{2}}\frac{k}{n} \cdot \prod_{k=\frac{n+1}{2}}^{n}\frac{k}{n} \\[6pt]
  & \le \left(\frac{1}{2}\right)^{\frac{n-1}{2}} \cdot 1^{\frac{n+1}{2}} =\left(\frac{1}{2}\right)^{\frac{n-1}{2}}
  \end{aligned}
  """),
    StepItem(tex: r"""\displaystyle \lim_{n\to\infty} \left(\frac{1}{2}\right)^{\frac{n-1}{2}} = 0\text{ なので、はさみうちより、} \displaystyle \lim_{n\to\infty} \frac{n!}{n^{n}} = 0"""),

    StepItem(tex: r"""\text{よって、}n\text{が偶数奇数の場合で合わせて、}\displaystyle \lim_{n\to\infty}\frac{n!}{n^{n}} = 0\text{が示された。}"""),
    StepItem(tex: r""""""),
    StepItem(tex: r"""\textbf{【補足：総乗記号】}
    """),
    StepItem(tex: r""" \displaystyle \prod_{k=m}^{n} a_k \ \ ( m\le n) \text{ は } a_m a_{m+1}\cdots a_n \text{ を表す。}"""),
    StepItem(tex: r"""\textbf{【補足：総乗記号の例】}"""),
    StepItem(tex: r"""
    \begin{aligned}
    \prod_{k=1}^{4} k = 1\cdot 2\cdot 3\cdot 4 = 24
    \end{aligned}"""),
    StepItem(tex: r"""
    \begin{aligned}
    \prod_{k=1}^{4}\frac{k}{4} &= \frac{1}{4}\cdot \frac{2}{4}\cdot \frac{3}{4}\cdot \frac{4}{4} = \frac{1\cdot 2\cdot 3\cdot 4}{4\cdot 4\cdot 4\cdot 4} \\[4pt]
    &= \frac{24}{256} = \frac{3}{32}
    \end{aligned}"""),
    ],
),

// MathProblem(
//   id: "3879103D-98A9-482B-8D13-681E004E29EC",
//   no: 5,
//   category: '比較（対数と一次）',
//   level: '初級',
//   question: r"""\displaystyle \lim_{n\to\infty}\frac{\log n}{n}""",
//   answer: r"""\displaystyle 0""",
//   imageAsset: 'assets/graphs/limit/problems_advanced_limits/problem_5.png',
//   steps: [
//     StepItem(tex: r"""\textbf{【方針】 }"""),
//     StepItem(tex: r""" \dfrac{1}{t}\le\dfrac{1}{\sqrt{t}}\ (t\ge 1)\ \Rightarrow\ \log n=\int_{1}^{n}\dfrac{dt}{t}\le \int_{1}^{n}\dfrac{dt}{\sqrt{t}}"""),
//     StepItem(tex: r"""\begin{aligned}
//     \frac{\log n}{n}
//     &\le \frac{2(\sqrt{n}-1)}{n} \\[6pt]
//     &= \frac{2}{\sqrt{n}}-\frac{2}{n} \\[6pt]
//     &\underset{n\to\infty}{\longrightarrow} 0
//     \end{aligned}"""),
//   ],
// ),

// MathProblem(
//   id: "C29BEC74-56F8-4F4E-A2BD-938061967CA8",
//   no: 6,
//   category: '単調収束（漸化式）',
//   level: '中級',
//   question: r"""a_{1}\in(0,1) ,\ \displaystyle a_{n+1}=\sqrt{a_{n}}.\quad \displaystyle \lim_{n\to\infty} a_{n}""",
//   answer: r"""\displaystyle 1""",
//   imageAsset: 'assets/graphs/limit/problems_advanced_limits/problem_6.png',
//   steps: [
//     StepItem(tex: r"""\textbf{【方針】 }"""),
//     StepItem(tex: r"""0<a_{n}<1 を保ちつつ単調増加・上に有界 \Rightarrow 収束，極限方程式 L=\sqrt{L} を解く"""),
//     StepItem(tex: r"""\begin{aligned}
//     0<a_{1}<1
//     &\Rightarrow 0<a_{2}=\sqrt{a_{1}}<1 \\[6pt]
//     \text{帰納より }0<a_{n}<1
//     &\ \text{かつ}\ a_{n+1}-a_{n}=\sqrt{a_{n}}-a_{n}>0 \\[6pt]
//     \Rightarrow\ \{a_{n}\}\ \text{は単調増加・上に有界}
//     &\Rightarrow \exists\,L=\underset{n\to\infty}{\longrightarrow} a_{n}\in(0,1] \\[6pt]
//     L=\sqrt{L}
//     &\Leftrightarrow L\in\{0,1\} \\[6pt]
//     \text{増加列で }L>0
//     &\Rightarrow L=1
//     \end{aligned}"""),
//   ],
// ),

// MathProblem(
//   id: "25103264-141F-4DF2-9DA3-DD2BF7A2272C",
//   no: 7,
//   category: '一次漸化式（等比化）',
//   level: '初級',
//   question: r"""a_{1}\in\mathbb{R},\ \displaystyle a_{n+1}=\frac{a_{n}+3}{4}.\quad \displaystyle \lim_{n\to\infty} a_{n}""",
//   answer: r"""\displaystyle 1""",
//   imageAsset: 'assets/graphs/limit/problems_advanced_limits/problem_6.png',
//   steps: [
//     StepItem(tex: r"""\textbf{【方針】 }"""),
//     StepItem(tex: r""" 平行移動 b_{n}=a_{n}-1 で等比数列化"""),
//     StepItem(tex: r"""\begin{aligned}
//     b_{n}
//     &= a_{n}-1 \\[6pt]
//     b_{n+1}
//     &= \frac{a_{n}+3}{4}-1 \\[6pt]
//     &= \frac{a_{n}-1}{4} \\[6pt]
//     &= \frac{b_{n}}{4} \\[6pt]
//     \Rightarrow\ b_{n}
//     &= b_{1}\left(\frac{1}{4}\right)^{n-1} \\[6pt]
//     &\underset{n\to\infty}{\longrightarrow} b_{n} = 0 \\[6pt]
//     \Rightarrow\ &\underset{n\to\infty}{\longrightarrow} a_{n} = 1
//     \end{aligned}"""),
//   ],
// ),

  MathProblem(
    id: "BCC5BF01-27BE-4D8C-8E40-8923C764BBEC",
    no: 8,
    category: '不定形の解消',
    level: '初級',
    question: r"""\displaystyle \lim_{n\to\infty} n\!\left(\sqrt{n+1}-\sqrt{n}\right)""",
    answer: r"""\displaystyle \infty""",
    imageAsset: 'assets/graphs/limit/problems_advanced_limits/problem_8.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{共役な数} \sqrt{n+1}+\sqrt{n} \text{を分母分子に掛けて不定形を解消する。}"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\begin{aligned}
      n\!\left(\sqrt{n+1}-\sqrt{n}\right)
      &= n\cdot \frac{\sqrt{n+1}-\sqrt{n}}{1} \\[6pt]
      &= n\cdot \frac{(\sqrt{n+1}-\sqrt{n})(\sqrt{n+1}+\sqrt{n})}{(\sqrt{n+1}+\sqrt{n})} \\[6pt]
      &= n\cdot \frac{(\sqrt{n+1})^2-(\sqrt{n})^2}{\sqrt{n+1}+\sqrt{n}} \\[6pt]
      &= n\cdot \frac{(n+1)-n}{\sqrt{n+1}+\sqrt{n}} \\[6pt]
      &= n\cdot \frac{1}{\sqrt{n+1}+\sqrt{n}} \\[6pt]
      &= \frac{n}{\sqrt{n+1}+\sqrt{n}} \\[6pt]
      &= \frac{\sqrt{n}}{\sqrt{1+\frac{1}{n}}+1} \\[6pt]
      &  \underset{n\to\infty}{\longrightarrow}\  \infty
      \end{aligned}"""),
    ],
  ),

  MathProblem(
    id: "1ECE1CDE-BFDC-4524-B8B5-6501A91BD8BE",
    no: 9,
    category: '比較（指数と多項式）',
    level: '上級',
  question: r"""\displaystyle \lim_{n\to\infty}\frac{n^{2}}{2^{n}}""",
  answer: r"""\displaystyle 0""",
  imageAsset: 'assets/graphs/limit/problems_advanced_limits/problem_9.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{比の評価により、}\displaystyle \lim_{n \to \infty} \frac {a_{n+1}} {a_n} = \frac 1 2 \text{を示す。この事実から、} N < n \text{ならば、} \displaystyle a_{n+1} \leq \frac{3}{4}a_n  \text{となるような}N \text{を導けることが予測できるので、これを使ってはさみうちを行う。（ここでは} \displaystyle \frac  3 4 \text{という値を用いたが、}1\text{未満で取ってこれればとくに何でも良い。）}"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: '', imageAsset: 'assets/graphs/limit/problems_advanced_limits/problem_21_ratio.png'),
      StepItem(tex: '', imageAsset: 'assets/graphs/limit/problems_advanced_limits/problem_21_squeeze.png'),
      StepItem(tex: r"""\displaystyle a_n = \frac{n^2}{2^n} \text{に対して、}"""),
      StepItem(tex: r"""\begin{aligned}
      \frac{a_{n+1}}{a_n} &= \frac{\frac{(n+1)^2}{2^{n+1}}}{\frac{n^2}{2^n}} \\[6pt]
      &= \displaystyle \frac{1}{2}\frac{(n+1)^2}{n^2} \\[6pt]
      &= \frac{1}{2}\left(1+\frac{1}{n}\right)^2 \\[6pt]
      &= \frac{1}{2} + \frac{1}{n} + \frac{1}{2n^2} \\[6pt]
      &\underset{n \to \infty}{\longrightarrow}\  \frac{1}{2} \quad \text{(単調減少で収束)}
      \end{aligned}"""),
      StepItem(tex: r"""\text{よって数列}a_n \text{は} n\text{が十分大きければ、1つ番号が進む度におよそ} \displaystyle \frac 1 2 \text{倍されていきどんどん小さくなっていくことが分かる。}"""),
      StepItem(tex: r"""\text{具体的に}N <n\text{ならば常に、} \displaystyle \frac{a_{n+1}}{a_n} \leq \frac{3}{4} \text{を満たすような} N \text{ を求める。}"""),
      StepItem(tex: r"""\begin{aligned}
      & \frac{1}{2} + \frac{1}{n} + \frac{1}{2n^2} \leq \frac{3}{4} \\[6pt]
      \Longleftrightarrow \ & \  n^2 - 4n - 2 \geq 0 \\[6pt]
      \Longleftrightarrow \ & \  n \geq 2 + \sqrt{6} \; (\fallingdotseq 4.45)
      \end{aligned}"""),
      StepItem(tex: r"""\text{したがって整数 } n \geq 5 \text{ で常に、}"""),
      StepItem(tex: r"""\begin{aligned}
      &\displaystyle \frac{a_{n+1}}{a_n} \leq \frac{3}{4} \Longleftrightarrow \boxed{a_{n+1} \leq \frac{3}{4}a_n}
      \end{aligned}"""),
      StepItem(tex: r"""\text{よって}"""),
      StepItem(tex: r"""\displaystyle 0 \leq a_n \leq \frac{3}{4} a_{n-1}  \leq \cdots \leq a_5\left(\frac{3}{4}\right)^{n-5} \ \  (n > 5)"""),
      StepItem(tex: r"""\text{また、}\displaystyle a_5  =\frac {5^2}{2^5}= \frac{25}{32}\text{である。}"""),
      StepItem(tex: r"""\displaystyle \lim_{n\to\infty} a_5 \left(\frac{3}{4}\right)^{n-5} = 0 \text{なので、はさみうちより、} \lim_{n\to\infty} a_n =\lim_{n\to\infty}\displaystyle \frac{n^2}{2^n} = 0"""),
    ],
  ),

  MathProblem(
    id: "F8A9B2C3-D4E5-6F7A-8B9C-0D1E2F3A4B5C",
    no: 10,
    category: '比較（対数と一次）',
    level: '中級',
    question: r"""\displaystyle \lim_{x\to\infty}\frac{\log x}{x}""",
    answer: r"""\displaystyle 0""",
    imageAsset: 'assets/graphs/limit/problems_advanced_limits/problem_10.png',
    hint: r"""\text{√x と log x の大小関係を用いる}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{√x と log x の大小関係を用いて評価する。}"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\text{補足で示すように、} x > 1 \text{ で }  \log x < \sqrt{x} \text{ が成り立つ。}"""),
      StepItem(tex: r"""\text{よって、} x > 1 \text{ で十分大きい } x \text{ に対して、}"""),
      StepItem(tex: r"""\begin{aligned}
      0 < \frac{\log x}{x} &< \frac{\sqrt{x}}{x} = \frac{1}{\sqrt{x}}
      \end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} \displaystyle \lim_{x\to\infty} \frac{1}{\sqrt{x}} = 0 \text{ なので、はさみうちの原理より、}"""),
      StepItem(tex: r"""\begin{aligned}
      \lim_{x\to\infty}\frac{\log x}{x} = 0
      \end{aligned}"""),
      StepItem(tex: r"""\textbf{【補足：log x < √x の証明】}"""),
      StepItem(tex: r"""\text{関数 } f(x) = \sqrt{x} - \log x \ (x > 0) \text{ を考える。}"""),
      StepItem(tex: '', imageAsset: 'assets/graphs/limit/problems_advanced_limits/problem_10_supplement.png'),
      StepItem(tex: r"""\begin{aligned}
      f'(x) &= \frac{1}{2\sqrt{x}} - \frac{1}{x} \\[6pt]
      &= \frac{\sqrt{x} - 2}{2x}
      \end{aligned}"""),
      StepItem(tex: r"""\text{よって、} f'(x) = 0 \text{ となるのは } x = 4 \text{ のときである。}"""),
      StepItem(tex: r"""\text{増減表より、} x = 4 \text{ で } f(x) \text{ は最小値をとり、}"""),
      StepItem(tex: r"""\begin{aligned}
      f(4) &= \sqrt{4} - \log 4 \\[6pt]
      &= 2 - 2\log 2 \\[6pt]
      &> 2 - 2 \cdot 0.7 = 0.6 > 0
      \end{aligned}"""),
      StepItem(tex: r"""\text{したがって、} x > 0 \text{ で } f(x) > 0 \text{、すなわち } \log x < \sqrt{x} \text{ が成り立つ。}"""),
    ],
  ),
];
