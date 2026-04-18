import '../../../models/problem_translation.dart';

final Map<String, ProblemTranslation> limitsTranslationsEn = {
  // advanced_limits.dart
  "81279279-68BC-46E4-96E8-C6188AD7617D": ProblemTranslation(
    category: 'Factorization / Geometric Series',
    level: 'Mid',
    hint: r"""x^{5}-1=(x-1)\bigl(x^{4}+x^{3}+x^{2}+x+1\bigr)""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Factorize } x^5-1 \text{ as } (x-1)(x^4+x^3+x^2+x+1), \text{ then take the limit as } x \to 1.",
      r"\text{After factoring, take the limit as } x \to 1\text{.}",
      r"\begin{aligned} \frac{x^{5}-1}{x-1} &= x^{4}+x^{3}+x^{2}+x+1 \end{aligned}",
      r"\begin{aligned} \therefore \lim_{x\to 1}\frac{x^{5}-1}{x-1} &= \lim_{x\to 1} (x^{4}+x^{3}+x^{2}+x+1)\\ &= 1+1+1+1+1\\ &= 5 \end{aligned}",
    ],
  ),
  "E3253228-3C96-488F-BD6E-A89DC18E84CA": ProblemTranslation(
    category: r"""\displaystyle \sum_{k=1}^{n}\frac{1}{k(k+2)}""",
    level: 'Easy',
    hint:
        r"""\displaystyle\frac{1}{k(k+2)}=\displaystyle\frac{1}{2}\left(\displaystyle\frac{1}{k}-\displaystyle\frac{1}{k+2}\right)""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\frac{1}{k(k+2)}=\frac{1}{2}\left(\frac{1}{k}-\frac{1}{k+2}\right)",
      r"\begin{aligned} \displaystyle \sum_{k=1}^{n}\frac{1}{k(k+2)} &= \frac{1}{2}\displaystyle \sum_{k=1}^{n}\left(\frac{1}{k}-\frac{1}{k+2}\right)\\ &= \frac{1}{2}\left(1+\frac{1}{2}-\frac{1}{n+1}-\frac{1}{n+2}\right)\\ &\underset{n\to\infty}{\longrightarrow} \frac{3}{4} \end{aligned}",
    ],
  ),
  "48677C5D-732B-4C47-B4AA-645616D8C392": ProblemTranslation(
    category: 'Comparison (Factorials vs Polynomials)',
    level: 'Advanced',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Write } \frac{n!}{n^n} = \prod_{k=1}^n \frac{k}{n}. \text{ Use the fact that } \frac{k}{n} \le \frac{1}{2} \text{ for } k \le \frac{n}{2} \text{ to apply the squeeze theorem.}",
      r"\textbf{[Solution]}",
      r"\textbf{[1] When } n \textbf{ is even:}",
      r"\begin{aligned} 0 \le \frac{n!}{n^n} &= \prod_{k=1}^{n}\frac{k}{n} = \prod_{k=1}^{\frac n 2}\frac{k}{n} \cdot \prod_{k=\frac {n} {2} +1}^{n}\frac{k}{n}\\ &\le \left(\frac{1}{2}\right)^{\frac n 2} \cdot 1^{\frac n 2} = \left(\frac{1}{2}\right)^{\frac n 2} \end{aligned}",
      r"\text{Since } \lim_{n\to\infty} (1/2)^{n/2} = 0, \text{ by the squeeze theorem, } \lim_{n\to\infty} \frac{n!}{n^n} = 0.",
      r"\textbf{[2] When } n \textbf{ is odd:}",
      r"\begin{aligned} 0 \le \frac{n!}{n^n} &= \prod_{k=1}^{n}\frac{k}{n} = \prod_{k=1}^{\frac{n-1}{2}}\frac{k}{n} \cdot \prod_{k=\frac{n+1}{2}}^{n}\frac{k}{n}\\ &\le \left(\frac{1}{2}\right)^{\frac{n-1}{2}} \cdot 1^{\frac{n+1}{2}} = \left(\frac{1}{2}\right)^{\frac{n-1}{2}} \end{aligned}",
      r"\text{Since } \lim_{n\to\infty} (1/2)^{(n-1)/2} = 0, \text{ by the squeeze theorem, } \lim_{n\to\infty} \frac{n!}{n^n} = 0.",
      r"\text{Combining both cases, we have shown that } \lim_{n\to\infty} \frac{n!}{n^n} = 0.",
      r"",
      r"\textbf{[Supplement: Product Notation]}",
      r"\prod_{k=m}^n a_k \text{ (} m \le n \text{) represents the product } a_m \cdot a_{m+1} \cdot \cdots \cdot a_n.",
      r"\textbf{[Example of Product Notation]}",
      r"\begin{aligned} \prod_{k=1}^{4} k &= 1\cdot 2\cdot 3\cdot 4 = 24 \end{aligned}",
      r"\begin{aligned} \prod_{k=1}^{4}\frac{k}{4} &= \frac{1}{4}\cdot \frac{2}{4}\cdot \frac{3}{4}\cdot \frac{4}{4} = \frac{1\cdot 2\cdot 3\cdot 4}{4\cdot 4\cdot 4\cdot 4}\\ &= \frac{24}{256} = \frac{3}{32} \end{aligned}",
    ],
  ),
  "BCC5BF01-27BE-4D8C-8E40-8923C764BBEC": ProblemTranslation(
    category: 'Resolving Indeterminate Forms',
    level: 'Easy',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Multiply the numerator and denominator by the conjugate } \sqrt{n+1}+\sqrt{n} \text{ to resolve the indeterminate form.}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} n(\sqrt{n+1}-\sqrt{n}) &= n \cdot \frac{\sqrt{n+1}-\sqrt{n}}{1}\\ &= n \cdot \frac{(\sqrt{n+1}-\sqrt{n})(\sqrt{n+1}+\sqrt{n})}{\sqrt{n+1}+\sqrt{n}}\\ &= n \cdot \frac{(\sqrt{n+1})^2-(\sqrt{n})^2}{\sqrt{n+1}+\sqrt{n}}\\ &= n \cdot \frac{(n+1)-n}{\sqrt{n+1}+\sqrt{n}}\\ &= \frac{n}{\sqrt{n+1}+\sqrt{n}}\\ &= \frac{\sqrt{n}}{\sqrt{1+\frac{1}{n}}+1}\\ &\underset{n\to\infty}{\longrightarrow} \infty \end{aligned}",
    ],
  ),
  "1ECE1CDE-BFDC-4524-B8B5-6501A91BD8BE": ProblemTranslation(
    category: 'Comparison (Exponentials vs Polynomials)',
    level: 'Advanced',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Using ratio test, show that} \lim_{n \to \infty} \displaystyle \frac{a_{n+1}}{a_n} = \frac{1}{2}. \text{This suggests that for} n > N, a_{n+1} \leq \displaystyle \frac{3}{4}a_n. \text{Use this to apply the squeeze theorem.}",
      r"\textbf{[Solution]}",
      r"", // Placeholder for image 1
      r"", // Placeholder for image 2
      r"\text{For } a_n = \frac{n^2}{2^n}:",
      r"\begin{aligned} \frac{a_{n+1}}{a_n} &= \frac{\frac{(n+1)^2}{2^{n+1}}}{\frac{n^2}{2^n}}\\ &= \frac{1}{2}\frac{(n+1)^2}{n^2}\\ &= \frac{1}{2}\left(1+\frac{1}{n}\right)^2\\ &= \frac{1}{2} + \frac{1}{n} + \frac{1}{2n^2}\\ &\underset{n \to \infty}{\longrightarrow} \frac{1}{2} \quad \text{(monotonically decreasing)} \end{aligned}",
      r"\text{Thus, for sufficiently large } n, \text{ each term is approximately } 1/2 \text{ the previous one, and the sequence decreases.}",
      r"\text{Specifically, find } N \text{ such that } \frac{a_{n+1}}{a_n} \leq \frac{3}{4} \text{ for } n > N.",
      r"\begin{aligned} \frac{1}{2} + \frac{1}{n} + \frac{1}{2n^2} \le \frac{3}{4} &\Leftrightarrow n^2 - 4n - 2 \ge 0\\ &\Leftrightarrow n \ge 2 + \sqrt{6} \approx 4.45 \end{aligned}",
      r"\text{Therefore, for integers } n \ge 5, \text{ we always have:}",
      r"\begin{aligned} \frac{a_{n+1}}{a_n} \le \frac{3}{4} \Leftrightarrow a_{n+1} \le \frac{3}{4}a_n \end{aligned}",
      r"\text{Thus,}",
      r"\begin{aligned} 0 \le a_n \le \frac{3}{4} a_{n-1} \le \cdots \le a_5\left(\frac{3}{4}\right)^{n-5} \quad (n > 5) \end{aligned}",
      r"\text{Also, } a_5 = \frac{5^2}{2^5} = \frac{25}{32}.",
      r"\text{Since } \lim_{n\to\infty} a_5 (3/4)^{n-5} = 0, \text{ by the squeeze theorem, } \lim_{n\to\infty} a_n = \lim_{n\to\infty} \frac{n^2}{2^n} = 0.",
    ],
  ),

  // basic_limits.dart
  "701CF34C-DB84-4CD4-BD3B-0DDE311D6A0F": ProblemTranslation(
    category: 'Basic Limits',
    level: 'Easy',
    hint: r"\text{Use } \lim_{x\to 0}\frac{\sin x}{x}=1",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use } \lim_{x\to 0}\frac{\sin x}{x}=1",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \lim_{x\to 0}\frac{\sin(3x)}{x} &= \lim_{x\to 0}3\cdot \frac{\sin(3x)}{3x}\\ &= 3 \end{aligned}",
    ],
  ),
  "E5CDA38B-2CD3-4F62-AB20-2F4ECDB14681": ProblemTranslation(
    category: 'Basic Limits',
    level: 'Easy',
    steps: [
      r"\textbf{[Solution]}",
      r"\begin{aligned} \lim_{x\to 0}\frac{\tan x}{x} &= \lim_{x\to 0}\frac{\sin x}{x}\cdot \frac{1}{\cos x}\\ &= 1\cdot 1 = 1 \end{aligned}",
    ],
  ),
  "B2198AC3-050B-4F1D-B584-A2C5DC3CA60F": ProblemTranslation(
    category: 'Basic Limits',
    level: 'Easy',
    steps: [
      r"\textbf{[Solution]}",
      r"\begin{aligned} \lim_{x\to \infty} x \sin\!\left(\frac{1}{x}\right) &= \lim_{x\to \infty} \frac{\sin\!\left(\frac{1}{x}\right)}{\frac{1}{x}}\\ &= 1 \end{aligned}",
    ],
  ),
  "71ECF2CF-206F-43FF-BA35-F097D1FEB231": ProblemTranslation(
    category: 'Basic Limits',
    level: 'Easy',
    steps: [
      r"\textbf{[Solution]}",
      r"\begin{aligned} \lim_{x\to 0}\frac{1-e^{-x}}{x} &= \lim_{x\to 0}\frac{e^{x}-1}{x\,e^{x}}\\ &= \lim_{x\to 0}\frac{e^{x}-e^0}{x - 0} \lim_{x\to 0}\frac{1}{e^{x}}\\ &= (e^x)' |_{x=0} \cdot \frac{1}{1}\\ &= e^x |_{x=0} = 1 \end{aligned}",
    ],
  ),
  "8BB1FDF5-A692-41E5-9B88-E62F9E4B96BA": ProblemTranslation(
    category: 'Basic Limits',
    level: 'Mid',
    steps: [
      r"\textbf{[Solution]}",
      r"\text{Multiply the numerator and denominator by } e^x \text{ and use } \lim_{u\to 0}\frac{e^u-1}{u}=1.",
      r"\begin{aligned} \lim_{x\to 0}\frac{e^x-e^{-x}}{2x} &= \lim_{x\to 0}\frac{e^x-e^{-x}}{2x}\cdot\frac{e^x}{e^x}\\ &= \lim_{x\to 0}\frac{e^{2x}-1}{2x}\cdot\frac{1}{e^x}\\ &= 1 \cdot \frac{1}{1} = 1 \end{aligned}",
    ],
  ),
  "6D0B855E-7E52-4C1B-8A44-AA9FF0FB03B3": ProblemTranslation(
    category: 'Basic Limits',
    level: 'Easy',
    steps: [
      r"\textbf{[Point] (Let this be [1])}",
      r"\begin{aligned} \lim_{x\to 0}\frac{\log(1+x)}{x} &= \lim_{x\to 0}\frac{\log(1+x) - \log 1}{x - 0}\\ &= \log(x+1)' \Big|_{x=0}\\ &= \frac{1}{x+1} \Big|_{x=0} = 1 \end{aligned}",
      r"\textbf{[Solution]}",
      r"\text{Multiply numerator and denominator by 2.}",
      r"\begin{aligned} \lim_{x\to 0}\frac{\log(1+2x)}{x} &= \lim_{x\to 0}\frac{2\,\log(1+2x)}{2 x}\\ &= 2\,\lim_{x\to 0}\frac{\log(1+2x)}{2 x}\\ &= 2\cdot 1 = 2 \end{aligned}",
    ],
  ),
  "BB41368E-ACE1-4D11-B8A8-CEB3918B6EE5": ProblemTranslation(
    category: 'Basic Limits',
    level: 'Easy',
    hint: r"\text{This is the derivative of } f(x)=\log(1+x) \text{ at } x=0.",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{This is the derivative of } f(x)=\log(1+x) \text{ at } x=0.",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \lim_{x\to 0}\frac{\log(1+x)}{x} &= \lim_{x\to 0}\frac{\log(1+x)-\log(1+0)}{x-0}\\ &= f'(0) = (\log(1+x))' \Big|_{x=0}\\ &= \frac{1}{1+x} \Big|_{x=0} = 1 \end{aligned}",
    ],
  ),
  "CCD350BD-2E20-456F-80B5-5646A5070E7E": ProblemTranslation(
    category: 'Basic Limits',
    level: 'Easy',
    hint: r"\text{This is the derivative of } f(x)=3^x \text{ at } x=0.",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{This is the derivative of } f(x)=3^x \text{ at } x=0.",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \lim_{x\to 0}\frac{3^x-1}{x} &= \lim_{x\to 0}\frac{3^x-3^0}{x-0}\\ &= f'(0) = (3^x)' \Big|_{x=0}\\ &= (e^{x\log 3})' \Big|_{x=0} = e^{x\log 3} \cdot \log 3 \Big|_{x=0}\\ &= \log 3 \end{aligned}",
    ],
  ),
  "0DDAAC08-A9CF-4240-9166-64922F384992": ProblemTranslation(
    category: 'Limits of Sums',
    level: 'Easy',
    hint: r"\text{Use } \displaystyle \sum_{k=1}^n k^2 = \frac{n(n+1)(2n+1)}{6}.",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use } \displaystyle \sum_{k=1}^n k^2 = \frac{n(n+1)(2n+1)}{6}.",
      r"\begin{aligned} \frac{1}{n^3}\displaystyle \sum_{k=1}^n k^2 &= \frac{1}{n^3}\cdot \frac{n(n+1)(2n+1)}{6}\\ &= \frac{1}{6}\cdot \frac{2n^2+3n+1}{n^2}\\ &= \frac{1}{6}\left(2+\frac{3}{n}+\frac{1}{n^2}\right)\\ &\underset{n\to\infty}{\longrightarrow} \frac{1}{6} \cdot 2 = \frac{1}{3} \end{aligned}",
    ],
  ),
  "CECF170F-83C3-485D-B0F7-A73B2089A50B": ProblemTranslation(
    category: 'Basic Limits',
    level: 'Easy',
    steps: [
      r"\textbf{[Explanation]}",
      r"\text{By the definition of convergence of an infinite series } \displaystyle \sum_{k=1}^\infty a_k = 2 + (-2+2) + (-2+2) + \cdots, \text{ we first consider the partial sum } S_n.",
      r"\text{Here, } a_1 = 2, a_2 = 0, a_3 = 0, \ldots.",
      r"\begin{aligned} S_n &= 2+0+0+\cdots+0 = 2 \end{aligned}",
      r"\text{Thus, the sequence of partial sums } S_n \text{ is } (2, 2, 2, \ldots).",
      r"\text{Therefore, the series converges to 2.}",
    ],
  ),
  "ABE37AA2-9FEC-4ADD-9022-1A38340249F1": ProblemTranslation(
    category: 'Basic Limits',
    level: 'Easy',
    steps: [
      r"\textbf{[Explanation]}",
      r"\text{By the definition of convergence of an infinite series } \displaystyle \sum_{k=1}^\infty a_k = (2-2) + (2-2) + (2-2) + \cdots, \text{ we first consider the partial sum } S_n.",
      r"\text{Here, } a_1 = 0, a_2 = 0, a_3 = 0, \ldots.",
      r"\begin{aligned} S_n &= 0+0+\cdots+0 = 0 \end{aligned}",
      r"\text{Thus, the sequence of partial sums } S_n \text{ is } (0, 0, 0, \ldots).",
      r"\text{Therefore, the series converges to 0.}",
    ],
  ),
  "FAF62CC1-1FE8-41FC-B1B6-5151D088742A": ProblemTranslation(
    category: 'Basic Limits',
    level: 'Easy',
    answer: r"""\textcolor{green}{Diverges (oscillates)}""",
    steps: [
      r"\textbf{[Explanation]}",
      r"\text{By the definition of convergence of an infinite series } \displaystyle \sum_{k=1}^\infty a_k = 2-2+2-2+2-2+\cdots, \text{ we first consider the partial sum } S_n.",
      r"\begin{aligned} S_{2n} &= (2-2)+(2-2)+\cdots+(2-2) = 0\\ S_{2n+1} &= (2-2)+\cdots+(2-2)+2 = 2 \end{aligned}",
      r"\text{Thus, the sequence of partial sums } S_n \text{ is } (0, 2, 0, 2, \ldots), \text{ which oscillates.}",
      r"\text{Therefore, the limit does not exist (it oscillates).}",
    ],
  ),
  "E8F3C9A2-7D6A-4E4E-9B6E-XLNXLOGX001": ProblemTranslation(
    category: 'Basic Limits',
    level: 'Easy',
    hint: r"\text{Let } x = 1/t \text{ (} t \to \infty \text{).}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{As } x \to 0^+, \text{ let } x = 1/t \text{ (} t \to \infty \text{).}",
      r"\textbf{[Transformation]}",
      r"\begin{aligned} \lim_{x\to +0} x\log x &= \lim_{t\to \infty} \frac{1}{t}\log\!\left(\frac{1}{t}\right)\\ &= \lim_{t\to \infty} \frac{1}{t}(-\log t)\\ &= \lim_{t\to \infty} -\frac{\log t}{t} = 0 \end{aligned}",
      r"\textbf{[Supplement on the limit } \lim_{t\to\infty} \frac{\log t}{t} \textbf{]}",
      r"\text{For } t > 0, \log t < \sqrt{t} \text{ holds.}",
      r"\text{Thus, } 0 \le \frac{\log t}{t} < \frac{1}{\sqrt{t}} \to 0 \text{ as } t \to \infty.",
      r"\text{By the squeeze theorem,}",
      r"\lim_{t\to\infty} -\frac{\log t}{t}=0",
    ],
  ),

  // exponential_limits.dart
  "7A1F3B90-6E2C-4D8A-9B4F-1C2D3E4F5A33": ProblemTranslation(
    category: 'Limits of Gamma Functions',
    level: 'Mid',
    steps: [
      r"\textbf{[Solution]}",
      r"\begin{aligned} \int_{0}^{x}t^{5}e^{-t}\,dt &= \Bigl[-t^{5}e^{-t}\Bigr]_{0}^{x}+5\int_{0}^{x}t^{4}e^{-t}\,dt \end{aligned}",
      r"\text{At } t=0, t^{5}e^{-t}=0, \text{ so}",
      r"\begin{aligned} &= -x^{5}e^{-x}+5\int_{0}^{x}t^{4}e^{-t}\,dt \end{aligned}",
      r"\textbf{[Integration by Parts Again]}",
      r"\begin{aligned} \int_{0}^{x}t^{4}e^{-t}\,dt &= \Bigl[-t^{4}e^{-t}\Bigr]_{0}^{x}+4\int_{0}^{x}t^{3}e^{-t}\,dt \end{aligned}",
      r"\text{At } t=0, t^{4}e^{-t}=0, \text{ so}",
      r"\begin{aligned} &= -x^{4}e^{-x}+4\int_{0}^{x}t^{3}e^{-t}\,dt \end{aligned}",
      r"\text{Therefore,}",
      r"\begin{aligned} \int_{0}^{x}t^{5}e^{-t}\,dt &= -x^{5}e^{-x}+5\int_{0}^{x}t^{4}e^{-t}\,dt\\ &= -x^{5}e^{-x} + 5\Bigl(-x^{4}e^{-x} + 4\int_{0}^{x}t^{3}e^{-t}\,dt\Bigr)\\ &= -x^{5}e^{-x}-5x^{4}e^{-x} + 5 \cdot 4\int_{0}^{x}t^{3}e^{-t}\,dt \end{aligned}",
      r"\text{Similarly, we can reduce the degree of the integral from 5, 4, 3, 2, 1, 0.}",
      r"\text{Finally, we get the following form (the first term will vanish as } x \to \infty \text{):}",
      r"\begin{aligned} \int_{0}^{x}t^{5}e^{-t}\,dt &= -e^{-x}\Bigl(x^{5}+5x^{4}+5\cdot 4x^{3}+5\cdot 4\cdot 3x^{2}+5\cdot 4\cdot 3\cdot 2x+5!\Bigr)\\ &\quad +5!\int_{0}^{x}e^{-t}\,dt \end{aligned}",
      r"\textbf{[Taking } x \to \infty \textbf{]}",
      r"\text{Since } e^{-x} \text{ approaches 0 very quickly, } e^{-x} \times (\text{polynomial}) \to 0. \text{ Thus,",
      r"\begin{aligned} \lim_{x\to \infty } \int_{0}^{x}t^{5}e^{-t}\,dt &= 0 + 5!\int_{0}^{x}e^{-t}\,dt\\ &= 5!\lim_{x\to \infty } \Bigl[-e^{-t}\Bigr]_{0}^{x}\\ &= 5!\lim_{x\to \infty } (1-e^{-x})\\ &= 5!(1-0)\\ &= 120 \end{aligned}",
      r"\textbf{[Supplement: General } n \textbf{ and Gamma Function]}",
      r"\text{For a natural number } n, \text{ let } I_n(x) = \int_0^x t^n e^{-t} dt.",
      r"\text{Using integration by parts,",
      r"\begin{aligned} I_n(x) &= [-t^n e^{-t}]_0^x + n \int_0^x t^{n-1} e^{-t} dt\\ &= -x^n e^{-x} + n I_{n-1}(x) \end{aligned}",
      r"\text{By repeatedly applying this relation and taking } x \to \infty, \text{ we obtain } \lim_{x\to\infty} I_n(x) = n!.",
      r"\text{The gamma function is defined as } \Gamma(s) = \int_0^\infty t^{s-1} e^{-t} dt \text{ (} s>0 \text{).}",
      r"\text{For natural numbers } n, \Gamma(n+1) = n!.",
    ],
  ),

  // riemann_limits.dart
  "D38E0151-81F6-4A38-A100-93A0C0E7A048": ProblemTranslation(
    category: 'Riemann Sums (Geometry: Semicircle Approximation)',
    level: 'Mid',
    question:
        r"""\displaystyle \lim_{n\to\infty}\displaystyle\frac{1}{n}\displaystyle \sum_{k=-n}^{n}\sqrt{1-\left(\displaystyle\frac{k}{n}\right)^{2}}""",
    answer: r"""\displaystyle \displaystyle\frac{\pi}{2}""",
    hint: r"""\text{Use a Riemann sum and recognize the area of a semicircle.}""",
    steps: [
      r"""\textbf{[Strategy]}
\text{Interpret the sum as a Riemann sum for a definite integral.}""",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \lim_{n\to\infty}\displaystyle\frac{1}{n}\displaystyle \sum_{k=-n}^{n}\sqrt{1-\left(\displaystyle\frac{k}{n}\right)^{2}} &= \int_{-1}^{1}\sqrt{1-x^{2}}\,dx \\[6pt] &= \text{half the area of the unit circle} \\[6pt] &= \displaystyle\frac{\pi}{2} \end{aligned}",
    ],
  ),
  // basic_limits.dart (reserve / commented problems)
  "52454E1F-0119-4440-981F-4A61FDC321CC": ProblemTranslation(
    category: 'Basic Limits',
    level: 'Easy',
    question: r"""\displaystyle \lim_{x\to 0}\frac{\sin(ax)}{\sin(bx)}""",
    answer: r"""\displaystyle \displaystyle\frac{a}{b}""",
    hint:
        r"""\text{Use } \lim_{x\to 0}\displaystyle\frac{\sin x}{x}=1 \text{ and rewrite each sine term.}""",
    steps: [
      r"\textbf{[Solution]}",
      r"\begin{aligned} \lim_{x\to 0}\frac{\sin(ax)}{\sin(bx)} &= \lim_{x\to 0}\frac{\displaystyle\frac{\sin(ax)}{ax}}{\displaystyle\frac{\sin(bx)}{bx}}\cdot\frac{a}{b} \\[6pt] &= 1\cdot\frac{a}{b} \\[6pt] &= \displaystyle\frac{a}{b} \end{aligned}",
    ],
  ),
  "2D593B2A-9D37-4D7D-998E-80D6F021B76D": ProblemTranslation(
    category: 'Basic Limits',
    level: 'Mid',
    question: r"""\displaystyle \lim_{x\to 0}\frac{\sin x}{x+\sin x}""",
    answer: r"""\displaystyle \displaystyle\frac{1}{2}""",
    hint:
        r"""\text{Divide numerator and denominator by } x \text{ and use } \lim_{x\to 0}\displaystyle\frac{\sin x}{x}=1.""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Divide the numerator and denominator by } x \text{ and use } \lim_{x\to 0}\displaystyle\frac{\sin x}{x}=1.",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \lim_{x\to 0}\frac{\sin x}{x+\sin x} &= \lim_{x\to 0}\frac{\displaystyle\frac{\sin x}{x}}{1+\displaystyle\frac{\sin x}{x}} \\[6pt] &= \frac{\lim_{x\to 0}\displaystyle\frac{\sin x}{x}}{1+\lim_{x\to 0}\displaystyle\frac{\sin x}{x}} \\[6pt] &= \frac{1}{1+1} \\[6pt] &= \displaystyle\frac{1}{2} \end{aligned}",
    ],
  ),
  // advanced_limits.dart (reserve / commented problems)
  "25103264-141F-4DF2-9DA3-DD2BF7A2272C": ProblemTranslation(
    category: 'First-Order Recurrence (Geometric Transformation)',
    level: 'Easy',
    question:
        r"""a_{1}\in\mathbb{R},\ \displaystyle a_{n+1}=\displaystyle\frac{a_{n}+3}{4}.\quad \displaystyle \lim_{n\to\infty} a_{n}""",
    answer: r"""\displaystyle 1""",
    hint:
        r"""\text{Shift the sequence by } 1: \text{ let } b_n=a_n-1 \text{ to make it geometric.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the translation } b_n=a_n-1 \text{ to obtain a geometric sequence.}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} b_n &= a_n-1,\\ b_{n+1} &= \displaystyle\frac{a_n+3}{4}-1 = \displaystyle\frac{a_n-1}{4} = \displaystyle\frac{b_n}{4} \end{aligned}",
      r"\text{Therefore } b_n=b_1\left(\displaystyle\frac{1}{4}\right)^{n-1}\to 0 \text{ as } n\to\infty.",
      r"\text{Hence } a_n=b_n+1 \to 1.",
    ],
  ),
  "50932692-D037-4E74-8000-6FF211AB235B": ProblemTranslation(
    category: r"""\displaystyle \sum_{k=1}^{n}\frac{1}{k(k+1)}""",
    level: 'Mid',
    question: r"""\displaystyle \lim_{n\to\infty}\displaystyle \sum_{k=1}^{n}\frac{1}{k(k+1)}""",
    answer: r"""\displaystyle 1""",
    hint: r"""\text{Use partial fractions to make the sum telescope.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use partial fractions to create cancellation (a telescoping sum).}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \frac{1}{k(k+1)} &= \frac{1}{k}-\frac{1}{k+1} \end{aligned}",
      r"\begin{aligned} \displaystyle \sum_{k=1}^{n}\frac{1}{k(k+1)} &= \displaystyle \sum_{k=1}^{n}\left(\frac{1}{k}-\frac{1}{k+1}\right) \\[6pt] &= 1-\frac{1}{n+1} \underset{n\to\infty}{\longrightarrow} 1 \end{aligned}",
    ],
  ),
  "3879103D-98A9-482B-8D13-681E004E29EC": ProblemTranslation(
    category: 'Comparison (Logarithm vs Linear)',
    level: 'Easy',
    question: r"""\displaystyle \lim_{n\to\infty}\frac{\log n}{n}""",
    answer: r"""\displaystyle 0""",
    hint:
        r"""\text{Use } \log n=\int_{1}^{n}\displaystyle\frac{dt}{t} \text{ and compare } \displaystyle\frac{1}{t}\le \displaystyle\frac{1}{\sqrt{t}} \ (t\ge 1).""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Bound } \log n \text{ by a simpler integral, then divide by } n.",
      r"\textbf{[Solution]}",
      r"\text{For } t\ge 1, \ \displaystyle\frac{1}{t}\le \displaystyle\frac{1}{\sqrt{t}}, \text{ so}",
      r"\begin{aligned} \log n=\int_{1}^{n}\frac{dt}{t} \le \int_{1}^{n}\frac{dt}{\sqrt{t}} = 2(\sqrt{n}-1) \end{aligned}",
      r"\text{Therefore,}",
      r"\begin{aligned} 0 \le \frac{\log n}{n} \le \frac{2(\sqrt{n}-1)}{n} = \frac{2}{\sqrt{n}}-\frac{2}{n} \underset{n\to\infty}{\longrightarrow} 0 \end{aligned}",
      r"\text{By the squeeze theorem, } \displaystyle\lim_{n\to\infty}\displaystyle\frac{\log n}{n}=0.",
    ],
  ),
  "C29BEC74-56F8-4F4E-A2BD-938061967CA8": ProblemTranslation(
    category: 'Monotone Convergence (Recurrence)',
    level: 'Mid',
    question:
        r"""a_{1}\in(0,1),\ \displaystyle a_{n+1}=\sqrt{a_{n}}.\quad \displaystyle \lim_{n\to\infty} a_{n}""",
    answer: r"""\displaystyle 1""",
    hint:
        r"""\text{Show } 0<a_n<1 \text{ and } a_{n+1}\ge a_n. \text{ Then solve the limit equation } L=\sqrt{L}.""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Keep } 0<a_n<1, \text{ prove monotone increase and boundedness, then solve the fixed-point equation for the limit.}",
      r"\textbf{[Solution]}",
      r"\text{Assume } 0<a_1<1. \text{ Then } 0<a_2=\sqrt{a_1}<1.",
      r"\text{By induction, } 0<a_n<1 \text{ for all } n.",
      r"\text{Also, for } 0<a_n<1, \ \sqrt{a_n}-a_n>0, \text{ so } a_{n+1}-a_n>0. \text{ Hence } \{a_n\} \text{ is increasing.}",
      r"\text{Since } a_n<1, \{a_n\} \text{ is bounded above, so it converges: } a_n\to L \in (0,1].",
      r"\text{Taking limits in } a_{n+1}=\sqrt{a_n} \text{ gives } L=\sqrt{L}. \text{ Thus } L\in\{0,1\}.",
      r"\text{Because } L>0, \text{ we conclude } L=1.",
    ],
  ),
  // log_limits.dart
  "C9E8A1B2-4D7F-4A91-9F5C-2B6E3A1D8C77": ProblemTranslation(
    category: 'Permutation Limit',
    level: 'Mid',
    question: r"""\displaystyle \lim_{n\to\infty}\frac{1}{n}\sqrt[n]{{}_{2n}P_n}""",
    answer: r"""\displaystyle \displaystyle\frac{4}{e}""",
    hint:
        r"""\text{Take logs, convert the product to a sum, and use a Riemann sum } \to \int_{1}^{2}\log x\,dx.""",
    steps: [
      r"\textbf{[Outline]}",
      r"\text{(1) Write } {}_{2n}P_n=(n+1)(n+2)\cdots(2n) \text{ and take logs.}",
      r"\text{(2) Recognize a Riemann-sum form and evaluate the integral.}",
      r"\text{(3) Exponentiate to return from } \log.",
      r"\textbf{[Solution]}",
      r"\text{First,}",
      r"\begin{aligned} \log\!\left(\frac{1}{n}\sqrt[n]{{}_{2n}P_n}\right) &= \log\!\left(\frac{1}{n}\sqrt[n]{(n+1)(n+2)\cdots(2n)}\right) \\[6pt] &= \frac{1}{n}\displaystyle \sum_{k=n+1}^{2n}\log k - \log n \end{aligned}",
      r"\text{Using } \log k=\log n+\log\!\left(\displaystyle\frac{k}{n}\right), \text{ we get}",
      r"\begin{aligned} \frac{1}{n}\displaystyle \sum_{k=n+1}^{2n}\log k &= \log n + \frac{1}{n}\displaystyle \sum_{k=n+1}^{2n}\log\!\left(\displaystyle\frac{k}{n}\right) \end{aligned}",
      r"\text{Hence}",
      r"\begin{aligned} \log\!\left(\frac{1}{n}\sqrt[n]{{}_{2n}P_n}\right) = \frac{1}{n}\displaystyle \sum_{k=n+1}^{2n}\log\!\left(\displaystyle\frac{k}{n}\right) \end{aligned}",
      r"\text{The right-hand side is a Riemann sum, so}",
      r"\begin{aligned} \lim_{n\to\infty}\frac{1}{n}\displaystyle \sum_{k=n+1}^{2n}\log\!\left(\displaystyle\frac{k}{n}\right) &= \int_{1}^{2}\log x\,dx \\[6pt] &= [x\log x-x]_{1}^{2} \\[6pt] &= 2\log 2 - 1 \end{aligned}",
      r"\text{Therefore,}",
      r"\begin{aligned} \lim_{n\to\infty}\log\!\left(\frac{1}{n}\sqrt[n]{{}_{2n}P_n}\right) = 2\log 2 - 1 \end{aligned}",
      r"\text{Since } \log \text{ is continuous, we can also write}",
      r"""\begin{aligned}
\lim_{n\to \infty} \log\!\left(\frac{1}{n}\sqrt[n]{{}_{2n}P_n}\right)
&= \log\!\left( \lim_{n\to \infty} \frac{1}{n}\sqrt[n]{{}_{2n}P_n}\right)
\end{aligned}""",
      r"\text{Exponentiating both sides (undoing } \log\text{) gives}",
      r"\begin{aligned} \lim_{n\to\infty}\frac{1}{n}\sqrt[n]{{}_{2n}P_n} = e^{2\log 2 - 1} = \frac{4}{e} \end{aligned}",
    ],
  ),
  "26E37810-7237-4FC5-8876-910F55F7133E": ProblemTranslation(
    category: 'One-Sided Limits',
    level: 'Easy',
    question: r"""\displaystyle \lim_{x\to 0}\frac{|\sin x|}{x}""",
    answer: r"""\textbf{The limit does not exist.}""",
    hint: r"""\text{Compare the right-hand limit and the left-hand limit.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Compare the right-hand limit and the left-hand limit.}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \lim_{x\to +0}\frac{|\sin x|}{x} &= \lim_{x\to +0}\frac{\sin x}{x} = 1 \\[8pt] \lim_{x\to -0}\frac{|\sin x|}{x} &= \lim_{x\to -0}\frac{-\sin x}{x} = -1 \end{aligned}",
      r"\text{Since the one-sided limits are not equal, the limit does not exist.}",
    ],
  ),
  "2D7ED2C9-2759-46FC-B597-619EB2FA6A3B": ProblemTranslation(
    category: 'Basic Trigonometric Limits',
    level: 'Easy',
    question: r"""\displaystyle \lim_{x\to 0}\frac{1-\cos x}{x^{2}}""",
    answer: r"""\displaystyle \displaystyle\frac{1}{2}""",
    hint:
        r"""\text{Use } 1-\cos x = 2\sin^{2}\!\left(\displaystyle\frac{x}{2}\right).""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use } 1-\cos x = 2\sin^{2}\!\left(\displaystyle\frac{x}{2}\right).",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \lim_{x\to 0}\frac{1-\cos x}{x^{2}} &= \lim_{x\to 0}\frac{2\sin^{2}\!\left(\displaystyle\frac{x}{2}\right)}{x^{2}} \\[6pt] &= \lim_{x\to 0}\frac{2\sin^{2}\!\left(\displaystyle\frac{x}{2}\right)}{4\left(\displaystyle\frac{x}{2}\right)^{2}} \\[6pt] &= \lim_{x\to 0}\displaystyle\frac{1}{2}\left(\frac{\sin\left(\displaystyle\frac{x}{2}\right)}{\displaystyle\frac{x}{2}}\right)^{2} \\[6pt] &= \displaystyle\frac{1}{2}\cdot 1^{2} \\[6pt] &= \displaystyle\frac{1}{2} \end{aligned}",
    ],
  ),
  "3B2F6F76-9E2E-4C3A-A0C7-6E3C6E8B9B21": ProblemTranslation(
    category: r"""\displaystyle \lim_{n\to\infty}\sqrt{n}\int_{0}^{\frac{\pi}{2}}\sin^{n}x\,dx""",
    level: 'Advanced',
    question:
        r"""\displaystyle \lim_{n\to\infty}\sqrt{n}\,\int_{0}^{\frac{\pi}{2}}\sin^n x\,dx""",
    answer: r"""\displaystyle \sqrt{\displaystyle\frac{\pi}{2}}""",
    hint:
        r"""\text{Let } I_n=\int_{0}^{\frac{\pi}{2}}\sin^n x\,dx. \text{ Derive a recurrence and an invariant, then squeeze } \sqrt{n}\,I_n.""",
    steps: [
      r"""\textbf{[Strategy]}
\text{Let } I_n=\int_{0}^{\frac{\pi}{2}}\sin^{n}x\,dx.""",
      r"\text{(1) Derive a recurrence for } I_n \text{ by integration by parts.}",
      r"\text{(2) Build an invariant: } nI_nI_{n-1}=\frac{\pi}{2}\text{, and (3) use } I_{n+1}\le I_n \text{ to squeeze } \sqrt{n}\,I_n.",
      r"\textbf{[Solution]}",
      r"\text{Define } I_n=\displaystyle\int_{0}^{\frac{\pi}{2}}\sin^{n}x\,dx.",
      r"\textbf{[Recurrence]}",
      r"\text{Using integration by parts (treat } \sin x\,dx =-(\cos x)'\,dx\text{):}",
      r"\begin{aligned} I_n &= \int_{0}^{\frac{\pi}{2}}\sin^{n-1}x\,\sin x\,dx \\ &= -\int_{0}^{\frac{\pi}{2}}\sin^{n-1}x\,(\cos x)'\,dx \\ &= \Bigl[-\sin^{n-1}x\cos x\Bigr]_{0}^{\frac{\pi}{2}} + (n-1)\int_{0}^{\frac{\pi}{2}}\sin^{n-2}x\,\cos^{2}x\,dx \\ &= (n-1)\int_{0}^{\frac{\pi}{2}}\sin^{n-2}x\,(1-\sin^{2}x)\,dx \\ &= (n-1)(I_{n-2}-I_n) \end{aligned}",
      r"\text{Therefore,}",
      r"\begin{aligned} \boxed{I_n=\displaystyle\frac{n-1}{n}I_{n-2}} \qquad (n\ge 2) \end{aligned}",
      r"\textbf{[Constructing an Invariant]}",
      r"\text{Multiply the recurrence by } nI_{n-1}:",
      r"\begin{aligned} nI_nI_{n-1}=(n-1)I_{n-1}I_{n-2} \end{aligned}",
      r"\text{So } A_n:=nI_nI_{n-1} \text{ satisfies } A_n=A_{n-1}\ (n\ge2), \text{ hence } A_n \text{ is constant.}",
      r"\text{Compute the constant from } I_0 \text{ and } I_1:",
      r"\begin{aligned} I_0 &= \int_{0}^{\frac{\pi}{2}}1\,dx=\displaystyle\frac{\pi}{2},\\ I_1 &= \int_{0}^{\frac{\pi}{2}}\sin x\,dx=\Bigl[-\cos x\Bigr]_{0}^{\frac{\pi}{2}}=1 \end{aligned}",
      r"\text{Thus } A_1=1\cdot I_1I_0=\displaystyle\frac{\pi}{2}, \text{ and therefore }",
      r"\begin{aligned} \boxed{nI_nI_{n-1}=\displaystyle\frac{\pi}{2}} \qquad (n\ge 1) \end{aligned}",
      r"\text{In particular, replacing } n \text{ by } n+1:",
      r"\begin{aligned} \boxed{(n+1)I_{n+1}I_n=\displaystyle\frac{\pi}{2}} \qquad (n\ge 0) \end{aligned}",
      r"\textbf{[Squeeze]}",
      r"\text{On } \left[0,\displaystyle\frac{\pi}{2}\right], \text{ we have } 0\le \sin x\le 1, \text{ so } \sin^{n+1}x\le \sin^{n}x. \text{ Hence } I_{n+1}\le I_n.",
      r"\text{Using } nI_nI_{n-1}=\displaystyle\frac{\pi}{2} \text{ and } I_{n-1}\ge I_n,",
      r"\begin{aligned} \displaystyle\frac{\pi}{2}=nI_nI_{n-1}\ge nI_n^{2} \end{aligned}",
      r"\text{so}",
      r"\begin{aligned} \sqrt{n}\,I_n \le \sqrt{\displaystyle\frac{\pi}{2}} \end{aligned}",
      r"\text{Also, using } (n+1)I_{n+1}I_n=\displaystyle\frac{\pi}{2} \text{ and } I_{n+1}\le I_n,",
      r"\begin{aligned} \displaystyle\frac{\pi}{2}=(n+1)I_{n+1}I_n \le (n+1)I_n^{2} \end{aligned}",
      r"\text{so}",
      r"\begin{aligned} \sqrt{\displaystyle\frac{\pi}{2}} \le \sqrt{n+1}\,I_n \quad\Rightarrow\quad \sqrt{\displaystyle\frac{n}{n+1}}\sqrt{\displaystyle\frac{\pi}{2}} \le \sqrt{n}\,I_n \end{aligned}",
      r"\text{Since } \lim_{n\to\infty}\sqrt{\displaystyle\frac{n}{n+1}}=1, \text{ by the squeeze theorem,}",
      r"\begin{aligned} \lim_{n\to\infty}\sqrt{n}\,I_n=\sqrt{\displaystyle\frac{\pi}{2}} \end{aligned}",
      r"\text{Therefore, } \displaystyle \lim_{n\to\infty}\sqrt{n}\,\int_{0}^{\frac{\pi}{2}}\sin^{n}x\,dx=\sqrt{\displaystyle\frac{\pi}{2}}.",
    ],
  ),
  "4647C909-D762-4F20-9CA7-A575D58640B2": ProblemTranslation(
    category: 'Harmonic Series (Difference of Partial Sums)',
    level: 'Advanced',
    question:
        r"""\displaystyle \lim_{n\to\infty}\left(\displaystyle \sum_{k=1}^{2n}\frac{1}{k}-\displaystyle \sum_{k=1}^{n}\frac{1}{k}\right)""",
    answer: r"""\displaystyle \log 2""",
    hint:
        r"""\text{Rewrite as } \displaystyle \sum_{k=n+1}^{2n}\displaystyle\frac{1}{k} \text{ and compare with } \int\displaystyle\frac{dx}{x}.""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Bound } \displaystyle \sum_{k=n+1}^{2n}\frac{1}{k} \text{ using integrals of } \displaystyle\frac{1}{x}.",
      r"\textbf{[Solution]}",
      r"\text{Note that } \displaystyle \sum_{k=1}^{2n}\displaystyle\frac{1}{k}-\displaystyle \sum_{k=1}^{n}\displaystyle\frac{1}{k}=\displaystyle \sum_{k=n+1}^{2n}\displaystyle\frac{1}{k}.",
      r"\begin{aligned} \int_{n}^{2n}\frac{dx}{x} &\le \displaystyle \sum_{k=n+1}^{2n}\frac{1}{k} \\[4pt] &\le \int_{n-1}^{2n-1}\frac{dx}{x} \end{aligned}",
      r"\text{Therefore,}",
      r"\begin{aligned} \log 2 \le \displaystyle \sum_{k=n+1}^{2n}\frac{1}{k} \le \log\!\left(\displaystyle\frac{2n-1}{n-1}\right) \end{aligned}",
      r"\text{Since } \log\!\left(\displaystyle\frac{2n-1}{n-1}\right)\to \log 2, \text{ the squeeze theorem gives } \lim_{n\to\infty}\displaystyle \sum_{k=n+1}^{2n}\displaystyle\frac{1}{k}=\log 2.",
    ],
  ),
  "774E49FD-A51A-4756-916A-52C94A3810BA": ProblemTranslation(
    category: 'Rationalization',
    level: 'Easy',
    question: r"""\displaystyle \lim_{x\to 0}\frac{\sqrt{1+x}-1}{x}""",
    answer: r"""\displaystyle \displaystyle\frac{1}{2}""",
    hint: r"""\text{Multiply by the conjugate } \sqrt{1+x}+1.""",
    steps: [
      r"\textbf{[Solution]}",
      r"\begin{aligned} \lim_{x\to 0}\frac{\sqrt{1+x}-1}{x} &= \lim_{x\to 0}\frac{(\sqrt{1+x}-1)(\sqrt{1+x}+1)}{x(\sqrt{1+x}+1)} \\[6pt] &= \lim_{x\to 0}\frac{x}{x(\sqrt{1+x}+1)} \\[6pt] &= \lim_{x\to 0}\frac{1}{\sqrt{1+x}+1} \\[6pt] &= \frac{1}{2} \end{aligned}",
    ],
  ),
  "4B230368-1412-4DCA-A4BB-F20858B287B8": ProblemTranslation(
    category: 'Extracting Higher-Order Terms (Logarithms)',
    level: 'Mid',
    question:
        r"""\displaystyle \lim_{x\to 0}\frac{\log(1+x)-x+\frac{x^{2}}{2}}{x^{3}}""",
    answer: r"""\displaystyle \displaystyle\frac{1}{3}""",
    hint:
        r"""\text{Use inequalities for } \log(1+x) \text{ (e.g., an upper bound } x-\displaystyle\frac{x^{2}}{2}+\displaystyle\frac{x^{3}}{3}\text{) to squeeze.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Squeeze } \log(1+x) \text{ between polynomial bounds and divide by } x^{3}.",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \frac{\log(1+x)-x+\frac{x^{2}}{2}}{x^{3}} \to \displaystyle\frac{1}{3} \quad \text{(prove by bounding from both sides)} \end{aligned}",
    ],
  ),
  "F7C0451B-E946-4AB6-90C4-A3B539CE4A1D": ProblemTranslation(
    category: 'Rationalization',
    level: 'Easy',
    question: r"""\displaystyle \lim_{n\to\infty}\sqrt{n^{2}+n}-n""",
    answer: r"""\displaystyle \displaystyle\frac{1}{2}""",
    hint:
        r"""\text{Multiply by the conjugate } \sqrt{n^{2}+n}+n \text{ to remove the indeterminate form.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Multiply by the conjugate } \sqrt{n^{2}+n}+n \text{ and simplify.}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \sqrt{n^{2}+n}-n &= \frac{\left(\sqrt{n^{2}+n}-n\right)\left(\sqrt{n^{2}+n}+n\right)}{\sqrt{n^{2}+n}+n} \\[6pt] &= \frac{n^{2}+n-n^{2}}{\sqrt{n^{2}+n}+n} \\[6pt] &= \frac{n}{\sqrt{n^{2}+n}+n} \\[6pt] &= \frac{1}{\sqrt{1+\frac{1}{n}}+1} \underset{n\to\infty}{\longrightarrow} \frac{1}{1+1}=\frac{1}{2} \end{aligned}",
    ],
  ),
  "4E839CEA-B995-4D8D-812D-C23546487B0E": ProblemTranslation(
    category: 'Harmonic Series',
    level: 'Advanced',
    question: r"""\displaystyle \lim_{n\to\infty}\displaystyle \sum_{k=1}^{n}\frac{1}{k}""",
    answer: r"""\displaystyle \infty \text{ (diverges)}""",
    hint:
        r"""\text{Use the integral test: } \displaystyle \sum_{k=1}^{n}\displaystyle\frac{1}{k}\ge \int_{1}^{n+1}\displaystyle\frac{1}{x}\,dx.""",
    steps: [
      r"\textbf{[Proof 1: Integral Test]}",
      r"\text{(Blue area)} < \text{(red area)}\text{, so}",
      r"",
      r"\text{Using the integral test,}",
      r"\begin{aligned} \displaystyle \sum_{k=1}^{n}\frac{1}{k} &\ge \int_{1}^{n+1}\frac{1}{x}\,dx \\[6pt] &= [\log x]_{1}^{n+1} \\[6pt] &= \log(n+1) \end{aligned}",
      r"\text{Therefore, } \log(n+1) \le \displaystyle \sum_{k=1}^{n}\frac{1}{k}.",
      r"\text{Since } \log(n+1)\to\infty \text{ as } n\to\infty, \text{ the harmonic series diverges.}",
      r"\textbf{[Proof 2: Lower Bound for Partial Sums]}",
      r"\begin{aligned} \displaystyle \sum_{k=1}^{2^{n}}\frac{1}{k} &= 1 + \frac{1}{2} + \left(\frac{1}{3}+\frac{1}{4}\right) + \left(\frac{1}{5}+\cdots+\frac{1}{8}\right) + \cdots + \left(\frac{1}{2^{n-1}+1}+\cdots+\frac{1}{2^{n}}\right) \\[6pt] &\ge 1 + \frac{1}{2} + 2\cdot\frac{1}{4} + 4\cdot\frac{1}{8} + \cdots + 2^{n-1}\cdot\frac{1}{2^{n}} \\[6pt] &= 1 + \frac{n}{2} \end{aligned}",
      r"\text{Since } 1+\displaystyle\frac{n}{2}\to\infty, \text{ the harmonic series diverges.}",
      r"\textbf{[Note]}",
      r"\text{This series is called the harmonic series.}",
    ],
  ),
  "A39DF72B-47BA-473A-83D4-5D35E8ADD533": ProblemTranslation(
    category: 'Logarithmic Transformation',
    level: 'Mid',
    question: r"""\displaystyle \lim_{n\to\infty}\sqrt[n]{n}""",
    answer: r"""\displaystyle 1""",
    hint: r"""\text{Take logarithms and use } \displaystyle\frac{\log n}{n}\to 0.""",
    steps: [
      r"\textbf{[Solution]}",
      r"\text{Taking logarithms, } \log\sqrt[n]{n} = \log(n^{1/n}) = \displaystyle \frac{\log n}{n} \ \underset{n\to\infty}{\longrightarrow} \ 0 \cdots (1)",
      r"\text{Therefore, the inside of } \log \text{ converges to } 1\text{. Hence } \lim_{n\to\infty}\sqrt[n]{n}=1\text{.}",
      r"",
      r"\textbf{[Supplement: Property of Continuous Functions]}",
      r"\text{In general, for a continuous function } f\text{, we have } \lim_{n\to\infty} f(a_n) = f\!\left(\lim_{n\to\infty} a_n\right)\text{.}",
      r"\text{In this problem, by continuity of } \log\text{:}",
      r"\lim_{n\to\infty} \log(\sqrt[n]{n}) = \log\!\left(\lim_{n\to\infty} \sqrt[n]{n}\right)",
      r"\text{By (1), this value is }0\text{, so } \log\!\left(\lim_{n\to\infty} \sqrt[n]{n}\right) = 0\text{.}",
      r"\text{Therefore, } \lim_{n\to\infty} \sqrt[n]{n} = 1\text{.}",
    ],
  ),
  "9A2E7C44-1B3A-4D7B-9E7F-2E3C1F6B8C10": ProblemTranslation(
    category: 'Trigonometric \u00d7 Geometric Series',
    level: 'Mid',
    question:
        r"""\displaystyle \sum_{k=1}^{\infty}\frac{1}{2^{k}}\sin\!\left(\displaystyle\frac{2k\pi}{3}\right)""",
    answer: r"""\displaystyle \displaystyle\frac{\sqrt{3}}{7}""",
    hint:
        r"""\text{The values of } \sin\!\left(\displaystyle\frac{2k\pi}{3}\right) \text{ are periodic with period } 3. \text{ Compare } S_{3M}, S_{3M+1}, S_{3M+2}.""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Consider the partial sum } S_N=\displaystyle \sum_{k=1}^{N}\displaystyle\frac{1}{2^{k}}\sin\!\left(\displaystyle\frac{2k\pi}{3}\right) \text{ and split into } N=3M,3M+1,3M+2.",
      r"\textbf{[Solution]}",
      r"\text{Since } \sin\!\left(\displaystyle\frac{2k\pi}{3}\right) \text{ has period } 3:",
      r"\begin{aligned} \sin\!\left(\displaystyle\frac{2k\pi}{3}\right)=\begin{cases} \displaystyle\frac{\sqrt3}{2} & (k\equiv 1\ (\mathrm{mod}\ 3))\\[6pt] -\displaystyle\frac{\sqrt3}{2} & (k\equiv 2\ (\mathrm{mod}\ 3))\\[6pt] 0 & (k\equiv 0\ (\mathrm{mod}\ 3)) \end{cases} \end{aligned}",
      r"\textbf{[1] Case } N=3M:",
      r"""\begin{aligned}
S_{3M}
&= \displaystyle \sum_{m=0}^{M-1}\left(\frac{1}{2^{3m+1}}\cdot\frac{\sqrt3}{2}+\frac{1}{2^{3m+2}}\cdot\left(-\frac{\sqrt3}{2}\right)+\frac{1}{2^{3m+3}}\cdot 0\right)\\
&= \frac{\sqrt3}{2}\displaystyle \sum_{m=0}^{M-1}\left(\frac{1}{2^{3m+1}}-\frac{1}{2^{3m+2}}\right)
\end{aligned}""",
      r"\text{Here, } \displaystyle \frac{1}{2^{3m+1}}-\frac{1}{2^{3m+2}}=\frac{1}{2^{3m+2}}\text{, so}",
      r"""\begin{aligned}
S_{3M}
&= \frac{\sqrt3}{2}\displaystyle \sum_{m=0}^{M-1}\frac{1}{2^{3m+2}}
= \frac{\sqrt3}{8}\displaystyle \sum_{m=0}^{M-1}\left(\frac{1}{8}\right)^m
\end{aligned}""",
      r"""\begin{aligned}
S_{3M}
&= \frac{\sqrt3}{8}\cdot\frac{1-(\frac18)^M}{1-\frac18}
= \frac{\sqrt3}{7}\left(1-\left(\frac{1}{8}\right)^M\right)
\end{aligned}""",
      r"\text{Hence } \lim_{M\to\infty}S_{3M}=\displaystyle\frac{\sqrt3}{7}.",
      r"\textbf{[2] Case } N=3M+1:",
      r"\begin{aligned} S_{3M+1} &= S_{3M}+\frac{1}{2^{3M+1}}\cdot\frac{\sqrt3}{2} = S_{3M}+\frac{\sqrt3}{2^{3M+2}} \end{aligned}",
      r"\text{So } \lim_{M\to\infty}S_{3M+1}=\displaystyle\frac{\sqrt3}{7}.",
      r"\textbf{[3] Case } N=3M+2:",
      r"\begin{aligned} S_{3M+2} &= S_{3M+1}+\frac{1}{2^{3M+2}}\cdot\left(-\frac{\sqrt3}{2}\right) = S_{3M+1}-\frac{\sqrt3}{2^{3M+3}} \end{aligned}",
      r"\text{So } \lim_{M\to\infty}S_{3M+2}=\displaystyle\frac{\sqrt3}{7}.",
      r"\text{Therefore, the sequence of partial sums converges and}",
      r"\begin{aligned} \displaystyle \sum_{k=1}^{\infty}\frac{1}{2^{k}}\sin\!\left(\displaystyle\frac{2k\pi}{3}\right)=\displaystyle\frac{\sqrt3}{7} \end{aligned}",
    ],
  ),
  "A4F3C2D1-7B6E-4C2A-9E3B-1D8C0E7F5A12": ProblemTranslation(
    category: 'Limit of \(\log(n!)\)',
    level: 'Advanced',
    question: r"""\displaystyle \lim_{n\to\infty}\frac{\log(n!)}{n\log n-n}""",
    answer: r"""\displaystyle 1""",
    hint:
        r"""\text{Write } \log(n!)=\displaystyle \sum_{k=1}^{n}\log k \text{ and squeeze it using } \int \log x\,dx.""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{(1) Let } \log(n!)=\displaystyle \sum_{k=1}^{n}\log k\text{.}",
      r"\text{(2) Use integral bounds for the increasing function } \log x \text{ to squeeze } \sum \log k\text{.}",
      r"\text{(3) Divide by the main term } n\log n-n \text{ and apply the squeeze theorem.}",
      r"\textbf{[Solution]}",
      r"\text{Let } S_n:=\log(n!)=\displaystyle \sum_{k=1}^{n}\log k\text{.}",
      r"\textbf{[Integral Squeeze]}",
      r"\text{The function } f(x)=\log x \text{ is increasing for } x>0\text{.}",
      r"\text{Hence, for each } k\ge 1 \text{ and } x\in[k,k+1]\text{, we have } \log k \le \log x \le \log(k+1)\text{.}",
      r"\text{Integrating over }[k,k+1]\text{ gives}",
      r"""\begin{aligned}
\log k
&\le \int_k^{k+1}\log x\,dx
\le \log(k+1).
\end{aligned}""",
      r"\text{Summing this for }k=1,2,\dots,n\text{ yields}",
      r"""\begin{aligned}
\displaystyle \sum_{k=1}^n \log k
&\le \int_{1}^{n+1}\log x\,dx
\le \displaystyle \sum_{k=1}^n \log(k+1).
\end{aligned}""",
      r"\text{The rightmost sum equals } \displaystyle \sum_{k=1}^n\log(k+1)=\displaystyle \sum_{j=2}^{n+1}\log j=\log((n+1)!)\text{. Hence}",
      r"""\boxed{\displaystyle
\log(n!)\le \int_{1}^{n+1}\log x\,dx \le \log((n+1)!)
}""",
      r"\text{Similarly, using intervals }[k-1,k]\text{, we also get } \int_{1}^{n}\log x\,dx \le \log(n!)\text{.}",
      r"\text{Therefore}",
      r"""\boxed{\displaystyle
\int_{1}^{n}\log x\,dx \le \log(n!)\le \int_{1}^{n+1}\log x\,dx
}""",
      r"\textbf{[Compute the integrals]}",
      r"\text{Since } \int \log x\,dx = x\log x - x + C\text{,}",
      r"""\begin{aligned}
\int_{1}^{n}\log x\,dx
&=\bigl[x\log x-x\bigr]_{1}^{n}
= n\log n-n+1,\\
\int_{1}^{n+1}\log x\,dx
&=\bigl[x\log x-x\bigr]_{1}^{n+1}
=(n+1)\log(n+1)-(n+1)+1.
\end{aligned}""",
      r"\text{Hence}",
      r"""\begin{aligned}
n\log n-n+1
\le \log(n!)
\le (n+1)\log(n+1)-(n+1)+1.
\end{aligned}""",
      r"\textbf{[Divide and Squeeze]}",
      r"\text{Divide by } n\log n-n \ (>0)\text{:}",
      r"""\begin{aligned}
\frac{n\log n-n+1}{n\log n-n}
\le \frac{\log(n!)}{n\log n-n}
\le \frac{(n+1)\log(n+1)-(n+1)+1}{n\log n-n}.
\end{aligned}""",
      r"\text{The left-hand side is } 1+\displaystyle\frac{1}{n\log n-n}\to 1\ (n\to\infty)\text{.}",
      r"\text{For the right-hand side, use } \log(n+1)=\log n+\log\!\left(1+\frac1n\right)\text{ to rewrite it:}",
      r"""\begin{aligned}
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
&=1+0+0+0=1.
\end{aligned}""",
      r"\text{Therefore}",
      r"""\boxed{\displaystyle 
\lim_{n\to\infty}\frac{(n+1)\log(n+1)-(n+1)+1}{n\log n-n}=1
}""",
      r"\text{So the right-hand bound also tends to }1\text{.}",
      r"\text{Hence, by the squeeze theorem,}",
      r"""\boxed{\displaystyle \lim_{n\to\infty}\frac{\log(n!)}{n\log n-n}=1}""",
    ],
  ),
  "6C703101-29A6-4005-87D6-594F60194AFC": ProblemTranslation(
    category: 'Riemann Sums (Cosine)',
    level: 'Advanced',
    question:
        r"""\displaystyle \lim_{n\to\infty}\displaystyle\frac{1}{n}\displaystyle \sum_{k=0}^{2n}\cos\!\left(\displaystyle\frac{\pi k}{n}\right)""",
    answer: r"""\displaystyle 0""",
    hint: r"""\text{Use a Riemann sum for } \int_{0}^{2}\cos(\pi x)\,dx.""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use Riemann sums.}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} &\lim_{n\to\infty}\displaystyle\frac{1}{n}\displaystyle \sum_{k=0}^{2n}\cos\!\left(\displaystyle\frac{\pi k}{n}\right) \\[6pt] =& \lim_{n\to\infty}\displaystyle\frac{1}{n}\displaystyle \sum_{k=0}^{2n}\cos\!\left(\pi\cdot\displaystyle\frac{k}{n}\right) \\[6pt] =& \int_{0}^{2}\cos(\pi x)\,dx \\[6pt] =& \left[\displaystyle\frac{1}{\pi}\sin(\pi x)\right]_{0}^{2} \\[6pt] =& \displaystyle\frac{1}{\pi}(\sin(2\pi)-\sin 0) \\[6pt] =& 0 \end{aligned}",
    ],
  ),
  "E9F0A1B2-C3D4-5E6F-7A8B-9C0D1E2F3A4B": ProblemTranslation(
    category: 'Limit of Integrals (Squeeze Theorem)',
    level: 'Advanced',
    question:
        r"""\displaystyle \lim_{n\to\infty}\int_{0}^{\displaystyle\frac{\pi}{4}}\tan^{2n}x\,dx""",
    answer: r"""\displaystyle 0""",
    hint:
        r"""\text{Compare } \tan x \text{ with the line } y=\displaystyle\frac{4x}{\pi} \text{ on } \left[0,\displaystyle\frac{\pi}{4}\right].""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Compare with the line } y=\displaystyle\frac{4x}{\pi} \text{ and apply the squeeze theorem.}",
      r"\textbf{[Solution]}",
      r"\text{First, we use the following proposition:}",
      r"\textbf{[Proposition]}",
      r"\text{For } 0 \le x \le \displaystyle\frac{\pi}{4}, \text{ we have } \tan x \le \displaystyle\frac{4x}{\pi}.",
      r"\text{By this proposition, for } 0 \le x \le \displaystyle\frac{\pi}{4}\text{,}",
      r"\text{Then, for } 0 \le x \le \displaystyle\frac{\pi}{4}:",
      r"\begin{aligned} 0 \le \tan^{2n}x \le \left(\displaystyle\frac{4x}{\pi}\right)^{2n} \end{aligned}",
      r"\text{Therefore,}",
      r"\begin{aligned} 0 \le \int_{0}^{\displaystyle\frac{\pi}{4}}\tan^{2n}x\,dx &\le \int_{0}^{\displaystyle\frac{\pi}{4}}\left(\displaystyle\frac{4x}{\pi}\right)^{2n}\,dx \\[6pt] &= \left(\displaystyle\frac{4}{\pi}\right)^{2n}\int_{0}^{\displaystyle\frac{\pi}{4}}x^{2n}\,dx \\[6pt] &= \left(\displaystyle\frac{4}{\pi}\right)^{2n}\cdot \displaystyle\frac{\left(\displaystyle\frac{\pi}{4}\right)^{2n+1}}{2n+1} \\[6pt] &= \displaystyle\frac{\pi}{4(2n+1)} \end{aligned}",
      r"\text{So we obtain:}",
      r"\begin{aligned} 0 < \int_{0}^{\displaystyle\frac{\pi}{4}}\tan^{2n}x\,dx < \displaystyle\frac{\pi}{4(2n+1)} \end{aligned}",
      r"\text{Since } \displaystyle\frac{\pi}{4(2n+1)}\to 0 \text{ as } n\to\infty,",
      r"\text{the squeeze theorem gives } \lim_{n\to\infty}\int_{0}^{\displaystyle\frac{\pi}{4}}\tan^{2n}x\,dx = 0.",
      r"\textbf{[Proof of Proposition]}",
      r"\text{On } \left[0,\displaystyle\frac{\pi}{4}\right], \text{ we have } \displaystyle\frac{d^2}{dx^2}(\tan x)=\displaystyle\frac{2\sin x}{\cos^{3}x}\ge 0.",
      r"\text{Thus } \tan x \text{ is convex on this interval, so it lies below the chord connecting } (0,0) \text{ and } \left(\displaystyle\frac{\pi}{4},1\right), \text{ i.e., below } y=\displaystyle\frac{4x}{\pi}.",
    ],
  ),
  // problems_e_limit_variations.dart
  "1E209006-69B2-4DAE-8B9D-036D1800D855": ProblemTranslation(
    category: 'Limits Defining \(e\)',
    level: 'Easy',
    question: r"""\displaystyle \lim_{h\to 0}(1+2h)^{\frac{1}{h}}""",
    answer: r"""\displaystyle e^{2}""",
    hint:
        r"""\text{Rewrite } (1+2h)^{\frac{1}{h}}=\left((1+2h)^{\frac{1}{2h}}\right)^{2}\text{ and use } e=\lim_{h\to 0}(1+h)^{\frac{1}{h}}.""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Rewrite the expression so that the definition of } e \text{ applies.}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \lim_{h\to 0}(1+2h)^{\frac{1}{h}} &= \lim_{h\to 0}\left((1+2h)^{\frac{1}{2h}}\right)^{2} \\[6pt] &= \left(\lim_{h\to 0}(1+2h)^{\frac{1}{2h}}\right)^{2} \end{aligned}",
      r"\text{As } h\to 0, \text{ we have } 2h\to 0, \text{ so by the definition } e=\lim_{h\to 0}(1+h)^{\frac{1}{h}}, \text{ we get } \lim_{h\to 0}(1+2h)^{\frac{1}{2h}}=e.",
      r"\begin{aligned} \therefore \lim_{h\to 0}(1+2h)^{\frac{1}{h}} &= e^{2} \end{aligned}",
    ],
  ),
  "3444E69A-5FCB-43A5-8C70-54616A1226D6": ProblemTranslation(
    category: 'Limits Defining \(e\)',
    level: 'Easy',
    question: r"""\displaystyle \lim_{h\to 0}(1+h)^{\frac{1}{h}}""",
    answer: r"""\displaystyle e""",
    hint: r"""\text{This is the definition of } e.""",
    steps: [
      r"\textbf{[Definition]}",
      r"\begin{aligned} \boxed{e=\lim_{h\to 0}(1+h)^{\frac{1}{h}}} \end{aligned}",
      r"\text{The expression is exactly the definition of the base of the natural logarithm } e.",
    ],
  ),
  "369BD639-C54E-4847-93A1-3B56E19006A2": ProblemTranslation(
    category: 'Limits Defining \(e\)',
    level: 'Easy',
    question: r"""\displaystyle \lim_{x\to \infty}\left(1+\frac{1}{x}\right)^{x}""",
    answer: r"""\displaystyle e""",
    hint:
        r"""\text{Use the substitution } h=\displaystyle\frac{1}{x} \text{ so that } h\to +0 \text{ and apply the definition of } e.""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the substitution } h=\displaystyle\frac{1}{x} \text{ to reduce to the definition of } e.",
      r"\textbf{[Solution]}",
      r"\text{Let } h=\displaystyle\frac{1}{x}. \text{ Then } x\to\infty \Rightarrow h\to +0 \text{ and } x=\displaystyle\frac{1}{h}.",
      r"\begin{aligned} \lim_{x\to \infty}\left(1+\frac{1}{x}\right)^{x} &= \lim_{h\to +0}(1+h)^{\frac{1}{h}} \\[6pt] &= e \end{aligned}",
      r"\text{Since the limit defining } e \text{ does not depend on the direction of approach, } \lim_{h\to +0}(1+h)^{\frac{1}{h}}=e.",
    ],
  ),
  "38DF36DC-0268-4E1D-A341-14A39DDE8543": ProblemTranslation(
    category: 'Limits Defining \(e\)',
    level: 'Easy',
    question: r"""\displaystyle \lim_{x\to -\infty}\left(1+\frac{1}{x}\right)^{x}""",
    answer: r"""\displaystyle e""",
    hint:
        r"""\text{Use a substitution to reduce to } \lim_{h\to 0}(1+h)^{\frac{1}{h}}.""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use a change of variables to reduce to the definition of } e.",
      r"\textbf{[Solution]}",
      r"\text{Let } t=-x. \text{ Then } x\to -\infty \Rightarrow t\to \infty.",
      r"\begin{aligned} \lim_{x\to -\infty}\left(1+\frac{1}{x}\right)^{x} &= \lim_{t\to \infty}\left(1-\displaystyle\frac{1}{t}\right)^{-t} \\[6pt] &= \lim_{t\to \infty}\left(\displaystyle\frac{t-1}{t}\right)^{-t} \\[6pt] &= \lim_{t\to \infty}\left(\displaystyle\frac{t}{t-1}\right)^{t} \\[6pt] &= \lim_{t\to \infty}\left(1+\displaystyle\frac{1}{t-1}\right)^{t} \\[6pt] &= \lim_{t\to \infty}\left(1+\displaystyle\frac{1}{t-1}\right)^{t-1}\cdot\left(1+\displaystyle\frac{1}{t-1}\right) \end{aligned}",
      r"\text{The second factor } \left(1+\displaystyle\frac{1}{t-1}\right)\to 1 \text{ as } t\to\infty\text{.}",
      r"\text{Let } u=t-1. \text{ Then } u\to\infty \text{ and } \left(1+\displaystyle\frac{1}{t-1}\right)=\left(1+\displaystyle\frac{1}{u}\right)\to 1.",
      r"\begin{aligned} \lim_{x\to -\infty}\left(1+\frac{1}{x}\right)^{x} &= \left(\lim_{u\to\infty}\left(1+\displaystyle\frac{1}{u}\right)^{u}\right)\cdot 1 \\[6pt] &= \left(\lim_{h\to +0}(1+h)^{\frac{1}{h}}\right)\cdot 1 \\[6pt] &= e \end{aligned}",
    ],
  ),
  "53BC96C5-2D01-45FE-9A39-F369BA9E2097": ProblemTranslation(
    category: 'Limits Defining \(e\)',
    level: 'Easy',
    question: r"""\displaystyle \lim_{x\to \infty}\left(1+\frac{1}{x}\right)^{2x}""",
    answer: r"""\displaystyle e^{2}""",
    hint:
        r"""\text{Use } h=\displaystyle\frac{1}{x} \text{ and rewrite as } \left((1+h)^{\frac{1}{h}}\right)^2.""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Reduce to the definition of } e \text{ by substituting } h=\displaystyle\frac{1}{x}.",
      r"\textbf{[Solution]}",
      r"\text{Let } h=\displaystyle\frac{1}{x}. \text{ Then } x\to\infty \Rightarrow h\to +0 \text{ and } x=\displaystyle\frac{1}{h}.",
      r"\begin{aligned} \lim_{x\to \infty}\left(1+\frac{1}{x}\right)^{2x} &= \lim_{h\to +0}(1+h)^{\frac{2}{h}} \\[6pt] &= \lim_{h\to +0}\left((1+h)^{\frac{1}{h}}\right)^{2} \end{aligned}",
      r"\text{So the limit is } \left(\lim_{h\to 0}(1+h)^{\frac{1}{h}}\right)^2\text{.}",
      r"\text{Since } \lim_{h\to 0}(1+h)^{\frac{1}{h}}=e, \text{ the same holds for } h\to +0, \text{ hence}",
      r"\begin{aligned} \lim_{x\to \infty}\left(1+\frac{1}{x}\right)^{2x} &= e^{2} \end{aligned}",
    ],
  ),
  "E03C5F81-3445-4D78-8BC7-9BDD3EF528CD": ProblemTranslation(
    category: 'Limits via Logarithms',
    level: 'Easy',
    question: r"""\displaystyle \lim_{h\to +0}\left(1+\frac{1}{h}\right)^{h}""",
    answer: r"""\displaystyle 1""",
    hint:
        r"""\text{Take logarithms and show the log tends to } 0, \text{ then exponentiate.}""",
    steps: [
      r"""\textbf{[Strategy]}
\text{Take logarithms and evaluate the limit of the exponent. If the logarithm tends to } 0, \text{ then the original limit is } e^{0}=1.""",
      r"\textbf{[Solution]}",
      r"\text{Let } u=\displaystyle\frac{1}{h}. \text{ Then } h\to +0 \Rightarrow u\to +\infty \text{ and } h=\displaystyle\frac{1}{u}.",
      r"\text{Thus } \lim_{h\to +0}\left(1+\frac{1}{h}\right)^{h}=\lim_{u\to\infty}(1+u)^{\frac{1}{u}}.",
      r"\text{Take logarithms:}",
      r"\begin{aligned} \log\left(\lim_{u\to\infty}(1+u)^{\frac{1}{u}}\right) &= \lim_{u\to\infty}\log\left((1+u)^{\frac{1}{u}}\right) \\[6pt] &= \lim_{u\to\infty}\displaystyle\frac{\log(1+u)}{u} \end{aligned}",
      r"\text{Write } \displaystyle\frac{\log(1+u)}{u}=\displaystyle\frac{\log(1+u)}{1+u}\cdot\displaystyle\frac{1+u}{u}.",
      r"\text{Using } \lim_{u\to\infty}\displaystyle\frac{\log(1+u)}{1+u}=0 \text{ and } \lim_{u\to\infty}\displaystyle\frac{1+u}{u}=1, \text{ we get } \lim_{u\to\infty}\displaystyle\frac{\log(1+u)}{u}=0.",
      r"\text{Therefore } \log\left(\lim_{u\to\infty}(1+u)^{\frac{1}{u}}\right)=0, \text{ so } \lim_{u\to\infty}(1+u)^{\frac{1}{u}}=1.",
    ],
  ),
  "9161EDD7-12DE-4729-A2A7-9A55E060C466": ProblemTranslation(
    category: 'Limits via Logarithms',
    level: 'Easy',
    question: r"""\displaystyle \lim_{h\to \infty}(1+h)^{\frac{1}{h}}""",
    answer: r"""\displaystyle 1""",
    hint:
        r"""\text{Take logarithms and show } \displaystyle\frac{\log(1+h)}{h}\to 0, \text{ then exponentiate.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Take logarithms and evaluate } \displaystyle\frac{\log(1+h)}{h}. \text{ Then use continuity of the exponential function.}",
      r"\textbf{[Solution]}",
      r"\text{Take logarithms:}",
      r"\begin{aligned} \log\left(\lim_{h\to\infty}(1+h)^{\frac{1}{h}}\right) &= \lim_{h\to\infty}\log\left((1+h)^{\frac{1}{h}}\right) \\[6pt] &= \lim_{h\to\infty}\displaystyle\frac{\log(1+h)}{h} \end{aligned}",
      r"\text{Rewrite } \displaystyle\frac{\log(1+h)}{h}=\displaystyle\frac{\log(1+h)}{1+h}\cdot\displaystyle\frac{1+h}{h}.",
      r"\text{Using } \lim_{h\to\infty}\displaystyle\frac{\log(1+h)}{1+h}=0 \text{ and } \lim_{h\to\infty}\displaystyle\frac{1+h}{h}=1, \text{ we get } \lim_{h\to\infty}\displaystyle\frac{\log(1+h)}{h}=0.",
      r"\text{Therefore } \log\left(\lim_{h\to\infty}(1+h)^{\frac{1}{h}}\right)=0, \text{ hence } \lim_{h\to\infty}(1+h)^{\frac{1}{h}}=e^{0}=1.",
    ],
  ),
  // exponential_limits.dart (reserve / commented problems)
  "B79A4A4F-6B5F-440A-9103-9E9C5BCB09D1": ProblemTranslation(
    category: 'Basic Exponential Limit (Mean Value Theorem)',
    level: 'Easy',
    question: r"""\displaystyle \lim_{x\to 0}\frac{e^{x}-1}{x}""",
    answer: r"""\displaystyle 1""",
    hint:
        r"""\text{By the mean value theorem, } \displaystyle\frac{e^{x}-1}{x}=e^{\xi} \text{ for some } \xi \text{ between } 0 \text{ and } x.""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Apply the mean value theorem to } e^{x}.",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \frac{e^{x}-1}{x} &= e^{\xi} \quad (\xi \text{ lies between } 0 \text{ and } x) \end{aligned}",
      r"\text{As } x\to 0, \ \xi\to 0, \text{ so } e^{\xi}\to 1.",
      r"\begin{aligned} \therefore \lim_{x\to 0}\frac{e^{x}-1}{x} = 1 \end{aligned}",
    ],
  ),
  "9716186B-D344-46B3-86B7-015ECFC26BEF": ProblemTranslation(
    category: 'Limit Defining \(e\) (Logarithmic Squeeze)',
    level: 'Easy',
    question: r"""\displaystyle \lim_{n\to\infty}\left(1+\frac{1}{n}\right)^{n}""",
    answer: r"""\displaystyle e""",
    hint:
        r"""\text{Use } \displaystyle\frac{u}{1+u}\le \log(1+u)\le u \ (u>-1) \text{ with } u=\displaystyle\frac{1}{n}.""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Squeeze } n\log\!\left(1+\displaystyle\frac{1}{n}\right) \text{ and exponentiate.}",
      r"\textbf{[Solution]}",
      r"\text{From } \displaystyle\frac{u}{1+u}\le \log(1+u)\le u \text{ with } u=\displaystyle\frac{1}{n}:",
      r"\begin{aligned} \frac{1}{1+\frac{1}{n}} \le n\log\!\left(1+\frac{1}{n}\right) \le 1 \end{aligned}",
      r"\text{Both bounds tend to } 1, \text{ so } n\log\!\left(1+\displaystyle\frac{1}{n}\right)\to 1.",
      r"\text{Exponentiating gives } \left(1+\displaystyle\frac{1}{n}\right)^{n}\to e^{1}=e.",
    ],
  ),
  "C2C5B1E9-4C1B-4B8F-9DD5-8A2A1FD9D103": ProblemTranslation(
    category: 'Limit Defining \(e\) (Exponent Adjustment)',
    level: 'Easy',
    question: r"""\displaystyle \lim_{n\to\infty}\left(1+\frac{1}{n}\right)^{\,n+1}""",
    answer: r"""\displaystyle e""",
    hint:
        r"""\text{Use } \left(1+\displaystyle\frac{1}{n}\right)^{n+1}=\left(1+\displaystyle\frac{1}{n}\right)^{n}\left(1+\displaystyle\frac{1}{n}\right).""",
    steps: [
      r"\textbf{[Solution]}",
      r"\begin{aligned} \left(1+\frac{1}{n}\right)^{n+1} &= \left(1+\frac{1}{n}\right)^{n}\left(1+\frac{1}{n}\right) \end{aligned}",
      r"\text{As } n\to\infty, \ \left(1+\displaystyle\frac{1}{n}\right)^{n}\to e \text{ and } \left(1+\displaystyle\frac{1}{n}\right)\to 1.",
      r"\begin{aligned} \therefore \left(1+\frac{1}{n}\right)^{n+1} \to e\cdot 1=e \end{aligned}",
    ],
  ),
  "7C3E8A4D-9B07-4638-9C8D-0A6D9E3B1B7F": ProblemTranslation(
    category: 'Limit Defining \(e\) (Scaled Exponent)',
    level: 'Easy',
    question: r"""\displaystyle \lim_{n\to\infty}\left(1+\frac{1}{n}\right)^{\,2n}""",
    answer: r"""\displaystyle e^{2}""",
    hint:
        r"""\text{Use } \left(1+\displaystyle\frac{1}{n}\right)^{2n}=\left(\left(1+\displaystyle\frac{1}{n}\right)^{n}\right)^{2}.""",
    steps: [
      r"\textbf{[Solution]}",
      r"\begin{aligned} \left(1+\frac{1}{n}\right)^{2n} &= \left(\left(1+\frac{1}{n}\right)^{n}\right)^{2} \underset{n\to\infty}{\longrightarrow} e^{2} \end{aligned}",
    ],
  ),
  "F5F0C2A9-1C9D-45CE-9F50-1B9B2E2E4D66": ProblemTranslation(
    category: 'Limit Defining \(e\) (General Coefficient)',
    level: 'Easy',
    question: r"""\displaystyle \lim_{n\to\infty}\left(1+\frac{3}{n}\right)^{\,n}""",
    answer: r"""\displaystyle e^{3}""",
    hint:
        r"""\text{Use } \left(1+\displaystyle\frac{c}{n}\right)^{n}\to e^{c} \text{ with } c=3.""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Convert to an exponential via } \exp \text{ and use } \lim_{u\to 0}\displaystyle\frac{\log(1+u)}{u}=1.",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \left(1+\frac{3}{n}\right)^{n} &= \exp\!\left(n\log\!\left(1+\frac{3}{n}\right)\right) \\[6pt] &= \exp\!\left(3\cdot \frac{\log\!\left(1+\frac{3}{n}\right)}{\frac{3}{n}}\right) \underset{n\to\infty}{\longrightarrow} \exp(3)=e^{3} \end{aligned}",
    ],
  ),
  "9B8A1F47-0D7B-4DE0-9F11-2E7A4BE6D2B2": ProblemTranslation(
    category: 'Limit Defining \(e\) (Negative Coefficient)',
    level: 'Easy',
    question: r"""\displaystyle \lim_{n\to\infty}\left(1-\frac{1}{n}\right)^{\,n}""",
    answer: r"""\displaystyle e^{-1}""",
    hint:
        r"""\text{Use } \left(1+\displaystyle\frac{c}{n}\right)^{n}\to e^{c} \text{ with } c=-1.""",
    steps: [
      r"\textbf{[Solution]}",
      r"\begin{aligned} \left(1-\frac{1}{n}\right)^{n} &= \exp\!\left(n\log\!\left(1-\frac{1}{n}\right)\right) \\[6pt] &= \exp\!\left(\frac{\log\!\left(1-\frac{1}{n}\right)}{-\frac{1}{n}}\right) \underset{n\to\infty}{\longrightarrow} \exp(-1)=e^{-1} \end{aligned}",
    ],
  ),
  "D1455B62-14C6-4B5B-8A78-8A6700CCCA90": ProblemTranslation(
    category: 'Exponential Limit (First-Order Error)',
    level: 'Advanced',
    question: r"""\displaystyle \lim_{n\to\infty} n\!\left(\Bigl(1+\frac{1}{n}\Bigr)^{n}-e\right)""",
    answer: r"""\displaystyle -\displaystyle\frac{e}{2}""",
    hint:
        r"""\text{Use the expansion } n\log\!\left(1+\displaystyle\frac{1}{n}\right)=1-\displaystyle\frac{1}{2n}+o\!\left(\displaystyle\frac{1}{n}\right).""",
    steps: [
      r"\textbf{[Idea]}",
      r"\text{Use a first-order expansion of } n\log\!\left(1+\displaystyle\frac{1}{n}\right) \text{ and then exponentiate.}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} n\log\!\left(1+\frac{1}{n}\right) &= 1-\frac{1}{2n}+o\!\left(\frac{1}{n}\right) \end{aligned}",
      r"\text{Exponentiating,}",
      r"\begin{aligned} \left(1+\frac{1}{n}\right)^{n} &= \exp\!\left(1-\frac{1}{2n}+o\!\left(\frac{1}{n}\right)\right) \\[6pt] &= e\cdot \exp\!\left(-\frac{1}{2n}+o\!\left(\frac{1}{n}\right)\right) \\[6pt] &= e\left(1-\frac{1}{2n}+o\!\left(\frac{1}{n}\right)\right) \end{aligned}",
      r"\text{Therefore,}",
      r"\begin{aligned} n\left(\left(1+\frac{1}{n}\right)^{n}-e\right) &= n\left(e\left(1-\frac{1}{2n}+o\!\left(\frac{1}{n}\right)\right)-e\right) \\[6pt] &= n\left(-\frac{e}{2n}+o\!\left(\frac{1}{n}\right)\right) \to -\frac{e}{2} \end{aligned}",
    ],
  ),
  "BA707FB0-6792-4F52-A32D-691C3C4C728C": ProblemTranslation(
    category: 'Asymptotics via Series (Taylor Expansion)',
    level: 'Mid',
    question:
        r"""\displaystyle \lim_{n\to\infty} n\!\left(\log\Bigl(1+\frac{1}{n}\Bigr)-\frac{1}{n}\right)""",
    answer: r"""\displaystyle 0""",
    hint:
        r"""\text{Use the Taylor expansion } \log(1+u)=u-\displaystyle\frac{u^{2}}{2}+\displaystyle\frac{u^{3}}{3}-\cdots \text{ with } u=\displaystyle\frac{1}{n}.""",
    steps: [
      r"\textbf{[Solution]}",
      r"\text{Using } \log(1+u)=u-\displaystyle\frac{u^{2}}{2}+\displaystyle\frac{u^{3}}{3}-\cdots \text{ with } u=\displaystyle\frac{1}{n}:",
      r"\begin{aligned} \log\!\left(1+\frac{1}{n}\right) - \frac{1}{n} &= -\frac{1}{2n^{2}}+\frac{1}{3n^{3}}-\frac{1}{4n^{4}}+\cdots \end{aligned}",
      r"\text{Multiplying by } n \text{ gives}",
      r"\begin{aligned} n\left(\log\!\left(1+\frac{1}{n}\right) - \frac{1}{n}\right) &= -\frac{1}{2n}+\frac{1}{3n^{2}}-\frac{1}{4n^{3}}+\cdots \to 0 \end{aligned}",
    ],
  ),
  "631DB9BF-2CEB-4ABF-B179-E73A34061E42": ProblemTranslation(
    category: 'Squeeze (Logarithm Inequality)',
    level: 'Mid',
    question: r"""\displaystyle \lim_{n\to\infty} n\,\log\!\left(1+\frac{1}{n}\right)""",
    answer: r"""\displaystyle 1""",
    hint:
        r"""\text{Apply } \displaystyle\frac{u}{1+u}\le \log(1+u)\le u \ (u>-1) \text{ with } u=\displaystyle\frac{1}{n}.""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use } \displaystyle\frac{u}{1+u}\le \log(1+u)\le u \text{ and multiply by } n.",
      r"\textbf{[Solution]}",
      r"\text{With } u=\displaystyle\frac{1}{n}:",
      r"\begin{aligned} \frac{\frac{1}{n}}{1+\frac{1}{n}} \le \log\!\left(1+\frac{1}{n}\right) \le \frac{1}{n} \end{aligned}",
      r"\text{Multiplying by } n \text{ gives}",
      r"\begin{aligned} \frac{1}{1+\frac{1}{n}} \le n\log\!\left(1+\frac{1}{n}\right) \le 1 \end{aligned}",
      r"\text{Both bounds tend to } 1, \text{ so by the squeeze theorem } \lim_{n\to\infty} n\log\!\left(1+\displaystyle\frac{1}{n}\right)=1.",
    ],
  ),
  // mean_value_theorem_limits.dart
  "9D8F2E21-0F37-4C8B-A5B4-7A4F2B3A0C11": ProblemTranslation(
    category: 'Limits via the Mean Value Theorem',
    level: 'Mid',
    question: r"""\displaystyle \lim_{x\to 0}\frac{\cos x-\cos x^2}{x-x^2}""",
    answer: r"""\displaystyle 0""",
    hint: r"""\text{Apply the mean value theorem to } f(t)=\cos t \text{ on } [x^2,x].""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Apply the mean value theorem to } \cos\text{.}",
      r"\textbf{[Mean Value Theorem]}",
      r"\text{If a function } f \text{ is continuous on } [a,b] \text{ and differentiable on } (a,b)\text{,}",
      r"\text{then there exists } c \text{ between } a \text{ and } b \text{ such that } f(b)-f(a)=f'(c)(b-a)\text{.}",
      r"\textbf{[Apply]}",
      r"\text{Let } f(t)=\cos t\text{. Then } f'(t)=-\sin t\text{.}",
      r"\text{Apply the theorem with } a=x^{2},\ b=x\text{.}",
      r"\text{Then}",
      r"\text{there exists a real number } c \text{ between } x \text{ and } x^{2} \text{ such that } \cos x-\cos x^{2} = (-\sin c)(x-x^{2})\text{.}",
      r"\textbf{[Therefore]}",
      r"\begin{aligned} \frac{\cos x-\cos x^{2}}{x-x^{2}} = -\sin c \end{aligned}",
      r"\textbf{[Check from both sides]}",
      r"\text{(1) If } x>0\text{, then }x^{2}<x\text{, so }c\text{ lies between }x^{2}\text{ and }x\text{.}",
      r"\text{(2) If } x<0\text{, then }x<x^{2}\text{, so }c\text{ lies between }x\text{ and }x^{2}\text{.}",
      r"\text{In either case, as }x\to 0\text{ we have }x^{2}\to 0\text{, hence }c\to 0\text{.}",
      r"\text{Since } \sin \text{ is continuous, } -\sin c \to -\sin 0 = 0\text{.}",
      r"\boxed{\displaystyle \lim_{x\to 0}\frac{\cos x-\cos x^{2}}{x-x^{2}} = 0}",
    ],
  ),
  "C2A4D7E9-8C31-4B67-9D1C-7B1F9F4D2C22": ProblemTranslation(
    category: 'Integral Form Limit of \(1/x\)',
    level: 'Mid',
    question: r"""\displaystyle \lim_{x\to 0}\frac{1}{x}\int_{0}^{x}\sqrt{1+\cos^{3}t}\,dt""",
    answer: r"""\displaystyle \sqrt{2}""",
    hint:
        r"""\text{Use the mean value theorem for integrals: } \int_{0}^{x}g(t)\,dt=g(\xi)x.""",
    steps: [
      r"\textbf{[Solution (Using a Theorem)]}",
      r"\text{Let } g(t)=\sqrt{1+\cos^{3}t}\text{.}",
      r"\text{The function } g \text{ is continuous near } t=0\text{.}",
      r"\text{By the mean value theorem for integrals,}",
      r"\text{there exists a real number } \xi \text{ between } 0 \text{ and } x \text{ such that } \int_{0}^{x}g(t)\,dt = g(\xi)\,x\text{.}",
      r"\Rightarrow\ \frac{1}{x}\int_{0}^{x}\sqrt{1+\cos^{3}t}\,dt=\sqrt{1+\cos^{3}\xi}",
      r"\text{As }x\to 0\text{, } \xi \text{ lies between }0\text{ and }x\text{, hence } \xi\to 0\text{.}",
      r"\text{Since } \cos \text{ is continuous, } \cos \xi \to 1\text{.}",
      r"\Rightarrow\ 1+\cos^{3}\xi \to 2\Rightarrow \sqrt{1+\cos^{3}\xi}\to \sqrt2",
      r"\boxed{\displaystyle \lim_{x\to0}\frac{1}{x}\int_{0}^{x}\sqrt{1+\cos^{3}t}\,dt=\sqrt2}",
      r"\textbf{[Supplement: Mean Value Theorem for Integrals (Proof)]}",
      r"\text{We prove the case } x>0\text{. (The case }x<0\text{ is similar.)}",
      r"\text{Since } g \text{ is continuous on } [0,x]\text{, it attains a minimum and a maximum.}",
      r"\text{Let the minimum be } m \text{ and the maximum be } M\text{. Then } m\le g(t)\le M\ (0\le t\le x).",
      r"\text{Integrate both sides from }0\text{ to }x\text{:}",
      r"\int_{0}^{x}m\,dt\le \int_{0}^{x}g(t)\,dt\le \int_{0}^{x}M\,dt",
      r"\Rightarrow\ mx\le \int_{0}^{x}g(t)\,dt\le Mx",
      r"\Rightarrow\ m\le \frac{1}{x}\int_{0}^{x}g(t)\,dt\le M",
      r"\text{Since } g \text{ is continuous, it takes every value between }m\text{ and }M\text{.}",
      r"\text{Therefore, there exists } \xi \text{ such that } g(\xi)=\frac{1}{x}\int_{0}^{x}g(t)\,dt\text{.}",
      r"\text{That is, } \int_{0}^{x}g(t)\,dt=g(\xi)x \text{ for some } \xi \text{ between }0\text{ and }x\text{.}",
    ],
  ),
  // squeeze_limits.dart
  "A60C22EA-24D4-4C3B-A60A-90996784D9C5": ProblemTranslation(
    category: 'Comparison (Exponentials vs Factorials)',
    level: 'Mid',
    question: r"""\displaystyle \lim_{n\to\infty}\frac{2^{n}}{n!}""",
    answer: r"""\displaystyle 0""",
    hint:
        r"""\text{Write } \displaystyle\frac{2^{n}}{n!}=\prod_{k=1}^{n}\displaystyle\frac{2}{k} \text{ and compare each factor for } k\ge 3.""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Write } \displaystyle\frac{2^{n}}{n!}=\prod_{k=1}^{n}\frac{2}{k}\text{.}",
      r"\text{For } k\ge 3\text{, we have } \displaystyle\frac{2}{k}\le \frac{2}{3}\text{, so we can squeeze.}",
      r"\textbf{[Solution]}",
      r"""\begin{aligned}
0 &\le \frac{2^{n}}{n!}\\[6pt]
&= \prod_{k=1}^{n}\frac{2}{k} \\[6pt]
&= \left(\frac{2}{1}\cdot\frac{2}{2}\right)\cdot \prod_{k=3}^{n}\frac{2}{k} \\[6pt]
&\le 2\cdot \left(\frac{2}{3}\right)^{\,n-2}
\end{aligned}""",
      r"\text{Since } \displaystyle \lim_{n\to\infty} 2\cdot\left(\frac{2}{3}\right)^{\,n-2}=0\text{, the squeeze theorem gives } \displaystyle \lim_{n\to\infty} \frac{2^{n}}{n!} = 0\text{.}",
      r"",
      r"\textbf{[Supplement: Product Notation]}",
      r"\text{The notation } \displaystyle \prod_{k=m}^{n} a_k \ (m\le n) \text{ means } a_m a_{m+1}\cdots a_n\text{.}",
      r"\textbf{[Example]}",
      r"""\begin{aligned}
\prod_{k=1}^{4} k
&= 1\cdot 2\cdot 3\cdot 4 \\[4pt]
&= 24 \\[10pt]
\prod_{k=1}^{4}\frac{2}{k}
&= \frac{2}{1}\cdot \frac{2}{2}\cdot \frac{2}{3}\cdot \frac{2}{4} \\[4pt]
&= \frac{2^{4}}{1\cdot 2\cdot 3\cdot 4} \\[4pt]
&= \frac{16}{24} \\[4pt]
&= \frac{2}{3}
\end{aligned}""",
    ],
  ),
  "C1F3E989-594D-446A-8E94-FD7E70C7450F": ProblemTranslation(
    category: 'Squeeze Theorem',
    level: 'Easy',
    question: r"""\displaystyle \lim_{x\to 0}x\sin\!\left(\frac{1}{x}\right)""",
    answer: r"""\displaystyle 0""",
    hint: r"""\text{Use } -1\le \sin(1/x)\le 1 \text{ and squeeze.}""",
    steps: [
      r"""\textbf{[Strategy]}
\text{Bound } \sin(\displaystyle \frac{1}{x}) \text{ between } -1 \text{ and } 1, \text{ then multiply by } x.""",
      r"\textbf{[Solution]}",
      r"\begin{aligned} -1 \le \sin\!\left(\frac{1}{x}\right) \le 1 \end{aligned}",
      r"\text{Multiplying by } |x| \text{ gives}",
      r"\begin{aligned} -|x| \le x\sin\!\left(\frac{1}{x}\right) \le |x| \end{aligned}",
      r"\text{Since } \lim_{x\to 0}|x|=0, \text{ the squeeze theorem yields } \lim_{x\to 0}x\sin(1/x)=0.",
    ],
  ),
  // squeeze_limits.dart (reserve / commented-out in source)
  "BA602879-97B8-4390-9C29-51F3F35F1A49": ProblemTranslation(
    category: 'Squeeze (Logarithm Composition)',
    level: 'Mid',
    question: r"""\displaystyle \lim_{x\to 0}\frac{\log(\cos x)}{x^{2}}""",
    answer: r"""\displaystyle -\frac{1}{2}""",
    hint:
        r"""\text{Use } 1-\cos x \le \displaystyle\frac{x^{2}}{2} \text{ and } \log(1-u)\le -u \ (0<u<1).""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Rewrite } \log(\cos x)=\log\!\bigl(1-(1-\cos x)\bigr) \text{ and bound it using } \log(1-u)\le -u.",
      r"\textbf{[Solution]}",
      r"\text{For } x\neq 0 \text{ near } 0,\ \cos x>0 \text{ and } 0<1-\cos x<1.",
      r"\text{Using } \log(1-u)\le -u \text{ for } 0<u<1 \text{ with } u=1-\cos x,\ \text{we get}",
      r"\begin{aligned} \log(\cos x) = \log\!\bigl(1-(1-\cos x)\bigr) \le -(1-\cos x). \end{aligned}",
      r"\text{Also } 0\le 1-\cos x \le \displaystyle\frac{x^{2}}{2} \text{ for all real } x \text{, hence}",
      r"\begin{aligned} \log(\cos x) \le -(1-\cos x) \le -\displaystyle\frac{x^{2}}{2}. \end{aligned}",
      r"\text{Dividing by } x^{2}>0 \text{ gives } \displaystyle\frac{\log(\cos x)}{x^{2}} \le -\frac{1}{2}.",
      r"\text{Similarly, using a lower bound for } \log(1-u) \text{ (or a two-sided estimate), we obtain the squeeze to } -\frac{1}{2}.",
      r"\begin{aligned} \therefore \lim_{x\to 0}\frac{\log(\cos x)}{x^{2}} = -\frac{1}{2}. \end{aligned}",
    ],
  ),
  "A8B9C0D1-E2F3-4A5B-6C7D-8E9F0A1B2C3D": ProblemTranslation(
    category: 'Shift Substitution',
    level: 'Mid',
    question: r"""\displaystyle \lim_{x\to\frac{\pi}{2}}\cos(3x)\tan(5x)""",
    answer: r"""\displaystyle -\frac{3}{5}""",
    hint:
        r"""\text{Let } t=x-\displaystyle\frac{\pi}{2} \text{ so that } t\to 0, \text{ then use } \lim_{t\to 0}\displaystyle\frac{\sin t}{t}=1.""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Shift the limit point } x=\displaystyle\frac{\pi}{2} \text{ to } 0 \text{ by setting } t=x-\displaystyle\frac{\pi}{2}.",
      r"\text{This substitution allows direct use of } \displaystyle \lim_{t\to 0}\frac{\sin t}{t}=1\text{.}",
      r"\textbf{[Solution]}",
      r"\text{Let } t=x-\displaystyle\frac{\pi}{2}. \text{ Then } x=t+\displaystyle\frac{\pi}{2} \text{ and } x\to\displaystyle\frac{\pi}{2} \Rightarrow t\to 0.",
      r"\text{First, transform } \cos(3x)\text{:}",
      r"""\begin{aligned}
\cos(3x)
&= \cos\!\left(3\left(t+\displaystyle\frac{\pi}{2}\right)\right)\\[6pt]
&= \cos\!\left(3t+\displaystyle\frac{3\pi}{2}\right)\\[6pt]
&= \sin(3t)
\end{aligned}""",
      r"\text{Next, transform } \tan(5x)\text{:}",
      r"""\begin{aligned}
\tan(5x)
&= \tan\!\left(5\left(t+\displaystyle\frac{\pi}{2}\right)\right)\\[6pt]
&= \tan\!\left(5t+\displaystyle\frac{5\pi}{2}\right)\\[6pt]
&= \tan\!\left(5t+\displaystyle\frac{\pi}{2}\right)\\[6pt]
&= -\frac{\cos(5t)}{\sin(5t)}
\end{aligned}""",
      r"\text{Therefore,}",
      r"""\begin{aligned}
\cos(3x)\tan(5x)
&= \sin(3t)\cdot\left(-\frac{\cos(5t)}{\sin(5t)}\right)\\[6pt]
&= -\frac{\sin(3t)\cos(5t)}{\sin(5t)}
\end{aligned}""",
      r"\text{Hence the limit becomes } t\to 0\text{:}",
      r"""\begin{aligned}
\lim_{x\to\frac{\pi}{2}}\cos(3x)\tan(5x)
&= -\lim_{t\to 0}\frac{\sin(3t)\cos(5t)}{\sin(5t)}\\[6pt]
&= -\left(\lim_{t\to 0}\frac{\sin(3t)}{\sin(5t)}\right)\left(\lim_{t\to 0}\cos(5t)\right)\\[6pt]
&= -\left(\lim_{t\to 0}\frac{\sin(3t)}{3t}\cdot\frac{5t}{\sin(5t)}\cdot\frac{3t}{5t}\right)\cdot 1\\[6pt]
&= -\frac{3}{5}\cdot 1 \cdot 1\\[6pt]
&= -\frac{3}{5}
\end{aligned}""",
    ],
  ),
  "AF028FDC-E4ED-4B5D-907A-FD053AA682F0": ProblemTranslation(
    category: 'Mercator Series (Alternating Harmonic)',
    level: 'Advanced',
    question: r"""\displaystyle \lim_{n\to\infty}\displaystyle \sum_{k=1}^{n}\frac{(-1)^{k+1}}{k}""",
    answer: r"""\displaystyle \log 2""",
    hint:
        r"""\text{Use } \displaystyle \frac{(-1)^{k+1}}{k}=\int_0^1 (-t)^{k-1}\,dt \text{ and the geometric series.}""",
    steps: [
      r"\textbf{[Proposition]}",
      r"\begin{aligned} \displaystyle \sum_{k=1}^{\infty}\frac{(-1)^{k+1}}{k}=\log 2 \end{aligned}",
      r"\textbf{[Solution 1] (Even partial sums \(\to\) Riemann sum)}",
      r"\text{Let } S_n=\displaystyle \sum_{k=1}^{n}\frac{(-1)^{k+1}}{k}. \text{ First, analyze the even partial sums }S_{2N}\text{.}",
      r"\textbf{[Lemma]} \ \displaystyle \sum_{k=1}^{2N}\frac{(-1)^{k+1}}{k}=\displaystyle \sum_{k=1}^{N}\frac{1}{N+k}",
      r"\textbf{[Proof of Lemma]}",
      r"\text{Consider the alternating sum } \displaystyle 1-\frac12+\frac13-\frac14+\cdots-\frac{1}{2N}\text{. First, add all terms with positive signs:}",
      r"\displaystyle 1+\frac12+\frac13+\frac14+\cdots+\frac{1}{2N}",
      r"\text{Then subtract twice the terms that originally had minus signs: } \displaystyle \frac12,\frac14,\ldots,\frac{1}{2N}\text{. We obtain}",
      r"""\begin{aligned}
&\ \displaystyle \ \ \ \ \ \displaystyle \sum_{k=1}^{2N}\frac{(-1)^{k+1}}{k}\\[6pt]
&\displaystyle = 1-\frac12+\frac13-\frac14+\cdots-\frac{1}{2N}\\[6pt]
&\displaystyle =\left(1+\frac12+\cdots+\frac{1}{2N}\right)
-2\left(\frac12+\frac14+\cdots+\frac{1}{2N}\right)\\[6pt]
&\displaystyle =\left(1+\frac12+\cdots+\frac{1}{2N}\right)
-\left(1+\frac12+\cdots+\frac{1}{N}\right)\\[6pt]
& \displaystyle =\frac{1}{N+1}+\frac{1}{N+2}+\cdots+\frac{1}{2N}\\[6pt]
& \displaystyle  =\displaystyle \sum_{k=1}^{N}\frac{1}{N+k}
\end{aligned}\quad \text{Q.E.D.}""",
      r"\text{By the lemma, } S_{2N}=\displaystyle \sum_{k=1}^{N}\frac{1}{N+k}\text{. Dividing by }N\text{ gives}",
      r"""\begin{aligned}
S_{2N}
&=\displaystyle \sum_{k=1}^{N}\frac{1}{N+k}
=\frac1N\displaystyle \sum_{k=1}^{N}\frac{1}{1+\frac{k}{N}}.
\end{aligned}""",
      r"\text{The right-hand side is a Riemann sum for } f(x)=\displaystyle\frac{1}{1+x} \text{ on } [0,1]\text{, so}",
      r"""\begin{aligned}
\lim_{N\to\infty}S_{2N}
&=\lim_{N\to\infty}\frac1N\displaystyle \sum_{k=1}^{N}\frac{1}{1+\frac{k}{N}}\\[6pt]
&=\int_{0}^{1}\frac{1}{1+x}\,dx\\[6pt]
&=\Bigl[\log(1+x)\Bigr]_{0}^{1}\\[6pt]
&=\log 2.
\end{aligned}""",
      r"\textbf{[Note: \(S_{2N+1}\) has the same limit]}",
      r"""\begin{aligned}
S_{2N+1}
&=\displaystyle \sum_{k=1}^{2N+1}\frac{(-1)^{k+1}}{k}\\[6pt]
&=\displaystyle \sum_{k=1}^{2N}\frac{(-1)^{k+1}}{k}+\frac{1}{2N+1}\\[6pt]
&= S_{2N}+\frac{1}{2N+1}
\end{aligned}""",
      r"\text{Thus } S_{2N+1}-S_{2N}=\displaystyle\frac{1}{2N+1}\to 0 \ (N\to\infty)\text{, hence } \lim_{N\to\infty}S_{2N+1}=\log 2\text{ as well.}",
      r"\text{Since the even and odd partial sums converge to the same limit } \log 2\text{, the full sequence }S_n\text{ also converges to } \log 2\text{.}",
      r"\textbf{[Solution 2] (Integral representation \(\to\) geometric series)}",
      r"\text{Each term can be written as } \displaystyle \frac{(-1)^{k+1}}{k}=\int_0^1 (-t)^{k-1}\,dt\text{.}",
      r"""\begin{aligned}
S_n&=\displaystyle \sum_{k=1}^{n}\frac{(-1)^{k+1}}{k}\\[6pt]
&=\displaystyle \sum_{k=1}^{n}\int_0^1 (-t)^{k-1}\,dt\\[6pt]
&=\int_0^1\displaystyle \sum_{k=0}^{n-1}(-t)^k\,dt
\end{aligned}""",
      r"\text{By the geometric sum formula } \displaystyle \sum_{k=0}^{n-1}(-t)^k=\frac{1-(-t)^n}{1+t}\text{. Hence}",
      r"""\begin{aligned}
S_n&=\int_0^1\frac{1-(-t)^n}{1+t}\,dt\\[6pt]
&=\int_0^1\frac{1}{1+t}\,dt-\int_0^1\frac{(-t)^n}{1+t}\,dt
\end{aligned}""",
      r"\text{We have } \displaystyle \int_0^1\frac{1}{1+t}\,dt=\Bigl[\log(1+t)\Bigr]_0^1=\log 2\text{.}",
      r"\text{Also, since } 0<\frac{t^n}{1+t}<t^n \ (0<t<1)\text{,}",
      r"""\begin{aligned}
\left|\int_0^1\frac{(-t)^n}{1+t}\,dt\right|
&\le \int_0^1 \frac{t^n}{1+t}\,dt
<\int_0^1 t^n\,dt
=\frac{1}{n+1}\to 0.
\end{aligned}""",
      r"\text{Therefore } \displaystyle \lim_{n\to\infty}S_n=\log 2\text{.}",
      r"\begin{aligned} \therefore \lim_{n\to\infty} S_n = \log 2. \end{aligned}",
      r"\boxed{\displaystyle \sum_{k=1}^{\infty}\frac{(-1)^{k+1}}{k}=\log 2}",
      r"\textbf{[Supplement]}",
      r"\text{This series is called the Mercator series.}",
    ],
  ),
  "BE3EC919-60B4-4334-BE8F-389731CF565D": ProblemTranslation(
    category: 'Leibniz Series',
    level: 'Advanced',
    question: r"""\displaystyle \lim_{n\to\infty}\displaystyle \sum_{k=1}^{n}\frac{(-1)^{k-1}}{2k-1}""",
    answer: r"""\displaystyle \frac{\pi}{4}""",
    hint:
        r"""\text{Use } \displaystyle\frac{(-1)^{k-1}}{2k-1}=\int_0^1(-t^2)^{k-1}\,dt \text{ and a geometric series.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Express the partial sums as an integral and evaluate using a geometric series.}",
      r"\textbf{[Solution]}",
      r"\text{Consider the partial sums } S_n = \displaystyle \sum_{k=1}^{n}\frac{(-1)^{k-1}}{2k-1}\text{:}",
      r"""\begin{aligned}
S_n &= \displaystyle \sum_{k=1}^{n}\frac{(-1)^{k-1}}{2k-1} \\[6pt]
&= 1 - \frac{1}{3} + \frac{1}{5} - \frac{1}{7} + \cdots + \frac{(-1)^{n-1}}{2n-1}
\end{aligned}""",
      r"\text{Each term can be written as } \displaystyle \frac{(-1)^{k-1}}{2k-1} = \int_0^1 (-t^2)^{k-1}\,dt\text{.}",
      r"\text{(For example, } \displaystyle -\frac{1}{3} = \int_0^1 (-t^2)^{1}\,dt\text{.)}",
      r"\text{Indeed,}",
      r"""\begin{aligned}
\int_0^1 (-t^2)^{k-1} \, dt
&= \int_0^1 (-1)^{k-1} t^{2k-2} \, dt \\[6pt]
&= (-1)^{k-1} \left[ \frac{t^{2k-1}}{2k-1} \right]_0^1 \\[6pt]
&= (-1)^{k-1}\cdot \frac{1}{2k-1} \\[6pt]
&= \frac{(-1)^{k-1}}{2k-1}.
\end{aligned}""",
      r"\text{Therefore, we can write the partial sum as a sum of integrals:}",
      r"""\begin{aligned}
S_n
&= \displaystyle \sum_{k=1}^{n} \int_0^1 (-t^2)^{k-1} \, dt \\[6pt]
&= \displaystyle \sum_{k=0}^{n-1} \int_0^1 (-t^2)^k \, dt \\[6pt]
&= \int_0^1 \displaystyle \sum_{k=0}^{n-1} (-t^2)^k \, dt.
\end{aligned}""",
      r"\text{By the geometric series formula,}",
      r"""\begin{aligned}
\displaystyle \sum_{k=0}^{n-1} (-t^2)^k
&= \frac{1-(-t^2)^n}{1-(-t^2)} \\[6pt]
&= \frac{1-(-t^2)^n}{1+t^2}.
\end{aligned}""",
      r"\text{Hence,}",
      r"""\begin{aligned}
S_n
&= \int_0^1 \frac{1-(-t^2)^n}{1+t^2} \, dt \\[6pt]
&= \int_0^1 \frac{1}{1+t^2} \, dt - \int_0^1 \frac{(-t^2)^n}{1+t^2} \, dt.
\end{aligned}""",
      r"\textcolor{blue}{The\ first\ term\ on\ the\ right-hand\ side\ is}",
      r"""\begin{aligned}
\int_0^1 \frac{1}{1+t^2} \, dt
&= \int_0^{\frac{\pi}{4}} \frac{1}{1+\tan^2 x}\frac{1}{\cos^2 x}\,dx \\[6pt]
&= \int_0^{\frac{\pi}{4}} 1\,dx \\[6pt]
&= \frac{\pi}{4}.
\end{aligned}""",
      r"\textcolor{blue}{The\ second\ term\ tends\ to\ } \textcolor{red}{0} \textcolor{blue}{\ as\ } n\to\infty \textcolor{blue}{\ (see\ the\ supplement\ below).}",
      r"\text{Therefore,}",
      r"\boxed{\displaystyle \sum_{k=1}^{\infty} \frac{(-1)^{k-1}}{2k-1} = \frac{\pi}{4}}",
      r"\textbf{[Supplement: Show the second term converges to 0]}",
      r"\text{Factor out } (-1)^n\text{:}",
      r"\frac{(-t^2)^n}{1+t^2} = (-1)^n \cdot \frac{(t^2)^n}{1+t^2}",
      r"\text{On }(0,1)\text{, we have } 0 < \displaystyle \frac{(t^2)^n}{1+t^2} < (t^2)^n\text{, so}",
      r"""\begin{aligned}
\left| \int_0^1 \frac{(-t^2)^n}{1+t^2} \, dt \right|
&= \left| \int_0^1 (-1)^n \cdot \frac{(t^2)^n}{1+t^2} \, dt \right| \\[6pt]
&= \left| (-1)^n \right| \cdot \left| \int_0^1 \frac{(t^2)^n}{1+t^2} \, dt \right| \\[6pt]
&=  \int_0^1 \frac{(t^2)^n}{1+t^2} \, dt  \\[6pt]
&< \int_0^1 (t^2)^n \, dt \\[6pt]
&= \left[ \frac{t^{2n+1}} {2n+1} \right]_0^1 \\[6pt]
&= \frac{1}{2n+1} \to 0 \quad (n \to \infty).
\end{aligned}""",
      r"\text{Thus, if we set } a_n := \int_0^1 \frac{(-t^2)^n}{1+t^2} \, dt\text{, then } \lim_{n\to\infty} |a_n| = 0\text{.}",
      r"\text{Therefore, } \displaystyle \lim_{n\to\infty} a_n = \lim_{n\to\infty}\int_0^1 \frac{(-t^2)^n}{1+t^2} \, dt = 0\text{.}",
      r"\text{(Note: In general, } \lim_{n\to\infty} |a_n| = 0 \Leftrightarrow \lim_{n\to\infty} a_n = 0\text{.)}",
      r"\textbf{[Supplement]}",
      r"\text{This series is called the Leibniz series.}",
    ],
  ),
  "D7F8E9A0-B1C2-4D3E-8F5A-6B7C8D9E0F1A": ProblemTranslation(
    category: 'Divergence of a Series (Integral Test)',
    level: 'Advanced',
    question: r"""\displaystyle \lim_{n\to\infty}\displaystyle \sum_{k=1}^{n}\frac{1}{\sqrt{k}}""",
    answer: r"""\displaystyle \infty \text{ (diverges)}""",
    hint:
        r"""\text{Compare } \sum \displaystyle\frac{1}{\sqrt{k}} \text{ with } \int \displaystyle\frac{1}{\sqrt{x}}\,dx.""",
    steps: [
      r"\textbf{[Strategy]}", 
      r"\text{Use an integral comparison with the decreasing function } f(x)=\displaystyle\frac{1}{\sqrt{x}}.",
      r"\textbf{[Solution]}",
      r"\text{Since } f(x)=\displaystyle\frac{1}{\sqrt{x}} \text{ is decreasing on } [1,\infty), \text{ for each integer } k\ge 1 \text{ we have}",
      r"\begin{aligned} \frac{1}{\sqrt{k}} \ge \int_{k}^{k+1}\frac{1}{\sqrt{x}}\,dx. \end{aligned}",
      r"\text{Therefore,}",
      r"\text{Summing from } k=1 \text{ to } n \text{ gives}",
      r"\begin{aligned} \displaystyle \sum_{k=1}^{n}\frac{1}{\sqrt{k}} \ge \int_{1}^{n+1}\frac{1}{\sqrt{x}}\,dx = \left[2\sqrt{x}\right]_{1}^{n+1} = 2\sqrt{n+1}-2. \end{aligned}",
      r"\text{Therefore, } 2\sqrt{n+1}-2 \le \displaystyle \sum_{k=1}^{n}\frac{1}{\sqrt{k}}.",
      r"\text{Since } 2\sqrt{n+1}-2 \to \infty \text{ as } n\to\infty, \text{ the partial sums diverge to } \infty.",
    ],
  ),
  // famous_limits.dart (reserve / commented-out in source)
  "C5B6C66A-0A6B-4B0B-8B76-7B8C7B0D42A7": ProblemTranslation(
    category: 'Wallis Product',
    level: 'Advanced',
    question:
        r"""\displaystyle \lim_{n\to\infty}\prod_{k=1}^{n}\frac{4k^2}{4k^2-1}""",
    answer: r"""\displaystyle \frac{\pi}{2}""",
    hint:
        r"""\text{Use } I_n=\int_0^{\pi/2}\sin^n x\,dx \text{ and squeeze a product derived from } I_{2n+1}\le I_{2n}\le I_{2n-1}.""",
    steps: [
      r"\textbf{[Idea]}",
      r"\text{Define } I_n=\int_0^{\pi/2}\sin^n x\,dx. \text{ Integration by parts yields } I_n=\displaystyle\frac{n-1}{n}I_{n-2}.",
      r"\text{From this recurrence, one derives explicit formulas for } I_{2n} \text{ and } I_{2n+1} \text{ involving products of } \frac{2k-1}{2k} \text{ and } \frac{2k}{2k+1}.",
      r"\text{Using } 0\le \sin x\le 1 \text{ on } [0,\pi/2], \text{ we have } I_{2n+1}\le I_{2n}\le I_{2n-1}.",
      r"\text{These inequalities squeeze the Wallis product } \prod_{k=1}^{n}\displaystyle\frac{4k^2}{4k^2-1} \text{ between } \displaystyle\frac{\pi}{2} \text{ and } \displaystyle\frac{2n+1}{2n}\cdot\frac{\pi}{2}.",
      r"\text{Since } \displaystyle\frac{2n+1}{2n}\to 1, \text{ the squeeze theorem gives } \prod_{k=1}^{n}\displaystyle\frac{4k^2}{4k^2-1}\to \displaystyle\frac{\pi}{2}.",
    ],
  ),
  // problems_e_limit_variations.dart (reserve / commented-out in source)
  "E9A0B1C2-D3E4-F5G6-H7I8-J9K0L1M2N3O4": ProblemTranslation(
    category: 'The Number \(e\)',
    level: 'Advanced',
    question: r""" 1+\displaystyle \sum_{n=1}^{\infty}\frac{1}{n!}""",
    answer: r"""\displaystyle e = 1+\displaystyle \sum_{n=1}^{\infty}\frac{1}{n!}""",
    hint:
        r"""\text{Start from } e=\lim_{h\to 0}(1+h)^{1/h}, \text{ set } h=\displaystyle\frac{1}{n}, \text{ and apply the binomial theorem to } \left(1+\displaystyle\frac{1}{n}\right)^n.""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use } e=\lim_{n\to\infty}\left(1+\displaystyle\frac{1}{n}\right)^n \text{ and expand by the binomial theorem.}",
      r"\textbf{[Solution]}",
      r"\text{Let } h=\displaystyle\frac{1}{n}. \text{ Then } h\to 0 \text{ corresponds to } n\to\infty, \text{ and}",
      r"\begin{aligned} e=\lim_{h\to 0}(1+h)^{1/h}=\lim_{n\to\infty}\left(1+\frac{1}{n}\right)^n. \end{aligned}",
      r"\text{By the binomial theorem,}",
      r"\begin{aligned} \left(1+\frac{1}{n}\right)^n &= \displaystyle \sum_{k=0}^{n}\binom{n}{k}\left(\frac{1}{n}\right)^k \\[6pt] &= \displaystyle \sum_{k=0}^{n}\frac{n(n-1)\cdots(n-k+1)}{k!}\cdot\frac{1}{n^{k}} \\[6pt] &= \displaystyle \sum_{k=0}^{n}\frac{1}{k!}\prod_{j=0}^{k-1}\left(1-\frac{j}{n}\right). \end{aligned}",
      r"\text{For each fixed } k, \text{ we have } \prod_{j=0}^{k-1}\left(1-\displaystyle\frac{j}{n}\right)\to 1 \text{ as } n\to\infty.",
      r"\text{Hence the sum tends to } \displaystyle \sum_{k=0}^{\infty}\displaystyle\frac{1}{k!}, \text{ so}",
      r"\begin{aligned} e = \displaystyle \sum_{k=0}^{\infty}\frac{1}{k!} = 1+\displaystyle \sum_{n=1}^{\infty}\frac{1}{n!}. \end{aligned}",
    ],
  ),
  "630FBD47-A86B-4108-8F90-86F202047B8D": ProblemTranslation(
    category: 'Riemann Sums (Logarithmic Functions)',
    level: 'Mid',
    question: r"""\displaystyle \lim_{n \to \infty} \displaystyle \sum_{k=1}^{n} \displaystyle\frac{1}{n+k}""",
    answer: r"""\displaystyle \log 2""",
    hint: r"""\text{Rewrite as a Riemann sum and reduce to a definite integral.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Rewrite the sum in the form } \displaystyle\frac{1}{n}\sum f\!\left(\displaystyle\frac{k}{n}\right).",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \lim_{n \to \infty} \displaystyle \sum_{k=1}^{n} \displaystyle\frac{1}{n+k} &= \lim_{n \to \infty} \displaystyle \sum_{k=1}^{n} \displaystyle\frac{\displaystyle\frac 1 n}{1+\displaystyle\frac k n}\\[6pt] &= \lim_{n \to \infty} \displaystyle\frac{1}{n} \displaystyle \sum_{k=1}^{n} \displaystyle\frac{1}{1+\displaystyle\frac{k}{n}} \\[6pt] &= \int_{0}^{1}\displaystyle\frac{1}{1+x}\,dx \\[6pt] &= \log 2 \end{aligned}",
    ],
  ),
  "A5E3309B-0558-4CCE-8B01-62E93D2FC90E": ProblemTranslation(
    category: 'Riemann Sums (Logarithmic Functions)',
    level: 'Mid',
    question:
        r"""\displaystyle \lim_{n \to \infty} \displaystyle\frac{1}{n} \displaystyle \sum_{k=1}^{n} \displaystyle\frac{1}{n+k}""",
    answer: r"""\displaystyle 0""",
    hint: r"""\text{Reduce the inner sum to the same integral as in the previous problem, then use the extra factor } \displaystyle\frac{1}{n}.""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the fact that } \displaystyle\frac{1}{n}\displaystyle \sum_{k=1}^{n}\displaystyle\frac{1}{1+\frac{k}{n}} \to \int_{0}^{1}\displaystyle\frac{1}{1+x}\,dx = \log 2.",
      r"\textbf{[Solution]}",
      r"\begin{aligned} &\lim_{n\to\infty} \displaystyle\frac{1}{n}\displaystyle \sum_{k=1}^{n}\displaystyle\frac{1}{k+n}\\[6pt] =&\lim_{n\to\infty} \displaystyle\frac{1}{n}\displaystyle \sum_{k=1}^{n}\displaystyle\frac{\displaystyle\frac 1 n}{1+\displaystyle\frac k n}\\[6pt] =&\lim_{n\to\infty} \displaystyle\frac{1}{n^2}\displaystyle \sum_{k=1}^{n}\displaystyle\frac{1}{1+\displaystyle\frac k n}\\[6pt] =&\lim_{n\to\infty} \displaystyle\frac{1}{n}\left(\displaystyle\frac{1}{n}\displaystyle \sum_{k=1}^{n}\displaystyle\frac{1}{1+\displaystyle\frac k n}\right) \\[6pt] =& 0 \cdot \int_{0}^{1}\displaystyle\frac{1}{1+x}\,dx \\[6pt] =& 0 \end{aligned}",
    ],
  ),
};
