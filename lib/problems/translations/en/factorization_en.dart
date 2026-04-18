import '../../../models/problem_translation.dart';

final Map<String, ProblemTranslation> factorizationTranslationsEn = {
  // basic_factorization.dart
  "5F7F2DCD-4A6E-4BA1-B97A-1F9B7B6809A4": ProblemTranslation(
    category: 'Factorization',
    level: 'Easy',
    steps: [
      r"\textbf{[Transformation]}",
      r"\begin{aligned} x^2 + 6xy + 9y^2 &= x^2 + (2\cdot 3y)x + (3y)^2 \\ &= (x + 3y)^2 \end{aligned}",
    ],
  ),
  "897713C5-D885-4103-937C-62F11F4E5C18": ProblemTranslation(
    category: 'Factorization',
    level: 'Easy',
    steps: [
      r"\textbf{[Transformation]}",
      r"\begin{aligned} 36x^2 - 25y^2 &= (6x)^2 - (5y)^2 \\ &= (6x - 5y)(6x + 5y) \end{aligned}",
    ],
  ),
  "E0D650DF-7B76-4A37-A0FE-B18A8A041E0B": ProblemTranslation(
    category: 'Factorization',
    level: 'Easy',
    steps: [
      r"\textbf{[Key Points]}",
      r"\text{Using the cross-multiplication method (tasukigake), find two numbers whose product is }-22 \text{and whose sum is} -9.",
      r"\textbf{[Transformation]}",
      r"\begin{aligned} x^2 - 9x - 22 = (x - 11)(x + 2) \end{aligned}",
    ],
  ),
  "546F77A4-9EED-4FED-92F4-8E22927D77C8": ProblemTranslation(
    category: 'Factorization',
    level: 'Easy',
    steps: [
      r"\textbf{[Key Points]}",
      r"\text{Factor out the common factor } xy.",
      r"\textbf{[Transformation]}",
      r"\begin{aligned} 9x^3y - 16xy^3 &= xy(9x^2 - 16y^2) \\ &= xy(3x-4y)(3x+4y) \end{aligned}",
    ],
  ),
  "15CEC271-B2C8-40A9-9B84-C64590472E61": ProblemTranslation(
    category: 'Factorization',
    level: 'Easy',
    steps: [
      r"\textbf{[Transformation]}",
      r"\begin{aligned} 4x^2 - 20xy + 25y^2 &= (2x)^2 - 2(2x)(5y) + (5y)^2 \\ &= (2x - 5y)^2 \end{aligned}",
    ],
  ),
  "8B1C27DD-2BAC-41F5-8D5B-2B1F58AB12ED": ProblemTranslation(
    category: 'Factorization',
    level: 'Mid',
    steps: [
      r"\textbf{[Key Points]}",
      r"\text{Use the factor theorem. Since the constant term is -6, the candidates are } \pm 1, \pm 2, \pm 3, \pm 6.",
      r"\textbf{[Explanation]}",
      r"\begin{aligned} f(-1) &= (-1)^3 + 2 \cdot (-1)^2 - 5 \cdot (-1) - 6 \\ &= -1 + 2 + 5 - 6 = 0 \end{aligned}",
      r"\text{Therefore, } x + 1 \text{ is a factor.}",
      r"\text{Dividing } x^3 + 2x^2 - 5x - 6 \text{ by } x + 1, \text{ we get:}",
      r"\begin{aligned} x^3 + 2x^2 - 5x - 6 &= (x + 1)(x^2 + x - 6) \\ &= (x + 1)(x + 3)(x - 2) \end{aligned}",
    ],
  ),
  "A1B2C3D4-E5F6-A7B8-C9D0-E1F2A3B4C5D6": ProblemTranslation(
    category: 'Factorization',
    level: 'Easy',
    hint: r"\text{Group terms and factor by } x \text{ and } z.",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Group terms and factor by } x \text{ and } z.",
      r"\textbf{[Transformation]}",
      r"\begin{aligned} xy - yz + zu - ux &= xy - ux - yz + zu \\ &= x(y - u) - z(y - u) \\ &= (x - z)(y - u) \end{aligned}",
    ],
  ),

  // mid_factorization.dart
  "7474E9C1-6272-4491-8807-C095BDE7AD6F": ProblemTranslation(
    category: 'Factorization',
    level: 'Mid',
    hint: r"\text{Organize by the variable with the lowest degree (} c \text{ is 1st degree, } b \text{ is 2nd, } a \text{ is 3rd).}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Organize by the variable with the lowest degree (} c \text{ is 1st degree, } b \text{ is 2nd, } a \text{ is 3rd).}",
      r"\textbf{[Transformation]}",
      r"\text{Organizing by } c:",
      r"\begin{aligned} a^3 - a b^2 - b^2 c + a^2 c &= c(a^2 - b^2) + a(a^2 - b^2) \\ &= (c+a)(a^2 - b^2) \\ &= (a+c)(a-b)(a+b) \end{aligned}",
    ],
  ),
  "1F0413C9-47F5-44A8-A3C3-519334677C68": ProblemTranslation(
    category: 'Factorization',
    level: 'Mid',
    hint: r"\text{Let } x^2 = t, \text{ factor as a quadratic, then substitute back.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let } x^2 = t, \text{ factor as a quadratic, then substitute back.}",
      r"\textbf{[Transformation]}",
      r"\text{Let } x^2 = t:",
      r"\begin{aligned} x^4 + x^2 - 2 &= t^2 + t - 2 \\ &= (t + 2)(t - 1) \end{aligned}",
      r"\text{Substituting back } t = x^2:",
      r"\begin{aligned} &= (x^2 + 2)(x^2 - 1) \\ &= (x^2 + 2)(x - 1)(x + 1) \end{aligned}",
    ],
  ),
  "2BC52EFA-C75B-4E77-B1E5-E7ECCA113394": ProblemTranslation(
    category: 'Factorization',
    level: 'Easy',
    hint: r"\text{Use the sum of cubes formula } a^3 + b^3 = (a+b)(a^2 - ab + b^2).",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the sum of cubes formula } a^3 + b^3 = (a+b)(a^2 - ab + b^2).",
      r"\textbf{[Transformation]}",
      r"\begin{aligned} x^3 + 125 &= x^3 + 5^3 \\ &= (x + 5)(x^2 - 5x + 25) \end{aligned}",
    ],
  ),
  "79E62DF5-7FEB-4D58-A989-DF5110913E3C": ProblemTranslation(
    category: 'Factorization',
    level: 'Mid',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the factor theorem.}",
      r"\textbf{[Transformation]}",
      r"\text{Substituting } x = -1:",
      r"\begin{aligned} (-1)^4 + 2(-1)^3 + 2(-1)^2 + 2(-1) + 1 &= 1 - 2 + 2 - 2 + 1 = 0 \end{aligned}",
      r"\text{Thus, } x + 1 \text{ is a factor. Dividing } x^4 + 2x^3 + 2x^2 + 2x + 1 \text{ by } x + 1 \text{ gives } x^3 + x^2 + x + 1. \text{ Thus,}",
      r"\begin{aligned} x^4 + 2x^3 + 2x^2 + 2x + 1 &= (x + 1)\textcolor{blue}{(x^3 + x^2 + x + 1)} \end{aligned}",
      r"\text{Next, for } x^3 + x^2 + x + 1, \text{ substituting } x = -1:",
      r"\begin{aligned} (-1)^3 + (-1)^2 + (-1) + 1 &= -1 + 1 - 1 + 1 = 0 \end{aligned}",
      r"\text{Thus, } x^3 + x^2 + x + 1 \text{ also has } x + 1 \text{ as a factor. Dividing by } x + 1 \text{ gives } x^2 + 1. \text{ So,}",
      r"\textcolor{blue}{x^3 + x^2 + x + 1} = \textcolor{red}{(x + 1)(x^2 + 1)}",
      r"\text{Therefore,}",
      r"\begin{aligned} x^4 + 2x^3 + 2x^2 + 2x + 1 &= (x + 1)\textcolor{blue}{(x^3 + x^2 + x + 1)} \\ &= (x + 1)\textcolor{red}{(x + 1)}\textcolor{red}{(x^2 + 1)} \\ &= (x + 1)^2(x^2 + 1) \end{aligned}",
    ],
  ),

  // advanced_factorization.dart
  "BE5B4E1D-4297-4F80-98BC-F74655BF03F9": ProblemTranslation(
    category: 'Factorization',
    level: 'Mid',
    hint: r"\text{Organize by } x \text{ and use the cross-multiplication method (tasukigake) to factor.}",
    steps: [
      r"\textbf{[]}",
      r"\text{Organize by } x \text{ and use the cross-multiplication method (tasukigake) to factor.}",
      r"\textbf{[Transformation]}",
      r"\begin{aligned} 2x^2 + 5xy + 2y^2 - 5x - y - 3 &= 2x^2 + x(5y - 5) + (2y^2 - y - 3) \\ &= 2x^2 + x(5y - 5) + (y+1)(2y-3) \\ &= (2x + y + 1)(x + 2y - 3) \end{aligned}",
    ],
  ),
  "CE7A2246-F134-4248-86EA-31A0502F58F1": ProblemTranslation(
    category: 'Factorization',
    level: 'Mid',
    steps: [
      r"\textbf{[Key Points]}",
      r"\text{Since it is a symmetric expression and the degree is the same for all variables, choose one variable and organize in descending order.}",
      r"\textbf{[Transformation]}",
      r"\begin{aligned} a^2(b-c) + b^2(c-a) + c^2(a-b) &= a^2(b-c) - a b^2 + b^2 c + a c^2 - c^2 b \\ &= a^2(b-c) - a(b^2- c^2) + (b^2 c - c^2 b) \\ &= a^2(b-c) - a(b-c)(b+c) + bc(b-c) \\ &= (b-c)\bigl(a^2 - (b+c)a + bc\bigr) \\ &= (b-c)(a-b)(a-c) \\ &= -(a-b)(b-c)(c-a) \end{aligned}",
    ],
  ),
  "703AE189-789C-4F2D-83A4-55C68DD65991": ProblemTranslation(
    category: 'Factorization',
    level: 'Mid',
    steps: [
      r"\textbf{[Transformation]}",
      r"\begin{aligned} x^4 + x^2 + 1 &= (x^2 + 1)^2 - x^2 \\ &= (x^2 + 1 + x)(x^2 + 1 - x)\\ &= (x^2 + x + 1)(x^2 - x + 1) \end{aligned}",
    ],
  ),
  "DB124FEE-EBB5-4940-B445-2D08B1B87E9A": ProblemTranslation(
    category: 'Factorization',
    level: 'Easy',
    hint: r"\text{Use the difference of cubes formula } a^3 - b^3 = (a-b)(a^2 + ab + b^2).",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the difference of cubes formula } a^3 - b^3 = (a-b)(a^2 + ab + b^2).",
      r"\textbf{[Transformation]}",
      r"\begin{aligned} 27x^3 - 8y^3 &= (3x)^3 - (2y)^3 \\ &= (3x - 2y)(9x^2 + 6xy + 4y^2) \end{aligned}",
    ],
  ),
  "1EC3C384-44E0-4C3B-8FE4-2E3814FD7CB3": ProblemTranslation(
    category: 'Factorization',
    level: 'Mid',
    steps: [
      r"\textbf{[Transformation]}",
      r"\begin{aligned} x^4 + 4 &= (x^2 + 2)^2 - 4x^2 \\ &= (x^2 + 2)^2 - (2x)^2 \\ &= (x^2 + 2 - 2x)(x^2 + 2 + 2x) \\ &= (x^2 - 2x + 2)(x^2 + 2x + 2) \end{aligned}",
    ],
  ),
  "09338EE1-388B-4048-ABC3-CD11A1297220": ProblemTranslation(
    category: 'Factorization',
    level: 'Advanced',
    hint: r"\text{Use the identity } a^3 + b^3 = (a+b)^3 - 3ab(a+b) \text{ twice.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the identity } a^3 + b^3 = (a+b)^3 - 3ab(a+b) \text{ twice.}",
      r"\textbf{[Transformation]}",
      r"\text{1st time: } x^3 + y^3 = (x+y)^3 - 3xy(x+y), \text{ so:}",
      r"\begin{aligned} x^3 + y^3 + z^3 - 3xyz &= (x + y)^3 - 3xy(x + y) + z^3 - 3xyz \\ &= (x + y)^3 + z^3 - 3xy(x + y + z) \end{aligned}",
      r"\text{2nd time: Let } x + y = A:",
      r"\begin{aligned} A^3 + z^3 - 3xy(A + z) &= (A + z)^3 - 3Az(A + z) - 3xy(A + z) \\ &= (A + z)\{(A + z)^2 - 3Az - 3xy\} \\ &= (A + z)(A^2 + 2Az + z^2 - 3Az - 3xy) \\ &= (A + z)(A^2 - Az + z^2 - 3xy) \end{aligned}",
      r"\text{Substituting back } A = x + y:",
      r"\begin{aligned} &= (x + y + z)\{(x + y)^2 - (x + y)z + z^2 - 3xy\} \\ &= (x + y + z)(x^2 + 2xy + y^2 - xz - yz + z^2 - 3xy) \\ &= (x + y + z)(x^2 + y^2 + z^2 - xy - yz - zx) \end{aligned}",
    ],
  ),
  "24D47C58-831B-4D01-A30E-3BD84A0D741E": ProblemTranslation(
    category: 'Factorization',
    level: 'Advanced',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the identity } a^3 + b^3 = (a+b)^3 - 3ab(a+b) \text{ twice.}",
      r"\textbf{[Transformation]}",
      r"\text{1st time: } x^3 + (3y)^3 = (x+3y)^3 - 3x(3y)(x+3y), \text{ so:}",
      r"\begin{aligned} x^3 - 9xy + 27y^3 + 1 &= x^3 + (3y)^3 + 1 - 9xy \\ &= (x + 3y)^3 - 3x(3y)(x + 3y) + 1 - 9xy \\ &= (x + 3y)^3 - 9xy(x + 3y) + 1 - 9xy \\ &= (x + 3y)^3 + 1 - 9xy(x + 3y + 1) \end{aligned}",
      r"\text{2nd time: Let } x + 3y = A:",
      r"\begin{aligned} A^3 + 1 - 9xy(A + 1) &= (A + 1)^3 - 3A(A + 1) - 9xy(A + 1) \\ &= (A + 1)\{(A + 1)^2 - 3A - 9xy\} \\ &= (A + 1)(A^2 + 2A + 1 - 3A - 9xy) \\ &= (A + 1)(A^2 - A + 1 - 9xy) \end{aligned}",
      r"\text{Substituting back } A = x + 3y:",
      r"\begin{aligned} &= (x + 3y + 1)\{(x + 3y)^2 - (x + 3y) + 1 - 9xy\} \\ &= (x + 3y + 1)(x^2 + 6xy + 9y^2 - x - 3y + 1 - 9xy) \\ &= (x + 3y + 1)(x^2 + 9y^2 + 1  - 3xy - 3y - x) \end{aligned}",
      r"\textbf{[Faster Method]}",
      r"\text{Use the factorization } a^3 + b^3 + c^3 - 3abc = (a + b + c)(a^2 + b^2 + c^2 - ab - bc - ca).",
      r"\text{Let } a = x, b = 3y, c = 1:",
      r"\begin{aligned} x^3 - 9xy + 27y^3 + 1 &= x^3 + (3y)^3 + 1^3 - 3x(3y)(1) \\ &= (x + 3y + 1)(x^2 + (3y)^2 + 1^2 - x(3y) - 3y(1) - 1(x)) \\ &= (x + 3y + 1)(x^2 + 9y^2 + 1 - 3xy - 3y - x) \end{aligned}",
    ],
  ),
  "1BD1750A-06EA-42B5-81DB-57091773730C": ProblemTranslation(
    category: 'Factorization',
    level: 'Advanced',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let } f(x)=x^4+9x^3+16x^2-x-3\text{.}",
      r"\text{First, use the factor theorem by testing }x=\pm1,\pm3\text{. If no linear factor exists, factor as (quadratic)}\times\text{(quadratic) and compare coefficients.}",
      r"\textbf{[Transformation]}",
      r"\text{Substituting candidates for the factor theorem:}",
      r"\begin{aligned} f(1) &= 1 + 9 + 16 - 1 - 3 = 22 \neq 0 \\ f(-1) &= 1 - 9 + 16 + 1 - 3 = 6 \neq 0 \\ f(3) &= 81 + 243 + 144 - 3 - 3 = 462 \neq 0 \\ f(-3) &= 81 - 243 + 144 + 3 - 3 = -18 \neq 0 \end{aligned}",
      r"\text{No linear factor is found. Now look for a factorization of the form (quadratic) } \times \text{ (quadratic).}",
      r"\text{Let } f(x) = (x^2 + ax + b)(x^2 + cx + d) \text{ with integer coefficients.}",
      r"\textcolor{red}{Actually,\ the\ calculation\ yields:}",
      r"\textcolor{red}{a = 2,\ b = -1,\ c = 7,\ d = 3}",
      r"\textcolor{red}{Below\ is\ the\ proof.}",
      r"\textbf{[Proof]}",
      r"\text{Since the constant term is }-3\text{, we have }bd=-3\text{.}",
      r"\text{So we test } (b, d) = (1, -3), (-1, 3).",
      r"\textcolor{blue}{Case\ 1:\ } \textcolor{blue}{(b,\ d)\ =\ (1,\ -3)}",
      r"\text{Let } f(x) = (x^2 + ax + 1)(x^2 + cx - 3):",
      r"\begin{aligned} x^4 + 9x^3 + 16x^2 - x - 3 &= (x^2 + ax + 1)(x^2 + cx - 3) \\ &= x^4 + (a+c)x^3 + (ac - 2)x^2 + (-3a + c)x - 3 \end{aligned}",
      r"\text{Comparing coefficients:}",
      r"\begin{aligned} \text{3rd deg: } a + c = 9 \ \cdots (1) \\ \text{2nd deg: } ac - 2 = 16 \ \cdots (2) \\ \text{1st deg: } -3a + c = -1 \ \cdots (3) \end{aligned}",
      r"\text{From (2) and (1), } ac = 18 \text{ and } a + c = 9, \text{ so } (a,c)=(6,3)\text{ or }(3,6)\text{.}",
      r"\text{Substituting into (3):}",
      r"$-3a + c = -3 \cdot 6 + 3 = -15 \neq -1$",
      r"$-3a + c = -3 \cdot 3 + 6 = -3 \neq -1$",
      r"\textcolor{red}{Thus,\ this\ case\ does\ not\ satisfy\ (3).}",
      r"\textcolor{blue}{Case\ 2:\ } \textcolor{blue}{(b,\ d)\ =\ (-1,\ 3)}",
      r"\text{Let } f(x) = (x^2 + ax - 1)(x^2 + cx + 3):",
      r"\begin{aligned} x^4 + 9x^3 + 16x^2 - x - 3 &= (x^2 + ax - 1)(x^2 + cx + 3) \\ &= x^4 + (a+c)x^3 + (ac + 2)x^2 + (3a - c)x - 3 \end{aligned}",
      r"\text{Comparing coefficients:}",
      r"\begin{aligned} \text{3rd deg: } a + c = 9 \ \cdots (1) \\ \text{2nd deg: } ac + 2 = 16 \ \cdots (2) \\ \text{1st deg: } 3a - c = -1 \ \cdots (3) \end{aligned}",
      r"\text{From (2) and (1), } ac = 14 \text{ and } a + c = 9, \text{ so } (a,c)=(7,2)\text{ or }(2,7)\text{.}",
      r"\text{Substituting into (3):}",
      r"3a - c = 3 \cdot 7 - 2 = 19 \neq -1",
      r"3a - c = 3 \cdot 2 - 7 = -1",
      r"\text{The second pair satisfies (3).}",
      r"\textcolor{green}{Therefore,\ } (a, b, c, d) = (2, -1, 7, 3).",
      r"\textcolor{green}{\begin{aligned} x^4 + 9x^3 + 16x^2 - x - 3 &= (x^2 + 2x - 1)(x^2 + 7x + 3) \end{aligned}}",
    ],
  ),
  "3A5214AB-C386-4C28-AA01-886809BDE55A": ProblemTranslation(
    category: 'Factorization',
    level: 'Advanced',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the factor theorem.}",
      r"\textbf{[Transformation]}",
      r"\text{Substituting } x = -1:",
      r"\begin{aligned} (-1)^5 + (-1)^4 + (-1)^3 + (-1)^2 + (-1) + 1 &= -1 + 1 - 1 + 1 - 1 + 1 = 0 \end{aligned}",
      r"\text{Thus, } x + 1 \text{ is a factor. The expression factors as:}",
      r"\begin{aligned} x^5 + x^4 + x^3 + x^2 + x + 1 &= (x + 1) \textcolor{blue}{(x^4 + x^2 + 1)} \end{aligned}",
      r"\text{Next, factor } x^4 + x^2 + 1:",
      r"\begin{aligned} \textcolor{blue}{x^4 + x^2 + 1} &= (x^2 + 1)^2 - x^2 \\ &= (x^2 + 1 + x)(x^2 + 1 - x) \\ &= \textcolor{red}{(x^2 + x + 1)(x^2 - x + 1)} \end{aligned}",
      r"\text{Therefore,}",
      r"\begin{aligned} x^5 + x^4 + x^3 + x^2 + x + 1 = (x + 1)\textcolor{red}{(x^2 + x + 1)}\textcolor{red}{(x^2 - x + 1)} \end{aligned}",
    ],
  ),
  "227D1ED5-9BAE-49E1-BD62-02531FB8ADF1": ProblemTranslation(
    category: 'Factorization',
    level: 'Advanced',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let } f(x)=x^5-x^4-1\text{. First, test the factor theorem candidates } \pm 1 \text{ to confirm there is no linear factor. Then assume a (quadratic)}\times\text{(cubic) factorization and compare coefficients.}",
      r"\textbf{[Transformation]}",
      r"\text{Substituting the candidates for the factor theorem:}",
      r"""\begin{aligned}
f(1) &= 1 - 1 - 1 = -1 \neq 0 \\
f(-1) &= -1 - 1 - 1 = -3 \neq 0
\end{aligned}""",
      r"\text{Therefore, there is no linear factor. So we look for a factorization of the form (quadratic)}\times\text{(cubic).}",
      r"\text{Assume, with integer coefficients, } f(x) = (x^2 + ax + \alpha)(x^3 + bx^2 + cx + \beta)\text{.}",
      r"\textcolor{red}{In\ fact,\ the\ calculation\ gives\ the\ following.}",
      r"\textcolor{red}{a = -1,\ b = 0,\ c = -1,\ \alpha = 1,\ \beta = -1}",
      r"\textcolor{red}{We\ prove\ this\ below.}",
      r"\textbf{[Proof]}",
      r"\text{Since the constant term of }x^5 - x^4 - 1\text{ is }-1\text{, we have }\alpha\beta = -1\text{. So we consider }(\alpha,\beta)=(1,-1),\ (-1,1)\text{.}",
      r"\textcolor{blue}{1. } \textcolor{blue}{When\ } \textcolor{blue}{(\alpha, \beta) = (1, -1)}",
      r"\text{Let } f(x) = (x^2 + ax + 1)(x^3 + bx^2 + cx - 1)\text{. Then}",
      r"""\begin{aligned}
&\ \ \ \ x^5 - x^4 - 1 \\
&= (x^2 + ax + 1)(x^3 + bx^2 + cx - 1) \\
&= x^5 + (a+b)x^4 + (ab + c + 1)x^3 + (ac + b - 1)x^2 + (- a + c)x - 1
\end{aligned}""",
      r"\text{Comparing coefficients:}",
      r"""
      \begin{aligned}
&\text{4th deg: } a + b = -1\ \cdots (1) \\[2pt]
&\text{3rd deg: } ab + c + 1 = 0\ \ \cdots (2) \\[2pt]
&\text{2nd deg: } ac + b - 1 = 0\ \ \cdots (3) \\[2pt]
&\text{1st deg: } -a + c = 0\ \ \cdots (4)
\end{aligned}""",
      r"\text{From (4) and (1), } c = a \text{ and } b = -1 - a\text{. Substitute into (2):}",
      r"""a(-1 - a) + a + 1 = -a - a^2 + a + 1 = -a^2 + 1 = 0 \text{, hence } a^2 = 1""",
      r"\text{Thus, } a = 1 \text{ or } a = -1\text{.}",
      r"\textcolor{blue}{(i)\ } \textcolor{blue}{When\ } \textcolor{blue}{a\ =\ 1}",
      r"\text{Then } b = -2,\ c = 1\text{. From (3):}",
      r"""\begin{aligned}
ac + b - 1 &= 1 \cdot 1 + (-2) - 1 = -2 \neq 0
\end{aligned}""",
      r"\textcolor{red}{So\ this\ case\ does\ not\ satisfy\ (3).}",
      r"\textcolor{blue}{(ii)\ } \textcolor{blue}{When\ } \textcolor{blue}{a\ =\ -1}",
      r"\text{Then } b = 0,\ c = -1\text{. From (3):}",
      r"""\begin{aligned}
ac + b - 1 &= (-1) \cdot (-1) + 0 - 1 = 0
\end{aligned}""",
      r"\textcolor{green}{Therefore,\ it\ satisfies\ (3),\ and\ the\ solution\ to\ the\ system\ (1)–(4)\ is:}",
      r"\textcolor{green}{a = -1, \quad b = 0, \quad c = -1}",
      r"\textcolor{green}{Hence,\ }\textcolor{green}{ (a, b, c, \alpha, \beta) = (-1, 0, -1, 1, -1)}\textcolor{green}{,\ and\ the\ answer\ is}",
      r"\textcolor{green}{ x^5 - x^4 - 1 = (x^2 - x + 1)(x^3 - x - 1)}",
      r"\textcolor{brown}{\large{We\ have\ obtained\ the\ answer,\ but\ for\ completeness,}}",
      r"\textcolor{brown}{\large{we\ confirm\ below\ that\ there\ are\ no\ other\ solutions.}}",
      r"\textcolor{blue}{2. } \textcolor{blue}{When\ } \textcolor{blue}{(\alpha, \beta) = (-1, 1)}",
      r"\text{Let } f(x) = (x^2 + ax - 1)(x^3 + bx^2 + cx + 1)\text{. Then}",
      r"""\begin{aligned}
&\ \ \ \ x^5 - x^4 - 1 \\
&= (x^2 + ax - 1)(x^3 + bx^2 + cx + 1) \\
&= x^5 + (a+b)x^4 + (ab + c - 1)x^3 + (ac - b + 1)x^2 + (a - c)x - 1
\end{aligned}""",
      r"\text{Comparing coefficients:}",
      r"""
      \begin{aligned}
&\text{4th deg: } a + b = -1\ \cdots (1) \\[2pt]
&\text{3rd deg: } ab + c - 1 = 0\ \ \cdots (2) \\[2pt]
&\text{2nd deg: } ac - b + 1 = 0\ \ \cdots (3) \\[2pt]
&\text{1st deg: } a - c = 0\ \ \cdots (4)
\end{aligned}""",
      r"\text{From (4) and (1), } c = a \text{ and } b = -1 - a\text{. Substitute into (2):}",
      r"""a(-1 - a) + a - 1 = -a - a^2 + a - 1 = -a^2 - 1 = 0 \text{, hence } a^2 = -1""",
      r"\textcolor{red}{This\ has\ no\ real\ solution.}",
    ],
  ),

  // basic_factorization_reserve.dart
  "14E178D7-FC09-4439-B145-92688182FC44": ProblemTranslation(
    category: 'Factorization',
    level: 'Easy',
    question: r"""9x^2 - 24xy + 16y^2""",
    answer: r"""(3x - 4y)^2""",
    steps: [
      r"\textbf{[Transformation]}",
      r"\begin{aligned} 9x^2 - 24xy + 16y^2 &= (3x)^2 - 2(3x)(4y) + (4y)^2 \\ &= (3x-4y)^2 \end{aligned}",
    ],
  ),
  "7D86EF83-52D7-4F6D-9A35-E085E17DA59C": ProblemTranslation(
    category: 'Factorization',
    level: 'Easy',
    question: r"""49x^2 - 36y^2""",
    answer: r"""(7x - 6y)(7x + 6y)""",
    steps: [
      r"\textbf{[Transformation]}",
      r"\begin{aligned} 49x^2 - 36y^2 &= (7x)^2-(6y)^2 \\ &= (7x-6y)(7x+6y) \end{aligned}",
    ],
  ),
  "51B65EA2-37AB-48F9-ACBE-2482B9740A10": ProblemTranslation(
    category: 'Factorization',
    level: 'Easy',
    question: r"""x^2 + 8xy + 16y^2""",
    answer: r"""(x + 4y)^2""",
    steps: [
      r"\textbf{[Transformation]}",
      r"\begin{aligned} x^2 + 8xy + 16y^2 &= x^2 + 2x(4y) + (4y)^2 \\ &= (x+4y)^2 \end{aligned}",
    ],
  ),
  "3CEFDD7D-4880-48DF-ABD8-7779C2D0F2C5": ProblemTranslation(
    category: 'Factorization',
    level: 'Easy',
    question: r"""x^2 - 7x - 18""",
    answer: r"""(x - 9)(x + 2)""",
    steps: [
      r"\textbf{[Key Point]}",
      r"\text{Find two numbers whose product is }-18\text{ and sum is }-7\text{: }-9,\ 2\text{.}",
      r"\textbf{[Transformation]}",
      r"\begin{aligned} x^2 - 7x - 18 &= (x-9)(x+2) \end{aligned}",
    ],
  ),
  "93BDE66A-D463-457F-A1C0-249A521A0B81": ProblemTranslation(
    category: 'Factorization',
    level: 'Easy',
    question: r"""4x^3y - 9xy^3""",
    answer: r"""xy(2x-3y)(2x+3y)""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Factor out the common factor }xy\text{, then use the difference of squares.}",
      r"\textbf{[Transformation]}",
      r"\begin{aligned} 4x^3y - 9xy^3 &= xy(4x^2-9y^2) \\ &= xy\bigl((2x)^2-(3y)^2\bigr) \\ &= xy(2x-3y)(2x+3y) \end{aligned}",
    ],
  ),
  "A73464B2-66D9-47E5-8069-94AC68CDB90F": ProblemTranslation(
    category: 'Factorization',
    level: 'Easy',
    question: r"""ab - bc + cd - da""",
    answer: r"""(a-c)(b-d)""",
    hint: r"""\text{Group terms by }a\text{ and }c\text{.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Group terms by }a\text{ and }c\text{.}",
      r"\textbf{[Transformation]}",
      r"\begin{aligned} ab - bc + cd - da &= ab - da - bc + cd \\ &= a(b-d)-c(b-d) \\ &= (a-c)(b-d) \end{aligned}",
    ],
  ),
  "B9C0D1E2-F3A4-5B6C-7D8E-9F0A1B2C3D4": ProblemTranslation(
    category: 'Factorization',
    level: 'Mid',
    question: r"""x^3 - 2x^2 - 5x + 6""",
    answer: r"""(x - 1)(x - 3)(x + 2)""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the factor theorem. Since the constant term is }6\text{, test } \pm 1,\pm 2,\pm 3,\pm 6\text{.}",
      r"\textbf{[Check]}",
      r"\textbf{[Explanation]}",
      r"\begin{aligned} f(1) &= 1-2-5+6=0 \end{aligned}",
      r"\text{Thus }x-1\text{ is a factor. Divide to get }x^2-x-6=(x-3)(x+2)\text{.}",
      r"\begin{aligned} x^3 - 2x^2 - 5x + 6 &= (x-1)(x^2-x-6) \\ &= (x-1)(x-3)(x+2) \end{aligned}",
    ],
  ),
  // (reserve / commented-out in source)
  "9071E13B-4683-43DD-A5FF-E79B318DD996": ProblemTranslation(
    category: 'Factorization',
    level: 'Easy',
    question: r"""x^4 + x^3 - 6x^2 - 4x + 8""",
    answer: r"""(x - 1)(x - 2)(x + 2)^2""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the factor theorem. Since the constant term is }8\text{, test } \pm 1,\pm 2,\pm 4,\pm 8\text{.}",
      r"\textbf{[Check]}",
      r"\begin{aligned} f(1) &= 1+1-6-4+8=0 \end{aligned}",
      r"\text{Thus }x-1\text{ is a factor. Divide to obtain }x^3+2x^2-4x-8\text{.}",
      r"\text{Apply the factor theorem again:}",
      r"\begin{aligned} g(2) &= 8+8-8-8=0 \end{aligned}",
      r"\text{Thus }x-2\text{ is a factor and }x^3+2x^2-4x-8=(x-2)(x^2+4x+4)=(x-2)(x+2)^2\text{.}",
      r"\begin{aligned} x^4 + x^3 - 6x^2 - 4x + 8 &= (x-1)(x-2)(x+2)^2 \end{aligned}",
    ],
  ),

  // mid_factorization_reserve.dart
  "A5BA5B5C-1557-48C1-B4D3-7C57FC5E3A41": ProblemTranslation(
    category: 'Factorization',
    level: 'Mid',
    question: r"""a^3 - 4a b^2 - 4b^2 c + a^2 c""",
    answer: r"""(a-2b)(a+2b)(a+c)""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Group terms by }c\text{ (it appears only linearly).}",
      r"\textbf{[Transformation]}",
      r"\text{Collecting terms in }c\text{:}",
      r"\begin{aligned} a^3 - 4ab^2 - 4b^2c + a^2c &= c(a^2-4b^2) + a^3 - 4ab^2 \\ &= c(a^2-4b^2) + a(a^2-4b^2) \\ &= (a+c)(a^2-4b^2) \\ &= (a+c)(a-2b)(a+2b) \end{aligned}",
    ],
  ),
  "34A820FC-E504-47F2-BBF4-741670A417AE": ProblemTranslation(
    category: 'Factorization',
    level: 'Mid',
    question: r"""x^4 + 3x^2 - 4""",
    answer: r"""(x^2 + 4)(x - 1)(x + 1)""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let }t=x^2\text{ to treat it as a quadratic.}",
      r"\textbf{[Transformation]}",
      r"\text{Let }t=x^2\text{. Then}",
      r"\begin{aligned} x^4+3x^2-4 &= t^2+3t-4 \\ &= (t+4)(t-1) \end{aligned}",
      r"\text{Substitute }t=x^2\text{ back:}",
      r"\begin{aligned} (t+4)(t-1) &= (x^2+4)(x^2-1) \\ &= (x^2+4)(x-1)(x+1) \end{aligned}",
    ],
  ),
  "A60F2EC9-A23B-420B-89BE-6D8708B0DFA8": ProblemTranslation(
    category: 'Factorization',
    level: 'Easy',
    question: r"""x^3 + 64""",
    answer: r"""(x + 4)(x^2 - 4x + 16)""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the sum of cubes formula } a^3+b^3=(a+b)(a^2-ab+b^2)\text{.}",
      r"\textbf{[Transformation]}",
      r"\begin{aligned} x^3+64 &= x^3+4^3 \\ &= (x+4)(x^2-4x+16) \end{aligned}",
    ],
  ),
  "8C5A89E9-86F8-4300-9179-3C9CF22FDF90": ProblemTranslation(
    category: 'Factorization',
    level: 'Mid',
    question: r"""x^4 - 3x^3 + 3x^2 - 3x + 2""",
    answer: r"""(x - 1)(x - 2)(x^2 + 1)""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the factor theorem. Test small integer roots suggested by the constant term }2\text{.}",
      r"\textbf{[Transformation]}",
      r"\textbf{[Check }x=1\textbf{]}",
      r"\begin{aligned} f(1) &= 1-3+3-3+2=0 \end{aligned}",
      r"\text{So }x-1\text{ is a factor. Divide to get }x^3-2x^2+x-2\text{.}",
      r"\text{Now apply the factor theorem to }x^3-2x^2+x-2\text{.}",
      r"\textbf{[Check }x=2\textbf{]}",
      r"\begin{aligned} 2^3-2\cdot 2^2+2-2 &= 8-8+2-2=0 \end{aligned}",
      r"\text{So }x-2\text{ is a factor and }x^3-2x^2+x-2=(x-2)(x^2+1)\text{.}",
      r"\begin{aligned} x^3-2x^2+x-2 &= (x-2)(x^2+1) \end{aligned}",
      r"\textbf{[Final]}",
      r"\begin{aligned} x^4 - 3x^3 + 3x^2 - 3x + 2 &= (x-1)(x^3-2x^2+x-2) \\ &= (x-1)(x-2)(x^2+1) \end{aligned}",
    ],
  ),

  // advanced_factorization_reserve.dart
  "656CDF93-3968-4527-81AE-9376B3E5B66B": ProblemTranslation(
    category: 'Factorization',
    level: 'Mid',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Treat it as a quadratic in }x\text{ and factor by cross-multiplication.}",
      r"\textbf{[Transformation]}",
      r"\begin{aligned} 3x^2 + 8xy + 4y^2 - 11x - 6y - 4 &= 3x^2 + x(8y-11) + (4y^2-6y-4) \\ &= 3x^2 + x(8y-11) + 2(2y+1)(y-2) \\ &= (3x+2y+1)(x+2y-4) \end{aligned}",
    ],
  ),
  "FAA00A56-4049-4921-A9C8-93B3F420DA1C": ProblemTranslation(
    category: 'Factorization',
    level: 'Mid',
    steps: [
      r"\textbf{[Key Point]}",
      r"\text{This is a symmetric expression. Collect terms as a polynomial in one variable (e.g., }a\text{).}",
      r"\textbf{[Transformation]}",
      r"\text{Collecting terms in }a\text{:}",
      r"\begin{aligned} a(b^2+c^2)+b(c^2+a^2)+c(a^2+b^2)+2abc &= ab^2+ac^2+bc^2+ba^2+ca^2+cb^2+2abc \\ &= a^2(b+c)+a(b^2+c^2+2bc)+bc(b+c) \\ &= a^2(b+c)+a(b+c)^2+bc(b+c) \\ &= (b+c)\bigl(a^2+a(b+c)+bc\bigr) \\ &= (b+c)(a+b)(a+c) \\ &= (a+b)(b+c)(c+a) \end{aligned}",
    ],
  ),
  "CAF59AF0-A107-4D21-B0E3-2C3D888A83D2": ProblemTranslation(
    category: 'Factorization',
    level: 'Mid',
    steps: [
      r"\textbf{[Transformation]}",
      r"\begin{aligned} x^4+5x^2+9 &= (x^2+3)^2-x^2 \\ &= (x^2+3+x)(x^2+3-x) \\ &= (x^2+x+3)(x^2-x+3) \end{aligned}",
    ],
  ),
  "7AF1A86F-615F-4E44-AEE8-F3BA22B7E6CC": ProblemTranslation(
    category: 'Factorization',
    level: 'Easy',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the difference of cubes } a^3-b^3=(a-b)(a^2+ab+b^2).",
      r"\textbf{[Transformation]}",
      r"\begin{aligned} 64x^3-27y^3 &= (4x)^3-(3y)^3 \\ &= (4x-3y)(16x^2+12xy+9y^2) \end{aligned}",
    ],
  ),
  "E406BD56-74DE-4603-9695-AE08B0757BE7": ProblemTranslation(
    category: 'Factorization',
    level: 'Mid',
    steps: [
      r"\textbf{[Transformation]}",
      r"\begin{aligned} x^4+4y^4 &= (x^2+2y^2)^2-(2xy)^2 \\ &= (x^2+2y^2-2xy)(x^2+2y^2+2xy) \\ &= (x^2-2xy+2y^2)(x^2+2xy+2y^2) \end{aligned}",
    ],
  ),
  "F1A2B3C4-D5E6-F7A8-B9C0-D1E2F3A4B5C6": ProblemTranslation(
    category: 'Factorization',
    level: 'Advanced',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use } a^3+b^3+c^3-3abc=(a+b+c)(a^2+b^2+c^2-ab-bc-ca).",
      r"\textbf{[Transformation]}",
      r"\text{Let } a=y-z,\ b=z-x,\ c=x-y\text{.}",
      r"""\begin{aligned}
 a+b+c &= (y-z)+(z-x)+(x-y)\\
 &= y-z+z-x+x-y\\
 &= 0
 \end{aligned}""",
      r"\text{Therefore, since }a+b+c=0\text{, the identity gives }a^3+b^3+c^3=3abc\text{.}",
      r"""\begin{aligned}
 (y-z)^3+(z-x)^3+(x-y)^3 &= a^3+b^3+c^3\\
 &= 3abc\\
 &= 3(y-z)(z-x)(x-y)
 \end{aligned}""",
    ],
  ),
  "6C4F2FA4-742F-474E-8103-E3BA3E979350": ProblemTranslation(
    category: 'Factorization',
    level: 'Advanced',
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the identity } a^3+b^3=(a+b)^3-3ab(a+b) \text{ twice.}",
      r"\textbf{[Transformation]}",
      r"\text{First: } a^3+(-2b)^3=(a-2b)^3-3a(-2b)(a-2b)\text{, so}",
      r"""\begin{aligned}
&\ \ \ \ a^3 + 18ab - 8b^3 + 27 \\
&= a^3 + (-2b)^3 + 27 + 18ab \\
&= (a - 2b)^3 - 3a(-2b)(a - 2b) + 27 + 18ab \\
&= (a - 2b)^3 + 6ab(a - 2b) + 27 + 18ab \\
&= (a - 2b)^3 + 27 + 6ab(a - 2b + 3)
\end{aligned}""",
      r"\text{Second: let }A=a-2b\text{. Then}",
      r"""\begin{aligned}
&\ \ \ \ A^3 + 27 + 6ab(A + 3) \\
&= (A + 3)^3 - 3A(A + 3) + 6ab(A + 3) \\
&= (A + 3)\{(A + 3)^2 - 3A + 6ab\} \\
&= (A + 3)(A^2 + 6A + 9 - 3A + 6ab) \\
&= (A + 3)(A^2 + 3A + 9 + 6ab)
\end{aligned}""",
      r"\text{Substitute back }A=a-2b\text{:}",
      r"""\begin{aligned}
&= (a - 2b + 3)\{(a - 2b)^2 + 3(a - 2b) + 9 + 6ab\} \\
&= (a - 2b + 3)(a^2 - 4ab + 4b^2 + 3a - 6b + 9 + 6ab) \\
&= (a - 2b + 3)(a^2 + 4b^2 + 9 + 2ab - 3a + 6b)
\end{aligned}""",
      r"\textbf{[Fast Method]}",
      r"\text{Use } a^3+b^3+c^3-3abc=(a+b+c)(a^2+b^2+c^2-ab-bc-ca).",
      r"\text{Set } a=a,\ b=-2b,\ c=3\text{. Then}",
      r"""\begin{aligned}
a^3 + 18ab - 8b^3 + 27
&= a^3 + (-2b)^3 + 3^3 - 3a(-2b)(3) \\
&= (a - 2b + 3)(a^2 + (-2b)^2 + 3^2 - a(-2b) - (-2b)(3) - 3a) \\
&= (a - 2b + 3)(a^2 + 4b^2 + 9 + 2ab + 6b - 3a) \\
&= (a - 2b + 3)(a^2 + 4b^2 + 9 + 2ab - 3a + 6b)
\end{aligned}""",
    ],
  ),
  "C66CEC49-FCD7-42E2-9FF5-628A431A8550": ProblemTranslation(
    category: 'Factorization',
    level: 'Advanced',
    hint: r"\text{Try a quadratic} \times \text{quadratic factorization and compare coefficients.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let }f(x)=x^4-4x^3+5x^2-4x+1\text{.}",
      r"\text{First test }x=\pm1\text{. If there is no linear factor, factor as (quadratic)}\times\text{(quadratic) and compare coefficients.}",
      r"\textbf{[Transformation]}",
      r"\text{Check the factor theorem candidates:}",
      r"""\begin{aligned}
 f(1) &= 1-4+5-4+1=-1\neq 0\\
 f(-1) &= 1+4+5+4+1=15\neq 0
 \end{aligned}""",
      r"\text{So there is no linear factor.}",
      r"\text{We now search for a factorization }(x^2+ax+b)(x^2+cx+d)\text{ with integers.}",
      r"\text{Since the constant term is }1\text{, we have }bd=1\text{.}",
      r"\text{So we only need to consider }(b,d)=(-1,-1)\text{ or }(1,1)\text{.}",
      r"\textbf{[Proof]}",
      r"\textcolor{blue}{1. }\textcolor{blue}{\ Case\ }(b,d)=(-1,-1)",
      r"\text{Assume }f(x)=(x^2+ax-1)(x^2+cx-1)\text{. Then}",
      r"""\begin{aligned}
 x^4-4x^3+5x^2-4x+1
 &= (x^2+ax-1)(x^2+cx-1)\\
 &= x^4+(a+c)x^3+(ac-2)x^2+(-a-c)x+1
 \end{aligned}""",
      r"\text{Comparing coefficients:}",
      r"""\begin{aligned}
 &\text{3rd deg: } a+c=-4\ \cdots (1)\\
 &\text{2nd deg: } ac-2=5\ \cdots (2)\\
 &\text{1st deg: } -a-c=-4\ \cdots (3)
 \end{aligned}""",
      r"\text{From (3), }-a-c=-4\Rightarrow a+c=4\text{.}",
      r"\textcolor{red}{But\ (1)\ requires\ }a+c=-4\text{.}",
      r"\textcolor{red}{This\ is\ a\ contradiction.}",
      r"\textcolor{red}{So\ this\ case\ has\ no\ solution.}",
      r"\textcolor{blue}{2. }\textcolor{blue}{\ Case\ }(b,d)=(1,1)",
      r"\text{Assume }f(x)=(x^2+ax+1)(x^2+cx+1)\text{. Then}",
      r"""\begin{aligned}
 x^4-4x^3+5x^2-4x+1
 &= (x^2+ax+1)(x^2+cx+1)\\
 &= x^4+(a+c)x^3+(ac+2)x^2+(a+c)x+1
 \end{aligned}""",
      r"\text{Comparing coefficients:}",
      r"""\begin{aligned}
 &\text{3rd deg: } a+c=-4\ \cdots (1)\\
 &\text{2nd deg: } ac+2=5\ \cdots (2)\\
 &\text{1st deg: } a+c=-4\ \cdots (3)
 \end{aligned}""",
      r"\text{From (2), }ac=3\text{.}",
      r"\text{Together with (1), }a+c=-4\text{.}",
      r"\text{So }(a,c)=(-1,-3)\text{ or }(-3,-1)\text{.}",
      r"\textcolor{green}{In\ either\ order,\ the\ factorization\ is\ the\ same:}",
      r"""\textcolor{green}{\begin{aligned}
 x^4-4x^3+5x^2-4x+1 &= (x^2-x+1)(x^2-3x+1)
 \end{aligned}}""",
    ],
  ),
  "B38E9107-4CB3-4966-AAA8-6966FC3F8B17": ProblemTranslation(
    category: 'Factorization',
    level: 'Advanced',
    hint: r"\text{Use the factor theorem with }x=-1\text{.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use the factor theorem.}",
      r"\textbf{[Transformation]}",
      r"\text{Substitute }x=-1\text{:}",
      r"""\begin{aligned}
 &\ \ \ \ (-1)^7+(-1)^6+(-1)^5+(-1)^4+(-1)^3+(-1)^2+(-1)+1\\
 &= -1+1-1+1-1+1-1+1\\
 &= 0
 \end{aligned}""",
      r"\text{Hence }x+1\text{ is a factor, and we can write:}",
      r"\begin{aligned} x^7+x^6+x^5+x^4+x^3+x^2+x+1 &= (x+1)(x^6+x^4+x^2+1). \end{aligned}",
      r"\text{Next, factor }x^6+x^4+x^2+1\text{ by grouping.}",
      r"\begin{aligned} x^6+x^4+x^2+1 &= (x^6+x^4)+(x^2+1) \\ &= x^4(x^2+1)+(x^2+1) \\ &= (x^4+1)(x^2+1). \end{aligned}",
      r"\text{Therefore,}",
      r"\begin{aligned} x^7+x^6+x^5+x^4+x^3+x^2+x+1 &= (x+1)(x^4+1)(x^2+1). \end{aligned}",
    ],
  ),
  "8207893B-5988-4EF1-80C7-74D75FECFE3E": ProblemTranslation(
    category: 'Factorization',
    level: 'Advanced',
    hint: r"\text{Assume a quadratic} \times \text{cubic factorization and compare coefficients.}",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Let } f(x)=x^5+x^4+1\text{. First, test the factor theorem candidates } \pm 1 \text{ to confirm there is no linear factor. Then assume a (quadratic)}\times\text{(cubic) factorization and compare coefficients.}",
      r"\textbf{[Transformation]}",
      r"\text{Substituting the candidates for the factor theorem:}",
      r"""\begin{aligned}
 f(1) &= 1 + 1 + 1 = 3 \neq 0 \\
 f(-1) &= -1 + 1 + 1 = 1 \neq 0
 \end{aligned}""",
      r"\text{Therefore, there is no linear factor. So we look for a factorization of the form (quadratic)}\times\text{(cubic).}",
      r"\text{Assume, with integer coefficients, } f(x) = (x^2 + ax + \alpha)(x^3 + bx^2 + cx + \beta)\text{.}",
      r"\textcolor{red}{In\ fact,\ the\ calculation\ gives\ the\ following.}",
      r"\textcolor{red}{a = 1,\ b = 0,\ c = -1,\ \alpha = 1,\ \beta = 1}",
      r"\textcolor{red}{We\ prove\ this\ below.}",
      r"\textbf{[Proof]}",
      r"\text{Since the constant term of }x^5 + x^4 + 1\text{ is }1\text{, we have }\alpha\beta = 1\text{. So we consider }(\alpha,\beta)=(1,1),\ (-1,-1)\text{.}",
      r"\textcolor{blue}{1. } \textcolor{blue}{When\ } \textcolor{blue}{(\alpha, \beta) = (1, 1)}",
      r"\text{Let } f(x) = (x^2 + ax + 1)(x^3 + bx^2 + cx + 1)\text{. Then}",
      r"""\begin{aligned}
 &\ \ \ \ x^5 + x^4 + 1 \\
 &= (x^2 + ax + 1)(x^3 + bx^2 + cx + 1) \\
 &= x^5 + (a+b)x^4 + (ab + c + 1)x^3 + (ac + b + 1)x^2 + (a + c)x + 1
 \end{aligned}""",
      r"\text{Comparing coefficients:}",
      r"""
      \begin{aligned}
 &\text{4th deg: } a + b = 1\ \cdots (1) \\[2pt]
 &\text{3rd deg: } ab + c + 1 = 0\ \ \cdots (2) \\[2pt]
 &\text{2nd deg: } ac + b + 1 = 0\ \ \cdots (3) \\[2pt]
 &\text{1st deg: } a + c = 0\ \ \cdots (4)
 \end{aligned}""",
      r"\text{From (4) and (1), } c = -a \text{ and } b = 1 - a\text{. Substitute into (2):}",
      r"""a(1 - a) - a + 1 = a - a^2 - a + 1 = -a^2 + 1 = 0 \text{, hence } a^2 = 1""",
      r"\text{Thus, } a = 1 \text{ or } a = -1\text{.}",
      r"\textcolor{blue}{(i)\ } \textcolor{blue}{When\ } \textcolor{blue}{a\ =\ 1}",
      r"\text{Then } b = 0,\ c = -1\text{. From (3):}",
      r"""\begin{aligned}
 ac + b + 1 &= 1 \cdot (-1) + 0 + 1 = 0
 \end{aligned}""",
      r"\text{Therefore, it satisfies (3), and the solution to the system (1)–(4) is:}",
      r"""\textcolor{green}{\begin{aligned}
 a = 1, \quad b = 0, \quad c = -1
 \end{aligned}}""",
      r"\textcolor{green}{Hence,\ } \textcolor{green}{(a, b, c, \alpha, \beta) = (1, 0, -1, 1, 1)}\textcolor{green}{,\ and\ the\ answer\ is}",
      r"\textcolor{green}{\ x^5\ +\ x^4\ +\ 1\ =\ (x^2\ +\ x\ +\ 1)(x^3\ -\ x\ +\ 1)\ }",
      r"\textcolor{brown}{\large{We\ have\ obtained\ the\ answer,\ but\ for\ completeness,}}",
      r"\textcolor{brown}{\large{we\ confirm\ below\ that\ there\ are\ no\ other\ solutions.}}",
      r"\textcolor{blue}{(ii)\ } \textcolor{blue}{When\ } \textcolor{blue}{a\ =\ -1}",
      r"\text{Then } b = 2,\ c = 1\text{. From (3):}",
      r"""\begin{aligned}
 ac + b + 1 &= (-1) \cdot 1 + 2 + 1 = 2 \neq 0
 \end{aligned}""",
      r"\textcolor{red}{So\ this\ case\ does\ not\ satisfy\ (3).}",
      r"\textcolor{blue}{2. } \textcolor{blue}{When\ } \textcolor{blue}{(\alpha, \beta) = (-1, -1)}",
      r"\text{Let } f(x) = (x^2 + ax - 1)(x^3 + bx^2 + cx - 1)\text{. Then}",
      r"""\begin{aligned}
 &\ \ \ \ x^5 + x^4 + 1 \\
 &= (x^2 + ax - 1)(x^3 + bx^2 + cx - 1) \\
 &= x^5 + (a+b)x^4 + (ab + c - 1)x^3 + (ac - b - 1)x^2 + (a + c)x + 1
 \end{aligned}""",
      r"\text{Comparing coefficients:}",
      r"""
      \begin{aligned}
 &\text{4th deg: } a + b = 1\ \cdots (1) \\[2pt]
 &\text{3rd deg: } ab + c - 1 = 0\ \ \cdots (2) \\[2pt]
 &\text{2nd deg: } ac - b - 1 = 0\ \ \cdots (3) \\[2pt]
 &\text{1st deg: } a + c = 0\ \ \cdots (4)
 \end{aligned}""",
      r"\text{From (4) and (1), } c = -a \text{ and } b = 1 - a\text{. Substitute into (2):}",
      r"""\text{From (2), } a(1 - a) - a - 1 = a - a^2 - a - 1 = -a^2 - 1 = 0 \text{, hence } a^2 = -1""",
      r"\textcolor{red}{This\ has\ no\ real\ solution.}",
    ],
  ),
};
