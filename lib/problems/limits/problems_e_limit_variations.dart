// problems_e_limit_variations.dart
// eに関する極限問題のバリエーション（9問）


import '../../models/math_problem.dart';
import '../../models/step_item.dart';

const problems_e_limit_variations = <MathProblem>[
  MathProblem(
    id: "3444E69A-5FCB-43A5-8C70-54616A1226D6",
    no: 1,
    category: 'eの極限',
    level: '初級',
    question: r"""\displaystyle \lim_{h\to 0}(1+h)^{\frac{1}{h}}""",
    answer: r"""\displaystyle e""",
    imageAsset: 'assets/graphs/limit/problems_e_limit_variations/problem_1.png',
    steps: [
      StepItem(tex: r"""\textbf{【定義】}"""),
    StepItem(tex: r"""\boxed{e = \lim_{h\to 0}(1+h)^{\frac{1}{h}}}"""),
      StepItem(tex: r"""\text{上記は自然対数の底(ネイピア数) } e \text{の定義そのもの。}"""),
    ],
  ),

  MathProblem(
    id: "1E209006-69B2-4DAE-8B9D-036D1800D855",
    no: 2,
    category: 'eの極限',
    level: '初級',
    question: r"""\displaystyle \lim_{h\to 0}(1+2h)^{\frac{1}{h}}""",
    answer: r"""\displaystyle e^{2}""",
    imageAsset: 'assets/graphs/limit/problems_e_limit_variations/problem_2.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{ } (1+2h)^{\frac{1}{h}} = \left((1+2h)^{\frac{1}{2h}}\right)^{2} \text{ と変形し、中身の部分が定義より } e \text{ になることを用いる。}"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\begin{aligned}
      \lim_{h\to 0}(1+2h)^{\frac{1}{h}} &= \lim_{h\to 0}\left((1+2h)^{\frac{1}{2h}}\right)^{2} \\[6pt]
      &= \left(\lim_{h\to 0}(1+2h)^{\frac{1}{2h}}\right)^{2}
      \end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} h\to 0 \text{ のとき } 2h\to 0 \text{ であるから、定義 } e = \lim_{h\to 0}(1+h)^{\frac{1}{h}} \text{ より、} \lim_{h\to 0}(1+2h)^{\frac{1}{2h}} = e \text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
      \lim_{h\to 0}(1+2h)^{\frac{1}{h}} &= e^{2}
      \end{aligned}"""),
    ],
  ),

  MathProblem(
    id: "369BD639-C54E-4847-93A1-3B56E19006A2",
    no: 3,
    category: 'eの極限',
    level: '初級',
    question: r"""\displaystyle \lim_{x\to \infty}\left(1+\frac{1}{x}\right)^{x}""",
    answer: r"""\displaystyle e""",
    imageAsset: 'assets/graphs/limit/problems_e_limit_variations/problem_3.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{変数変換 } h = \displaystyle\frac{1}{x} \text{ を用いて、} e = \lim_{h\to 0}(1+h)^{\frac{1}{h}} \text{ の定義に帰着させる。}"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\text{ } h = \displaystyle\frac{1}{x} \text{ とおくと、} x\to \infty \text{ のとき } h\to +0 \text{ であり、} x = \displaystyle\frac{1}{h} \text{ である。}"""),
      StepItem(tex: r"""\begin{aligned}
      \lim_{x\to \infty}\left(1+\frac{1}{x}\right)^{x} &= \lim_{h\to +0}(1+h)^{\frac{1}{h}} \\[6pt]
      &= e
      \end{aligned}"""),
      StepItem(tex: r"""\text{ここで、定義より} e = \lim_{h\to 0}(1+h)^{\frac{1}{h}} \text{ なので、(これは近づけ方によらないという意味なので)大きい方から近づけた極限}  \lim_{h\to +0}(1+h)^{\frac{1}{h}} \text{も} e \text{と等しい。}"""),
    ],
  ),

  MathProblem(
    id: "38DF36DC-0268-4E1D-A341-14A39DDE8543",
    no: 4,
    category: 'eの極限',
    level: '初級',
    question: r"""\displaystyle \lim_{x\to -\infty}\left(1+\frac{1}{x}\right)^{x}""",
    answer: r"""\displaystyle e""",
    imageAsset: 'assets/graphs/limit/problems_e_limit_variations/problem_4.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{変数変換を用いて、} e = \lim_{h\to 0}(1+h)^{\frac{1}{h}} \text{ の定義に帰着させる。}"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\text{ } t = -x \text{ とおくと、} x\to -\infty \text{ のとき } t\to \infty \text{ である。}"""),
      StepItem(tex: r"""\begin{aligned}
      \lim_{x\to -\infty}\left(1+\frac{1}{x}\right)^{x} &= \lim_{t\to \infty}\left(1-\displaystyle\frac{1}{t}\right)^{-t} \\[6pt]
      &= \lim_{t\to \infty}\left(\displaystyle\frac{t-1}{t}\right)^{-t} \\[6pt]
      &= \lim_{t\to \infty}\left(\displaystyle\frac{t}{t-1}\right)^{t} \\[6pt]
      &= \lim_{t\to \infty}\left(1+\displaystyle\frac{1}{t-1}\right)^{t} \\[6pt]
      &= \lim_{t\to \infty}\left(1+\displaystyle\frac{1}{t-1}\right)^{t-1}\cdot\left(1+\displaystyle\frac{1}{t-1}\right) \\[6pt]
      \end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} u = t-1 \text{ とおくと、} t\to \infty \text{ のとき } u\to \infty \text{ であり、}"""),
      StepItem(tex: r"""\begin{aligned}
      &= \lim_{u\to \infty}\left(1+\displaystyle\frac{1}{u}\right)^{u}\cdot 1 \\[6pt]
      &= \lim_{h\to +0}(1+h)^{\frac{1}{h}} \quad (h = \displaystyle\frac{1}{u}) \\[6pt]
      \end{aligned}"""),
      StepItem(tex: r"""\text{ここで、定義より} e = \lim_{h\to 0}(1+h)^{\frac{1}{h}} \text{ なので、(これは近づけ方によらないという意味なので)大きい方から近づけた極限}  \lim_{h\to +0}(1+h)^{\frac{1}{h}} \text{も} e \text{と等しい。}"""),
    ],
  ),

  MathProblem(
    id: "53BC96C5-2D01-45FE-9A39-F369BA9E2097",
    no: 5,
    category: 'eの極限',
    level: '初級',
    question: r"""\displaystyle \lim_{x\to \infty}\left(1+\frac{1}{x}\right)^{2x}""",
    answer: r"""\displaystyle e^{2}""",
    imageAsset: 'assets/graphs/limit/problems_e_limit_variations/problem_5.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{変数変換 } h = \displaystyle\frac{1}{x} \text{ を用いて、} e = \lim_{h\to 0}(1+h)^{\frac{1}{h}} \text{ の定義に帰着させる。}"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\text{ } h = \displaystyle\frac{1}{x} \text{ とおくと、} x\to \infty \text{ のとき } h\to +0 \text{ であり、} x = \displaystyle\frac{1}{h} \text{ である。}"""),
      StepItem(tex: r"""\begin{aligned}
      \lim_{x\to \infty}\left(1+\frac{1}{x}\right)^{2x} &= \lim_{h\to +0}(1+h)^{\frac{2}{h}} \\[6pt]
      &= \lim_{h\to +0}\left((1+h)^{\frac{1}{h}}\right)^{2} \\[6pt]
      \end{aligned}"""),
      StepItem(tex: r"""\text{ここで、定義より} e = \lim_{h\to 0}(1+h)^{\frac{1}{h}} \text{ なので、(これは近づけ方によらないという意味なので)大きい方から近づけた極限}  \lim_{h\to +0}(1+h)^{\frac{1}{h}} \text{も} e \text{と等しい。}"""),
      StepItem(tex: r"""\text{よって、}"""),
      StepItem(tex: r"""\begin{aligned}
        \lim_{h\to +0}\left((1+h)^{\frac{1}{h}}\right)^{2} 
        &= \left(\lim_{h\to +0}(1+h)^{\frac{1}{h}}\right)^{2}
        &= e^{2}
      \end{aligned}"""),
      
    ],
  ),

    MathProblem(
    id: "E03C5F81-3445-4D78-8BC7-9BDD3EF528CD",
    no: 6,
    category: 'eの極限',
    level: '初級',
    question: r"""\displaystyle \lim_{h\to +0}\left(1+\frac{1}{h}\right)^{h}""",
    answer: r"""\displaystyle 1""",
    imageAsset: 'assets/graphs/limit/problems_e_limit_variations/problem_6.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{対数を取り、指数部の極限を評価する。対数の極限が }0\text{ なら元の極限は }e^{0}=1\text{ である。}"""),
    StepItem(tex: r"""\textbf{【計算}"""),
       StepItem(tex: r"""\text{ } u=\displaystyle\frac{1}{h} \text{ とおくと、} h\to +0 \text{ のとき } u\to +\infty \text{ であり、} h=\displaystyle\frac{1}{u} \text{ である。}"""),
      StepItem(tex: r"""\text{よって、} \lim_{h\to +0}\left(1+\frac{1}{h}\right)^{h} =\lim_{u\to\infty}\left(1+u\right)^{\frac{1}{u}} \text{この対数を取ると、}"""),
      StepItem(tex: r"""\begin{aligned}
      \log\left(\lim_{u\to\infty}(1+u)^{\frac{1}{u}}\right)
      &=\lim_{u\to\infty}\log\left((1+u)^{\frac{1}{u}}\right) \\[6pt]
      &=\textcolor{blue}{\lim_{u\to\infty}\frac{\log(1+u)}{u}\cdots(1)}
      \end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} \displaystyle \frac{\log(1+u)}{u} = \frac{\log(1+u)}{1+u}\cdot\frac{1+u}{u}"""),
      StepItem(tex: r"""\text{とすると、既知の極限 } \displaystyle\lim_{u\to\infty}\frac{\log(1+u)}{1+u}=0,\ \lim_{u\to\infty}\frac{1+u}{u}=1 \text{ より、}\textcolor{blue}{(1)は}\textcolor{blue}{\displaystyle \lim_{u\to\infty}\frac{\log(1+u)}{u}} =  0 \cdot 1= 0"""),
      StepItem(tex: r"""\text{したがって、} \displaystyle \log\left(\lim_{u\to\infty}(1+u)^{\frac{1}{u}}\right) = 0 \text{ より、} \displaystyle \lim_{u\to\infty}(1+u)^{\frac{1}{u}} = 1 """),
    ],
  ),

  MathProblem(
    id: "9161EDD7-12DE-4729-A2A7-9A55E060C466",
    no: 7,
    category: 'eの極限',
    level: '初級',
    question: r"""\displaystyle \lim_{h\to \infty}(1+h)^{\frac{1}{h}}""",
    answer: r"""\displaystyle 1""",
    imageAsset: 'assets/graphs/limit/problems_e_limit_variations/problem_7.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{対数を取って } \displaystyle\frac{\log(1+h)}{h}\text{ の極限を調べ、指数関数の連続性で元に戻す。}"""),
      StepItem(tex: r"""\textbf{【計算】}"""),
      StepItem(tex: r"""\lim_{h\to\infty}(1+h)^{\frac{1}{h}} \text{の対数を取ると、}"""),
      StepItem(tex: r"""\begin{aligned}
      \log\left(\lim_{h\to\infty}(1+h)^{\frac{1}{h}}\right)
      &=\lim_{h\to\infty}\log\left((1+h)^{\frac{1}{h}}\right) \\[6pt]
      &=\textcolor{blue}{\lim_{h\to\infty}\frac{\log(1+h)}{h}\cdots(1)}
      \end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} \displaystyle \frac{\log(1+h)}{h} = \frac{\log(1+h)}{1+h}\cdot\frac{1+h}{h}"""),
      StepItem(tex: r"""\text{とすると、既知の極限 } \displaystyle\lim_{h\to\infty}\frac{\log(1+h)}{1+h}=0,\ \lim_{h\to\infty}\frac{1+h}{h}=1 \text{ より、}\textcolor{blue}{(1)は}\textcolor{blue}{\displaystyle \lim_{h\to\infty}\frac{\log(1+h)}{h}} =  0 \cdot 1= 0"""),
      StepItem(tex: r"""\text{したがって、} \displaystyle \log\left(\lim_{h\to\infty}(1+h)^{\frac{1}{h}}\right) = 0 \text{ より、} \displaystyle \lim_{h\to\infty}(1+h)^{\frac{1}{h}} = 1 """),
    ],
  ),



