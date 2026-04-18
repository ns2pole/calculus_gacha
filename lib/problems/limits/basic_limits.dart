// basic_limits.dart
// 基本極限問題集（13問）

import '../../models/math_problem.dart';
import '../../models/step_item.dart';

const basic_limits = <MathProblem>[
  MathProblem(
    id: "701CF34C-DB84-4CD4-BD3B-0DDE311D6A0F",
    no: 1,
    category: '基本極限',
    level: '初級',
    question: r"""\displaystyle \lim_{x\to 0}\frac{\sin(3x)}{x}""",
    answer: r"""\displaystyle 3""",
    imageAsset: 'assets/graphs/limit/problems_basic_limits/problem_1.png',
    hint: r"""$\displaystyle \lim_{x\to 0}\frac{\sin x}{x}=1$ \text{ を使う}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""$\displaystyle \lim_{x\to 0}\frac{\sin x}{x}=1$ \text{ を使う}"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\begin{aligned}
      \lim_{x\to 0}\frac{\sin(3x)}{x}&=\displaystyle \lim_{x\to 0}3\cdot \frac{\sin(3x)}{3x} \\[6pt]
      &= \displaystyle 3
      \end{aligned}"""),
    ],
  ),

  MathProblem(
    id: "E5CDA38B-2CD3-4F62-AB20-2F4ECDB14681",
    no: 2,
    category: '基本極限',
    level: '初級',
    question: r"""\displaystyle \lim_{x\to 0}\frac{\tan x}{x}""",
    answer: r"""\displaystyle 1""",
    imageAsset: 'assets/graphs/limit/problems_basic_limits/problem_2.png',
    steps: [
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\begin{aligned}
      \lim_{x\to 0}\frac{\tan x}{x}&=\displaystyle \lim_{x\to 0}\frac{\sin x}{x}\cdot \frac{1}{\cos x} \\[6pt]
      &= \displaystyle 1\cdot 1 \\[6pt]
      &= \displaystyle 1
      \end{aligned}"""),
    ],
  ),

    MathProblem(
    id: "B2198AC3-050B-4F1D-B584-A2C5DC3CA60F",
    no: 3,
    category: '基本極限',
    level: '初級',
    question: r"""\displaystyle \lim_{x\to \infty} x \sin\!\left(\frac{1}{x}\right) """,
    answer: r"""\displaystyle 1""",
    imageAsset: 'assets/graphs/limit/problems_basic_limits/problem_3.png',
    steps: [
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\begin{aligned}
      \lim_{x\to \infty} x \sin\!\left(\frac{1}{x}\right) &= \lim_{x\to \infty} \frac{\sin\!\left(\frac{1}{x}\right)}{\frac{1}{x}} \\[6pt]
      &= \displaystyle 1
      \end{aligned}"""),
    ],
  ),


  // MathProblem(
  //   id: "52454E1F-0119-4440-981F-4A61FDC321CC",
  //   no: 3,
  //   category: '基本極限',
  //   level: '初級',
  //   question: r"""\displaystyle \lim_{x\to 0}\frac{\sin(ax)}{\sin(bx)}""",
  //   answer: r"""\displaystyle \frac{a}{b}""",
  //   imageAsset: 'assets/graphs/limit/problems_basic_limits/problem_3.png',
  //   steps: [
  //     StepItem(tex: r"""\textbf{【解答】}"""),
  //     StepItem(tex: r"""\begin{aligned}
  //     \lim_{x\to 0} \frac{\sin(ax)}{\sin(bx)}&=\lim_{x\to 0} \frac{\frac{\sin(ax)}{ax}}{\frac{\sin(bx)}{bx}}\cdot \frac{a}{b} \\[6pt]
  //     &= \frac{a}{b}
  //     \end{aligned}"""),
  //   ],
  // ),

  // MathProblem(
  //   id: "2D593B2A-9D37-4D7D-998E-80D6F021B76D",
  //   no: 4,
  //   category: '基本極限',
  //   level: '中級',
  //   question: r"""\displaystyle \lim_{x\to 0}\frac{\sin x}{x+\sin x}""",
  //   answer: r"""\displaystyle \frac{1}{2}""",
  //   imageAsset: 'assets/graphs/limit/problems_basic_limits/problem_4.png',
  //   steps: [
  //     StepItem(tex: r"""\textbf{【方針】}"""),
  //     StepItem(tex: r"""\text{分母分子を} x \text{で割り、} $\displaystyle \lim_{x\to 0}\frac{\sin x}{x}=1$ \text{ を使う}"""),
  //     StepItem(tex: r"""\textbf{【解答】}"""),
  //     StepItem(tex: r"""\begin{aligned}
  // \lim_{x\to 0}\frac{\sin x}{x+\sin x}
  // &= \lim_{x\to 0} \frac{\displaystyle  \dfrac{\sin x}{x}}{\,1+\displaystyle \dfrac{\sin x}{x}\,} \\[6pt]
  // &= \frac{\displaystyle \lim_{x\to 0}\dfrac{\sin x}{x}}{\,1+\displaystyle \lim_{x\to 0}\dfrac{\sin x}{x}\,} \\[6pt]
  // &= \frac{1}{1+1} \\[4pt]
  // &= \frac{1}{2}
  // \end{aligned}"""),
  //   ],
  // ),


  MathProblem(
    id: "71ECF2CF-206F-43FF-BA35-F097D1FEB231",
    no: 5,
    category: '基本極限',
    level: '初級',
    question: r"""\displaystyle \lim_{x\to 0}\frac{1-e^{-x}}{x}""",
    answer: r"""\displaystyle 1""",
    imageAsset: 'assets/graphs/limit/problems_basic_limits/problem_5.png',
    steps: [
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\begin{aligned}
  \lim_{x\to 0}\frac{1-e^{-x}}{x}&= \lim_{x\to 0}\frac{e^{x}-1}{x\,e^{x}} \\[6pt]
  &= \lim_{x\to 0}\frac{e^{x}-e^0}{x - 0}  \lim_{x\to 0}\frac{1} {e^{x}} \\[6pt]
  &= (e^x)' |_{x=0} \cdot \frac{1}{1} \\[4pt]
  &= e^x |_{x=0} \cdot \frac{1}{1} \\[4pt]
  &= \frac{1}{1} \\[4pt]
  &= 1
  \end{aligned}"""),
    ],
  ),


  MathProblem(
    id: "8BB1FDF5-A692-41E5-9B88-E62F9E4B96BA",
    no: 6,
    category: '基本極限',
    level: '中級',
    question: r"""\displaystyle \lim_{x\to 0}\frac{e^{x}-e^{-x}}{2x}""",
    answer: r"""\displaystyle 1""",
    imageAsset: 'assets/graphs/limit/problems_basic_limits/problem_6.png',
    steps: [
      StepItem(tex: r"""\textbf{【解答】} """),
      StepItem(tex: r"""\text{分母分子に } $e^{x}$ \text{ を掛け、} $\displaystyle \lim_{u\to 0}\frac{e^{u}-1}{u}=1$ \text{ を用いる}"""),
      StepItem(tex: r"""\begin{aligned}
  \lim_{x\to 0}\frac{e^{x}-e^{-x}}{2x} &= \lim_{x\to 0}\frac{e^{x}-e^{-x}}{2x}\cdot\frac{e^{x}}{e^{x}} \\[6pt]
  &= \lim_{x\to 0}\frac{e^{2x}-1}{2x}\cdot\frac{1}{e^{x}} \\[6pt]
  &= \left(\lim_{x\to 0}\frac{e^{2x}-1}{2x}\right)\cdot\left(\lim_{x\to 0}\frac{1}{e^{x}}\right) \\[6pt]
  &= 1 \cdot \frac{1}{1} \\[6pt]
  &= 1 \cdot 1 \\[6pt]
  &= 1
  \end{aligned}"""),
    ],
  ),


  MathProblem(
    id: "6D0B855E-7E52-4C1B-8A44-AA9FF0FB03B3",
    no: 7,
    category: '基本極限',
    level: '初級',
    question: r"""\displaystyle \lim_{x\to 0}\frac{\log(1+2x)}{x}""",
    answer: r"""\displaystyle 2""",
    imageAsset: 'assets/graphs/limit/problems_basic_limits/problem_7.png',
    steps: [
      StepItem(tex: r"""\textbf{【ポイント】( [1] とする)}"""),
      StepItem(tex: r"""
      \begin{aligned}
      \lim_{x\to 0}\frac{\log(1+x)}{x} =& \lim_{x\to 0}\frac{\log(1+x) - \log 1}{x - 0} \\[6pt]
      =& \log(x+1)' \Big|_{x=0}\\[6pt]
      =& \frac{1}{x+1} \Big|_{x=0}\\[6pt]
      =& 1 
      \end{aligned}
      """),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\text{分母分子に } 2 \text{ を掛ける。}"""),
      StepItem(tex: r"""
      \begin{aligned}
      & \lim_{x\to 0}\frac{\log(1+2x)}{x} \\[6pt]
      =& \lim_{x\to 0}\frac{2\,\log(1+2x)}{2 x} \\[6pt]
      =& 2\,\lim_{x\to 0}\frac{\log(1+2x)}{2 x} \\[6pt]
      =& 2\cdot 1 \ \  (\because \ [1] )  \\[6pt]
      =& 2 
      \end{aligned}"""),
    ],
  ),


  MathProblem(
    id: "BB41368E-ACE1-4D11-B8A8-CEB3918B6EE5",
    no: 8,
    category: '基本極限',
    level: '初級',
    question: r"""\displaystyle \lim_{x\to 0}\frac{\log(1+x)}{x}""",
    answer: r"""\displaystyle 1""",
    imageAsset: 'assets/graphs/limit/problems_basic_limits/problem_8.png',
    hint: r"""\text{これは } f(x)=\log(1+x) \text{ の } x=0 \text{ での微分係数である}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{これは } f(x)=\log(1+x) \text{ の } x=0 \text{ での微分係数である}"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\begin{aligned}
      \lim_{x\to 0}\frac{\log(1+x)}{x}
      &= \lim_{x\to 0}\frac{\log(1+x)-\log(1+0)}{x-0} \\[6pt]
      &= \lim_{x\to 0}\frac{f(x)-f(0)}{x-0} \\[6pt]
      &= f'(0) \\[6pt]
      &= (\log(1+x))' \Big|_{x=0} \\[6pt]
      &= \frac{1}{1+x} \Big|_{x=0} \\[6pt]
      &= \frac{1}{1+0} \\[6pt]
      &= 1
      \end{aligned}"""),
    ],
  ),

  MathProblem(
    id: "CCD350BD-2E20-456F-80B5-5646A5070E7E",
    no: 9,
    category: '基本極限',
    level: '初級',
    question: r"""\displaystyle \lim_{x\to 0}\frac{3^{x}-1}{x}""",
    answer: r"""\displaystyle \log 3""",
    imageAsset: 'assets/graphs/limit/problems_basic_limits/problem_9.png',
    hint: r"""\text{これは } f(x)=3^{x} \text{ の } x=0 \text{ での微分係数である}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{これは } f(x)=3^{x} \text{ の } x=0 \text{ での微分係数である}"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\begin{aligned}
      \lim_{x\to 0}\frac{3^{x}-1}{x}
      &= \lim_{x\to 0}\frac{3^{x}-3^{0}}{x-0} \\[6pt]
      &= \lim_{x\to 0}\frac{f(x)-f(0)}{x-0} \\[6pt]
      &= f'(0) \\[6pt]
      &= (3^{x})' \Big|_{x=0} \\[6pt]
      &= (e^{x\log 3})'\Big|_{x=0} \\[6pt]
      &= e^{x\log 3} \cdot \log 3 \Big|_{x=0} \\[6pt]
      &= e^{0} \cdot \log 3 \\[6pt]
      &= \log 3
      \end{aligned}"""),
    ],
  ),


  MathProblem(
    id: "0DDAAC08-A9CF-4240-9166-64922F384992",
    no: 10,
    category: '基本和の極限',
    level: '初級',
    question: r"""\displaystyle \lim_{n\to\infty}\frac{1}{n^{3}}\displaystyle \sum_{k=1}^{n}k^{2}""",
    answer: r"""\displaystyle \frac{1}{3}""",
    imageAsset: 'assets/graphs/limit/problems_basic_limits/problem_10.png',
    hint: r"""\textbf{【方針】 } \displaystyle \sum_{k=1}^{n}k^{2}=\dfrac{n(n+1)(2n+1)}{6}\ を用いる""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】 } \displaystyle \sum_{k=1}^{n}k^{2}=\dfrac{n(n+1)(2n+1)}{6}\ を用いる"""),
      StepItem(tex: r"""\begin{aligned}
        \frac{1}{n^{3}}\displaystyle \sum_{k=1}^{n}k^{2}
        &= \frac{1}{n^{3}}\cdot \frac{n(n+1)(2n+1)}{6} \\[6pt]
        &= \frac{1}{6}\cdot \frac{(n+1)(2n+1)}{n^{2}} \\[6pt]
        &= \frac{1}{6}\cdot \frac{2n^{2}+3n+1}{n^{2}} \\[6pt]
        &= \frac{1}{6}\left(2+\frac{3}{n}+\frac{1}{n^{2}}\right) \\[6pt]
        &\underset{n\to\infty}{\longrightarrow}\  \displaystyle \frac{1}{6} \cdot 2 = \frac{1}{3}
      \end{aligned}"""),
    ],
  ),

  MathProblem(
    id: "CECF170F-83C3-485D-B0F7-A73B2089A50B",
    no: 11,
    category: '基本極限',
    level: '初級',
    question: r"""\displaystyle 2+(-2+2)+(-2+2)+\cdots """,
    answer: r"""\displaystyle 2""",
    imageAsset: 'assets/graphs/limit/problems_basic_limits/problem_11.png',
    steps: [
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{無限級数} \displaystyle \sum_{k=1}^{\infty} a_k= 2+(-2+2)+(-2+2)+\cdots \text{ の収束の定義より、まず部分和} S_n \text{を考えると、}"""),
      StepItem(tex: r"""\text{ここで、} a_1 = 2, \ a_2 = -2+2 = 0, \ a_3 = -2+2 = 0, \ \ldots \text{ である。}"""),
      StepItem(tex: r"""\begin{aligned}
        S_n &= 2+(-2+2)+(-2+2)+\cdots+(-2+2) \\[6pt]
        &= 2+0+0+\cdots+0 \\[6pt]
        &= 2
      \end{aligned}"""),
      StepItem(tex: r"""\text{したがって、部分和の数列} S_n \text{ は } (2,2,2,2,\cdots) \text{ となる。}"""),
      StepItem(tex: r"""\text{よって、無限級数} \displaystyle \sum_{k=1}^{\infty} a_k= 2+(-2+2)+(-2+2)+\cdots \text{ は } 2 \text{ に収束する。}"""),
    ],
  ),

  MathProblem(
    id: "ABE37AA2-9FEC-4ADD-9022-1A38340249F1",
    no: 12,
    category: '基本極限',
    level: '初級',
    question: r"""\displaystyle (2-2)+(2-2)+(2-2)+\cdots """,
    answer: r"""\displaystyle 0""",
    imageAsset: 'assets/graphs/limit/problems_basic_limits/problem_12.png',
    steps: [
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{無限級数} \displaystyle \sum_{k=1}^{\infty} a_k= (2-2)+(2-2)+(2-2)+\cdots \text{ の収束の定義より、まず部分和} S_n \text{を考えると、}"""),
      StepItem(tex: r"""\text{ここで、} a_1 = 2-2 = 0, \ a_2 = 2-2 = 0, \ a_3 = 2-2 = 0, \ \ldots \text{ である。}"""),
      StepItem(tex: r"""\begin{aligned}
        S_n &= (2-2)+(2-2)+\cdots+(2-2) \\[6pt]
        &= 0+0+\cdots+0 \\[6pt]
        &= 0
      \end{aligned}"""),
      StepItem(tex: r"""\text{したがって、部分和の数列} S_n \text{ は } (0,0,0,0,\cdots) \text{ となる。}"""),
      StepItem(tex: r"""\text{よって、無限級数} \displaystyle \sum_{k=1}^{\infty} a_k= (2-2)+(2-2)+(2-2)+\cdots \text{ は } 0 \text{ に収束する。}"""),
    ],
  ),

  MathProblem(
    id: "FAF62CC1-1FE8-41FC-B1B6-5151D088742A",
    no: 13,
    category: '基本極限',
    level: '初級',
    question: r"""\displaystyle 2-2+2-2+2-2+\cdots """,
    answer: r"""\textcolor{green}{発散（振動）}""",
    imageAsset: 'assets/graphs/limit/problems_basic_limits/problem_13.png',
    steps: [
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{無限級数} \displaystyle \sum_{k=1}^{\infty} a_k= 2-2+2-2+2-2+\cdots \text{ の収束の定義より、まず部分和} S_n \text{を考えると、}"""),
      StepItem(tex: r"""\begin{aligned}
        S_{2n} &= (2-2)+(2-2)+\cdots+(2-2) = 0 \\[6pt]
        S_{2n+1} &= (2-2)+(2-2)+\cdots+(2-2)+2 = 2
      \end{aligned}"""),
      StepItem(tex: r"""\text{したがって、部分和の数列} S_n{は } (0,2,0,2,0,2,\cdots) \text{ となり、振動する。}"""),
      StepItem(tex: r"""\text{よって、無限級数} \displaystyle \sum_{k=1}^{\infty} a_k= 2-2+2-2+2-2+\cdots \text{ の極限は存在しない(振動する)}"""),
    ],
  ),

  MathProblem(
  id: "E8F3C9A2-7D6A-4E4E-9B6E-XLNXLOGX001",
  no: 14,
  category: '基本極限',
  level: '初級',
  question: r"""\displaystyle \lim_{x\to +0} x\log x""",
  answer: r"""\displaystyle 0""",
  hint: r"""\text{ } x = \dfrac{1}{t} \ (t\to\infty) \text{ と置く}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{ } x\to 0^+ \text{ のとき } x=\dfrac{1}{t} \ (t\to\infty) \text{ とおく}"""),
    StepItem(tex: r"""\textbf{【変形】}"""),
    StepItem(tex: r"""
    \begin{aligned}
    \lim_{x\to +0} x\log x
    &= \lim_{t\to \infty} \frac{1}{t}\log\!\left(\frac{1}{t}\right) \\[6pt]
    &= \lim_{t\to \infty} \frac{1}{t}(-\log t) \\[6pt]
    &= \lim_{t\to \infty} -\frac{\log t}{t}\\[6pt]
    &= 0
    \end{aligned}
    """),
    StepItem(tex: r""" \textbf{【} \displaystyle \lim_{t\to\infty}-\frac{\log t}{t} \textbf{ の極限の補足】}"""),

    StepItem(tex:r"""t> 0 \text{ で } \log t < \sqrt{t} \text{ が成り立つ。}"""),

    StepItem(tex:r"""\text{よって}0 \le \displaystyle \frac{\log t}{t} < \frac{1}{\sqrt{t}} \xrightarrow[t\to\infty]{} 0"""),

    StepItem(tex:r"""\text{はさみうちの原理より，}"""),
    StepItem(tex:r"""\lim_{t\to\infty}-\frac{\log t}{t}=0"""),
  ],
),



];
