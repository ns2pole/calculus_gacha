import '../../../models/problem_translation.dart';

final Map<String, ProblemTranslation> sequencesTranslationsEn = {
  "7D0760FF-946D-469A-842D-60D426A01724": ProblemTranslation(
    category: 'Recurrence Relations',
    level: 'Easy',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Since the right side is a constant, find a particular solution in the form of a constant sequence } A, \text{ and use it to reduce the relation to a simple geometric progression.}",
      r"\textbf{[Solution]}",
      r"\text{Assume a constant solution } A \text{ and substitute it into the recurrence: } A = 2A + 3.",
      r"\begin{aligned} A = 2A + 3 \Leftrightarrow A = -3 \end{aligned}",
      r"\text{Substituting } A = -3 \text{ back into the recurrence: } -3 = 2 \cdot (-3) + 3 \cdots (1).",
      r"\text{Subtracting (1) from the original recurrence and defining a new sequence } b_n = a_n + 3:",
      r"\begin{aligned} a_{n+1} &= 2a_n + 3 \\ -3 &= 2 \cdot (-3) + 3 \\ \hline a_{n+1} + 3 &= 2(a_n + 3) \end{aligned}",
      r"\text{Therefore, let } b_n = a_n + 3\text{.}",
      r"""\begin{aligned}
      \begin{cases}
    \ b_{n+1} = 2b_n \\
    \ b_1 = a_1 + 3 = 4
    \end{cases}
    \end{aligned}""",
      r"\text{This is a geometric progression: } b_n = 4 \cdot 2^{n-1} = 2^{n+1}.",
      r"\begin{aligned} a_n = b_n - 3 \Leftrightarrow a_n = 2^{n+1} - 3 \end{aligned}",
    ],
  ),

  "3F26B444-EA86-4FF8-830B-2AC464BDE3E6": ProblemTranslation(
    category: 'Recurrence Relations',
    level: 'Easy',
    question: r"""a_{n+1} = 3a_n - 4, \quad a_1 = 1""",
    answer: r"""a_n = -3^{n-1} + 2""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Since the right side is a constant, find a constant particular solution }A\text{ and reduce to a geometric progression.}",
      r"\textbf{[Solution]}",
      r"\text{Assume a constant solution }A\text{ and substitute into the recurrence: }A=3A-4\text{.}",
      r"\begin{aligned} A=3A-4 \Leftrightarrow A=2 \end{aligned}",
      r"\text{Substituting the constant solution }A=2\text{ back into the recurrence: }2 = 3\cdot 2 - 4 \cdots (1).",
      r"\text{Subtracting (1) from the original recurrence, define a new sequence } b_n = a_n - 2\text{. Then}",
      r"""
      \begin{aligned}
      a_{n+1} &= 3a_n - 4 \\
      2 &= 3 \cdot 2 - 4 \\
      \hline
      \ \ \ \ \ a_{n+1} - 2 &= 3a_n - 4 - (3 \cdot 2 - 4) \\
      \Leftrightarrow a_{n+1} - 2 &= 3a_n - 4 - 2 \\
      \Leftrightarrow a_{n+1} - 2 &= 3(a_n - 2)
      \end{aligned}
      """,
      r"\text{Let } b_n = a_n - 2\text{. Then }",
      r"\text{ } b_1 = a_1 - 2 = 1 - 2 = -1\text{, so}",
      r"""\begin{aligned}
    \begin{cases}
    \ b_{n+1} = 3b_n \\
    \ b_1 = -1
    \end{cases}
    \end{aligned}""",
      r"\text{This is a geometric progression, so } b_n = -1 \cdot 3^{n-1} = -3^{n-1}\text{.}",
      r"\begin{aligned} a_n=b_n+2=-3^{n-1}+2 \end{aligned}",
    ],
  ),

  "0E10892B-45E0-4994-9281-EDB35CE38498": ProblemTranslation(
    category: 'Recurrence Relations',
    level: 'Mid',
    question: r"""a_{n+1} = 2a_n + n + 1, \quad a_1 = 1""",
    answer: r"""a_n = 2^{n+1} - n - 2""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Since the non-homogeneous term is linear in }n\text{, find a particular solution of the form }An+B\text{, then reduce to a geometric progression.}",
      r"\textbf{[Solution]}",
      r"\text{Assume a particular solution }a_n^{(p)} = An + B\text{ and substitute into }a_{n+1}=2a_n+n+1\text{:}",
      r"""\begin{aligned}
    \ \ \ \ \ A(n+1) + B &= 2(An + B) + n + 1 \\
    \Leftrightarrow An + A + B &= 2An + 2B + n + 1 \\
    \Leftrightarrow An + A + B &= (2A + 1)n + 2B + 1
    \end{aligned}""",
      r"\text{Compare coefficients: }A=2A+1,\ A+B=2B+1\text{, so }A=-1,\ B=-2\text{.}",
      r"\text{Thus, one particular solution is } -n - 2\text{.}",
      r"\text{Substituting this solution into the recurrence gives } -(n+1) - 2 = 2(-n - 2) + n + 1 \cdots (1)\text{.}",
      r"\text{Subtracting (1) from the original recurrence and defining } b_n = a_n + n + 2\text{, we can reduce to a geometric progression. Indeed,}",
      r"""
      \begin{aligned}
      a_{n+1} &= 2a_n + n + 1 \\
      -(n+1) - 2 &= 2(-n - 2) + n + 1 \\
      \hline
      \ \ \ \ \ a_{n+1} - (-(n+1) - 2) &= 2a_n + n + 1 - (2(-n - 2) + n + 1) \\
      \Leftrightarrow a_{n+1} + (n+1) + 2 &= 2a_n + n + 1 - 2(-n - 2) - n - 1 \\
      \Leftrightarrow a_{n+1} + (n+1) + 2 &= 2(a_n + n + 2)
      \end{aligned}
      """,
      r"\text{Let } b_n = a_n + n + 2\text{. Then } b_{n+1} = 2b_n\text{.}",
      r"\text{Since } a_1 = 1\text{, we have } b_1 = a_1 + 1 + 2 = 4\text{, so}",
      r"""\begin{aligned}
    \begin{cases}
    \ b_{n+1} = 2b_n \\
    \ b_1 = 4
    \end{cases}
    \end{aligned}""",
      r"\text{This is a geometric progression, so } b_n = 4 \cdot 2^{n-1} = 2^{n+1}\text{.}",
      r"""\begin{aligned}
    &\ \ \ \ \ a_n = b_n - n - 2 \\
    &\Leftrightarrow a_n = 2^{n+1} - n - 2
    \end{aligned}""",
    ],
  ),

  "98C763E5-86DB-47A3-B2EF-D070244EC978": ProblemTranslation(
    category: 'Recurrence Relations',
    level: 'Easy',
    question: r"""a_{n+1} = 2a_n + n^2 + 1, \quad a_1 = 1""",
    answer: r"""a_n = 2^{n+2} - n^2 - 2n - 4""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Since the non-homogeneous term is quadratic, find a particular solution of the form }An^2+Bn+C\text{, then reduce to a geometric progression.}",
      r"\textbf{[Solution]}",
      r"\text{Assume a particular solution }a_n^{(p)}=An^2+Bn+C\text{. Substitute into }a_{n+1}=2a_n+n^2+1\text{:}",
      r"""\begin{aligned}
    &\ \ \ \ \ A(n+1)^2 + B(n+1) + C = 2(An^2 + Bn + C) + n^2 + 1 \\
    &\Leftrightarrow A(n^2 + 2n + 1) + Bn + B + C = 2An^2 + 2Bn + 2C + n^2 + 1 \\
    &\Leftrightarrow An^2 + 2An + A + Bn + B + C = (2A + 1)n^2 + 2Bn + 2C + 1
    \end{aligned}""",
      r"\text{Compare coefficients:}",
      r"""\begin{aligned}
    &\begin{cases}
    A = 2A + 1 \\
    2A + B = 2B \\
    A + B + C = 2C + 1
    \end{cases}
    \ \Rightarrow\
    \begin{cases}
    A = -1 \\
    B = -2 \\
    C = -4
    \end{cases}
    \end{aligned}""",
      r"\text{Thus, one particular solution is } \textcolor{green}{-n^2 - 2n - 4}\text{.}",
      r"\text{Substituting this solution into the recurrence gives } -(n+1)^2 - 2(n+1) - 4 = 2(-n^2 - 2n - 4) + n^2 + 1 \cdots (1)\text{.}",
      r"\text{Subtracting (1) from the original recurrence and defining } b_n = a_n + n^2 + 2n + 4\text{, we reduce to a geometric progression. Indeed,}",
      r"""
      \begin{aligned}
      a_{n+1} &= 2a_n + n^2 + 1 \\
      -(n+1)^2 - 2(n+1) - 4 &= 2(-n^2 - 2n - 4) + n^2 + 1 \\
      \hline
      \ \ \ \ \ a_{n+1} - (-(n+1)^2 - 2(n+1) - 4) &= 2a_n + n^2 + 1 - (2(-n^2 - 2n - 4) + n^2 + 1) \\
      \Leftrightarrow a_{n+1} + (n+1)^2 + 2(n+1) + 4 &= 2a_n + n^2 + 1 - 2(-n^2 - 2n - 4) - n^2 - 1 \\
      \Leftrightarrow a_{n+1} + (n+1)^2 + 2(n+1) + 4 &= 2(a_n + n^2 + 2n + 4)
      \end{aligned}
      """,
      r"\text{Let } b_n = a_n + n^2 + 2n + 4\text{. Then } b_{n+1} = 2b_n\text{.}",
      r"\text{Since } a_1 = 1\text{, we have } b_1 = a_1 + 1^2 + 2\cdot 1 + 4 = 8\text{, so}",
      r"""\begin{aligned}
    \begin{cases}
    \ b_{n+1} = 2b_n \\
    \ b_1 = 8
    \end{cases}
    \end{aligned}""",
      r"\text{This is a geometric progression, so } b_n = 8 \cdot 2^{n-1} = 2^{n+2}\text{.}",
      r"""\begin{aligned}
    &\ \ \ \ \ a_n = b_n - n^2 - 2n - 4 \\
    &\Leftrightarrow a_n = 2^{n+2} - n^2 - 2n - 4 \\
    \end{aligned}""",
    ],
  ),

  "9F9BF526-C923-4508-A690-C5E04D27A79E": ProblemTranslation(
    category: 'Recurrence Relations',
    level: 'Mid',
    question: r"""a_{n+1} = 2a_n + 3^n, \quad a_1 = 1""",
    answer: r"""a_n = 3^n - 2^n""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Since the non-homogeneous term is exponential, look for a particular solution of the form }A\cdot 3^n\text{, then reduce to a geometric progression.}",
      r"\textbf{[Solution]}",
      r"\text{Assume a particular solution of the form }A\cdot 3^{n-1}\text{. Substitute into }a_{n+1}=2a_n+3^n\text{:}",
      r"""\begin{aligned}
    &\ \ \ \ \ A\cdot 3^n = 2\cdot A\cdot 3^{n-1} + 3^n \\
    &\Leftrightarrow A\cdot 3^n = \displaystyle \frac{2A}{3}\cdot 3^n + 3^n \\
    &\Leftrightarrow A = \displaystyle \frac{2A}{3} + 1 \\
    &\Leftrightarrow 3A = 2A + 3 \\
    &\Leftrightarrow A = 3
    \end{aligned}""",
      r"\text{Thus, one particular solution is } 3\cdot 3^{n-1} = 3^n\text{.}",
      r"\text{Substituting this solution into the recurrence gives } 3^{n+1} = 2\cdot 3^n + 3^n \cdots (1)\text{.}",
      r"\text{Subtracting (1) from the original recurrence and defining } b_n = a_n - 3^n\text{, we reduce to a geometric progression. Indeed,}",
      r"""
      \begin{aligned}
      a_{n+1} &= 2a_n + 3^n \\
      3^{n+1} &= 2 \cdot 3^n + 3^n \\
      \hline
      \ \ \ \ \ a_{n+1} - 3^{n+1} &= 2a_n + 3^n - (2 \cdot 3^n + 3^n) \\
      \Leftrightarrow a_{n+1} - 3^{n+1} &= 2(a_n - 3^n)
      \end{aligned}
      """,
      r"\text{Let } b_n = a_n - 3^n\text{. Then } b_{n+1} = 2b_n\text{ and } b_1 = a_1 - 3^1 = 1 - 3 = -2\text{, so}",
      r"""\begin{aligned}
        \begin{cases}
         b_{n+1} = 2b_n \\
          b_1 = -2
          \end{cases}
          \end{aligned}""",
      r"\text{This is a geometric progression, so } b_n = -2 \cdot 2^{n-1} = -2^n\text{.}",
      r"""\begin{aligned}
    &\ \ \ \ \ a_n = b_n + 3^n \\
    &\Leftrightarrow a_n = -2^n + 3^n \\
    &\Leftrightarrow a_n = 3^n - 2^n
    \end{aligned}""",
    ],
  ),
  
  "BE1669B0-E7C4-4855-B98E-2F2AE53B7981": ProblemTranslation(
    category: 'Recurrence Relations',
    level: 'Easy',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Take the reciprocal of both sides.}",
      r"\textbf{[Solution]}",
      r"\text{Taking reciprocals:}",
      r"\begin{aligned} \frac{1}{a_{n+1}} = \frac{a_n + 1}{a_n} = 1 + \frac{1}{a_n} \end{aligned}",
      r"\text{Let } b_n = 1/a_n. \text{ Then } b_{n+1} = b_n + 1 \text{ and } b_1 = 1.",
      r"b_n = 1 + (n-1) \cdot 1 = n.",
      r"\begin{aligned} a_n = 1/b_n = 1/n \end{aligned}",
    ],
  ),
  "8CF61D01-3229-4ABF-BC3F-46A7681BBFEF": ProblemTranslation(
    category: 'Recurrence Relations',
    level: 'Advanced',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Find constant solutions }A\text{ and use them to reduce the recurrence to a simpler form.}",
      r"\textbf{[Solution]}",
      r"\text{Assume a constant solution }A\text{. Substituting into the recurrence gives } A = \displaystyle\frac{4A+3}{A+2}\text{.}",
      r"""\begin{aligned}
    &\ \ \ \ \ A(A + 2) = 4A + 3 \\
    &\Leftrightarrow A^2 + 2A = 4A + 3 \\
    &\Leftrightarrow A^2 - 2A - 3 = 0 \\
    &\Leftrightarrow (A - 3)(A + 1) = 0
    \end{aligned}""",
      r"\text{Therefore, the constant solutions are } A=3 \text{ or } A=-1\text{.}",
      r"\text{Choose }A=3\text{. Substituting into the recurrence gives } 3 = \displaystyle\frac{4\cdot 3 + 3}{3+2}\cdots(1)\text{.}",
      r"\text{By Proposition 1, define } b_n=a_n-3\text{ to remove the constant term in the numerator. Subtract (1) from the original recurrence:}",
      r"""
      \begin{aligned}
      a_{n+1} &= \displaystyle \frac{4a_n + 3}{a_n + 2}  \\
      3 &= \displaystyle \frac{4 \cdot 3 + 3}{3 + 2} \cdots (1) \\
      \hline
      \ \ \ \ \ a_{n+1} - 3 &= \displaystyle \frac{4a_n + 3}{a_n + 2} - \displaystyle \frac{4 \cdot 3 + 3}{3 + 2} \\
      \Leftrightarrow a_{n+1} - 3 &= \displaystyle \frac{4a_n + 3}{a_n + 2} - 3 \\
      \Leftrightarrow a_{n+1} - 3 &= \displaystyle \frac{4a_n + 3 - 3(a_n + 2)}{a_n + 2} \\
      \Leftrightarrow a_{n+1} - 3 &= \displaystyle \frac{4a_n + 3 - 3a_n - 6}{a_n + 2} \\
      \Leftrightarrow a_{n+1} - 3 &= \displaystyle \frac{a_n - 3}{a_n + 2}
      \end{aligned}
      """,
      r"\text{Let } b_n=a_n-3\text{. Then }b_1=a_1-3=2-3=-1\text{ and }a_n=b_n+3\text{. Substituting,}",
      r"""\begin{aligned}
    b_{n+1} &= \displaystyle \frac{b_n + 3 - 3}{b_n + 3 + 2} \\
    &= \displaystyle \frac{b_n}{b_n + 5}
    \end{aligned}""",
      r"\text{Taking reciprocals,}",
      r"""\begin{aligned}
    &\ \ \ \ \ \displaystyle \frac{1}{b_{n+1}} = \displaystyle \frac{b_n + 5}{b_n} \\
    &\Leftrightarrow \displaystyle \frac{1}{b_{n+1}} = 1 + \displaystyle \frac{5}{b_n}
    \end{aligned}""",
      r"\text{Let } c_n=\displaystyle\frac{1}{b_n}\text{. Then } c_{n+1}=1+5c_n,\ c_1=\frac{1}{b_1}=\frac{1}{-1}=-1\text{. Solving gives } c_n=-\displaystyle \frac{3\cdot 5^{n-1}+1}{4}\text{.}",
      r"\text{Therefore,}",
      r"""\begin{aligned}
    &\ \ \ \ \ b_n = \displaystyle \frac{1}{c_n} \\
    &\Leftrightarrow b_n = -\displaystyle \frac{4}{3 \cdot 5^{n-1} + 1}
    \end{aligned}""",
      r"\text{Finally, since }a_n=b_n+3\text{,}",
      r"""\begin{aligned}
    &\ \ \ \ \ a_n = b_n + 3 \\
    &\Leftrightarrow a_n = 3 - \displaystyle \frac{4}{3 \cdot 5^{n-1} + 1}
    \end{aligned}""",
      r"\textbf{[Proposition 1]}",
      r"\text{Given a fractional recurrence } a_{n+1}=\displaystyle\frac{pa_n+q}{ra_n+s}\text{, let }A\text{ be a constant solution satisfying } A=\displaystyle\frac{pA+q}{rA+s}\text{.}",
      r"\text{Then, with } b_n=a_n-A\text{, we obtain } b_{n+1}=\displaystyle\frac{(p-rA)b_n}{rb_n+rA+s}\text{, which has no constant term in the numerator.}",
      r"\textbf{[Proof]}",
      r"\text{Since }A=\displaystyle\frac{pA+q}{rA+s}\text{, multiplying both sides by }(rA+s)\text{ gives}",
      r"""\begin{aligned}
    &\ \ \ \ \ A(rA + s) = pA + q \\
    &\Leftrightarrow rA^2 + sA = pA + q \\
    &\Leftrightarrow rA^2 + (s - p)A - q = 0 \\
    &\Leftrightarrow rA^2 + (s - p)A - q = 0 \cdots (1)
    \end{aligned}""",
      r"\text{Now let } b_n=a_n-A\text{. Then }a_n=b_n+A\text{. Substituting into the original recurrence gives}",
      r"""\begin{aligned}
    b_{n+1} + A &= \displaystyle \frac{p(b_n + A) + q}{r(b_n + A) + s} \\
    &= \displaystyle \frac{pb_n + pA + q}{rb_n + rA + s}
    \end{aligned}""",
      r"""\begin{aligned}
    b_{n+1} &= \displaystyle \frac{pb_n + pA + q}{rb_n + rA + s} - A \\
    &= \displaystyle \frac{pb_n + pA + q - A(rb_n + rA + s)}{rb_n + rA + s} \\
    &= \displaystyle \frac{pb_n  - rAb_n - (rA^2 + (s-p)A - q) }{rb_n + rA + s} \\
    \end{aligned}""",
      r"\text{Using (1), the term }rA^2 + (s-p)A - q=0\text{, so}",
      r"""\begin{aligned}
      b_{n+1}
      &=\displaystyle \frac{pb_n  - rAb_n}{rb_n + rA + s} \\
      &= \displaystyle \frac{(p - rA)b_n}{rb_n + rA + s}
    \end{aligned}""",
      r"\text{Thus, } b_{n+1} = \displaystyle \frac{(p - rA)b_n}{rb_n + rA + s}\text{, proving the proposition.}",
    ],
  ),
  "A8B9C0D1-2E3F-4A5B-6C7D-8E9F0A1B2C3": ProblemTranslation(
    category: 'Recurrence Relations',
    level: 'Advanced',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Find a constant solution }A\text{, then use the reduction }b_n=a_n-A\text{. Since the constant solution is a double root, we will get an arithmetic progression after taking reciprocals.}",
      r"\textbf{[Solution]}",
      r"\text{Assume a constant solution }A\text{. Substituting into the recurrence gives } A = \displaystyle\frac{A-9}{A-5}\text{.}",
      r"""\begin{aligned}
    &\ \ \ \ \ A(A - 5) = A - 9 \\
    &\Leftrightarrow A^2 - 5A = A - 9 \\
    &\Leftrightarrow A^2 - 6A + 9 = 0 \\
    &\Leftrightarrow (A - 3)^2 = 0 \\
    &\Leftrightarrow A = 3
    \end{aligned}""",
      r"\text{Choose }A=3\text{. Substituting into the recurrence gives } 3 = \displaystyle\frac{3-9}{3-5}\cdots(1)\text{.}",
      r"\text{By Proposition 1, define } b_n=a_n-3\text{. Subtract (1) from the original recurrence:}",
      r"""
      \begin{aligned}
      a_{n+1} &= \displaystyle \frac{a_n - 9}{a_n - 5}  \\
      3 &= \displaystyle \frac{3 - 9}{3 - 5} \cdots (1) \\
      \hline
      \ \ \ \ \ a_{n+1} - 3 &= \displaystyle \frac{a_n - 9}{a_n - 5} - \displaystyle \frac{3 - 9}{3 - 5} \\
      \Leftrightarrow a_{n+1} - 3 &= \displaystyle \frac{a_n - 9}{a_n - 5} - 3 \\
      \Leftrightarrow a_{n+1} - 3 &= \displaystyle \frac{a_n - 9 - 3(a_n - 5)}{a_n - 5} \\
      \Leftrightarrow a_{n+1} - 3 &= \displaystyle \frac{a_n - 9 - 3a_n + 15}{a_n - 5} \\
      \Leftrightarrow a_{n+1} - 3 &= \displaystyle \frac{-2a_n + 6}{a_n - 5} \\
      \Leftrightarrow a_{n+1} - 3 &= \displaystyle \frac{-2(a_n - 3)}{a_n - 5}
      \end{aligned}
      """,
      r"\text{Let } b_n=a_n-3\text{. Then }b_1=a_1-3=2-3=-1\text{ and }a_n=b_n+3\text{. Substituting,}",
      r"""\begin{aligned}
    b_{n+1} &= \displaystyle \frac{-2(b_n + 3 - 3)}{b_n + 3 - 5} \\
    &= \displaystyle \frac{-2b_n}{b_n - 2}
    \end{aligned}""",
      r"\text{Taking reciprocals,}",
      r"""\begin{aligned}
    &\ \ \ \ \ \displaystyle \frac{1}{b_{n+1}} = \displaystyle \frac{b_n - 2}{-2b_n} \\
    &\Leftrightarrow \displaystyle \frac{1}{b_{n+1}} = -\displaystyle \frac{1}{2} + \displaystyle \frac{1}{b_n}
    \end{aligned}""",
      r"\text{Let } c_n=\displaystyle\frac{1}{b_n}\text{. Then } c_{n+1}=-\displaystyle\frac{1}{2}+c_n,\ c_1=\frac{1}{b_1}=\frac{1}{-1}=-1\text{.}",
      r"\text{Solving this arithmetic progression gives } c_n = -1 + (n-1)\left(-\displaystyle\frac{1}{2}\right) = -\displaystyle\frac{n+1}{2}\text{.}",
      r"\text{Therefore,}",
      r"""\begin{aligned}
    &\ \ \ \ \ b_n = \displaystyle \frac{1}{c_n} \\
    &\Leftrightarrow b_n = -\displaystyle \frac{2}{n+1}
    \end{aligned}""",
      r"\text{Finally, since }a_n=b_n+3\text{,}",
      r"""\begin{aligned}
    &\ \ \ \ \ a_n = b_n + 3 \\
    &\Leftrightarrow a_n = 3 - \displaystyle \frac{2}{n+1} \\
    &\Leftrightarrow a_n = \displaystyle \frac{3(n+1) - 2}{n+1} \\
    &\Leftrightarrow a_n = \displaystyle \frac{3n + 1}{n+1}
    \end{aligned}""",
      r"\textbf{[Proposition 1]}",
      r"\text{Given a fractional recurrence } a_{n+1}=\displaystyle\frac{pa_n+q}{ra_n+s}\text{, let }A\text{ be a constant solution satisfying } A=\displaystyle\frac{pA+q}{rA+s}\text{.}",
      r"\text{Then, with } b_n=a_n-A\text{, we obtain } b_{n+1}=\displaystyle\frac{(p-rA)b_n}{rb_n+rA+s}\text{, which has no constant term in the numerator.}",
      r"\textbf{[Proof]}",
      r"\text{Since }A=\displaystyle\frac{pA+q}{rA+s}\text{, multiplying both sides by }(rA+s)\text{ gives}",
      r"""\begin{aligned}
    &\ \ \ \ \ A(rA + s) = pA + q \\
    &\Leftrightarrow rA^2 + sA = pA + q \\
    &\Leftrightarrow rA^2 + (s - p)A - q = 0 \\
    &\Leftrightarrow rA^2 + (s - p)A - q = 0 \cdots (1)
    \end{aligned}""",
      r"\text{Now let } b_n=a_n-A\text{. Then }a_n=b_n+A\text{. Substituting into the original recurrence gives}",
      r"""\begin{aligned}
    b_{n+1} + A &= \displaystyle \frac{p(b_n + A) + q}{r(b_n + A) + s} \\
    &= \displaystyle \frac{pb_n + pA + q}{rb_n + rA + s}
    \end{aligned}""",
      r"""\begin{aligned}
    b_{n+1} &= \displaystyle \frac{pb_n + pA + q}{rb_n + rA + s} - A \\
    &= \displaystyle \frac{pb_n + pA + q - A(rb_n + rA + s)}{rb_n + rA + s} \\
    &= \displaystyle \frac{pb_n  - rAb_n - (rA^2 + (s-p)A - q) }{rb_n + rA + s} \\
    \end{aligned}""",
      r"\text{Using (1), the term }rA^2 + (s-p)A - q=0\text{, so}",
      r"""\begin{aligned}
      b_{n+1}
      &=\displaystyle \frac{pb_n  - rAb_n}{rb_n + rA + s} \\
      &= \displaystyle \frac{(p - rA)b_n}{rb_n + rA + s} \quad \cdots (2)
    \end{aligned}""",
      r"\text{Thus, } b_{n+1} = \displaystyle \frac{(p - rA)b_n}{rb_n + rA + s}\cdot(2)\text{, proving Proposition 1.}",
      r"\textbf{[In particular: Double-root case]}",
      r"\text{In the double-root case, the discriminant is }0\text{, so } (s-p)^2+4rq=0\text{. By the quadratic formula, } A=\displaystyle\frac{-(s-p)}{2r}=\displaystyle\frac{p-s}{2r}\text{.}",
      r"\text{Rewriting this gives } 2rA=p-s \Leftrightarrow rA+s=p-rA\text{.}",
      r"\text{Taking reciprocals of (2), } \displaystyle \frac{1}{b_{n+1}} = \displaystyle\frac{rb_n+rA+s}{(p-rA)b_n}\text{.}",
      r"\text{Using } rA+s=p-rA\text{, we get } \displaystyle \frac{1}{b_{n+1}}=\displaystyle\frac{rb_n+(p-rA)}{(p-rA)b_n}=\displaystyle\frac{r}{p-rA}+\displaystyle\frac{1}{b_n}\text{.}",
      r"\text{Also } p-rA = p-r\cdot \displaystyle\frac{p-s}{2r}=\displaystyle\frac{p+s}{2}\text{, hence } \displaystyle \frac{1}{b_{n+1}}=\displaystyle\frac{2r}{p+s}+\displaystyle\frac{1}{b_n}\text{.}",
      r"\text{Therefore, } \displaystyle\frac{1}{b_n}\text{ is an arithmetic progression with common difference } \displaystyle\frac{2r}{p+s}\text{.}",
    ],
  ),
  "D31DD01A-20D0-49DA-9EAD-E9571974B0DB": ProblemTranslation(
    category: 'Sequences',
    level: 'Easy',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the formula for sequences with given differences } b_n = a_{n+1} - a_n = 2n + 1.",
      r"\textbf{[Solution]}",
      r"\text{For } n \ge 2:",
      r"\begin{aligned} a_n = a_1 + \displaystyle \sum_{k=1}^{n-1} (2k + 1) = 1 + 2 \cdot \frac{(n-1)n}{2} + (n-1) = n^2 \end{aligned}",
      r"\text{For } n = 1:",
      r"a_1 = 1 = 1^2",
      r"\text{Thus, } a_n = n^2 \text{ for } n \ge 1.",
    ],
  ),
  "D8CA1CE8-6921-47E2-8A45-728DED579EB0": ProblemTranslation(
    category: 'Sequences',
    level: 'Easy',
    steps: [
      r"\textbf{[Solution]}",
      r"\text{For } n \ge 2:",
      r"a_n = S_n - S_{n-1}\text{, so}",
      r"\begin{aligned} a_n = (n^2 + 2n) - \{(n-1)^2 + 2(n-1)\} = 2n + 1 \end{aligned}",
      r"\text{For } n = 1:",
      r"a_1 = S_1 = 1^2 + 2(1) = 3 = 2(1) + 1\text{, which holds.}",
      r"Thus, $a_n = 2n + 1$ for $n \ge 1$.",
    ],
  ),
  "417F69AB-5A9E-4488-9692-AA67DE3BCFF2": ProblemTranslation(
    category: 'Sequences (3-term Recurrence)',
    level: 'Mid',
    steps: [
      r"""\textbf{[Strategy]}
\text{Solve the characteristic equation } r^2 + 3r - 4 = 0 \text{ to get roots } r_1,r_2\text{. Then write } a_n = A r_1^{n-1} + B r_2^{n-1}\text{ and determine }A,B\text{ from the initial conditions.}""",
      r"\textbf{[Solution]}",
      r"\text{Characteristic equation:}",
      r"""
      \begin{aligned}
      &\ \ \ \ \ r^2 + 3r - 4 = 0 \\
      &\Leftrightarrow (r - 1)(r + 4) = 0 \\
      &\Leftrightarrow r = 1 \text{ or } r = -4
      \end{aligned}
      """,
      r"\text{Therefore (by Proposition 1), the solution can be written as } a_n = A\cdot 1^{\,n-1} + B\cdot (-4)^{\,n-1}\text{.}",
      r"\text{(2) Determine }A,B\text{ from the initial conditions.}",
      r"\text{From } a_1=1,\ a_2=2\text{:}",
      r"""\begin{aligned}
      \begin{cases}
        1 = A + B \\
        2 = A - 4B
      \end{cases}
      \ \Rightarrow\
      \begin{cases}
        A = \displaystyle \frac{6}{5} \\[6pt]
        B = -\displaystyle \frac{1}{5}
      \end{cases}
      \end{aligned}""",
      r"\textcolor{green}{Therefore,\ } \textcolor{green}{a_n = \displaystyle \frac{6}{5} - \displaystyle \frac{1}{5}(-4)^{\,n-1}}",
      r"\textbf{[Proposition 1]}",
      r"\text{Given a recurrence } a_{n+2} + p a_{n+1} + q a_n = 0 \text{ with real initial values }a_1,a_2\text{,}",
      r"\text{if the characteristic equation } r^2 + p r + q = 0 \text{ has two distinct roots } r_1,r_2\text{, then the general term can be written using real constants }A,B\text{ as}",
      r"\textcolor{green}{a_n = A r_1^{\,n-1} + B r_2^{\,n-1}}\textcolor{green}{.}",
      r"\text{(Here, }A,B\text{ are determined by the initial conditions }a_1,a_2\text{.)}",
      r"""\textbf{[Proof]}
\text{Sketch: Using the root relations }r_1+r_2=-p,\ r_1r_2=q\text{, one can show}
\ a_{n+2}-r_1a_{n+1}=r_2(a_{n+1}-r_1a_n),\ 
\ a_{n+2}-r_2a_{n+1}=r_1(a_{n+1}-r_2a_n).
\text{Define }b_n=a_{n+1}-r_1a_n,\ c_n=a_{n+1}-r_2a_n\text{ to get geometric sequences, then solve for }a_n\text{ as a linear combination of }r_1^{n-1}, r_2^{n-1}.}""",
      r"\textbf{[Note]}",
      r"\text{If the characteristic equation has a double root }(r_1=r_2)\text{, this proposition does not apply; in that case one needs the double-root form } a_n=(A+Bn)r^{\,n-1}\text{.}",
    ],
  ),
  "E460F72E-E848-4B8F-B481-9D3E820FEBAE": ProblemTranslation(
    category: 'Sequences (3-term Recurrence)',
    level: 'Mid',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Solve the characteristic equation } r^2 - r - 6 = 0 \text{ to get roots } r_1,r_2\text{, then write } a_n = A r_1^{n-1} + B r_2^{n-1}\text{ and determine }A,B\text{ from }a_1,a_2\text{.}",
      r"\textbf{[Solution]}",
      r"\text{Characteristic equation:}",
      r"""
      \begin{aligned}
      &\ \ \ \ \ r^2 - r - 6 = 0 \\
      &\Leftrightarrow (r - 3)(r + 2) = 0 \\
      &\Leftrightarrow r = 3 \text{ or } r = -2
      \end{aligned}
      """,
      r"\text{Therefore (by Proposition 1), } a_n = A\cdot 3^{\,n-1} + B\cdot (-2)^{\,n-1}\text{.}",
      r"\text{(2) Determine }A,B\text{ from the initial conditions.}",
      r"\text{From } a_1=1,\ a_2=2\text{:}",
      r"""\begin{aligned}
      \begin{cases}
        1 = A + B \\
        2 = 3A - 2B
      \end{cases}
      \ \Rightarrow\
      \begin{cases}
        A = \displaystyle \frac{4}{5} \\[6pt]
        B = \displaystyle \frac{1}{5}
      \end{cases}
      \end{aligned}""",
      r"\textcolor{green}{Therefore,\ } \textcolor{green}{a_n = \displaystyle \frac{4}{5}\cdot 3^{\,n-1} + \displaystyle \frac{1}{5}(-2)^{\,n-1}}",
      r"\textbf{[Proposition 1]}",
      r"\text{Given a recurrence } a_{n+2} + p a_{n+1} + q a_n = 0 \text{ with real initial values }a_1,a_2\text{,}",
      r"\text{if the characteristic equation } r^2 + p r + q = 0 \text{ has two distinct roots } r_1,r_2\text{, then the general term can be written using real constants }A,B\text{ as}",
      r"\textcolor{green}{a_n = A r_1^{\,n-1} + B r_2^{\,n-1}}\textcolor{green}{.}",
      r"\text{(Here, }A,B\text{ are determined by the initial conditions }a_1,a_2\text{.)}",
      r"""\textbf{[Proof]}
\text{Sketch: Using the root relations }r_1+r_2=-p,\ r_1r_2=q\text{, define }b_n=a_{n+1}-r_1a_n,\ c_n=a_{n+1}-r_2a_n\text{. Then }b_n,c_n\text{ become geometric sequences, and }a_n\text{ can be solved as a linear combination of }r_1^{n-1},r_2^{n-1}.}""",
      r"\textbf{[Note]}",
      r"\text{If }r_1=r_2\text{ (double root), a different form } a_n=(A+Bn)r^{\,n-1}\text{ is needed.}",
    ],
  ),
  "73D06F52-2C0D-4118-84C6-662FAA49A553": ProblemTranslation(
    category: 'Sequences (3-term Recurrence)',
    level: 'Mid',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{The characteristic equation } r^2 - 4r + 4 = 0 \text{ has a double root } r=2\text{. Use the double-root form } a_n=(A+Bn)r^{\,n-1}\text{ and determine }A,B\text{.}",
      r"\textbf{[Solution]}",
      r"\text{Characteristic equation:}",
      r"""\begin{aligned}
    &\ \ \ \ \ r^2 - 4r + 4 = 0 \\
    &\Leftrightarrow (r - 2)^2 = 0 \\
    &\Leftrightarrow r = 2 \text{ (double root)}
    \end{aligned}""",
      r"\text{Therefore (by the double-root proposition), } a_n = (A + Bn)\cdot 2^{\,n-1}\text{.}",
      r"\text{(2) Determine }A,B\text{ from the initial conditions.}",
      r"\text{From } a_1=1,\ a_2=6\text{:}",
      r"""\begin{aligned}
    \begin{cases}
      1 = A + B \\
      6 = (A + 2B) \cdot 2
    \end{cases}
    \ \Rightarrow\
    \begin{cases}
      A = -1 \\
      B = 2
    \end{cases}
    \end{aligned}""",
      r"\textcolor{green}{Therefore,\ } \textcolor{green}{a_n = (-1 + 2n)\cdot 2^{\,n-1}}",
      r"\textbf{[Proposition (Double Root Case)]}",
      r"\text{Given } a_{n+2} + p a_{n+1} + q a_n = 0 \text{ with real }a_1,a_2\text{, if } r^2 + pr + q = 0 \text{ has a double root }r\text{,}",
      r"\text{then the general term can be written using real constants }A,B\text{ as}",
      r"\textcolor{green}{a_n = (A + Bn) r^{\,n-1}}\textcolor{green}{ for some real }A,B\text{.}",
      r"\text{(Here, }A,B\text{ are determined by the initial conditions.)}",
      r"""\textbf{[Proof]}
\text{Sketch: When the root is double, use the identity }a_{n+2}-ra_{n+1}=r(a_{n+1}-ra_n)\text{. Let }b_n=a_{n+1}-ra_n\text{ to obtain a geometric sequence for }b_n\text{. Then define }u_n=a_n/r^n\text{ so that }u_{n+1}-u_n \text{ is constant, hence }u_n \text{ is arithmetic. Converting back gives }a_n=(A+Bn)r^{n-1}.}""",
      r"\textbf{[Note]}",
      r"\text{If the roots are distinct }(r_1\neq r_2)\text{, the solution takes the form } a_n = A r_1^{n-1} + B r_2^{n-1}\text{ instead.}",
    ],
  ),
  "37B80E92-3E58-4BAF-A56B-7425004B28E0": ProblemTranslation(
    category: 'Sequences (Simultaneous Recurrence)',
    level: 'Advanced',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Eliminate } b_n \text{ from the simultaneous recurrence to obtain a 3-term recurrence for } a_n\text{. Then solve the characteristic equation and write } a_n = A r_1^{n-1} + B r_2^{n-1}\text{.}",
      r"\textbf{[Solution]}",
      r"\text{(1) From the 1st equation, } b_n = a_{n+1} - 4a_n\text{. Replacing }n\text{ by }n+1\text{ also gives } b_{n+1} = a_{n+2} - 4a_{n+1}\text{. Substitute these into the 2nd equation:}",
      r"""\begin{aligned}
    &\ \ \ \ \ b_{n+1} = -2a_n + b_n \\
    &\Leftrightarrow a_{n+2} - 4a_{n+1} = -2a_n + (a_{n+1} - 4a_n) \\
    &\Leftrightarrow a_{n+2} - 5a_{n+1} + 6a_n = 0
    \end{aligned}""",
      r"\text{Now we have reduced it to a 3-term recurrence for }a_n\text{.}",
      r"\text{Characteristic equation:}",
      r"""\begin{aligned}
    &\ \ \ \ r^2 -5r +6 = 0 \\
    &\Leftrightarrow r = 2,\ 3
    \end{aligned}""",
      r"\text{Therefore (by Proposition 1), the solution can be written as } a_n = A\cdot 2^{\,n-1} + B\cdot 3^{\,n-1}\text{.}",
      r"\text{(2) Determine }A,B\text{ from the initial conditions.}",
      r"\text{From } a_1=2,\ b_1=1\text{, we have } a_2 = 4a_1 + b_1 = 9\text{.}",
      r"\text{Hence}",
      r"""\begin{aligned}
    \begin{cases}
      2 = A + B \\
      9 = 2A + 3B
    \end{cases}
    \ \Rightarrow\
    \begin{cases}
      A = -3 \\
      B = 5
    \end{cases}
    \end{aligned}""",
      r"\textcolor{green}{Therefore,\ } \textcolor{green}{ a_n = -3\cdot 2^{\,n-1} + 5\cdot 3^{\,n-1}}",
      r"\text{(3) Find } b_n \text{ explicitly (from the 1st equation).}",
      r"\text{From } a_{n+1}=4a_n+b_n\text{, we have } b_n = a_{n+1}-4a_n\text{. Using } a_n = -3\cdot 2^{n-1} + 5\cdot 3^{n-1}\text{,}",
      r"""\begin{aligned}
b_n
&= \bigl(-3\cdot 2^{n} + 5\cdot 3^{n}\bigr)
   -4\bigl(-3\cdot 2^{n-1} + 5\cdot 3^{n-1}\bigr)\\[6pt]
&= -3\cdot 2^{n} + 5\cdot 3^{n} + 12\cdot 2^{n-1} -20\cdot 3^{n-1}\\[6pt]
&= \textcolor{green}{6\cdot 2^{\,n-1} -5\cdot 3^{\,n-1}}
\end{aligned}""",
      r"\textbf{[Proposition 1]}",
      r"\text{Assume the recurrence } a_{n+2} + p a_{n+1} + q a_n = 0 \text{ with real initial values }a_1,a_2\text{ is given.}",
      r"\text{If the characteristic equation } r^2 + p r + q = 0 \text{ has two distinct roots } r_1,r_2\text{, then the general term }a_n\text{ can be written using real constants }A,B\text{ as}",
      r"\textcolor{green}{a_n = A r_1^{\,n-1} + B r_2^{\,n-1}}\textcolor{green}{.}",
      r"\text{(Here, }A,B\text{ are determined by the initial conditions }a_1,a_2\text{.)}",
      r"""\textbf{[Proof]}
\text{(Outline)}\ 
\text{Using the root relations }r_1+r_2=-p,\ r_1r_2=q\text{, one can derive}
\ a_{n+2}-r_1a_{n+1}=r_2(a_{n+1}-r_1a_n),\ 
\ a_{n+2}-r_2a_{n+1}=r_1(a_{n+1}-r_2a_n).
\text{Let }b_n=a_{n+1}-r_1a_n,\ c_n=a_{n+1}-r_2a_n\text{. Then }b_n,c_n\text{ are geometric sequences, and solving back yields }a_n=A r_1^{n-1}+B r_2^{n-1}.}""",
      r"\textbf{[Note]}",
      r"\text{If }r_1=r_2\text{ (double root), this argument does not apply; a separate double-root form } a_n=(A+Bn)r^{\,n-1} \text{ is needed.}",
    ],
  ),
  "863C1DB8-6D69-4926-93D3-24FE77194C4D": ProblemTranslation(
    category: 'Sequences (Simultaneous Recurrence)',
    level: 'Advanced',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Eliminate one variable to reduce the system to a 3-term recurrence for }a_n\text{. The characteristic equation will have a double root }r=5\text{, so use the double-root form to find }a_n\text{.}",
      r"\textbf{[Solution]}",
      r"\text{(1) From the 1st equation, } b_n = a_{n+1} - 6a_n\text{. Replacing }n\text{ by }n+1\text{ gives } b_{n+1} = a_{n+2} - 6a_{n+1}\text{. Substitute into the 2nd equation:}",
      r"""\begin{aligned}
&\ \ \ \ \ b_{n+1} = -a_n + 4b_n \\
&\Leftrightarrow a_{n+2} - 6a_{n+1} = -a_n + 4(a_{n+1}-6a_n) \\
&\Leftrightarrow a_{n+2} -10 a_{n+1} +25 a_n = 0
\end{aligned}""",
      r"\text{Now we have reduced it to a 3-term recurrence for }a_n\text{.}",
      r"\text{Characteristic equation:}",
      r"""\begin{aligned}
    &\ \ \ \ \ r^2 - 10 r + 25 = 0 \\
    &\Leftrightarrow (r-5)^2 = 0 \\
    &\Leftrightarrow r = 5
    \end{aligned}""",
      r"\text{Therefore (by the double-root proposition), } a_n = (A + Bn)\cdot 5^{\,n-1}\text{.}",
      r"\text{(2) Determine }A,B\text{ from the initial conditions.}",
      r"\text{From } a_1=1,\ b_1=2\text{, we have } a_2 = 6a_1 + b_1 = 8\text{.}",
      r"\text{Hence}",
      r"""\begin{aligned}
    \begin{cases}
      1 = A + B \\
      8 = (A + 2B) \cdot 5
    \end{cases}
    \ \Rightarrow\
    \begin{cases}
      A = \displaystyle \frac{2}{5} \\[6pt]
      B = \displaystyle \frac{3}{5}
    \end{cases}
    \end{aligned}""",
      r"\textcolor{green}{Therefore,\ } \textcolor{green}{ a_n = \left(\displaystyle \frac{2}{5} + \displaystyle \frac{3}{5}n\right)5^{\,n-1} = (2+3n)5^{\,n-2}}",
      r"\text{(3) Find } b_n \text{ explicitly (from the 1st equation).}",
      r"\text{From } a_{n+1}=6a_n+b_n\text{, we have } b_n=a_{n+1}-6a_n\text{. Using } a_n=(2+3n)5^{\,n-2}\text{,}",
      r"""\begin{aligned}
b_n
&= \bigl((2+3(n+1))5^{\,n-1}\bigr)
   -6\bigl((2+3n)5^{\,n-2}\bigr)\\[6pt]
&= (5+3n)5^{\,n-1} - (12+18n)5^{\,n-2}\\[6pt]
&= (5+3n)\cdot 5\cdot 5^{\,n-2} - (12+18n)5^{\,n-2}\\[6pt]
&= (25+15n)5^{\,n-2} - (12+18n)5^{\,n-2}\\[6pt]
&= \textcolor{green}{(13 - 3n)5^{\,n-2}}
\end{aligned}""",
      r"\textbf{[Supplement: Double Root Proposition]}",
      r"\text{Given a recurrence } a_{n+2}+p a_{n+1}+q a_n=0 \text{ with real initial values }a_1,a_2\text{,}",
      r"\text{if the characteristic equation } r^2+pr+q=0 \text{ has a double root }r\text{, then the general term }a_n\text{ can be written using real constants }A,B\text{ as}",
      r"\textcolor{green}{a_n = (A + Bn) r^{\,n-1}}\textcolor{green}{.}",
      r"\text{(Here, }A,B\text{ are determined by the initial conditions.)}",
      r"""\textbf{[Proof]}
\text{(Outline)}\ 
\text{When the characteristic equation has a double root }r\text{, one can show }a_{n+2}-r a_{n+1}=r(a_{n+1}-r a_n).
\text{Let }b_n=a_{n+1}-r a_n\text{ to obtain }b_{n+1}=r b_n\text{ (geometric). Then set }u_n=a_n/r^n\text{ to get }u_{n+1}-u_n=\text{const}, \text{ hence }u_n\text{ is arithmetic. Converting back yields }a_n=(A+Bn)r^{n-1}.}""",
      r"\textbf{[Note]}",
      r"\text{The argument assumes }r\neq 0\text{. Here }r=5\neq 0\text{, so there is no issue.}",
    ],
  ),
  "48F0A009-A401-42C4-9AC5-E84555D43257": ProblemTranslation(
    category: 'Sequences',
    level: 'Mid',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Divide both sides by }(n+1)\text{ to express }a_n\text{ in terms of }a_{n-1}\text{, then repeatedly substitute to form a telescoping product.}",
      r"\textbf{[Solution]}",
      r"\text{(1) Rearrange the recurrence.}",
      r"""\begin{aligned}
a_n &= \frac{n-1}{n+1}a_{n-1} \quad (n\ge2)
\end{aligned}""",
      r"\text{(2) Repeat substitution (product form).}",
      r"""\begin{aligned}
a_n &= \frac{n-1}{n+1}a_{n-1} \\
&= \frac{n-1}{n+1}\cdot \frac{n-2}{n}a_{n-2} \\
&= \frac{n-1}{n+1}\cdot \frac{n-2}{n}\cdot \frac{n-3}{n-1}\cdots \frac{2}{4}\cdot \frac{1}{3}a_1 \\
&= \frac{1\cdot 2}{n(n+1)}a_1
\end{aligned}""",
      r"\text{Using }a_1=2\text{, we get } a_n = \dfrac{4}{n(n+1)}\text{.}",
      r"\text{This formula also holds for }n=1\text{.}",
      r"\textbf{[Supplement (Wallis integrals)]}",
      r"\text{This recurrence is similar to the one appearing in the evaluation of } I_n=\displaystyle\int_0^{\pi/2}\sin^n x\,dx \text{ (or } \int_0^{\pi/2}\cos^n x\,dx\text{), called the Wallis integrals, which satisfy } I_n=\dfrac{n-1}{n}I_{n-2}\text{.}",
      r"\textbf{[Derivation (Supplement)]}",
      r"\text{For } I_n=\displaystyle\int_0^{\pi/2}\sin^n x\,dx \text{ (or } \int_0^{\pi/2}\cos^n x\,dx\text{), derive the recurrence using integration by parts. For } n\ge 2\text{, in the case } I_n=\displaystyle\int_0^{\pi/2}\sin^n x\,dx\text{:}",
      r"""\begin{aligned}
    I_n &= \displaystyle \int_0^{\frac{\pi}{2}} \sin^n x \, dx \\
    &= \displaystyle \int_0^{\frac{\pi}{2}} \sin^{n-1} x \cdot \sin x \, dx \\
    &= \displaystyle \int_0^{\frac{\pi}{2}} \sin^{n-1} x \cdot (-\cos x)' \, dx \\
    &= \left[ -\sin^{n-1} x \cos x \right]_0^{\frac{\pi}{2}} + (n-1) \displaystyle \int_0^{\frac{\pi}{2}} \sin^{n-2} x \cdot \cos^2 x \, dx \\    
    &= (n-1) \left( \displaystyle \int_0^{\frac{\pi}{2}} \sin^{n-2} x \, dx - \displaystyle \int_0^{\frac{\pi}{2}} \sin^n x \, dx \right) \\
    &= (n-1)(I_{n-2} - I_n)
    \end{aligned}""",
      r"\text{Rearranging,}",
      r"""\begin{aligned}
    &\ \ \ \ \ I_n = (n-1)(I_{n-2} - I_n) \\
    &\Leftrightarrow nI_n = (n-1)I_{n-2}
    \end{aligned}""",
      r"\text{Similarly, for } I_n=\displaystyle\int_0^{\pi/2}\cos^n x\,dx\text{, using the substitution }x=\frac{\pi}{2}-t\text{,}",
      r"""\begin{aligned}
    I_n &= \displaystyle \int_0^{\frac{\pi}{2}} \cos^n x \, dx \\
    &= \displaystyle \int_{\frac{\pi}{2}}^{0} \cos^n \left(\frac{\pi}{2} - t\right) \, (-dt) \\
    &= \displaystyle \int_0^{\frac{\pi}{2}} \sin^n t \, dt \\
    &= \displaystyle \int_0^{\frac{\pi}{2}} \sin^n x \, dx
    \end{aligned}""",
      r"\text{Thus, the } \cos^n x \text{ integral satisfies the same recurrence } I_n=\dfrac{n-1}{n}I_{n-2}\text{.}",
    ],
  ),
  "43D15683-AB09-49EE-8412-0CCB4D260EAF": ProblemTranslation(
    category: 'Recurrence Relations (Variable Coefficients)',
    level: 'Advanced',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Since the right-hand side is a constant, find a particular solution as a constant sequence }A\text{, then reduce it to a variable-coefficient homogeneous recurrence.}",
      r"\textbf{[Solution]}",
      r"\text{Assume a constant solution }A\text{ and substitute into the recurrence: } (n+2)A = nA + 4\text{.}",
      r"""\begin{aligned}
    &\ \ \ \ \ (n+2)A = nA + 4 \\
    &\Leftrightarrow nA + 2A = nA + 4 \\
    &\Leftrightarrow 2A = 4 \\
    &\Leftrightarrow A = 2
    \end{aligned}""",
      r"\text{Substituting the constant solution }A=2\text{ back into the recurrence gives } (n+2)\cdot 2 = n\cdot 2 + 4 \cdots (1)\text{.}",
      r"\text{Subtracting (1) from the original recurrence and defining a new sequence } b_n = a_n - 2\text{, we obtain:}",
      r"""
      \begin{aligned}
      (n+2)a_n &= n a_{n-1} + 4 \\
      (n+2) \cdot 2 &= n \cdot 2 + 4 \\
      \hline
      \ \ \ \ \ (n+2)(a_n - 2) &= n(a_{n-1} - 2) \\
      \end{aligned}
      """,
      r"\text{Let } b_n = a_n - 2\text{. Then}",
      r"\text{ } b_1 = a_1 - 2 = 1 - 2 = -1\text{, so}",
      r"""\begin{aligned}
    \begin{cases}
    \ (n+2)b_n = n b_{n-1} \\
    \ b_1 = -1
    \end{cases}
    \end{aligned}""",
      r"\text{(2) Rewrite the recurrence.}",
      r"""\begin{aligned}
    b_n &= \frac{n}{n+2}b_{n-1} \quad (n\ge2)
    \end{aligned}""",
      r"\text{(3) Repeat substitution (product form).}",
      r"""\begin{aligned}
    b_n &= \frac{n}{n+2}b_{n-1} \\
    &= \frac{n}{n+2} \cdot \frac{n-1}{n+1}b_{n-2} \\
    &= \frac{n}{n+2} \cdot \frac{n-1}{n+1} \cdot \frac{n-2}{n}b_{n-3} \\
    &= \frac{n}{n+2} \cdot \frac{n-1}{n+1} \cdot \frac{n-2}{n} \cdot \frac{n-3}{n-1}b_{n-4} \\
    &\cdots \\
    &= \frac{n}{n+2} \cdot \frac{n-1}{n+1} \cdot \frac{n-2}{n} \cdot \frac{n-3}{n-1} \cdots \frac{3}{5} \cdot \frac{2}{4}  b_1\\
    \end{aligned}""",
      r"Since }b_1=-1\text{,}",
      r"""\begin{aligned}
    &= \frac{\cancel{n}}{n+2} \cdot \frac{\cancel{n-1}}{n+1} \cdot \frac{\cancel{n-2}}{\cancel{n}} \cdot \frac{\cancel{n-3}}{\cancel{n-1}} \cdots \frac{{3}}{\cancel{5}} \cdot \frac{{2}}{\cancel{4}} \cdot (-1)\\

    &= -\frac{6}{(n+1)(n+2)}
    \end{aligned}""",
      r"\text{Therefore, } b_n = -\displaystyle \frac{6}{(n+1)(n+2)}\text{, so}",
      r"""\begin{aligned}
    a_n &= b_n + 2 = \displaystyle -\frac{6}{(n+1)(n+2)} + 2
    \end{aligned}""",
      r"\text{This formula also holds for }n=1\text{.}",
    ],
  ),
  "5AE63216-BADE-46E5-A90B-18933C16F2FE": ProblemTranslation(
    category: 'Nonlinear Recurrence (Roots)',
    level: 'Mid',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Take the logarithm.}",
      r"\textbf{[Solution]}",
      r"\text{Taking base-2 logarithms on both sides:}",
      r"\log_2(a_n) = \log_2(4\sqrt{a_{n-1}}) = \log_2 4 + \frac{1}{2}\log_2 a_{n-1} = 2 + \frac{1}{2}\log_2 a_{n-1}",
      r"x_n:=\log_2 a_n\text{. Then}",
      r"\text{This is a first-order linear recurrence } x_n = \frac{1}{2}x_{n-1} + 2\text{. The fixed point satisfies } \alpha = \frac{1}{2}\alpha + 2\text{, so } \alpha = 4\text{. Hence,}",
      r"""\begin{aligned}
x_n - 4 &= \frac{1}{2}\left(x_{n-1} - 4\right) \\
&= \left(\frac{1}{2}\right)^{n-1}\left(x_1 - 4\right) \\
&= \left(\frac{1}{2}\right)^{n-1}\left(\log_2 8 - 4\right) \\
&= \left(\frac{1}{2}\right)^{n-1}(3 - 4) \\
&= -\left(\frac{1}{2}\right)^{n-1}
\end{aligned}""",
      r"\text{Therefore, } x_n = 4 - \left(\frac{1}{2}\right)^{n-1}\text{.}",
      r"2^{x_n}= a_n\text{, so converting back,}",
      r"""\begin{aligned}
a_n &= 2^{x_n} = 2^{4 - (\frac{1}{2})^{n-1}} = 16 \cdot 2^{-(\frac{1}{2})^{n-1}}
\end{aligned}""",
    ],
  ),
  "AB08A968-36A0-40E9-B392-651BAE535DA9": ProblemTranslation(
    category: 'Nonlinear Recurrence (Powers)',
    level: 'Advanced',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Take the logarithm.}",
      r"\textbf{[Solution]}",
      r"\text{Taking base-2 logarithms on both sides:}",
      r"\log_2(a_n) = \log_2 \left(\frac {1}{2}(a_{n-1})^2\right) = -1 + 2\log_2(a_{n-1})",
      r"x_n:=\log_2 a_n\text{. Then}",
      r"\text{This is a first-order linear recurrence } x_n = - 1 + 2x_{n-1}\text{. The fixed point satisfies } \alpha = 2\alpha - 1\text{, so } \alpha = 1\text{. Hence,}",
      r"""\begin{aligned}
x_n - 1 &= 2\left(x_{n-1} - 1\right) \\
&= 2^{n-1}\left(x_1 - 1\right) \\
&= 2^{n-1}\left(\log_2 5 - 1\right)
\end{aligned}""",
      r"\text{Therefore,}",
      r"""\begin{aligned}
x_n &= 2^{n-1}\log_2 5 - 2^{n-1} + 1 \\
&= 2^{n-1}\log_2 5 + 1 - 2^{n-1}
\end{aligned}""",
      r"2^{x_n}= a_n\text{, so converting back,}",
      r"""\begin{aligned}
a_n &= 2^{x_n} = 2^{2^{n-1}\log_2 5 + 1 - 2^{n-1}} \\
&= 2^{2^{n-1}\log_2 5} \cdot 2^{1 - 2^{n-1}} \\
&= \left(2^{\log_2 5}\right)^{2^{n-1}} \cdot 2 \cdot 2^{-2^{n-1}} \\
&= 5^{2^{n-1}} \cdot 2 \cdot 2^{-2^{n-1}} \\
&= 2 \cdot \frac{5^{2^{n-1}}}{2^{2^{n-1}}} \\
&= 2 \cdot \left(\frac{5}{2}\right)^{2^{n-1}}
\end{aligned}""",
      r"\text{For example, when } n = 4\text{:}",
      r"""\begin{aligned}
a_4 &= 2 \cdot \left(\frac{5}{2}\right)^{2^{3}} = 2 \cdot \left(\frac{5}{2}\right)^{8}\\[5pt]
&= 2 \cdot \frac{5^8}{2^8} = 2 \cdot \frac{390625}{256} = \frac{390625}{128} \approx 3051.76
\end{aligned}""",
    ],
  ),
};