//   MathProblem(
//     id: "E9A0B1C2-D3E4-F5G6-H7I8-J9K0L1M2N3O4",
//     no: 9,
//     category: 'eの極限',
//     level: '上級',
//     question: r""" 1+\displaystyle \sum_{n=1}^{\infty}\frac{1}{n!}""",
//     answer: r"""\displaystyle e = 1+\displaystyle \sum_{n=1}^{\infty}\frac{1}{n!}""",
//     imageAsset: 'assets/graphs/limit/problems_e_limit_variations/problem_9.png',
//     steps: [
//       StepItem(tex: r"""\textbf{【方針】}"""),
//       StepItem(tex: r"""\text{定義 } e = \lim_{h\to 0}(1+h)^{\frac{1}{h}} \text{ において、} h = \displaystyle\frac{1}{n} \text{ とおいて } (1+\frac{1}{n})^{n} \text{ を二項展開し、} n\to \infty \text{ の極限を取る。}"""),
//       StepItem(tex: r"""\textbf{【解答】}"""),
//       StepItem(tex: r"""\text{ } h = \displaystyle\frac{1}{n} \text{ とおくと、} h\to 0 \text{ のとき } n\to \infty \text{ であり、} (1+h)^{\frac{1}{h}} = \left(1+\frac{1}{n}\right)^{n} \text{ である。}"""),
//       StepItem(tex: r"""\text{ } n \text{ を } 1 \text{ 以上の整数とする。二項定理より、}"""),
//       StepItem(tex: r"""\begin{aligned}
//       \left(1+\frac{1}{n}\right)^{n} &= \displaystyle \sum_{k=0}^{n} \binom{n}{k}\left(\frac{1}{n}\right)^{k} \\[6pt]
//       &= \displaystyle \sum_{k=0}^{n} \frac{n(n-1)\cdots(n-k+1)}{k!}\cdot\frac{1}{n^{k}} \\[6pt]
//       &= \displaystyle \sum_{k=0}^{n} \frac{1}{k!}\cdot\frac{n(n-1)\cdots(n-k+1)}{n^{k}} \\[6pt]
//       &= \displaystyle \sum_{k=0}^{n} \frac{1}{k!}\cdot\frac{n}{n}\cdot\frac{n-1}{n}\cdots\frac{n-k+1}{n} \\[6pt]
//       &= \displaystyle \sum_{k=0}^{n} \frac{1}{k!}\prod_{j=0}^{k-1}\left(1-\frac{j}{n}\right)
//       \end{aligned}"""),
//       StepItem(tex: r"""\text{ここで、} n\to \infty \text{ のとき、各 } k \text{ に対して、} \displaystyle\frac{n(n-1)\cdots(n-k+1)}{n^{k}} \to 1 \text{ である（補足の命題参照）。}"""),
//       StepItem(tex: r"""\text{したがって、}"""),
//       StepItem(tex: r"""\begin{aligned}
//       e = \lim_{h\to 0}(1+h)^{\frac{1}{h}} &= \lim_{n\to\infty}\left(1+\frac{1}{n}\right)^{n} \\[6pt]
//       &= \lim_{n\to\infty}\displaystyle \sum_{k=0}^{n}\frac{1}{k!}\cdot\frac{n(n-1)\cdots(n-k+1)}{n^{k}} \\[6pt]
//       &= \displaystyle \sum_{k=0}^{\infty}\frac{1}{k!} \\[6pt]
//       &= 1+\displaystyle \sum_{n=1}^{\infty}\frac{1}{n!}
//       \end{aligned}"""),
//       StepItem(tex: r"""\text{ここで、} k=0 \text{ の項を分離し、} n=k \text{ と置き換えた。}"""),
//             StepItem(tex: r"""\textbf{【命題】}"""),
//       StepItem(tex: r"""\text{任意の固定した自然数 } k\ge 0 \text{ に対して、}"""),
//       StepItem(tex: r"""\begin{aligned}
//       \lim_{n\to\infty}\frac{n(n-1)\cdots(n-k+1)}{n^{k}}
//       &=\lim_{n\to\infty}\prod_{j=0}^{k-1}\left(1-\frac{j}{n}\right) \\[6pt]
//       &= 1
//       \end{aligned}"""),

//       StepItem(tex: r"""\textbf{【証明】}"""),
//       StepItem(tex: r"""\text{左辺は有限積 } \(\prod_{j=0}^{k-1}\bigl(1-\tfrac{j}{n}\bigr)\) に書ける。各固定した } j(0\le j\le k-1)\text{ に対して }"""),
//       StepItem(tex: r"""\begin{aligned}
//       \lim_{n\to\infty}\left(1-\frac{j}{n}\right) = 1
//       \end{aligned}"""),
//       StepItem(tex: r"""\text{である。有限個の数列の積の極限は各数列の極限の積に等しいため、}"""),
//       StepItem(tex: r"""\begin{aligned}
//       \lim_{n\to\infty}\prod_{j=0}^{k-1}\left(1-\frac{j}{n}\right)
//       &=\prod_{j=0}^{k-1}\lim_{n\to\infty}\left(1-\frac{j}{n}\right) \\[6pt]
//       &=\prod_{j=0}^{k-1}1 \\[6pt]
//       &= 1
//       \end{aligned}"""),
//       StepItem(tex: r"""\text{これで命題は示された。}"""),
//     ],
//   ),

];

