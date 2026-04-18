// riemann_limits.dart
// 区分求積問題集（6問）


import '../../models/math_problem.dart';
import '../../models/step_item.dart';

const riemann_limits = <MathProblem>[
  MathProblem(
    id: "D38E0151-81F6-4A38-A100-93A0C0E7A048",
    no: 1,
    category: '区分求積（幾何：扇形近似）',
    level: '中級',
    question: r"""\displaystyle \lim_{n\to\infty}\frac{1}{n}\displaystyle \sum_{k=-n}^{n}\sqrt{1-\left(\frac{k}{n}\right)^{2}}""",
    answer: r"""\displaystyle \frac{\pi}{2}""",
    imageAsset: 'assets/graphs/limit/problems_riemann_limits/problem_1.png',
    hint: r"""\text{区分求積と円の一部である事を用いるとよい。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{区分求積と円の一部である事を用いるとよい。}"""),
      StepItem(tex: r"""\begin{aligned}
        &\lim_{n\to\infty}\frac{1}{n}\displaystyle \sum_{k=-n}^{n}\sqrt{1-\left(\frac{k}{n}\right)^{2}} \\[6pt]
        =& \int_{-1}^{1}\sqrt{1-x^{2}}\,dx \\[6pt]
        =& \text{円の面積の半分} \\[6pt]
        =& \displaystyle \frac{\pi}{2}
      \end{aligned}"""),
    ],
  ),
  MathProblem(
    id: "630FBD47-A86B-4108-8F90-86F202047B8D",
    no: 2,
    category: '区分求積（対数関数）',
    level: '中級',
    question: r"""\displaystyle \lim_{n \to \infty} \displaystyle \sum_{k=1}^{n} \frac{1}{n+k}""",
    answer: r"""\displaystyle \log 2""",
    imageAsset: 'assets/graphs/limit/problems_riemann_limits/problem_2.png',
    hint: r"""\text{区分求積法で定積分に帰着させる}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{区分求積法で定積分に帰着させる}"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\begin{aligned}
      \lim_{n \to \infty} \displaystyle \sum_{k=1}^{n} \frac{1}{n+k}
      &=\lim_{n \to \infty} \displaystyle \sum_{k=1}^{n} \frac{\frac 1 n}{1+\frac k n}\\[6pt]
      &=\lim_{n \to \infty} \frac{1}{n} \displaystyle \sum_{k=1}^{n} \frac{1}{1+\frac{k}{n}} \\[6pt]
      &=\int_{0}^{1}\frac{1}{1+x}\,dx \\[6pt]
      &=\log 2
      \end{aligned}"""),
    ],
  ),

  MathProblem(
    id: "A5E3309B-0558-4CCE-8B01-62E93D2FC90E",
    no: 3,
    category: '区分求積（対数関数）',
    level: '中級',
    question: r"""\displaystyle \lim_{n \to \infty} \frac{1}{n} \displaystyle \sum_{k=1}^{n} \frac{1}{n+k}""",
    answer: r"""\displaystyle 0""",
    imageAsset: 'assets/graphs/limit/problems_riemann_limits/problem_3.png',
    hint: r"""\text{区分求積法で定積分に帰着させる}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{区分求積法で定積分に帰着させる}"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\begin{aligned}
      &\lim_{n\to\infty} \frac{1}{n}\displaystyle \sum_{k=1}^{n}\frac{1}{k+n}\\[6pt]
      =&\lim_{n\to\infty} \frac{1}{n}\displaystyle \sum_{k=1}^{n}\frac{\frac 1 n}{1+\frac k n}\\[6pt]
      =&\lim_{n\to\infty} \frac{1}{n^2}\displaystyle \sum_{k=1}^{n}\frac{ 1 }{1+\frac k n}\\[6pt]
      =&\lim_{n\to\infty} \frac{1}{n} \cdot \left(\frac{1}{n}\displaystyle \sum_{k=1}^{n}\frac{1}{1+\frac k n}\right)\\[6pt]
      =&\lim_{n\to\infty} \frac{1}{n} \cdot \lim_{n\to\infty} \left(\frac{1}{n}\displaystyle \sum_{k=1}^{n}\frac{1}{1+\frac k n}\right) \\[6pt]
      =&0 \cdot \int_{0}^{1}\frac{1}{1+x}\,dx \\[6pt]
      =&0 \cdot \log 2 \\[6pt]
      =&0
      \end{aligned}"""),
    ],
  ),

  MathProblem(
    id: "6C703101-29A6-4005-87D6-594F60194AFC",
    no: 4,
    category: '区分求積（余弦）',
    level: '上級',
    question: r"""\displaystyle \lim_{n\to\infty}\frac{1}{n}\displaystyle \sum_{k=0}^{2n}\cos\!\left(\frac{\pi k}{n}\right)""",
    answer: r"""\displaystyle 0""",
    imageAsset: 'assets/graphs/limit/problems_riemann_limits/problem_4.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】 }"""),
      StepItem(tex: r"""\text{区分求積法を使う。}"""),
      StepItem(tex: r"""\textbf{【解答】}"""),
      StepItem(tex: r"""\begin{aligned}
        &\lim_{n\to\infty}\frac{1}{n}\displaystyle \sum_{k=0}^{2n}\cos\!\left(\frac{\pi k}{n}\right) \\[6pt]
        =& \lim_{n\to\infty}\frac{1}{n}\displaystyle \sum_{k=0}^{2n}\cos\!\left(\pi \cdot \frac{k}{n}\right) \\[6pt]
        =& \int_{0}^{2}\cos(\pi x)\,dx \\[6pt]
        =& \left[\frac{1}{\pi}\sin(\pi x)\right]_{0}^{2} \\[6pt]
        =& \frac{1}{\pi}(\sin(2\pi) - \sin(0)) \\[6pt]
        =& 0
      \end{aligned}"""),
    ],
  ),
