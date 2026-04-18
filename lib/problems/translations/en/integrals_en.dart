import '../../../models/problem_translation.dart';

/// English translations for Integral problems
final Map<String, ProblemTranslation> integralsTranslationsEn = {
  // problems_basic_formula.dart
  "180399F4-71C4-4CAE-8392-D57061DDCBA6": ProblemTranslation(
    category: "Others - Logarithms (Basic)",
    level: "Easy",
    question: r"""\displaystyle \int_{1}^{e} \log  x \, dx""",
    answer: r"""1
""",

    steps: [
      r"\textbf{[Key Point]}",
      r"Assume \log x = (x)'\log {x} and use the integration by parts formula.",
      r"\begin{aligned} &\displaystyle \int \log x\,dx = \displaystyle \int (x)' \log x\,dx &= x\log x - \displaystyle \int x\cdot\displaystyle \frac{1}{x}\,dx \\ &\phantom{\displaystyle \int \log x\,dx } = x\log x - \displaystyle \int 1\,dx \\ &\phantom{\displaystyle \int \log x\,dx } = x\log x - x + C \end{aligned}",
      r"\textbf{[Calculation]}",
      r"\begin{aligned} \displaystyle \int_{1}^{e} \log x\,dx &= \left[x\log x - x\right]_{x=1}^{x=e} \\ &= \left(e\cdot \log e - e\right) - \left(1\cdot \log 1 - 1\right) \\ &= \left(e\cdot 1 - e\right) - \left(1\cdot 0 - 1\right) \\ &= (e-e) - (0-1) \\ &= 1 \end{aligned}",
    ],
  ),
  "F41A1522-30A9-4428-AB89-02F6A0650991": ProblemTranslation(
    category: "Trigonometric (Basic)",
    level: "Easy",
    question:
        r"""\displaystyle \int_{ \frac {\pi} {6}}^{ \frac {\pi} {4}} \tan x \, dx""",
    answer:
        r"""\displaystyle \frac{1}{2}\,\log \left(\displaystyle \frac{3}{2}\right)""",

    hint:
        r"\begin{aligned} &\text{Write } \tan x=\dfrac{\sin x}{\cos x} \text{ and find } \displaystyle \int \tan x\,dx \text{ by substituting } u=\cos x.\\ &\text{Then substitute } x=\displaystyle \frac{\pi}{6},\displaystyle \frac{\pi}{4} \text{ into the obtained primitive function to evaluate the definite integral.} \end{aligned}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\begin{aligned} &\text{Write } \tan x=\dfrac{\sin x}{\cos x} \text{ and find } \displaystyle \int \tan x\,dx \text{ by substituting } u=\cos x.\\ &\text{Then substitute } x=\displaystyle \frac{\pi}{6},\displaystyle \frac{\pi}{4} \text{ into the obtained primitive function to evaluate the definite integral.} \end{aligned}",
      r"\textbf{[Key Point]}",
      r"\begin{aligned} &u=\cos x , \ \ du=-\sin x\,dx \\[4pt] &\displaystyle \int \tan x\,dx = \displaystyle \int \displaystyle \frac{\sin x}{\cos x}\,dx \\ &\phantom{\displaystyle \int \tan x\,dx } = \displaystyle \int \displaystyle \frac{-1}{u}\,du \\ &\phantom{\displaystyle \int \tan x\,dx } = -\displaystyle \int \displaystyle \frac{1}{u}\,du \\ &\phantom{\displaystyle \int \tan x\,dx } = -\log |u| + C \\ &\phantom{\displaystyle \int \tan x\,dx } = -\log |\cos x| + C \\[6pt] &\cos \displaystyle \frac{\pi}{4} =\displaystyle \frac{\sqrt{2}}{2},\quad \cos \displaystyle \frac{\pi}{6}=\displaystyle \frac{\sqrt{3}}{2} \\ &\text{Since } \cos x>0 \text{ on the interval } \left[\displaystyle \frac{\pi}{6},\displaystyle \frac{\pi}{4}\right], \text{ we can set } |\cos x|=\cos x. \end{aligned}",
      r"\textbf{[Explanation]}",
      r"\begin{aligned} \displaystyle \int_{ \frac{\pi}{6}}^{ \frac{\pi}{4}} \tan x\,dx &= \Biggl[-\log |\cos x|\Biggr]_{x= \frac{\pi}{6}}^{x= \frac{\pi}{4}} \\ &= \Biggl[-\log \cos x \Biggr]_{x= \frac{\pi}{6}}^{x= \frac{\pi}{4}} \\ &= \left(-\log \cos\displaystyle \frac{\pi}{4}\right) - \left(-\log \cos\displaystyle \frac{\pi}{6}\right) \\ &= -\log\!\left(\displaystyle \frac{\sqrt{2}}{2}\right) + \log\!\left(\displaystyle \frac{\sqrt{3}}{2}\right) \\ &= \log\!\left(\displaystyle \frac{\displaystyle \frac{\sqrt{3}}{2}}{\displaystyle \frac{\sqrt{2}}{2}}\right) \\ &= \log\!\left(\displaystyle \frac{\sqrt{3}}{\sqrt{2}}\right) \\ &= \log\!\left(\sqrt{\displaystyle \frac{3}{2}}\right) \\ &= \displaystyle \frac{1}{2}\,\log\!\left(\displaystyle \frac{3}{2}\right) \end{aligned}",
    ],
  ),
  "ECB70663-7BFE-4801-8F92-21A71BF20AD3": ProblemTranslation(
    category: "Exponential Functions (Basic)",
    level: "Easy",
    question:
        r"""\displaystyle \int_{ \frac {1} {4}}^{ \frac {1} {2}} 2^{x} \, dx""",
    answer: r"""\displaystyle \frac{\sqrt{2}-2^{ \frac{1}{4}}}{\log 2}
""",

    hint:
        r"\text{Use the formula } \displaystyle \int a^x\,dx = \dfrac{a^x}{\log a} + C\ (a>0, a\neq 1).",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the formula } \displaystyle \int a^x\,dx = \dfrac{a^x}{\log a} + C\ (a>0, a\neq 1).",
      r"\textbf{[Key Point]}",
      r"\text{The formula can be derived using the chain rule. That is, view } 2^x = e^{x \log 2} = (e^{\log 2})^x.",
      r"\textbf{[Explanation]}",
      r"\begin{aligned} \displaystyle \int_{ \frac{1}{4}}^{ \frac{1}{2}} 2^x\,dx &= \left[\displaystyle \frac{2^x}{\log 2}\right]_{x=\displaystyle \frac{1}{4}}^{x=\displaystyle \frac{1}{2}} \\ &= \displaystyle \frac{2^{ \frac{1}{2}}}{\log 2} - \displaystyle \frac{2^{ \frac{1}{4}}}{\log 2} \\ &= \displaystyle \frac{2^{ \frac{1}{2}} - 2^{ \frac{1}{4}}}{\log 2} \\ &= \displaystyle \frac{\sqrt{2} - 2^{ \frac{1}{4}}}{\log 2} \end{aligned}",
      r"\textbf{[Supplement - Formula derivation as a composite function]}",
      r"\begin{aligned} (2^x)' &= \left((e^{\log 2})^x\right)'\\ &= \left(e^{x \log 2}\right)'\\ &= (e^{x \log 2}) \left(x \log 2\right)'\\ &= 2^x \log 2\\ &= (\log 2) 2^x\\ \end{aligned}",
      r"\text{Therefore, }\left(\displaystyle \frac {2^x}{\log 2}\right)' = 2^x",
      r"\text{Therefore, }\displaystyle \int 2^x\,dx = \displaystyle \frac{2^x}{\log 2} + C",
    ],
  ),

  // problems_abs_definite.dart
  "9477B6DC-F0A3-4B53-8891-212FED0C5886": ProblemTranslation(
    category: "Definite Integrals with Absolute Values",
    level: "Easy",
    question:
        r"""\displaystyle \int_{-1}^{1}\left|x^2-\displaystyle \frac{1}{4}\right|\,dx""",
    answer: r"""\displaystyle \frac{1}{2}""",

    hint:
        r"\text{Split the interval at the roots } x=\pm \displaystyle \frac{1}{2} \text{ into } \left[-1,-\displaystyle \frac{1}{2}\right],\left[-\displaystyle \frac{1}{2},\displaystyle \frac{1}{2}\right],\left[\displaystyle \frac{1}{2},1\right] \text{ and calculate.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Split the interval at the roots } x=\pm \displaystyle \frac{1}{2} \text{ into } \left[-1,-\displaystyle \frac{1}{2}\right],\left[-\displaystyle \frac{1}{2},\displaystyle \frac{1}{2}\right],\left[\displaystyle \frac{1}{2},1\right] \text{ and calculate.}",
      r"\textbf{[Key Point]}",
      r"\cdot\  x^2-\displaystyle \frac{1}{4}=0 \Leftrightarrow x=\pm\displaystyle \frac{1}{2} \text{. The sign changes at these points.}",
      r"\cdot \text{Integrate } \displaystyle \frac{1}{4}-x^2 \text{ in the middle interval, and } x^2-\displaystyle \frac{1}{4} \text{ in the outer intervals.}",
      r"\cdot \text{Since it is an even function, it is easier to convert the integration interval to } \displaystyle 0 \rightarrow 1 \text{.}",
      r"\textbf{[Explanation]}",
      r"\begin{aligned} \displaystyle \int_{-1}^{1}\left|x^2-\displaystyle \frac{1}{4}\right|\,dx &= 2\displaystyle \int_{0}^{1}\left|x^2-\displaystyle \frac{1}{4}\right|\,dx\\ &= 2\left(\displaystyle \int_{0}^{ \frac{1}{2}}\left(\displaystyle \frac{1}{4}-x^2\right)dx + \displaystyle \int_{ \frac{1}{2}}^{1}\left(x^2-\displaystyle \frac{1}{4}\right)dx\right)\\ &= 2\left(\left[\displaystyle \frac{x}{4}-\displaystyle \frac{x^3}{3}\right]_{0}^{ \frac{1}{2}} + \left[\displaystyle \frac{x^3}{3}-\displaystyle \frac{x}{4}\right]_{ \frac{1}{2}}^{1}\right)\\ &= 2\left(\left(\displaystyle \frac{1}{8}-\displaystyle \frac{1}{24}\right)-0 + \left(\left(\displaystyle \frac{1}{3}-\displaystyle \frac{1}{4}\right)-\left(\displaystyle \frac{1}{24}-\displaystyle \frac{1}{8}\right)\right)\right)\\ &= 2\left(\displaystyle \frac{1}{8}-\displaystyle \frac{1}{24} + \displaystyle \frac{1}{3}-\displaystyle \frac{1}{4} -\displaystyle \frac{1}{24} +\displaystyle \frac{1}{8}\right)\\ &= 2\left(\displaystyle \frac{1}{8}+\displaystyle \frac{1}{8} -\displaystyle \frac{1}{24}-\displaystyle \frac{1}{24} +\displaystyle \frac{1}{3}-\displaystyle \frac{1}{4}\right)\\ &= 2\left(\displaystyle \frac{2}{8} -\displaystyle \frac{2}{24} +\displaystyle \frac{1}{12}\right)\\ &= 2\left(\displaystyle \frac{1}{4} -\displaystyle \frac{1}{12} +\displaystyle \frac{1}{12}\right)\\ &= 2\left(\displaystyle \frac{1}{4}\right)\\ &= \displaystyle \frac{1}{2} \end{aligned}",
    ],
  ),

  // problems_linear_radical.dart
  "48615294-8E6C-4EFB-B9F9-5A08205FFF69": ProblemTranslation(
    category: "1st Order Radicals",
    level: "Easy",
    question:
        r"""\displaystyle \int_{0}^{2} \displaystyle \frac{dx}{\sqrt{2x + 5}}""",
    answer: r"""3-\sqrt{5}""",
    hint: r"\text{Use the substitution }u=2x+5\text{ (}du=2\,dx\text{).}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let }u=2x+5\text{, then }du=2\,dx\text{ and }dx=\displaystyle\frac{1}{2}\,du\text{.}",
      r"\textbf{[Calculation]}",
      r"\begin{aligned} \int_{0}^{2}\frac{dx}{\sqrt{2x+5}} &= \int_{u=5}^{u=9}\frac{1}{\sqrt{u}}\cdot\frac{1}{2}\,du \\ &= \frac{1}{2}\int_{5}^{9}u^{-1/2}\,du \\ &= \frac{1}{2}\left[\frac{u^{1/2}}{1/2}\right]_{5}^{9} = \left[\sqrt{u}\right]_{5}^{9} \\ &= \sqrt{9}-\sqrt{5}=3-\sqrt{5}. \end{aligned}",
    ],
  ),
  "383DCCBD-6B56-4171-856E-F14225EC83D8": ProblemTranslation(
    category: "1st Order Radicals",
    level: "Easy",
    question:
        r"""\displaystyle \int_{0}^{ \frac{1}{2}} \sqrt{1 - 2x}\,dx""",
    answer: r"""\displaystyle \frac{1}{3}""",
    hint: r"\text{Use the substitution }u=1-2x\text{ (}du=-2\,dx\text{).}",
    steps: [
      r"\textbf{[Substitution]}",
      r"\text{Let }u=1-2x\text{. Then }du=-2\,dx\text{ and }dx=-\displaystyle\frac{1}{2}\,du\text{.}",
      r"\textbf{[Calculation]}",
      r"\text{When }x:0\to \displaystyle\frac{1}{2}\text{, we have }u:1\to 0\text{, so}",
      r"\begin{aligned} \int_{0}^{1/2}\sqrt{1-2x}\,dx &= \int_{u=1}^{u=0}\sqrt{u}\cdot\left(-\frac{1}{2}\,du\right) \\ &= \frac{1}{2}\int_{0}^{1}u^{1/2}\,du = \frac{1}{2}\left[\frac{u^{3/2}}{3/2}\right]_{0}^{1} \\ &= \frac{1}{2}\cdot\frac{2}{3}=\frac{1}{3}. \end{aligned}",
    ],
  ),

  // problems_linear_radical_reserve.dart (reserve / commented-out in source)
  "D2B89DAA-E92F-42BE-84DB-BBBAA97CF300": ProblemTranslation(
    category: "1st Order Radicals",
    level: "Easy",
    question: r"""\displaystyle \int_{0}^{1} \sqrt{1+2x}\,dx""",
    answer: r"""\sqrt{3}-\displaystyle \frac{1}{3}""",
    hint: r"\text{Use the substitution }u=1+2x\text{ (}du=2\,dx\text{).}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let }u=1+2x\text{, then }du=2\,dx\text{ and }dx=\displaystyle\frac{1}{2}\,du\text{.}",
      r"\textbf{[Calculation]}",
      r"\begin{aligned} \int_{0}^{1}\sqrt{1+2x}\,dx &= \int_{u=1}^{u=3}\sqrt{u}\cdot\frac{1}{2}\,du \\ &= \frac{1}{2}\int_{1}^{3}u^{1/2}\,du = \frac{1}{2}\left[\frac{u^{3/2}}{3/2}\right]_{1}^{3} \\ &= \left[\frac{1}{3}u^{3/2}\right]_{1}^{3} = \frac{1}{3}\left(3^{3/2}-1\right) \\ &= \frac{1}{3}\left(3\sqrt{3}-1\right)=\sqrt{3}-\frac{1}{3}. \end{aligned}",
    ],
  ),

  // problems_abs_definite_reserve.dart (reserve / commented-out in source)
  "9CB65E9A-BFF7-4C9F-B331-B55CFA7448A1": ProblemTranslation(
    category: "Definite Integrals with Absolute Values",
    level: "Easy",
    question: r"""\displaystyle \int_{-2}^{3} |x| \, dx""",
    answer: r"""\displaystyle \frac{13}{2}""",
    hint:
        r"\text{Split the interval at }x=0\text{ using the piecewise definition of }|x|\text{.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use }|x|=\begin{cases}-x&(x<0)\\ x&(x\ge 0)\end{cases}\text{ and split }[-2,3]\text{ into }[-2,0]\text{ and }[0,3]\text{.}",
      r"\textbf{[Calculation]}",
      r"\begin{aligned} \int_{-2}^{3}|x|\,dx &= \int_{-2}^{0}(-x)\,dx + \int_{0}^{3}x\,dx \\ &= \left[-\frac{x^2}{2}\right]_{-2}^{0} + \left[\frac{x^2}{2}\right]_{0}^{3} \\ &= \left(0-\left(-\frac{4}{2}\right)\right) + \left(\frac{9}{2}-0\right) = \frac{4}{2}+\frac{9}{2}=\frac{13}{2}. \end{aligned}",
    ],
  ),
  "3CFA230C-2B50-4EE9-BE1B-46A6505BC279": ProblemTranslation(
    category: "Definite Integrals with Absolute Values",
    level: "Easy",
    question: r"""\displaystyle \int_{0}^{2\pi} |\sin x| \, dx""",
    answer: r"""\displaystyle 4""",
    hint:
        r"\text{Use that }\sin x\ge 0\text{ on }[0,\pi]\text{ and }\sin x\le 0\text{ on }[\pi,2\pi]\text{.}",
    steps: [
      r"\textbf{[Key Point]}",
      r"\text{On }[0,\pi]\text{, }|\sin x|=\sin x\text{. On }[\pi,2\pi]\text{, }|\sin x|=-\sin x\text{.}",
      r"\text{By symmetry, } \int_{0}^{2\pi}|\sin x|\,dx = 2\int_{0}^{\pi}\sin x\,dx\text{.}",
      r"\textbf{[Calculation]}",
      r"\begin{aligned} \int_{0}^{2\pi}|\sin x|\,dx &= \int_{0}^{\pi}\sin x\,dx + \int_{\pi}^{2\pi}(-\sin x)\,dx \\ &= 2\int_{0}^{\pi}\sin x\,dx = 2\left[-\cos x\right]_{0}^{\pi} \\ &= 2\left(-\cos\pi + \cos 0\right)=2(1+1)=4. \end{aligned}",
    ],
  ),

  // problems_exponential_fraction.dart
  "6FD0F698-5284-4008-A239-84083F7520B2": ProblemTranslation(
    category: "Exponential Rational Functions",
    level: "Easy",
    question:
        r"""\displaystyle \int_{0}^{\log 2} \displaystyle \frac{e^{2x}}{(1+e^x)^2}\,dx""",
    answer: r"""\log\!\displaystyle \frac{3}{2} - \displaystyle \frac{1}{6}
""",

    hint:
        r"\text{Use substitution } u=e^x \text{ to reduce to a rational function, then use } 1+u=w \text{ to evaluate the integral.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use substitution } u=e^x \text{ to reduce to a rational function, then use } 1+u=w \text{ to evaluate the integral.}",
      r"\textbf{[Explanation]}",
      r"\text{First, find the indefinite integral. Let } u=e^x, \text{ then } du=e^x\,dx.",
      r"\begin{aligned} \displaystyle \int \displaystyle \frac{e^{2x}}{(1+e^x)^2}\,dx &= \displaystyle \int \displaystyle \frac{e^x \cdot e^x}{(1+e^x)^2}\,dx\\ &= \displaystyle \int \displaystyle \frac{u}{(1+u)^2}\,du \end{aligned}",
      r"\text{Now, let } w=1+u \text{ (} dw=du \text{), then } u=w-1.",
      r"\begin{aligned} \displaystyle \int \displaystyle \frac{u}{(1+u)^2}\,du &= \displaystyle \int \displaystyle \frac{w-1}{w^2}\,dw\\ &= \displaystyle \int \left(\displaystyle \frac{1}{w} - \displaystyle \frac{1}{w^2}\right)\,dw\\ &= \log w + \displaystyle \frac{1}{w} + C\\ &= \log(1+u) + \displaystyle \frac{1}{1+u} + C\\ &= \log(1+e^x) + \displaystyle \frac{1}{1+e^x} + C \end{aligned}",
      r"\text{Therefore, the definite integral is:}",
      r"\begin{aligned} &\ \ \ \displaystyle \int_{0}^{\log 2} \displaystyle \frac{e^{2x}}{(1+e^x)^2}\,dx \\ &= \left[\log(1+e^x) + \displaystyle \frac{1}{1+e^x}\right]_{0}^{\log 2}\\ &= \left(\log(1+e^{\log 2}) + \displaystyle \frac{1}{1+e^{\log 2}}\right) - \left(\log(1+e^0) + \displaystyle \frac{1}{1+e^0}\right)\\ &= \left(\log(1+2) + \displaystyle \frac{1}{1+2}\right) - \left(\log(1+1) + \displaystyle \frac{1}{1+1}\right)\\ &= \left(\log 3 + \displaystyle \frac{1}{3}\right) - \left(\log 2 + \displaystyle \frac{1}{2}\right)\\ &= \log\!\displaystyle \frac{3}{2} + \left(\displaystyle \frac{1}{3} - \displaystyle \frac{1}{2}\right)\\ &= \log\!\displaystyle \frac{3}{2} - \displaystyle \frac{1}{6} \end{aligned}",
    ],
  ),

  "A370BF54-FFB7-4B23-BFA7-522C277250B8": ProblemTranslation(
    category: "Exponential Rational Functions",
    level: "Mid",
    question:
        r"""\displaystyle \int_{0}^{ \frac{\log 3}{2}} \displaystyle \frac{2}{e^x+e^{-x}}dx""",
    answer: r"""\displaystyle \frac{\pi}{6}""",
    hint:
        r"\text{Multiply numerator and denominator by }e^x\text{ and use }u=e^x\text{.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Multiply numerator and denominator by }e^x\text{ to get } \dfrac{e^x}{1+e^{2x}}\text{, then use }u=e^x\text{.}",
      r"\textbf{[Explanation]}",
      r"""\begin{aligned}
\displaystyle \int_{0}^{ \frac{\log 3}{2}} \frac{2}{e^x+e^{-x}}\,dx
&= 2\int_{0}^{ \frac{\log 3}{2}} \frac{dx}{e^x+e^{-x}}\\
&= 2\int_{0}^{ \frac{\log 3}{2}} \frac{e^x}{1+e^{2x}}\,dx
\end{aligned}""",
      r"\text{Let }u=e^x\text{. Then }du=e^x\,dx\text{ and }x:0\to \dfrac{\log 3}{2}\text{ gives }u:1\to \sqrt{3}\text{.}",
      r"""\begin{aligned}
&= 2\int_{1}^{\sqrt{3}} \frac{1}{1+u^2}\,du
\end{aligned}""",
      r"\text{Now let }u=\tan\theta\text{. Then }du=\dfrac{1}{\cos^2\theta}\,d\theta\text{ and }1+\tan^2\theta=\dfrac{1}{\cos^2\theta}\text{.}",
      r"\text{When }u:1\to\sqrt{3}\text{, we have }\theta:\dfrac{\pi}{4}\to\dfrac{\pi}{3}\text{.}",
      r"""\begin{aligned}
&= 2\int_{\frac{\pi}{4}}^{\frac{\pi}{3}} \frac{1}{1+\tan^2\theta}\cdot \frac{1}{\cos^2\theta}\,d\theta\\
&= 2\int_{\frac{\pi}{4}}^{\frac{\pi}{3}} 1\,d\theta
= 2\left[\theta\right]_{\frac{\pi}{4}}^{\frac{\pi}{3}}
= 2\left(\frac{\pi}{3}-\frac{\pi}{4}\right)
= \frac{\pi}{6}
\end{aligned}""",
      r"\textbf{[Supplement]}",
      r"\text{Using hyperbolic functions gives an alternative viewpoint.}",
      r"\text{By definition, } \cosh x=\dfrac{e^x+e^{-x}}{2}\text{, so }e^x+e^{-x}=2\cosh x\text{.}",
      r"""\begin{aligned}
\int \frac{2\,dx}{e^x+e^{-x}}
&= 2\int \frac{dx}{e^x+e^{-x}}
= 2\int \frac{dx}{2\cosh x}
= \int \frac{dx}{\cosh x}
\end{aligned}""",
      r"\text{With }u=e^x\text{ and then }u=\tan\theta\text{, the integrand reduces to }2\,d\theta\text{.}",
      r"""\begin{aligned}
\int \frac{2\,dx}{e^x+e^{-x}}
&= \int 2\,d\theta
= 2\theta + C
= 2\arctan(u)+C
= 2\arctan(e^x)+C
\end{aligned}""",
      r"""\text{Therefore,}\quad \int \frac{2\,dx}{e^x+e^{-x}} = 2\arctan(e^x)+C\text{.}""",
    ],
  ),
  // problems_exponential_fraction_reserve.dart (reserve / commented-out in source)
  "9C1AF019-A9BA-4C1A-B3ED-4BA5638B1D07": ProblemTranslation(
    category: "Exponential Rational Functions",
    level: "Easy",
    question:
        r"""\displaystyle \int_{0}^{\log 2} \displaystyle \frac{1}{1+e^{-x}}\,dx""",
    answer: r"""\log\!\left(\displaystyle \frac{3}{2}\right)""",
    hint:
        r"\text{Rewrite }\displaystyle\frac{1}{1+e^{-x}}=\displaystyle\frac{e^x}{1+e^x}\text{ and use }u=1+e^x\text{.}",
    steps: [
      r"\textbf{[Rewrite]}",
      r"\begin{aligned} \int \frac{1}{1+e^{-x}}\,dx = \int \frac{e^x}{1+e^x}\,dx. \end{aligned}",
      r"\textbf{[Substitution]}",
      r"\text{Let }u=1+e^x\text{, so }du=e^x\,dx\text{.}",
      r"\begin{aligned} \int \frac{e^x}{1+e^x}\,dx = \int \frac{du}{u} = \log u + C = \log(1+e^x)+C. \end{aligned}",
      r"\textbf{[Evaluate]}",
      r"\begin{aligned} \int_{0}^{\log 2}\frac{1}{1+e^{-x}}\,dx &= \left[\log(1+e^x)\right]_{0}^{\log 2} \\ &= \log(1+2)-\log(1+1)=\log 3-\log 2=\log\!\left(\frac{3}{2}\right). \end{aligned}",
    ],
  ),

  // problems_polynomial_fraction.dart
  "4E93591C-AFE6-41F0-A2E9-4A32C796D02B": ProblemTranslation(
    category: "Rational Functions",
    level: "Easy",
    question:
        r"""\displaystyle \int_{1}^{\sqrt{3}}\displaystyle \frac{1}{x^{2}+3}\,dx""",
    answer: r""" \displaystyle \frac{\pi}{12\sqrt{3}}""",

    hint:
        r"\text{Use substitution } x=\sqrt{3}\tan\theta \text{ where } \theta\in(0, \frac{\pi}{2}).",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use substitution } x=\sqrt{3}\tan\theta \text{ where } \theta\in(0, \frac{\pi}{2}).",
      r"\textbf{[Substitution and Interval Conversion]}",
      r"\text{Let } x=\sqrt{3}\tan\theta, \text{ then } dx=\sqrt{3}\frac{1}{\cos^2\theta}\,d\theta. \text{ When } x=1\rightarrow \sqrt{3}, \tan\theta=\frac{1}{\sqrt{3}}\rightarrow 1, \text{ so } \theta=\frac{\pi}{6}\rightarrow \frac{\pi}{4}.",
      r"\textbf{[Calculation]}",
      r"\text{Using substitution } x=\sqrt{3}\tan\theta \text{ and } dx=\sqrt{3}\frac{1}{\cos^2\theta}\,d\theta:",
      r"\begin{aligned} x^2+3 &= (\sqrt{3}\tan\theta)^2 + 3\\ &= 3\tan^2\theta + 3\\ &= 3(\tan^2\theta + 1)\\ &= 3\cdot\displaystyle \frac{1}{\cos^2\theta} \end{aligned}",
      r"\text{Substituting } x=\sqrt{3}\tan\theta \text{ and } dx=\sqrt{3}\frac{1}{\cos^2\theta}\,d\theta:",
      r"\begin{aligned} &\displaystyle \int_{1}^{\sqrt{3}}\displaystyle \frac{1}{x^{2}+3}\,dx\\ &=\displaystyle \int_{\frac \pi 6}^{\frac \pi 4}\displaystyle \frac{1}{3\cdot\displaystyle \frac{1}{\cos^2\theta}}\cdot\sqrt{3}\displaystyle \frac{1}{\cos^2\theta}\,d\theta\\[6pt] &=\displaystyle \int_{\frac \pi 6}^{\frac \pi 4}\displaystyle \frac{\cos^2\theta}{3}\cdot\sqrt{3}\displaystyle \frac{1}{\cos^2\theta}\,d\theta\\[6pt] &=\displaystyle \int_{\frac \pi 6}^{\frac \pi 4}\displaystyle \frac{\sqrt{3}}{3}\,d\theta\\[6pt] &=\displaystyle \frac{1}{\sqrt{3}}\displaystyle \int_{\frac \pi 6}^{\frac \pi 4} d\theta\\[6pt] &=\displaystyle \frac{1}{\sqrt{3}}\left(\displaystyle \frac{\pi}{4}-\displaystyle \frac{\pi}{6}\right)\\[6pt] &=\displaystyle \frac{1}{\sqrt{3}}\cdot\displaystyle \frac{\pi}{12}\\[6pt] &=\displaystyle \frac{\pi}{12\sqrt{3}} \end{aligned}",
      r"\textbf{[Supplement: Inverse Trigonometric Functions]}",
      r"\text{We can use the arctangent function } \arctan x\text{. Its domain is }(-\infty,\infty)\text{ and its range is }\left(-\displaystyle\frac{\pi}{2},\displaystyle\frac{\pi}{2}\right)\text{.}",
      r"\text{Using the formula } \displaystyle \int\displaystyle \frac{dx}{x^2+a^2}=\displaystyle \frac{1}{a}\arctan\displaystyle \frac{x}{a}+C, \text{ where } x^2+3=x^2+(\sqrt{3})^2, \text{ so } a=\sqrt{3}.",
      r"\text{First, find the indefinite integral:}",
      r"\begin{aligned} \displaystyle \int\displaystyle \frac{dx}{x^2+3} &= \displaystyle \int\displaystyle \frac{dx}{x^2+(\sqrt{3})^2}\\ &= \displaystyle \frac{1}{\sqrt{3}}\arctan\displaystyle \frac{x}{\sqrt{3}} + C \end{aligned}",
      r"\text{Therefore, the definite integral is:}",
      r"\begin{aligned} \displaystyle \int_{1}^{\sqrt{3}}\displaystyle \frac{1}{x^{2}+3}\,dx &= \left[\displaystyle \frac{1}{\sqrt{3}}\arctan\displaystyle \frac{x}{\sqrt{3}}\right]_{1}^{\sqrt{3}}\\ &= \displaystyle \frac{1}{\sqrt{3}}\left(\arctan\displaystyle \frac{\sqrt{3}}{\sqrt{3}} - \arctan\displaystyle \frac{1}{\sqrt{3}}\right)\\ &= \displaystyle \frac{1}{\sqrt{3}}\left(\arctan 1 - \arctan\displaystyle \frac{1}{\sqrt{3}}\right)\\ &= \displaystyle \frac{1}{\sqrt{3}}\left(\displaystyle \frac{\pi}{4} - \displaystyle \frac{\pi}{6}\right)\\ &= \displaystyle \frac{1}{\sqrt{3}}\cdot\displaystyle \frac{\pi}{12}\\ &= \displaystyle \frac{\pi}{12\sqrt{3}} \end{aligned}",
    ],
  ),

  "C08EC860-F248-4E0A-90FD-F321E66616A4": ProblemTranslation(
    category: "Rational Functions (Completing the Square)",
    level: "Mid",
    question:
        r"""\displaystyle \int_{-1}^{1}\displaystyle \frac{1}{x^{2}+2x+5}\,dx""",
    answer: r"""\displaystyle \frac{\pi}{8}""",
    steps: [
      r"\textbf{[Idea]}",
      r"\text{Complete the square: }x^2+2x+5=(x+1)^2+4\text{, then use }x+1=2\tan\theta\text{.}",
      r"\text{Let }x+1=2\tan\theta\text{, so }dx=2\displaystyle\frac{1}{\cos^2\theta}\,d\theta\text{.}",
      r"\text{When }x=-1\to 1\text{, } \tan\theta=0\to 1\text{, so } \theta=0\to \displaystyle\frac{\pi}{4}\text{.}",
      r"\begin{aligned} \int_{-1}^{1}\frac{1}{x^2+2x+5}\,dx &= \int_{-1}^{1}\frac{1}{(x+1)^2+4}\,dx \\ &= \int_{0}^{\pi/4}\frac{1}{(2\tan\theta)^2+4}\cdot 2(1+\tan^2\theta)\,d\theta \\ &= \int_{0}^{\pi/4}\frac{2(1+\tan^2\theta)}{4(1+\tan^2\theta)}\,d\theta \\ &= \int_{0}^{\pi/4}\frac{1}{2}\,d\theta = \frac{1}{2}\cdot\frac{\pi}{4}=\frac{\pi}{8}. \end{aligned}",
      r"\textbf{[Remark]}",
      r"\text{Equivalently, set } \theta=\arctan\left(\displaystyle\frac{x+1}{2}\right)\text{.}",
      r"\text{Then } \displaystyle \int \frac{dx}{(x+1)^2+4} = \displaystyle\frac{1}{2}\arctan\left(\displaystyle\frac{x+1}{2}\right)+C\text{.}",
    ],
  ),

  "8FB8536A-3433-4F7A-8B29-B44DC4186F09": ProblemTranslation(
    category: "Partial Fractions",
    level: "Mid",
    question:
        r"""\displaystyle \int_{3}^{6}\displaystyle \frac{1}{x^{2}-4}\,dx""",
    answer: r"""\displaystyle \frac{1}{4}\log\displaystyle \frac{5}{2}""",
    hint:
        r"\text{Factor }x^2-4=(x-2)(x+2)\text{ and use partial fraction decomposition.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Factor }x^2-4=(x-2)(x+2)\text{ and use partial fraction decomposition.}",
      r"\textbf{[Partial Fractions]}",
      r"\text{Factor the denominator: } x^2-4=(x-2)(x+2)\text{.}",
      r"\text{Set up:}",
      r"\displaystyle \frac{1}{x^2-4}=\displaystyle \frac{A}{x-2}+\displaystyle \frac{B}{x+2}",
      r"\text{Multiply both sides by } (x-2)(x+2)\text{:}",
      r"1=A(x+2)+B(x-2)",
      r"\text{Expand the right-hand side:}",
      r"1=(A+B)x+(2A-2B)",
      r"\text{Compare coefficients:}",
      r"""\begin{cases}
A+B=0\\
2A-2B=1
\end{cases}""",
      r"\text{Solving gives } A=\displaystyle \frac{1}{4},\ B=-\displaystyle \frac{1}{4}\text{.}",
      r"\text{Therefore,}",
      r"\displaystyle \frac{1}{x^2-4}=\displaystyle \frac{1}{4}\cdot\displaystyle \frac{1}{x-2}-\displaystyle \frac{1}{4}\cdot\displaystyle \frac{1}{x+2}",
      r"\textbf{[Integration]}",
      r"\text{Compute the indefinite integral:}",
      r"""\begin{aligned}
\displaystyle \int\displaystyle \frac{1}{x^{2}-4}\,dx
&=\displaystyle \int\left(\displaystyle \frac{1}{4}\cdot\displaystyle \frac{1}{x-2}-\displaystyle \frac{1}{4}\cdot\displaystyle \frac{1}{x+2}\right)dx\\[6pt]
&=\displaystyle \frac{1}{4}\int\displaystyle \frac{1}{x-2}\,dx-\displaystyle \frac{1}{4}\int\displaystyle \frac{1}{x+2}\,dx\\[6pt]
&=\displaystyle \frac{1}{4}\log|x-2|-\displaystyle \frac{1}{4}\log|x+2|+C\\[6pt]
&=\displaystyle \frac{1}{4}\log\left|\displaystyle \frac{x-2}{x+2}\right|+C
\end{aligned}""",
      r"\textbf{[Definite Integral]}",
      r"\text{On }[3,6]\text{ we have }x-2>0,\ x+2>0\text{, so absolute values are unnecessary.}",
      r"""\begin{aligned}
\displaystyle \int_{3}^{6}\displaystyle \frac{1}{x^{2}-4}\,dx
&=\left[\displaystyle \frac{1}{4}\log\displaystyle \frac{x-2}{x+2}\right]_{3}^{6}\\[6pt]
&=\displaystyle \frac{1}{4}\left(\log\displaystyle \frac{6-2}{6+2}-\log\displaystyle \frac{3-2}{3+2}\right)\\[6pt]
&=\displaystyle \frac{1}{4}\left(\log\displaystyle \frac{4}{8}-\log\displaystyle \frac{1}{5}\right)\\[6pt]
&=\displaystyle \frac{1}{4}\left(\log\displaystyle \frac{1}{2}-\log\displaystyle \frac{1}{5}\right)\\[6pt]
&=\displaystyle \frac{1}{4}\log\displaystyle \frac{5}{2}
\end{aligned}""",
    ],
  ),

  "A36F411F-99B5-40E0-8BE1-F9126992BA14": ProblemTranslation(
    category: "Partial Fractions (Rational Function)",
    level: "Advanced",
    question:
        r"""\displaystyle \int_{0}^{1}\displaystyle \frac{1}{1+x^{3}}\,dx""",
    answer:
        r"""\displaystyle \frac{1}{3}\log 2+\displaystyle \frac{\pi}{3\sqrt{3}}""",
    hint:
        r"\text{Factor }1+x^3=(1+x)(1-x+x^2)\text{ and use partial fractions.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Factor }1+x^3=(1+x)(1-x+x^2)\text{, use partial fractions, find antiderivatives, then evaluate the definite integral.}",
      r"\textbf{[Partial Fractions]}",
      r"\text{Factor the denominator: } 1+x^3=(1+x)(1-x+x^2)\text{.}",
      r"\text{Set up:}",
      r"\displaystyle \frac{1}{1+x^3}=\displaystyle \frac{A}{1+x}+\displaystyle \frac{Bx+C}{1-x+x^2}",
      r"\text{Multiply both sides by } (1+x)(1-x+x^2)\text{:}",
      r"1=A(1-x+x^2)+(Bx+C)(1+x)",
      r"\text{Expand the right-hand side:}",
      r"""\begin{aligned}
1&=A(1-x+x^2)+(Bx+C)(1+x)\\
&=A-Ax+Ax^2+Bx+Bx^2+C+Cx\\
&=(A+C)+(-A+B+C)x+(A+B)x^2
\end{aligned}""",
      r"\text{Compare coefficients:}",
      r"""\begin{cases}
A+C=1\\
-A+B+C=0\\
A+B=0
\end{cases}""",
      r"\text{Solving gives } A=\displaystyle \frac{1}{3},\ B=-\displaystyle \frac{1}{3},\ C=\displaystyle \frac{2}{3}\text{.}",
      r"\text{Therefore,}",
      r"\displaystyle \frac{1}{1+x^3}=\displaystyle \frac{1}{3}\cdot\displaystyle \frac{1}{1+x}+\displaystyle \frac{-x+2}{3(1-x+x^2)}",
      r"\textbf{[Rewrite the second term]}",
      r"\text{We split the numerator so that one part is proportional to the derivative of the denominator, producing a logarithm. Since }(1-x+x^2)'=2x-1\text{:}",
      r"\text{Let } -x+2=\alpha(2x-1)+\beta\text{.}",
      r"\text{Expand the right-hand side:}",
      r"""\begin{aligned}
-x+2&=2\alpha x-\alpha+\beta\\
&=(2\alpha)x+(-\alpha+\beta)
\end{aligned}""",
      r"\text{Compare coefficients:}",
      r"""\begin{cases}
2\alpha=-1\\
-\alpha+\beta=2
\end{cases}""",
      r"\text{Solving gives } \alpha=-\displaystyle \frac{1}{2},\ \beta=\displaystyle \frac{3}{2}\text{.}",
      r"\text{Therefore,}",
      r"""\begin{aligned}
\displaystyle \frac{-x+2}{3(1-x+x^2)}
&=-\displaystyle \frac{1}{6}\cdot\displaystyle \frac{2x-1}{1-x+x^2}+\displaystyle \frac{1}{2}\cdot\displaystyle \frac{1}{1-x+x^2}
\end{aligned}""",
      r"\textbf{[Evaluate the definite integral]}",
      r"\text{By the partial fraction decomposition, the integral becomes a sum of three integrals:}",
      r"""\begin{aligned}
\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{1+x^{3}}
&=\displaystyle \frac{1}{3}\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{1+x}-\displaystyle \frac{1}{6}\displaystyle \int_{0}^{1}\displaystyle \frac{2x-1}{1-x+x^2}dx+\displaystyle \frac{1}{2}\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{1-x+x^2}
\end{aligned}""",
      r"\textcolor{blue}{\textbf{[Compute\ Term\ 1]}}",
      r"""\begin{aligned}
\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{1+x}
&=\left[\log(1+x)\right]_{0}^{1}\\[6pt]
&=\log 2-\log 1\\[6pt]
&=\log 2
\end{aligned}""",
      r"\textcolor{blue}{\textbf{[Compute\ Term\ 2]}}",
      r"\text{Since the derivative of } 1-x+x^2 \text{ is } 2x-1\text{, we have}",
      r"""\begin{aligned}
\displaystyle \int_{0}^{1}\displaystyle \frac{2x-1}{1-x+x^2}dx
&=\left[\log(1-x+x^2)\right]_{0}^{1}\\[6pt]
&=\log(1-1+1)-\log(1-0+0)\\[6pt]
&=\log 1-\log 1\\[6pt]
&=0
\end{aligned}""",
      r"\textcolor{blue}{\textbf{[Compute\ Term\ 3]}}",
      r"\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{1-x+x^2} =\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{\left(x-\displaystyle \frac{1}{2}\right)^2+\left(\displaystyle \frac{\sqrt{3}}{2}\right)^2}",
      r"\text{Now change variables } x=\displaystyle \frac{1}{2}+\displaystyle \frac{\sqrt{3}}{2}u\text{. Then } dx=\displaystyle \frac{\sqrt{3}}{2}du\text{.}",
      r"""\text{Convert bounds: }
\begin{aligned}
\begin{cases}
x=0 \Leftrightarrow u=-\displaystyle \frac{1}{\sqrt{3}},\\[5pt]
x=1 \Leftrightarrow u=\displaystyle \frac{1}{\sqrt{3}}
\end{cases}
\end{aligned}""",
      r"\text{Therefore,}",
      r"""\begin{aligned}
&=\displaystyle \int_{-\frac{1}{\sqrt{3}}}^{\frac{1}{\sqrt{3}}}\displaystyle \frac{\displaystyle \frac{\sqrt{3}}{2}du}{\left(\displaystyle \frac{\sqrt{3}}{2}u\right)^2+\left(\displaystyle \frac{\sqrt{3}}{2}\right)^2}\\[6pt]
&=\displaystyle \int_{-\frac{1}{\sqrt{3}}}^{\frac{1}{\sqrt{3}}}\displaystyle \frac{\displaystyle \frac{\sqrt{3}}{2}du}{\displaystyle \frac{3}{4}(u^2+1)}\\[6pt]
&=\displaystyle \frac{2}{\sqrt{3}}\displaystyle \int_{-\frac{1}{\sqrt{3}}}^{\frac{1}{\sqrt{3}}}\displaystyle \frac{du}{u^2+1}
\end{aligned}""",
      r"\text{To compute } \displaystyle \int\displaystyle \frac{du}{u^2+1}\text{, set } u=\tan\theta\text{.}",
      r"""\text{Convert bounds: }
\begin{aligned}
\begin{cases}
u=-\displaystyle \frac{1}{\sqrt{3}} \Leftrightarrow \theta=-\displaystyle \frac{\pi}{6},\\[5pt]
u=\displaystyle \frac{1}{\sqrt{3}} \Leftrightarrow \theta=\displaystyle \frac{\pi}{6}
\end{cases}
\end{aligned}""",
      r"""\begin{aligned}
\displaystyle \frac{2}{\sqrt{3}}\displaystyle \int_{-\frac{1}{\sqrt{3}}}^{\frac{1}{\sqrt{3}}}\displaystyle \frac{du}{u^2+1}
&=\displaystyle \frac{2}{\sqrt{3}}\displaystyle \int_{-\frac{\pi}{6}}^{\frac{\pi}{6}}\displaystyle \frac{\displaystyle \frac{1}{\cos^2\theta}d\theta}{\tan^2\theta+1}\\[6pt]
&=\displaystyle \frac{2}{\sqrt{3}}\displaystyle \int_{-\frac{\pi}{6}}^{\frac{\pi}{6}}d\theta\\[6pt]
&=\displaystyle \frac{2}{\sqrt{3}}\left(\displaystyle \frac{\pi}{6}-\left(-\displaystyle \frac{\pi}{6}\right)\right)\\[6pt]
&=\displaystyle \frac{2}{\sqrt{3}}\cdot\displaystyle \frac{\pi}{3}\\[6pt]
&=\displaystyle \frac{2\pi}{3\sqrt{3}}
\end{aligned}""",
      r"\textbf{[Summary]}",
      r"\text{Combine the three parts:}",
      r"""\begin{aligned}
\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{1+x^{3}}
&=\displaystyle \frac{1}{3}\cdot\log 2-\displaystyle \frac{1}{6}\cdot 0+\displaystyle \frac{1}{2}\cdot\displaystyle \frac{2\pi}{3\sqrt{3}}\\[6pt]
&=\displaystyle \frac{1}{3}\log 2+\displaystyle \frac{\pi}{3\sqrt{3}}
\end{aligned}""",
    ],
  ),
  // problems_beta_function.dart
  "A056E0E4-7F5B-4EC7-ACC2-F91C38585F7E": ProblemTranslation(
    category: "Polynomial Type (Numerical Calculation)",
    level: "Easy",
    question: r"""\displaystyle \int_{2}^{5}(x-2)(5-x)\,dx
""",
    answer: r""" 
\displaystyle \frac{9}{2}
""",

    hint:
        r'\text{Use the 1/6 rule: } \displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)\,dx = \frac{(\beta-\alpha)^3}{6}\text{.}',
    steps: [
      r"\textbf{[Strategy]}",
      r'\text{Use the 1/6 rule: } \displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)\,dx = \frac{(\beta-\alpha)^3}{6}\text{.}',
      r"\textbf{[Calculation using formula]}",
      r"\begin{aligned} &\displaystyle \int_{2}^{5}(x-2)(5-x)\,dx\\ =&(5-2)^3\cdot\displaystyle \frac{1}{6}\\ =&3^3\cdot\displaystyle \frac{1}{6}\\ =&\displaystyle \frac{27}{6}=\displaystyle \frac{9}{2} \end{aligned}",
      r"\textbf{[Proposition]}",
      r"\displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)\,dx = \displaystyle \frac{(\beta-\alpha)^3}{6}",
      r"\textbf{[Proof 1: Proof by integration by parts]}",
      r"\begin{aligned} &\displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)\,dx\\ =&\displaystyle \int_{\alpha}^{\beta}\left(\displaystyle \frac{(x-\alpha)^2}{2}\right)'(\beta-x)\,dx\\ =& \left[\displaystyle \frac{(x-\alpha)^2}{2}(\beta-x)\right]_{\alpha}^{\beta} -\displaystyle \int_{\alpha}^{\beta}\displaystyle \frac{(x-\alpha)^2}{2}\,(-1)\,dx\\ =& \displaystyle \frac{1}{2}\displaystyle \int_{\alpha}^{\beta}(x-\alpha)^2\,dx\\ =& \displaystyle \frac{1}{2}\left[\displaystyle \frac{(x-\alpha)^3}{3}\right]_{\alpha}^{\beta}\\ =& \displaystyle \frac{(\beta-\alpha)^3}{6} \end{aligned}",
      r"\textbf{[Proof 2: Proof by expanding and calculating]}",
      r"\begin{aligned} &\displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)\,dx\\ =&\displaystyle \int_{\alpha}^{\beta}\left((x-\alpha)\beta-(x-\alpha)x\right)\,dx\\ =&\displaystyle \int_{\alpha}^{\beta}\left(\beta(x-\alpha)-x(x-\alpha)\right)\,dx\\ =&\displaystyle \int_{\alpha}^{\beta}\left(\beta(x-\alpha)-x^2+\alpha x\right)\,dx\\ =&\displaystyle \int_{\alpha}^{\beta}\left(\beta x-\alpha\beta-x^2+\alpha x\right)\,dx\\ =&\displaystyle \int_{\alpha}^{\beta}\left((\beta+\alpha)x-\alpha\beta-x^2\right)\,dx\\ =&\left[\displaystyle \frac{(\beta+\alpha)x^2}{2}-\alpha\beta x-\displaystyle \frac{x^3}{3}\right]_{\alpha}^{\beta}\\ =&\displaystyle \frac{(\beta+\alpha)\beta^2}{2}-\alpha\beta^2-\displaystyle \frac{\beta^3}{3}-\displaystyle \frac{(\beta+\alpha)\alpha^2}{2}+\alpha^2\beta+\displaystyle \frac{\alpha^3}{3}\\ =&\displaystyle \frac{(\beta+\alpha)(\beta^2-\alpha^2)}{2}-\alpha\beta(\beta-\alpha)-\displaystyle \frac{\beta^3-\alpha^3}{3}\\ =&\displaystyle \frac{(\beta+\alpha)(\beta-\alpha)(\beta+\alpha)}{2}-\alpha\beta(\beta-\alpha)-\displaystyle \frac{(\beta-\alpha)(\beta^2+\alpha\beta+\alpha^2)}{3}\\ =&(\beta-\alpha)\left[\displaystyle \frac{(\beta+\alpha)^2}{2}-\alpha\beta-\displaystyle \frac{\beta^2+\alpha\beta+\alpha^2}{3}\right]\\ =&(\beta-\alpha)\left[\displaystyle \frac{3(\beta+\alpha)^2-6\alpha\beta-2(\beta^2+\alpha\beta+\alpha^2)}{6}\right]\\ =&(\beta-\alpha)\left[\displaystyle \frac{3\beta^2+6\alpha\beta+3\alpha^2-6\alpha\beta-2\beta^2-2\alpha\beta-2\alpha^2}{6}\right]\\ =&(\beta-\alpha)\left[\displaystyle \frac{\beta^2-2\alpha\beta+\alpha^2}{6}\right]\\ =&(\beta-\alpha)\left[\displaystyle \frac{(\beta-\alpha)^2}{6}\right]\\ =&\displaystyle \frac{(\beta-\alpha)^3}{6} \end{aligned}",
    ],
  ),
  "6705BE2F-10DF-484F-8E32-768EE0F07E15": ProblemTranslation(
    category: "Polynomial Type (Numerical Calculation)",
    level: "Mid",
    question:
        r"""\displaystyle \int_{ \frac12}^{ \frac32}\left(x-\displaystyle \frac12\right)\left(\displaystyle \frac32-x\right)^2\,dx
""",
    answer: r""" 
\displaystyle \frac{1}{12}
""",

    hint:
        r'\text{Use the 1/12 rule: } \displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)^2\,dx = \frac{(\beta-\alpha)^4}{12}\text{.}',
    steps: [
      r"\textbf{[Strategy]}",
      r'\text{Use the 1/12 rule: } \displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)^2\,dx = \frac{(\beta-\alpha)^4}{12}\text{.}',
      r"\textbf{[Calculation using formula]}",
      r"\begin{aligned} &\displaystyle \int_{ \frac 1 2}^{ \frac 3 2}\left(x-\displaystyle \frac 1 2\right)\left(\displaystyle \frac 3 2-x\right)^2\,dx\\ =&\left(\displaystyle \frac 3 2 - \displaystyle \frac 1 2\right)^4\cdot\displaystyle \frac{1}{12}\\ =&\displaystyle \frac{1}{12} \end{aligned}",
      r"\textbf{[Proposition]}",
      r"\displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)^2\,dx = \displaystyle \frac{(\beta-\alpha)^4}{12}",
      r"\textbf{[Proof]}",
      r"\begin{aligned} &\displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)^2\,dx\\ =&\displaystyle \int_{\alpha}^{\beta} (x-\alpha) \left(-\displaystyle \frac{(\beta-x)^3}{3}\right)'\,dx\\ =& \left[-\displaystyle \frac{(\beta-x)^3}{3}(x-\alpha)\right]_{\alpha}^{\beta} -\displaystyle \int_{\alpha}^{\beta} 1 \cdot \left(-\displaystyle \frac{(\beta-x)^3}{3}\right)\,dx \end{aligned}",
      r"\text{(The boundary terms are 0 at both ends, so only the following calculation remains.)}",
      r"\begin{aligned} =& \displaystyle \frac{1}{3}\displaystyle \int_{\alpha}^{\beta}(\beta-x)^3\,dx\\ =& \displaystyle \frac{1}{3}\left[-\displaystyle \frac{(\beta-x)^4}{4}\right]_{\alpha}^{\beta}\\ =& \displaystyle \frac{(\beta-\alpha)^4}{12} \end{aligned}",
    ],
  ),
  "48B05BE5-7632-4228-BF46-F8476E23E0CF": ProblemTranslation(
    category: "Polynomial Type (Numerical Calculation)",
    level: "Advanced",
    question: r"""\displaystyle \int_{2}^{5}(x-2)^2(5-x)^2\,dx
""",
    answer: r""" 
\displaystyle \frac{81}{10}
""",

    hint:
        r'\text{Use the 1/30 rule: } \displaystyle \int_{\alpha}^{\beta}(x-\alpha)^2(\beta-x)^2\,dx = \frac{(\beta-\alpha)^5}{30}\text{.}',
    steps: [
      r"\textbf{[Strategy]}",
      r'\text{Use the 1/30 rule: } \displaystyle \int_{\alpha}^{\beta}(x-\alpha)^2(\beta-x)^2\,dx = \frac{(\beta-\alpha)^5}{30}\text{.}',
      r"\textbf{[Calculation using formula]}",
      r"\begin{aligned} &\displaystyle \int_{2}^{5}(x-2)^2(5-x)^2\,dx\\=&3^5\cdot\displaystyle \frac{1}{30}\\ =&243\cdot\displaystyle \frac{1}{30}\\ =&\displaystyle \frac{243}{30}\\ =&\displaystyle \frac{81}{10} \end{aligned}",
      r"\textbf{[Proposition]}",
      r"\displaystyle \int_{\alpha}^{\beta}(x-\alpha)^2(\beta-x)^2\,dx = \displaystyle \frac{(\beta-\alpha)^5}{30}",
      r"\textbf{[Proof]}",
      r"\begin{aligned} &\displaystyle \int_{\alpha}^{\beta}(x-\alpha)^2(\beta-x)^2\,dx\\ =&\displaystyle \int_{\alpha}^{\beta}(x-\alpha)^2\left(-\displaystyle \frac{(\beta-x)^3}{3}\right)'\,dx\\ =& \left[(x-\alpha)^2\left(-\displaystyle \frac{(\beta-x)^3}{3}\right)\right]_{\alpha}^{\beta} -\displaystyle \int_{\alpha}^{\beta} 2(x-\alpha)\cdot \left(-\displaystyle \frac{(\beta-x)^3}{3}\right)\,dx\\ &\text{(The boundary terms are 0 at both ends)} \end{aligned}",
      r"\begin{aligned} =& \displaystyle \frac{2}{3}\displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)^3\,dx\\ =& \displaystyle \frac{2}{3}\displaystyle \int_{\alpha}^{\beta}(x-\alpha)\left(-\displaystyle \frac{(\beta-x)^4}{4}\right)'\,dx\\ =& \displaystyle \frac{2}{3}\left(\left[(x-\alpha)\left(-\displaystyle \frac{(\beta-x)^4}{4}\right)\right]_{\alpha}^{\beta} -\displaystyle \int_{\alpha}^{\beta}\left(-1 \cdot \displaystyle \frac{(\beta-x)^4}{4}\right)\,dx\right)\\ &\text{(The inner boundary terms are also 0)} \end{aligned}",
      r"\begin{aligned} =& \displaystyle \frac{2}{3}\cdot\displaystyle \frac{1}{4}\displaystyle \int_{\alpha}^{\beta}(\beta-x)^4\,dx\\ =& \displaystyle \frac{2}{3}\cdot\displaystyle \frac{1}{4}\left[-\displaystyle \frac{(\beta-x)^5}{5}\right]_{\alpha}^{\beta}\\ =& \displaystyle \frac{(\beta-\alpha)^5}{30} \end{aligned}",
    ],
  ),

  "18A36D0E-7123-4A0D-8AE6-E8453099D9A9": ProblemTranslation(
    category: "Symmetry (Substitution)",
    level: "Easy",
    question: r"""\displaystyle \int_{-1}^{1}(1-x^{2})^{3}\,dx""",
    answer: r"""\displaystyle\frac{32}{35}""",
    hint:
        r"\text{The integrand is an even function, so we can integrate from } 0 \text{ to } 1 \text{ and multiply by } 2. \text{ Expand } (1-x^2)^3 \text{ and integrate term by term.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{The integrand is an even function, so we can integrate from } 0 \text{ to } 1 \text{ and multiply by } 2. \text{ Expand } (1-x^2)^3 \text{ and integrate term by term.}",
      r"\textbf{[Expansion]}",
      r"(1-x^{2})^{3}=1-3x^{2}+3x^{4}-x^{6}",
      r"\textbf{[Calculation]}",
      r"\text{Since the integrand is an even function:}",
      r"\begin{aligned} &\ \ \ \ \ \ \displaystyle \int_{-1}^{1}(1-x^{2})^{3}\,dx\\ &= 2\displaystyle \int_{0}^{1}(1-x^{2})^{3}\,dx\\[4pt] &= 2\displaystyle \int_{0}^{1}\bigl(1-3x^{2}+3x^{4}-x^{6}\bigr)\,dx\\[4pt] &= 2\left(\displaystyle \int_{0}^{1}1\,dx -3\displaystyle \int_{0}^{1}x^{2}\,dx +3\displaystyle \int_{0}^{1}x^{4}\,dx -\displaystyle \int_{0}^{1}x^{6}\,dx\right) \end{aligned}",
      r"\begin{alignedat}{2} &\displaystyle \int_{0}^{1}1\,dx &&= 1\\[4pt] &\displaystyle \int_{0}^{1}x^{2}\,dx &&= \dfrac{1}{3}\\[4pt] &\displaystyle \int_{0}^{1}x^{4}\,dx &&= \dfrac{1}{5}\\[4pt] &\displaystyle \int_{0}^{1}x^{6}\,dx &&= \dfrac{1}{7} \end{alignedat}",
      r"\begin{aligned} \displaystyle \int_{-1}^{1}(1-x^{2})^{3}\,dx &= 2\left(1 -3\cdot \dfrac{1}{3} +3\cdot \dfrac{1}{5} - \dfrac{1}{7}\right)\\[6pt] &= 2\left(1-1+\dfrac{3}{5}-\dfrac{1}{7}\right)\\[6pt] &= 2\left(\dfrac{3}{5}-\dfrac{1}{7}\right)\\[6pt] &= 2\cdot \dfrac{3\cdot7-1\cdot5}{35}\\[6pt] &= 2\cdot \dfrac{21-5}{35}\\[6pt] &= 2\cdot \dfrac{16}{35}\\[6pt] &= \dfrac{32}{35} \end{aligned}",
    ],
  ),
  "EE0E5F29-6071-4A82-BBA0-6D3DAAD6BB0C": ProblemTranslation(
    category: "Logarithms (Substitution)",
    level: "Mid",
    question:
        r"""\displaystyle \int_{1}^{e}\displaystyle \frac{\log  x}{x^{2}}\,dx""",
    answer: r"""\displaystyle 1 - \displaystyle \frac{2}{e}""",

    hint:
        r"\text{Let } t=\log x, \text{ then } x=e^t \text{ and } dx=e^t dt. \text{ Use integration by parts after converting to an exponential function.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let } t=\log x, \text{ then } x=e^t \text{ and } dx=e^t dt. \text{ Use integration by parts after converting to an exponential function.}",
      r"\textbf{[Point]}",
      r"\textbf{[Explanation]}",
      r"\begin{aligned} \displaystyle \int_{1}^{e}\displaystyle \frac{\log x}{x^{2}}\,dx &=\displaystyle \int_{t=0}^{1} t\cdot e^{-2t}\cdot e^{t}\,dt\\ &=\displaystyle \int_{0}^{1} t\,e^{-t}\,dt. \end{aligned}",
      r"\text{Now apply integration by parts.}",
      r"\text{Now use integration by parts:}",
      r"\begin{aligned} &\displaystyle \int_{0}^{1} t\,e^{-t}\,dt\\ &=\displaystyle \int_{0}^{1} t\,(-e^{-t})'\,dt\\ &=\left[-t\,e^{-t}\right]_{0}^{1}+\displaystyle \int_{0}^{1} e^{-t}\,dt\\ &=\left(-e^{-1}-0\right)+\left[-e^{-t}\right]_{0}^{1}\\ &=-\displaystyle \frac{1}{e}+\left(-e^{-1}+1\right)\\ &=1-\displaystyle \frac{2}{e} \end{aligned}",
    ],
  ),
  "A191EF43-6467-4047-8FE9-BFEE5B89D08E": ProblemTranslation(
    category: "Substitution (tan → u)",
    level: "Mid",
    question:
        r"""\displaystyle \int_{ \frac {\pi} {4}}^{\frac{\pi}{3}}\tan^{2}x\left(\tan^{2}x+1\right)\,dx""",
    answer: r""" \displaystyle \sqrt{3} -\displaystyle \frac{1}{3}""",

    hint: r"\text{Let } u=\tan x.",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let } u=\tan x.",
      r"\textbf{[Explanation]}",
      r"\text{Since } du = (1+\tan^2 x) dx:",
      r"\begin{aligned} &\displaystyle \int_{ \frac{\pi}{4}}^{\frac{\pi}{3}}\tan^{2}x\left(1 + \tan^{2}x\right)\,dx\\ &=\displaystyle \int_{\tan\left(\frac{\pi}{4}\right)}^{\tan\left(\frac{\pi}{3}\right)} u^{2} \,du\\ &=\displaystyle \int_{1}^{\sqrt{3}} u^{2} \,du\\ &=\left[ \displaystyle \frac{u^{3}}{3}\right]_{1}^{\sqrt{3}}\\ &=\displaystyle \frac{\sqrt{3}^3-1^3}{3}\\ &=\displaystyle \sqrt{3}- \displaystyle \frac{1}{3} \end{aligned}",
    ],
  ),

  // problems_trig_polynomial_reserve.dart (reserve / commented-out in source)
  "3FC3F98E-E3D9-42B7-BD88-95AA0B2A7B17": ProblemTranslation(
    category: "Product-to-Sum Formula",
    level: "Easy",
    question: r"""\displaystyle \int_0^{2\pi}\sin(2x)\sin(5x)\,dx""",
    answer: r"""0""",
    hint:
        r"\text{Use } \sin A\sin B=\displaystyle\frac{1}{2}\left(\cos(A-B)-\cos(A+B)\right)\text{.}",
    steps: [
      r"\textbf{[Product-to-Sum]}",
      r"\text{Using } \sin A\sin B=\displaystyle\frac{1}{2}\left(\cos(A-B)-\cos(A+B)\right)\text{:}",
      r"\begin{aligned} \int_0^{2\pi}\sin(2x)\sin(5x)\,dx &= \frac{1}{2}\int_0^{2\pi}\left(\cos((2-5)x)-\cos((2+5)x)\right)\,dx \\ &= \frac{1}{2}\int_0^{2\pi}\left(\cos(3x)-\cos(7x)\right)\,dx \\ &= \frac{1}{2}\left[\frac{\sin(3x)}{3}-\frac{\sin(7x)}{7}\right]_0^{2\pi}=0. \end{aligned}",
      r"\textbf{[Remark]}",
      r"\text{This is an instance of orthogonality: } \displaystyle \int_0^{2\pi}\sin(mx)\sin(nx)\,dx=\begin{cases}0&(m\ne n)\\ \pi&(m=n)\end{cases}\text{.}",
    ],
  ),

  // problems_trig_polynomial.dart
  "D812B02C-7F6E-4FA4-BD61-A05CBAB6D525": ProblemTranslation(
    category: "Trigonometric Polynomials",
    level: "Easy",
    question: r"""\displaystyle \int_0^{\pi} \sin^2 x \, dx""",
    answer: r""" \displaystyle\frac{\pi}{2}""",

    hint:
        r"\text{Use the half-angle formula } \sin^2 x = \displaystyle\frac{1-\cos 2x}{2}\text{ to reduce the integral.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the half-angle formula } \sin^2 x = \displaystyle\frac{1-\cos 2x}{2}\text{.}",
      r"\textbf{[Explanation]}",
      r"\begin{aligned} \displaystyle &\int_0^{\pi}\sin^2 x\,dx\\ =& \displaystyle \int_0^{\pi}\displaystyle\frac{1-\cos 2x}{2}\,dx\\ =& \displaystyle\frac{1}{2}\displaystyle \int_0^{\pi}1\,dx-\displaystyle\frac{1}{2}\displaystyle \int_0^{\pi}\cos 2x\,dx\\ =& \displaystyle\frac{1}{2}\left[x\right]_0^{\pi}-\displaystyle\frac{1}{2}\left[\displaystyle\frac{\sin 2x}{2}\right]_0^{\pi}\\ =& \displaystyle\frac{1}{2}\left(\pi-0\right)-\displaystyle\frac{1}{2}\left(\displaystyle\frac{\sin 2\pi}{2}-\displaystyle\frac{\sin 0}{2}\right)\\ =& \displaystyle\frac{1}{2}\pi-\displaystyle\frac{1}{2}\left(\displaystyle\frac{0}{2}-\displaystyle\frac{0}{2}\right)\\ =& \displaystyle\frac{\pi}{2} \end{aligned}",
    ],
  ),
  "E356DB2A-1686-4B3F-8F5C-77FBE782E17F": ProblemTranslation(
    category: "Trigonometric Polynomials",
    level: "Easy",
    question: r"""\displaystyle \int_{0}^{\frac{\pi}{6}} \sin^3 x \, dx""",
    answer: r"""\displaystyle\frac{16-9\sqrt{3}}{24}""",

    hint:
        r"\text{Write } \sin^3 x = \sin x(1-\cos^2 x) \text{ and use substitution } u=\cos x.",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Write } \sin^3 x = \sin x(1-\cos^2 x) \text{ and use substitution } u=\cos x.",
      r"\textbf{[Key Point]}",
      r"\begin{aligned} &\sin^3 x = \sin x(1-\cos^2 x)\\[5pt] &u = \cos x \Rightarrow du = -\sin x \, dx \end{aligned}",
      r"\textbf{[Explanation]}",
      r"\begin{aligned} \int_{0}^{\frac{\pi}{6}} \sin^3 x \, dx &= \int_{0}^{\frac{\pi}{6}} (1-\cos^2 x)\sin x \, dx\\[5pt] &= \int_{u=\cos 0}^{u=\cos(\pi/6)} (1-u^2)(-du)\\[5pt] &= \int_{u=1}^{u=\displaystyle\frac{\sqrt{3}}{2}} (u^2-1) \, du\\[5pt] &= \int_{\frac{\sqrt{3}}{2}}^{1} (1-u^2) \, du\\[5pt] &= \left[u - \displaystyle\frac{u^3}{3}\right]_{\displaystyle\frac{\sqrt{3}}{2}}^{1}\\[5pt] &= \left(1 - \displaystyle\frac{1}{3}\right) - \left(\displaystyle\frac{\sqrt{3}}{2} - \displaystyle\frac{(\sqrt{3}/2)^3}{3}\right)\\[5pt] &= \displaystyle\frac{2}{3} - \displaystyle\frac{\sqrt{3}}{2} + \displaystyle\frac{(\sqrt{3}/2)^3}{3}\\[5pt] &= \displaystyle\frac{2}{3} - \displaystyle\frac{\sqrt{3}}{2} + \displaystyle\frac{\displaystyle\frac{3\sqrt{3}}{8}}{3}\\[5pt] &= \displaystyle\frac{2}{3} - \displaystyle\frac{\sqrt{3}}{2} + \displaystyle\frac{\sqrt{3}}{8}\\[5pt] &= \displaystyle\frac{2}{3} - \displaystyle\frac{4\sqrt{3}}{8} + \displaystyle\frac{\sqrt{3}}{8}\\[5pt] &= \displaystyle\frac{2}{3} - \displaystyle\frac{3\sqrt{3}}{8}\\[5pt] &= \displaystyle\frac{16}{24} - \displaystyle\frac{9\sqrt{3}}{24} \end{aligned}",
      r"\text{Note that } \cos\displaystyle\frac{\pi}{6}=\displaystyle\frac{\sqrt{3}}{2}\text{ and } \sin\displaystyle\frac{\pi}{6}=\displaystyle\frac{1}{2}\text{.}",
      r"\text{Alternatively, find the indefinite integral first:}",
      r"\begin{aligned} \int \sin^3 x \, dx &= \int \sin x (1-\cos^2 x) \, dx\\[5pt] &= \int \sin x \, dx - \int \sin x \cos^2 x \, dx\\[5pt] &= -\cos x + \displaystyle\frac{\cos^3 x}{3} + C \end{aligned}",
      r"\text{Therefore,}",
      r"\begin{aligned} \int_{0}^{\frac{\pi}{6}} \sin^3 x \, dx &= \left[-\cos x + \displaystyle\frac{\cos^3 x}{3}\right]_{0}^{\frac{\pi}{6}}\\[5pt] &= \left(-\cos\displaystyle\frac{\pi}{6} + \displaystyle\frac{\cos^3(\pi/6)}{3}\right) - \left(-\cos 0 + \displaystyle\frac{\cos^3 0}{3}\right)\\[5pt] &= \left(-\displaystyle\frac{\sqrt{3}}{2} + \displaystyle\frac{(\sqrt{3}/2)^3}{3}\right) - \left(-1 + \displaystyle\frac{1}{3}\right)\\[5pt] &= -\displaystyle\frac{\sqrt{3}}{2} + \displaystyle\frac{\displaystyle\frac{3\sqrt{3}}{8}}{3} + 1 - \displaystyle\frac{1}{3}\\[5pt] &= -\displaystyle\frac{\sqrt{3}}{2} + \displaystyle\frac{\sqrt{3}}{8} + \displaystyle\frac{2}{3}\\[5pt] &= -\displaystyle\frac{4\sqrt{3}}{8} + \displaystyle\frac{\sqrt{3}}{8} + \displaystyle\frac{2}{3}\\[5pt] &= -\displaystyle\frac{3\sqrt{3}}{8} + \displaystyle\frac{2}{3}\\[5pt] &= \displaystyle\frac{16}{24} - \displaystyle\frac{9\sqrt{3}}{24} \end{aligned}",
      r"\text{So,}",
      r"\begin{aligned} \int_{0}^{\frac{\pi}{6}} \sin^3 x \, dx = \displaystyle\frac{16-9\sqrt{3}}{24} \end{aligned}",
    ],
  ),
  "422D4451-7399-4187-863C-165C15969BB4": ProblemTranslation(
    category: "Trigonometric Polynomials",
    level: "Mid",
    question: r"""\displaystyle \int_0^{  \frac{\pi}{2}} \sin^4 x \, dx""",
    answer: r""" \displaystyle\frac{3}{16}\pi""",

    hint:
        r"\text{Use half-angle formulas } \sin^2 x = \displaystyle\frac{1-\cos 2x}{2} \text{ and } \cos^2 2x = \displaystyle\frac{1+\cos 4x}{2}\text{.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use half-angle formulas } \sin^2 x = \displaystyle\frac{1-\cos 2x}{2} \text{ and } \cos^2 2x = \displaystyle\frac{1+\cos 4x}{2}\text{.}",
      r"\textbf{[Key Point]}",
      r"\begin{aligned} &\sin^4 x=\left(\displaystyle\frac{1-\cos 2x}{2}\right)^2\ \\[4pt] &\cos^2 2x=\displaystyle\frac{1+\cos 4x}{2}\ \\[4pt] &\displaystyle \int \cos kx\,dx=\displaystyle\frac{\sin kx}{k} \end{aligned}",
      r"\textbf{[Explanation]}",
      r"\begin{aligned} \sin^4 x &= \left(\displaystyle\frac{1-\cos 2x}{2}\right)^2\\ &= \displaystyle\frac{1}{4}\left(1-2\cos 2x+\cos^2 2x\right)\\ &= \displaystyle\frac{1}{4}\left(1-2\cos 2x+\displaystyle\frac{1+\cos 4x}{2}\right)\\ &= \displaystyle\frac{1}{4}\left(\displaystyle\frac{3}{2}-2\cos 2x+\displaystyle\frac{1}{2}\cos 4x\right) \end{aligned}",
      r"\begin{aligned} \displaystyle \int_0^{  \frac{\pi}{2}}\sin^4 x\,dx &= \displaystyle\frac{1}{4}\displaystyle \int_0^{  \frac{\pi}{2}}\left(\displaystyle\frac{3}{2}-2\cos 2x+\displaystyle\frac{1}{2}\cos 4x\right)dx\\ &= \displaystyle\frac{1}{4}\left[\ \displaystyle\frac{3}{2}x-2\cdot\displaystyle\frac{\sin 2x}{2}+\displaystyle\frac{1}{2}\cdot\displaystyle\frac{\sin 4x}{4}\ \right]_0^{  \frac{\pi}{2}}\\ &= \displaystyle\frac{1}{4}\left[\ \displaystyle\frac{3}{2}x-\sin 2x+\displaystyle\frac{1}{8}\sin 4x\ \right]_0^{  \frac{\pi}{2}}\\ &= \displaystyle\frac{1}{4}\left(\displaystyle\frac{3}{2}\cdot\displaystyle\frac{\pi}{2}-\sin \pi+\displaystyle\frac{1}{8}\sin 2\pi\right)\\ &= \displaystyle\frac{1}{4}\left(\displaystyle\frac{3\pi}{4}-0+0\right)\\ &= \displaystyle\frac{3}{16}\pi \end{aligned}",
    ],
  ),
  "FEE633FE-DE9A-4BF9-8E42-52FD6CA67E3A": ProblemTranslation(
    category: "Trigonometric Polynomials",
    level: "Mid",
    question:
        r"""\displaystyle \int_0^{\frac{\pi}{3}} \sin^2 x \cos^2 x \, dx""",
    answer: r"""\displaystyle\frac{\pi}{24}+\displaystyle\frac{\sqrt{3}}{64}""",

    hint:
        r"\text{Use } \sin 2x = 2\sin x\cos x\text{, so } \sin^2 x\cos^2 x=\left(\displaystyle\frac{\sin 2x}{2}\right)^2\text{, then } \sin^2 2x=\displaystyle\frac{1-\cos 4x}{2}\text{.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use } \sin 2x = 2\sin x\cos x\text{, then apply half-angle formulas.}",
      r"\textbf{[Explanation]}",
      r"\begin{aligned}\sin^2 x\cos^2 x &= \left(\displaystyle\frac{\sin 2x}{2}\right)^2\\ &= \displaystyle\frac{1}{4}\sin^2 2x\\ &= \displaystyle\frac{1}{4}\cdot\displaystyle\frac{1-\cos 4x}{2}\\ &= \displaystyle\frac{1}{8}\left(1-\cos 4x\right). \end{aligned}",
      r"\begin{aligned} \displaystyle \int_0^{\frac{\pi}{3}} \sin^2 x\cos^2 x\,dx &= \displaystyle\frac{1}{8}\displaystyle \int_0^{\frac{\pi}{3}} \left(1-\cos 4x\right)dx\\ &= \displaystyle\frac{1}{8}\left[x-\displaystyle\frac{\sin 4x}{4}\right]_0^{\frac{\pi}{3}}\\ &= \displaystyle\frac{1}{8}\left(\displaystyle\frac{\pi}{3}-\displaystyle\frac{\sin(4\pi/3)}{4}\right)-\displaystyle\frac{1}{8}\left(0-\displaystyle\frac{\sin 0}{4}\right)\\ &= \displaystyle\frac{1}{8}\left(\displaystyle\frac{\pi}{3}-\displaystyle\frac{\sin(4\pi/3)}{4}\right)\\ &= \displaystyle\frac{1}{8}\left(\displaystyle\frac{\pi}{3}-\displaystyle\frac{-\sqrt{3}/2}{4}\right)\\ &= \displaystyle\frac{1}{8}\left(\displaystyle\frac{\pi}{3}+\displaystyle\frac{\sqrt{3}}{8}\right)\\ &= \displaystyle\frac{\pi}{24}+\displaystyle\frac{\sqrt{3}}{64} \end{aligned}",
      r"\text{Note that } \sin\displaystyle\frac{4\pi}{3}=\sin\left(\pi+\displaystyle\frac{\pi}{3}\right)=-\sin\displaystyle\frac{\pi}{3}=-\displaystyle\frac{\sqrt{3}}{2}\text{.}",
    ],
  ),
  "A5B6C7D8-E9F0-1234-5678-9ABCDEF01234": ProblemTranslation(
    category: "Trigonometric Polynomials",
    level: "Easy",
    question:
        r"""\displaystyle \int_{-\frac{\pi}{4}}^{\frac{\pi}{4}} \cos^3 x \, dx""",
    answer: r"""\displaystyle\frac{5\sqrt{2}}{6}""",

    hint:
        r"\text{Since the integrand is an even function, calculate } 2\int_{0}^{\pi/4} \cos^3 x \, dx.",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{The integrand } \cos^3 x \text{ is an even function, so:}",
      r"\displaystyle \int_{-\frac \pi 4}^{\frac \pi 4} \cos^3 x \, dx = \displaystyle 2\int_{0}^{\frac \pi 4} \cos^3 x \, dx",
      r"\textbf{[Key Point]}",
      r"\begin{aligned} &\cos^3 x = \cos x(1-\sin^2 x)\\[5pt] &u = \sin x \Rightarrow du = \cos x \, dx \end{aligned}",
      r"\textbf{[Explanation]}",
      r"\begin{aligned} \int_{-\frac{\pi}{4}}^{\frac{\pi}{4}} \cos^3 x \, dx &= 2\int_{0}^{\frac{\pi}{4}} \cos^3 x \, dx\\[5pt] &= 2\int_{0}^{\frac{\pi}{4}} (1-\sin^2 x)\cos x \, dx\\[5pt] &= 2\int_{u=0}^{u=\sin(\frac \pi 4)} (1-u^2) \, du\\[5pt] &= 2\int_{0}^{\frac{\sqrt{2}}{2}} (1-u^2) \, du\\[5pt] &= 2\left[u - \displaystyle\frac{u^3}{3}\right]_{0}^{\frac{\sqrt{2}}{2}}\\[5pt] &= 2\left(\displaystyle\frac{\sqrt{2}}{2} - \frac{\left(\frac{\sqrt{2}}{2}\right)^3}{3}\right)\\[5pt] &= 2\left(\displaystyle\frac{\sqrt{2}}{2} - \frac{\frac{2\sqrt{2}}{8}}{3}\right)\\[5pt] &= 2\left(\displaystyle\frac{\sqrt{2}}{2} - \displaystyle\frac{\sqrt{2}}{12}\right)\\[5pt] &= 2\left(\displaystyle\frac{6\sqrt{2}}{12} - \displaystyle\frac{\sqrt{2}}{12}\right)\\[5pt] &= 2 \cdot \displaystyle\frac{5\sqrt{2}}{12}\\[5pt] &= \displaystyle\frac{5\sqrt{2}}{6} \end{aligned}",
    ],
  ),
  "F1G2H3I4-J5K6-L7M8-N9O0-P1Q2R3S4T5U6": ProblemTranslation(
    category: "Trigonometric Polynomials",
    level: "Easy",
    question: r"""\displaystyle \int_{0}^{\frac{\pi}{4}} \frac{dx}{\cos^2 x}""",
    answer: r"""1""",

    hint: r"\text{Use } (\tan x)' = \displaystyle\frac{1}{\cos^2 x}\text{.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use } (\tan x)' = \displaystyle\frac{1}{\cos^2 x}\text{.}",
      r"\textbf{[Explanation]}",
      r"\begin{aligned} \int_{0}^{\frac{\pi}{4}} \displaystyle\frac{dx}{\cos^2 x} &= \left[\tan x\right]_{0}^{\frac{\pi}{4}}\\[5pt] &= \tan\displaystyle\frac{\pi}{4} - \tan 0\\[5pt] &= 1 - 0\\[5pt] &= 1 \end{aligned}",
    ],
  ),
  "D04D1417-91C9-4E4F-8558-80C8FF96A50F": ProblemTranslation(
    category: "Trigonometric Polynomials",
    level: "Easy",
    question: r"""\displaystyle \int_0^{\frac{\pi}{2}} \cos^2 x \, dx""",
    answer: r""" \displaystyle\frac{\pi}{4}""",

    hint:
        r"\text{Use the half-angle formula } \cos^2 x = \displaystyle\frac{1+\cos 2x}{2}\text{.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the half-angle formula } \cos^2 x = \displaystyle\frac{1+\cos 2x}{2}\text{.}",
      r"\textbf{[Explanation]}",
      r"\begin{aligned} \displaystyle &\int_0^{\frac {\pi}{2}}\cos^2 x\,dx\\ =& \displaystyle \int_0^{  \frac{\pi}{2}}\displaystyle\frac{1+\cos 2x}{2}\,dx\\ =& \displaystyle\frac{1}{2}\displaystyle \int_0^{  \frac{\pi}{2}}1\,dx+\displaystyle\frac{1}{2}\displaystyle \int_0^{  \frac{\pi}{2}}\cos 2x\,dx\\ =& \displaystyle\frac{1}{2}\left[x\right]_0^{  \frac{\pi}{2}}+\displaystyle\frac{1}{2}\left[\displaystyle\frac{\sin 2x}{2}\right]_0^{  \frac{\pi}{2}}\\ =& \displaystyle\frac{1}{2}\left(\displaystyle\frac{\pi}{2}-0\right)+\displaystyle\frac{1}{2}\left(\displaystyle\frac{\sin \pi}{2}-\displaystyle\frac{\sin 0}{2}\right)\\ =& \displaystyle\frac{\pi}{4}+\displaystyle\frac{1}{2}\left(\displaystyle\frac{0}{2}-\displaystyle\frac{0}{2}\right)\\ =& \displaystyle\frac{\pi}{4} \end{aligned}",
      r"\textbf{[Supplement]}",
      r"\text{The calculation for } \sin^2 x \text{ is similar.}",
    ],
  ),

  // (reserve / commented-out in source)
  "0A45939C-F132-4735-BD59-1A31B9BFA4E8": ProblemTranslation(
    category: "Trigonometric Polynomials",
    level: "Easy",
    question:
        r"""\displaystyle \int_0^{\pi}\sin x\left(1+\cos x+\cos^2x\right)\,dx""",
    answer: r"""\displaystyle \frac{8}{3}""",
    hint: r"""\text{Use substitution }u=\cos x\text{.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use }u=\cos x\text{ so that }du=-\sin x\,dx\text{.}",
      r"\textbf{[Computation]}",
      r"\begin{aligned} \int_0^{\pi}\sin x(1+\cos x+\cos^2x)\,dx &= -\int_{1}^{-1} (1+u+u^2)\,du \\ &= \int_{-1}^{1} (1+u+u^2)\,du \\ &= \int_{-1}^{1} 1\,du + \int_{-1}^{1} u\,du + \int_{-1}^{1} u^2\,du \\ &= 2 + 0 + 2\int_{0}^{1} u^2\,du \\ &= 2 + 2\left[\frac{u^3}{3}\right]_{0}^{1} \\ &= 2 + \frac{2}{3} = \frac{8}{3}. \end{aligned}",
    ],
  ),
  // (reserve / commented-out in source)
  "FA2B5E85-9ACE-4515-820D-C24AE18B6E99": ProblemTranslation(
    category: "Trigonometric (Identity Transformation)",
    level: "Mid",
    question:
        r"""\displaystyle \int_{ \frac {\pi} {8}}^{ \frac {\pi} {4}}\displaystyle \frac{1}{\tan^{2}x}\,dx""",
    answer: r"""\displaystyle \sqrt{2}-\displaystyle \frac{\pi}{8}""",
    hint:
        r"""\text{Rewrite } \displaystyle\frac{1}{\tan^2 x}=\displaystyle\frac{1}{\sin^2 x}-1\text{.}""",
    steps: [
      r"\textbf{[Transformation]}",
      r"\begin{aligned} \frac{1}{\tan^2 x} &= \frac{\cos^2 x}{\sin^2 x} = \frac{1}{\sin^2 x}-1. \end{aligned}",
      r"\textbf{[Key Derivative]}",
      r"\begin{aligned} \left(\frac{\cos x}{\sin x}\right)' &= \frac{-\sin x\cdot \sin x-\cos x\cdot \cos x}{\sin^2 x} = -\frac{1}{\sin^2 x}. \end{aligned}",
      r"\textbf{[Indefinite Integral]}",
      r"\begin{aligned} \int \frac{1}{\tan^2 x}\,dx &= \int\left(\frac{1}{\sin^2 x}-1\right)\,dx \\ &= -\frac{\cos x}{\sin x}-x + C. \end{aligned}",
      r"\textbf{[Evaluation]}",
      r"\begin{aligned} \int_{\pi/8}^{\pi/4}\frac{1}{\tan^2 x}\,dx &= \left[-\frac{\cos x}{\sin x}-x\right]_{\pi/8}^{\pi/4} \\ &= \left(-\frac{\cos(\pi/4)}{\sin(\pi/4)}-\frac{\pi}{4}\right) - \left(-\frac{\cos(\pi/8)}{\sin(\pi/8)}-\frac{\pi}{8}\right) \\ &= -1-\frac{\pi}{4}+\frac{\cos(\pi/8)}{\sin(\pi/8)}+\frac{\pi}{8}. \end{aligned}",
      r"\text{Since } \tan\displaystyle\frac{\pi}{8}=\sqrt{2}-1\text{, we have } \displaystyle\frac{\cos(\pi/8)}{\sin(\pi/8)}=\displaystyle\frac{1}{\tan(\pi/8)}=\sqrt{2}+1\text{.}",
      r"\begin{aligned} \therefore\ \int_{\pi/8}^{\pi/4}\frac{1}{\tan^2 x}\,dx &= -1-\frac{\pi}{4}+(\sqrt{2}+1)+\frac{\pi}{8} = \sqrt{2}-\frac{\pi}{8}. \end{aligned}",
    ],
  ),
  // (reserve / commented-out in source)
  "4B718765-D339-4E16-89C5-C2C932AEF020": ProblemTranslation(
    category: "Power Trigonometric (Recurrence)",
    level: "Advanced",
    question: r"""\displaystyle \int_0^{\pi}\sin^9 x\,dx""",
    answer: r"""\displaystyle \frac{256}{315}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let } I_n=\displaystyle \int_0^{\pi/2}\sin^n x\,dx\text{. Using integration by parts, derive } I_n=\displaystyle\frac{n-1}{n}I_{n-2}\text{, then compute }I_9\text{ and use } \int_0^\pi \sin^n x\,dx=2I_n\text{.}",
      r"\textbf{[Recurrence]}",
      r"\begin{aligned} I_n &= \int_0^{\pi/2}\sin^{n-1}x\cdot\sin x\,dx \\ &= \left[-\sin^{n-1}x\cos x\right]_0^{\pi/2} + (n-1)\int_0^{\pi/2}\sin^{n-2}x\cos^2 x\,dx \\ &= (n-1)\int_0^{\pi/2}\sin^{n-2}x(1-\sin^2 x)\,dx \\ &= (n-1)I_{n-2}-(n-1)I_n, \end{aligned}",
      r"\begin{aligned} \therefore\ nI_n=(n-1)I_{n-2}\ \Rightarrow\ I_n=\frac{n-1}{n}I_{n-2}. \end{aligned}",
      r"\textbf{[Compute }I_9\textbf{]}",
      r"\begin{aligned} I_1&=1,\\ I_3&=\frac{2}{3}I_1=\frac{2}{3},\\ I_5&=\frac{4}{5}I_3=\frac{8}{15},\\ I_7&=\frac{6}{7}I_5=\frac{16}{35},\\ I_9&=\frac{8}{9}I_7=\frac{128}{315}. \end{aligned}",
      r"\textbf{[Final]}",
      r"\begin{aligned} \int_0^{\pi}\sin^9 x\,dx = 2I_9 = 2\cdot\frac{128}{315}=\frac{256}{315}. \end{aligned}",
    ],
  ),
  // (reserve / commented-out in source)
  "C107D86A-6A15-4CEC-A66F-AB05FD6FB378": ProblemTranslation(
    category: "Power Trigonometric (Even Power)",
    level: "Advanced",
    question: r"""\displaystyle \int_0^{\pi}\sin^{10}x\,dx""",
    answer: r"""\displaystyle \frac{63\pi}{256}""",
    steps: [
      r"\textbf{[Formula]}",
      r"\text{Use } \displaystyle \int_0^{\pi}\sin^{2k}x\,dx=\pi\,\displaystyle\frac{(2k)!}{2^{2k}(k!)^2}\text{.}",
      r"\textbf{[Substitute }k=5\textbf{]}",
      r"\begin{aligned} \int_0^{\pi}\sin^{10}x\,dx &= \pi\cdot\frac{10!}{2^{10}(5!)^2} \\ &= \pi\cdot\frac{3628800}{1024\cdot 14400} = \pi\cdot\frac{63}{256} = \frac{63\pi}{256}. \end{aligned}",
    ],
  ),
  "5F800251-23AC-4487-8BD4-3BC209617EF6": ProblemTranslation(
    category: "Trigonometric Polynomials (Recurrence)",
    level: "Advanced",
    question:
        r"""\displaystyle \int_{0}^{ \frac{\pi}{4}} \tan^6 x \, dx""",
    answer: r"""\displaystyle\frac{13}{15}-\displaystyle\frac{\pi}{4}""",
    hint:
        r"\text{Let } I_n=\displaystyle \int_{0}^{\frac{\pi}{4}} \tan^n x\,dx\text{. Derive a recurrence and reduce }I_6\text{ to }I_4,I_2,I_0\text{.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let } I_n=\displaystyle \int_{0}^{\frac{\pi}{4}} \tan^n x\,dx\text{ and derive a recurrence to reduce }I_6\text{ to }I_4,I_2,I_0\text{.}",
      r"\textcolor{green}{[Proposition]}",
      r"\text{For any }a,b\text{ with }-\displaystyle\frac{\pi}{2}<a<b<\displaystyle\frac{\pi}{2}\text{, define } I_n=\displaystyle\int_{a}^{b} \tan^n x\,dx\text{. Then for }n\ge 2\text{:}",
      r"\textcolor{green}{\ I_n=\displaystyle\frac{1}{n-1}\left[\tan^{n-1}x\right]_{a}^{b}-I_{n-2}\ }",
      r"\textbf{[Proof]}",
      r"\text{Use the identity } \tan^2 x=\displaystyle\frac{1}{\cos^2 x}-1\text{:}",
      r"""\begin{aligned}
I_n
&=\displaystyle \int_{a}^{b} \tan^n x\,dx\\[6pt]
&=\displaystyle \int_{a}^{b} \tan^{n-2}x\cdot\tan^2 x\,dx\\[6pt]
&=\displaystyle \int_{a}^{b} \tan^{n-2}x\cdot\left(\displaystyle \frac{1}{\cos^2 x}-1\right)\,dx\\[6pt]
&=\displaystyle \int_{a}^{b} \tan^{n-2}x\cdot\displaystyle \frac{1}{\cos^2 x}\,dx-\displaystyle \int_{a}^{b} \tan^{n-2}x\,dx\cdots(1)
\end{aligned}""",
      r"\textbf{[First term]}",
      r"""\begin{aligned}
\displaystyle \int \tan^{n-2}x\cdot\displaystyle \frac{1}{\cos^2 x}\,dx
&=\displaystyle\int \tan^{n-2}x\cdot\sec^2 x\,dx\\[6pt]
&=\displaystyle\frac{\tan^{n-1}x}{n-1}+C
\end{aligned}""",
      r"\text{Therefore, as a definite integral:}",
      r"""\begin{aligned}
\displaystyle \int_{a}^{b} \tan^{n-2}x\cdot\displaystyle \frac{1}{\cos^2 x}\,dx
&=\left[\displaystyle\frac{\tan^{n-1}x}{n-1}\right]_{a}^{b}\\[6pt]
&=\displaystyle\frac{1}{n-1}\left[\tan^{n-1}x\right]_{a}^{b}
\end{aligned}""",
      r"\text{Substitute into (1): } I_n=\displaystyle\frac{1}{n-1}\left[\tan^{n-1}x\right]_{a}^{b}-I_{n-2}\quad \text{Q.E.D.}",
      r"",
      r"\textbf{[Case }a=0,\ b=\displaystyle\frac{\pi}{4}\textbf{]}",
      r"\text{Here } a=0,\ b=\displaystyle\frac{\pi}{4}\text{, so}",
      r"""\begin{aligned}
I_n
&=\displaystyle\frac{1}{n-1}\left[\tan^{n-1}x\right]_{0}^{\frac{\pi}{4}}-I_{n-2}\\[6pt]
&=\displaystyle\frac{1}{n-1}\left(\tan^{n-1}\left(\displaystyle\frac{\pi}{4}\right)-\tan^{n-1}(0)\right)-I_{n-2}\\[6pt]
&=\displaystyle\frac{1}{n-1}(1-0)-I_{n-2}\\[6pt]
&=\displaystyle\frac{1}{n-1}-I_{n-2}
\end{aligned}""",
      r"\textbf{[Compute }I_6\textbf{]}",
      r"\text{Apply the recurrence repeatedly:}",
      r"""\begin{aligned}
I_6
&=\displaystyle\frac{1}{6-1}-I_{6-2}\\[6pt]
&=\displaystyle\frac{1}{5}-I_4\\[6pt]
&=\displaystyle\frac{1}{5}-\left(\displaystyle\frac{1}{4-1}-I_{4-2}\right)\\[6pt]
&=\displaystyle\frac{1}{5}-\left(\displaystyle\frac{1}{3}-I_2\right)\\[6pt]
&=\displaystyle\frac{1}{5}-\displaystyle\frac{1}{3}+I_2\\[6pt]
&=\displaystyle\frac{1}{5}-\displaystyle\frac{1}{3}+\left(\displaystyle\frac{1}{2-1}-I_{2-2}\right)\\[6pt]
&=\displaystyle\frac{1}{5}-\displaystyle\frac{1}{3}+(1-I_0)\\[6pt]
&=\displaystyle\frac{1}{5}-\displaystyle\frac{1}{3}+1-I_0\\[6pt]
&=\displaystyle\frac{3-5+15}{15}-I_0\\[6pt]
&=\displaystyle\frac{13}{15}-I_0\\[6pt]
&=\displaystyle\frac{13}{15}-\displaystyle\int_{0}^{\frac{\pi}{4}} \tan^0 x\,dx\\[6pt]
&=\displaystyle\frac{13}{15}-\displaystyle\int_{0}^{\frac{\pi}{4}} 1\,dx\\[6pt]
&=\displaystyle\frac{13}{15}-\displaystyle\frac{\pi}{4}
\end{aligned}""",
    ],
  ),
  "B1C2D3E4-F5G6-7890-HIJK-LM1234567890": ProblemTranslation(
    category: "Trigonometric Polynomials",
    level: "Advanced",
    question:
        r"""\displaystyle \int_{0}^{ \frac{\pi}{2}} \sin^7 x \cos^9 x \, dx""",
    answer: r"""\displaystyle\frac{1}{560}""",
    hint:
        r"\text{Let } I_{m,n}=\displaystyle \int_{0}^{\frac{\pi}{2}} \sin^{2m-1}x\,\cos^{2n-1}x\,dx\text{. Use }u=\sin^2 x\text{ to reduce it to a factorial form.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let } I_{m,n}=\displaystyle \int_{0}^{\frac{\pi}{2}} \sin^{2m-1} x \cos^{2n-1} x\,dx\text{ and reduce it via }u=\sin^2 x\text{, then evaluate using a factorial form.}",
      r"\textcolor{green}{[Proposition]}",
      r"\text{For positive integers }m,n\text{, if } I_{m,n}=\displaystyle\int_{0}^{\frac{\pi}{2}} \sin^{2m-1} x \cos^{2n-1} x\,dx\text{, then}",
      r"\textcolor{green}{I_{m,n}=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{(m-1)!(n-1)!}{(m+n-1)!}\text{.}}",
      r"\textbf{[Proof]}",
      r"\text{Set } u=\sin^2 x\text{. Then } du=2\sin x\cos x\,dx\text{.}",
      r"\text{Change of bounds:}",
      r"""\begin{aligned}
\begin{cases}
x=0 \Leftrightarrow u=\sin^2 0=0,\\[5pt]
x=\displaystyle\frac{\pi}{2} \Leftrightarrow u=\sin^2\displaystyle\frac{\pi}{2}=1
\end{cases}
\end{aligned}""",
      r"\text{Rewrite the integrand:}",
      r"""\begin{aligned}
\sin^{2m-1} x \cos^{2n-1} x
&=(\sin^2 x)^{m-\frac{1}{2}} (\cos^2 x)^{n-\frac{1}{2}}\\[6pt]
&=u^{m-\frac{1}{2}} (1-u)^{n-\frac{1}{2}}
\end{aligned}""",
      r"\text{Also } dx=\displaystyle\frac{du}{2\sin x\cos x}=\frac{du}{2u^{\frac{1}{2}}(1-u)^{\frac{1}{2}}}\text{, hence}",
      r"""\begin{aligned}
I_{m,n}
&=\displaystyle\int_{0}^{\frac{\pi}{2}} \sin^{2m-1} x \cos^{2n-1} x\,dx\\[6pt]
&=\displaystyle\int_{0}^{1} u^{m-\frac{1}{2}} (1-u)^{n-\frac{1}{2}} \cdot \frac{du}{2u^{\frac{1}{2}}(1-u)^{\frac{1}{2}}}\\[6pt]
&=\displaystyle\frac{1}{2}\displaystyle\int_{0}^{1} u^{m-1} (1-u)^{n-1}\,du
\end{aligned}""",
      r"\text{Using integration by parts:}",
      r"""\begin{aligned}
&\ \ \ \ \ \displaystyle\frac{1}{2}\displaystyle\int_{0}^{1} u^{m-1}(1-u)^{n-1}\,du\\
&=\displaystyle\frac{1}{2}\displaystyle\int_{0}^{1} \left(\displaystyle\frac{u^m}{m}\right)' \cdot (1-u)^{n-1} \,du\\[6pt]
&=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{n-1}{m}\displaystyle\int_{0}^{1} u^m(1-u)^{n-2}\,du
\end{aligned}""",
      r"\text{Repeating similarly:}",
      r"""\begin{aligned}
&=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{n-1}{m} \cdot\displaystyle\frac{n-2}{m+1}\displaystyle\int_{0}^{1} u^{m+1}(1-u)^{n-3}\,du
\end{aligned}""",
      r"\text{Further repeating gives:}",
      r"""\begin{aligned}
&=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{n-1}{m}\cdot\displaystyle\frac{n-2}{m+1}\cdots\displaystyle\frac{1}{m+n-2}\displaystyle\int_{0}^{1} u^{m+n-2}(1-u)^0\,du\\[6pt]
&=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{(n-1)!}{m(m+1)\cdots(m+n-2)}\cdot\displaystyle\frac{1}{m+n-1}\\[6pt]
&=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{(m-1)!(n-1)!}{(m+n-1)!}
\end{aligned}""",
      r"\text{Therefore } I_{m,n}=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{(m-1)!(n-1)!}{(m+n-1)!}\quad\text{Q.E.D.}",
      r"\textbf{[Apply to }\sin^7 x\cos^9 x\textbf{]}",
      r"\text{Here }2m-1=7,\ 2n-1=9\text{ so }m=4,\ n=5\text{.}",
      r"""\begin{aligned}
I_{4,5}
&=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{(4-1)!(5-1)!}{(4+5-1)!}\\[6pt]
&=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{3! \cdot 4!}{8!}\\[6pt]
&=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{1}{280}
=\displaystyle\frac{1}{560}
\end{aligned}""",
    ],
  ),
  "2E68B281-EA4E-4B67-879E-59A9AE7EC762": ProblemTranslation(
    category: "Product-to-Sum Formula",
    level: "Easy",
    question: r"""\displaystyle \int_0^{2\pi}\sin(2x)\cos(3x)\,dx""",
    answer: r"""0""",

    hint: r"\text{Use the product-to-sum formula to reduce to a linear form.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the product-to-sum formula to reduce to a linear form.}",
      r"\textbf{[Explanation]}",
      r"\text{Using } \sin A\cos B = \displaystyle\frac{1}{2}\bigl(\sin(A+B)+\sin(A-B)\bigr)\text{:}",
      r"\begin{aligned} \displaystyle &\int_0^{2\pi}\sin(2x)\cos(3x)\,dx\\[5pt] &= \displaystyle\frac{1}{2}\displaystyle \int_0^{2\pi}\left(\sin((2+3)x)+\sin((2-3)x)\right)dx\\[5pt] &= \displaystyle\frac{1}{2}\displaystyle \int_0^{2\pi}\left(\sin(5x)+\sin(-x)\right)dx\\[5pt] &= \displaystyle\frac{1}{2}\displaystyle \int_0^{2\pi}\left(\sin(5x)-\sin x\right)dx\\[5pt] &= \displaystyle\frac{1}{2}\left[-\displaystyle\frac{\cos(5x)}{5}+\cos x\right]_0^{2\pi}\\[5pt] &= \displaystyle\frac{1}{2}\left((-\displaystyle\frac{\cos(10\pi)}{5}+\cos(2\pi))-(-\displaystyle\frac{\cos 0}{5}+\cos 0)\right)\\[5pt] &= \displaystyle\frac{1}{2}\left((-\displaystyle\frac{1}{5}+1)-(-\displaystyle\frac{1}{5}+1)\right)\\[5pt] &= \displaystyle\frac{1}{2}(0)\\[5pt] &= 0 \end{aligned}",
      r"\textbf{[Supplement]}",
      r"\text{This result relates to Fourier series, where generally:}",
      r"\displaystyle \int_0^{2\pi}\sin(mx)\cos(nx)\,dx = 0",
    ],
  ),
  "A1B2C3D4-E5F6-G7H8-I9J0-K1L2M3N4O5": ProblemTranslation(
    category: 'Trigonometric Fractions',
    question:
        r"""\displaystyle \int_{\frac{\pi}{6}}^{\frac{\pi}{2}} \frac{dx}{\sin x}""",
    answer: r"""\log(2+\sqrt{3})""",

    level: 'Mid',
    hint:
        r"\text{Multiply numerator and denominator by } \sin x\text{, then substitute } u = \cos x\text{.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Multiply numerator and denominator by } \sin x, \text{ then substitute } u = \cos x.",
      r"\textbf{[Solution]}",
      r"\text{Multiplying numerator and denominator by } \sin x:",
      r"\begin{aligned} \int_{\frac{\pi}{6}}^{\frac{\pi}{2}} \frac{dx}{\sin x} &= \int_{\frac{\pi}{6}}^{\frac{\pi}{2}} \frac{\sin x}{\sin^2 x} \, dx\\[5pt] &= \textcolor{blue}{\int_{\frac{\pi}{6}}^{\frac{\pi}{2}} \frac{\sin x}{1-\cos^2 x} \, dx} \end{aligned}",
      r"\text{With } u = \cos x, \text{ we have } du = -\sin x \, dx, \text{ and:}",
      r"\begin{aligned} x = \frac{\pi}{6} &\Rightarrow u = \cos\frac{\pi}{6} = \frac{\sqrt{3}}{2}\\[5pt] x = \frac{\pi}{2} &\Rightarrow u = \cos\frac{\pi}{2} = 0 \end{aligned}",
      r"\begin{aligned} &\ \ \ \ \ \textcolor{blue}{\int_{\frac{\pi}{6}}^{\frac{\pi}{2}} \frac{\sin x}{1-\cos^2 x} \, dx}\\[5pt] &= \int_{u=\frac{\sqrt{3}}{2}}^{u=0} \frac{-du}{1-u^2}\\[5pt] &= \int_{0}^{\frac{\sqrt{3}}{2}} \frac{du}{1-u^2}\\[5pt] &= \int_{0}^{\frac{\sqrt{3}}{2}} \frac{1}{2}\left(\frac{1}{1-u} + \frac{1}{1+u}\right) du\\[5pt] &= \frac{1}{2}\left[-\log|1-u| + \log|1+u|\right]_{0}^{\frac{\sqrt{3}}{2}}\\[5pt] &= \frac{1}{2}\log\left|\frac{1+u}{1-u}\right|_{0}^{\frac{\sqrt{3}}{2}}\\[5pt] &= \frac{1}{2}\log\left(\frac{1+\frac{\sqrt{3}}{2}}{1-\frac{\sqrt{3}}{2}}\right)\\[5pt] &= \frac{1}{2}\log\left({\frac{2+\sqrt{3}}{2-\sqrt{3}}}\right)\\[5pt] &= \frac{1}{2}\log\left(\frac{2+\sqrt{3}}{2-\sqrt{3}} \cdot \frac{2+\sqrt{3}}{2+\sqrt{3}}\right)\\[5pt] &= \frac{1}{2}\log\left(\frac{(2+\sqrt{3})^2}{(2-\sqrt{3})(2+\sqrt{3})}\right)\\[5pt] &= \frac{1}{2}\log\left(\frac{(2+\sqrt{3})^2}{4-3}\right)\\[5pt] &= \frac{1}{2}\log\left((2+\sqrt{3})^2\right)\\[5pt] &= \log(2+\sqrt{3}) \end{aligned}",
    ],
  ),
  "B2C3D4E5-F6G7-H8I9-J0K1-L2M3N4O5P6": ProblemTranslation(
    category: 'Trigonometric Fractions',
    question: r"""\displaystyle \int_{0}^{\frac{\pi}{4}} \frac{dx}{\cos x}""",
    answer: r"""\log(1+\sqrt{2})""",

    level: 'Mid',
    hint:
        r"\text{Multiply numerator and denominator by } \cos x\text{, then substitute } u = \sin x\text{.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Multiply numerator and denominator by } \cos x, \text{ then substitute } u = \sin x.",
      r"\textbf{[Solution]}",
      r"\text{Multiplying numerator and denominator by } \cos x:",
      r"\begin{aligned} \int_{0}^{\frac{\pi}{4}} \frac{dx}{\cos x} &= \int_{0}^{\frac{\pi}{4}} \frac{\cos x}{\cos^2 x} \, dx\\[5pt] &= \textcolor{blue}{\int_{0}^{\frac{\pi}{4}} \frac{\cos x}{1-\sin^2 x} \, dx} \end{aligned}",
      r"\text{With } u = \sin x, \text{ we have } du = \cos x \, dx, \text{ and:}",
      r"\begin{aligned} x = 0 &\Rightarrow u = \sin 0 = 0\\[5pt] x = \frac{\pi}{4} &\Rightarrow u = \sin\frac{\pi}{4} = \frac{\sqrt{2}}{2} \end{aligned}",
      r"\begin{aligned} &\ \ \ \ \ \textcolor{blue}{\int_{0}^{\frac{\pi}{4}} \frac{\cos x}{1-\sin^2 x} \, dx}\\[5pt] &= \int_{u=0}^{u=\frac{\sqrt{2}}{2}} \frac{du}{1-u^2}\\[5pt] &= \int_{0}^{\frac{\sqrt{2}}{2}} \frac{1}{2}\left(\frac{1}{1-u} + \frac{1}{1+u}\right) du\\[5pt] &= \frac{1}{2}\left[-\log|1-u| + \log|1+u|\right]_{0}^{\frac{\sqrt{2}}{2}}\\[5pt] &= \frac{1}{2}\log\left|\frac{1+u}{1-u}\right|_{0}^{\frac{\sqrt{2}}{2}}\\[5pt] &= \frac{1}{2}\log\left(\frac{1+\frac{\sqrt{2}}{2}}{1-\frac{\sqrt{2}}{2}}\right)\\[5pt] &= \frac{1}{2}\log\left({\frac{2+\sqrt{2}}{2-\sqrt{2}}}\right)\\[5pt] &= \frac{1}{2}\log\left(\frac{2+\sqrt{2}}{2-\sqrt{2}} \cdot \frac{2+\sqrt{2}}{2+\sqrt{2}}\right)\\[5pt] &= \frac{1}{2}\log\left(\frac{(2+\sqrt{2})^2}{(2-\sqrt{2})(2+\sqrt{2})}\right)\\[5pt] &= \frac{1}{2}\log\left(\frac{(2+\sqrt{2})^2}{4-2}\right)\\[5pt] &= \frac{1}{2}\log\left(\frac{(2+\sqrt{2})^2}{2}\right)\\[5pt] &= \frac{1}{2}\log\left(\frac{6+4\sqrt{2}}{2}\right)\\[5pt] &= \frac{1}{2}\log(3+2\sqrt{2})\\[5pt] &= \frac{1}{2}\log\left((1+\sqrt{2})^2\right)\\[5pt] &= \log(1+\sqrt{2}) \end{aligned}",
    ],
  ),
  "F92FA824-A0AC-486A-95B7-C731A52DEEC9-variant": ProblemTranslation(
    category: 'Trigonometric Fractions',
    question:
        r"""\displaystyle \int_{0}^{\frac{\pi}{2}} \frac{dx}{2 + \sin x}""",
    answer: r"""\displaystyle \frac{\pi}{3\sqrt{3}}""",

    level: 'Advanced',
    hint:
        r"\text{Use the half-angle substitution } t=\tan\left(\frac{x}{2}\right)\text{.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the half-angle substitution } t = \tan\left(\frac{x}{2}\right) \text{ to convert trigonometric functions into rational functions of } t.",
      r"\textbf{[Key Points]}",
      r"\begin{aligned} &\textcolor{green}{\sin x = \frac{2t}{1+t^2}, \quad dx = \frac{2\,dt}{1+t^2}} \text{ (see supplement)}\\[5pt] &2 + \sin x = 2 + \frac{2t}{1+t^2} = \frac{2(1+t^2) + 2t}{1+t^2} = \frac{2(t^2+t+1)}{1+t^2} \end{aligned}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} x=0 &\Rightarrow t=\tan0=0,\\[5pt] x=\frac{\pi}{2} &\Rightarrow t=\tan\frac{\pi}{4}=1. \end{aligned}",
      r"\begin{aligned} \int_{0}^{\frac{\pi}{2}}\frac{dx}{2+\sin x} &= \int_{t=0}^{t=1} \frac{1}{\frac{2(t^2+t+1)}{1+t^2}}\cdot\frac{2\,dt}{1+t^2}\\[6pt] &= \int_{0}^{1} \frac{2\,dt}{2(t^2+t+1)}\\[6pt] &= \int_{0}^{1} \frac{dt}{t^2+t+1}\\[6pt] &= \int_{0}^{1} \frac{dt} {\left(t+\frac{1}{2}\right)^2 + \frac{3}{4}}\\[6pt] &=\textcolor{blue}{\int_{0}^{1} \frac{dt}{\left(t+\frac{1}{2}\right)^2 + \left(\frac{\sqrt{3}}{2}\right)^2}} \end{aligned}",
      r"\text{Let } t + \frac{1}{2} = \frac{\sqrt{3}}{2}\tan\theta. \text{ Then } dt = \frac{\sqrt{3}}{2}(1+\tan^2\theta) \, d\theta, \text{ and:}",
      r"\begin{aligned} t = 0 &\Rightarrow t + \frac{1}{2} = \frac{1}{2} \Rightarrow \frac{\sqrt{3}}{2}\tan\theta = \frac{1}{2} \Rightarrow \tan\theta = \frac{1}{\sqrt{3}} \Rightarrow \theta = \frac{\pi}{6}\\[5pt] t = 1 &\Rightarrow t + \frac{1}{2} = \frac{3}{2} \Rightarrow \frac{\sqrt{3}}{2}\tan\theta = \frac{3}{2} \Rightarrow \tan\theta = \sqrt{3} \Rightarrow \theta = \frac{\pi}{3} \end{aligned}",
      r"\text{Therefore:}",
      r"\begin{aligned} &=\textcolor{blue}{\int_{0}^{1} \frac{dt}{\left(t+\frac{1}{2}\right)^2 + \left(\frac{\sqrt{3}}{2}\right)^2}}\\[5pt] &=\int_{\theta=\frac{\pi}{6}}^{\theta=\frac{\pi}{3}} \frac{\frac{\sqrt{3}}{2}(1+\tan^2\theta) \, d\theta}{\left(\frac{\sqrt{3}}{2}\tan\theta\right)^2 + \left(\frac{\sqrt{3}}{2}\right)^2}\\[5pt] &= \int_{\theta=\frac{\pi}{6}}^{\theta=\frac{\pi}{3}} \frac{\frac{\sqrt{3}}{2}(1+\tan^2\theta) \, d\theta}{\frac{3}{4}(\tan^2\theta + 1)}\\[5pt] &= \int_{\frac{\pi}{6}}^{\frac{\pi}{3}} \frac{\frac{\sqrt{3}}{2}(1+\tan^2\theta) \, d\theta}{\frac{3}{4}(1+\tan^2\theta)}\\[5pt] &= \int_{\frac{\pi}{6}}^{\frac{\pi}{3}} \frac{2}{\sqrt{3}} \, d\theta\\[5pt] &= \frac{2}{\sqrt{3}}\left[\theta\right]_{\frac{\pi}{6}}^{\frac{\pi}{3}}\\[5pt] &= \frac{2}{\sqrt{3}}\left(\frac{\pi}{3} - \frac{\pi}{6}\right)\\[5pt] &= \frac{\pi}{3\sqrt{3}} \end{aligned}",
      r"\textbf{[Supplement]}",
      r"\text{The half-angle substitution } t = \tan\left(\frac{x}{2}\right) \text{ allows trigonometric functions to be expressed as rational functions of } t.",
      r"\text{From } t = \tan\left(\frac{x}{2}\right), \text{ we have } \sin\left(\frac{x}{2}\right) = t\cos\left(\frac{x}{2}\right).",
      r"\text{Also, from } \sin^2\left(\frac{x}{2}\right) + \cos^2\left(\frac{x}{2}\right) = 1:",
      r"\begin{aligned} &t^2\cos^2\left(\frac{x}{2}\right) + \cos^2\left(\frac{x}{2}\right) = 1\\[5pt] &\cos^2\left(\frac{x}{2}\right)(1+t^2) = 1\\[5pt] &\textcolor{green}{\cos\left(\frac{x}{2}\right) = \frac{1}{\sqrt{1+t^2}}}, \quad \textcolor{green}{\sin\left(\frac{x}{2}\right) = \frac{t}{\sqrt{1+t^2}}} \end{aligned}",
      r"\text{Using the double-angle formula:}",
      r"\begin{aligned} &\textcolor{green}{\sin x = 2\sin\left(\frac{x}{2}\right)\cos\left(\frac{x}{2}\right) = \frac{2t}{1+t^2}} \end{aligned}",
      r"\text{Differentiating } t = \tan\left(\frac{x}{2}\right) \text{ with respect to } x:",
      r"\begin{aligned} &t' = \left(\tan\left(\frac{x}{2}\right)\right)' = \frac{1}{\cos^2\left(\frac{x}{2}\right)} \cdot \frac{1}{2} = \frac{1+t^2}{2}\\[5pt] &\textcolor{green}{dx = \frac{2}{1+t^2} \, dt} \end{aligned}",
    ],
  ),
  "C1D2E3F4-G5H6-I7J8-K9L0-M1N2O3P4Q5": ProblemTranslation(
    category: 'Trigonometric Fractions',
    question:
        r"""\displaystyle \int_{-\frac{\pi}{12}}^{\frac{\pi}{12}} \frac{dx}{\cos^2(3x)}""",
    answer: r"""\displaystyle \frac{2}{3}""",

    level: 'Mid',
    hint:
        r"\text{Use substitution } u=3x \text{ and the basic integral } \displaystyle\int \sec^2 u\,du=\tan u + C.",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use substitution } u = 3x \text{ to reduce to the basic integral } \displaystyle\int \frac{1}{\cos^2 u} \, du = \tan u + C.",
      r"\textbf{[Solution]}",
      r"\text{With } u = 3x, \text{ we have } du = 3 \, dx, \text{ so } \displaystyle dx = \frac{1}{3} \, du.",
      r"\begin{aligned} x = -\frac{\pi}{12} &\Rightarrow u = 3 \cdot \left(-\frac{\pi}{12}\right) = -\frac{\pi}{4}\\[5pt] x = \frac{\pi}{12} &\Rightarrow u = 3 \cdot \frac{\pi}{12} = \frac{\pi}{4} \end{aligned}",
      r"\begin{aligned} &\ \ \ \ \ \int_{-\frac{\pi}{12}}^{\frac{\pi}{12}} \frac{dx}{\cos^2(3x)}\\[5pt] &= \int_{u=-\frac{\pi}{4}}^{u=\frac{\pi}{4}} \frac{1}{\cos^2 u} \cdot \frac{1}{3} \, du\\[5pt] &= \frac{1}{3} \int_{-\frac{\pi}{4}}^{\frac{\pi}{4}} \frac{1}{\cos^2 u} \, du\\[5pt] &= \frac{1}{3} \left[\tan u\right]_{-\frac{\pi}{4}}^{\frac{\pi}{4}}\\[5pt] &= \frac{1}{3} \left(\tan\frac{\pi}{4} - \tan\left(-\frac{\pi}{4}\right)\right)\\[5pt] &= \frac{1}{3} \left(1 - (-1)\right)\\[5pt] &= \frac{1}{3} \cdot 2\\[5pt] &= \frac{2}{3} \end{aligned}",
    ],
  ),
  "4E69F402-F551-49E7-A295-047AD1C75481": ProblemTranslation(
    category: 'Recurrence Relations for Integrals',
    question:
        r"""I_{n}=\displaystyle \int_{0}^{ \frac {\pi} {2}}\sin^n x\,dx\quad (n\ge 0)
\quad
\text{Find } I_{0}\text{ and }I_{1}.
""",
    answer: r""" 
I_{0} = \displaystyle \frac{\pi}{2},\quad I_{1} = 1
""",

    level: 'Mid',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Calculate the integrals for } n=0,1 \text{ directly according to the definition.}",
      r"\textbf{[Key Points]}",
      r"\text{Basic integrals: } \displaystyle\int 1\,dx = x, \ \displaystyle\int \sin x\,dx = -\cos x. \text{ Evaluation interval is } [0,\frac{\pi}{2}].",
      r"\textbf{[Solution]}",
      r"\begin{aligned} I_{0} &= \displaystyle\int_{0}^{\frac{\pi}{2}} 1\,dx \\ &= \left[ x \right]_{0}^{\frac{\pi}{2}} \\ &= \frac{\pi}{2} - 0 \\ &= \frac{\pi}{2} \end{aligned}",
      r"\begin{aligned} I_{1} &= \displaystyle\int_{0}^{\frac{\pi}{2}} \sin x\,dx \\ &= \left[ -\cos x \right]_{0}^{\frac{\pi}{2}} \\ &= \left(-\cos \frac{\pi}{2}\right) - \left(-\cos 0\right) \\ &= 0 - (-1) \\ &= 1 \end{aligned}",
      r"\textbf{[Supplement]}",
      r"\text{Direct calculation is sufficient for this problem. Evaluation using the beta function is also possible, but we do not use it here.}",
    ],
  ),
  "E4E57A29-3A93-42B0-85A5-D5098551A8AC": ProblemTranslation(
    category: 'Recurrence Relations for Integrals',
    question: r"""J_{n}=\displaystyle \int_{0}^{ \frac {\pi} {2}}\cos^{2n}x\,dx
\quad
\text{Express } J_{n}\text{ in terms of }J_{n-1}.
""",
    answer: r""" 
J_{n} = \displaystyle \frac{\pi}{2}\cdot\displaystyle \frac{(2n)!}{2^{2n}\,(n!)^{2}}
""",

    level: 'Mid',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Derive the recurrence relation } J_{n} = \frac{2n-1}{2n}J_{n-1} \text{ using integration by parts, then expand the product from } J_{0} = \frac{\pi}{2} \text{ to obtain a closed form.}",
      r"\textbf{[Key Points]}",
      r"\text{Integration by parts setup: } u=\cos^{2n-1}x, dv=\cos x\,dx \ (\Rightarrow\ du=-(2n-1)\cos^{2n-2}x\sin x\,dx, v=\sin x).",
      r"\text{The boundary term } \cos^{2n-1}x\sin x \text{ vanishes at } x=0, \frac{\pi}{2}.",
      r"\text{Use the identity } \sin^{2}x=1-\cos^{2}x \text{ to separate into } J_{n-1} \text{ and } J_{n}.",
      r"\textbf{[Solution] (Derivation of recurrence relation)}",
      r"\begin{aligned} J_{n} &= \displaystyle\int_{0}^{\frac{\pi}{2}} \cos^{2n}x\,dx \\ &= \displaystyle\int_{0}^{\frac{\pi}{2}} \cos^{2n-1}x\cdot\cos x\,dx \\ &= \left[ \cos^{2n-1}x\cdot\sin x \right]_{0}^{\frac{\pi}{2}} - \displaystyle\int_{0}^{\frac{\pi}{2}} \sin x \cdot \left(-(2n-1)\cos^{2n-2}x\sin x\right)\,dx \\ &= 0 + (2n-1)\displaystyle\int_{0}^{\frac{\pi}{2}} \cos^{2n-2}x\,\sin^{2}x\,dx \\ &= (2n-1)\displaystyle\int_{0}^{\frac{\pi}{2}} \cos^{2n-2}x\,(1-\cos^{2}x)\,dx \\ &= (2n-1)\displaystyle\int_{0}^{\frac{\pi}{2}} \cos^{2n-2}x\,dx - (2n-1)\displaystyle\int_{0}^{\frac{\pi}{2}} \cos^{2n}x\,dx \\ &= (2n-1)J_{n-1} - (2n-1)J_{n} \end{aligned}",
      r"\begin{aligned} J_{n} + (2n-1)J_{n} &= (2n-1)J_{n-1} \\ 2n\,J_{n} &= (2n-1)J_{n-1} \\ J_{n} &= \frac{2n-1}{2n}\,J_{n-1} \end{aligned}",
      r"\textbf{[Solution] (Initial value and product expansion)}",
      r"\begin{aligned} J_{0} &= \displaystyle\int_{0}^{\frac{\pi}{2}} 1\,dx \\ &= \left[ x \right]_{0}^{\frac{\pi}{2}} \\ &= \frac{\pi}{2} \end{aligned}",
      r"\begin{aligned} J_{n} &= \frac{2n-1}{2n}\cdot \frac{2n-3}{2n-2}\cdots \frac{1}{2}\cdot J_{0} \\ &= \left( \prod_{k=1}^{n} \frac{2k-1}{2k} \right)\cdot \frac{\pi}{2} \end{aligned}",
      r"\textbf{[Solution] (Expressing product in terms of factorials)}",
      r"\begin{aligned} \prod_{k=1}^{n} (2k-1) &= 1\cdot 3 \cdot 5 \cdots (2n-1) \\ &= \frac{1\cdot 2 \cdot 3 \cdots (2n)}{2\cdot 4 \cdot 6 \cdots (2n)} \\ &= \frac{(2n)!}{2^{n}\,n!} \end{aligned}",
      r"\begin{aligned} \prod_{k=1}^{n} (2k) &= 2\cdot 4 \cdot 6 \cdots (2n) \\ &= 2^{n}\,n! \end{aligned}",
      r"\begin{aligned} \prod_{k=1}^{n} \frac{2k-1}{2k} &= \frac{\prod_{k=1}^{n} (2k-1)}{\prod_{k=1}^{n} (2k)} \\ &= \frac{\frac{(2n)!}{2^{n}\,n!}}{2^{n}\,n!} \\ &= \frac{(2n)!}{2^{2n}\,(n!)^{2}} \end{aligned}",
      r"\begin{aligned} J_{n} &= \frac{\pi}{2}\cdot \frac{(2n)!}{2^{2n}\,(n!)^{2}} \end{aligned}",
      r"\textbf{[Supplement]}",
      r"\text{Using the beta function } B(p,q), \text{ we can also write } J_{n}=\frac{1}{2}B\!\left(\frac{1}{2},\,n+\frac{1}{2}\right), \text{ but we do not use it here.}",
    ],
  ),
  "FF359933-B62F-49DE-8469-0B676607D489": ProblemTranslation(
    category: 'Recurrence Relations for Integrals',
    question: r"""I_{n}=\displaystyle \int_{0}^{1}x^n\log  x\,dx
\quad
\text{Express } I_{n}\text{ in terms of }I_{n-1}.
""",
    answer: r""" 
I_{n} = -\displaystyle \frac{1}{(n+1)^2}
""",

    level: 'Advanced',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use integration by parts to differentiate } \log x \text{ and integrate the power function } x^n. \text{ Carefully verify the limits at endpoints } x=0,1.",
      r"\textbf{[Key Points]}",
      r"\text{Setup: } u=\log x, dv=x^n\,dx \ \Rightarrow\ du=\frac{1}{x}\,dx, v=\frac{x^{n+1}}{n+1}. \text{ The boundary term } \left[\frac{x^{n+1}}{n+1}\log x\right]_{0}^{1} \text{ becomes } 0.",
      r"\textbf{[Solution] (Limit at endpoint } x\to 0^{+} \textbf{)}",
      r"\begin{aligned} \lim_{x\to 0^{+}} x^{n+1}\log x &= \lim_{x\to 0^{+}} \frac{\log x}{x^{-(n+1)}} \\ &= \lim_{x\to 0^{+}} \frac{\frac{d}{dx}(\log x)}{\frac{d}{dx}\left(x^{-(n+1)}\right)} \\ &= \lim_{x\to 0^{+}} \frac{1/x}{-(n+1)\,x^{-(n+2)}} \\ &= \lim_{x\to 0^{+}} \left(-\frac{1}{n+1}\,x^{n+1}\right) \\ &= 0 \end{aligned}",
      r"\textbf{[Solution] (Main calculation)}",
      r"\begin{aligned} I_{n} &= \displaystyle\int_{0}^{1} x^{n}\log x\,dx \\ &= \left[ \frac{x^{n+1}}{n+1}\,\log x \right]_{0}^{1} - \displaystyle\int_{0}^{1} \frac{x^{n+1}}{n+1}\cdot \frac{1}{x}\,dx \\ &= 0 - \frac{1}{n+1}\displaystyle\int_{0}^{1} x^{n}\,dx \\ &= -\frac{1}{n+1}\left[ \frac{x^{n+1}}{n+1} \right]_{0}^{1} \\ &= -\frac{1}{n+1}\left( \frac{1^{n+1}}{n+1} - \frac{0^{n+1}}{n+1} \right) \\ &= -\frac{1}{n+1}\cdot \frac{1}{n+1} \\ &= -\frac{1}{(n+1)^{2}} \end{aligned}",
      r"\textbf{[Supplement]}",
      r"\text{From the closed form } I_{n}=-\frac{1}{(n+1)^{2}}, \text{ we have } \begin{aligned} I_{n-1} &= -\frac{1}{n^{2}},\\ I_{n} &= \frac{n^{2}}{(n+1)^{2}}\,I_{n-1} \end{aligned}. \text{ This can also be derived using the beta function or parameter differentiation, but we do not use them here.}",
    ],
  ),

  // problems_quadratic_radical.dart
  "C13B40D7-8559-43C1-8D36-0EBEA7E37F30": ProblemTranslation(
    category: 'Quadratic Radicals',
    level: 'Advanced',
    question: r"""\displaystyle \int \sqrt{x^2+1}\,dx""",
    answer:
        r"""\displaystyle \frac{x}{2}\sqrt{x^2+1} + \displaystyle \frac{1}{2}\log\!\left|x+\sqrt{x^2+1}\right| + C""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use integration by parts to relate }I=\displaystyle\int\sqrt{x^2+1}\,dx\text{ to itself, then reduce to }\displaystyle\int\displaystyle\frac{dx}{\sqrt{x^2+1}}\text{.}",
      r"\textbf{[Key Point]}",
      r"\text{Use }u=\sqrt{x^2+1},\ dv=dx \text{ and the decomposition } x^2=(x^2+1)-1\text{.}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} I &= \int 1\cdot\sqrt{x^2+1}\,dx \\ &= x\sqrt{x^2+1} - \int x\cdot\frac{x}{\sqrt{x^2+1}}\,dx \\ &= x\sqrt{x^2+1} - \int \frac{x^2}{\sqrt{x^2+1}}\,dx \\ &= x\sqrt{x^2+1} - \int \frac{(x^2+1)-1}{\sqrt{x^2+1}}\,dx \\ &= x\sqrt{x^2+1} - \int \sqrt{x^2+1}\,dx + \int \frac{dx}{\sqrt{x^2+1}} \\ &= x\sqrt{x^2+1} - I + \int \frac{dx}{\sqrt{x^2+1}} \end{aligned}",
      r"\begin{aligned} 2I &= x\sqrt{x^2+1} + \int \frac{dx}{\sqrt{x^2+1}} \\ I &= \frac{x}{2}\sqrt{x^2+1} + \frac{1}{2}\int \frac{dx}{\sqrt{x^2+1}} \end{aligned}",
      r"\text{Also, } \displaystyle \int \displaystyle\frac{dx}{\sqrt{x^2+1}}=\log\!\left|x+\sqrt{x^2+1}\right|+C\text{ (check by differentiation).}",
      r"\begin{aligned} \therefore\ I=\displaystyle \frac{x}{2}\sqrt{x^2+1} + \displaystyle \frac{1}{2}\log\!\left|x+\sqrt{x^2+1}\right| + C \end{aligned}",
    ],
  ),
  "295EB83A-31A6-4379-955A-58D4E7614320": ProblemTranslation(
    category: 'Quadratic Radicals',
    level: 'Mid',
    question:
        r"""\displaystyle \int_{-1}^{1} \displaystyle \frac{dx}{\sqrt{1-x^2}}""",
    answer: r"""\pi""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the trigonometric substitution }x=\sin\theta\text{ so that }\sqrt{1-x^2}=\cos\theta\text{ on the interval.}",
      r"\textbf{[Interval Conversion]}",
      r"\text{When }x=-1,\ \theta=-\displaystyle\frac{\pi}{2};\quad \text{when }x=1,\ \theta=\displaystyle\frac{\pi}{2}.",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \int_{-1}^{1}\frac{dx}{\sqrt{1-x^2}} &= \int_{-\frac{\pi}{2}}^{\frac{\pi}{2}} \frac{\cos\theta}{\sqrt{1-\sin^2\theta}}\,d\theta \\ &= \int_{-\frac{\pi}{2}}^{\frac{\pi}{2}} \frac{\cos\theta}{|\cos\theta|}\,d\theta \\ &= \int_{-\frac{\pi}{2}}^{\frac{\pi}{2}} 1\,d\theta \\ &= \left[\theta\right]_{-\frac{\pi}{2}}^{\frac{\pi}{2}} = \pi \end{aligned}",
    ],
  ),
  "9BA403E8-04E8-48FC-9200-99FD6A2D7846": ProblemTranslation(
    category: 'Quadratic Radicals',
    level: 'Advanced',
    question: r"""\displaystyle \int \sqrt{x^2+4x+5}\,dx""",
    answer:
        r"""\displaystyle \frac{x+2}{2}\sqrt{(x+2)^2+1} + \displaystyle \frac{1}{2}\log\!\left|x+2+\sqrt{(x+2)^2+1}\right| + C""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Complete the square and reduce to Problem 1 via }u=x+2\text{.}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} x^2+4x+5 &= (x+2)^2+1, \\ \int \sqrt{x^2+4x+5}\,dx &= \int \sqrt{(x+2)^2+1}\,dx \xrightarrow{u=x+2} \int \sqrt{u^2+1}\,du. \end{aligned}",
      r"\text{Apply the result of } \displaystyle\int\sqrt{u^2+1}\,du \text{ from Problem 1 and substitute back }u=x+2\text{.}",
    ],
  ),
  "CEC675CF-86F7-4027-B139-DB88DD3D662F": ProblemTranslation(
    category: 'Quadratic Radicals',
    level: 'Advanced',
    question:
        r"""\displaystyle \int \displaystyle \frac{x^2}{\sqrt{x^2+1}}\,dx""",
    answer:
        r"""\displaystyle \frac{1}{2}x\sqrt{x^2+1} - \displaystyle \frac{1}{2}\log\!\left|x+\sqrt{x^2+1}\right| + C""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use }x^2=(x^2+1)-1\text{ to split into two standard integrals.}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \int \frac{x^2}{\sqrt{x^2+1}}\,dx &= \int \frac{(x^2+1)-1}{\sqrt{x^2+1}}\,dx \\ &= \int \sqrt{x^2+1}\,dx - \int \frac{dx}{\sqrt{x^2+1}}. \end{aligned}",
      r"\text{Use } \displaystyle\int\sqrt{x^2+1}\,dx \text{ from Problem 1 and } \displaystyle\int\displaystyle\frac{dx}{\sqrt{x^2+1}}=\log\!\left|x+\sqrt{x^2+1}\right|+C\text{.}",
      r"\begin{aligned} \therefore\ \int \frac{x^2}{\sqrt{x^2+1}}\,dx = \frac{1}{2}x\sqrt{x^2+1} - \frac{1}{2}\log\!\left|x+\sqrt{x^2+1}\right| + C \end{aligned}",
    ],
  ),
  "733CD527-888E-479D-B4D1-1AD5AB48856E": ProblemTranslation(
    category: 'Quadratic Radicals',
    level: 'Mid',
    question:
        r"""\displaystyle \int \displaystyle \frac{dx}{\sqrt{x^2 - a^2}}\quad (x>a>0)""",
    answer: r"""\displaystyle \log\!\left|x + \sqrt{x^2 - a^2}\right| + C""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Verify by differentiating the candidate primitive function }F(x)=\log\!\left|x+\sqrt{x^2-a^2}\right|\text{.}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} F(x) &= \log\!\left|x+\sqrt{x^2-a^2}\right|,\\ F'(x) &= \frac{1}{x+\sqrt{x^2-a^2}}\left(1+\frac{x}{\sqrt{x^2-a^2}}\right)\\ &= \frac{\sqrt{x^2-a^2}+x}{(x+\sqrt{x^2-a^2})\sqrt{x^2-a^2}}\\ &= \frac{1}{\sqrt{x^2-a^2}}. \end{aligned}",
      r"\begin{aligned} \therefore\ \int \frac{dx}{\sqrt{x^2-a^2}} = \log\!\left|x+\sqrt{x^2-a^2}\right| + C. \end{aligned}",
    ],
  ),
  "649EB9D0-FDDB-410A-AC5B-A756A35E2D58": ProblemTranslation(
    category: 'Square Roots (Standard Forms)',
    level: 'Mid',
    question:
        r"""\displaystyle \int_{-1}^{1}\displaystyle \frac{dx}{(x^2+2)\sqrt{x^2+2}}""",
    answer: r"""\displaystyle \frac{1}{\sqrt{3}}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use }x=\sqrt{2}\tan\theta\text{ to simplify }\sqrt{x^2+2}\text{.}",
      r"\textbf{[Substitution]}",
      r"\begin{aligned} x=\sqrt{2}\tan\theta,\quad dx=\sqrt{2}\sec^2\theta\,d\theta,\\ x^2+2=2\sec^2\theta,\quad \sqrt{x^2+2}=\sqrt{2}\sec\theta. \end{aligned}",
      r"\textbf{[Integrand]}",
      r"\begin{aligned} \frac{dx}{(x^2+2)\sqrt{x^2+2}} &= \frac{\sqrt{2}\sec^2\theta\,d\theta}{(2\sec^2\theta)(\sqrt{2}\sec\theta)} = \frac{1}{2}\cos\theta\,d\theta. \end{aligned}",
      r"\textbf{[Bounds]}",
      r"\text{When }x=\pm1,\ \theta=\arctan\!\left(\pm\displaystyle\frac{1}{\sqrt{2}}\right). \text{ The integrand is even, so we use }2\int_0^1\cdots\text{.}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \int_{-1}^{1}\frac{dx}{(x^2+2)\sqrt{x^2+2}} &= 2\int_{0}^{\arctan(1/\sqrt{2})}\cos\theta\,d\theta \\ &= 2\left[\sin\theta\right]_{0}^{\arctan(1/\sqrt{2})} \\ &= 2\sin\!\bigl(\arctan(1/\sqrt{2})\bigr). \end{aligned}",
      r"\text{Let } \alpha=\arctan(1/\sqrt{2}).\ \tan\alpha=1/\sqrt{2}\Rightarrow \sin\alpha=\displaystyle\frac{1}{\sqrt{3}}.",
      r"\begin{aligned} \therefore\ \int_{-1}^{1}\frac{dx}{(x^2+2)\sqrt{x^2+2}}=\frac{1}{\sqrt{3}}. \end{aligned}",
    ],
  ),
  "897CD524-5BB7-47CB-BF28-E3E68E133F32": ProblemTranslation(
    category: 'Square Roots (Circular Arc)',
    level: 'Mid',
    question:
        r"""\displaystyle \int_{1}^{a/2}\sqrt{a^{2}-x^{2}}\,dx\quad(a\ge 2)""",
    answer:
        r"""\displaystyle \frac{a^{2}\sqrt{3}}{8} - \displaystyle \frac{1}{2}\sqrt{a^{2}-1} + \displaystyle \frac{a^{2}}{2}\left(\displaystyle \frac{\pi}{6}-\arcsin\displaystyle \frac{1}{a}\right)""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use }x=a\sin\theta\ (0\le\theta\le\displaystyle\frac{\pi}{2})\text{ and reduce to an integral of }\cos^2\theta\text{.}",
      r"\textbf{[Bounds]}",
      r"\text{When }x=1,\ \theta=\arcsin\!\left(\displaystyle\frac{1}{a}\right);\quad \text{when }x=\displaystyle\frac{a}{2},\ \theta=\arcsin\!\left(\displaystyle\frac{1}{2}\right)=\displaystyle\frac{\pi}{6}.",
      r"\textbf{[Solution]}",
      r"\begin{aligned} I &= \int_{1}^{a/2}\sqrt{a^2-x^2}\,dx \xrightarrow{x=a\sin\theta} a^2\int_{\arcsin(1/a)}^{\pi/6}\cos^2\theta\,d\theta \\ &= a^2\int_{\arcsin(1/a)}^{\pi/6}\frac{1+\cos2\theta}{2}\,d\theta \\ &= \frac{a^2}{2}\left[\theta+\frac{\sin2\theta}{2}\right]_{\arcsin(1/a)}^{\pi/6}. \end{aligned}",
      r"\text{Simplifying yields the stated result.}",
    ],
  ),
  "A28E4B29-0D6F-4B4D-8C13-343682C251A1": ProblemTranslation(
    category: 'Square Roots (Log Form)',
    level: 'Mid',
    question:
        r"""\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{\sqrt{x^{2}+1}}""",
    answer: r"""\displaystyle \log\!\left(1+\sqrt{2}\right)""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use } \displaystyle\int\displaystyle\frac{dx}{\sqrt{x^2+1}}=\log\!\left|x+\sqrt{x^2+1}\right|+C \text{ and evaluate }[0,1]\text{.}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \int_{0}^{1}\frac{dx}{\sqrt{x^{2}+1}} &= \left[\log\!\left(x+\sqrt{x^2+1}\right)\right]_{0}^{1} \\ &= \log\!\left(1+\sqrt{2}\right)-\log(1) \\ &= \log\!\left(1+\sqrt{2}\right). \end{aligned}",
    ],
  ),
  "B7FBE400-DE79-4365-AD89-A544F45A8170": ProblemTranslation(
    category: 'Rationalization (Algebraic Simplification)',
    level: 'Mid',
    question:
        r"""\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{x+\sqrt{x^{2}+1}}""",
    answer:
        r"""\displaystyle \frac{\sqrt{2}}{2} + \displaystyle \frac{1}{2}\log\!\left(1+\sqrt{2}\right) - \displaystyle \frac{1}{2}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Rationalize the denominator to rewrite } \displaystyle\frac{1}{x+\sqrt{x^2+1}}=\sqrt{x^2+1}-x\text{.}",
      r"\textbf{[Rationalization]}",
      r"\begin{aligned} \frac{1}{x+\sqrt{x^2+1}}\cdot\frac{\sqrt{x^2+1}-x}{\sqrt{x^2+1}-x} &= \frac{\sqrt{x^2+1}-x}{(x+\sqrt{x^2+1})(\sqrt{x^2+1}-x)} \\ &= \sqrt{x^2+1}-x. \end{aligned}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \int_{0}^{1}\frac{dx}{x+\sqrt{x^{2}+1}} &= \int_{0}^{1}\left(\sqrt{x^2+1}-x\right)\,dx \\ &= \left[\frac{x}{2}\sqrt{x^2+1}+\frac{1}{2}\log\!\left(x+\sqrt{x^2+1}\right)\right]_{0}^{1} - \left[\frac{x^2}{2}\right]_{0}^{1} \\ &= \left(\frac{\sqrt{2}}{2}+\frac{1}{2}\log(1+\sqrt{2})\right) - \frac{1}{2}. \end{aligned}",
    ],
  ),
  "D36E79F5-FF3C-442A-8A3A-DE453F25EA60": ProblemTranslation(
    category: 'Quadratic Radicals',
    level: 'Mid',
    question: r"""\displaystyle \int_{0}^{3} \frac{dx}{\sqrt{x^2+9}}""",
    answer: r"""\log(1+\sqrt{2})""",
    hint: r"""\text{Use the substitution } x = 3\tan\theta\text{.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the trigonometric substitution } x = 3\tan\theta \text{ to simplify the integrand.}",
      r"\textbf{[Explanation]}",
      r"\text{Let } x = 3\tan\theta\text{. Then}",
      r"""\begin{aligned}
x = 0 &\Rightarrow 0 = 3\tan\theta \Rightarrow \theta = 0\\[5pt]
x = 3 &\Rightarrow 3 = 3\tan\theta \Rightarrow \tan\theta = 1 \Rightarrow \theta = \frac{\pi}{4}
\end{aligned}""",
      r"\text{Also,}",
      r"""\begin{aligned}\begin{cases}
dx = 3(\tan\theta)' \, d\theta = 3 \cdot \frac{1}{\cos^2\theta} \, d\theta = 3(1+\tan^2\theta) \, d\theta\\[5pt]
\sqrt{x^2+9} = 3\sqrt{1+\tan^2\theta}
\end{cases}\end{aligned}""",
      r"\text{Therefore,}",
      r"""\begin{aligned}
\int_{0}^{3} \frac{dx}{\sqrt{x^2+9}}
&= \int_{\theta=0}^{\theta=\frac{\pi}{4}} \frac{3(1+\tan^2\theta)\,d\theta}{3\sqrt{1+\tan^2\theta}}\\[5pt]
&= \int_{0}^{\frac{\pi}{4}} \frac{1+\tan^2\theta}{\sqrt{1+\tan^2\theta}} \, d\theta\\[5pt]
&= \int_{0}^{\frac{\pi}{4}} \sqrt{1+\tan^2\theta} \, d\theta\\[5pt]
&= \int_{0}^{\frac{\pi}{4}} \frac{1}{\cos\theta} \, d\theta\\[5pt]
&= \int_{0}^{\frac{\pi}{4}} \frac{\cos\theta}{\cos^2\theta} \, d\theta\\[5pt]
&= \textcolor{blue}{\int_{0}^{\frac{\pi}{4}} \frac{\cos\theta}{1-\sin^2\theta} \, d\theta}
\end{aligned}""",
      r"\text{Let } u = \sin\theta\text{. Then } du = \cos\theta \, d\theta\text{ and}",
      r"""\begin{aligned}
\theta = 0 &\Rightarrow u = 0\\[5pt]
\theta = \frac{\pi}{4} &\Rightarrow u = \frac{\sqrt{2}}{2}
\end{aligned}""",
      r"""\begin{aligned}
&\ \ \ \ \ \textcolor{blue}{\int_{0}^{\frac{\pi}{4}} \frac{\cos\theta}{1-\sin^2\theta} \, d\theta}\\[5pt]
&= \int_{0}^{\frac{\sqrt{2}}{2}} \frac{du}{1-u^2}\\[5pt]
&= \int_{0}^{\frac{\sqrt{2}}{2}} \frac{1}{2}\left(\frac{1}{1-u} + \frac{1}{1+u}\right) du\\[5pt]
&= \frac{1}{2}\left[-\log|1-u| + \log|1+u|\right]_{0}^{\frac{\sqrt{2}}{2}}\\[5pt]
&= \frac{1}{2}\log\left(\frac{1+\frac{\sqrt{2}}{2}}{1-\frac{\sqrt{2}}{2}}\right)
=\log(1+\sqrt{2})
\end{aligned}""",
    ],
  ),
  "14D0F717-BEC3-49D9-98CF-F56C33CB6B3B": ProblemTranslation(
    category: 'Quadratic Radicals',
    level: 'Mid',
    question:
        r"""\displaystyle \int_{0}^{2} \frac{dx}{(4+x^2)^{\frac{3}{2}}}""",
    answer: r"""\displaystyle \frac{\sqrt{2}}{8}""",
    hint: r"""\text{Use the substitution } x = 2\tan\theta\text{.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the trigonometric substitution } x = 2\tan\theta \text{ to simplify the integrand.}",
      r"\textbf{[Explanation]}",
      r"\text{Let } x = 2\tan\theta\text{. Then}",
      r"""\begin{aligned}
x = 0 &\Rightarrow 0 = 2\tan\theta \Rightarrow \theta = 0\\[5pt]
x = 2 &\Rightarrow 2 = 2\tan\theta \Rightarrow \tan\theta = 1 \Rightarrow \theta = \frac{\pi}{4}
\end{aligned}""",
      r"\text{Also,}",
      r"""\begin{aligned}\begin{cases}
dx = 2(\tan\theta)' \, d\theta = 2 \cdot \frac{1}{\cos^2\theta} \, d\theta = 2(1+\tan^2\theta) \, d\theta\\[5pt]
(4+x^2)^{\frac{3}{2}} = [4(1+\tan^2\theta)]^{\frac{3}{2}} = 8(1+\tan^2\theta)^{\frac{3}{2}}
\end{cases}\end{aligned}""",
      r"\text{Therefore,}",
      r"""\begin{aligned}
\int_{0}^{2} \frac{dx}{(4+x^2)^{\frac{3}{2}}}
&= \int_{\theta=0}^{\theta=\frac{\pi}{4}} \frac{2(1+\tan^2\theta)\,d\theta}{8(1+\tan^2\theta)^{\frac{3}{2}}}\\[5pt]
&= \int_{0}^{\frac{\pi}{4}} \frac{1+\tan^2\theta}{4(1+\tan^2\theta)^{\frac{3}{2}}} \, d\theta\\[5pt]
&= \frac{1}{4}\int_{0}^{\frac{\pi}{4}} \frac{1}{(1+\tan^2\theta)^{\frac{1}{2}}} \, d\theta
\end{aligned}""",
      r"\text{Here, since } 1+\tan^2\theta=\frac{1}{\cos^2\theta}\text{, we have } (1+\tan^2\theta)^{1/2}=\frac{1}{|\cos\theta|}=\frac{1}{\cos\theta}\text{ (because }0\le\theta\le\frac{\pi}{4}\Rightarrow \cos\theta>0\text{).}",
      r"""\begin{aligned}
\frac{1}{4}\int_{0}^{\frac{\pi}{4}} \frac{1}{(1+\tan^2\theta)^{\frac{1}{2}}} \, d\theta
&= \frac{1}{4}\int_{0}^{\frac{\pi}{4}} \cos\theta \, d\theta\\[5pt]
&= \frac{1}{4}\left[\sin\theta\right]_{0}^{\frac{\pi}{4}}\\[5pt]
&= \frac{1}{4}\left(\sin\frac{\pi}{4} - \sin 0\right)
= \frac{\sqrt{2}}{8}
\end{aligned}""",
    ],
  ),

  // problems_integration_by_parts.dart
  "01AB7A0C-4FD8-4E11-B537-50DFBEF48965": ProblemTranslation(
    category: 'Integration by Parts',
    level: 'Easy',
    question: r"""\displaystyle \int_0^{\pi} x\cos x \,dx""",
    answer: r"""\displaystyle -2""",
    steps: [
      r"\textbf{[Solution]}",
      r"\text{Use integration by parts with }u=x,\ dv=\cos x\,dx\text{. Then }du=dx,\ v=\sin x\text{.}",
      r"\begin{aligned} \int_0^{\pi} x\cos x\,dx &= \left[x\sin x\right]_0^{\pi} - \int_0^{\pi}\sin x\,dx \\ &= 0 - \left[-\cos x\right]_0^{\pi} \\ &= -(-\cos\pi+\cos 0) \\ &= -(1+1) \\ &= -2 \end{aligned}",
    ],
  ),
  // (reserve / commented-out in source)
  "24269DC8-C26B-4A60-A238-1D3A9CB0D57D": ProblemTranslation(
    category: 'Integration by Parts',
    level: 'Easy',
    question: r"""\displaystyle \int x^2 e^x \,dx""",
    answer: r"""(x^2 - 2x + 2)e^x + C""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Apply integration by parts repeatedly to reduce the power of }x\text{.}",
      r"\textbf{[Solution]}",
      r"\text{Let } I=\displaystyle \int x^2 e^x\,dx. \text{ Take }u=x^2,\ dv=e^x\,dx\text{ so }du=2x\,dx,\ v=e^x.",
      r"\begin{aligned} I &= x^2 e^x - \int 2x e^x\,dx. \end{aligned}",
      r"\text{Now let } J=\displaystyle\int x e^x\,dx. \text{ Using }u=x,\ dv=e^x\,dx\text{:}",
      r"\begin{aligned} J &= x e^x - \int e^x\,dx = (x-1)e^x + C. \end{aligned}",
      r"\text{Therefore } \int 2x e^x\,dx = 2J = 2(x-1)e^x + C\text{, hence}",
      r"\begin{aligned} I &= x^2 e^x - 2(x-1)e^x + C = (x^2-2x+2)e^x + C. \end{aligned}",
    ],
  ),
  // (reserve / commented-out in source)
  "9D78C6AC-6B30-40DF-B1C2-C494A4E2D8A1": ProblemTranslation(
    category: 'Integration by Parts',
    level: 'Easy',
    question: r"""\displaystyle \int_{0}^{\pi} x\sin x \,dx""",
    answer: r"""\displaystyle \pi""",
    steps: [
      r"\textbf{[Solution]}",
      r"\text{Use integration by parts with }u=x,\ dv=\sin x\,dx\text{. Then }du=dx,\ v=-\cos x\text{.}",
      r"\begin{aligned} \int_{0}^{\pi} x\sin x\,dx &= \left[-x\cos x\right]_{0}^{\pi} - \int_{0}^{\pi}(-\cos x)\,dx \\ &= \left(-\pi\cos\pi\right) + \left[\sin x\right]_{0}^{\pi} \\ &= -\pi(-1) + (0-0) \\ &= \pi \end{aligned}",
    ],
  ),
  // (reserve / commented-out in source)
  "5C64DEF5-13F5-4F53-BAB1-3939CC6F9994": ProblemTranslation(
    category: 'Integration by Parts',
    level: 'Mid',
    question: r"""\displaystyle \int e^x \sin x \,dx""",
    answer: r"""\displaystyle \frac{1}{2}\,e^x(\sin x - \cos x) + C""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let } I=\displaystyle\int e^x\sin x\,dx \text{ and } J=\displaystyle\int e^x\cos x\,dx, \text{ then use integration by parts twice to form a system.}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} I &= \int e^x\sin x\,dx = -e^x\cos x + \int e^x\cos x\,dx = -e^x\cos x + J, \\ J &= \int e^x\cos x\,dx = e^x\sin x - \int e^x\sin x\,dx = e^x\sin x - I. \end{aligned}",
      r"\text{Substitute }J=e^x\sin x-I\text{ into the first equation:}",
      r"\begin{aligned} I &= -e^x\cos x + e^x\sin x - I \\ 2I &= e^x(\sin x-\cos x) \\ \therefore\ I &= \frac{1}{2}e^x(\sin x-\cos x) + C. \end{aligned}",
    ],
  ),
  // (reserve / commented-out in source)
  "603166CF-56C7-4075-8D7B-5D7EB90A9E20": ProblemTranslation(
    category: 'Product (Exponential × Trigonometric)',
    level: 'Advanced',
    question: r"""\displaystyle \int_{0}^{\infty} x e^{-x}\sin 2x\,dx""",
    answer: r"""\displaystyle \frac{4}{25}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the Laplace transform }F(s)=\displaystyle\int_0^\infty e^{-sx}\sin(2x)\,dx=\displaystyle\frac{2}{s^2+4}\text{ and differentiate: }-F'(s)=\int_0^\infty x e^{-sx}\sin(2x)\,dx.",
      r"\textbf{[Solution]}",
      r"\begin{aligned} F(s) &= \frac{2}{s^2+4},\\ F'(s) &= -\frac{4s}{(s^2+4)^2},\\ \int_0^\infty x e^{-sx}\sin(2x)\,dx &= -F'(s)=\frac{4s}{(s^2+4)^2}. \end{aligned}",
      r"\text{Substitute }s=1\text{:}",
      r"\begin{aligned} \int_0^\infty x e^{-x}\sin(2x)\,dx = \frac{4}{(1^2+4)^2}=\frac{4}{25}. \end{aligned}",
    ],
  ),
  // (reserve / commented-out in source)
  "F8352C53-F7CA-4173-85C0-E6A94D2ABA5E": ProblemTranslation(
    category: 'Exponential × Trigonometric (Integration by Parts)',
    level: 'Advanced',
    question:
        r"""\displaystyle \int_{ \frac {\pi} {4}}^{\pi} x e^{x}\sin x \,dx""",
    answer:
        r"""\displaystyle \frac{1}{2}e^{\pi}(\pi - 1) - \displaystyle \frac{\sqrt{2}}{4}\,e^{ \frac{\pi}{4}}""",
    steps: [
      r"\textbf{[Key Integrals]}",
      r"\begin{aligned} \int e^x\sin x\,dx &= \frac{1}{2}e^x(\sin x-\cos x) + C,\\ \int e^x\cos x\,dx &= \frac{1}{2}e^x(\sin x+\cos x) + C. \end{aligned}",
      r"\textbf{[Find a primitive]}",
      r"\text{Let } I=\int x e^x\sin x\,dx. \text{ Using integration by parts with }u=x,\ dv=e^x\sin x\,dx\text{:}",
      r"\begin{aligned} I &= x\cdot\frac{1}{2}e^x(\sin x-\cos x) - \int \frac{1}{2}e^x(\sin x-\cos x)\,dx. \end{aligned}",
      r"\text{Now}",
      r"\begin{aligned} \int \frac{1}{2}e^x(\sin x-\cos x)\,dx &= \frac{1}{2}\int e^x\sin x\,dx - \frac{1}{2}\int e^x\cos x\,dx \\ &= \frac{1}{4}e^x(\sin x-\cos x) - \frac{1}{4}e^x(\sin x+\cos x) \\ &= -\frac{1}{2}e^x\cos x. \end{aligned}",
      r"\text{Therefore}",
      r"\begin{aligned} I = \frac{1}{2}x e^x(\sin x-\cos x) + \frac{1}{2}e^x\cos x + C. \end{aligned}",
      r"\textbf{[Evaluate]}",
      r"\begin{aligned} \int_{\pi/4}^{\pi} x e^x\sin x\,dx &= \left[\frac{1}{2}e^x\left(x(\sin x-\cos x)+\cos x\right)\right]_{\pi/4}^{\pi} \\ &= \frac{1}{2}e^\pi(\pi-1) - \frac{\sqrt{2}}{4}e^{\pi/4}. \end{aligned}",
    ],
  ),
  "26D1B6CC-77F8-4522-88A0-0A06A41D8D67": ProblemTranslation(
    category: 'Integration by Parts (Exponential)',
    level: 'Mid',
    question:
        r"""\displaystyle \int_{0}^{\log 2} \displaystyle \frac{x+1}{e^{x}}\,dx""",
    answer: r"""\displaystyle -\frac{\log 2}{2} + 1""",
    hint:
        r"""\text{Rewrite } \displaystyle\frac{1}{e^x}=e^{-x}\text{ and apply integration by parts.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Rewrite } \displaystyle\frac{1}{e^x}=e^{-x}\text{ and apply integration by parts.}",
      r"\textbf{[Solution]}",
      r"\text{Evaluate } \int_{0}^{\log 2} (x+1)e^{-x}\,dx \text{ by parts (take }u=x+1,\ dv=e^{-x}dx\text{).}",
      r"\begin{aligned} \int_{0}^{\log 2} (x+1)e^{-x}\,dx &= \int_{0}^{\log 2} (x+1)\cdot(-e^{-x})'\,dx \\ &= \left[-(x+1)e^{-x}\right]_{0}^{\log 2} + \int_{0}^{\log 2} e^{-x}\,dx \\ &= -(\log 2+1)e^{-\log 2} + 1 + \left[-e^{-x}\right]_{0}^{\log 2} \\ &= -\frac{\log 2+1}{2} + 1 + \left(-\frac{1}{2}+1\right) \\ &= 1-\frac{\log 2}{2}. \end{aligned}",
    ],
  ),
  "CC1A2E7C-04EF-4D32-BB13-907FBEC6515D": ProblemTranslation(
    category: 'Integration by Parts',
    level: 'Mid',
    question: r"""\displaystyle \int_0^{\frac{\pi}{2}} x^2 \cos x \, dx""",
    answer: r"""\displaystyle \frac{\pi^2}{4} - 2""",
    steps: [
      r"\textbf{[Background]}",
      r"\text{This integral appears when computing the volume of the solid of revolution obtained by rotating } y=\sin x\ (0\le x\le \frac{\pi}{2}) \text{ about the } y\text{-axis.}",
      r"",
      r"\text{In fact, the volume is}",
      r"""\begin{aligned}
V &= \pi \int_0^{1} Y(x)^2 \, dy\\
&= \pi \int_0^{\frac{\pi}{2}} x^2 \frac{dy}{dx}\,dx\\
&= \pi \int_0^{\frac{\pi}{2}} x^2 \cos x \, dx
\end{aligned}""",
      r"\text{So it suffices to evaluate } \int_0^{\frac{\pi}{2}} x^2\cos x\,dx\text{.}",
      r"\textbf{[Solution]}",
      r"\text{Use integration by parts.}",
      r"""\begin{aligned}
\int_0^{\frac{\pi}{2}} x^2 \cos x \, dx &= \int_0^{\frac{\pi}{2}} x^2 \cdot (\sin x)' \, dx \\
&= \left[x^2 \sin x\right]_0^{\frac{\pi}{2}} - \int_0^{\frac{\pi}{2}} \sin x \cdot 2x \, dx \\
&= \left(\displaystyle \frac{\pi}{2}\right)^2 \cdot 1 - 0 - 2\int_0^{\frac{\pi}{2}} x \sin x \, dx \\
&= \displaystyle \frac{\pi^2}{4} - 2\textcolor{blue} {\int_0^{\frac{\pi}{2}} x \sin x \, dx}
\end{aligned}""",
      r"\text{Next, apply integration by parts to } \displaystyle \int_0^{\frac{\pi}{2}} x \sin x \, dx\text{.}",
      r"""\begin{aligned}
\textcolor{blue} {\int_0^{\frac{\pi}{2}} x \sin x \, dx} &= \int_0^{\frac{\pi}{2}} x \cdot (-\cos x)' \, dx \\
&= \left[-x \cos x\right]_0^{\frac{\pi}{2}} + \int_0^{\frac{\pi}{2}} \cos x \, dx \\
&= -\displaystyle\frac{\pi}{2} \cdot 0 + 0 + \left[\sin x\right]_0^{\frac{\pi}{2}} \\
&= \textcolor{blue} {1}
\end{aligned}""",
      r"\text{Therefore,}",
      r"""\begin{aligned}
\int_0^{\frac{\pi}{2}} x^2 \cos x \, dx &= \displaystyle \frac{\pi^2}{4} - 2 \cdot \textcolor{blue} {1} \\
&= \displaystyle \frac{\pi^2}{4} - 2
\end{aligned}""",
    ],
  ),
  "D9E29F85-E082-42D3-A2E6-34D162864716": ProblemTranslation(
    category: 'Integration by Parts (Exponential × Trigonometric)',
    level: 'Advanced',
    question: r"""\displaystyle \int_{0}^{\frac{\pi}{5}} e^{-2x}\cos 5x \,dx""",
    answer: r"""\displaystyle \frac{2(e^{\frac{-2\pi}{5}}+1)}{29}""",
    hint:
        r"""\text{Use the standard formula } \int e^{ax}\cos(bx)\,dx=\displaystyle\frac{e^{ax}}{a^2+b^2}\big(a\cos(bx)+b\sin(bx)\big).""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let } I=\displaystyle \int_{0}^{\frac{\pi}{5}} e^{-2x}\cos 5x \,dx \text{. Perform integration by parts twice and solve for }I\text{.}",
      r"\textbf{[Solution]}",
      r"\text{Use integration by parts.}",
      r"""\begin{aligned}
I &= \int_{0}^{\frac{\pi}{5}} e^{-2x}\cos 5x \,dx\\[5pt]
&= \int_{0}^{\frac{\pi}{5}} e^{-2x} \cdot \left(\displaystyle\frac{1}{5}\sin 5x\right)' \,dx\\[5pt]
&= \left[e^{-2x} \cdot \displaystyle\frac{1}{5}\sin 5x\right]_{0}^{\frac{\pi}{5}} - \int_{0}^{\frac{\pi}{5}} \displaystyle\frac{1}{5}\sin 5x \cdot (-2e^{-2x})\,dx\\[5pt]
&= \left(\displaystyle\frac{1}{5}e^{\frac{-2\pi}{5}}\sin\pi - \displaystyle\frac{1}{5}e^{0}\sin 0\right) + \displaystyle\frac{2}{5}\int_{0}^{\frac{\pi}{5}} e^{-2x}\sin 5x \,dx\\[5pt]
&= \displaystyle\frac{2}{5}\textcolor{blue}{\int_{0}^{\frac{\pi}{5}} e^{-2x}\sin 5x \,dx}
\end{aligned}""",
      r"\text{Next, integrate by parts for } \textcolor{blue}{\displaystyle \int_{0}^{\frac{\pi}{5}} e^{-2x}\sin 5x \,dx}\text{.}",
      r"""\begin{aligned}
&\ \ \ \ \ \textcolor{blue}{\int_{0}^{\frac{\pi}{5}} e^{-2x}\sin 5x \,dx} \\[5pt]
&= \int_{0}^{\frac{\pi}{5}} e^{-2x} \cdot \left(-\displaystyle\frac{1}{5}\cos 5x\right)' \,dx\\[5pt]
&= \left[e^{-2x} \cdot \left(-\displaystyle\frac{1}{5}\cos 5x\right)\right]_{0}^{\frac{\pi}{5}} - \int_{0}^{\frac{\pi}{5}} \left(-\displaystyle\frac{1}{5}\cos 5x\right) \cdot (-2e^{-2x})\,dx\\[5pt]
&= \left(-\displaystyle\frac{1}{5}e^{\frac{-2\pi}{5}}\cos\pi + \displaystyle\frac{1}{5}e^{0}\cos 0\right) - \displaystyle\frac{2}{5}\int_{0}^{\frac{\pi}{5}} e^{-2x}\cos 5x \,dx\\[5pt]
&= -\displaystyle\frac{1}{5}e^{\frac{-2\pi}{5}}\cos\pi + \displaystyle\frac{1}{5} - \displaystyle\frac{2}{5}I\\[5pt]
&= \textcolor{blue}{\displaystyle\frac{1}{5}e^{\frac{-2\pi}{5}} + \displaystyle\frac{1}{5} - \displaystyle\frac{2}{5}I}
\end{aligned}""",
      r"\text{Therefore,}",
      r"""\begin{aligned}
&\ \ \ \ \ I = \displaystyle\frac{2}{5}\textcolor{blue}{\left(\displaystyle\frac{1}{5}e^{\frac{-2\pi}{5}} + \displaystyle\frac{1}{5} - \displaystyle\frac{2}{5}I\right)}\\[5pt]
&\Leftrightarrow I = \displaystyle\frac{2}{25}e^{\frac{-2\pi}{5}} + \displaystyle\frac{2}{25} - \displaystyle\frac{4}{25}I\\
&\Leftrightarrow I + \displaystyle\frac{4}{25}I = \displaystyle\frac{2}{25}e^{\frac{-2\pi}{5}} + \displaystyle\frac{2}{25}\\[5pt]
&\Leftrightarrow \displaystyle\frac{29}{25}I = \displaystyle\frac{2(e^{\frac{-2\pi}{5}} + 1)}{25}\\[5pt]
&\Leftrightarrow I = \displaystyle\frac{2(e^{\frac{-2\pi}{5}} + 1)}{29}
\end{aligned}""",
    ],
  ),

  // problems_curves.dart
  "9E0F1A2B-3C4D-5E6F-7A8B-9C0D1E2F3C4D": ProblemTranslation(
    category: 'Arc Length of Curves',
    level: 'Advanced',
    question: r"""\displaystyle \int_0^{2\pi} \sqrt{2 - 2\cos x} \, dx""",
    answer: r"""8""",
    steps: [
      r"\textbf{[Background]}",
      r"\text{This integral appears when computing the arc length of a cycloid.}",
      r"\text{For the cycloid } x=t-\sin t,\; y=1-\cos t\text{, the arc length is:}",
      r"",
      r"""\begin{aligned}
x'(t) &= 1 - \cos t\\
y'(t) &= \sin t
\end{aligned}""",
      r"""\begin{aligned}
L &= \displaystyle \int_0^{2\pi} \sqrt{(x'(t))^2 + (y'(t))^2} \, dt\\
&= \displaystyle \int_0^{2\pi} \sqrt{(1-\cos t)^2 + (\sin t)^2} \, dt\\
&= \displaystyle \int_0^{2\pi} \sqrt{1 - 2\cos t + \cos^2 t + \sin^2 t} \, dt\\
&= \displaystyle \int_0^{2\pi} \sqrt{2 - 2\cos t} \, dt
\end{aligned}""",
      r"\textbf{[Calculation]}",
      r"\text{Using the half-angle identity } \sin^2 \dfrac{x}{2} = \dfrac{1 - \cos x}{2}\text{, we have }1-\cos x = 2\sin^2 \dfrac{x}{2}\text{.}",
      r"""\begin{aligned}
\displaystyle \int_0^{2\pi} \sqrt{2 - 2\cos x} \, dx &= \displaystyle \int_0^{2\pi} \sqrt{2 \cdot 2\sin^2 \dfrac{x}{2}} \, dx\\
&= \displaystyle \int_0^{2\pi} \sqrt{4\sin^2 \dfrac{x}{2}} \, dx\\
&= \displaystyle \int_0^{2\pi} 2\left|\sin \dfrac{x}{2}\right| \, dx
\end{aligned}""",
      r"\text{Since }0 \le x \le 2\pi\Rightarrow 0 \le \dfrac{x}{2} \le \pi\text{, we have }\sin \dfrac{x}{2} \ge 0\text{.}",
      r"""\begin{aligned}
\displaystyle \int_0^{2\pi} 2\left|\sin \dfrac{x}{2}\right| \, dx &= 2 \displaystyle \int_0^{2\pi} \sin \dfrac{x}{2} \, dx\\
&= 2 \cdot \left[-2\cos \dfrac{x}{2}\right]_0^{2\pi}\\
&= -4(\cos \pi - \cos 0)\\
&= -4(-1 - 1)\\
&= 8
\end{aligned}""",
    ],
  ),
  "C7312AD1-233C-42E9-94E7-BF9A59591EE1": ProblemTranslation(
    category: 'Trigonometric Integrals (Recurrence) + Application',
    level: 'Advanced',
    question:
        r"""\displaystyle \int_0^{ \frac{\pi}{2}} \sin^9 x \, dx""",
    answer: r"""\displaystyle \frac{128}{315}""",
    steps: [
      r"\textbf{[Method]}",
      r"\text{Use integration by parts to derive a recurrence for } I_n=\displaystyle \int_0^{\pi/2}\sin^n x\,dx\text{ and then compute }I_9\text{.}",
      r"\textcolor{green}{\text{Show\ that\ the\ following\ holds\ in\ general.}}",
      r"""\textcolor{green}{
\begin{aligned}
\begin{cases}
& n=0:\ \displaystyle I_0=\frac{\pi}{2} \\
& n\text{ even: }\displaystyle I_n = \frac{(n-1)(n-3)\cdots 3\cdot 1}{n(n-2)\cdots 4\cdot 2}\cdot\frac{\pi}{2}\\
& n\text{ odd: }\displaystyle I_n = \frac{(n-1)(n-3)\cdots 4\cdot 2}{n(n-2)\cdots 3\cdot 1}
\end{cases}
\end{aligned}
}""",
      r"""\begin{aligned}
I_n&=\displaystyle \int_0^{\frac{\pi}{2}}\sin^{n-1}x\cdot\sin x\,dx \\
& = \displaystyle \int_0^{\frac{\pi}{2}}\sin^{n-1}x\cdot(-\cos x)'\,dx \\
& = \displaystyle \int_0^{\frac{\pi}{2}}- \sin^{n-1}x\cdot(\cos x)'\,dx \\
&= \left[-\sin^{n-1}x\cos x\right]_0^{\frac{\pi}{2}} + (n-1)\displaystyle \int_0^{\frac{\pi}{2}}\sin^{n-2}x\cos^2 x\,dx \\
&= (n-1)\displaystyle \int_0^{\frac{\pi}{2}}\sin^{n-2}x\cos^2 x\,dx \\
&= (n-1)\displaystyle \int_0^{\frac{\pi}{2}}\sin^{n-2}x(1-\sin^2 x)\,dx \\
&= (n-1)\displaystyle \int_0^{\frac{\pi}{2}}\sin^{n-2}x\,dx - (n-1)\displaystyle \int_0^{\frac{\pi}{2}}\sin^n x\,dx \\
&= (n-1)\left(I_{n-2}-I_n\right)
\end{aligned}""",
      r"\text{Hence the recurrence } \displaystyle I_n=\frac{n-1}{n}I_{n-2}\text{ follows.}",
      r"\displaystyle I_0,\ I_1\text{ are easy to compute:}",
      r"""\begin{aligned}
\displaystyle I_0&=\int_0^{\frac{\pi}{2}}1\,dx=\frac{\pi}{2} \\
\displaystyle I_1&=\int_0^{\frac{\pi}{2}}\sin x\,dx=1
\end{aligned}""",
      r"\text{Iterating the recurrence gives the even/odd closed forms above.}",
      r"""\begin{aligned}
\textcolor{green}{
\displaystyle I_n =
\begin{cases}
\displaystyle \frac{(n-1) \cdot (n-3) \cdot \cdots \cdot 3 \cdot 1}{n \cdot (n-2) \cdot \cdots \cdot 4 \cdot 2}\cdot\frac{\pi}{2} & (n\ \text{:even})\\[6pt]
\displaystyle \frac{(n-1) \cdot (n-3) \cdot \cdots \cdot 4 \cdot 2}{n \cdot (n-2) \cdot \cdots \cdot 3 \cdot 1} & (n\ \text{:odd})
\end{cases}}
\end{aligned}""",
      r"\text{For }I_9=\displaystyle \int_0^{\frac{\pi}{2}} \sin^9 x \, dx\text{ we compute:}",
      r"\textbf{[Compute]}",
      r"""\begin{aligned}
\displaystyle I_9 &= \frac{8 \cdot 6 \cdot 4 \cdot 2}{9 \cdot 7 \cdot 5 \cdot 3 \cdot 1} \\
&= \frac{384}{945} \\
&= \frac{128}{315}
\end{aligned}""",
      r"\textcolor{blue}{[Application\ 1:\ Area\ of\ an\ astroid]}",
      r"",
      r"\text{The astroid }x=\cos^3 t,\ y=\sin^3 t\ (0\le t\le 2\pi)\text{ has four symmetric lobes. The first quadrant corresponds to }0<t<\displaystyle\frac{\pi}{2}\text{.}",
      r"\text{The first-quadrant area is } \displaystyle \int_{x=0}^{1} y\,dx\text{. Using }x=x(t)\text{ changes bounds }t:\frac{\pi}{2}\to 0\text{.}",
      r"""\begin{aligned}
&\ \ \ \ \ \text{Area in the first quadrant}\\
&= \displaystyle \int_{x=0}^{1} Y(x)\,dx \\
&= \displaystyle \int_{t=\frac{\pi}{2}}^{0} y(t)\,x'(t)\,dt \\
&= -\displaystyle \int_{0}^{\frac{\pi}{2}} y(t)\,x'(t)\,dt
\end{aligned}""",
      r"\text{Here }x'(t)=-3\cos^2 t\sin t,\ y(t)=\sin^3 t\text{, so}",
      r"""\begin{aligned}
&\ \ \ \ \ \text{Area in the first quadrant} \\
&= -\displaystyle \int_0^{\frac{\pi}{2}} \sin^3 t \cdot (-3\cos^2 t\sin t)\,dt \\
&= \displaystyle \int_0^{\frac{\pi}{2}} 3\sin^4 t\cos^2 t\,dt \\
&= 3\displaystyle \int_0^{\frac{\pi}{2}}\sin^4 t(1-\sin^2 t)\,dt \\
&= 3\left(I_4 - I_6\right)
\end{aligned}""",
      r"\text{By fourfold symmetry, multiply by }4\text{:}",
      r"""\begin{aligned}
&\ \ \ \ \ \text{Enclosed area} \\
&= 12\left(I_4 - I_6\right) \\
&= 12\left(\frac{3 \cdot 1}{4 \cdot 2} \cdot \frac{\pi}{2} - \frac{5 \cdot 3 \cdot 1}{6 \cdot 4 \cdot 2} \cdot \frac{\pi}{2}\right) \\
&= 12\left(\frac{3\pi}{16}-\frac{5\pi}{32}\right)
= \textcolor{green}{ \frac{3\pi}{8} }
\end{aligned}""",
      r"\textcolor{blue}{[Application\ 2:\ Volume\ of\ revolution\ about\ the\ }x\text{-axis]}",
      r"V_x=\pi\displaystyle \int_{x=-1}^{1}Y(x)^2\,dx\text{. By symmetry,}",
      r"V_x=2\pi\displaystyle \int_0^1 Y(x)^2\,dx\text{.}",
      r"\text{As }x:0\to 1\text{ corresponds to }t:\frac{\pi}{2}\to 0\text{, substitute }x=t\text{ in the parameter integral.}",
      r"y^2=\sin^6 t,\ x'=-3\cos^2 t\sin t\text{, so}",
      r"""\begin{aligned}
V_x&=2\pi\displaystyle \int_0^1 Y(x)^2\,dx\\
&=2\pi\displaystyle \int_{t=\frac{\pi}{2}}^{0} y(t)^2\,x'(t)\,dt\\
&=-6\pi\displaystyle \int_{t=\frac{\pi}{2}}^{0} \sin^7 t\cos^2 t\,dt\\
&=6\pi\displaystyle \int_{t=0}^{\frac{\pi}{2}} \sin^7 t(1-\sin^2 t)\,dt\\
&= 6\pi\bigl(I_7 - I_9\bigr)
= \textcolor{green}{ \frac{32\pi}{105} }
\end{aligned}""",
      r"\textbf{[Supplement: check via Green's theorem]}",
      r"\text{(Supplement) The area can also be computed using Green's theorem }A=\oint x\,dy\text{.}",
    ],
  ),
  "A1B2C3D4-E5F6-7890-ABCD-EF1234567890": ProblemTranslation(
    category: 'Arc Length of Curves',
    level: 'Advanced',
    question: r"""\displaystyle \int_0^1 \sqrt{1 + 4x^2} \, dx""",
    answer:
        r"""\displaystyle\frac{\sqrt{5}}{2} + \displaystyle\frac{1}{4}\log(2+\sqrt{5})""",
    steps: [
      r"\textbf{[Background]}",
      r"\text{This integral appears when computing the arc length of a parabola.}",
      r"",
      r"\text{For the parabola } y = 1 + x^2 \text{, the arc length on }[0,1]\text{ is}",
      r"""\begin{aligned}
L &= \displaystyle \int_0^1 \sqrt{1 + (y')^2} \, dx\\
&= \displaystyle \int_0^1 \sqrt{1 + (2x)^2} \, dx\\
&= \displaystyle \int_0^1 \sqrt{1 + 4x^2} \, dx
\end{aligned}""",
      r"\textbf{[Calculation]}",
      r"\text{We use the hyperbolic functions } \sinh t = \dfrac{e^t - e^{-t}}{2},\ \cosh t = \dfrac{e^t + e^{-t}}{2}\text{.}",
      r"\text{Let } 2x = \sinh t\text{. Then } x=\displaystyle\frac{\sinh t}{2},\ dx=\displaystyle\frac{\cosh t}{2}\,dt\text{. Also }x=0\Rightarrow t=0,\ x=1\Rightarrow t=t_0\text{ where }\sinh t_0=2\text{.}",
      r"\text{Using the identity } \cosh^2 t - \sinh^2 t = 1\text{, we have }\sqrt{1+\sinh^2 t}=\cosh t\text{. Hence}",
      r"""\begin{aligned}
L &= \displaystyle \int_0^{t_0} \sqrt{1 + \sinh^2 t} \cdot \frac{\cosh t}{2} \, dt \\
&= \displaystyle \int_0^{t_0} \cosh t \cdot \frac{\cosh t}{2} \, dt \\
&= \frac{1}{2} \displaystyle \int_0^{t_0} \cosh^2 t \, dt
\end{aligned}""",
      r"\text{Using the double-angle identity } \cosh 2t = 2\cosh^2 t - 1\text{, we get } \cosh^2 t = \frac{1 + \cosh 2t}{2}\text{. So}",
      r"""\begin{aligned}
L &= \frac{1}{2} \displaystyle \int_0^{t_0} \frac{1 + \cosh 2t}{2} \, dt \\
&= \frac{1}{4} \displaystyle \int_0^{t_0} (1 + \cosh 2t) \, dt \\
&= \frac{1}{4} \left[t + \frac{\sinh 2t}{2}\right]_0^{t_0}
\end{aligned}""",
      r"\text{Since }\sinh t_0=2\text{, we have } \cosh t_0 = \sqrt{1+\sinh^2 t_0}=\sqrt{5}\text{.}",
      r"\text{Also by the double-angle formula,}",
      r"\sinh 2t_0 = 2\sinh t_0 \cosh t_0 = 2\cdot 2\cdot \sqrt{5}=4\sqrt{5}\text{.}",
      r"""\begin{aligned}
L &= \frac{1}{4} \left[t_0 + \frac{4\sqrt{5}}{2} - \left(0 + \frac{0}{2}\right)\right] \\
&= \frac{1}{4} \left[t_0 + 2\sqrt{5}\right] \\
&= \frac{\sqrt{5}}{2} + \frac{t_0}{4}
\end{aligned}""",
      r"\text{Now find }t_0\text{: since }\sinh t_0=2\text{, solve } \frac {e^{t_0}-e^{-t_0}}{2}=2\text{.}",
      r"""\begin{aligned}
\frac {e^{t_0}-e^{-t_0}}{2}&=2 \\
e^{t_0}-e^{-t_0}&=4 \\
e^{2t_0}-1&=4e^{t_0} \\
e^{2t_0}-4e^{t_0}-1&=0 \\
e^{t_0}&=2+\sqrt{5} \\
t_0&=\log(2+\sqrt{5})
\end{aligned}""",
      r"\text{Therefore,}",
      r"""\begin{aligned}
L &= \frac{\sqrt{5}}{2} + \frac{1}{4} \log(2+\sqrt{5})
\end{aligned}""",
      r"\textbf{[Supplement: proofs of hyperbolic identities]}",
      r"\text{(1) Proof of } \cosh^2 t - \sinh^2 t = 1\text{:}",
      r"""\begin{aligned}
\cosh^2 t - \sinh^2 t &= \left(\frac{e^t + e^{-t}}{2}\right)^2 - \left(\frac{e^t - e^{-t}}{2}\right)^2 \\
&= \frac{e^{2t} + 2 + e^{-2t}}{4} - \frac{e^{2t} - 2 + e^{-2t}}{4} \\
&= \frac{4}{4} = 1
\end{aligned}""",
      r"\text{(2) Proof of } \cosh 2t = 2\cosh^2 t - 1\text{:}",
      r"""\begin{aligned}
\cosh 2t &= \frac{e^{2t} + e^{-2t}}{2}
= \frac{(e^t)^2 + (e^{-t})^2}{2} \\
&= \frac{(e^t + e^{-t})^2 - 2}{2}
= \frac{(e^t + e^{-t})^2}{2} - 1 \\
&= 2\left(\frac{e^t + e^{-t}}{2}\right)^2 - 1
= 2\cosh^2 t - 1
\end{aligned}""",
      r"\text{(3) Proof of } \sinh 2t = 2\sinh t \cosh t\text{:}",
      r"""\begin{aligned}
\sinh 2t &= \frac{e^{2t} - e^{-2t}}{2}
= \frac{(e^t)^2 - (e^{-t})^2}{2} \\
&= \frac{(e^t - e^{-t})(e^t + e^{-t})}{2} \\
&= 2 \cdot \frac{e^t - e^{-t}}{2} \cdot \frac{e^t + e^{-t}}{2}
= 2\sinh t \cosh t
\end{aligned}""",
    ],
  ),
  // (reserve / commented-out in source)
  "A1F2C8B3-12D4-4A77-9C22-AC19B2C11D90": ProblemTranslation(
    category: 'Area (Green’s Theorem)',
    level: 'Advanced',
    question: r"""\text{For }0\le x\le 2\text{, find:}

\text{(1) } \displaystyle I=\int_0^2 x\sqrt{4-x^2}\,dx

\text{(2) The area }A\text{ of the right loop enclosed by }
x=2\sin\theta,\ y=2\sin 2\theta\ (0\le\theta\le\pi),
\text{ using Green’s theorem.}""",
    answer: r"""\displaystyle I=\frac{8}{3},\quad A=\frac{16}{3}""",
    steps: [
      r"\textbf{[(1) Compute the integral]}",
      r"\text{Use the substitution }u=4-x^2\text{. Then }du=-2x\,dx\text{.}",
      r"\begin{aligned} I=\int_0^2 x\sqrt{4-x^2}\,dx &= \int_{u=4}^{0}\sqrt{u}\left(-\frac{1}{2}\right)\,du \\ &= \frac{1}{2}\int_{0}^{4} u^{1/2}\,du = \frac{1}{2}\cdot\frac{2}{3}u^{3/2}\Big|_{0}^{4} \\ &= \frac{1}{3}\cdot 4^{3/2}=\frac{8}{3}. \end{aligned}",
      r"\textbf{[(2) Area via Green’s theorem]}",
      r"\text{Green’s theorem gives } A=\frac{1}{2}\int (x\,dy-y\,dx)\text{. Parametrize by }\theta\in[0,\pi]\text{:}",
      r"\begin{aligned} x&=2\sin\theta,\quad y=2\sin 2\theta=4\sin\theta\cos\theta,\\ x'&=2\cos\theta,\quad y'=4\cos 2\theta. \end{aligned}",
      r"\begin{aligned} x y' - y x' &= (2\sin\theta)(4\cos2\theta) - (4\sin\theta\cos\theta)(2\cos\theta) \\ &= 8\sin\theta(\cos2\theta-\cos^2\theta) = -8\sin^3\theta. \end{aligned}",
      r"\begin{aligned} A &= \frac{1}{2}\int_{0}^{\pi}(-8\sin^3\theta)\,d\theta = -4\int_{0}^{\pi}\sin^3\theta\,d\theta. \end{aligned}",
      r"\text{The sign is negative due to orientation, so take the absolute value. Also } \int_0^\pi \sin^3\theta\,d\theta = 2\int_0^{\pi/2}\sin^3\theta\,d\theta=2\cdot\frac{2}{3}=\frac{4}{3}\text{.}",
      r"\begin{aligned} |A| = 4\cdot\frac{4}{3}=\frac{16}{3}. \end{aligned}",
    ],
  ),

  // problems_curves_reserve.dart (reserve / commented-out in source)
  "5A1DA9C1-D8A7-489A-8AE1-DE6642D44272": ProblemTranslation(
    category: 'Area of Curves',
    level: 'Easy',
    question: r"""\displaystyle \int_0^{2\pi} (1-\cos x)^2 \, dx""",
    answer: r"""3\pi""",
    steps: [
      r"\textbf{[Expand]}",
      r"\begin{aligned} \int_0^{2\pi}(1-\cos x)^2\,dx &= \int_0^{2\pi}\left(1-2\cos x+\cos^2 x\right)\,dx. \end{aligned}",
      r"\textbf{[Use } \cos^2 x=\displaystyle\frac{1+\cos 2x}{2}\textbf{]}",
      r"\begin{aligned} \int_0^{2\pi}\left(1-2\cos x+\cos^2 x\right)\,dx &= \int_0^{2\pi}\left(1-2\cos x+\frac{1+\cos 2x}{2}\right)\,dx \\ &= \int_0^{2\pi}\left(\frac{3}{2}-2\cos x+\frac{\cos 2x}{2}\right)\,dx \\ &= \left[\frac{3x}{2}-2\sin x+\frac{\sin 2x}{4}\right]_0^{2\pi} = 3\pi. \end{aligned}",
    ],
  ),
  "36867962-7B2A-4DF5-B176-CE3E388C0F4D": ProblemTranslation(
    category: 'Solids of Revolution',
    level: 'Mid',
    question: r"""\displaystyle \int_0^{2\pi} (1-\cos x)^3 \, dx""",
    answer: r"""5\pi""",
    steps: [
      r"\textbf{[Expand]}",
      r"\begin{aligned} (1-\cos x)^3 &= 1-3\cos x+3\cos^2 x-\cos^3 x. \end{aligned}",
      r"\textbf{[Integrate termwise]}",
      r"\begin{aligned} \int_0^{2\pi}(1-\cos x)^3\,dx &= \int_0^{2\pi}1\,dx -3\int_0^{2\pi}\cos x\,dx +3\int_0^{2\pi}\cos^2 x\,dx -\int_0^{2\pi}\cos^3 x\,dx. \end{aligned}",
      r"\text{We have } \int_0^{2\pi}1\,dx=2\pi,\ \int_0^{2\pi}\cos x\,dx=0\text{.}",
      r"\text{Also } \cos^2 x=\displaystyle\frac{1+\cos 2x}{2}\text{, so } \int_0^{2\pi}\cos^2 x\,dx=\pi\text{.}",
      r"\text{And } \cos^3 x=\displaystyle\frac{3\cos x+\cos 3x}{4}\text{, so } \int_0^{2\pi}\cos^3 x\,dx=0\text{.}",
      r"\begin{aligned} \therefore\ \int_0^{2\pi}(1-\cos x)^3\,dx &= 2\pi + 3\pi = 5\pi. \end{aligned}",
    ],
  ),
  "8D9E0F3B-4C5D-5E6F-7A8B-9C0D1E2F3B4C": ProblemTranslation(
    category: 'Arc Length of Curves',
    level: 'Mid',
    question: r"""\displaystyle \int_0^{2\pi} |\sin x \cos x| \, dx""",
    answer: r"""2""",
    steps: [
      r"\textbf{[Symmetry]}",
      r"\text{By symmetry, }|\sin x\cos x|\text{ repeats in each quadrant and is nonnegative.}",
      r"\begin{aligned} \int_0^{2\pi}|\sin x\cos x|\,dx &= 4\int_0^{\pi/2}\sin x\cos x\,dx. \end{aligned}",
      r"\textbf{[Compute]}",
      r"\begin{aligned} 4\int_0^{\pi/2}\sin x\cos x\,dx &= 4\left[\frac{\sin^2 x}{2}\right]_0^{\pi/2} = 4\cdot\frac{1}{2}=2. \end{aligned}",
    ],
  ),

  // problems_others.dart
  "AC0C8F06-65FE-4FDD-8DB8-04252764D3CB": ProblemTranslation(
    category: 'Odd Function',
    level: 'Mid',
    question: r"""\displaystyle \int_{-2}^{2} x^4 \sin^5 x \, dx""",
    answer: r"""0""",
    steps: [
      r"\textbf{[Explanation]}",
      r"x^4 \text{ is even and } \sin^5 x \text{ is odd. Since even}\times\text{odd}=\text{odd},\ x^4\sin^5 x \text{ is an odd function.}",
      r"\text{Therefore, over the symmetric interval }[-2,2]\text{:}",
      r"""\begin{aligned}
\displaystyle \int_{-2}^{2} x^4 \sin^5 x \, dx = 0
\end{aligned}""",
      r"\textbf{[Remark]}",
      r"\text{Standard formulas for even/odd functions:}",
      r"""\begin{aligned}
&\text{(1) Even: } f(-x)=f(x)\ \Rightarrow\ \displaystyle \int_{-a}^{a} f(x)\,dx = 2\displaystyle \int_{0}^{a} f(x)\,dx\\[6pt]
&\text{(2) Odd: } f(-x)=-f(x)\ \Rightarrow\ \displaystyle \int_{-a}^{a} f(x)\,dx = 0
\end{aligned}""",
      r"\text{[Proof] (1) Even function case:}",
      r"""\begin{aligned}
\displaystyle \int_{-a}^{a} f(x)\,dx
&=\textcolor{red}{\displaystyle \int_{-a}^{0} f(x)\,dx} + \displaystyle \int_{0}^{a} f(x)\,dx
\end{aligned}""",
      r"\text{In the first term, substitute } t=-x\text{. Then }x=-t,\ dx=-dt,\ x:-a\to 0 \Rightarrow t:a\to 0\text{, so}",
      r"""\begin{aligned}
\textcolor{red}{\displaystyle \int_{-a}^{0} f(x)\,dx}
&=\displaystyle \int_{a}^{0} f(-t)(-dt)\\
&=\displaystyle \int_{0}^{a} f(-t)\,dt
\end{aligned}""",
      r"\text{Since }f\text{ is even, } f(-t)=f(t)\text{, hence}",
      r"""\begin{aligned}
&=\displaystyle \int_{0}^{a} f(t)\,dt
=\textcolor{red}{\displaystyle \int_{0}^{a} f(x)\,dx}
\end{aligned}""",
      r"\text{Therefore,}",
      r"""\begin{aligned}
\displaystyle \int_{-a}^{a} f(x)\,dx
&=\textcolor{red}{\displaystyle \int_{0}^{a} f(x)\,dx} + \displaystyle \int_{0}^{a} f(x)\,dx\\
&=2\displaystyle \int_{0}^{a} f(x)\,dx
\end{aligned}""",
      r"\text{[Proof] (2) Odd function case:}",
      r"""\begin{aligned}
\displaystyle \int_{-a}^{a} f(x)\,dx
&=\textcolor{red}{\displaystyle \int_{-a}^{0} f(x)\,dx} + \displaystyle \int_{0}^{a} f(x)\,dx
\end{aligned}""",
      r"\text{In the first term, substitute } t=-x\text{. Then }x=-t,\ dx=-dt,\ x:-a\to 0 \Rightarrow t:a\to 0\text{, so}",
      r"""\begin{aligned}
\textcolor{red}{\displaystyle \int_{-a}^{0} f(x)\,dx}
&=\displaystyle \int_{a}^{0} f(-t)(-dt)\\
&=\displaystyle \int_{0}^{a} f(-t)\,dt
\end{aligned}""",
      r"\text{Since }f\text{ is odd, } f(-t)=-f(t)\text{, hence}",
      r"""\begin{aligned}
&=\displaystyle \int_{0}^{a} (-f(t))\,dt\\
&=-\displaystyle \int_{0}^{a} f(t)\,dt\\
&=\textcolor{red}{- \displaystyle \int_{0}^{a} f(x)\,dx}
\end{aligned}""",
      r"\text{Therefore,}",
      r"""\begin{aligned}
\displaystyle \int_{-a}^{a} f(x)\,dx
&=\textcolor{red}{- \displaystyle \int_{0}^{a} f(x)\,dx} + \displaystyle \int_{0}^{a} f(x)\,dx\\
&=0
\end{aligned}""",
    ],
  ),
  "9BC1C756-BFC5-41C7-8751-D78DF6430084": ProblemTranslation(
    category: 'Other (Square Root / Sign Handling)',
    level: 'Advanced',
    question:
        r"""\displaystyle \int_{ \frac{\pi}{2}}^{ \frac{5\pi}{2}}\sqrt{1+\sin x}\,dx""",
    answer: r"""\displaystyle 4\sqrt{2}""",
    hint:
        r"\text{Use a half-angle identity to rewrite }\sqrt{1+\sin x}\text{ as }\sqrt{2}\,|\cos(\cdots)|\text{, then split the interval at the sign change.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use a half-angle identity to rewrite } \sqrt{1+\sin x}\text{ in terms of }|\cos|\text{, then split the interval by the sign.}",
      r"""\begin{aligned}
1+\sin x &= 1 + \cos\left(\displaystyle\frac{\pi}{2} - x\right)\\[5pt]
&= 2\cos^2\displaystyle\frac{\frac{\pi}{2} - x}{2}\\[5pt]
&= 2\cos^2\left(\displaystyle\frac{\pi}{4} - \displaystyle\frac{x}{2}\right)\\[5pt]
&= 2\cos^2\left(\displaystyle\frac{x}{2} - \displaystyle\frac{\pi}{4}\right)
\end{aligned}""",
      r"\text{Therefore,}",
      r"""\begin{aligned}
\sqrt{1+\sin x} &= \sqrt{2\cos^2\left(\displaystyle\frac{x}{2}-\displaystyle\frac{\pi}{4}\right)}\\[5pt]
&= \sqrt{2}\left|\cos\left(\displaystyle\frac{x}{2}-\displaystyle\frac{\pi}{4}\right)\right|
\end{aligned}""",
      r"\text{Next, find where the absolute value changes sign.}",
      r"""\begin{aligned}
&\cos\!\left(\displaystyle \frac{x}{2}-\displaystyle \frac{\pi}{4}\right)=0
\iff x=\displaystyle \frac{3\pi}{2}+2k\pi
\end{aligned}""",
      r"\text{In the interval } \left[\displaystyle \frac{\pi}{2},\displaystyle \frac{5}{2}\pi\right]\text{ there is one zero at } x=\displaystyle \frac{3\pi}{2}\text{. Checking the sign gives:}",
      r"""\begin{aligned}
\begin{cases}
\left[\displaystyle \frac{\pi}{2},\displaystyle \frac{3\pi}{2}\right]\text{ : } \cos\!\left(\displaystyle \frac{x}{2}-\displaystyle \frac{\pi}{4}\right) > 0\\
\left[\displaystyle \frac{3\pi}{2},\displaystyle \frac{5}{2}\pi\right]\text{ : } \cos\!\left(\displaystyle \frac{x}{2}-\displaystyle \frac{\pi}{4}\right) < 0
\end{cases}
\end{aligned}""",
      r"\text{Therefore,}",
      r"""\begin{aligned}
&\ \ \ \int_{ \frac{\pi}{2}}^{ \frac{5}{2}\pi}\sqrt{1+\sin x}\,dx\\[5pt]
&= \sqrt2\displaystyle \int_{ \frac{\pi}{2}}^{ \frac{3\pi}{2}}\cos\!\left(\displaystyle \frac{x}{2}-\displaystyle \frac{\pi}{4}\right)\,dx 
-\sqrt2\displaystyle \int_{ \frac{3\pi}{2}}^{ \frac{5}{2}\pi}\cos\!\left(\displaystyle \frac{x}{2}-\displaystyle \frac{\pi}{4}\right)\,dx\\[5pt]
&= \sqrt2 \cdot 2\left[\sin\!\left(\displaystyle \frac{x}{2}-\displaystyle \frac{\pi}{4}\right)\right]_{ \frac{\pi}{2}}^{ \frac{3\pi}{2}} 
-\sqrt2 \cdot 2\left[\sin\!\left(\displaystyle \frac{x}{2}-\displaystyle \frac{\pi}{4}\right)\right]_{ \frac{3\pi}{2}}^{ \frac{5}{2}\pi}\\[5pt]
&=2\sqrt2\left(\textcolor{red}{\sin\!\left(\displaystyle \frac{3\pi}{2}\cdot\displaystyle \frac{1}{2}-\displaystyle \frac{\pi}{4}\right)} - \textcolor{green}{\sin\!\left(\displaystyle \frac{\pi}{2}\cdot\displaystyle \frac{1}{2}-\displaystyle \frac{\pi}{4}\right)}\right.\\[5pt]
&\quad \left.-\textcolor{blue}{\sin\!\left(\displaystyle \frac{5}{2}\pi\cdot\displaystyle \frac{1}{2}-\displaystyle \frac{\pi}{4}\right)} + \textcolor{orange}{\sin\!\left(\displaystyle \frac{3\pi}{2}\cdot\displaystyle \frac{1}{2}-\displaystyle \frac{\pi}{4}\right)}\right)
\end{aligned}""",
      r"\text{Compute each term:}",
      r"""\begin{aligned}
\textcolor{red}{\sin\!\left(\displaystyle \frac{3\pi}{2}\cdot\displaystyle \frac{1}{2}-\displaystyle \frac{\pi}{4}\right)} &= \sin\!\left(\displaystyle \frac{3\pi}{4}-\displaystyle \frac{\pi}{4}\right) = \sin\displaystyle \frac{\pi}{2} = \textcolor{red}{1}\\[4pt]
\textcolor{green}{\sin\!\left(\displaystyle \frac{\pi}{2}\cdot\displaystyle \frac{1}{2}-\displaystyle \frac{\pi}{4}\right)} &= \sin\!\left(\displaystyle \frac{\pi}{4}-\displaystyle \frac{\pi}{4}\right) = \sin 0 = \textcolor{green}{0}\\[4pt]
\textcolor{blue}{\sin\!\left(\displaystyle \frac{5}{2}\pi\cdot\displaystyle \frac{1}{2}-\displaystyle \frac{\pi}{4}\right)} &= \sin\!\left(\displaystyle \frac{5\pi}{4}-\displaystyle \frac{\pi}{4}\right) = \sin\pi = \textcolor{blue}{0}\\[4pt]
\textcolor{orange}{\sin\!\left(\displaystyle \frac{3\pi}{2}\cdot\displaystyle \frac{1}{2}-\displaystyle \frac{\pi}{4}\right)} &= \sin\!\left(\displaystyle \frac{3\pi}{4}-\displaystyle \frac{\pi}{4}\right) = \sin\displaystyle \frac{\pi}{2} = \textcolor{orange}{1}
\end{aligned}""",
      r"\text{Substituting these values gives:}",
      r"""\begin{aligned}
&=2\sqrt2\left(\textcolor{red}{1} - \textcolor{green}{0} - \textcolor{blue}{0} + \textcolor{orange}{1}\right)\\
&=4\sqrt2
\end{aligned}""",
      r"\textbf{[Supplement]}",
      r"\text{A technical but valid alternative is to rewrite:}",
      r"""\begin{aligned}
1+\sin x
=&\sin^2\displaystyle \frac{x}{2}+\cos^2\displaystyle \frac{x}{2}+2\sin\displaystyle \frac{x}{2}\cos\displaystyle \frac{x}{2}\\
=&\left(\sin\displaystyle \frac{x}{2}+\cos\displaystyle \frac{x}{2}\right)^2
\end{aligned}""",
      r"\text{So we can also take the square root as an absolute value:}",
      r"""\begin{aligned}
\sqrt{1+\sin x}=&\left|\sin\displaystyle \frac{x}{2}+\cos\displaystyle \frac{x}{2}\right|
=\sqrt2\left|\sin\!\left(\displaystyle \frac{x}{2}+\displaystyle \frac{\pi}{4}\right)\right|
\end{aligned}""",
    ],
  ),
  // (reserve / commented-out in source)
  "3E2C0C8F-7AEC-4667-8AAE-665B8D47CD40": ProblemTranslation(
    category: 'Other (Composite Function / Symmetry)',
    level: 'Advanced',
    question:
        r"""\displaystyle \int_{0}^{\pi}\displaystyle \frac{x\sin x}{3+\sin x}\,dx""",
    answer:
        r"""\displaystyle \frac{\pi^2}{2}-\displaystyle \frac{3\sqrt{2}\,\pi}{4}\left(\displaystyle \frac{\pi}{2}-\arctan\displaystyle \frac{1}{2\sqrt{2}}\right)""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the symmetry }x\mapsto \pi-x\text{ to eliminate }x\text{, then evaluate the remaining integral via the half-angle substitution }t=\tan\left(\displaystyle\frac{x}{2}\right)\text{.}",
      r"\textbf{[Symmetry]}",
      r"\begin{aligned} I&=\int_0^\pi \frac{x\sin x}{3+\sin x}\,dx. \end{aligned}",
      r"\text{Let }u=\pi-x\text{. Then } \sin(\pi-u)=\sin u \text{ and}",
      r"\begin{aligned} I&=\int_0^\pi \frac{(\pi-u)\sin u}{3+\sin u}\,du. \end{aligned}",
      r"\text{Adding the two expressions gives}",
      r"\begin{aligned} 2I=\pi\int_0^\pi \frac{\sin x}{3+\sin x}\,dx. \end{aligned}",
      r"\text{Let }J=\int_0^\pi \frac{\sin x}{3+\sin x}\,dx\text{. Since } \frac{\sin x}{3+\sin x}=1-\frac{3}{3+\sin x}\text{,}",
      r"\begin{aligned} J=\pi-3K,\quad K=\int_0^\pi \frac{dx}{3+\sin x}. \end{aligned}",
      r"\begin{aligned} \therefore\ I=\frac{\pi}{2}J=\frac{\pi}{2}\left(\pi-3K\right). \end{aligned}",
      r"\textbf{[Evaluate }K\textbf{]}",
      r"\text{Use }t=\tan\left(\frac{x}{2}\right)\ (x\in[0,\pi])\text{: } \sin x=\displaystyle\frac{2t}{1+t^2},\ dx=\displaystyle\frac{2\,dt}{1+t^2},\ x:0\to\pi \Rightarrow t:0\to\infty\text{.}",
      r"\begin{aligned} K&=\int_0^\infty \frac{1}{3+\frac{2t}{1+t^2}}\cdot\frac{2\,dt}{1+t^2} = \int_0^\infty \frac{2\,dt}{3(1+t^2)+2t} = \int_0^\infty \frac{2\,dt}{3t^2+2t+3}. \end{aligned}",
      r"\text{Complete the square: }3t^2+2t+3=3\left[\left(t+\frac{1}{3}\right)^2+\left(\frac{2\sqrt{2}}{3}\right)^2\right]\text{.}",
      r"\begin{aligned} K&=\frac{2}{3}\int_0^\infty \frac{dt}{\left(t+\frac{1}{3}\right)^2+\left(\frac{2\sqrt{2}}{3}\right)^2}. \end{aligned}",
      r"\text{This gives (via }\arctan\text{ evaluation)}",
      r"\begin{aligned} K=\frac{\sqrt{2}}{2}\left(\frac{\pi}{2}-\arctan\frac{1}{2\sqrt{2}}\right). \end{aligned}",
      r"\textbf{[Final]}",
      r"\begin{aligned} I&=\frac{\pi}{2}\left(\pi-3K\right)=\frac{\pi^2}{2}-\frac{3\sqrt{2}\,\pi}{4}\left(\frac{\pi}{2}-\arctan\frac{1}{2\sqrt{2}}\right). \end{aligned}",
    ],
  ),

  // problems_trig_fraction.dart
  // (reserve / commented-out in source)
  "A80163F0-5A93-4748-9E8B-A9FBF63483A8": ProblemTranslation(
    category: 'Trigonometric Fraction',
    level: 'Advanced',
    question: r"""\displaystyle \int \displaystyle \frac{dx}{1+\sin x}""",
    answer: r"""\tan x - \displaystyle \frac{1}{\cos x} + C""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Rationalize the denominator (avoid using }\sec,\csc,\cot\text{).}",
      r"\textbf{[Rationalization]}",
      r"\begin{aligned} \frac{1}{1+\sin x} &= \frac{1-\sin x}{(1+\sin x)(1-\sin x)} \\ &= \frac{1-\sin x}{1-\sin^2 x} \\ &= \frac{1-\sin x}{\cos^2 x} \\ &= \frac{1}{\cos^2 x} - \frac{\sin x}{\cos^2 x}. \end{aligned}",
      r"\textbf{[Integration]}",
      r"\begin{aligned} \int \frac{dx}{1+\sin x} &= \int \frac{1}{\cos^2 x}\,dx - \int \frac{\sin x}{\cos^2 x}\,dx \\ &= \tan x - \frac{1}{\cos x} + C. \end{aligned}",
    ],
  ),
  // (reserve / commented-out in source)
  "704B2074-890B-48AA-94A7-B218C49F9F90": ProblemTranslation(
    category: 'Trigonometric Fraction',
    level: 'Easy',
    question:
        r"""\displaystyle \int \displaystyle \frac{\sin x}{\cos^3 x}\,dx""",
    answer: r"""\displaystyle \frac{1}{2\cos^2 x} + C""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Substitute }u=\cos x\text{.}",
      r"\textbf{[Solution]}",
      r"\text{Let }u=\cos x\text{, then }du=-\sin x\,dx\text{.}",
      r"\begin{aligned} \int \frac{\sin x}{\cos^3 x}\,dx &= \int \sin x\cdot(\cos x)^{-3}\,dx \\ &= -\int u^{-3}\,du \\ &= \frac{1}{2}u^{-2}+C \\ &= \frac{1}{2\cos^2 x}+C. \end{aligned}",
    ],
  ),
  // (reserve / commented-out in source)
  "D3A7479B-AAC4-447E-8B59-E468854817B6": ProblemTranslation(
    category: 'Trigonometric Fraction',
    level: 'Easy',
    question:
        r"""\displaystyle \int \displaystyle \frac{\cos x}{1+\sin^2 x}\,dx""",
    answer:
        r"""\displaystyle \frac{1}{2\mathrm{i}}\log\!\left(\displaystyle \frac{1+\mathrm{i}\,\sin x}{1-\mathrm{i}\,\sin x}\right)+C""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Substitute }u=\sin x\text{ so the integral becomes } \int \displaystyle\frac{du}{1+u^2}\text{. Express it using a (complex) logarithm.}",
      r"\textbf{[Solution]}",
      r"\text{Let }u=\sin x\text{, then }du=\cos x\,dx\text{.}",
      r"\begin{aligned} \int \frac{\cos x}{1+\sin^2 x}\,dx &= \int \frac{du}{1+u^2} \\ &= \frac{1}{2\mathrm{i}}\log\!\left(\frac{1+\mathrm{i}u}{1-\mathrm{i}u}\right)+C \\ &= \frac{1}{2\mathrm{i}}\log\!\left(\frac{1+\mathrm{i}\sin x}{1-\mathrm{i}\sin x}\right)+C. \end{aligned}",
      r"\textbf{[Note]}",
      r"\text{As a real function, this is } \arctan(\sin x)+C\text{.}",
    ],
  ),
  // (reserve / commented-out in source)
  "8CD196F8-A54F-4A9A-93E7-8897C01ED59C": ProblemTranslation(
    category: 'Trigonometric Fraction',
    level: 'Advanced',
    question:
        r"""\displaystyle \int_{0}^{ \frac{\pi}{2}} \displaystyle \frac{dx}{1+\tan x}""",
    answer: r"""\displaystyle \frac{\pi}{4}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the substitution }x\mapsto \displaystyle\frac{\pi}{2}-x\text{ and add the two expressions.}",
      r"\textbf{[Solution]}",
      r"\text{Let }I=\displaystyle \int_{0}^{\pi/2}\frac{dx}{1+\tan x}\text{.}",
      r"\text{With }x\mapsto \displaystyle\frac{\pi}{2}-x\text{, we have } \tan\!\left(\displaystyle\frac{\pi}{2}-x\right)=\displaystyle\frac{1}{\tan x}\text{, hence}",
      r"\begin{aligned} I &= \int_0^{\pi/2}\frac{dx}{1+\tan\!\left(\frac{\pi}{2}-x\right)} = \int_0^{\pi/2}\frac{\tan x}{1+\tan x}\,dx. \end{aligned}",
      r"\text{Add the two expressions for }I\text{:}",
      r"\begin{aligned} 2I &= \int_0^{\pi/2}\left(\frac{1}{1+\tan x}+\frac{\tan x}{1+\tan x}\right)dx = \int_0^{\pi/2} 1\,dx = \frac{\pi}{2}. \end{aligned}",
      r"\begin{aligned} \therefore\ I=\frac{\pi}{4}. \end{aligned}",
    ],
  ),
  // (reserve / commented-out in source)
  "B840CE86-BC98-491C-9C1D-4AE2B5872CD3": ProblemTranslation(
    category: 'Trigonometric Fraction',
    level: 'Mid',
    question:
        r"""\displaystyle \int \displaystyle \frac{dx}{\sin x + \cos x}""",
    answer:
        r"""\displaystyle \frac{1}{\sqrt{2}}\,\log\!\left|\tan\!\left(\displaystyle \frac{x}{2}+\displaystyle \frac{\pi}{8}\right)\right| + C""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use a phase shift: }\sin x+\cos x=\sqrt{2}\sin\!\left(x+\displaystyle\frac{\pi}{4}\right)\text{.}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \int \frac{dx}{\sin x+\cos x} &= \int \frac{dx}{\sqrt{2}\sin\left(x+\frac{\pi}{4}\right)} \\ &= \frac{1}{\sqrt{2}}\int \frac{du}{\sin u}\quad\left(u=x+\frac{\pi}{4}\right). \end{aligned}",
      r"\text{Using } \int \displaystyle\frac{du}{\sin u} = \log\left|\tan\left(\displaystyle\frac{u}{2}\right)\right|+C\text{, we get}",
      r"\begin{aligned} \int \frac{dx}{\sin x+\cos x} &= \frac{1}{\sqrt{2}}\,\log\left|\tan\left(\frac{u}{2}\right)\right|+C \\ &= \frac{1}{\sqrt{2}}\,\log\left|\tan\left(\frac{x}{2}+\frac{\pi}{8}\right)\right|+C. \end{aligned}",
    ],
  ),
  // (reserve / commented-out in source)
  "D5531EC7-67F5-4A26-8EAC-8A686F066365": ProblemTranslation(
    category: 'Trigonometric (Weierstrass Substitution)',
    level: 'Advanced',
    question:
        r"""\displaystyle \int_{ \frac{\pi}{12}}^{ \frac{\pi}{6}}\displaystyle \frac{dx}{5\sin x+3}""",
    answer: r"""\displaystyle \frac{1}{4}\log \!\left|
\displaystyle \frac{\displaystyle \frac{\,2-\sqrt{3}+\displaystyle \frac{1}{3}\,}{\,2-\sqrt{3}+3\,}}
{\displaystyle \frac{\,\displaystyle \frac{4-\sqrt{6}-\sqrt{2}}{\sqrt{6}-\sqrt{2}}+\displaystyle \frac{1}{3}\,}{\,\displaystyle \frac{4-\sqrt{6}-\sqrt{2}}{\sqrt{6}-\sqrt{2}}+3\,}}
\right|""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the half-angle substitution }t=\tan\left(\displaystyle\frac{x}{2}\right)\text{ to convert to a rational integral.}",
      r"\textbf{[Key Formulas]}",
      r"\begin{aligned} \sin x &= \frac{2t}{1+t^2},\\ dx &= \frac{2\,dt}{1+t^2}. \end{aligned}",
      r"\textbf{[Convert the Integral]}",
      r"\begin{aligned} \int \frac{dx}{5\sin x+3} &= \int \frac{\frac{2\,dt}{1+t^2}}{5\cdot\frac{2t}{1+t^2}+3} = \int \frac{2\,dt}{3t^2+10t+3}. \end{aligned}",
      r"\text{Factor }3t^2+10t+3=3\left(t+\displaystyle\frac{1}{3}\right)(t+3)\text{, then}",
      r"\begin{aligned} \int \frac{2\,dt}{3t^2+10t+3} &= \frac{1}{4}\int\left(\frac{1}{t+\frac{1}{3}}-\frac{1}{t+3}\right)dt \\ &= \frac{1}{4}\log\left|\frac{t+\frac{1}{3}}{t+3}\right|+C. \end{aligned}",
      r"\textbf{[Bounds]}",
      r"\begin{aligned} x=\frac{\pi}{6} &\Rightarrow t=\tan\left(\frac{\pi}{12}\right)=2-\sqrt{3},\\ x=\frac{\pi}{12} &\Rightarrow t=\tan\left(\frac{\pi}{24}\right)=\frac{4-\sqrt{6}-\sqrt{2}}{\sqrt{6}-\sqrt{2}}. \end{aligned}",
      r"\textbf{[Evaluation]}",
      r"\text{Substitute these bounds into } \displaystyle\frac{1}{4}\log\left|\frac{t+\frac{1}{3}}{t+3}\right|\text{ to obtain the stated value.}",
    ],
  ),
  // (reserve / commented-out in source)
  "994945E2-9216-4776-A0C1-8B83F5F86B6C": ProblemTranslation(
    category: 'Trigonometric (Substitution)',
    level: 'Advanced',
    question:
        r"""\displaystyle \int_{ \frac{\pi}{6}}^{ \frac{\pi}{2}}\displaystyle \frac{dx}{\sin^{4}x}""",
    answer: r"""2\sqrt{3}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let }u=\displaystyle\frac{\cos x}{\sin x}\text{. (Do not use }\cot\text{ notation.)}",
      r"\textbf{[Key Relations]}",
      r"\begin{aligned} u &= \frac{\cos x}{\sin x},\\ du &= \frac{-\sin^2 x-\cos^2 x}{\sin^2 x}\,dx = -\frac{dx}{\sin^2 x}. \end{aligned}",
      r"\text{Also, } \displaystyle\frac{1}{\sin^4 x}\,dx=\frac{1}{\sin^2 x}\cdot\frac{dx}{\sin^2 x}=(1+u^2)(-du)\text{.}",
      r"\textbf{[Bounds]}",
      r"\begin{aligned} x=\frac{\pi}{6} &\Rightarrow u=\frac{\cos(\pi/6)}{\sin(\pi/6)}=\sqrt{3},\\ x=\frac{\pi}{2} &\Rightarrow u=\frac{0}{1}=0. \end{aligned}",
      r"\textbf{[Integration]}",
      r"\begin{aligned} \int_{\pi/6}^{\pi/2}\frac{dx}{\sin^4 x} &= \int_{\sqrt{3}}^{0}-(1+u^2)\,du = \int_{0}^{\sqrt{3}}(1+u^2)\,du \\ &= \left[u+\frac{u^3}{3}\right]_{0}^{\sqrt{3}} = \sqrt{3}+\frac{3\sqrt{3}}{3}=2\sqrt{3}. \end{aligned}",
    ],
  ),
  "B9B22B73-65CB-4AE7-A6BF-79E52EEDA3BC": ProblemTranslation(
    category: 'Trigonometric Fraction',
    level: 'Advanced',
    question:
        r"""\displaystyle \int_{-\frac{\pi}{6}}^{\frac{\pi}{6}} \displaystyle \frac{dx}{\cos^3 x}""",
    answer: r"""\displaystyle \frac{1}{2}\log 3 + \frac{2}{3}""",
    hint:
        r"\text{The integrand is even, so compute }2\int_{0}^{\pi/6}\sec^3 x\,dx\text{.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{The integrand is even, so } \int_{-\pi/6}^{\pi/6}\frac{dx}{\cos^3 x}=2\int_{0}^{\pi/6}\frac{dx}{\cos^3 x}\text{.}",
      r"\textbf{[Explanation]}",
      r"""\begin{aligned}
&\ \ \ \ \ \int_{-\frac{\pi}{6}}^{\frac{\pi}{6}} \frac{dx}{\cos^3 x}\\[5pt]
&= 2\int_{0}^{\frac{\pi}{6}} \frac{dx}{\cos^3 x}\\[5pt]
&= 2\int_{0}^{\frac{\pi}{6}} \frac{\cos x}{\cos^4 x}dx\\[5pt]
&= 2\int_{0}^{\frac{\pi}{6}} \frac{\cos x}{(1-\sin^2 x)^2} \, dx
\end{aligned}""",
      r"\text{Let }u=\sin x\text{.}",
      r"""\begin{aligned}
&= 2\int_{u=0}^{u=\sin\frac{\pi}{6}} \frac{du}{(1-u^2)^2}\\[5pt]
&= \textcolor{blue}{2\int_{0}^{\frac{1}{2}} \frac{du}{(1-u^2)^2}}\cdots (\star)
\end{aligned}""",
      r"\text{Perform partial fraction decomposition. Since } \displaystyle \frac{1}{(1-u^2)^2} = \frac{1}{(1-u)^2(1+u)^2}\text{:}",
      r"""\begin{aligned}
& \ \ \ \ \ \frac{1}{(1-u^2)^2} \\[5pt]
&= \frac{A}{1-u} + \frac{B}{(1-u)^2} + \frac{C}{1+u} + \frac{D}{(1+u)^2}\\[5pt]
&= \frac{A(1-u)(1+u)^2 + B(1+u)^2 + C(1+u)(1-u)^2 + D(1-u)^2}{(1-u^2)^2}
\end{aligned}""",
      r"\text{Expanding the numerator gives:}",
      r"""\begin{aligned}
&\ \ \ \ \ A(1-u)(1+u)^2 + B(1+u)^2\\[5pt]
&\ \ \ \ \ \ \ \ \ \ + C(1+u)(1-u)^2 + D(1-u)^2\\[5pt]
&= (A+B+C+D) + (A+2B-C-2D)u \\[5pt]
&\ \ \ \ \ \ \ \ \ \ + (-A+B-C+D)u^2 + (-A+C)u^3
\end{aligned}""",
      r"\text{Comparing coefficients yields:}",
      r"""\begin{aligned}&\ \ \ \ \ \begin{cases}
-A + C = 0\\
-A + B - C + D = 0\\
A + 2B - C - 2D = 0\\
A + B + C + D = 1
\end{cases} \\
&\Leftrightarrow 
\begin{cases}
A = \frac{1}{4}\\[6pt]
B = \frac{1}{4}\\[6pt]
C = \frac{1}{4}\\[6pt]
D = \frac{1}{4}
\end{cases} 
\end{aligned}""",
      r"\text{Therefore, from }(\star)\text{:}",
      r"""\begin{aligned}
&\ \ \ \ \ \textcolor{blue}{2\int_{0}^{\frac{1}{2}} \frac{du}{(1-u^2)^2}}\\[5pt]
&= 2\int_{0}^{\frac{1}{2}} \left[\frac{1}{4(1-u)} + \frac{1}{4(1-u)^2} + \frac{1}{4(1+u)} + \frac{1}{4(1+u)^2}\right] du\\[5pt]
&= \frac{1}{2}\left[-\log|1-u| + \frac{1}{1-u} + \log|1+u| - \frac{1}{1+u}\right]_{0}^{\frac{1}{2}}\\[5pt]
&= \frac{1}{2}\left[\log\left|\frac{1+u}{1-u}\right| + \frac{2u}{1-u^2}\right]_{0}^{\frac{1}{2}}\\[5pt]
&= \frac{1}{2}\left[\log\left(\frac{1+\frac{1}{2}}{1-\frac{1}{2}}\right) + \frac{2 \cdot \frac{1}{2}}{1-\frac{1}{4}}\right]\\[5pt]
&= \frac{1}{2}\left[\log 3 + \frac{4}{3}\right]\\[5pt]
&= \frac{1}{2}\log 3 + \frac{2}{3}
\end{aligned}""",
    ],
  ),

  // problems_substitution_reserve.dart (reserve / commented-out in source)
  "FB4AEC30-C024-417C-BEA7-96DB6B5BEE43": ProblemTranslation(
    category: 'Substitution',
    level: 'Easy',
    question:
        r"""\displaystyle \int_{0}^{\frac{3}{2}} \displaystyle \frac{dx}{\sqrt{9 - x^{2}}}""",
    answer: r"""\displaystyle \frac{\pi}{6}""",
    hint: r"\text{Use the substitution }x=3\sin\theta\text{.}",
    steps: [
      r"\textbf{[Plan]}",
      r"\text{Let }x=3\sin\theta\text{.}",
      r"\textbf{[Bounds]}",
      r"\text{When }x=0\text{, }\sin\theta=0\Rightarrow \theta=0\text{. When }x=\displaystyle\frac{3}{2}\text{, }\sin\theta=\displaystyle\frac{1}{2}\Rightarrow \theta=\displaystyle\frac{\pi}{6}\text{.}",
      r"\textbf{[Computation]}",
      r"\text{We have }9-x^2=9-9\sin^2\theta=9\cos^2\theta\text{ and }dx=3\cos\theta\,d\theta\text{.}",
      r"\begin{aligned} \int_{0}^{3/2}\frac{dx}{\sqrt{9-x^2}} &= \int_{0}^{\pi/6}\frac{3\cos\theta\,d\theta}{\sqrt{9\cos^2\theta}} = \int_{0}^{\pi/6}\frac{3\cos\theta}{3|\cos\theta|}\,d\theta \\ &= \int_{0}^{\pi/6}1\,d\theta=\frac{\pi}{6}. \end{aligned}",
      r"\textbf{[Remark]}",
      r"\text{Using } \displaystyle \int \frac{dx}{\sqrt{a^2-x^2}}=\arcsin\left(\displaystyle\frac{x}{a}\right)+C \text{ with }a=3\text{ also gives } \left[\arcsin\left(\displaystyle\frac{x}{3}\right)\right]_{0}^{3/2}=\displaystyle\frac{\pi}{6}\text{.}",
    ],
  ),

  // problems_substitution.dart
  "680C8A2D-4E18-4E76-97F7-5F59531CD4DD": ProblemTranslation(
    category: 'Substitution',
    level: 'Easy',
    question:
        r"""\displaystyle \int_{0}^{ \frac{\pi}{4}} \sin x \cos x \,dx""",
    answer: r"""\displaystyle \frac{1}{4}""",
    hint: r"""\text{Let }u=\sin x\text{.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let }u=\sin x\text{, so }du=\cos x\,dx\text{.}",
      r"\textbf{[Explanation]}",
      r"\text{Change of bounds:}",
      r"\begin{aligned} x=0 &\Rightarrow u=0,\\ x=\frac{\pi}{4} &\Rightarrow u=\frac{\sqrt{2}}{2}. \end{aligned}",
      r"\textbf{[Computation]}",
      r"\begin{aligned} \int_{0}^{\pi/4}\sin x\cos x\,dx &= \int_{0}^{\sqrt{2}/2} u\,du \\ &= \left[\frac{1}{2}u^2\right]_{0}^{\sqrt{2}/2} \\ &= \frac{1}{2}\cdot\frac{2}{4} = \frac{1}{4}. \end{aligned}",
    ],
  ),
  "183166B0-C425-4604-B488-2D51C73267D5": ProblemTranslation(
    category: 'Substitution',
    level: 'Easy',
    question:
        r"""\displaystyle \int_{0}^{\sqrt{3}} \displaystyle \frac{x}{\sqrt{1+x^{2}}}\,dx""",
    answer: r"""1""",
    hint: r"""\text{Let }u=1+x^2\text{.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let }u=1+x^2\text{, so }du=2x\,dx\text{.}",
      r"\textbf{[Explanation]}",
      r"\text{Change of bounds:}",
      r"\begin{aligned} x=0 &\Rightarrow u=1,\\ x=\sqrt{3} &\Rightarrow u=4. \end{aligned}",
      r"\textbf{[Computation]}",
      r"\begin{aligned} \int_{0}^{\sqrt{3}} \frac{x}{\sqrt{1+x^2}}\,dx &= \frac{1}{2}\int_{1}^{4} u^{-1/2}\,du \\ &= \frac{1}{2}\left[ \frac{u^{1/2}}{1/2}\right]_{1}^{4} = \left[\sqrt{u}\right]_{1}^{4} \\ &= 2-1 = 1. \end{aligned}",
    ],
  ),
  "BDCAAAB3-8109-4E6B-8A45-9EFD024A0B05": ProblemTranslation(
    category: 'Substitution',
    level: 'Easy',
    question:
        r"""\displaystyle \int_{2}^{2\sqrt{3}} \displaystyle \frac{dx}{\sqrt{16 - x^{2}}}""",
    answer: r"""\displaystyle \frac{\pi}{6}""",
    hint: r"""\text{Let }x=4\sin\theta\text{.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let }x=4\sin\theta\text{.}",
      r"\textbf{[Explanation]}",
      r"x=2\to 2\sqrt{3}\ \Rightarrow\ \sin\theta=\frac{1}{2}\to\frac{\sqrt{3}}{2}\ \Rightarrow\ \theta=\frac{\pi}{6}\to\frac{\pi}{3}.",
      r"\text{Also, }16-x^2=16-16\sin^2\theta=16\cos^2\theta,\quad dx=4\cos\theta\,d\theta\text{.}",
      r"\text{Therefore,}",
      r"\begin{aligned} \int_{2}^{2\sqrt{3}} \frac{dx}{\sqrt{16-x^2}} &= \int_{\pi/6}^{\pi/3} \frac{4\cos\theta\,d\theta}{4\cos\theta} \\ &= \int_{\pi/6}^{\pi/3} 1\,d\theta = \left[\theta\right]_{\pi/6}^{\pi/3} = \frac{\pi}{6}. \end{aligned}",
      r"\textbf{[Supplement]}",
      r"\text{We can also use the inverse sine function } \arcsin x \text{ (principal values).}",
      r"\text{Use } \displaystyle \int \frac{dx}{\sqrt{a^2-x^2}}=\arcsin\left(\frac{x}{a}\right)+C \text{ with }a=4\text{.}",
      r"\text{First compute the indefinite integral:}",
      r"\begin{aligned} \int \frac{dx}{\sqrt{16-x^2}} &= \arcsin\left(\frac{x}{4}\right)+C. \end{aligned}",
      r"\text{Hence,}",
      r"\begin{aligned} \int_{2}^{2\sqrt{3}} \frac{dx}{\sqrt{16-x^2}} &= \left[\arcsin\left(\frac{x}{4}\right)\right]_{2}^{2\sqrt{3}} = \arcsin\left(\frac{\sqrt{3}}{2}\right)-\arcsin\left(\frac{1}{2}\right) \\ &= \frac{\pi}{3}-\frac{\pi}{6}=\frac{\pi}{6}. \end{aligned}",
    ],
  ),
  "7FF2277B-44DC-480A-B1BF-7D1990121B24": ProblemTranslation(
    category: 'Substitution',
    level: 'Easy',
    question:
        r"""\displaystyle \int_{e}^{e^{2}} \displaystyle \frac{dx}{x\log x}""",
    answer: r"""\log 2""",
    hint:
        r"""\text{Let }u=\log x\text{. Then }du=\displaystyle\frac{dx}{x}\text{.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let }u=\log x\text{.}",
      r"\text{Then }du=\displaystyle\frac{dx}{x}\text{.}",
      r"\textbf{[Explanation]}",
      r"\text{First find an antiderivative.}",
      r"\begin{aligned} \int \frac{dx}{x\log x} &= \int \frac{1}{u}\,du = \log|u|+C = \log|\log x|+C. \end{aligned}",
      r"\text{Therefore, the definite integral is}",
      r"\text{Change of bounds:}",
      r"\begin{aligned} x=e &\Rightarrow u=\log e=1,\\ x=e^2 &\Rightarrow u=\log(e^2)=2. \end{aligned}",
      r"\begin{aligned} \int_{e}^{e^{2}} \frac{dx}{x\log x} &= \int_{1}^{2} \frac{1}{u}\,du = \left[\log|u|\right]_{1}^{2} = \log 2 - \log 1 = \log 2. \end{aligned}",
      r"\textbf{[Supplement]}",
      r"\text{On this interval }x>1\text{ so }\log x>0\text{ and }\log|\log x|=\log(\log x)\text{.}",
    ],
  ),
  "BED49300-099F-4DD3-9DC6-1AB5635BEC1B": ProblemTranslation(
    category: 'Substitution',
    level: 'Easy',
    question:
        r"""\displaystyle \int_{0}^{ \frac{\pi}{6}} \sin^{2}x \cos x \,dx""",
    answer: r"""\displaystyle \frac{1}{24}""",
    hint: r"""\text{Let }u=\sin x\text{.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let }u=\sin x\text{, so }du=\cos x\,dx\text{.}",
      r"\textbf{[Explanation]}",
      r"\text{Change of bounds:}",
      r"\begin{aligned} x=0 &\Rightarrow u=0,\\ x=\frac{\pi}{6} &\Rightarrow u=\frac{1}{2}. \end{aligned}",
      r"\textbf{[Computation]}",
      r"\begin{aligned} \int_{0}^{\pi/6}\sin^2x\cos x\,dx &= \int_{0}^{1/2} u^2\,du = \left[\frac{1}{3}u^3\right]_{0}^{1/2} \\ &= \frac{1}{3}\cdot\frac{1}{8}=\frac{1}{24}. \end{aligned}",
    ],
  ),
  "76E997DF-6492-444C-91C9-F3EC13EB7F41": ProblemTranslation(
    category: 'Substitution',
    level: 'Easy',
    question:
        r"""\displaystyle \int_{0}^{1} \displaystyle \frac{dx}{1 + x^{2}}""",
    answer: r"""\displaystyle \frac{\pi}{4}""",
    hint: r"""\text{Use the substitution }x=\tan\theta\text{.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let }x=\tan\theta\text{.}",
      r"\textbf{[Explanation]}",
      r"\text{Set }x=\tan\theta\text{. Then }dx=\displaystyle\frac{1}{\cos^2\theta}\,d\theta\text{.}",
      r"\text{Also }1+\tan^2\theta=\displaystyle\frac{1}{\cos^2\theta}\text{.}",
      r"\text{When }x:0\to 1,\ \tan\theta:0\to 1,\ \text{so }\theta:0\to \displaystyle\frac{\pi}{4}\text{.}",
      r"\begin{aligned} \int_{0}^{1}\frac{dx}{1+x^2} &= \int_{0}^{\pi/4} \frac{1}{1+\tan^2\theta}\cdot\frac{1}{\cos^2\theta}\,d\theta \\ &= \int_{0}^{\pi/4} 1\,d\theta = \left[\theta\right]_{0}^{\pi/4}=\frac{\pi}{4}. \end{aligned}",
      r"\textbf{[Supplement]}",
      r"\text{Equivalently, } \int \displaystyle\frac{dx}{1+x^2}=\arctan x + C\text{.}",
    ],
  ),
  "17D1526C-1324-4C82-8D05-59B9308E14D2": ProblemTranslation(
    category: 'Substitution',
    level: 'Advanced',
    question:
        r"""\displaystyle \int_{\frac{1}{4}}^{\frac{3}{4}} \displaystyle \frac{dx}{\sqrt{x(1-x)}}""",
    answer: r"""\displaystyle \frac{\pi}{3}""",
    hint: r"""\text{Use the substitution }x=\sin^2\theta\text{.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let }x=\sin^2\theta\text{.}",
      r"\textbf{[Explanation]}",
      r"x=\frac{1}{4}\to\frac{3}{4}\ \Rightarrow\ \sin^2\theta=\frac{1}{4}\to\frac{3}{4}\ \Rightarrow\ \sin\theta=\frac{1}{2}\to\frac{\sqrt{3}}{2}\ \Rightarrow\ \theta=\frac{\pi}{6}\to\frac{\pi}{3}.",
      r"\text{Also,}",
      r"\begin{aligned} \sqrt{x(1-x)} &= \sqrt{\sin^2\theta(1-\sin^2\theta)} = |\sin\theta\cos\theta| \\ &= \sin\theta\cos\theta \quad \left(\frac{\pi}{6}\le\theta\le\frac{\pi}{3}\right). \end{aligned}",
      r"\text{Moreover, }dx=2\sin\theta\cos\theta\,d\theta\text{, so}",
      r"\begin{aligned} \int_{1/4}^{3/4}\frac{dx}{\sqrt{x(1-x)}} &= \int_{\pi/6}^{\pi/3} \frac{2\sin\theta\cos\theta\,d\theta}{\sin\theta\cos\theta} \\ &= \int_{\pi/6}^{\pi/3} 2\,d\theta = \left[2\theta\right]_{\pi/6}^{\pi/3} \\ &= 2\left(\frac{\pi}{3}-\frac{\pi}{6}\right)=\frac{\pi}{3}. \end{aligned}",
      r"\textbf{[Supplement]}",
      r"\text{In university mathematics this appears as }B\!\left(\frac{1}{2},\frac{1}{2}\right)=\pi\text{ (the beta function).}",
    ],
  ),
};
