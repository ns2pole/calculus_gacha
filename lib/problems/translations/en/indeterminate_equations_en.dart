import '../../../models/problem_translation.dart';

final Map<String, ProblemTranslation> indeterminateEquationsTranslationsEn = {
  "DB513B4F-55DC-4AB9-87B7-1BCF5F47DC6A": ProblemTranslation(
    category: 'Indeterminate Equations',
    level: 'Easy',
    answer: r"""x = 5k + 4,\ y = -3k - 2 \quad (k \in \mathbb{Z})""",
    steps: [
      r"\textbf{[Solution]}",
      r"\text{A particular solution to } 3x + 5y = 2 \text{ is found to be } x = 4, y = -2.",
      r"\text{Thus, } 3 \cdot 4 + 5 \cdot (-2) = 2.",
      r"\text{Subtracting this from the original equation:}",
      r"\begin{aligned} 3x + 5y &= 2 \\ 3 \cdot 4 + 5 \cdot (-2) &= 2 \\ \hline 3(x - 4) + 5(y + 2) &= 0 \end{aligned}",
      r"\text{Since 3 and 5 are coprime, there exists an integer } k \text{ such that } x - 4 = 5k \text{ and } y + 2 = -3k. \text{ Thus,}",
      r"\begin{aligned} \begin{cases} x - 4 = 5k \\ y + 2 = -3k \end{cases} \Leftrightarrow \begin{cases} x = 5k + 4 \\ y = -3k - 2 \end{cases} \end{aligned} \quad (k \in \mathbb{Z})",
    ],
  ),
  "E2B55755-0658-4FBE-911F-C18148799924": ProblemTranslation(
    category: 'Indeterminate Equations',
    level: 'Easy',
    answer: r"""x = 7k + 2,\ y = 4k + 1 \quad (k \in \mathbb{Z})""",
    steps: [
      r"\textbf{[Solution]}",
      r"\text{A particular solution to } 4x - 7y = 1 \text{ is found to be } x = 2, y = 1.",
      r"\text{Thus, } 4 \cdot 2 - 7 \cdot 1 = 1.",
      r"\text{Subtracting this from the original equation:}",
      r"\begin{aligned} 4x - 7y &= 1 \\ 4 \cdot 2 - 7 \cdot 1 &= 1 \\ \hline 4(x - 2) - 7(y - 1) &= 0 \end{aligned}",
      r"\text{Since 4 and 7 are coprime, there exists an integer } k \text{ such that } x - 2 = 7k \text{ and } y - 1 = 4k. \text{ Thus,}",
      r"\begin{aligned} \begin{cases} x - 2 = 7k \\ y - 1 = 4k \end{cases} \Leftrightarrow \begin{cases} x = 7k + 2 \\ y = 4k + 1 \end{cases} \end{aligned} \quad (k \in \mathbb{Z})",
    ],
  ),
  "4F6568BE-B67F-46E7-859C-F22766018567": ProblemTranslation(
    category: 'Indeterminate Equations',
    level: 'Mid',
    answer: r"""x = 69 + 287k,\ y = -94 - 391k \quad (k \in \mathbb{Z})""",
    hint: r"\text{Use the Euclidean algorithm to find one particular solution to } 391x + 287y = 1.",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the Euclidean algorithm to find one particular solution to } 391x + 287y = 1.",
      r"\textbf{[Solution]}",
      r"\text{By the Euclidean algorithm:}",
      r"\begin{aligned} 391 &= 287 \cdot 1 + 104 \\ 287 &= 104 \cdot 2 + 79 \\ 104 &= 79 \cdot 1 + 25 \\ 79 &= 25 \cdot 3 + 4 \\ 25 &= 4 \cdot 6 + 1 \\ 4 &= 1 \cdot 4 + 0 \end{aligned}",
      r"\text{Working backwards:}",
      r"\begin{aligned} 1 &= 25 - 4 \cdot 6 \\ &= 25 - (79 - 25 \cdot 3) \cdot 6 \\ &= 25 \cdot 19 - 79 \cdot 6 \\ &= (104 - 79) \cdot 19 - 79 \cdot 6 \\ &= 104 \cdot 19 - 79 \cdot 25 \\ &= 104 \cdot 19 - (287 - 104 \cdot 2) \cdot 25 \\ &= 104 \cdot 69 - 287 \cdot 25 \\ &= (391 - 287) \cdot 69 - 287 \cdot 25 \\ &= 391 \cdot 69 - 287 \cdot 94 \end{aligned}",
      r"\text{Thus, } 391 \cdot 69 + 287 \cdot (-94) = 1.",
      r"\text{So one particular solution is } (x_0, y_0) = (69, -94).",
      r"\text{Therefore } 391 \cdot 69 + 287 \cdot (-94) = 1.",
      r"\text{Subtracting } 391 \cdot 69 + 287 \cdot (-94) = 1 \text{ from the original equation:}",
      r"\begin{aligned} 391x + 287y &= 1 \\ 391 \cdot 69 + 287 \cdot (-94) &= 1 \\ \hline 391(x - 69) + 287(y + 94) &= 0 \end{aligned}",
      r"\text{Since 391 and 287 are coprime, there exists an integer } k \text{ such that } x - 69 = 287k \text{ and } y + 94 = -391k. \text{ Thus,}",
      r"\begin{aligned} \begin{cases} x - 69 = 287k \\ y + 94 = -391k \end{cases} \Leftrightarrow \begin{cases} x = 287k + 69 \\ y = -391k - 94 \end{cases} \end{aligned} \quad (k \in \mathbb{Z})",
    ],
  ),
  "16F18597-C6FC-4AE9-B600-B230BB5F5405": ProblemTranslation(
    category: 'Indeterminate Equations',
    level: 'Mid',
    answer: r"""x = -97 + 495k,\ y = 165 - 842k \quad (k \in \mathbb{Z})""",
    hint: r"\text{Use the Euclidean algorithm to find one particular solution to } 842x + 495y = 1.",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the Euclidean algorithm to find one particular solution to } 842x + 495y = 1.",
      r"\textbf{[Solution]}",
      r"\text{By the Euclidean algorithm:}",
      r"\begin{aligned} 842 &= 495 \cdot 1 + 347 \\ 495 &= 347 \cdot 1 + 148 \\ 347 &= 148 \cdot 2 + 51 \\ 148 &= 51 \cdot 2 + 46 \\ 51 &= 46 \cdot 1 + 5 \\ 46 &= 5 \cdot 9 + 1 \\ 5 &= 1 \cdot 5 + 0 \end{aligned}",
      r"\text{Working backwards:}",
      r"\begin{aligned} 1 &= 46 - 5 \cdot 9 \\ &= 46 - (51 - 46) \cdot 9 \\ &= 46 \cdot 10 - 51 \cdot 9 \\ &= (148 - 51 \cdot 2) \cdot 10 - 51 \cdot 9 \\ &= 148 \cdot 10 - 51 \cdot 29 \\ &= 148 \cdot 10 - (347 - 148 \cdot 2) \cdot 29 \\ &= 148 \cdot 68 - 347 \cdot 29 \\ &= (495 - 347) \cdot 68 - 347 \cdot 29 \\ &= 495 \cdot 68 - 347 \cdot 97 \\ &= 495 \cdot 68 - (842 - 495) \cdot 97 \\ &= 842 \cdot (-97) + 495 \cdot 165 \end{aligned}",
      r"\text{Thus, } 842 \cdot (-97) + 495 \cdot 165 = 1.",
      r"\text{So one particular solution is } (x_0, y_0) = (-97, 165).",
      r"\text{Therefore } 842 \cdot (-97) + 495 \cdot 165 = 1.",
      r"\text{Subtracting } 842 \cdot (-97) + 495 \cdot 165 = 1 \text{ from the original equation:}",
      r"\begin{aligned} 842x + 495y &= 1 \\ 842 \cdot (-97) + 495 \cdot 165 &= 1 \\ \hline 842(x + 97) + 495(y - 165) &= 0 \end{aligned}",
      r"\text{Since 842 and 495 are coprime, there exists an integer } k \text{ such that } x + 97 = 495k \text{ and } y - 165 = -842k. \text{ Thus,}",
      r"\begin{aligned} \begin{cases} x + 97 = 495k \\ y - 165 = -842k \end{cases} \Leftrightarrow \begin{cases} x = 495k - 97 \\ y = -842k + 165 \end{cases} \end{aligned} \quad (k \in \mathbb{Z})",
    ],
  ),

  // (reserve / commented-out in source) Quadratic form
  "1DBC903A-5066-44C5-B5D7-46E94C864775": ProblemTranslation(
    category: 'Quadratic Forms',
    level: 'Mid',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Complete the square.}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} x^2+2xy+3y^2=(x+y)^2+2y^2. \end{aligned}",
      r"\text{From }(x+y)^2=27-2y^2\text{, we need }27-2y^2\ge 0\Rightarrow |y|\le 3\text{.}",
      r"\text{Since }(x+y)^2\text{ is a perfect square, }y=0,\pm2\text{ do not give solutions here. Check the remaining cases:}",
      r"\textcolor{blue}{Case:\  }y=1\text{: }(x+1)^2=25\Rightarrow x=4\text{ or }x=-6\text{.}",
      r"\textcolor{blue}{Case:\  }y=-1\text{: }(x-1)^2=25\Rightarrow x=6\text{ or }x=-4\text{.}",
      r"\textcolor{blue}{Case:\  }y=3\text{: }(x+3)^2=9\Rightarrow x=0\text{ or }x=-6\text{.}",
      r"\textcolor{blue}{Case:\  }y=-3\text{: }(x-3)^2=9\Rightarrow x=6\text{ or }x=0\text{.}",
      r"\text{Therefore, the integer solutions are }(x,y)=(4,1),(-6,1),(6,-1),(-4,-1),(0,3),(-6,3),(6,-3),(0,-3)\text{.}",
    ],
  ),
  "00E2A046-7CC1-48D5-ADCB-A48C3F5A250B": ProblemTranslation(
    category: 'Quadratic Homogeneous Equations',
    level: 'Mid',
    answer: r"""\{(x,y)=(1,2),(-3,2),(3,-2),(-1,-2)\}""",
    hint: r"\text{Complete the square avoiding fractions.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Complete the square avoiding fractions.}",
      r"\textbf{[Solution]}",
      r"\text{Multiplying both sides by 4:}",
      r"\begin{aligned} 4x^2+4xy+8y^2 &= 44 \\ \Leftrightarrow (2x+y)^2+7y^2 &= 44 \end{aligned}",
      r"(2x+y)^2 = 44 - 7y^2. \text{ Since } (2x+y)^2 \ge 0, 44-7y^2 \ge 0 \Rightarrow |y| \le 2.",
      r"\text{Note: } (2x+y)^2 \text{ must be a square number. Check } y = \pm 2. \text{ (For } y=0, 44-0=44; \text{ for } y=1, 44-7=37; \text{ neither are square numbers.)}",
      r"\textcolor{blue}{Case:\  } \textcolor{blue}{y\ =\ 2}",
      r"(2x+2)^2 = 44 - 28 = 16 \Rightarrow 2x+2 = \pm 4.",
      r"\begin{aligned} \begin{cases} 2x+2=4 \Leftrightarrow \textcolor{green}{x=1} \\ 2x+2=-4 \Leftrightarrow \textcolor{green}{x=-3} \end{cases} \end{aligned}",
      r"\textcolor{blue}{Case:\  } \textcolor{blue}{y\ =\ -2}",
      r"(2x-2)^2 = 44 - 28 = 16 \Rightarrow 2x-2 = \pm 4.",
      r"\begin{aligned} \begin{cases} 2x-2=4 \Leftrightarrow \textcolor{green}{x=3} \\ 2x-2=-4 \Leftrightarrow \textcolor{green}{x=-1} \end{cases} \end{aligned}",
      r"\text{Therefore, the solutions are } (x,y)=(1,2),(-3,2),(3,-2),(-1,-2).",
    ],
  ),
  "EBA0562C-23C6-4DE1-95C1-94FB618E1073": ProblemTranslation(
    category: 'Indeterminate Equations',
    level: 'Easy',
    answer: r"""\{(x,y)=(9,6), (17,-2), (7,-12), (-1,-4), (11, 0), (5,-6)\} \quad \text{(6 solutions)}""",
    hint: r"\text{Use factorization into linear factors.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use factorization into linear factors.}",
      r"\textbf{[Solution]}",
      r"\text{Using the identity } xy+3x-8y = (x-8)(y+3)+24:",
      r"\begin{aligned} xy+3x-8y &= 33 \\ \Leftrightarrow (x-8)(y+3)+24 &= 33 \\ \Leftrightarrow (x-8)(y+3) &= 9 \end{aligned}",
      r"\text{Considering integer factor pairs of 9:}",
      r"\begin{aligned} (x-8,y+3) &= (1,9),(9,1),(-1,-9),(-9,-1),(3,3),(-3,-3)\\ \Leftrightarrow (x,y) &= (9,6), (17,-2), (7,-12), (-1,-4), (11, 0), (5,-6) \end{aligned}",
    ],
  ),
  "AA271833-9840-40EE-924F-1D94AD63FEB6": ProblemTranslation(
    category: 'Indeterminate Equations',
    level: 'Easy',
    answer: r"""\{(x,y)=(2,9),(8,3),(0,-5),(-6,1)\} \quad \text{(4 solutions)}""",
    hint: r"\text{Use factorization into linear factors.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use factorization into linear factors.}",
      r"\textbf{[Solution]}",
      r"\text{Using the identity } xy-2x-y = (x-1)(y-2)-2:",
      r"\begin{aligned} xy-2x-y &= 5 \\ \Leftrightarrow (x-1)(y-2)-2 &= 5 \\ \Leftrightarrow (x-1)(y-2) &= 7 \end{aligned}",
      r"\text{Considering integer factor pairs of 7:}",
      r"\begin{aligned} (x-1,y-2) &= (1,7),(7,1),(-1,-7),(-7,-1)\\ \Leftrightarrow (x,y) &= (2,9), (8,3), (0,-5), (-6,1) \end{aligned}",
    ],
  ),
  "70FFD2EF-5335-4593-86B4-0060A4295D31": ProblemTranslation(
    category: 'Rational Equations \(\to\) Indeterminate Equations',
    level: 'Easy',
    answer: r"""(8,56),(14,14),(56,8),(6,-42),(-42,6) \quad \text{(5 solutions)}""",
    hint: r"\text{Find a common denominator and factor into linear expressions. Note that } x \neq 0 \text{ and } y \neq 0.",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Find a common denominator and factor into linear expressions. Note that } x \neq 0 \text{ and } y \neq 0.",
      r"\textbf{[Solution]}",
      r"\begin{aligned} \frac{1}{x} + \frac{1}{y} &= \frac{1}{7} \\ \Leftrightarrow \frac{x+y}{xy} &= \frac{1}{7} \quad \text{and } x,y \neq 0 \\ \Leftrightarrow 7(x+y) &= xy \quad \text{and } x,y \neq 0 \\ \Leftrightarrow xy-7x-7y &= 0 \quad \text{and } x,y \neq 0 \end{aligned}",
      r"\text{Using the identity } xy-7x-7y = (x-7)(y-7)-49:",
      r"\begin{aligned} \Leftrightarrow (x-7)(y-7)-49 = 0 \quad \text{and } x,y \neq 0 \\ \Leftrightarrow (x-7)(y-7) = 49 \quad \text{and } x,y \neq 0 \end{aligned}",
      r"\text{Considering factor pairs of 49 while keeping } x \neq 0, y \neq 0 \text{ in mind:}",
      r"\begin{aligned} (x-7,y-7) &= (1,49),(49,1),(-1,-49),(-49,-1),(-7,-7)\\ \Leftrightarrow (x,y) &= (8,56), (56,8), (6,-42), (-42,6), (14,14) \end{aligned}",
    ],
  ),
  "5B9CCE39-6329-4F9D-8E86-20D97B7760A2": ProblemTranslation(
    category: 'Factorization of Quadratic Expressions',
    level: 'Easy',
    answer: r"""(3,2),(3,-2),(-3,2),(-3,-2) \quad \text{(4 solutions)}""",
    hint: r"\text{Factor the left side.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Factor the left side.}",
      r"\textbf{[Solution]}",
      r"\begin{aligned} 4x^2 - y^2 &= 32 \\ \Leftrightarrow (2x - y)(2x + y) &= 32 \end{aligned}",
      r"\text{Since } (2x - y) + (2x + y) = 4x, \text{ the sum of the two factors must be a multiple of 4.}",
      r"\text{Of the factor pairs of 32, those whose sum is a multiple of 4 are } (2x-y, 2x+y) = (4,8), (8,4), (-4,-8), (-8,-4). \text{ Solving these:}",
      r"\begin{aligned} 2x-y=4, 2x+y=8 \Leftrightarrow \textcolor{green}{x=3,y=2} \end{aligned}",
      r"\begin{aligned} 2x-y=8, 2x+y=4 \Leftrightarrow \textcolor{green}{x=3,y=-2} \end{aligned}",
      r"\begin{aligned} 2x-y=-4, 2x+y=-8 \Leftrightarrow \textcolor{green}{x=-3,y=2} \end{aligned}",
      r"\begin{aligned} 2x-y=-8, 2x+y=-4 \Leftrightarrow \textcolor{green}{x=-3,y=-2} \end{aligned}",
      r"\text{Thus, } (x,y)=(3,2),(3,-2),(-3,2),(-3,-2).",
    ],
  ),
  "B8F9C5D2-4E6A-4F8B-9C1D-3A5B7C9D1E2F": ProblemTranslation(
    category: 'Quadratic Equations in Two Variables (Discriminant)',
    level: 'Advanced',
    answer: r"""\{(x,y)=(4,1),(6,3),(2,3),(0,1)\} \quad \text{(4 solutions)}""",
    hint: r"\text{Focus on the quadratic and linear terms and decompose into a product of two linear expressions. Adjust the constant later.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Focus on the quadratic and linear terms and factor them as a product of two linear expressions. Adjust the constant term afterward.}",
      r"\textbf{[Solution]}",
      r"\text{Assume } x^2 - 2xy - 2x + 6y = (ax+by+c)(dx+ey+f) - cf\text{. Then}",
      r"""\begin{aligned}
&\ \ \ \ \ x^2 - 2xy - 2x + 6y \\
&= (ax+by+c)(dx+ey+f) -cf \\
&= ad x^2 + (ae+bd) xy + (af+cd)x \\
&\quad + be y^2 + (bf+ce) y + cf
\end{aligned}""",
      r"\text{Comparing coefficients gives:}",
      r"""\begin{cases}
\textcolor{blue}{ad=1 \cdots} \textcolor{blue}{(1)}\\
\textcolor{blue}{ae+bd=-2 \cdots} \textcolor{blue}{(2)}\\
\textcolor{blue}{af+cd=-2 \cdots} \textcolor{blue}{(3)}\\
\textcolor{blue}{be=0 \cdots} \textcolor{blue}{(4)}\\
\textcolor{blue}{bf+ce=6 \cdots} \textcolor{blue}{(5)}
\end{cases}""",
      r"\text{From (1), choosing }(a,d)=(1,1)\text{ is enough (the other choice just flips signs).}",
      r"\text{From (4), }be=0\text{ so }b=0\text{ or }e=0\text{.}",
      r"\text{From (2), }ae+bd=-2\text{. If we take }b=0\text{, then }e=-2\text{.}",
      r"\text{From (3), }af+cd=-2 \Leftrightarrow f+c=-2\text{.}",
      r"\text{From (5), }bf+ce=6 \Leftrightarrow -2c=6 \Rightarrow \textcolor{green}{c=-3}\text{.}",
      r"\text{Then }f+c=-2\text{ gives }f=1\text{.}",
      r"\text{Therefore the integer solution is}",
      r"\begin{aligned} \textcolor{green}{(a,b,c,d,e,f)=(1,0,-3,1,-2,1)}. \end{aligned}",
      r"\text{Hence the linear factors are } x-3 \text{ and } x-2y+1\text{.}",
      r"\text{So } x^2 - 2xy - 2x + 6y = (x-3)(x-2y+1) + 3\text{.}",
      r"\text{Therefore the original equation becomes}",
      r"""\begin{aligned}
&\ \ \ \ \ x^2-2xy-2x+6y-6=0 \\
&\Leftrightarrow (x-3)(x-2y+1) + 3 - 6=0 \\
&\Leftrightarrow (x-3)(x-2y+1)=3 \\ 
&\Leftrightarrow (x-3,\ x-2y+1)=(1,3),(3,1),(-1,-3),(-3,-1)
\end{aligned}""",
      r"\text{Solve each case.}",
      r"\textcolor{blue}{Case:\  }(x-3,x-2y+1)=(1,3)\textcolor{blue}{:}",
      r"""\begin{aligned}
&\ \ \ \ \ x-3=1 \\
&\ \ \ \ \ x-2y+1=3 \\
&\Leftrightarrow x=4,\ 4-2y+1=3 \\
&\Leftrightarrow -2y=-2 \\
&\Leftrightarrow \textcolor{green}{y=1,\ x=4}
\end{aligned}""",
      r"\textcolor{blue}{Case:\  }(x-3,x-2y+1)=(3,1)\textcolor{blue}{:}",
      r"""\begin{aligned}
&\ \ \ \ \ x-3=3 \\
&\ \ \ \ \ x-2y+1=1 \\
&\Leftrightarrow x=6,\ 6-2y+1=1 \\
&\Leftrightarrow -2y=-6 \\
&\Leftrightarrow \textcolor{green}{y=3,\ x=6}
\end{aligned}""",
      r"\textcolor{blue}{Case:\  }(x-3,x-2y+1)=(-1,-3)\textcolor{blue}{:}",
      r"""\begin{aligned}
&\ \ \ \ \ x-3=-1 \\
&\ \ \ \ \ x-2y+1=-3 \\
&\Leftrightarrow x=2,\ 2-2y+1=-3 \\
&\Leftrightarrow -2y=-6 \\
&\Leftrightarrow \textcolor{green}{y=3,\ x=2}
\end{aligned}""",
      r"\textcolor{blue}{Case:\  }(x-3,x-2y+1)=(-3,-1)\textcolor{blue}{:}",
      r"""\begin{aligned}
&\ \ \ \ \ x-3=-3 \\
&\ \ \ \ \ x-2y+1=-1 \\
&\Leftrightarrow x=0,\ 0-2y+1=-1 \\
&\Leftrightarrow -2y=-2 \\
&\Leftrightarrow \textcolor{green}{y=1,\ x=0}
\end{aligned}""",
      r"\text{Therefore, the integer solutions are }(x,y)=(4,1),(6,3),(2,3),(0,1)\text{.}",
    ],
  ),
  "AF7A04F4-3FFC-435D-ACF7-C0741E7B23F8": ProblemTranslation(
    category: 'Quadratic Equations in Two Variables (Discriminant)',
    level: 'Mid',
    answer: r"""\{(x,y)=(4,-1)\} \quad \text{(1 solution)}""",
    hint: r"\text{Focus on the quadratic and linear terms and decompose into a product of two linear expressions. Adjust the constant later.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Focus on the quadratic and linear terms and factor them as a product of two linear expressions. Adjust the constant term afterward.}",
      r"\textbf{[Solution]}",
      r"\text{Assume } 2x^2 + 11xy + 12y^2 - 5y = (ax+by+c)(dx+ey+f) - cf\text{. Then}",
      r"""\begin{aligned}
&\ \ \ \ \ 2x^2 + 11xy + 12y^2 - 5y \\
&= (ax+by+c)(dx+ey+f) -cf \\
&= ad x^2 + (ae+bd) xy + (af+cd)x \\
&\quad + be y^2 + (bf+ce) y + cf
\end{aligned}""",
      r"\text{Comparing coefficients gives:}",
      r"""\begin{cases}
\textcolor{blue}{ad=2 \cdots} \textcolor{blue}{(1)}\\
\textcolor{blue}{ae+bd=11 \cdots} \textcolor{blue}{(2)}\\
\textcolor{blue}{af+cd=0 \cdots} \textcolor{blue}{(3)}\\
\textcolor{blue}{be=12 \cdots} \textcolor{blue}{(4)}\\
\textcolor{blue}{bf+ce=-5 \cdots} \textcolor{blue}{(5)}
\end{cases}""",
      r"\text{From (1), choosing }(a,d)=(1,2)\text{ is enough (other choices only change signs/order).}",
      r"\text{From (2) and (4), we need } be=12 \text{ and } e+2b=11 \text{ with positive integers }b,e\text{.}",
      r"\text{List candidates: }(b,e)=(1,12),(2,6),(3,4),(4,3),(6,2),(12,1)\text{.}",
      r"\text{Only } \textcolor{green}{(b,e)=(4,3)} \text{ satisfies } e+2b=11\text{.}",
      r"\text{From (3), } af+cd=0 \Leftrightarrow f+2c=0 \Leftrightarrow f=-2c\text{.}",
      r"\text{From (5), } bf+ce=-5 \Leftrightarrow 4f+3c=-5\text{.}",
      r"\text{Substitute }f=-2c\text{: }4(-2c)+3c=-5 \Leftrightarrow -5c=-5 \Rightarrow \textcolor{green}{c=1}\text{, hence } \textcolor{green}{f=-2}\text{.}",
      r"\text{Therefore the integer solution is}",
      r"\begin{aligned} \textcolor{green}{(a,b,c,d,e,f)=(1,4,1,2,3,-2)}. \end{aligned}",
      r"\text{So the linear factors are } x+4y+1 \text{ and } 2x+3y-2\text{.}",
      r"\text{Hence } 2x^2 + 11xy + 12y^2 - 5y = (x+4y+1)(2x+3y-2) + 2\text{.}",
      r"\text{Therefore the original equation becomes}",
      r"""\begin{aligned}
&\ \ \ \ \ 2x^2+11xy+12y^2-5y-5=0 \\
&\Leftrightarrow (x+4y+1)(2x+3y-2) + 2 - 5=0 \\
&\Leftrightarrow (x+4y+1)(2x+3y-2)=3 \\ 
&\Leftrightarrow (x+4y+1,\ 2x+3y-2)=(1,3),(3,1),(-1,-3),(-3,-1)
\end{aligned}""",
      r"\text{Solve each case.}",
      r"\textcolor{blue}{Case:\  }(x+4y+1,2x+3y-2)=(1,3)\textcolor{blue}{:}",
      r"""\begin{aligned}
&\ \ \ \ \ x+4y+1=1 \\
&\ \ \ \ \ 2x+3y-2=3 \\
&\Leftrightarrow x+4y=0,\ 2x+3y=5 \\
&\Leftrightarrow x=-4y,\ 2(-4y)+3y=5 \\
&\Leftrightarrow -5y=5 \\
&\Leftrightarrow \textcolor{green}{y=-1,\ x=4}
\end{aligned}""",
      r"\textcolor{blue}{Case:\  }(x+4y+1,2x+3y-2)=(3,1)\textcolor{blue}{:}",
      r"""\begin{aligned}
&\ \ \ \ \ x+4y+1=3 \\
&\ \ \ \ \ 2x+3y-2=1 \\
&\Leftrightarrow x+4y=2,\ 2x+3y=3 \\
&\Leftrightarrow 2x+8y=4 \\
&\Leftrightarrow 5y=1 \\
&\Leftrightarrow y=\frac{1}{5}\ \textcolor{red}{(\text{not\ an\ integer})}
\end{aligned}""",
      r"\textcolor{blue}{Case:\  }(x+4y+1,2x+3y-2)=(-1,-3)\textcolor{blue}{:}",
      r"""\begin{aligned}
&\ \ \ \ \ x+4y+1=-1 \\
&\ \ \ \ \ 2x+3y-2=-3 \\
&\Leftrightarrow x+4y=-2,\ 2x+3y=-1 \\
&\Leftrightarrow 2x+8y=-4 \\
&\Leftrightarrow 5y=3 \\
&\Leftrightarrow y=\frac{3}{5}\ \textcolor{red}{(\text{not\ an\ integer})}
\end{aligned}""",
      r"\textcolor{blue}{Case:\  }(x+4y+1,2x+3y-2)=(-3,-1)\textcolor{blue}{:}",
      r"""\begin{aligned}
&\ \ \ \ \ x+4y+1=-3 \\
&\ \ \ \ \ 2x+3y-2=-1 \\
&\Leftrightarrow x+4y=-4,\ 2x+3y=1 \\
&\Leftrightarrow 2x+8y=-8 \\
&\Leftrightarrow 5y=9 \\
&\Leftrightarrow y=\frac{9}{5}\ \textcolor{red}{(\text{not\ an\ integer})}
\end{aligned}""",
      r"\text{Therefore, the only integer solution is }(x,y)=(4,-1)\text{.}",
    ],
  ),
  "595AEE6D-B85D-45AE-AB48-641EC064B6EB": ProblemTranslation(
    category: 'Quadratic Equations in Two Variables (Discriminant)',
    level: 'Mid',
    answer: r"""\{(x,y)=(-1,-2),(-1,-1),(1,-1),(1,0)\} \quad \text{(4 solutions)}""",
    hint: r"\text{View the equation as a quadratic in x and find integers y such that the discriminant is a perfect square.}",
    steps: [
      r"""\textbf{[Strategy]}
\text{View the equation as a quadratic in }x\text{ and search for integers }y\text{ such that the discriminant is a perfect square.}""",
      r"\textbf{[Solution]}",
      r"\text{Organize the equation in terms of }x\text{:}",
      r"""\begin{aligned}
3x^2 - 2xy + 2y^2 - 2x + 4y - 1 &= 0 \\
\Leftrightarrow 3x^2 - (2y+2)x + (2y^2+4y-1) &= 0
\end{aligned}""",
      r"\text{By the quadratic formula,}",
      r"""\begin{aligned}
x &= \frac{(2y+2) \pm \sqrt{(2y+2)^2 - 12(2y^2+4y-1)}}{2\cdot 3}\\
&= \textcolor{blue}{\frac{2y+2 \pm \sqrt{\Delta}}{6}\cdots(1)}
\end{aligned}""",
      r"\text{Here the discriminant is}",
      r"""\begin{aligned}
\Delta &= (2y+2)^2 - 12(2y^2+4y-1) \\
&= 4y^2 + 8y + 4 - 24y^2 - 48y + 12 \\
&= -20y^2 - 40y + 16\\
&= -20(y^2 + 2y) + 16 \\
&= -20\{(y + 1)^2 - 1\} + 16 \\
&= -20(y + 1)^2 + 20 + 16 \\
&= -20(y + 1)^2 + 36
\end{aligned}""",
      r"\text{For }x\text{ to be an integer, we need }\Delta \ge 0\text{ and }\Delta\text{ to be a perfect square.}",
      r"\Delta = -20(y + 1)^2 + 36 \ge 0 \Rightarrow (y + 1)^2 \le \dfrac{36}{20}=\dfrac{9}{5}=1.8\text{.}",
      r"\text{Therefore } y\in\{-2,-1,0\}\text{ are the only candidates.}",
      r"\text{Now check whether }\Delta\text{ is a perfect square in each case.}",
      r"\textcolor{blue}{Case:\  }y=-2\textcolor{blue}{:}",
      r"\text{ }\Delta = -20(-2 + 1)^2 + 36 = 16\text{ (a square).}",
      r"\text{Substitute }y=-2\text{ into (1): }x=\dfrac{2(-2)+2\pm\sqrt{16}}{6}=\dfrac{-2\pm 4}{6}=-\dfrac{1}{3},-1\text{.}",
      r"\text{The integer solution is } \textcolor{green}{x=-1}\text{, hence } \textcolor{green}{(x,y)=(-1,-2)}\text{.}",
      r"\textcolor{blue}{Case:\  }y=-1\textcolor{blue}{:}",
      r"\text{ }\Delta = -20(-1 + 1)^2 + 36 = 36\text{ (a square).}",
      r"\text{Similarly, }x=\dfrac{2(-1)+2\pm\sqrt{36}}{6}=\dfrac{0\pm 6}{6}=1,-1\text{.}",
      r"\text{So } \textcolor{green}{(x,y)=(-1,-1),(1,-1)}\text{.}",
      r"\textcolor{blue}{Case:\  }y=0\textcolor{blue}{:}",
      r"\text{ }\Delta = -20(0 + 1)^2 + 36 = 16\text{ (a square).}",
      r"\text{Then }x=\dfrac{2\cdot 0 + 2\pm\sqrt{16}}{6}=\dfrac{2\pm 4}{6}=1,-\dfrac{1}{3}\text{.}",
      r"\text{The integer solution is } \textcolor{green}{x=1}\text{, hence } \textcolor{green}{(x,y)=(1,0)}\text{.}",
      r"\text{Therefore, the integer solutions are }(-1,-2),(-1,-1),(1,-1),(1,0)\text{.}",
    ],
  ),
  "6ED3659C-A465-4E25-A2B2-4CAF4FEAEDA5": ProblemTranslation(
    category: 'Quadratic Equations in Two Variables (Discriminant)',
    level: 'Mid',
    answer: r"""\{(x,y)=(2,-1),(2,-7)\} \quad \text{(2 solutions)}""",
    hint: r"\text{View the equation as a quadratic in y and find integers x such that the discriminant is a perfect square.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{View the equation as a quadratic in }y\text{ and search for integers }x\text{ such that the discriminant is a perfect square.}",
      r"\textbf{[Solution]}",
      r"\text{Organize the equation in terms of }y\text{:}",
      r"""\begin{aligned}
5x^2 + 2xy + y^2 - 12x + 4y + 11 &= 0 \\
\Leftrightarrow y^2 + (2x+4)y + (5x^2-12x+11) &= 0
\end{aligned}""",
      r"\text{Compute the discriminant:}",
      r"""\begin{aligned}
\Delta &= (2x+4)^2 - 4(5x^2-12x+11) \\
&= 4x^2 + 16x + 16 - 20x^2 + 48x - 44 \\
&= -16x^2 + 64x - 28 \\
&= -16(x^2 - 4x) - 28 \\
&= -16\{(x - 2)^2 - 4\} - 28 \\
&= -16(x - 2)^2 + 64 - 28 \\
&= -16(x - 2)^2 + 36
\end{aligned}""",
      r"\text{For integer }y\text{, }\Delta\text{ must be a perfect square. In particular, }\Delta\ge 0\text{ gives}",
      r"""\begin{aligned}
&-16(x - 2)^2 + 36 \ge 0 \\
&\Leftrightarrow 16(x - 2)^2 \le 36 \\
&\Leftrightarrow (x - 2)^2 \le \frac{9}{4} \\
&\Leftrightarrow |x - 2| \le \frac{3}{2} \\
&\Leftrightarrow x \in \{1,2,3\}
\end{aligned}""",
      r"\text{Now check whether } \Delta=-16(x-2)^2+36 \text{ is a perfect square for each }x\text{.}",
      r"\textcolor{blue}{Case:\  }x=1\textcolor{blue}{:}",
      r"\text{ }\Delta = -16(1 - 2)^2 + 36 = 20\text{ (not a square).}",
      r"\textcolor{blue}{Case:\  }x=2\textcolor{blue}{:}",
      r"\text{ }\Delta = -16(2 - 2)^2 + 36 = 36\text{ (a square).}",
      r"\text{Substitute }x=2\text{ into the equation:}",
      r"""\begin{aligned}
5 \cdot 2^2 + 2 \cdot 2 \cdot y + y^2 - 12 \cdot 2 + 4y + 11 &= 0 \\
\Leftrightarrow 20 + 4y + y^2 - 24 + 4y + 11 &= 0 \\
\Leftrightarrow y^2 + 8y + 7 &= 0 \\
\Leftrightarrow \textcolor{green}{y = -1,\ -7}
\end{aligned}""",
      r"\textcolor{blue}{Case:\  }x=3\textcolor{blue}{:}",
      r"\text{ }\Delta = -16(3 - 2)^2 + 36 = 20\text{ (not a square).}",
      r"\text{Therefore, the integer solutions are }(x,y)=(2,-1),(2,-7)\text{.}",
    ],
  ),
  "479E7E6E-ED63-4F1A-BB39-42C4C598782D": ProblemTranslation(
    category: 'Rational Equations (Sum of Fractions)',
    level: 'Mid',
    answer: r"""\{(x,y,z)=(2,3,6), (2,4,4), (3,3,3)\} \quad \text{(3 solutions)}""",
    hint: r"\text{Restrict the range of x.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Restrict the range of }x\text{.}",
      r"\textbf{[Solution]}",
      r"\text{If }x\text{ were an integer }\ge 4\text{, then}",
      r"""\begin{aligned}
\displaystyle \frac{1}{x} + \frac{1}{y} + \frac{1}{z} \le \frac{1}{x} + \frac{1}{x} + \frac{1}{x} = \displaystyle \frac{3}{x} \le \dfrac 3 4 < 1
\end{aligned}""",
      r"\text{Hence } x \le 3\text{.}",
      r"\text{So we check }x = 1, 2, 3\text{.}",
      r"\textcolor{blue}{Case:\  }x = 1\textcolor{blue}{: } \text{Since } \frac{1}{y},\frac{1}{z}>0\text{, there are no solutions.}",
      r"\textcolor{blue}{Case:\  }x = 2\textcolor{blue}{: } \displaystyle \frac{1}{2} + \frac{1}{y} + \frac{1}{z} = 1 \Rightarrow \displaystyle \frac{1}{y} + \frac{1}{z} = \frac{1}{2}.",
      r"""\begin{aligned}
\displaystyle \frac{1}{y} + \frac{1}{z} &= \frac{1}{2} \\
\Leftrightarrow \displaystyle \frac{y+z}{yz} &= \frac{1}{2} \\
\Leftrightarrow 2(y+z) &= yz \\
\Leftrightarrow yz - 2y - 2z &= 0
\end{aligned}""",
      r"\text{Use the identity } yz - 2y - 2z = (y-2)(z-2) - 4\text{:}",
      r"""\begin{aligned}
(y-2)(z-2) - 4 &= 0 \\
\Leftrightarrow (y-2)(z-2) &= 4
\end{aligned}""",
      r"\text{Since }2 \le y \le z\text{, we have }0 \le y-2 \le z-2\text{. Consider factor pairs of }4\text{:}",
      r"""\begin{aligned}
&\ \ \ \ \ (y-2,z-2)=(1,4),(2,2) \\
& \Leftrightarrow (y,z) = (3,6), (4,4)
\end{aligned}""",
      r"\text{Thus for }x=2\text{, the solutions are } \textcolor{green}{(y,z)=(3,6),(4,4)}\text{.}",
      r"\textcolor{blue}{Case:\  }x = 3\textcolor{blue}{: } \displaystyle \frac{1}{3} + \frac{1}{y} + \frac{1}{z} = 1 \Rightarrow \displaystyle \frac{1}{y} + \frac{1}{z} = \frac{2}{3}.",
      r"""\begin{aligned}
\displaystyle \frac{1}{y} + \frac{1}{z} &= \frac{2}{3} \\
\Leftrightarrow \displaystyle \frac{y+z}{yz} &= \frac{2}{3} \\
\Leftrightarrow 3(y+z) &= 2yz \\
\Leftrightarrow 2yz - 3y - 3z &= 0
\end{aligned}""",
      r"\text{Use the identity }2yz - 3y - 3z = (2y-3)(2z-3) - 9\text{:}",
      r"""\begin{aligned}
(2y-3)(2z-3) - 9 &= 0 \\
\Leftrightarrow (2y-3)(2z-3) &= 9
\end{aligned}""",
      r"\text{Since }3 \le y \le z\text{, we have }3 \le 2y-3 \le 2z-3\text{. Consider factor pairs of }9\text{:}",
      r"""\begin{aligned}
&\ \ \ \ \ (2y-3,2z-3)=(3,3) \\
& \Leftrightarrow (y,z) = (3,3)
\end{aligned}""",
      r"\text{Thus for }x=3\text{, the only solution is } \textcolor{green}{(y,z)=(3,3)}\text{.}",
      r"\text{Therefore, the integer solutions are } \textcolor{green}{(x,y,z)=(2,3,6),(2,4,4),(3,3,3)}\text{.}",
    ],
  ),
  "E8EA2D7A-4614-47AB-8934-8C7BCF3568C1": ProblemTranslation(
    category: 'Equations in Three Variables (Case Analysis)',
    level: 'Mid',
    answer: r"""(1,2,3) \quad \text{(1 solution)}""",
    hint: r"Use x \le y \le z to write x+y+z \le 3z and reduce x, y to a finite number of candidates.",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the condition }x \le y \le z\text{ to bound }x,y\text{ to finitely many candidates.}",
      r"\textbf{[Solution]}",
      r"\text{Since }x \le y \le z\text{,}",
      r"""\begin{aligned}
xyz &= x + y + z \\
&\le z + z + z = 3z
\end{aligned}""",
      r"\text{Thus } xyz \le 3z \Rightarrow xy \le 3\text{.}",
      r"\text{With }x \le y\text{, the candidates are }(x,y)=(1,1),(1,2),(1,3),(2,2)\text{.}",
      r"\text{Substitute these candidates into }xyz=x+y+z\text{.}",
      r"\textcolor{blue}{Case:\  }(x,y)=(1,1)\textcolor{blue}{:}",
      r"\text{Substitute }x=1,\ y=1\text{:}",
      r"""\begin{aligned}
1 \cdot 1 \cdot z &= 1 + 1 + z
\end{aligned}""",
      r"\textcolor{red}{This\ is\ impossible.}",
      r"\textcolor{blue}{Case:\  }(x,y)=(1,2)\textcolor{blue}{:}",
      r"\text{Substitute }x=1,\ y=2\text{:}",
      r"""\begin{aligned}
1 \cdot 2 \cdot z &= 1 + 2 + z \\
\Leftrightarrow 2z &= 3 + z \\
\Leftrightarrow z &= 3
\end{aligned}""",
      r"\text{Therefore, } \textcolor{green}{(x,y,z)=(1,2,3)} \text{ is a solution.}",
      r"\textcolor{blue}{Case:\  }(x,y)=(1,3)\textcolor{blue}{:}",
      r"\text{Substitute }x=1,\ y=3\text{:}",
      r"""\begin{aligned}
1 \cdot 3 \cdot z &= 1 + 3 + z \\
\Leftrightarrow 3z &= 4 + z \\
\Leftrightarrow 2z &= 4 \\
\Leftrightarrow z &= 2
\end{aligned}""",
      r"\text{But }y \le z\text{ would require }3 \le 2\text{, so }\textcolor{red}{this\ case\ is\ invalid.}",
      r"\textcolor{blue}{Case:\  }(x,y)=(2,2)\textcolor{blue}{:}",
      r"\text{Substitute }x=2,\ y=2\text{:}",
      r"""\begin{aligned}
2 \cdot 2 \cdot z &= 2 + 2 + z \\
\Leftrightarrow 4z &= 4 + z \\
\Leftrightarrow 3z &= 4 \\
\Leftrightarrow z &= \frac{4}{3}
\end{aligned}""",
      r"\text{But }z\text{ must be an integer and }y \le z\text{, so }\textcolor{red}{this\ case\ is\ invalid.}",
      r"\textcolor{blue}{Case:\  }(x,y)=(2,3)\textcolor{blue}{:}",
      r"\text{Substitute }x=2,\ y=3\text{:}",
      r"""\begin{aligned}
2 \cdot 3 \cdot z &= 2 + 3 + z \\
\Leftrightarrow 6z &= 5 + z \\
\Leftrightarrow 5z &= 5 \\
\Leftrightarrow z &= 1
\end{aligned}""",
      r"\text{But }y \le z\text{ would require }3 \le 1\text{, so }\textcolor{red}{this\ case\ is\ invalid.}",
      r"\text{Therefore, the only integer solution is }(x,y,z)=(1,2,3)\text{.}",
    ],
  ),
  "73F50D01-0B10-4D81-A565-163E48987C2E": ProblemTranslation(
    category: 'Indeterminate Equations',
    level: 'Advanced',
    answer: r"""(20,1),(20,-1),(-20,1),(-20,-1),(19,2),(19,-2),(-19,2),(-19,-2) \quad \text{(8 solutions)}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Work modulo }13\text{.}",
      r"\textbf{[Solution]}",
      r"\text{Consider the equation modulo }13\text{:}",
      r"""\begin{aligned}
x^2 + 13y^2 &\equiv x^2 \pmod{13},\\
413 &= 13 \times 31 + 10 \equiv 10 \pmod{13}.
\end{aligned}""",
      r"\text{Therefore } x^2 \equiv 10 \pmod{13} \text{ is necessary.}",
      r"\text{List quadratic residues modulo }13\text{:}",
      r"""\begin{aligned}
0^2 &\equiv 0,\quad 1^2 \equiv 1,\quad 2^2 \equiv 4,\quad 3^2 \equiv 9 \\
4^2 &\equiv 3,\quad 5^2 \equiv 12,\quad 6^2 \equiv 10,\quad 7^2 \equiv 10 \\
8^2 &\equiv 12,\quad 9^2 \equiv 3,\quad 10^2 \equiv 9,\quad 11^2 \equiv 4,\quad 12^2 \equiv 1
\end{aligned}""",
      r"\text{Hence } x \equiv \pm 6 \pmod{13} \text{ or } x \equiv \pm 7 \pmod{13}\text{.}",
      r"\text{So } x = 13k \pm 6 \text{ or } x = 13k \pm 7\text{.}",
      r"\text{Since }x^2 \le 413\text{, we have } |x| \le 20\text{, so candidates are } x=\pm 6,\pm 7,\pm 19,\pm 20\text{.}",
      r"\text{For each candidate, check whether } y^2=\dfrac{413-x^2}{13}\text{ is a perfect square.}",
      r"\textcolor{blue}{Case:\  }x=\pm 20\textcolor{blue}{:}",
      r"\text{ }y^2 = \frac{413 - 400}{13} = 1 \Rightarrow \textcolor{green}{y = \pm 1}.",
      r"\textcolor{blue}{Case:\  }x=\pm 19\textcolor{blue}{:}",
      r"\text{ }y^2 = \frac{413 - 361}{13} = 4 \Rightarrow \textcolor{green}{y = \pm 2}.",
      r"\textcolor{red}{For\ \ the\ \ other\ \ candidates\ \ }x=\pm 6,\pm 7\textcolor{red}{,\ we\ \ get\ \ }y^2=29\text{ or }28\text{, which are not squares.}",
      r"\text{Therefore, the integer solutions are }(\pm 20,\pm 1)\text{ and }(\pm 19,\pm 2)\text{ (8 solutions).}",
    ],
  ),
  "3F983683-4841-44A5-8A49-2AADB866B6D9": ProblemTranslation(
    category: 'Indeterminate Equations',
    level: 'Advanced',
    answer: r"""\{(x,y)=(2,-7)\} \quad \text{(1 solution)}""",
    hint: r"\text{Use isolation of constants and factorization to explore integer solutions. Focus on the constant term -2 to narrow down candidates for x.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Search for integer solutions using isolation of constants and factorization. Focus on the constant term }-2\text{ to restrict candidates for }x\text{.}",
      r"\textbf{[Solution]}",
      r"\text{Rearrange the equation (group terms so the constant becomes visible):}",
      r"""\begin{aligned}
x^3 + (3y - 5)x^2 - 7yx - 2 &= 0 \\
\Leftrightarrow x(x^2 - 5x - 2 + 3yx - 7y) &= 2
\end{aligned}""",
      r"\text{From the constant term }2\text{, the only integer candidates are }x\in\{1,-1,2,-2\}\text{.}",
      r"\text{So we check each case.}",
      r"\textcolor{blue}{Case:\  }x = 1\textcolor{blue}{:}",
      r"""\begin{aligned}
1^3 + (3y - 5) \cdot 1^2 - 7y \cdot 1 - 2 &= 0 \\
1 + 3y - 5 - 7y - 2 &= 0 \\
-4y - 6 &= 0 \\
y &= -\frac{3}{2}
\end{aligned}""",
      r"\textcolor{red}{This\ is\ not\ an\ integer.}",
      r"\textcolor{blue}{Case:\  }x = -1\textcolor{blue}{:}",
      r"""\begin{aligned}
(-1)^3 + (3y - 5) \cdot (-1)^2 - 7y \cdot (-1) - 2 &= 0 \\
-1 + 3y - 5 + 7y - 2 &= 0 \\
10y - 8 &= 0 \\
y &= \frac{4}{5}
\end{aligned}""",
      r"\textcolor{red}{This\ is\ not\ an\ integer.}",
      r"\textcolor{blue}{Case:\  }x = 2\textcolor{blue}{:}",
      r"""\begin{aligned}
2^3 + (3y - 5) \cdot 2^2 - 7y \cdot 2 - 2 &= 0 \\
8 + 4(3y - 5) - 14y - 2 &= 0 \\
8 + 12y - 20 - 14y - 2 &= 0 \\
-2y - 14 &= 0 \\
y &= -7
\end{aligned}""",
      r"\text{Therefore, } \textcolor{green}{(x,y)=(2,-7)} \text{ is an integer solution.}",
      r"\textcolor{blue}{Case:\  }x = -2\textcolor{blue}{:}",
      r"""\begin{aligned}
(-2)^3 + (3y - 5) \cdot (-2)^2 - 7y \cdot (-2) - 2 &= 0 \\
-8 + 4(3y - 5) + 14y - 2 &= 0 \\
-8 + 12y - 20 + 14y - 2 &= 0 \\
26y - 30 &= 0 \\
y &= \frac{15}{13}
\end{aligned}""",
      r"\textcolor{red}{This\ is\ not\ an\ integer.}",
      r"\text{Hence, the only integer solution is }(x,y)=(2,-7)\text{.}",
    ],
  ),
  "C0367E7C-E68E-4377-B638-8C6EDB803AEB": ProblemTranslation(
    category: 'Equations in Four Variables (Case Analysis)',
    level: 'Mid',
    answer: r"""\{(a,b,c,d)=(1,1,2,4) \text{ and its permutations. (12 solutions)} \}""",
    hint: r"Assume a \le b \le c \le d and restrict the range.",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{By symmetry, assume } a \le b \le c \le d \text{ and restrict the possible values.}",
      r"\textbf{[Solution]}",
      r"\text{Since } a \le b \le c \le d\text{,}",
      r"""\begin{aligned}
abcd &= a + b + c + d \\
&\le d + d + d + d = 4d
\end{aligned}""",
      r"abcd \le 4d \Leftrightarrow abc \le 4\cdots(1)\text{.}",
      r"\text{If }a=2\text{, then }b,c \ge 2\text{ so }abc \ge 2^3=8>4\text{, contradicting (1). Hence }a=1\text{.}",
      r"\text{With }a=1\text{, we have }b \le c\text{ and }bc \le 4\text{, so there are only finitely many candidates.}",
      r"\textcolor{blue}{Case:\  }a=1\textcolor{blue}{:}",
      r"\text{Since }bc \le 4\text{, candidates are }(b,c)=(1,1),(1,2),(1,3),(1,4),(2,2)\text{.}",
      r"\textcolor{blue}{Case:\  }(a,b,c)=(1,1,1)\textcolor{blue}{:}",
      r"\text{Substitute into the equation:}",
      r"""\begin{aligned}
1 \cdot 1 \cdot 1 \cdot d &= 1 + 1 + 1 + d \\
\Leftrightarrow d &= 3 + d
\end{aligned}""",
      r"\textcolor{red}{This\ is\ impossible.}",
      r"\textcolor{blue}{Case:\  }(a,b,c)=(1,1,2)\textcolor{blue}{:}",
      r"\text{Substitute into the equation:}",
      r"""\begin{aligned}
1 \cdot 1 \cdot 2 \cdot d &= 1 + 1 + 2 + d \\
\Leftrightarrow 2d &= 4 + d \\
\Leftrightarrow d &= 4
\end{aligned}""",
      r"\text{Therefore, } \textcolor{green}{(a,b,c,d)=(1,1,2,4)} \text{ is a solution.}",
      r"\textcolor{blue}{Case:\  }(a,b,c)=(1,1,3)\textcolor{blue}{:}",
      r"\text{Substitute into the equation:}",
      r"""\begin{aligned}
1 \cdot 1 \cdot 3 \cdot d &= 1 + 1 + 3 + d \\
\Leftrightarrow 3d &= 5 + d \\
\Leftrightarrow d &= \frac{5}{2}
\end{aligned}""",
      r"\textcolor{red}{This\ is\ not\ an\ integer.}",
      r"\textcolor{blue}{Case:\  }(a,b,c)=(1,1,4)\textcolor{blue}{:}",
      r"\text{Substitute into the equation:}",
      r"""\begin{aligned}
1 \cdot 1 \cdot 4 \cdot d &= 1 + 1 + 4 + d \\
\Leftrightarrow 4d &= 6 + d \\
\Leftrightarrow d &= 2
\end{aligned}""",
      r"\text{But }c \le d\text{ would require }4 \le 2\text{, so }\textcolor{red}{this\ case\ is\ invalid.}",
      r"\textcolor{blue}{Case:\  }(a,b,c)=(1,2,2)\textcolor{blue}{:}",
      r"\text{Substitute into the equation:}",
      r"""\begin{aligned}
1 \cdot 2 \cdot 2 \cdot d &= 1 + 2 + 2 + d \\
\Leftrightarrow 4d &= 5 + d \\
\Leftrightarrow d &= \frac{5}{3}
\end{aligned}""",
      r"\textcolor{red}{This\ is\ not\ an\ integer.}",
      r"\text{Therefore, under }a \le b \le c \le d\text{, the only solution is }(a,b,c,d)=(1,1,2,4)\text{.}",
      r"\text{Since the original problem has no ordering restriction, all permutations of }(1,1,2,4)\text{ are solutions:}",
      r"""\begin{aligned}
(a,b,c,d) = &(1,1,2,4), (1,1,4,2), (1,2,1,4), (1,2,4,1),\\
&(1,4,1,2), (1,4,2,1), (2,1,1,4), (2,1,4,1),\\
&(2,4,1,1), (4,1,1,2), (4,1,2,1), (4,2,1,1)
\end{aligned}""",
    ],
  ),
  "FBFAA113-A701-4D94-9421-3AEF3FA2A96E": ProblemTranslation(
    category: 'Indeterminate Equations',
    level: 'Advanced',
    answer: r"""\begin{aligned} \begin{cases} x = 29k + 36 - 732\ell\\ y = -17k - 21 + 427\ell\\ z = \ell \end{cases} \end{aligned} \quad (k, \ell \in \mathbb{Z})""",
    hint: r"Since gcd(17, 29) = 1, for any z, there exist integer solutions x, y. Fix z = \ell and solve for x, y to find the general solution.",
    steps: [
      r"""\textbf{[Strategy]}
\text{Since }\gcd(17,29)=1\text{, for any fixed }z\text{ there exist integer solutions }x,y\text{. Fix }z=\ell\text{ and solve, then collect over all }\ell\in\mathbb{Z}\text{.}""",
      r"\textbf{[Solution]}",
      r"\text{Fix an integer }z=\ell\text{. Then the equation becomes }17x+29y=3-61\ell\text{.}",
      r"\textbf{[Find one solution to }17x+29y=1\textbf{]}",
      r"\text{Use the Euclidean algorithm:}",
      r"""\begin{aligned}
29 &= 17 \cdot 1 + 12 \\
17 &= 12 \cdot 1 + 5 \\
12 &= 5 \cdot 2 + 2 \\
5 &= 2 \cdot 2 + 1 \\
2 &= 1 \cdot 2 + 0
\end{aligned}""",
      r"\text{Work backwards:}",
      r"""\begin{aligned}
1 &= 5 - 2 \cdot 2 \\
&= 5 - (12 - 5 \cdot 2) \cdot 2 \\
&= 5 \cdot 5 - 12 \cdot 2 \\
&= (17 - 12) \cdot 5 - 12 \cdot 2 \\
&= 17 \cdot 5 - 12 \cdot 7 \\
&= 17 \cdot 5 - (29 - 17) \cdot 7 \\
&= 17 \cdot 12 - 29 \cdot 7
\end{aligned}""",
      r"\text{Thus } 17\cdot 12 + 29\cdot(-7)=1\text{, so one solution is }(x,y)=(12,-7)\text{.}",
      r"\text{Multiply both sides by }(3-61\ell)\text{. Then a solution to }17x+29y=3-61\ell\text{ is}",
      r"(x_0,y_0)=\bigl(12(3-61\ell),\ -7(3-61\ell)\bigr)\text{.}",
      r"\text{Indeed: } 17\cdot 12(3-61\ell) + 29\cdot(-7)(3-61\ell) = 3-61\ell.",
      r"\textbf{[Construct the general solution]}",
      r"\text{Subtract the particular-solution equation from }17x+29y=3-61\ell\text{:}",
      r"""\begin{aligned}
17x + 29y &= 3-61\ell \\
17 \cdot 12(3-61\ell) + 29 \cdot (-7)(3-61\ell) &= 3-61\ell \\
\hline
17(x - 12(3-61\ell)) + 29(y - (-7)(3-61\ell)) &= 0 
\end{aligned}""",
      r"\text{Since }17\text{ and }29\text{ are coprime, there exists }k\in\mathbb{Z}\text{ such that}",
      r"""\begin{aligned}
\begin{cases} 
x-12(3-61\ell) = 29k \\
y-(-7)(3-61\ell) = -17k
\end{cases}
\end{aligned}""",
      r"\text{Therefore,}",
      r"""\begin{aligned}
\begin{cases} 
x = 12(3 - 61\ell) + 29k = 29k + 36 - 732\ell\\
y = -7(3 - 61\ell) - 17k = -17k - 21 + 427\ell
\end{cases}
\end{aligned}""",
      r"\text{These are all solutions for the fixed }z=\ell\text{. Hence the general solution to }17x+29y+61z=3\text{ is }x=29k+36-732\ell,\ y=-17k-21+427\ell,\ z=\ell\ (k,\ell\in\mathbb{Z}).",
    ],
  ),
  "B1D8559E-D3F4-45DA-A889-8056A50EE5A8": ProblemTranslation(
    category: 'Indeterminate Equations',
    level: 'Mid',
    answer: r"""\begin{aligned} x = 3k + 2 - 13\ell,\ y = 7k + 4 - 26\ell,\ z = \ell \end{aligned} \quad (k, \ell \in \mathbb{Z})""",
    hint: r"Since gcd(3, 7) = 1, for any z, there exist integer solutions x, y. Fix z = \ell and solve for x, y.",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Since }\gcd(3,7)=1\text{, for any fixed }z\text{ the equation }7x-3y+13z=2\text{ has integer solutions in }x,y\text{. Fix }z\text{ and find all }(x,y)\text{, then collect over all }z\in\mathbb{Z}\text{.}",
      r"\textbf{[Solution]}",
      r"\text{Fix an integer }z=\ell\text{. Then }7x-3y=2-13\ell\text{. Solve for fixed }\ell\text{ and then allow }\ell\in\mathbb{Z}\text{.}",
      r"\textbf{[Find one solution]}",
      r"\text{A solution to }7x-3y=1\text{ is }(x,y)=(1,2)\text{.}",
      r"\text{Multiply both sides by }(2-13\ell)\text{. Then a solution to }7x-3y=2-13\ell\text{ is }(x_0,y_0)=(2-13\ell,\ 2(2-13\ell))\text{.}",
      r"\text{Indeed: } 7(2-13\ell) - 3\cdot 2(2-13\ell) = 2-13\ell.",
      r"\textbf{[Construct the general solution]}",
      r"\text{Subtract the particular-solution equation from }7x-3y=2-13\ell\text{:}",
      r"""\begin{aligned}
7x - 3y &= 2-13\ell \\
7 \cdot (2-13\ell) - 3 \cdot 2(2-13\ell) &= 2-13\ell \\
\hline
7(x - (2-13\ell)) - 3(y - 2(2-13\ell)) &= 0 
\end{aligned}""",
      r"\text{Since }7\text{ and }3\text{ are coprime, there exists }k\in\mathbb{Z}\text{ such that }x-(2-13\ell)=3k\text{ and }y-2(2-13\ell)=7k\text{.}",
      r"""\begin{aligned}
\begin{cases} 
x - (2-13\ell) = 3k \\
y - 2(2-13\ell) = 7k
\end{cases}
\Leftrightarrow
\begin{cases} 
x = 3k + 2 - 13\ell\\
y = 7k + 4 - 26\ell
\end{cases}
\end{aligned}""",
      r"\text{These are all solutions for the fixed }z=\ell\text{. Hence the general solution to }7x-3y+13z=2\text{ is }x=3k+2-13\ell,\ y=7k+4-26\ell,\ z=\ell\ (k,\ell\in\mathbb{Z}).",
    ],
  ),
  "A8B9C0D1-E2F3-4A5B-6C7D-8E9F0A1B2C3": ProblemTranslation(
    category: 'Indeterminate Equations',
    level: 'Advanced',
    answer: r"""(13,3),(13,-3),(-13,3),(-13,-3) \quad \text{(4 solutions)}""",
    hint: r"\text{Use modulo 6.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Work modulo }6\text{.}",
      r"\textbf{[Solution]}",
      r"\text{Working modulo }6\text{:}",
      r"""\begin{aligned}
6y^2 &\equiv 0 \pmod{6} \quad (\text{a multiple of }6) \\
223 &= 6 \times 37 + 1 \equiv 1 \pmod{6}
\end{aligned}""",
      r"\text{Therefore,}",
      r"""\begin{aligned}
x^2 + 6y^2 &\equiv x^2 \equiv 1 \pmod{6}
\end{aligned}""",
      r"\text{Check possible residues of }x^2\text{ modulo }6\text{:}",
      r"""\begin{aligned}
x \equiv 0 \pmod{6} &\Rightarrow x^2 \equiv 0 \pmod{6} \\
x \equiv 1 \pmod{6} &\Rightarrow x^2 \equiv 1 \pmod{6} \\
x \equiv 2 \pmod{6} &\Rightarrow x^2 \equiv 4 \pmod{6} \\
x \equiv 3 \pmod{6} &\Rightarrow x^2 \equiv 9 \equiv 3 \pmod{6} \\
x \equiv 4 \pmod{6} &\Rightarrow x^2 \equiv 16 \equiv 4 \pmod{6} \\
x \equiv 5 \pmod{6} &\Rightarrow x^2 \equiv 25 \equiv 1 \pmod{6}
\end{aligned}""",
      r"\text{Hence, }x^2 \equiv 1 \pmod{6}\text{ implies } x \equiv 1,5 \pmod{6}\text{.}",
      r"\text{Also, from }x^2 \le 223\text{ we have }|x| \le 14\text{.}",
      r"\text{So candidates are } x=\pm 1,\pm 5,\pm 7,\pm 11,\pm 13\text{.}",
      r"\text{For each candidate, compute }y^2=\dfrac{223-x^2}{6}\text{.}",
      r"\textcolor{blue}{Case:\  }x=\pm 1\textcolor{blue}{:}",
      r"""\begin{aligned}
1 + 6y^2 &= 223 \\
6y^2 &= 222 \\
y^2 &= 37
\end{aligned}""",
      r"\text{Since }37\text{ is not a perfect square, }\textcolor{red}{no\ solutions.}",
      r"\textcolor{blue}{Case:\  }x=\pm 5\textcolor{blue}{:}",
      r"""\begin{aligned}
25 + 6y^2 &= 223 \\
6y^2 &= 198 \\
y^2 &= 33
\end{aligned}""",
      r"\text{Since }33\text{ is not a perfect square, }\textcolor{red}{no\ solutions.}",
      r"\textcolor{blue}{Case:\  }x=\pm 7\textcolor{blue}{:}",
      r"""\begin{aligned}
49 + 6y^2 &= 223 \\
6y^2 &= 174 \\
y^2 &= 29
\end{aligned}""",
      r"\text{Since }29\text{ is not a perfect square, }\textcolor{red}{no\ solutions.}",
      r"\textcolor{blue}{Case:\  }x=\pm 11\textcolor{blue}{:}",
      r"""\begin{aligned}
121 + 6y^2 &= 223 \\
6y^2 &= 102 \\
y^2 &= 17
\end{aligned}""",
      r"\text{Since }17\text{ is not a perfect square, }\textcolor{red}{no\ solutions.}",
      r"\textcolor{blue}{Case:\  }x=\pm 13\textcolor{blue}{:}",
      r"""\begin{aligned}
169 + 6y^2 &= 223 \\
6y^2 &= 54 \\
y^2 &= 9 \\
\textcolor{green}{y} & \textcolor{green}{= \pm 3}
\end{aligned}""",
      r"\text{Therefore, the integer solutions are }(x,y)=(13,3),(13,-3),(-13,3),(-13,-3)\text{.}",
    ],
  ),
};