MathProblem(
  id: "E9F0A1B2-C3D4-5E6F-7A8B-9C0D1E2F3A4B",
  no: 5,
  category: '積分の極限（はさみうち）',
  level: '上級',
  question: r"""\displaystyle \lim_{n\to\infty}\int_{0}^{\frac{\pi}{4}}\tan^{2n}x\,dx""",
  answer: r"""\displaystyle 0""",
  imageAsset: 'assets/graphs/limit/problems_riemann_limits/problem_5.png',
  hint: r"""\text{はさみうちの原理を用いて評価する（直線 } y=\frac{4x}{\pi} \text{ と比較）}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{直線 } y=\displaystyle\frac{4x}{\pi} \text{ と比較し、はさみうちの原理を用いて評価する。}"""),
    StepItem(tex: r"""\textbf{【解答】}"""),
    StepItem(tex: r"""\text{まず、次の命題を用いる：}"""),
    StepItem(tex: r"""\text{【命題】}"""),
    StepItem(tex: r"""0 \leq x \leq \displaystyle\frac{\pi}{4} \text{ のとき、} \tan x \leq \displaystyle\frac{4x}{\pi} \text{ が成り立つ。}"""),
    StepItem(tex: r"""\text{この命題により、} 0 \leq x \leq \displaystyle\frac{\pi}{4} \text{ のとき、}"""),
    StepItem(tex: r"""\begin{aligned}
    0 \leq \tan^{2n}x \leq \left(\frac{4x}{\pi}\right)^{2n}
    \end{aligned}"""),
    StepItem(tex: r"""\text{が成り立つ。したがって、積分について、}"""),
    StepItem(tex: r"""\begin{aligned}
    0 \leq \int_{0}^{\frac{\pi}{4}}\tan^{2n}x\,dx &\leq \int_{0}^{\frac{\pi}{4}}\left(\frac{4x}{\pi}\right)^{2n}\,dx \\[6pt]
    &= \left(\frac{4}{\pi}\right)^{2n}\int_{0}^{\frac{\pi}{4}}x^{2n}\,dx \\[6pt]
    &= \left(\frac{4}{\pi}\right)^{2n} \cdot \frac{\left(\frac{\pi}{4}\right)^{2n+1}}{2n+1} \\[6pt]
    &= \frac{\pi}{4(2n+1)}
    \end{aligned}"""),
    StepItem(tex: r"""\text{したがって、}"""),
    StepItem(tex: r"""\begin{aligned}
    0 < \int_{0}^{\frac{\pi}{4}}\tan^{2n}x\,dx < \frac{\pi}{4(2n+1)}
    \end{aligned}"""),
    StepItem(tex: r"""\text{右辺は } n \to \infty \text{ で } 0 \text{ に収束するので、はさみうちの原理より、}"""),
    StepItem(tex: r"""\begin{aligned}
    \lim_{n\to\infty}\int_{0}^{\frac{\pi}{4}}\tan^{2n}x\,dx = 0
    \end{aligned}"""),
    StepItem(tex: r"""\textbf{【命題の証明】}"""),
    StepItem(tex: r"""\text{区間 }[0,\frac{\pi}{4}]\text{ において }"""),
    StepItem(tex: r"""\displaystyle \frac{d^2}{dx^2}(\tan x) =\frac{2\sin x}{\cos^{3}x}\ge0 \text{ が成り立つ。}"""),
    StepItem(tex: r"""\text{したがって }\tan x\text{ はこの区間で下に凸であり、} 0\text{ と }\tfrac{\pi}{4}\text{ を結ぶ直線の下に位置する。}"""),
  ],
),

];
