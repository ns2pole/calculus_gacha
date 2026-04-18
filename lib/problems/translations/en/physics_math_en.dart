import '../../../models/problem_translation.dart';

final Map<String, ProblemTranslation> physicsMathTranslationsEn = {
  // uniform_acceleration_problems.dart
  "5FDE5472-2F31-46C7-89A5-F564360CD6C5": ProblemTranslation(
    category: 'General - 1st Order - Non-homogeneous',
    level: 'Easy',
    constants: r"""g: constant""",
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• Differential equation for velocity change in free fall.}""",
      r"""\text{• In mechanics, it often appears as } v'(t) = g \text{. This represents the velocity change of a particle under gravity.}""",
      r"""\textcolor{brown}{\large{[Correspondence\ between\ problem\ symbols\ and\ mechanics\ symbols]}}""",
      r"""\text{Velocity change in free fall}""",
      r"""v'(t) = g""",
      r"""\text{• } f(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } g \leftrightarrow g \text{ (gravitational acceleration)}""",
      r"""\text{• } f_0 \leftrightarrow v_0 \text{ (initial velocity)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""f'(t) = g""",
      r"""\text{Integrate both sides from } 0 \text{ to } t \text{:}""",
      r"""
\begin{aligned}
&\Leftrightarrow \int_0^t f'(s)\,ds = \int_0^t g\,ds\\[5pt]
&\Leftrightarrow [f(s)]_{0}^{t} = [gs]_{0}^{t}\\[5pt]
&\Leftrightarrow \ f(t) - f(0) = g t - 0\\[5pt]
&\Leftrightarrow \ f(t) = g t + f(0)
\end{aligned}
""",
      r"""\text{From initial conditions, } f(0) = f_0 \text{, so:}""",
      r"""\Leftrightarrow \ f(t) = g t + f_0""",
    ],
  ),
  "C5C2514A-CF06-4F19-BE62-4F99731FA905": ProblemTranslation(
    category: 'General - 2nd Order - Non-homogeneous',
    level: 'Easy',
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• Differential equation for position in free fall with initial position } x_0=f_0 \text{, initial velocity } v_0 \text{, and gravitational acceleration } g \text{.}""",
      r"""\text{• In mechanics, it often appears as } x''(t) = g \text{. This represents the position change of a particle under gravity.}""",
      r"""\text{• The solution } f(t) = \displaystyle \frac{1}{2}g t^2 + v_0 t + f_0 \text{ is the position formula for uniformly accelerated motion itself.}""",
      r"""\textcolor{brown}{\large{[Correspondence\ between\ problem\ symbols\ and\ mechanics\ symbols]}}""",
      r"""\text{Position change in free fall}""",
      r"""x''(t) = g""",
      r"""\text{• } f(t) \leftrightarrow x(t) \text{ (position)}""",
      r"""\text{• } f'(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } f''(t) \leftrightarrow a(t) \text{ (acceleration)}""",
      r"""\text{• } g \leftrightarrow g \text{ (gravitational acceleration)}""",
      r"""\text{• } f_0 \leftrightarrow x_0 \text{ (initial position)}""",
      r"""\text{• } v_0 \leftrightarrow v_0 \text{ (initial velocity)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""f''(t) = g""",
      r"""\text{Integrate both sides from } 0 \text{ to } t \text{:}""",
      r"""
\begin{aligned}
&\Leftrightarrow \int_0^t f''(s)\,ds = \int_0^t g\,ds\\[5pt]
&\Leftrightarrow [f'(s)]_{0}^{t} = [gs]_{0}^{t}\\[5pt]
&\Leftrightarrow \ f'(t) - f'(0) = g t - 0\\[5pt]
&\Leftrightarrow \ f'(t) = g t + f'(0)
\end{aligned}
""",
      r"""\text{From initial conditions, } f'(0) = v_0 \text{, so:}""",
      r"""\Leftrightarrow \ f'(t) = g t + v_0""",
      r"""\text{Furthermore, integrate both sides from } 0 \text{ to } t \text{:}""",
      r"""
\begin{aligned}
&\Leftrightarrow \int_0^t f'(s)\,ds = \int_0^t (g s + v_0)\,ds\\[5pt]
&\Leftrightarrow [f(s)]_{0}^{t} = \left[\displaystyle \frac{1}{2}g s^2 + v_0 s\right]_{0}^{t}\\[5pt]
&\Leftrightarrow \ f(t) - f(0) = \displaystyle \frac{1}{2}g t^2 + v_0 t - 0\\[5pt]
&\Leftrightarrow \ f(t) = \displaystyle \frac{1}{2}g t^2 + v_0 t + f(0)
\end{aligned}
""",
      r"""\text{From initial conditions, } f(0) = f_0 \text{, so:}""",
      r"""\Leftrightarrow \ f(t) = \displaystyle \frac{1}{2}g t^2 + v_0 t + f_0""",
    ],
  ),
  "9B75DE01-6B72-487F-B653-EE769057E58B": ProblemTranslation(
    category: 'Numerical - 1st Order - Non-homogeneous',
    level: 'Easy',
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• Differential equation for velocity change in constant acceleration motion.}""",
      r"""\text{• In mechanics, it often appears as } v'(t) = a \text{. This represents the velocity change of a particle under a constant force.}""",
      r"""\textcolor{brown}{\large{[Correspondence\ between\ problem\ symbols\ and\ mechanics\ symbols]}}""",
      r"""\text{Velocity change in constant acceleration motion}""",
      r"""\text{• } f(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } 1 \leftrightarrow v_0 \text{ (initial velocity)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""f'(t) = 2""",
      r"""\text{Integrate both sides from } 0 \text{ to } t \text{:}""",
      r"""
\begin{aligned}
&\Leftrightarrow \int_0^t f'(s)\,ds = \int_0^t 2\,ds\\[5pt]
&\Leftrightarrow [f(s)]_{0}^{t} = [2s]_{0}^{t}\\[5pt]
&\Leftrightarrow \ f(t) - f(0) = 2 t - 0\\[5pt]
&\Leftrightarrow \ f(t) = 2 t + f(0)
\end{aligned}
""",
      r"""\text{From initial conditions, } f(0) = 1 \text{, so:}""",
      r"""\Leftrightarrow \ f(t) = 2 t + 1""",
    ],
  ),
  "6B6506AA-7296-4C18-9A00-44CAF515FDD4": ProblemTranslation(
    category: 'Numerical - 2nd Order - Non-homogeneous',
    level: 'Easy',
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• Differential equation for position in uniformly accelerated linear motion with initial position } x_0=-1 \text{, initial velocity } v_0=3 \text{, and acceleration } a=2 \text{.}""",
      r"""\text{• In mechanics, it often appears as } x''(t) = a \text{. This represents the position change of a particle under a constant force.}""",
      r"""\textcolor{brown}{\large{[Correspondence\ between\ problem\ symbols\ and\ mechanics\ symbols]}}""",
      r"""\text{Position change in constant acceleration motion}""",
      r"""\text{• } f(t) \leftrightarrow x(t) \text{ (position)}""",
      r"""\text{• } f'(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } f''(t) \leftrightarrow a(t) \text{ (acceleration)}""",
      r"""\text{• } f(0)=-1 \leftrightarrow x_0=-1 \text{ (initial position)}""",
      r"""\text{• } f'(0)=3 \leftrightarrow v_0=3 \text{ (initial velocity)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""f''(t) = 2""",
      r"""\text{Integrate both sides from } 0 \text{ to } t \text{:}""",
      r"""
\begin{aligned}
&\Leftrightarrow \int_0^t f''(s)\,ds = \int_0^t 2\,ds\\[5pt]
&\Leftrightarrow [f'(s)]_{0}^{t} = [2s]_{0}^{t}\\[5pt]
&\Leftrightarrow \ f'(t) - f'(0) = 2 t - 0\\[5pt]
&\Leftrightarrow \ f'(t) = 2 t + f'(0)
\end{aligned}
""",
      r"""\text{From initial conditions, } f'(0) = 3 \text{, so:}""",
      r"""\Leftrightarrow \ f'(t) = 2 t + 3""",
      r"""\text{Furthermore, integrate both sides from } 0 \text{ to } t \text{:}""",
      r"""
\begin{aligned}
&\Leftrightarrow \int_0^t f'(s)\,ds = \int_0^t (2 s + 3)\,ds\\[5pt]
&\Leftrightarrow [f(s)]_{0}^{t} = [s^2 + 3s]_{0}^{t}\\[5pt]
&\Leftrightarrow \ f(t) - f(0) = t^2 + 3 t - 0\\[5pt]
&\Leftrightarrow \ f(t) = t^2 + 3 t + f(0)
\end{aligned}
""",
      r"""\text{From initial conditions, } f(0) = -1 \text{, so:}""",
      r"""\Leftrightarrow \ f(t) = t^2 + 3 t - 1""",
    ],
  ),

  // simple_harmonic_motion_problems.dart
  // (reserve / auxiliary)
  "26B96D2C-B75A-41EE-9C07-0E1CBE45D019": ProblemTranslation(
    category: 'Supplement',
    level: 'Reference',
    question: r"""\text{Integral formulas used later (derived explicitly)}""",
    answer: r"""\displaystyle 
\int e^{\alpha t}\cos(\beta t)\,dt=\displaystyle \frac{e^{\alpha t}}{\alpha^2+\beta^2}\big(\alpha\cos(\beta t)+\beta\sin(\beta t)\big),\quad
\int e^{\alpha t}\sin(\beta t)\,dt=\displaystyle \frac{e^{\alpha t}}{\alpha^2+\beta^2}\big(\alpha\sin(\beta t)-\beta\cos(\beta t)\big)
""",
    steps: [
      r"\textbf{[Derivation via integration by parts (real functions only)]}",
      r"\text{Let } I_1(t)=\int e^{\alpha t}\cos(\beta t)\,dt,\quad I_2(t)=\int e^{\alpha t}\sin(\beta t)\,dt.",
      r"\text{Integrate by parts to express }I_1\text{ in terms of }I_2\text{ and }I_2\text{ in terms of }I_1\text{, then solve the resulting 2×2 linear system.}",
      r"\text{The closed forms above follow; we will reference them later.}",
    ],
  ),
  "1105E028-5A00-4735-8506-CC3FF3BF43E7": ProblemTranslation(
    category: 'General - 2nd Order - Non-homogeneous (Off Resonance)',
    level: 'Advanced',
    hint:
        r"""\text{Solve by a particular solution + homogeneous solution, then use }f(0)=0,\ f'(0)=0\text{.}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Find a particular solution for }F\cos(\omega t)\text{, then add the general homogeneous solution and apply initial conditions.}",
      r"\textbf{[Solution]}",
      r"\text{For }\omega\neq\omega_0,\ \text{try } f_p(t)=a\cos(\omega t).",
      r"\begin{aligned} f_p''+\omega_0^2 f_p &= (-\omega^2+\omega_0^2)a\cos(\omega t) = F\cos(\omega t) \\ \Rightarrow a &= \frac{F}{\omega_0^2-\omega^2}. \end{aligned}",
      r"\text{So } f_p(t)=\displaystyle\frac{F}{\omega_0^2-\omega^2}\cos(\omega t).",
      r"\text{The homogeneous solution is } f_h(t)=A\cos(\omega_0 t)+B\sin(\omega_0 t).",
      r"\text{Thus } f(t)=f_h(t)+f_p(t). Using }f(0)=0,\ f'(0)=0\text{ gives }A=-\displaystyle\frac{F}{\omega_0^2-\omega^2},\ B=0.",
      r"\begin{aligned} \therefore\ f(t)=\frac{F}{\omega_0^2-\omega^2}\big(\cos(\omega t)-\cos(\omega_0 t)\big). \end{aligned}",
    ],
  ),
  "BAAFC855-C0E1-4C39-9496-406A89079285": ProblemTranslation(
    category: 'General - 2nd Order - Non-homogeneous (Resonance)',
    level: 'Advanced',
    hint:
        r"""\text{At resonance }(\omega=\omega_0)\text{, use a }t\sin(\omega_0 t)\text{ particular solution (or take a limit from the off-resonance formula).}""",
    steps: [
      r"\textbf{[Strategy]}",
      r"\text{Use an undetermined-coefficients ansatz of the form } f_p(t)=a\,t\sin(\omega_0 t)\text{.}",
      r"\textbf{[Solution]}",
      r"\text{Let } f_p(t)=a\,t\sin(\omega_0 t). \text{ Then } f_p''+\omega_0^2 f_p = 2a\omega_0\cos(\omega_0 t).",
      r"\text{Match with }F\cos(\omega_0 t)\text{ to get }2a\omega_0=F\Rightarrow a=\displaystyle\frac{F}{2\omega_0}.",
      r"\text{With }f(0)=0,\ f'(0)=0,\text{ the homogeneous constants vanish.}",
      r"\begin{aligned} \therefore\ f(t)=\displaystyle\frac{F}{2\omega_0}\,t\,\sin(\omega_0 t). \end{aligned}",
    ],
  ),
  // (reserve / commented-out in source)
  "3E5D27F0-5236-4F00-BD82-9BF5CA6CFDB9": ProblemTranslation(
    category: 'General - 2nd Order - Non-homogeneous',
    level: 'Advanced',
    hint:
        r"""\text{Use undetermined coefficients: try }f_p(t)=e^{\beta t}(C\sin(\omega t)+D\cos(\omega t))\text{, then apply initial conditions.}""",
    steps: [
      r"\textbf{[Outline]}",
      r"\text{(1) Find a particular solution of the form } f_p(t)=e^{\beta t}(C\sin(\omega t)+D\cos(\omega t)).",
      r"\text{(2) Determine }C,D\text{ by substituting into } f''+\omega_0^2 f = A e^{\beta t}\sin(\omega t).",
      r"\text{(3) Add the homogeneous solution }A_1\cos(\omega_0 t)+A_2\sin(\omega_0 t)\text{ and use }f(0)=f'(0)=0\text{ to fix }A_1,A_2.",
      r"\text{This yields the stated closed form in the problem statement.}",
    ],
  ),
  // (reserve / commented-out in source)
  "D87AC614-9562-4570-8921-38EF84BADF5F": ProblemTranslation(
    category: 'Numeric - 2nd Order - Non-homogeneous',
    level: 'Advanced',
    hint:
        r"""\text{Try }f_p(t)=e^t(A\sin(3t)+B\cos(3t))\text{, then solve the homogeneous part and match initial conditions.}""",
    steps: [
      r"\textbf{[Outline]}",
      r"\text{(1) Assume } f_p(t)=e^t(A\sin(3t)+B\cos(3t)).",
      r"\text{(2) Substitute into } f''(t)+4f(t)=2e^t\sin(3t)\text{ to solve for }A,B.",
      r"\text{(3) Set } g(t)=f(t)-f_p(t) \text{ so that } g''+4g=0, \text{ then apply } f(0)=f'(0)=0.",
      r"\text{You obtain the stated answer.}",
    ],
  ),
  "4F674DAB-329F-45CC-9417-94C45BE5B203": ProblemTranslation(
    category: '2nd Order Homogeneous - Constant Coefficients',
    level: 'Mid',
    hint: r"""\text{Solve }f(t)=A\cos(2t)+B\sin(2t)\text{ and apply initial conditions.}""",
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• In mechanics, this often appears in the form } mx''(t)+kx(t)=0\text{. This is the equation of motion for simple harmonic motion of a spring-mass system.}""",
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• In electromagnetism, this often appears in the form } LQ''(t)+\displaystyle \frac{Q(t)}{C}=0\text{. This is Kirchhoff's law for discharging an LC circuit, resulting in electrical oscillations.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Mechanics]}}""",
      r"""\text{Example of simple harmonic motion (free oscillation of spring-mass system):} \ mx''(t)+kx(t)=0""",
      r"""\text{• } f(t) \leftrightarrow x(t) \text{ (position)}""",
      r"""\text{• } f'(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } f''(t) \leftrightarrow a(t) \text{ (acceleration)}""",
      r"""\text{• } 4 \leftrightarrow \displaystyle \frac{k}{m} \text{ (spring constant / mass)}""",
      r"""\text{• } f(0)=0 \leftrightarrow x_0=0 \text{ (initial position)}""",
      r"""\text{• } f'(0)=2 \leftrightarrow v_0=2 \text{ (initial velocity)}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{Example of LC oscillation circuit (free oscillation of capacitor and inductor):} \ LQ''(t)+\displaystyle \frac{Q(t)}{C}=0""",
      r"""\text{• } f(t) \leftrightarrow Q(t) \text{ (charge stored in capacitor)}""",
      r"""\text{• } f'(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } f''(t) \leftrightarrow I' \text{ (rate of current change)}""",
      r"""\text{• } 4 \leftrightarrow \displaystyle \frac{1}{LC} \text{ (natural angular frequency squared)}""",
      r"""\text{• } f(0)=0 \leftrightarrow Q_0=0 \text{ (initial charge stored in capacitor)}""",
      r"""\text{• } f'(0)=2 \leftrightarrow I_0=2 \text{ (initial current)}""",
      r"""\textbf{[Strategy]}""",
      r"""\text{Determine the solution directly using a conserved quantity and a phase parameter.}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\textcolor{green}{1.\ } \textcolor{green}{\displaystyle \frac{1}{2}f'(t)^2 + 2f(t)^2}\textcolor{green}{\ is\ constant\ in\ time}""",
      r"""Multiply both sides of \(f''(t)=-4f(t)\) by \(f'(t)\). (This works well.)""",
      r"""\Rightarrow \ f''(t)f'(t) = -4 f(t)f'(t)""",
      r"""\text{By the product rule,}""",
      r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2\right)' = \left(-\displaystyle \frac{4}{2}f(t)^2\right)'""",
      r"""\text{Move terms to one side:}""",
      r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2\right)' - \left(-\displaystyle \frac{4}{2}f(t)^2\right)' = 0""",
      r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2 + \displaystyle \frac{4}{2}f(t)^2\right)' = 0""",
      r"""\text{Since the time derivative is }0\text{, } \displaystyle \frac{1}{2}f'(t)^2 + \displaystyle \frac{4}{2}f(t)^2 \text{ is a conserved quantity.}""",
      r"""\Leftrightarrow \ \displaystyle \frac{1}{2}f'(t)^2 + \displaystyle 2f(t)^2 = C \quad(\text{constant}) \cdots (1)""",
      r"""\textcolor{green}{2.\ } \textcolor{green}{For\ any\ time\ }t\textcolor{green}{, } \textcolor{green}{\left(\displaystyle \frac{f'(t)}{2}\right)^2 + f(t)^2 = 1}\textcolor{green}{\ (constant)}""",
      r"""\text{Using the initial conditions }f(0)=0,\ f'(0)=2\text{, compute the constant }C\text{ in (1):}""",
      r"""C = \displaystyle \frac12\cdot 2^2 + 2\cdot 0^2""",
      r"""\text{Therefore, for any }t\text{,}""",
      r""" \displaystyle \frac{1}{2}f'(t)^2 + 2f(t)^2 = 2 \  \cdots (1)""",
      r"""\text{Divide both sides of (1) by }2\text{:}""",
      r"""\Leftrightarrow \left(\displaystyle \frac{f'(t)}{2}\right)^2 + f(t)^2 = \displaystyle \frac{4}{4} = 1 \  \cdots (2)""",
      r"""\textcolor{green}{3.\ } \textcolor{green}{We\ can\ take\ a\ function\ } \textcolor{green}{\theta(t)} \textcolor{green}{\ such\ that\ } \textcolor{green}{\displaystyle \frac{f'(t)}{2} = \cos\theta(t),\  f(t)=\sin\theta(t)}""",
      r"""From (2), \(\left(\displaystyle \frac{f'(t)}{2},\,f(t)\right)\) always lies on the unit circle.""",
      r"""\text{Hence we can represent it using a continuous angle } \theta(t)\text{:}""",
      r"""
      \begin{cases}
      \displaystyle \frac{f'(t)}{2}=\cos\theta(t)\ \ \cdots (3)\\[6pt]
      f(t)=\sin\theta(t)\ \ \cdots (4)
      \end{cases}
      """,
      r"""\textcolor{green}{4.\ } \textcolor{green}{\cos\theta(0)=1,\ \sin\theta(0)=0}""",
      r"""\text{Substitute }t=0\text{ into (3) and (4):}""",
      r"""
      \begin{aligned}
      &\quad \begin{cases}
      \displaystyle \frac{f'(0)}{2}=\displaystyle \frac{2}{2}=1=\cos\theta(0)\\[6pt]
      f(0)=0=\sin\theta(0)
      \end{cases}
      \\[7pt]
      & \Leftrightarrow
      \begin{cases}
      \cos\theta(0) = 1\ \ \cdots (5)\\[6pt]
      \sin\theta(0) = 0\ \ \cdots (6)
      \end{cases}
      \end{aligned}
      """,
      r"""\text{From (5) and (6), we get } \theta(0)=0\text{.}""",
      r"""\textcolor{green}{5.\ } \textcolor{green}{\theta'(t)=2}""",
      r"""\text{From (4), }f(t)=\sin\theta(t)\text{, so by the chain rule } f'(t)=\theta'(t)\cos\theta(t)\text{.}""",
      r"""\text{On the other hand, from (3) we have } \displaystyle \frac{f'(t)}{2}=\cos\theta(t)\text{, so } f'(t)=2\cos\theta(t)\text{.}""",
      r"""\text{Therefore, } \theta'(t)\cos\theta(t) = 2\cos\theta(t)\text{.}""",
      r"""\text{Comparing coefficients gives } \theta'(t)=2 \text{ for }t\text{ where }\cos\theta(t)\neq 0\text{.}""",
      r"""\text{By continuity, } \theta'(t)=2 \text{ holds for all }t\text{.}""",
      r"""\textcolor{green}{6.\ } \textcolor{green}{f(t)=\sin(2t)}""",
      r"""\text{From } \theta'(t)=2 \text{ and } \theta(0)=0\text{,}""",
      r"""\text{integrate to get } \theta(t)=2t+\theta_0\text{. Since }\theta(0)=0\text{, we have }\theta_0=0\text{.}""",
      r"""\theta(t)=2t\text{.}""",
      r"""\text{Hence, from (4),}""",
      r"""
      \begin{aligned}
      f(t) &= \sin\theta(t) \\[5pt]
      &= \sin(2 t)
      \end{aligned}
      """,
    ],
  ),
  "2C1016F1-C7DD-4BE8-8BC8-0C5AA7F05FB5": ProblemTranslation(
    category: '2nd Order - Constant Coefficients (Constant Forcing)',
    level: 'Mid',
    hint:
        r"""\text{Find the equilibrium (constant) solution and shift: }g(t)=f(t)-f_s\text{.}""",
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• In mechanics, this often appears as } mx''(t)+kx(t)=F\text{. If }F=mg\text{, it describes a spring-mass system under gravity, where the equilibrium position shifts.}""",
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• In electromagnetism, this often appears as } LQ''(t)+\displaystyle \frac{Q(t)}{C}=V\text{, representing an LC circuit driven by a DC voltage.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Mechanics]}}""",
      r"""\text{Spring under gravity: } \ mx''(t)+kx(t)=F""",
      r"""\text{• } f(t) \leftrightarrow x(t) \text{ (position)}""",
      r"""\text{• } f'(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } f''(t) \leftrightarrow a(t) \text{ (acceleration)}""",
      r"""\text{• } 4 \leftrightarrow \displaystyle \frac{k}{m} \text{ (spring constant / mass)}""",
      r"""\text{• } 2 \leftrightarrow \displaystyle \frac{F}{m} \text{ (external force / mass)}""",
      r"""\text{• } f(0)=0 \leftrightarrow x_0=0 \text{ (initial position)}""",
      r"""\text{• } f'(0)=0 \leftrightarrow v_0=0 \text{ (initial velocity)}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{LC circuit (DC): } \ LQ''(t)+\displaystyle \frac{Q(t)}{C}=V""",
      r"""\text{• } f(t) \leftrightarrow Q(t) \text{ (charge stored in capacitor)}""",
      r"""\text{• } f'(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } f''(t) \leftrightarrow I' \text{ (rate of current change)}""",
      r"""\text{• } 4 \leftrightarrow \displaystyle \frac{1}{LC} \text{ (natural angular frequency squared)}""",
      r"""\text{• } 2 \leftrightarrow \displaystyle \frac{V}{L} \text{ (voltage / inductance)}""",
      r"""\text{• } f(0)=0 \leftrightarrow Q_0=0 \text{ (initial charge stored in capacitor)}""",
      r"""\text{• } f'(0)=0 \leftrightarrow I_0=0 \text{ (initial current)}""",
      r"""\textbf{[Strategy]}""",
      r"""\text{Find a constant (equilibrium) solution, shift the variable, and use the homogeneous solution formula.}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\textcolor{green}{Homogeneous-case\ formula}""",
      r"""\text{For the IVP of } f''(t)=-\omega^2 f(t)\text{:}""",
      r"""f(0)=A_0,\quad f'(0)=v_0""",
      r"""\text{the solution is}""",
      r"""f(t)=A_0\cos(\omega t)+\displaystyle \frac{v_0}{\omega}\sin(\omega t)""",
      r"""\text{(derived in Problem 6).}""",
      r"""\textcolor{blue}{We\ solve\ this\ problem\ using\ the\ formula\ above.}""",
      r"""f''(t) = -4f(t) + 2""",
      r"""\textcolor{green}{1.\ } \textcolor{green}{Find\ a\ constant\ solution}""",
      r"""\text{Let }f_s\text{ be a constant particular solution. Since }f_s''=0\text{,}""",
      r"""0 = -4 f_s + 2 \quad \Leftrightarrow \quad f_s = \displaystyle \frac{2}{4} = \displaystyle \frac{1}{2}""",
      r"""\textcolor{green}{2.\ } \textcolor{green}{Shift\ to\ homogenize\ (reduce\ to\ the\ force-free\ oscillation)}""",
      r"""\text{Define } g(t)=f(t)-f_s\text{.}""",
      r"""\begin{aligned}
g''(t) &= f''(t) = -4 f(t) + 2 \\[5pt]
&= -4(g(t) + f_s) + 2 \\[5pt]
&= -4 g(t) - 4 \cdot \displaystyle \frac{1}{2} + 2 \\[5pt]
&= -4 g(t)
\end{aligned}""",
      r"""\text{Hence } g''(t) = -4g(t)\text{ (homogeneous).}""",
      r"""\textcolor{green}{3.\ } \textcolor{green}{Find\ initial\ conditions\ for\ }g""",
      r"""\begin{aligned}
g(0) &= f(0) - f_s = 0 - \displaystyle \frac{1}{2} = -\displaystyle \frac{1}{2} \\[5pt]
g'(0) &= f'(0) = 0
\end{aligned}""",
      r"""\textcolor{green}{4.\ } \textcolor{green}{Apply\ the\ formula\ to\ find\ }g""",
      r"""g''(t) = -4 g(t),\quad g(0) = -\displaystyle \frac{1}{2},\quad g'(0) = 0""",
      r"""\text{Using the formula with }\omega=2\text{:}""",
      r"""\begin{aligned}
g(t) &= g(0)\cos(2t) + \displaystyle \frac{g'(0)}{2}\sin(2t) \\[5pt]
&= -\displaystyle \frac{1}{2}\cos(2t)
\end{aligned}""",
      r"""\textcolor{green}{5.\ } \textcolor{green}{Recover\ }f\textcolor{green}{\ from\ }g""",
      r"""f(t) = g(t) + f_s = -\displaystyle \frac{1}{2}\cos(2t) + \displaystyle \frac{1}{2}""",
      r"""\quad = \displaystyle \frac{1}{2}\big(1 - \cos(2t)\big)""",
    ],
  ),
  "9B2C3D4E-5F6G-7890-BCDE-F23456789012": ProblemTranslation(
    category: '2nd Order Homogeneous - Constant Coefficients (Hyperbolic)',
    level: 'Mid',
    hint: r"""\text{Solve }f(t)=c_1 e^{3t}+c_2 e^{-3t}\text{ and use }f(0)=1,\ f'(0)=0\text{.}""",
    steps: [
      r"\textbf{[Solution]}",
      r"\text{The general solution of }f''(t)=9f(t)\text{ is } f(t)=c_1 e^{3t}+c_2 e^{-3t}.",
      r"\text{From }f(0)=1\Rightarrow c_1+c_2=1.",
      r"\text{Also }f'(t)=3c_1 e^{3t}-3c_2 e^{-3t}\Rightarrow f'(0)=3(c_1-c_2)=0\Rightarrow c_1=c_2=\displaystyle\frac{1}{2}.",
      r"\begin{aligned} \therefore\ f(t)=\frac{1}{2}e^{3t}+\frac{1}{2}e^{-3t}=\cosh(3t). \end{aligned}",
    ],
  ),
  "B4A7301D-51FF-4FAE-B321-A02C73C38C9E": ProblemTranslation(
    category: 'Numeric - 2nd Order - Non-homogeneous (Off Resonance)',
    level: 'Advanced',
    hint: r"""\text{Use a cosine particular solution for }3\cos t\text{ and apply the initial conditions.}""",
    steps: [
      r"\textbf{[Solution]}",
      r"\text{Try }f_p(t)=a\cos t. \text{ Then }f_p''+4f_p=(-1+4)a\cos t=3a\cos t.",
      r"\text{Match }3a\cos t = 3\cos t \Rightarrow a=1,\ \text{so } f_p(t)=\cos t.",
      r"\text{Homogeneous solution: } f_h(t)=A\cos(2t)+B\sin(2t).",
      r"\text{Thus } f(t)=A\cos(2t)+B\sin(2t)+\cos t.",
      r"\text{Apply }f(0)=0\Rightarrow A+1=0\Rightarrow A=-1,\quad f'(0)=0\Rightarrow 2B=0\Rightarrow B=0.",
      r"\begin{aligned} \therefore\ f(t)=-\cos(2t)+\cos t. \end{aligned}",
    ],
  ),
  "F03213BF-4AEC-4D56-BCA8-D2D4F16E9D02": ProblemTranslation(
    category: 'Numeric - 2nd Order - Non-homogeneous (Resonance)',
    level: 'Advanced',
    hint:
        r"""\text{For resonance forcing }3\cos(2t)\text{, try }f_p(t)=a t\sin(2t)\text{.}""",
    steps: [
      r"\textbf{[Solution]}",
      r"\text{Because the forcing frequency equals the natural frequency }2, \text{try } f_p(t)=a t\sin(2t).",
      r"\text{Compute } f_p''+4f_p = 4a\cos(2t). \text{ Matching } 4a\cos(2t)=3\cos(2t)\text{ gives } a=\displaystyle\frac{3}{4}.",
      r"\text{With }f(0)=0,\ f'(0)=0\text{, the homogeneous constants vanish.}",
      r"\begin{aligned} \therefore\ f(t)=\frac{3}{4}\,t\,\sin(2t). \end{aligned}",
    ],
  ),
  "BEB5E18C-4AF5-4411-8578-2CE052A3CDE8": ProblemTranslation(
    category: '2nd Order Homogeneous - Constant Coefficients',
    level: 'Mid',
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• In mechanics, it often appears in the form } mx''(t) + kx(t) = 0 \text{. This is the equation of motion for simple harmonic motion of a spring-mass system.}""",
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• In electromagnetism, it often appears in the form } LQ''(t) + \displaystyle \frac{Q(t)}{C} = 0 \text{. This is Kirchhoff's law for discharging an LC circuit, resulting in electrical oscillations.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Mechanics]}}""",
      r"""\text{Simple harmonic motion (free oscillation of spring-mass system):} \ mx''(t) + kx(t) = 0""",
      r"""\text{• } f(t) \leftrightarrow x(t) \text{ (position)}""",
      r"""\text{• } f'(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } f''(t) \leftrightarrow a(t) \text{ (acceleration)}""",
      r"""\text{• } \omega_0 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{ (natural angular frequency)}""",
      r"""\text{• } A_0 \leftrightarrow x_0 \text{ (initial position)}""",
      r"""\text{• } v_0 \leftrightarrow v_0 \text{ (initial velocity)}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{LC oscillation circuit (free oscillation of capacitor and inductor):} \ LQ''(t) + \displaystyle \frac{Q(t)}{C} = 0""",
      r"""\text{• } f(t) \leftrightarrow Q(t) \text{ (charge stored in capacitor)}""",
      r"""\text{• } f'(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } f''(t) \leftrightarrow I' \text{ (rate of current change)}""",
      r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{ (natural angular frequency)}""",
      r"""\text{• } A_0 \leftrightarrow Q_0 \text{ (initial charge in capacitor)}""",
      r"""\text{• } v_0 \leftrightarrow I_0 \text{ (initial current)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\textcolor{green}{1.} \textcolor{green}{\displaystyle \frac{1}{2}f'(t)^2 + \displaystyle \frac{\omega_0^2}{2}f(t)^2} \textcolor{green}{\ is\ constant\ over\ time}""",
      r"""\text{Multiply both sides of } f''(t) = -\omega_0^2 f(t) \text{ by } f'(t) \text{. (This approach works well)}""",
      r"""\Rightarrow \ f''(t)f'(t) = -\omega_0^2 f(t)f'(t)""",
      r"""\text{By the product rule for derivatives:}""",
      r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2\right)' = \left(-\displaystyle \frac{\omega_0^2}{2}f(t)^2\right)'""",
      r"""\text{Rearrange:}""",
      r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2\right)' - \left(-\displaystyle \frac{\omega_0^2}{2}f(t)^2\right)' = 0""",
      r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2 + \displaystyle \frac{\omega_0^2}{2}f(t)^2\right)' = 0""",
      r"""\text{Since the time derivative is 0, } \displaystyle \frac{1}{2}f'(t)^2 + \displaystyle \frac{\omega_0^2}{2}f(t)^2 \text{ is a conserved quantity independent of time.}""",
      r"""\textcolor{green}{2. } \textcolor{green}{At\ any\ time\ } \textcolor{green}{t}\textcolor{green}{, } \textcolor{green}{\left(\displaystyle \frac{f'(t)}{\omega_0}\right)^2 + f(t)^2 = \displaystyle \frac{v_0^2+\omega_0^2 A_0^2}{\omega_0^2}} \textcolor{green}{\ :\ Constant} """,
      r"""\text{From initial conditions } f(0)=A_0, f'(0)=v_0\text{, let } C \text{ be the value of the conserved quantity. Then,} """,
      r"""C = \displaystyle \frac12\cdot v_0^2 + \displaystyle \frac{\omega_0^2}{2}\cdot A_0^2""",
      r"""\text{Thus, at any time } t \text{,} """,
      r""" \displaystyle \frac{1}{2}f'(t)^2 + \displaystyle \frac{\omega_0^2}{2}f(t)^2 = \displaystyle \frac{v_0^2+\omega_0^2 A_0^2}{2} \  \cdots (1)""",
      r""" \text{holds. Dividing both sides of (1) by } \displaystyle \frac{\omega_0^2}{2} \text{:}""",
      r"""\Leftrightarrow \left(\displaystyle \frac{f'(t)}{\omega_0}\right)^2 + f(t)^2 = \displaystyle \frac{v_0^2+\omega_0^2 A_0^2}{\omega_0^2} \  \cdots (2)""",
      r"""\textcolor{green}{3.} \textcolor{green}{We can find a function  \theta(t)  satisfying  \displaystyle \frac{f'(t)}{\omega_0} = \frac{\sqrt{v_0^2+\omega_0^2 A_0^2}}{\omega_0}\cos\theta(t), f(t) = \frac{\sqrt{v_0^2+\omega_0^2 A_0^2}}{\omega_0}\sin\theta(t)}""",
      r"""\text{From (2), } \left(\displaystyle \frac{f'(t)}{\omega_0},\, f(t)\right) \text{ is always on a circle of radius } \displaystyle \frac{\sqrt{v_0^2+\omega_0^2 A_0^2}}{\omega_0}\text{.}""",
      r"""\text{Thus, it can be represented using a continuous angle } \theta(t) \text{ as follows:}""",
      r"""
      \begin{cases}
      \displaystyle \frac{f'(t)}{\omega_0}=\frac{\sqrt{v_0^2+\omega_0^2 A_0^2}}{\omega_0}\cos\theta(t)\ \ \cdots (3)\\[6pt]
      f(t)=\frac{\sqrt{v_0^2+\omega_0^2 A_0^2}}{\omega_0}\sin\theta(t)\ \ \cdots (4)
      \end{cases}
      """,
      r"""\text{Letting } \displaystyle A=\displaystyle \frac{\sqrt{v_0^2+\omega_0^2 A_0^2}}{\omega_0}\text{:}""",
      r"""
      \begin{cases}
      \displaystyle \frac{f'(t)}{\omega_0}=A\cos\theta(t)\ \ \cdots (3)\\[6pt]
      f(t)=A\sin\theta(t)\ \ \cdots (4)
      \end{cases}
      """,
      r"""\textcolor{green}{4.\ } \textcolor{green}{\cos\theta(0) = \displaystyle \frac{v_0}{\omega_0 A} , \ \sin\theta(0) = \displaystyle \frac{A_0}{A}} \textcolor{green}{\ holds.}""",
      r"""\text{Substituting } t=0 \text{ into (3) and (4) gives:}""",
      r"""
      \begin{aligned}
      &\quad \begin{cases}
      \displaystyle \frac{f'(0)}{\omega_0}=\displaystyle \frac{v_0}{\omega_0}=A\cos\theta(0) \cdots (5)\\[6pt]
      f(0)=A_0=A\sin\theta(0)\cdots (6)
      \end{cases}
      \end{aligned}
      """,
      r"""\textcolor{green}{5.\ } \textcolor{green}{\theta'(t) = \omega_0} \textcolor{green}{\ holds}""",
      r"""\text{From (4), } f(t) = A\sin\theta(t) \text{, so by the chain rule } f'(t) = A \theta'(t)\cos\theta(t)""",
      r"""\text{From (3), } \displaystyle \frac{f'(t)}{\omega_0}=A\cos\theta(t) \text{ so } f'(t) = \omega_0 A\cos\theta(t)""",
      r"""\text{Thus, } A \theta'(t)\cos\theta(t) = \omega_0 A\cos\theta(t)""",
      r"""\text{Comparing coefficients of } \cos\theta(t)\text{: } A \theta'(t) = \omega_0 A \text{, so for } t \text{ where } \cos\theta(t)\neq 0\text{, } \theta'(t)=\omega_0""",
      r"""\text{By continuity of } \theta'(t)\text{, at any time } \theta'(t)=\omega_0 """,
      r"""\textcolor{green}{6.\ } \textcolor{green}{f(t)=A_0\cos(\omega_0 t)+\displaystyle \frac{v_0}{\omega_0}\sin(\omega_0 t)}\textcolor{green}{\ holds}""",
      r"""\text{Integrating } \theta'(t) = \omega_0 \text{ gives } \theta(t)=\omega_0 t+\theta_0 \text{.}""",
      r"""\text{Thus,}""",
      r"""
      \begin{aligned}
      f(t)&=A\sin\theta(t)\\[5pt]
      &=A\sin(\omega_0 t+\theta_0)\\[5pt]
      &=A\sin(\omega_0 t)\cos\theta_0+A\cos(\omega_0 t)\sin\theta_0\ \cdots (7)
      \end{aligned}
      """,
      r"""""",
      r"""\text{From (5) and (6):}""",
      r"""
      \begin{aligned}
      \begin{cases}
      \cos\theta_0= \displaystyle \cos \theta(0)\ \underset{(5)}{=} \  \displaystyle \frac{v_0}{\omega_0 A}\\[5pt]
      \sin\theta_0= \displaystyle \sin \theta(0)\ \underset{(6)}{=} \  \displaystyle \frac{A_0}{A}
      \end{cases}
      \end{aligned}
      """,
      r"""\text{From (7):}
      \begin{aligned}
      f(t)&=A\sin(\omega_0 t)\cos\theta_0+A\cos(\omega_0 t)\sin\theta_0\\[5pt]
      &=A\sin(\omega_0 t)\cdot\displaystyle \frac{v_0}{\omega_0 A}+A\cos(\omega_0 t)\cdot\displaystyle \frac{A_0}{A}\\[5pt]
      &=\displaystyle \frac{v_0}{\omega_0}\sin(\omega_0 t)+A_0\cos(\omega_0 t)
      \end{aligned}
      """,
    ],
  ),
  "F2C5AEF4-1FD1-4BD6-A7FE-D0E65756456A": ProblemTranslation(
    category: '2nd Order Homogeneous - Constant Coefficients',
    level: 'Mid',
    hint: r"""\text{Find the constant solution, perform a translation, and use the formula for the differential equation without external force.}""",
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• In mechanics, it often appears in the form } mx''(t) + kx(t) = mg \text{. This represents the motion of a spring-mass system under gravity, causing a shift in the equilibrium position.}""",
      r"""\text{Motion of a spring under gravity:} \ mx''(t) + kx(t) = mg""",
      r"""\text{• } f(t) \leftrightarrow x(t) \text{ (position)}""",
      r"""\text{• } f'(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } f''(t) \leftrightarrow a(t) \text{ (acceleration)}""",
      r"""\text{• } \omega_0 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{ (natural angular frequency)}""",
      r"""\text{• } G \leftrightarrow \displaystyle \frac{mg}{m} = g \text{ (gravitational acceleration)}""",
      r"""\text{• } \frac{G}{\omega_0^2} \leftrightarrow \displaystyle \frac{mg}{k} \text{ (equilibrium point, center of oscillation)}""",
      r"""\text{• } f(0)=f_0 \leftrightarrow x_0=f_0 \text{ (initial position)}""",
      r"""\text{• } f'(0)=v_0 \leftrightarrow v_0=v_0 \text{ (initial velocity)}""",
      r"""\textbf{[Strategy]}""",
      r"""\text{Find the constant solution, perform a translation, and use the formula for the solution of the differential equation without external force.}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\textcolor{green}{Formula\ for\ homogeneous\ case\ (no\ constant\ term\ on\ the\ RHS)}""",
      r"""\text{The solution to the initial value problem for } f''(t) = -\omega^2 f(t) \text{ with }""",
      r"""f(0) = A_0,\quad f'(0) = v_0""",
      r"""\text{is}""",
      r"""f(t) = A_0\cos(\omega t) + \displaystyle \frac{v_0}{\omega}\sin(\omega t)""",
      r"""\text{(Derived in Problem 6)}""",
      r"""\textcolor{blue}{Use\ this\ formula\ to\ solve\ this\ problem.}""",
      r"""f''(t) = -\omega_0^2 f(t) + G""",
      r"""\textcolor{green}{1.} \textcolor{green}{Find\ the\ constant\ solution}""",
      r"""\text{Let } f_s \text{ be the constant solution. Since } f_s'' = 0 \text{:}""",
      r"""0 = -\omega_0^2 f_s + G \quad \Leftrightarrow \quad f_s = \displaystyle \frac{G}{\omega_0^2}""",
      r"""\textcolor{green}{2. } \textcolor{green}{Homogenize\ by\ translating\ to\ a\ new\ function\ } \textcolor{green}{g}""",
      r"""\text{Let } g(t) = f(t) - f_s \text{.}""",
      r"""\begin{aligned}
      g''(t) &= f''(t) = -\omega_0^2 f(t) + G \\[5pt]
      &= -\omega_0^2(g(t) + f_s) + G \\[5pt]
      &= -\omega_0^2 g(t) - \omega_0^2 \cdot \displaystyle \frac{G}{\omega_0^2} + G \\[5pt]
      &= -\omega_0^2 g(t)
      \end{aligned}""",
      r"""\text{Thus } g''(t) = -\omega_0^2 g(t) \text{ (Homogenization complete)}""",
      r"""\textcolor{green}{3.} \textcolor{green}{Find\ initial\ conditions\ for\ } \textcolor{green}{g}""",
      r"""\begin{aligned}
      g(0) &= f(0) - f_s = f_0 - \displaystyle \frac{G}{\omega_0^2} \\[5pt]
      g'(0) &= f'(0) = v_0
      \end{aligned}""",
      r"""\textcolor{green}{4.\ } \textcolor{green}{Apply\ formula\ to\ find\ } \textcolor{green}{g}""",
      r"""\text{For } g''(t) = -\omega_0^2 g(t) \text{ with } g(0) = f_0 - \displaystyle \frac{G}{\omega_0^2}, g'(0) = v_0\text{,}""",
      r"""\text{from the formula:}""",
      r"""\begin{aligned}
      g(t) &= g(0)\cos(\omega_0 t) + \displaystyle \frac{g'(0)}{\omega_0}\sin(\omega_0 t) \\[5pt]
      &= \Big(f_0 - \displaystyle \frac{G}{\omega_0^2}\Big)\cos(\omega_0 t) + \displaystyle \frac{v_0}{\omega_0}\sin(\omega_0 t)
      \end{aligned}""",
      r"""\textcolor{green}{5.\ } \textcolor{green}{Find\ } \textcolor{green}{f} \textcolor{green}{\ from\ } \textcolor{green}{g}""",
      r"""f(t) = g(t) + f_s = \Big(f_0 - \displaystyle \frac{G}{\omega_0^2}\Big)\cos(\omega_0 t) + \displaystyle \frac{v_0}{\omega_0}\sin(\omega_0 t) + \displaystyle \frac{G}{\omega_0^2}""",
      r"""\quad = \displaystyle \frac{G}{\omega_0^2}+\Big(f_0-\displaystyle \frac{G}{\omega_0^2}\Big)\cos(\omega_0 t)+\displaystyle \frac{v_0}{\omega_0}\sin(\omega_0 t)""",
    ],
  ),
  "EE1DFDFD-1094-42EC-9572-34CA88066BCD": ProblemTranslation(
    category: '2nd Order Homogeneous - Constant Coefficients (Hyperbolic)',
    level: 'Mid',
    constants: r"""\omega_0>0: constant""",
    steps: [
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\text{[Definition of Hyperbolic Functions]}""",
      r"""\text{Hyperbolic functions are defined as follows:}""",
      r"""\cosh x = \displaystyle \frac{e^x + e^{-x}}{2} \quad \text{(Hyperbolic Cosine)}""",
      r"""\sinh x = \displaystyle \frac{e^x - e^{-x}}{2} \quad \text{(Hyperbolic Sine)}""",
      r"""\text{These functions have properties similar to trigonometric functions, such as } \cosh^2 x - \sinh^2 x = 1 \text{. That is, } (\cosh x, \sinh x) \text{ lies on the hyperbola } x^2 - y^2 = 1 \text{.}""", 
      r"""\text{Derivatives:}""",
      r"""(\cosh x)' = \sinh x, \quad (\sinh x)' = \cosh x""",
      r"""\text{Addition Theorems:}""",
      r"""\cosh(a+b) = \cosh a \cosh b + \sinh a \sinh b""",
      r"""\sinh(a+b) = \sinh a \cosh b + \cosh a \sinh b""",
      r"""\textcolor{green}{1.} \textcolor{green}{Conserved\ quantity\ } \textcolor{green}{\displaystyle \frac{1}{2}f'(t)^2 - \displaystyle \frac{\omega_0^2}{2}f(t)^2} \textcolor{green}{\ is\ constant\ over\ time}""",
      r"""\text{Multiply both sides of } f''(t) = \omega_0^2 f(t) \text{ by } f'(t) \text{. (This approach works well)}""",
      r"""\Rightarrow \ f''(t)f'(t) = \omega_0^2 f(t)f'(t)""",
      r"""\text{By the product rule for derivatives:}""",
      r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2\right)' = \left(\displaystyle \frac{\omega_0^2}{2}f(t)^2\right)'""",
      r"""\text{Rearrange:}""",
      r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2\right)' - \left(\displaystyle \frac{\omega_0^2}{2}f(t)^2\right)' = 0""",
      r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2 - \displaystyle \frac{\omega_0^2}{2}f(t)^2\right)' = 0""",
      r"""\text{Since the time derivative is 0, } \displaystyle \frac{1}{2}f'(t)^2 - \displaystyle \frac{\omega_0^2}{2}f(t)^2 \text{ is a conserved quantity independent of time.}""",
      r"""\textcolor{green}{2. } \textcolor{green}{At\ any\ time\ } \textcolor{green}{t}\textcolor{green}{, } \textcolor{green}{\left(\displaystyle \frac{f'(t)}{\omega_0}\right)^2 - f(t)^2 = \displaystyle \frac{v_0^2-\omega_0^2 A_0^2}{\omega_0^2}} \textcolor{green}{\ :\ Constant}""",
      r"""\text{From initial conditions } f(0)=A_0, f'(0)=v_0\text{, let } C \text{ be the value of the conserved quantity. Then,} """,
      r"""C = \displaystyle \frac{1}{2}\cdot v_0^2 - \displaystyle \frac{\omega_0^2}{2}\cdot A_0^2""",
      r"""\text{Thus, at any time } t \text{,} """,
      r""" \displaystyle \frac{1}{2}f'(t)^2 - \displaystyle \frac{\omega_0^2}{2}f(t)^2 = \displaystyle \frac{v_0^2-\omega_0^2 A_0^2}{2} \  \cdots (1)""",
      r""" \text{holds. Dividing both sides of (1) by } \displaystyle \frac{\omega_0^2}{2} \text{:}""",
      r"""\Leftrightarrow \left(\displaystyle \frac{f'(t)}{\omega_0}\right)^2 - f(t)^2 = \displaystyle \frac{v_0^2-\omega_0^2 A_0^2}{\omega_0^2} \  \cdots (2)""",
      r"""\textcolor{green}{3.} \textcolor{green}{Case\ Analysis}""",
      r"""\text{We divide into three cases based on the sign of the conserved quantity:}""",
      r"""\text{• } v_0^2 > \omega_0^2 A_0^2 \text{ (Hyperbolic Type 1)}""",
      r"""\text{• } v_0^2 < \omega_0^2 A_0^2 \text{ (Hyperbolic Type 2)}""",
      r"""\text{• } v_0^2 = \omega_0^2 A_0^2 \text{ (Boundary Type)}""",
      r"""\textcolor{red}{\textbf{・}\ } \textcolor{red}{\text{Case } v_0^2 > \omega_0^2 A_0^2}""",
      r"""\text{In this case, } \displaystyle \frac{v_0^2-\omega_0^2 A_0^2}{\omega_0^2} > 0 \text{.}""",
      r"""\text{The hyperbola has two branches; the initial velocity } v_0 \text{ determines which branch to use.}""",
      r"""\text{Let } s \text{ be the sign of the branch (} s = 1 \text{ if } v_0 > 0\text{, } s = -1 \text{ if } v_0 < 0\text{). Using a parameter } \theta(t)\text{:}""",
      r"""\textcolor{green}{\displaystyle \frac{f'(t)}{\omega_0} = s\frac{\sqrt{v_0^2-\omega_0^2 A_0^2}}{\omega_0}\cosh\theta(t),\quad  f(t) = s\frac{\sqrt{v_0^2-\omega_0^2 A_0^2}}{\omega_0}\sinh\theta(t)}""",
      r"""From (2), \left(\displaystyle \frac{f'(t)}{\omega_0},\, f(t)\right) \text{ is on the hyperbola } x^2 - y^2 = \displaystyle \frac{v_0^2-\omega_0^2 A_0^2}{\omega_0^2} > 0 \text{.}""",
      r"""\text{Thus, it can be represented as follows:}""",
      r"""
      \begin{cases}
      \displaystyle \frac{f'(t)}{\omega_0}=s\frac{\sqrt{v_0^2-\omega_0^2 A_0^2}}{\omega_0}\cosh\theta(t)\\[6pt]
      f(t)=s\frac{\sqrt{v_0^2-\omega_0^2 A_0^2}}{\omega_0}\sinh\theta(t)
      \end{cases}
      """,
      r"""\text{Let } \displaystyle A=\displaystyle \frac{\sqrt{v_0^2-\omega_0^2 A_0^2}}{\omega_0}\ (>0) \text{:}""",
      r"""
      \begin{cases}
      \displaystyle \frac{f'(t)}{\omega_0}=sA\cosh\theta(t)\ \ \cdots (3)\\[6pt]
      f(t)=sA\sinh\theta(t)\ \ \cdots (4)
      \end{cases}
      """,
      r"""\textcolor{green}{4-1.\ } \textcolor{green}{\cosh \theta(0) = \frac{|v_0|}{\omega_0 A},\ \sinh \theta(0) = \frac{sA_0}{A}} \text{ holds}""",
      r"""\text{Substituting } t=0 \text{ into (3) and (4) gives:}""",
      r"""
      \begin{aligned}
      \quad &\begin{cases}
      \displaystyle \frac{f'(0)}{\omega_0}=\displaystyle \frac{v_0}{\omega_0}=sA\cosh\theta(0)\\[6pt]
      f(0)=A_0=sA\sinh\theta(0)
      \end{cases}\\[7pt]
      \Leftrightarrow & 
      \begin{cases}
      \cosh\theta(0) = \displaystyle \frac{|v_0|}{\omega_0 A}\ \ \ \cdots (5)\\[6pt] 
      \sinh\theta(0) = \displaystyle \frac{sA_0}{A}\ \ \ \cdots (6)
      \end{cases}
      \end{aligned}
      """,
      r"""\textcolor{green}{5-1.\ } \textcolor{green}{\theta '(t) = \omega_0} \text{ holds}""",
      r"""\text{From (4), } f(t) = sA\sinh\theta(t) \text{ so } f'(t) = sA \theta'(t)\cosh\theta(t) \text{.}""",
      r"""\text{From (3), } \displaystyle \frac{f'(t)}{\omega_0}=sA\cosh\theta(t) \text{ so } f'(t) = s\omega_0 A\cosh\theta(t) \text{.}""",
      r"""\text{Thus, } sA \theta'(t)\cosh\theta(t) = s\omega_0 A\cosh\theta(t) \text{ (when } \cosh\theta(t)\neq0\text{).}""",
      r"""\text{Comparing coefficients gives } \theta'(t)=\omega_0 \text{. By continuity, this holds for all } t \text{.}""",
      r"""\textcolor{green}{6-1.\ } \textcolor{green}{f(t) = A_0 \cosh(\omega_0 t) + \displaystyle \frac{v_0}{\omega_0} \sinh(\omega_0 t)} \text{ holds}""",
      r"""\text{From (5) and (6), let } \theta(0)=\theta_0 \text{, then } \theta(t)=\omega_0 t+\theta_0 \text{ where } \cosh\theta_0=\frac{|v_0|}{\omega_0 A},\ \sinh\theta_0=\frac{sA_0}{A}""",
      r"""\text{Thus,}""",
      r"""
      \begin{aligned}
      f(t)&=sA\sinh(\omega_0 t+\theta_0)\\[5pt]
      &=sA\big(\sinh(\omega_0 t)\cosh\theta_0+\cosh(\omega_0 t)\sinh\theta_0\big)\\[5pt]
      &=sA\sinh(\omega_0 t)\cdot\frac{|v_0|}{\omega_0 A}+sA\cosh(\omega_0 t)\cdot\frac{sA_0}{A}\\[5pt]
      &=\displaystyle \frac{v_0}{\omega_0}\sinh(\omega_0 t)+A_0\cosh(\omega_0 t)
      \end{aligned}
      """,
      r"""\textcolor{red}{\textbf{・}\ } \textcolor{red}{\text{Case } v_0^2 < \omega_0^2 A_0^2}""",
      r"""\text{In this case, } \displaystyle \frac{v_0^2-\omega_0^2 A_0^2}{\omega_0^2} < 0 \text{.}""",
      r"""\text{The initial position } A_0 \text{ determines the branch. Let } r \text{ be its sign. Using a parameter } \theta(t)\text{:}""",
      r"""\textcolor{green}{\displaystyle \frac{f'(t)}{\omega_0} = r\frac{\sqrt{\omega_0^2 A_0^2-v_0^2}}{\omega_0}\sinh\theta(t),\quad  f(t) = r\frac{\sqrt{\omega_0^2 A_0^2-v_0^2}}{\omega_0}\cosh\theta(t)}""",
      r"""From (2), \left(\displaystyle \frac{f'(t)}{\omega_0},\, f(t)\right) \text{ is on the hyperbola } x^2 - y^2 = \displaystyle \frac{v_0^2-\omega_0^2 A_0^2}{\omega_0^2} < 0 \text{.}""",
      r"""\text{Thus, it can be represented as follows:}""",
      r"""
      \begin{cases}
      \displaystyle \frac{f'(t)}{\omega_0}=rA\sinh\theta(t)\\[6pt]
      f(t)=rA\cosh\theta(t)
      \end{cases}
      \quad\text{where } A=\frac{\sqrt{\omega_0^2 A_0^2-v_0^2}}{\omega_0}>0
      """,
      r"""\textcolor{green}{4-2.\ } \textcolor{green}{\sinh\theta(0) = \frac{v_0}{\omega_0 A},\ \cosh\theta(0) = \frac{rA_0}{A}} \text{ holds}""",
      r"""\text{Substituting } t=0 \text{ into (3) and (4) gives:}""",
      r"""
      \begin{aligned}
      \quad &\begin{cases}
      \displaystyle \frac{f'(0)}{\omega_0}=\displaystyle \frac{v_0}{\omega_0}=rA\sinh\theta(0)\\[6pt]
      f(0)=A_0=rA\cosh\theta(0)
      \end{cases}\\[7pt]
      \Leftrightarrow & 
      \begin{cases}
      \sinh\theta(0) = \displaystyle \frac{v_0}{\omega_0 A}\ \ \ \cdots (5)\\[6pt] 
      \cosh\theta(0) = \displaystyle \frac{rA_0}{A}\ \ \ \cdots (6)
      \end{cases}
      \end{aligned}
      """,
      r"""\textcolor{green}{5-2.\ } \textcolor{green}{\theta '(t) = \omega_0} \text{ holds}""",
      r"""\text{From (4), } f(t)=rA\cosh\theta(t) \text{ so } f'(t)=rA\theta'(t)\sinh\theta(t)\text{.}""",
      r"""\text{From (3), } \displaystyle \frac{f'(t)}{\omega_0}=rA\sinh\theta(t) \text{ so } f'(t)=r\omega_0 A\sinh\theta(t)\text{.}""",
      r"""\text{Comparing coefficients gives } \theta'(t)=\omega_0 \text{ (holds for all } t \text{ by continuity).}""",
      r"""\textcolor{green}{6-2.\ } \textcolor{green}{f(t) = A_0 \cosh(\omega_0 t) + \displaystyle \frac{v_0}{\omega_0} \sinh(\omega_0 t)} \text{ holds}""",
      r"""\text{From (5) and (6), let } \theta(t)=\omega_0 t+\theta_0 \text{ where } \sinh\theta_0=\frac{v_0}{\omega_0 A},\ \cosh\theta_0=\frac{rA_0}{A} """,
      r"""\text{Thus,}""",
      r"""
      \begin{aligned}
      f(t)&=rA\cosh(\omega_0 t+\theta_0)\\[5pt]
      &=rA\big(\cosh(\omega_0 t)\cosh\theta_0+\sinh(\omega_0 t)\sinh\theta_0\big)\\[5pt]
      &=rA\cosh(\omega_0 t)\cdot\frac{rA_0}{A}+rA\sinh(\omega_0 t)\cdot\frac{v_0}{\omega_0 A}\\[5pt]
      &=A_0\cosh(\omega_0 t)+\displaystyle \frac{v_0}{\omega_0}\sinh(\omega_0 t)
      \end{aligned}
      """,
      r"""\textcolor{red}{\textbf{・}\ } \textcolor{red}{\text{Case } v_0^2 = \omega_0^2 A_0^2}""",
      r"""\text{In this case, } \left(\displaystyle \frac{f'(t)}{\omega_0}\right)^2 - f(t)^2 = 0 \Leftrightarrow \displaystyle \frac{f'(t)}{\omega_0} = \pm f(t) \text{.}""",
      r"""\text{This is motion on a straight line, which can be directly expressed using exponential functions.}""",
      r"""\textcolor{green}{4-3.\ } \textcolor{green}{Solution\ in\ exponential\ form}""",
      r"""\text{The general solution is } f(t) = C_1 e^{\omega_0 t} + C_2 e^{-\omega_0 t} \text{.}""",
      r"""\text{From initial conditions } f(0) = A_0, f'(0) = v_0 \text{:}""",
      r"""
      \begin{aligned}
      \quad &\begin{cases}
      f(0) = C_1 + C_2 = A_0\\[6pt]
      f'(0) = \omega_0 C_1 - \omega_0 C_2 = v_0
      \end{cases}\\[7pt]
      \Leftrightarrow & 
      \begin{cases}
      C_1 + C_2 = A_0\ \ \ \cdots (7)\\[6pt] 
      C_1 - C_2 = \frac{v_0}{\omega_0}\ \ \ \cdots (8)
      \end{cases}
      \end{aligned}
      """,
      r"""\text{Solving this:}""",
      r"""
      \begin{aligned}
      C_1 &= \displaystyle \frac{A_0 + \frac{v_0}{\omega_0}}{2}\\[6pt]
      C_2 &= \displaystyle \frac{A_0 - \frac{v_0}{\omega_0}}{2}
      \end{aligned}
      """,
      r"""\textcolor{green}{5-3.\ } \textcolor{green}{f(t) = \frac{A_0 + \frac{v_0}{\omega_0}}{2} e^{\omega_0 t} + \frac{A_0 - \frac{v_0}{\omega_0}}{2} e^{-\omega_0 t}} \text{ holds}""",
      r"""\text{Thus,}""",
      r"""
      \begin{aligned}
      f(t) &= \displaystyle \frac{A_0 + \frac{v_0}{\omega_0}}{2}e^{\omega_0 t} + \displaystyle \frac{A_0 - \frac{v_0}{\omega_0}}{2}e^{-\omega_0 t}\\[6pt]
      &= A_0 \cdot \displaystyle \frac{e^{\omega_0 t} + e^{-\omega_0 t}}{2} + \displaystyle \frac{v_0}{\omega_0} \cdot \displaystyle \frac{e^{\omega_0 t} - e^{-\omega_0 t}}{2}\\[6pt]
      &= A_0\cosh(\omega_0 t) + \displaystyle \frac{v_0}{\omega_0}\sinh(\omega_0 t)
      \end{aligned}
      """,
      r"""\textcolor{green}{7.\ } \textcolor{green}{Expression\ in\ exponential\ form}""",
      r"""\text{In all cases, the final solution is}""",
      r"""f(t) = A_0\cosh(\omega_0 t) + \displaystyle \frac{v_0}{\omega_0}\sinh(\omega_0 t)""",
      r"""\text{In exponential form:}""",
      r"""
      \begin{aligned}
      f(t) &= A_0\cosh(\omega_0 t) + \displaystyle \frac{v_0}{\omega_0}\sinh(\omega_0 t)\\[6pt]
      &= A_0 \cdot \displaystyle \frac{e^{\omega_0 t} + e^{-\omega_0 t}}{2} + \displaystyle \frac{v_0}{\omega_0} \cdot \displaystyle \frac{e^{\omega_0 t} - e^{-\omega_0 t}}{2}\\[6pt]
      &= \displaystyle \frac{A_0 + \frac{v_0}{\omega_0}}{2}e^{\omega_0 t} + \displaystyle \frac{A_0 - \frac{v_0}{\omega_0}}{2}e^{-\omega_0 t}
      \end{aligned}
      """,
    ],
  ),

  // first_order_exponential_problems.dart
  // (reserve / commented-out in source)
  "30948029-223D-426E-92E9-DAF075344AA4": ProblemTranslation(
    category: 'General - 1st Order - Homogeneous',
    level: 'Mid',
    question:
        r"""V(t)\ \text{given},\ f'(V)+\gamma\displaystyle\frac{f(V)}{V}=0,\ \gamma>1,\ f(V_0)=p_0""",
    answer:
        r"""f(V)=p_0\left(\displaystyle\frac{V_0}{V}\right)^{\gamma}\quad \Leftrightarrow \ f(t)=p_0\,V_0^{\gamma}\,[V(t)]^{-\gamma}""",
    hint: r"""\text{Solve }f(V)=C V^{-\gamma}\text{ and use }f(V_0)=p_0\text{.}""",
    steps: [
      r"\textbf{[Solution]}",
      r"\text{Rewrite as } \displaystyle\frac{f'(V)}{f(V)}=-\frac{\gamma}{V}\text{ and integrate.}",
      r"\begin{aligned} \log|f(V)| &= -\gamma\log|V|+C \end{aligned}",
      r"\begin{aligned} f(V) &= C V^{-\gamma}. \end{aligned}",
      r"\text{Use } f(V_0)=p_0 \Rightarrow C=p_0 V_0^{\gamma}, \text{ hence } f(V)=p_0\left(\displaystyle\frac{V_0}{V}\right)^\gamma.",
      r"\text{If }V=V(t)\text{ is given, then }f(t)=f(V(t)).",
    ],
  ),
  "035BEF48-5556-4099-9AD4-1FBE772833CE": ProblemTranslation(
    category: 'Numeric - 1st Order - Homogeneous',
    level: 'Easy',
    question: r"""f'(t)=-2\,f(t),\quad f(0)=f_0""",
    answer: r"""f(t)=f_0 e^{-2 t}""",
    hint: r"""\text{Multiply by the integrating factor }e^{2t}\text{.}""",
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• Velocity decay of a particle subject only to air resistance is modeled by } v'(t)+\displaystyle\frac{k}{m}v(t)=0\text{. The velocity decreases exponentially.}""",
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• RC discharge: the charge on the capacitor decreases exponentially.}""",
      r"""\text{• In an RC circuit, Kirchhoff's second law gives } RI(t)+\displaystyle\frac{Q(t)}{C}=0\text{. Dividing by }R\text{ and differentiating yields } I'(t)+\displaystyle\frac{1}{RC}I(t)=0\text{, which describes the time evolution of the discharge current.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Mechanics]}}""",
      r"""\text{Motion under air resistance:}\ v'(t)+\displaystyle\frac{k}{m}v(t)=0""",
      r"""\text{• } f(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } 2 \leftrightarrow \displaystyle\frac{k}{m} \text{ (drag coefficient / mass)}""",
      r"""\text{• } f_0 \leftrightarrow v_0 \text{ (initial velocity)}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{RC circuit discharge:}\ I'(t)+\displaystyle\frac{1}{RC}I(t)=0""",
      r"""\text{• } f(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } 2 \leftrightarrow \displaystyle\frac{1}{RC} \text{ (inverse time constant)}""",
      r"""\text{• } f_0 \leftrightarrow I_0 \text{ (initial current)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""f'(t)+2f(t)=0""",
      r"""\text{Multiply both sides by }e^{2t}\text{. (This works well.)}""",
      r"""\Leftrightarrow \ e^{2t}f'(t)+2e^{2t}f(t)=0""",
      r"""\text{By the product rule,}""",
      r"""\Leftrightarrow \ (e^{2t}f(t))'=0""",
      r"""\text{Integrate both sides from }0\text{ to }t\text{:}""",
      r"""
\begin{aligned}
&\Leftrightarrow \int_0^t (e^{2s}f(s))'\,ds = \int_0^t 0\,ds\\[5pt]
&\Leftrightarrow [e^{2s}f(s)]_{0}^{t} = 0\\[5pt]
&\Leftrightarrow \ e^{2t}f(t) - e^0 f(0) = 0\\[5pt]
&\Leftrightarrow \ e^{2t}f(t) = f(0)
\end{aligned}
""",
      r"""\text{Using the initial condition } f(0)=f_0\text{,}""",
      r"""\Leftrightarrow \ e^{2t}f(t)=f_0""",
      r"""\Leftrightarrow \ f(t)=f_0e^{-2t}""",
      r"""\text{This is an exponential decay with decay constant }2\text{.}""",
    ],
  ),
  "D2706488-8F89-46F4-8636-834028B00CFC": ProblemTranslation(
    category: 'Numeric - 1st Order - Non-homogeneous',
    level: 'Easy',
    question: r"""f'(t)+3\,f(t)=2,\quad f(0)=1""",
    answer: r"""f(t)=\displaystyle \frac{2}{3}+\displaystyle \frac{1}{3}e^{-3 t}""",
    hint: r"""\text{Use the integrating factor }e^{3t}\text{.}""",
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• Free fall under air resistance is modeled by } v'(t) = -\displaystyle \frac{k}{m}v(t) + g \text{, and the velocity converges exponentially to } \displaystyle \frac{mg}{k}\text{.}""",
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• For an RL circuit driven by DC voltage, Kirchhoff's second law gives } LI'(t) + RI(t) = V\text{. Dividing by }L\text{ reduces it to the same form as this problem. The current converges exponentially to } \displaystyle \frac{V}{R}\text{.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Mechanics]}}""",
      r"""\text{Equation of motion for free fall with air resistance: } \ mv'(t) = -kv(t)+mg""",
      r"""\text{• } f(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } 3 \leftrightarrow \displaystyle \frac{k}{m} \text{ (drag coefficient / mass)}""",
      r"""\text{• } \displaystyle \frac{2}{3} \leftrightarrow \displaystyle \frac{mg}{k} \text{ (terminal velocity)}""",
      r"""\text{• } 2 \leftrightarrow \displaystyle \frac{mg}{m} = g \text{ (gravitational acceleration)}""",
      r"""\text{• } f(0)=1 \leftrightarrow v_0=1 \text{ (initial velocity)}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{RL circuit (DC): } \ LI'(t) + RI(t) = V""",
      r"""\text{• } f(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } 3 \leftrightarrow \displaystyle \frac{R}{L} \text{ (inverse time constant)}""",
      r"""\text{• } 2 \leftrightarrow \displaystyle \frac{V}{L} \text{ (voltage / inductance)}""",
      r"""\text{• } \displaystyle \frac{2}{3} \leftrightarrow \displaystyle \frac{V}{R} \text{ (steady-state current)}""",
      r"""\text{• } f(0)=1 \leftrightarrow I_0=1 \text{ (initial current)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""f'(t) + 3f(t) = 2""",
      r"""\text{Multiply both sides by }e^{3t}\text{. (This works well)}""",
      r"""\Leftrightarrow \ e^{3t}f'(t) + 3e^{3t}f(t) = 2e^{3t}""",
      r"""\text{By the product rule,}""",
      r"""\Leftrightarrow (e^{3t}f(t))' = 2e^{3t}""",
      r"""\text{Integrate both sides from }0\text{ to }t\text{:}""",
      r"""
\begin{aligned}
&\Leftrightarrow \int_0^t (e^{3s}f(s))'\,ds = \int_0^t 2e^{3s}\,ds\\[5pt]
&\Leftrightarrow [e^{3s}f(s)]_{0}^{t} = \left[\displaystyle \frac{2}{3}e^{3s}\right]_{0}^{t}\\[5pt]
&\Leftrightarrow \ e^{3t}f(t) - e^0 f(0) = \displaystyle \frac{2}{3}e^{3t} - \displaystyle \frac{2}{3}e^0\\[5pt]
&\Leftrightarrow \ e^{3t}f(t) = f(0) + \displaystyle \frac{2}{3}(e^{3t}-1)
\end{aligned}
""",
      r"""\text{Using the initial condition } f(0)=1\text{:}""",
      r"""\Leftrightarrow \ e^{3t}f(t) = 1 + \displaystyle \frac{2}{3}(e^{3t}-1)""",
      r"""\Leftrightarrow \ e^{3t}f(t) = \displaystyle \frac{2}{3}e^{3t} + \displaystyle \frac{1}{3}""",
      r"""\Leftrightarrow \ f(t) = \displaystyle \frac{2}{3} + \displaystyle \frac{1}{3}e^{-3t}""",
      r"""\text{This solution shows exponential convergence to the target value } \displaystyle \frac{2}{3} \text{ with time constant } \displaystyle \frac{1}{3}\text{.}""",
    ],
  ),
  "5FFA2B66-BA71-44F4-9834-EF997E17081D": ProblemTranslation(
    category: 'Numeric - 2nd Order - Non-homogeneous',
    level: 'Easy',
    question: r"""f''(t)+3\,f'(t)=2,\quad f(0)=1,\ f'(0)=5""",
    answer:
        r"""f(t)=\displaystyle \frac{22}{9} + \displaystyle \frac{2}{3}t-\displaystyle \frac{13}{9}e^{-3 t}""",
    hint: r"""\text{Let }u(t)=f'(t)\text{ to reduce to a 1st-order linear ODE.}""",
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• Motion under a constant external force with air resistance is modeled by } mx'' + kx' = mg\text{.}""",
      r"""\text{• The velocity converges exponentially to the terminal velocity } \displaystyle \frac{mg}{k}\text{. Near terminal velocity, the motion is approximately uniform (external force and drag balance).}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Mechanics]}}""",
      r"""\text{Motion with constant force under air resistance: } \ mx''(t) + kx'(t) = mg""",
      r"""\text{• } f(t) \leftrightarrow x(t) \text{ (position)}""",
      r"""\text{• } f'(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } f''(t) \leftrightarrow a(t) \text{ (acceleration)}""",
      r"""\text{• } 3 \leftrightarrow \displaystyle \frac{k}{m} \text{ (drag coefficient / mass)}""",
      r"""\text{• } 2 \leftrightarrow \displaystyle \frac{mg}{m} = g \text{ (gravitational acceleration)}""",
      r"""\text{• } f(0)=1 \leftrightarrow x_0=1 \text{ (initial position)}""",
      r"""\text{• } f'(0)=5 \leftrightarrow v_0=5 \text{ (initial velocity)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""f''(t) + 3f'(t) = 2""",
      r"""\text{Substitution: let }u(t)=f'(t)\text{. Then}""",
      r"""\Leftrightarrow \ u'(t) + 3u(t) = 2""",
      r"""\text{Multiply both sides by }e^{3t}\text{. (This works well)}""",
      r"""\Leftrightarrow \ e^{3t}u'(t) + 3e^{3t}u(t) = 2e^{3t}""",
      r"""\text{By the product rule,}""",
      r"""\Leftrightarrow (e^{3t}u(t))' = 2e^{3t}""",
      r"""\text{Integrate both sides from }0\text{ to }t\text{:}""",
      r"""
\begin{aligned}
&\Leftrightarrow \int_0^t (e^{3s}u(s))'\,ds = \int_0^t 2e^{3s}\,ds\\[5pt]
&\Leftrightarrow [e^{3s}u(s)]_{0}^{t} = \left[\displaystyle \frac{2}{3}e^{3s}\right]_{0}^{t}\\[5pt]
&\Leftrightarrow \ e^{3t}u(t) - e^0 u(0) = \displaystyle \frac{2}{3}e^{3t} - \displaystyle \frac{2}{3}e^0\\[5pt]
&\Leftrightarrow \ e^{3t}u(t) = u(0) + \displaystyle \frac{2}{3}(e^{3t}-1)
\end{aligned}
""",
      r"""\text{Using the initial condition }u(0)=f'(0)=5\text{:}""",
      r"""\Leftrightarrow \ e^{3t}u(t) = 5 + \displaystyle \frac{2}{3}(e^{3t}-1)""",
      r"""\Leftrightarrow \ e^{3t}u(t) = \displaystyle \frac{2}{3}e^{3t} + 5 - \displaystyle \frac{2}{3}""",
      r"""\Leftrightarrow \ e^{3t}u(t) = \displaystyle \frac{2}{3}e^{3t} + \displaystyle \frac{13}{3}""",
      r"""\Leftrightarrow \ u(t) = \displaystyle \frac{2}{3} + \displaystyle \frac{13}{3}e^{-3t}""",
      r"""\text{Return to the original variable: } f'(t)=u(t)\text{.}""",
      r"""\text{Integrate both sides from }0\text{ to }t\text{:}""",
      r"""
\begin{aligned}
&\Leftrightarrow \int_0^t f'(s)\,ds = \int_0^t u(s)\,ds\\[5pt]
&\Leftrightarrow [f(s)]_{0}^{t} = \int_0^t \left[\displaystyle \frac{2}{3} + \displaystyle \frac{13}{3}e^{-3s}\right]ds\\[5pt]
&\Leftrightarrow \ f(t) - f(0) = \left[\displaystyle \frac{2}{3}s\right]_{0}^{t} + \displaystyle \frac{13}{3}\left[-\displaystyle \frac{1}{3}e^{-3s}\right]_{0}^{t}\\[5pt]
&\Leftrightarrow \ f(t) = f(0) + \displaystyle \frac{2}{3}t + \displaystyle \frac{13}{3}\left(-\displaystyle \frac{1}{3}e^{-3t} + \displaystyle \frac{1}{3}\right)
\end{aligned}
""",
      r"""\text{Using the initial condition } f(0)=1\text{:}""",
      r"""\Leftrightarrow \ f(t) = 1 + \displaystyle \frac{2}{3}t + \displaystyle \frac{13}{3}\left(-\displaystyle \frac{1}{3}e^{-3t} + \displaystyle \frac{1}{3}\right)""",
      r"""\Leftrightarrow \ f(t) = 1 + \displaystyle \frac{2}{3}t - \displaystyle \frac{13}{9}e^{-3t} + \displaystyle \frac{13}{9}""",
      r"""\Leftrightarrow \ f(t) = \displaystyle \frac{22}{9} + \displaystyle \frac{2}{3}t - \displaystyle \frac{13}{9}e^{-3t}""",
      r"""\text{This solution is of the form (line) + (exponential), converging exponentially with decay constant }3\text{.}""",
    ],
  ),
  "666687A5-6EF8-434E-9209-818CE7092863": ProblemTranslation(
    category: 'Numeric - 1st Order - Non-homogeneous (AC RL)',
    level: 'Mid',
    question:
        r"""\sqrt{3}f'(t)+2f(t)=3\sqrt{3}\cos(2t),\quad f(0)=0""",
    answer:
        r"""f(t)=\displaystyle \frac{3\sqrt{3}}{4}\cos \left( 2t- \displaystyle \frac{\pi}{3} \right)-\displaystyle \frac{3\sqrt{3}}{8}e^{- \frac{2}{\sqrt{3}}t}""",
    hint:
        r"""\text{Divide by }\sqrt{3}\text{ and use an integrating factor. Use } \int e^{at}\cos(\omega t)\,dt \text{ formula.}""",
    steps: [
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• For an AC RL circuit, Kirchhoff's second law gives } LI'(t) + RI(t) = V_0\cos(\omega t)\text{.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ RL\ AC\ circuit]}}""",
      r"""\text{• } f(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } \sqrt{3} \leftrightarrow L \text{ (inductance)}""",
      r"""\text{• } 2 \leftrightarrow R \text{ (resistance)}""",
      r"""\text{• } 3\sqrt{3} \leftrightarrow V_0 \text{ (voltage amplitude)}""",
      r"""\text{• } \displaystyle \frac{2}{\sqrt{3}} \leftrightarrow \displaystyle \frac{R}{L} \text{ (inverse time constant)}""",
      r"""\text{• } 3 \leftrightarrow \displaystyle \frac{V_0}{L} \text{ (voltage amplitude / inductance)}""",
      r"""\text{• } 2 \leftrightarrow \omega \text{ (angular frequency)}""",
      r"""\text{• } 0 \leftrightarrow I_0 \text{ (initial current)}""",
      r"""\text{• } |Z| = \sqrt{(2\sqrt{3})^2+2^2} = 4 \leftrightarrow \sqrt{R^2+(\omega L)^2} \text{ (impedance magnitude)}""",
      r"""\text{• } \displaystyle \frac{3}{\sqrt{\left(\displaystyle \frac{2}{\sqrt{3}}\right)^2+2^2}}= \frac {3 \sqrt 3}{4} \leftrightarrow \displaystyle \frac{V_0}{\sqrt{R^2+(\omega L)^2}} = \displaystyle \frac{V_0}{|Z|} \text{ (steady-state current amplitude)}""",
      r"""\text{• } \tan\alpha = \displaystyle \frac{2}{\displaystyle \frac{2}{\sqrt{3}}} = \sqrt 3 \Leftrightarrow \alpha = \frac \pi 3 \leftrightarrow \displaystyle \frac{\omega L}{R} \text{ (phase lag angle)}""",
      r"""\textcolor{red}{\textbf{Integral formula for (exponential)\(\times\)(trigonometric):}}""",
      r"""\textcolor{red}{\displaystyle \int e^{a t}\cos(\omega t)\,dt=\displaystyle \frac{e^{a t}}{a^2+\omega^2}\big(a\cos(\omega t)+\omega\sin(\omega t)\big)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\sqrt{3}f'(t) + 2f(t) = 3\sqrt{3}\cos(2t)""",
      r"""\text{Divide both sides by } \sqrt{3} \text{ to obtain the standard form:}""",
      r"""\Leftrightarrow \ f'(t) + \displaystyle \frac{2}{\sqrt{3}}f(t) = 3\cos(2t)""",
      r"""\text{Multiply both sides by }e^{ \frac{2}{\sqrt{3}}t}\text{. (This works well)}""",
      r"""\Leftrightarrow \ e^{ \frac{2}{\sqrt{3}}t}f'(t) + \displaystyle \frac{2}{\sqrt{3}}e^{ \frac{2}{\sqrt{3}}t}f(t) = 3e^{ \frac{2}{\sqrt{3}}t}\cos(2t)""",
      r"""\text{By the product rule,}""",
      r"""\Leftrightarrow (e^{ \frac{2}{\sqrt{3}}t}f(t))' = 3e^{ \frac{2}{\sqrt{3}}t}\cos(2t)""",
      r"""\text{Integrate both sides from }0\text{ to }t\text{:}""",
      r"""\Leftrightarrow \int_0^t \left(e^{ \frac{2}{\sqrt{3}}s}f(s)\right)'\,ds = \int_0^t 3e^{ \frac{2}{\sqrt{3}}s}\cos(2s)\,ds""",
      r"""\Leftrightarrow \left[e^{ \frac{2}{\sqrt{3}}s}f(s)\right]_{0}^{t} = 3\int_0^t e^{ \frac{2}{\sqrt{3}}s}\cos(2s)\,ds""",
      r"""\Leftrightarrow \ e^{ \frac{2}{\sqrt{3}}t}f(t) - e^0 f(0) = 3\int_0^t e^{ \frac{2}{\sqrt{3}}s}\cos(2s)\,ds""",
      r"""\Leftrightarrow \ e^{ \frac{2}{\sqrt{3}}t}f(t) = 3\int_0^t e^{ \frac{2}{\sqrt{3}}s}\cos(2s)\,ds""",
      r"""\Leftrightarrow \ f(t) = 3e^{ -\frac{2}{\sqrt{3}}t}\int_0^t e^{ \frac{2}{\sqrt{3}}s}\cos(2s)\,ds""",
      r"""\textcolor{red}{\textbf{Use\ the\ integral\ formula\ above\ for\ the\ RHS:}}""",
      r"""\textcolor{red}{\int e^{\frac{2}{\sqrt{3}}s}\cos(2s)\,ds = \displaystyle \frac{e^{\frac{2}{\sqrt{3}}s}}{\left(\frac{2}{\sqrt{3}}\right)^2+2^2}\left(\frac{2}{\sqrt{3}}\cos(2s)+2\sin(2s)\right) + C}""",
      r"""\textcolor{green}{Therefore\ the\ definite\ integral\ is}""",
      r"""\textcolor{green}{\int_0^t e^{\frac{2}{\sqrt{3}}s}\cos(2s)\,ds = \left[\displaystyle \frac{e^{\frac{2}{\sqrt{3}}s}}{\left(\frac{2}{\sqrt{3}}\right)^2+2^2}\left(\frac{2}{\sqrt{3}}\cos(2s)+2\sin(2s)\right)\right]_{0}^{t}}""",
      r"""\textcolor{green}{= \displaystyle \frac{e^{\frac{2}{\sqrt{3}}t}}{\left(\frac{2}{\sqrt{3}}\right)^2+2^2}\left(\frac{2}{\sqrt{3}}\cos(2t)+2\sin(2t)\right) - \displaystyle \frac{1}{\left(\frac{2}{\sqrt{3}}\right)^2+2^2}\left(\frac{2}{\sqrt{3}}\cos(0)+2\sin(0)\right)}""",
      r"""\textcolor{green}{= \displaystyle \frac{e^{\frac{2}{\sqrt{3}}t}}{\left(\frac{2}{\sqrt{3}}\right)^2+2^2}\left(\frac{2}{\sqrt{3}}\cos(2t)+2\sin(2t)\right) - \displaystyle \frac{\frac{2}{\sqrt{3}}}{\left(\frac{2}{\sqrt{3}}\right)^2+2^2}}""",
      r"""\text{Here } \left(\frac{2}{\sqrt{3}}\right)^2+2^2 = \frac{4}{3} + 4 = \frac{16}{3}\text{, so}""",
      r"""\textcolor{green}{= \displaystyle \frac{3e^{\frac{2}{\sqrt{3}}t}}{16}\left(\frac{2}{\sqrt{3}}\cos(2t)+2\sin(2t)\right) - \displaystyle \frac{3 \cdot \frac{2}{\sqrt{3}}}{16}}""",
      r"""\text{Therefore,}""",
      r"""\Leftrightarrow \ f(t) = 3e^{-\frac{2}{\sqrt{3}}t} \left( \displaystyle \frac{3e^{\frac{2}{\sqrt{3}}t}}{16}\left(\frac{2}{\sqrt{3}}\cos(2t)+2\sin(2t)\right) - \frac{3\sqrt{3}}{8} \right)""",
      r"""\Leftrightarrow \ f(t) = \displaystyle \frac{9}{16}\left(\frac{2}{\sqrt{3}}\cos(2t)+2\sin(2t)\right) - \displaystyle \frac{3\sqrt{3}}{8}e^{-\frac{2}{\sqrt{3}}t}""",
      r"""\Leftrightarrow \ f(t) = \displaystyle \frac{9}{16}\left(\frac{2}{\sqrt{3}}\cos(2t)+2\sin(2t)\right) - \displaystyle \frac{3\sqrt{3}}{8}e^{-\frac{2}{\sqrt{3}}t}""",
      r"""\text{Factor the forcing term by } \sqrt{\left(\displaystyle \frac{2}{\sqrt{3}}\right)^2+2^2} = \displaystyle \frac{4}{\sqrt{3}} \text{:}""",
      r"""\Leftrightarrow \ f(t) = \displaystyle \frac{9}{16} \cdot \displaystyle \frac{4}{\sqrt{3}}\left(\displaystyle \frac{1}{2}\cos(2t) + \displaystyle \frac{\sqrt{3}}{2}\sin(2t)\right) - \displaystyle \frac{3\sqrt{3}}{8}e^{- \frac{2}{\sqrt{3}}t}""",
      r"""\Leftrightarrow \ f(t) = \displaystyle \frac{3\sqrt{3}}{4}\cos\left(2t - \displaystyle \frac{\pi}{3}\right) - \displaystyle \frac{3\sqrt{3}}{8}e^{- \frac{2}{\sqrt{3}}t}""",
      r"""\text{As } t \to \infty \text{, } e^{- \frac{2}{\sqrt{3}}t} \to 0\text{, so}""",
      r"""f(t) \to \displaystyle \frac{3\sqrt{3}}{4}\cos\left(2t - \displaystyle \frac{\pi}{3}\right)\text{.}""",
      r"""\text{Thus, compared to the phase } \omega t \text{ of the RHS, the solution lags by } \displaystyle \frac{\pi}{3}\text{.}""",
    ],
  ),
  "A6304C30-50F4-40E4-A056-A57A60548064": ProblemTranslation(
    category: 'Numeric - 1st Order - Non-homogeneous (AC RC integral form)',
    level: 'Mid',
    question:
        r"""\displaystyle \frac{\int_0^t f(s) \, ds}{2}+\sqrt{3}f(t)=4\cos\left(\displaystyle \frac{t}{2}\right),\quad f(0)=0""",
    answer:
        r"""f(t)=2\cos\left(\displaystyle \frac{t}{2} + \displaystyle \frac{\pi}{6}\right)-\sqrt{3}e^{- \frac{t}{2\sqrt{3}}}""",
    hint:
        r"""\text{Differentiate once to get a 1st-order linear ODE for }f(t)\text{.}""",
    steps: [
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• For an AC RC circuit (with initial capacitor charge 0), Kirchhoff's second law gives } RI(t)+\displaystyle \frac{1}{C}\int_0^t I(s)\,ds = V_0\cos(\omega t)\text{.}""",
      r"""\text{• In the steady state, the current }I(t)\text{ oscillates at the same angular frequency }\omega\text{ and its amplitude is } \displaystyle \frac{V_0}{\sqrt{R^2+\left(\displaystyle \frac{1}{\omega C}\right)^2}}\text{.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{RC AC circuit (initial capacitor charge 0): } \ \displaystyle \frac{1}{C}\int_0^t I(s)\,ds + RI(t) = V_0\cos(\omega t)""",
      r"""\text{• } f(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } 2 \leftrightarrow C \text{ (capacitance)}""",
      r"""\text{• } \sqrt{3} \leftrightarrow R \text{ (resistance)}""",
      r"""\text{• } 4 \leftrightarrow V_0 \text{ (voltage amplitude)}""",
      r"""\text{• } \displaystyle \frac{1}{2} \leftrightarrow \omega \text{ (angular frequency)}""",
      r"""\text{• } 0 \leftrightarrow I_0 \text{ (initial current)}""",
      r"""\text{• } |Z| = \sqrt{(\sqrt{3})^2+\left(\displaystyle \frac{1}{\displaystyle \frac{1}{2} \times 2}\right)^2} = 2 \leftrightarrow \sqrt{R^2+\left(\displaystyle \frac{1}{\omega C}\right)^2} \text{ (impedance magnitude)}""",
      r"""\text{• } \displaystyle \frac{4}{\sqrt{(\sqrt{3})^2+\left(\displaystyle \frac{1}{\displaystyle \frac{1}{2} \times 2}\right)^2}} = 2 \leftrightarrow \displaystyle \frac{V_0}{\sqrt{R^2+\left(\displaystyle \frac{1}{\omega C}\right)^2}} = \displaystyle \frac{V_0}{|Z|} \text{ (steady-state current amplitude)}""",
      r"""\text{• } \tan\alpha = \displaystyle \frac{1}{\displaystyle \frac{1}{2} \times 2 \times \sqrt{3}} = \displaystyle \frac{1}{\sqrt{3}} \Leftrightarrow \alpha = \displaystyle \frac{\pi}{6} \leftrightarrow \displaystyle \frac{1}{\omega RC} \text{ (phase lead angle)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\displaystyle \frac{\int_0^t f(s) \, ds}{2} + \sqrt{3}f(t) = 4\cos\left(\displaystyle \frac{t}{2}\right)""",
      r"""\text{Differentiate both sides:}""",
      r"""\Leftrightarrow \ \displaystyle \frac{f(t)}{2} + \sqrt{3}f'(t) = -2\sin\left(\displaystyle \frac{t}{2}\right)""",
      r"""\Leftrightarrow \ f'(t) + \displaystyle \frac{1}{2\sqrt{3}}f(t) = -\displaystyle \frac{2}{\sqrt{3}}\sin\left(\displaystyle \frac{t}{2}\right)""",
      r"""\text{Multiply both sides by }e^{\frac{t}{2\sqrt{3}}}\text{. (This works well)}""",
      r"""\Leftrightarrow \ e^{\frac{t}{2\sqrt{3}}}f'(t) + \displaystyle \frac{1}{2\sqrt{3}}e^{\frac{t}{2\sqrt{3}}}f(t) = -\displaystyle \frac{2}{\sqrt{3}}e^{\frac{t}{2\sqrt{3}}}\sin\left(\displaystyle \frac{t}{2}\right)""",
      r"""\text{By the product rule,}""",
      r"""\Leftrightarrow (e^{\frac{t}{2\sqrt{3}}}f(t))' = -\displaystyle \frac{2}{\sqrt{3}}e^{\frac{t}{2\sqrt{3}}}\sin\left(\displaystyle \frac{t}{2}\right)""",
      r"""\Leftrightarrow \int_0^t (e^{\frac{s}{2\sqrt{3}}}f(s))'\,ds = -\displaystyle \frac{2}{\sqrt{3}}\int_0^t e^{\frac{s}{2\sqrt{3}}}\sin\left(\displaystyle \frac{s}{2}\right)\,ds""",
      r"""\Leftrightarrow [e^{\frac{s}{2\sqrt{3}}}f(s)]_{0}^{t} = -\displaystyle \frac{2}{\sqrt{3}}\int_0^t e^{\frac{s}{2\sqrt{3}}}\sin\left(\displaystyle \frac{s}{2}\right)\,ds""",
      r"""\Leftrightarrow \ e^{\frac{t}{2\sqrt{3}}}f(t) - 0 = -\displaystyle \frac{2}{\sqrt{3}}\int_0^t e^{\frac{s}{2\sqrt{3}}}\sin\left(\displaystyle \frac{s}{2}\right)\,ds""",
      r"""\Leftrightarrow \ f(t) = -\displaystyle \frac{2}{\sqrt{3}}e^{-\frac{t}{2\sqrt{3}}} \int_0^t e^{\frac{s}{2\sqrt{3}}}\sin\left(\displaystyle \frac{s}{2}\right)\,ds""",
      r"""\textcolor{red}{\textbf{Use\ the\ integral\ formula\ for\ the\ RHS:}}""",
      r"""\textcolor{red}{\int e^{\frac{s}{2\sqrt{3}}}\sin\left(\displaystyle \frac{s}{2}\right)\,ds = \displaystyle \frac{e^{\frac{s}{2\sqrt{3}}}}{\left(\frac{1}{2\sqrt{3}}\right)^2+\left(\frac{1}{2}\right)^2}\left(\frac{1}{2\sqrt{3}}\sin\left(\displaystyle \frac{s}{2}\right)-\frac{1}{2}\cos\left(\displaystyle \frac{s}{2}\right)\right) + C}""",
      r"""\textcolor{green}{Therefore,\ the\ definite\ integral\ is}""",
      r"""\textcolor{green}{\int_0^t e^{\frac{s}{2\sqrt{3}}}\sin\left(\displaystyle \frac{s}{2}\right)\,ds = \left[\displaystyle \frac{e^{\frac{s}{2\sqrt{3}}}}{\left(\frac{1}{2\sqrt{3}}\right)^2+\left(\frac{1}{2}\right)^2}\left(\frac{1}{2\sqrt{3}}\sin\left(\displaystyle \frac{s}{2}\right)-\frac{1}{2}\cos\left(\displaystyle \frac{s}{2}\right)\right)\right]_{0}^{t}}""",
      r"""\textcolor{green}{= \displaystyle \frac{e^{\frac{t}{2\sqrt{3}}}}{\left(\frac{1}{2\sqrt{3}}\right)^2+\left(\frac{1}{2}\right)^2}\left(\frac{1}{2\sqrt{3}}\sin\left(\displaystyle \frac{t}{2}\right)-\frac{1}{2}\cos\left(\displaystyle \frac{t}{2}\right)\right) - \displaystyle \frac{1}{\left(\frac{1}{2\sqrt{3}}\right)^2+\left(\frac{1}{2}\right)^2}\left(\frac{1}{2\sqrt{3}}\sin(0)-\frac{1}{2}\cos(0)\right)}""",
      r"""\textcolor{green}{= \displaystyle \frac{e^{\frac{t}{2\sqrt{3}}}}{\left(\frac{1}{2\sqrt{3}}\right)^2+\left(\frac{1}{2}\right)^2}\left(\frac{1}{2\sqrt{3}}\sin\left(\displaystyle \frac{t}{2}\right)-\frac{1}{2}\cos\left(\displaystyle \frac{t}{2}\right)\right) + \displaystyle \frac{\frac{1}{2}}{\left(\frac{1}{2\sqrt{3}}\right)^2+\left(\frac{1}{2}\right)^2}}""",
      r"""\text{Here } \left(\frac{1}{2\sqrt{3}}\right)^2+\left(\frac{1}{2}\right)^2 = \frac{1}{12} + \frac{1}{4} = \frac{1}{3}\text{, so}""",
      r"""\textcolor{green}{= \displaystyle \frac{\sqrt{3}e^{\frac{t}{2\sqrt{3}}}}{2}\sin\left(\displaystyle \frac{t}{2}\right) - \frac{3e^{\frac{t}{2\sqrt{3}}}}{2}\cos\left(\displaystyle \frac{t}{2}\right) + \frac{3}{2}}""",
      r"""\text{Therefore,}""",
      r"""\Leftrightarrow \ f(t) = -\displaystyle \frac{2}{\sqrt{3}}e^{-\frac{t}{2\sqrt{3}}} \left( \displaystyle \frac{\sqrt{3}e^{\frac{t}{2\sqrt{3}}}}{2}\sin\left(\displaystyle \frac{t}{2}\right) - \frac{3e^{\frac{t}{2\sqrt{3}}}}{2}\cos\left(\displaystyle \frac{t}{2}\right) + \frac{3}{2} \right)""",
      r"""\Leftrightarrow \ f(t) = -\sin\left(\displaystyle \frac{t}{2}\right) + \sqrt{3}\cos\left(\displaystyle \frac{t}{2}\right) - \sqrt{3}e^{- \frac{t}{2\sqrt{3}}}""",
      r"""\Leftrightarrow \ f(t) = \sqrt{3}\cos\left(\displaystyle \frac{t}{2}\right) - \sin\left(\displaystyle \frac{t}{2}\right) - \sqrt{3}e^{- \frac{t}{2\sqrt{3}}}""",
      r"""\text{Factor the forcing term by } \sqrt{(\sqrt{3})^2+1^2} = 2\text{:}""",
      r"""\Leftrightarrow \ f(t) = 2\left(\displaystyle \frac{\sqrt{3}}{2}\cos\left(\displaystyle \frac{t}{2}\right) - \frac{1}{2}\sin\left(\displaystyle \frac{t}{2}\right)\right) - \sqrt{3}e^{- \frac{t}{2\sqrt{3}}}""",
      r"""\text{By combining trigonometric functions,}""",
      r"""\Leftrightarrow \ f(t) = 2\cos\left(\displaystyle \frac{t}{2} + \displaystyle \frac{\pi}{6}\right) - \sqrt{3}e^{- \frac{t}{2\sqrt{3}}}""",
      r"""\text{As } t \to \infty \text{, } e^{- \frac{t}{2\sqrt{3}}} \to 0\text{, so}""",
      r"""f(t) \to 2\cos\left(\displaystyle \frac{t}{2} + \displaystyle \frac{\pi}{6}\right)\text{.}""",
      r"""\text{Thus, compared to the phase } \omega t \text{ of the RHS, the solution leads by } \displaystyle \frac{\pi}{6}\text{.}""",
    ],
  ),
  "448E166D-FEF8-4A70-8541-FCA04C82C7F8": ProblemTranslation(
    category: 'Numeric - 1st Order - Non-homogeneous (AC Inductor)',
    level: 'Easy',
    question: r"""2f'(t)=12\sin(4t),\quad f(0)=0""",
    answer: r"""f(t)=-\displaystyle \frac{3}{2}\cos(4t)+\displaystyle \frac{3}{2}""",
    steps: [
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• For an AC circuit with only an inductor, Kirchhoff's second law gives } LI'(t)=V_0\sin(\omega t)\text{.}""",
      r"""\text{• The phase of the current }I(t)\text{ lags the phase of the voltage }V_0\sin(\omega t)\text{ by }\displaystyle \frac{\pi}{2}\text{.}""",
      r"""\text{• The amplitude of the current }I(t)\text{ is } \displaystyle \frac{1}{\omega L} \text{ times the voltage amplitude.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{Inductor-only AC circuit: } \ LI'(t) = V_0\sin(\omega t)""",
      r"""\text{• } f(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } 2 \leftrightarrow L \text{ (inductance)}""",
      r"""\text{• } 12 \leftrightarrow V_0 \text{ (voltage amplitude)}""",
      r"""\text{• } 4 \leftrightarrow \omega \text{ (angular frequency)}""",
      r"""\text{• } f(0)=0 \leftrightarrow I_0=0 \text{ (initial current)}""",
      r"""\text{• }4\times 2=8 \leftrightarrow X_L=\omega L \text{ (inductive reactance)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""2f'(t) = 12\sin(4t)""",
      r"""\text{Divide both sides by }2\text{:}""",
      r"""\Leftrightarrow \ f'(t) = 6\sin(4t)""",
      r"""\text{Integrate both sides from }0\text{ to }t\text{:}""",
      r"""\Leftrightarrow \int_0^t f'(s)\,ds = \int_0^t 6\sin(4s)\,ds""",
      r"""\Leftrightarrow [f(s)]_{0}^{t} = 6\int_0^t \sin(4s)\,ds""",
      r"""\Leftrightarrow \ f(t) - f(0) = 6\left[-\displaystyle \frac{1}{4}\cos(4s)\right]_{0}^{t}""",
      r"""\Leftrightarrow \ f(t) = f(0) + 6\left(-\displaystyle \frac{1}{4}\cos(4t) + \displaystyle \frac{1}{4}\cos(0)\right)""",
      r"""\text{Using the initial condition } f(0)=0\text{:}""",
      r"""\Leftrightarrow \ f(t) = 0 + 6\left(-\displaystyle \frac{1}{4}\cos(4t) + \displaystyle \frac{1}{4}\right)""",
      r"""\Leftrightarrow \ f(t) = -\displaystyle \frac{3}{2}\cos(4t) + \displaystyle \frac{3}{2}""",
      r"""\text{To make the phase difference explicit, rewrite the steady-state term using a trig shift:}""",
      r"""\Leftrightarrow \ f(t) = \displaystyle \frac{3}{2}\sin\left(4t - \displaystyle \frac{\pi}{2}\right) + \displaystyle \frac{3}{2}""",
    ],
  ),
  "7E10C37B-AB59-4B49-8037-D1D34D1B3055": ProblemTranslation(
    category: 'Numeric - 1st Order - Non-homogeneous (AC Capacitor)',
    level: 'Easy',
    question:
        r"""\displaystyle \frac{\int_0^t f(s) \, ds}{0.2}=8\sin(10t),\quad f(0)=0""",
    answer: r"""f(t)=16\sin\left(10t+\displaystyle \frac{\pi}{2}\right)""",
    steps: [
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• For an AC circuit with only a capacitor, Kirchhoff's second law gives } \displaystyle \frac{Q(t)}{C} = V_0\sin(\omega t)\text{.}""",
      r"""\text{• The current }I(t)\text{ leads the voltage }V_0\sin(\omega t)\text{ by }\displaystyle \frac{\pi}{2}\text{.}""",
      r"""\text{• The amplitude of the current }I(t)\text{ is } \omega C \text{ times the voltage amplitude (capacitive reactance).}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{AC circuit with only a capacitor: } \ \displaystyle \frac{Q(t)}{C} = V_0\sin(\omega t)""",
      r"""\text{• } f(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } 0.2 \leftrightarrow C \text{ (capacitance)}""",
      r"""\text{• } 8 \leftrightarrow V_0 \text{ (voltage amplitude)}""",
      r"""\text{• } 10 \leftrightarrow \omega \text{ (angular frequency)}""",
      r"""\text{• } f(0)=0 \leftrightarrow I_0=0 \text{ (initial current)}""",
      r"""\text{• }\displaystyle \frac{1}{10 \times 0.2} = \frac{1}{2} \leftrightarrow X_C = \displaystyle \frac{1}{\omega C} \text{ (capacitive reactance)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\displaystyle \frac{\int_0^t f(s) \, ds}{0.2} = 8\sin(10t)""",
      r"""\text{Multiply both sides by }0.2\text{:}""",
      r"""\Leftrightarrow \ \int_0^t f(s) \, ds = 1.6\sin(10t)""",
      r"""\text{Differentiate both sides:}""",
      r"""\Leftrightarrow \ f(t) = 1.6 \times 10\cos(10t)""",
      r"""\Leftrightarrow \ f(t) = 16\cos(10t)""",
      r"""\text{Rewrite using a trigonometric shift to make the phase difference explicit:}""",
      r"""\Leftrightarrow \ f(t) = 16\sin\left(10t + \displaystyle \frac{\pi}{2}\right)""",
    ],
  ),
  "F744D6AB-A8EB-42F0-9740-0FD4DC4EA29D": ProblemTranslation(
    category: 'General - 1st Order - Homogeneous',
    level: 'Easy',
    constants: r"""a: constant""",
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• Velocity decay of a particle subject only to air resistance is modeled by } v'(t) + \displaystyle \frac{k}{m}v(t) = 0 \text{. Velocity decreases exponentially.}""",
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• In an RC discharging circuit, Kirchhoff's second law gives } RI(t) + \displaystyle \frac{Q(t)}{C} = 0 \text{. Dividing by } R \text{ and differentiating gives } I'(t) + \displaystyle \frac{1}{RC}I(t) = 0 \text{, representing the current change over time. Current decreases exponentially.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Mechanics]}}""",
      r"""\text{Motion under air resistance:} \ v'(t) + \displaystyle \frac{k}{m}v(t) = 0""",
      r"""\text{• } f(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } a \leftrightarrow \displaystyle \frac{k}{m} \text{ (resistance coefficient / mass)}""",
      r"""\text{• } f_0 \leftrightarrow v_0 \text{ (initial velocity)}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{RC circuit discharge:} \ I'(t) + \displaystyle \frac{1}{RC}I(t) = 0""",
      r"""\text{• } f(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } a \leftrightarrow \displaystyle \frac{1}{RC} \text{ (reciprocal of time constant)}""",
      r"""\text{• } f_0 \leftrightarrow I_0 \text{ (initial current)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""f'(t)+a\,f(t) = 0""",
      r"""\text{Multiply both sides by } e^{at} \text{. (This approach works well)}""",
      r"""\Leftrightarrow \ e^{at}f'(t) + ae^{at}f(t) = 0""",
      r"""\text{By the product rule for derivatives:}""",
      r"""\Leftrightarrow (e^{at}f(t))' = 0""",
      r"""\text{Integrate both sides from } 0 \text{ to } t \text{.}""",
      r"""
\begin{aligned}
&\Leftrightarrow \int_0^t (e^{as}f(s))'\,ds = \int_0^t 0\,ds\\[5pt]
&\Leftrightarrow [e^{as}f(s)]_{0}^{t} = 0\\[5pt]
&\Leftrightarrow \ e^{at}f(t) - e^0 f(0) = 0\\[5pt]
&\Leftrightarrow \ e^{at}f(t) = f(0)
\end{aligned}
""",
      r"""\text{From initial conditions, } f(0) = f_0 \text{, so:}""",
      r"""
\begin{aligned}
&\Leftrightarrow \ e^{at}f(t) = f_0\\[5pt]
&\Leftrightarrow \ f(t) = f_0e^{-at}
\end{aligned}
""",
      r"""\text{This solution is an exponential decay function, decreasing exponentially with decay constant } a \text{.}""",
    ],
  ),
  "E5E4228F-7819-4063-A4DB-9F1DB3D27225": ProblemTranslation(
    category: 'General - 1st Order - Non-homogeneous',
    level: 'Easy',
    constants: r"""a \neq 0,\ b: constant""",
    steps: [
      r"""\text{[Mechanics]}""",
      r"""\text{• Free fall under air resistance is modeled by } v'(t) = -\displaystyle \frac{k}{m}v(t) + g \text{, where velocity converges exponentially to } \displaystyle \frac{mg}{k} \text{.}""",
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• Applying Kirchhoff's second law to an RL circuit with DC voltage gives } LI'(t) + RI(t) = V \text{. Dividing by } L \text{ leads to the problem's form. Current converges exponentially to } \displaystyle \frac{V}{R} \text{.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Mechanics]}}""",
      r"""\text{Free fall with air resistance:} \ mv'(t) = -kv(t)+mg""",
      r"""\text{• } f(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } a \leftrightarrow \displaystyle \frac{k}{m} \text{ (resistance coefficient / mass)}""",
      r"""\text{• } \frac b a \leftrightarrow \displaystyle \frac{mg}{k} \text{ (terminal velocity)}""",
      r"""\text{• } b \leftrightarrow \displaystyle \frac{mg}{m} = g \text{ (gravitational acceleration)}""",
      r"""\text{• } f_0 \leftrightarrow v_0 \text{ (initial velocity)}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{RL circuit (DC):} \ LI'(t) + RI(t) = V""",
      r"""\text{• } f(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } a \leftrightarrow \displaystyle \frac{R}{L} \text{ (reciprocal of time constant)}""",
      r"""\text{• } b \leftrightarrow \displaystyle \frac{V}{L} \text{ (voltage / inductance)}""",
      r"""\text{• } \frac b a \leftrightarrow \displaystyle \frac{V}{R} \text{ (steady-state current)}""",
      r"""\text{• } f_0 \leftrightarrow I_0 \text{ (initial current)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""f'(t) + af(t) = b""",
      r"""\text{Multiply both sides by } e^{at} \text{. (This approach works well)}""",
      r"""\Leftrightarrow \ e^{at}f'(t) + ae^{at}f(t) = be^{at}""",
      r"""\text{By the product rule for derivatives:}""",
      r"""\Leftrightarrow (e^{at}f(t))' = be^{at}""",
      r"""\text{Integrate both sides from } 0 \text{ to } t \text{:}""",
      r"""
\begin{aligned}
&\Leftrightarrow \int_0^t (e^{as}f(s))'\,ds = \int_0^t be^{as}\,ds\\[5pt]
&\Leftrightarrow [e^{as}f(s)]_{0}^{t} = \left[\displaystyle \frac{b}{a}e^{as}\right]_{0}^{t}\\[5pt]
&\Leftrightarrow \ e^{at}f(t) - e^0 f(0) = \displaystyle \frac{b}{a}e^{at} - \displaystyle \frac{b}{a}e^0\\[5pt]
&\Leftrightarrow \ e^{at}f(t) = f(0) + \displaystyle \frac{b}{a}(e^{at}-1) 
\end{aligned}
""",
      r"""\text{From initial conditions, } f(0) = f_0 \text{, so:}""",
      r"""\Leftrightarrow \ e^{at}f(t) = f_0 + \displaystyle \frac{b}{a}(e^{at}-1)""",
      r"""\Leftrightarrow \ e^{at}f(t) = \displaystyle \frac{b}{a}e^{at} + f_0 - \displaystyle \frac{b}{a}""",
      r"""\Leftrightarrow \ f(t) = \displaystyle \frac{b}{a}+\left(f_0-\displaystyle \frac{b}{a}\right)e^{-at}""",
      r"""\text{This solution shows exponential convergence to the target value } \displaystyle \frac{b}{a} \text{ with time constant } \displaystyle \frac{1}{a} \text{.}""",
    ],
  ),
  "D87D022C-7BED-4C0D-BC95-8A74C64BCD86": ProblemTranslation(
    category: 'General - 2nd Order - Non-homogeneous',
    level: 'Easy',
    constants: r"""a\neq 0,\ b: constant""",
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• Motion under a constant external force with air resistance is modeled by } mx'' + kx' = mg \text{.}""",
      r"""\text{• Velocity converges exponentially to terminal velocity } \displaystyle \frac{mg}{k} \text{. Near terminal velocity, the motion approximates uniform linear motion where external and resistive forces balance.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Mechanics]}}""",
      r"""\text{Constant external force with air resistance:} \ mx''(t) + kx'(t) = mg""",
      r"""\text{• } f(t) \leftrightarrow x(t) \text{ (position)}""",
      r"""\text{• } f'(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } f''(t) \leftrightarrow a(t) \text{ (acceleration)}""",
      r"""\text{• } a \leftrightarrow \displaystyle \frac{k}{m} \text{ (resistance coefficient / mass)}""",
      r"""\text{• } b \leftrightarrow \displaystyle \frac{mg}{m} = g \text{ (gravitational acceleration)}""",
      r"""\text{• } f_0 \leftrightarrow x_0 \text{ (initial position)}""",
      r"""\text{• } v_0 \leftrightarrow v_0 \text{ (initial velocity)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""f''(t) + af'(t) = b""",
      r"""\textcolor{green}{1. }\textcolor{green}{Reduce\ to\ 1st\ order\ linear\ non-homogeneous}""",
      r"""\text{Substitute } u(t) = f'(t) \text{:}""",
      r"""\Leftrightarrow \ u'(t) + au(t) = b""",
      r"""\textcolor{green}{2.} \textcolor{green}{Solve\ for\ } \textcolor{green{u}} \textcolor{green}{\ using\ integrating\ factor}""",
      r"""\text{Multiply both sides by } e^{at} \text{. (This approach works well)}""",
      r"""\Leftrightarrow \ e^{at}u'(t) + ae^{at}u(t) = be^{at}""",
      r"""\text{By the product rule for derivatives:}""",
      r"""\Leftrightarrow (e^{at}u(t))' = be^{at}""",
      r"""\text{Integrate both sides from } 0 \text{ to } t \text{:}""",
      r"""
\begin{aligned}
&\Leftrightarrow \int_0^t (e^{as}u(s))'\,ds = \int_0^t be^{as}\,ds\\[5pt]
&\Leftrightarrow [e^{as}u(s)]_{0}^{t} = \left[\displaystyle \frac{b}{a}e^{as}\right]_{0}^{t}\\[5pt]
&\Leftrightarrow \ e^{at}u(t) - e^0 u(0) = \displaystyle \frac{b}{a}e^{at} - \displaystyle \frac{b}{a}e^0\\[5pt]
&\Leftrightarrow \ e^{at}u(t) = u(0) + \displaystyle \frac{b}{a}(e^{at}-1)
\end{aligned}
""",
      r"""\text{From initial conditions, } u(0) = v_0 \text{, so:}""",
      r"""\Leftrightarrow \ e^{at}u(t) = v_0 + \displaystyle \frac{b}{a}(e^{at}-1)""",
      r"""\Leftrightarrow \ e^{at}u(t) = \displaystyle \frac{b}{a}e^{at} + v_0 - \displaystyle \frac{b}{a}""",
      r"""\Leftrightarrow \ u(t) = \displaystyle \frac{b}{a} + \left(v_0-\displaystyle \frac{b}{a}\right)e^{-at}""",
      r"""\textcolor{green}{3. } \textcolor{green}{Solve\ for\ } \textcolor{green}{f}""",
      r"""\text{Revert to original variable: } f'(t) = u(t) \text{:}""",
      r"""\text{Integrate both sides from } 0 \text{ to } t \text{:}""",
      r"""
\begin{aligned}
&\Leftrightarrow \int_0^t f'(s)\,ds = \int_0^t u(s)\,ds\\[5pt]
&\Leftrightarrow [f(s)]_{0}^{t} = \int_0^t \left[\displaystyle \frac{b}{a} + \left(v_0-\displaystyle \frac{b}{a}\right)e^{-as}\right]ds\\[5pt]
&\Leftrightarrow \ f(t) - f(0) = \left[\displaystyle \frac{b}{a}s\right]_{0}^{t} + \left(v_0-\displaystyle \frac{b}{a}\right)\left[-\displaystyle \frac{1}{a}e^{-as}\right]_{0}^{t}\\[5pt]
&\Leftrightarrow \ f(t) = f(0) + \displaystyle \frac{b}{a}t - 0 + \left(v_0-\displaystyle \frac{b}{a}\right)\left(-\displaystyle \frac{1}{a}e^{-at} + \displaystyle \frac{1}{a}e^0\right)
\end{aligned}
""",
      r"""\text{From initial conditions, } f(0) = f_0 \text{, so:}""",
      r"""\Leftrightarrow \ f(t) = f_0 + \displaystyle \frac{b}{a}t + \left(v_0-\displaystyle \frac{b}{a}\right)\left(-\displaystyle \frac{1}{a}e^{-at} + \displaystyle \frac{1}{a}\right)""",
      r"""\Leftrightarrow \ f(t) = f_0 + \displaystyle \frac{b}{a}t - \displaystyle \frac{v_0-\displaystyle \frac{b}{a}}{a}e^{-at} + \displaystyle \frac{v_0-\displaystyle \frac{b}{a}}{a}""",
      r"""\Leftrightarrow \ f(t) = f_0 + \displaystyle \frac{v_0-\displaystyle \frac{b}{a}}{a} + \displaystyle \frac{b}{a}t - \displaystyle \frac{v_0-\displaystyle \frac{b}{a}}{a}e^{-at}""",
      r"""\text{This solution converges exponentially with time constant } a \text{ to the linear function } f_0 + \displaystyle \frac{v_0-\displaystyle \frac{b}{a}}{a} + \displaystyle \frac{b}{a}t \text{.}""",
    ],
  ),
  "1DAE0FE3-E342-4547-956C-6CD1EA31EAD3": ProblemTranslation(
    category: 'General - 1st Order - Non-homogeneous',
    level: 'Mid',
    constants: r"""a \neq 0,\ \omega \neq 0""",
    steps: [
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• For an RL AC circuit, Kirchhoff's second law gives } LI'(t) + RI(t) = V_0\cos(\omega t) \text{.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{RL AC circuit:} \ LI'(t) + RI(t) = V_0\cos(\omega t)""",
      r"""\text{• } f(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } a \leftrightarrow \displaystyle \frac{R}{L} \text{ (reciprocal of time constant)}""",
      r"""\text{• } F \leftrightarrow \displaystyle \frac{V_0}{L} \text{ (voltage amplitude / inductance)}""",
      r"""\text{• } \omega \leftrightarrow \omega \text{ (angular frequency)}""",
      r"""\text{• } f_0 \leftrightarrow I_0 \text{ (initial current)}""",
      r"""\text{• } |Z| = \sqrt{a^2+\omega^2} \leftrightarrow \sqrt{R^2+(\omega L)^2} \text{ (impedance magnitude)}""",
      r"""\text{• } \displaystyle \frac{F}{\sqrt{a^2+\omega^2}} \leftrightarrow \displaystyle \frac{V_0}{\sqrt{R^2+(\omega L)^2}} = \displaystyle \frac{V_0}{|Z|} \text{ (steady-state current amplitude)}""",
      r"""\text{• } \tan\alpha = \displaystyle \frac{\omega}{a} \leftrightarrow \displaystyle \frac{\omega L}{R} \text{ (phase lag angle)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""f'(t) + af(t) = F\cos(\omega t)""",
      r"""\text{Multiply both sides by } e^{at} \text{. (This approach works well)}""",
      r"""\Leftrightarrow \ e^{at}f'(t) + ae^{at}f(t) = Fe^{at}\cos(\omega t)""",
      r"""\text{By the product rule for derivatives:}""",
      r"""\Leftrightarrow (e^{at}f(t))' = Fe^{at}\cos(\omega t)""",
      r"""\text{Integrate both sides from } 0 \text{ to } t \text{:}""",
      r"""\Leftrightarrow \int_0^t (e^{as}f(s))'\,ds = \int_0^t Fe^{as}\cos(\omega s)\,ds""",
      r"""\Leftrightarrow [e^{as}f(s)]_{0}^{t} = F\int_0^t e^{as}\cos(\omega s)\,ds""",
      r"""\Leftrightarrow \ e^{at}f(t) - f_0 = F\int_0^t e^{as}\cos(\omega s)\,ds""",
      r"""\textcolor{green}{From\ the\ integral\ formula,\ the\ indefinite\ integral\ is:}""",
      r"""\textcolor{green}{\int e^{as}\cos(\omega s)\,ds = \displaystyle \frac{e^{as}}{a^2+\omega^2}\big(a\cos(\omega s)+\omega\sin(\omega s)\big) + C}""",
      r"""\textcolor{green}{Therefore,\ the\ definite\ integral\ is:}""",
      r"""\textcolor{green}{\int_0^t e^{as}\cos(\omega s)\,ds = \left[\displaystyle \frac{e^{as}}{a^2+\omega^2}\big(a\cos(\omega s)+\omega\sin(\omega s)\big)\right]_{0}^{t}}""",
      r"""\textcolor{green}{= \displaystyle \frac{e^{at}}{a^2+\omega^2}\big(a\cos(\omega t)+\omega\sin(\omega t)\big) - \displaystyle \frac{e^{0}}{a^2+\omega^2}\big(a\cos(0)+\omega\sin(0)\big)}""",
      r"""\textcolor{green}{= \displaystyle \frac{e^{at}}{a^2+\omega^2}\big(a\cos(\omega t)+\omega\sin(\omega t)\big) - \displaystyle \frac{a}{a^2+\omega^2}}""",
      r"""\text{Thus,}""",
      r"""\Leftrightarrow \ e^{at}f(t) - f_0 = F\left(\displaystyle \frac{e^{at}}{a^2+\omega^2}\big(a\cos(\omega t)+\omega\sin(\omega t)\big) - \displaystyle \frac{a}{a^2+\omega^2}\right)""",
      r"""\Leftrightarrow \ e^{at}f(t) = \displaystyle \frac{Fe^{at}}{a^2+\omega^2}\big(a\cos(\omega t)+\omega\sin(\omega t)\big) - \displaystyle \frac{Fa}{a^2+\omega^2} + f_0""",
      r"""\Leftrightarrow \ f(t) = \displaystyle \frac{F}{a^2+\omega^2}(a\cos(\omega t) + \omega\sin(\omega t)) + \left(f_0 - \displaystyle \frac{Fa}{a^2+\omega^2}\right)e^{-at}""",
      r"""\text{Factor the forced vibration term by } \sqrt{a^2+\omega^2} \text{:}""",
      r"""\Leftrightarrow \ f(t) = \displaystyle \frac{F}{\sqrt{a^2+\omega^2}} \cdot \displaystyle \frac{a\cos(\omega t) + \omega\sin(\omega t)}{\sqrt{a^2+\omega^2}} + \left(f_0 - \displaystyle \frac{Fa}{a^2+\omega^2}\right)e^{-at}""",
      r"""\text{By trigonometric synthesis:}""",
      r"""\Leftrightarrow \ f(t) = \displaystyle \frac{F}{\sqrt{a^2+\omega^2}}\cos(\omega t - \alpha) + \left(f_0 - \displaystyle \frac{Fa}{a^2+\omega^2}\right)e^{-at}""",
      r"""\text{where } \tan\alpha = \displaystyle \frac{\omega}{a} \text{.}""",
      r"""\text{Since } e^{-at} \to 0 \text{ as } t \to \infty \text{:}""",
      r"""f(t) \to \displaystyle \frac{F}{\sqrt{a^2+\omega^2}}\cos(\omega t - \alpha) \text{.}""",
      r"""\text{The phase of the solution function lags behind the phase of the RHS trigonometric function } \omega t \text{ by } \alpha \text{.}""",
    ],
  ),
  "574DF54B-E141-4B50-944D-F38724F1ADC3": ProblemTranslation(
    category: 'General - 1st Order - Non-homogeneous',
    level: 'Mid',
    constants: r"""a, b, F, \omega: positive constants""",
    steps: [
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• For an RC AC circuit with initial charge 0, Kirchhoff's second law gives } RI(t) + \displaystyle \frac{1}{C}\int_0^t I(s)\,ds = V_0\cos(\omega t) \text{.}""",
      r"""\text{• In steady state, current } I(t) \text{ oscillates at the same angular frequency } \omega \text{ as the voltage, with amplitude } \displaystyle \frac{V_0}{\sqrt{R^2+\left(\displaystyle \frac{1}{\omega C}\right)^2}} \text{.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{RC AC circuit (initial charge 0):} \ \displaystyle \frac{1}{C}\int_0^t I(s)ds + RI(t) = V_0\cos(\omega t)""",
      r"""\text{• } f(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } a \leftrightarrow C \text{ (capacitance)}""",
      r"""\text{• } b \leftrightarrow R \text{ (resistance)}""",
      r"""\text{• } F \leftrightarrow V_0 \text{ (voltage amplitude)}""",
      r"""\text{• } \omega \leftrightarrow \omega \text{ (angular frequency)}""",
      r"""\text{• } \tan\alpha = \displaystyle \frac{1}{a b \omega} \leftrightarrow \displaystyle \frac{1}{ RC \omega} \text{ (phase lead angle)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\displaystyle \frac{\int_0^t f(s) \, ds}{a} + bf(t) = F\cos(\omega t)""",
      r"""\text{Differentiate both sides:}""",
      r"""\Leftrightarrow \ \displaystyle \frac{f(t)}{a} + bf'(t) = -F\omega\sin(\omega t)""",
      r"""\Leftrightarrow \ f'(t) + \displaystyle \frac{1}{ab}f(t) = -\displaystyle \frac{F\omega}{b}\sin(\omega t)""",
      r"""\text{Multiply both sides by } e^{ \frac{t}{ab}} \text{:}""",
      r"""\Leftrightarrow \ e^{ \frac{t}{ab}}f'(t) + \displaystyle \frac{1}{ab}e^{ \frac{t}{ab}}f(t) = -\displaystyle \frac{F\omega}{b}e^{ \frac{t}{ab}}\sin(\omega t)""",
      r"""\text{By the product rule for derivatives:}""",
      r"""\Leftrightarrow (e^{ \frac{t}{ab}}f(t))' = -\displaystyle \frac{F\omega}{b}e^{ \frac{t}{ab}}\sin(\omega t)""",
      r"""\text{Integrate both sides from } 0 \text{ to } t \text{:}""",
      r"""\Leftrightarrow [e^{ \frac{s}{ab}}f(s)]_{0}^{t} = -\displaystyle \frac{F\omega}{b}\int_0^t e^{ \frac{s}{ab}}\sin(\omega s)\,ds""",
      r"""\Leftrightarrow \ e^{ \frac{t}{ab}}f(t) - f(0) = -\displaystyle \frac{F\omega}{b}\int_0^t e^{ \frac{s}{ab}}\sin(\omega s)\,ds \cdots(1)
\ \ \ \ \ (\text{Evaluating at }t=0\text{ gives }bf(0)=F\Rightarrow f(0)=\dfrac{F}{b}.)""",
      r"""\text{Indefinite integral formula: } \textcolor{blue}{\int e^{\alpha t}\sin(\beta t)\,dt = \displaystyle \frac{e^{\alpha t}}{\alpha^2+\beta^2}\big(\alpha\sin(\beta t)-\beta\cos(\beta t)\big) + C}""",
      r"""\text{Letting } \alpha=\displaystyle \frac{1}{ab}, \beta=\omega \text{:}""",
      r"""\text{RHS of (1) } = -\displaystyle \frac{F\omega}{b}\int_0^t e^{ \frac{s}{ab}}\sin(\omega s)\,ds""",
      r"""= -\displaystyle \frac{F\omega}{b} \textcolor{blue}{\left[\displaystyle \frac{e^{ \frac{s}{ab}}}{\left(\frac{1}{ab}\right)^2+\omega^2}\left(\frac{1}{ab}\sin(\omega s)-\omega\cos(\omega s)\right)\right]_0^t}""",
      r"""= -\displaystyle \frac{F\omega}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}\left(e^{ \frac{t}{ab}}\left(\frac{1}{ab}\sin(\omega t)-\omega\cos(\omega t)\right) - \left(\frac{1}{ab}\cdot 0 - \omega\cdot 1\right)\right)""",
      r"""= -\displaystyle \frac{F\omega}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}\left(e^{ \frac{t}{ab}}\left(\frac{1}{ab}\sin(\omega t)-\omega\cos(\omega t)\right) + \omega\right)""",
      r"""= -\displaystyle \frac{F\omega e^{ \frac{t}{ab}}}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}\left(\frac{1}{ab}\sin(\omega t)-\omega\cos(\omega t)\right) - \displaystyle \frac{F\omega^2}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}""",
      r"""\text{Thus (1) becomes:}""",
      r"""\Leftrightarrow \ e^{ \frac{t}{ab}}f(t) = f(0) - \displaystyle \frac{F\omega e^{ \frac{t}{ab}}}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}\left(\frac{1}{ab}\sin(\omega t)-\omega\cos(\omega t)\right) - \displaystyle \frac{F\omega^2}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}""",
      r"""\Leftrightarrow \ e^{ \frac{t}{ab}}f(t) = \dfrac{F}{b} - \displaystyle \frac{F\omega e^{ \frac{t}{ab}}}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}\left(\frac{1}{ab}\sin(\omega t)-\omega\cos(\omega t)\right) - \displaystyle \frac{F\omega^2}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}""",
      r"""\text{So}""",
      r"""\Leftrightarrow \ f(t) = \displaystyle \frac{F\omega}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}\left(\omega\cos(\omega t) - \frac{1}{ab}\sin(\omega t)\right) 
    + \left(\dfrac{F}{b} - \dfrac{F\omega^2}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}\right)e^{- \frac{t}{ab}}""",
      r"""\text{Simplify the transient term constant (let } D=(\tfrac{1}{ab})^2+\omega^2\text{):}""",
      r"""
      \begin{aligned}
      \dfrac{F}{b} - \dfrac{F\omega^2}{bD}
      &= \dfrac{F}{b}\left(1 - \dfrac{\omega^2}{D}\right)\\[5pt]
      &= \dfrac{F}{b}\cdot\dfrac{D-\omega^2}{D} \\[5pt]
      &= \dfrac{F}{b}\cdot\dfrac{\left(\frac{1}{ab}\right)^2}{D}\\[5pt]
      &= \dfrac{F}{b\bigl(1+(ab\omega)^2\bigr)} \\[5pt]
      &= \dfrac{F}{b}\cdot\dfrac{1}{a^2\omega^2\left(b^2 + \left(\displaystyle\frac{1}{a \omega}\right)^2\right)} \\[5pt]
      &= \dfrac{F}{b a^2\omega^2\left(b^2 + \left(\displaystyle\frac{1}{a \omega}\right)^2\right)}
      \end{aligned}
      """,
      r"""\text{Thus the transient term is:}""",
      r"""\dfrac{F}{b\bigl(1+(ab\omega)^2\bigr)} = \dfrac{F}{b a^2\omega^2\left(b^2 + \left(\displaystyle\frac{1}{a \omega}\right)^2\right)}""",
      r"""\text{Finally,}""",
      r"""    \boxed{\,f(t)=\displaystyle \frac{F}{\sqrt{b^2+\left(\displaystyle \frac{1}{a \omega}\right)^2}}\cos(\omega t + \alpha)
    +\displaystyle \frac{F}{b a^2\omega^2\left(b^2 + \left(\displaystyle\frac{1}{a \omega}\right)^2\right)}\,e^{- \frac{t}{ab}}\,}""",
      r"""\text{where } \tan\alpha = \displaystyle \frac{1}{ ab \omega} \text{ (phase).}""",
      r"""As t\to\infty \text{, the transient term vanishes and the solution converges to the steady-state solution:}""",
      r"""\displaystyle \frac{F}{\sqrt{b^2+\left(\displaystyle \frac{1}{a \omega}\right)^2}}\cos(\omega t + \alpha) \text{.}""",
    ],
  ),
  "B4FDC2FF-78D4-5C52-C9FE-2477A027B74E": ProblemTranslation(
    category: 'General - 1st Order - Non-homogeneous',
    level: 'Easy',
    constants: r"""L>0,\ A,\omega: constant""",
    steps: [
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• In electromagnetism, it appears in the form } LI'(t) = V_0\sin(\omega t) \text{.}""",
      r"""\text{• The phase of the current } I(t) \text{ lags behind the phase of the voltage } V_0\sin(\omega t) \text{ by } \displaystyle \frac{\pi}{2} \text{.}""",
      r"""\text{• The amplitude of current } I(t) \text{ is } \displaystyle \frac{1}{\omega L} \text{ times the voltage amplitude (inductive reactance).}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{Inductor-only AC circuit:} \ LI'(t) = V_0\sin(\omega t)""",
      r"""\text{• } f(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } L \leftrightarrow L \text{ (inductance)}""",
      r"""\text{• } A \leftrightarrow V_0 \text{ (voltage amplitude)}""",
      r"""\text{• } \omega \leftrightarrow \omega \text{ (angular frequency)}""",
      r"""\text{• } f(0)=0 \leftrightarrow I_0=0 \text{ (initial current)}""",
      r"""\text{• Inductive reactance: } X_L = \omega L""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""Lf'(t) = A\sin(\omega t)""",
      r"""\text{Divide both sides by } L \text{:}""",
      r"""\Leftrightarrow \ f'(t) = \displaystyle \frac{A}{L}\sin(\omega t)""",
      r"""\text{Integrate both sides from } 0 \text{ to } t \text{:}""",
      r"""\Leftrightarrow \int_0^t f'(s)\,ds = \int_0^t \displaystyle \frac{A}{L}\sin(\omega s)\,ds""",
      r"""\Leftrightarrow [f(s)]_{0}^{t} = \displaystyle \frac{A}{L}\int_0^t \sin(\omega s)\,ds""",
      r"""\Leftrightarrow \ f(t) - f(0) = \displaystyle \frac{A}{L}\left[-\displaystyle \frac{1}{\omega}\cos(\omega s)\right]_{0}^{t}""",
      r"""\Leftrightarrow \ f(t) = f(0) + \displaystyle \frac{A}{L}\left(-\displaystyle \frac{1}{\omega}\cos(\omega t) + \displaystyle \frac{1}{\omega}\cos(0)\right)""",
      r"""\text{From initial conditions, } f(0) = 0 \text{, so:}""",
      r"""\Leftrightarrow \ f(t) = 0 + \displaystyle \frac{A}{L}\left(-\displaystyle \frac{1}{\omega}\cos(\omega t) + \displaystyle \frac{1}{\omega}\right)""",
      r"""\Leftrightarrow \ f(t) = -\displaystyle \frac{A}{L\omega}\cos(\omega t) + \displaystyle \frac{A}{L\omega}""",
      r"""\text{To clarify the phase difference, transform the steady-state part using trig conversion formulas:}""",
      r"""\Leftrightarrow \ f(t) = \displaystyle \frac{A}{L\omega}\sin\left(\omega t - \displaystyle \frac{\pi}{2}\right) + \displaystyle \frac{A}{L\omega}""",
    ],
  ),
  "A3ECB1EE-67C3-4B41-B8ED-13669F16A63D": ProblemTranslation(
    category: 'General - 1st Order - Non-homogeneous',
    level: 'Easy',
    constants: r"""C: positive constant""",
    steps: [
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• For an AC circuit with only a capacitor, Kirchhoff's second law gives } \displaystyle \frac{Q(t)}{C} = V_0\sin(\omega t)\text{.}""",
      r"""\text{• The phase of the current }I(t)\text{ leads the phase of the voltage }V_0\sin(\omega t)\text{ by }\displaystyle \frac{\pi}{2}\text{.}""",
      r"""\text{• The amplitude of the current }I(t)\text{ is } \omega C \text{ times the voltage amplitude (capacitive reactance).}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{AC circuit with only a capacitor: } \ \displaystyle \frac{Q(t)}{C} = V_0\sin(\omega t)""",
      r"""\text{• } f(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } C \leftrightarrow C \text{ (capacitance)}""",
      r"""\text{• } A \leftrightarrow V_0 \text{ (voltage amplitude)}""",
      r"""\text{• } \omega \leftrightarrow \omega \text{ (angular frequency)}""",
      r"""\text{• } f(0)=0 \leftrightarrow I_0=0 \text{ (initial current)}""",
      r"""\text{• Capacitive reactance: } X_C = \displaystyle \frac{1}{\omega C}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\displaystyle \frac{\int_0^t f(s) \, ds}{C} = A\sin(\omega t)""",
      r"""\text{Multiply both sides by }C\text{:}""",
      r"""\Leftrightarrow \ \int_0^t f(s) \, ds = CA\sin(\omega t)""",
      r"""\text{Differentiate both sides:}""",
      r"""\Leftrightarrow \ f(t) = \omega CA\cos(\omega t)""",
      r"""\text{Rewrite using a trigonometric shift to make the phase difference explicit:}""",
      r"""\Leftrightarrow \ f(t) = \omega CA\sin\left(\omega t + \displaystyle \frac{\pi}{2}\right)""",
    ],
  ),

  // rlc_series_discharge_problems.dart
  "ADC1559C-5A8D-490C-9D10-8722FECF3115": ProblemTranslation(
    category: '2nd Order Homogeneous - Constant Coefficients (Damping)',
    level: 'Advanced',
    constants: r"""\ 0< \beta < \omega_0""",
    steps: [
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• For an RLC series circuit, Kirchhoff's second law gives } LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = 0 \text{.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{Transient response of RLC series circuit:} \ LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = 0""",
      r"""\text{• } f(t) \leftrightarrow Q(t) \text{ (charge stored in capacitor)}""",
      r"""\text{• } f'(t) \leftrightarrow Q'(t) \text{ (current)}""",
      r"""\text{• } f''(t) \leftrightarrow Q''(t) \text{ (rate of current change)}""",
      r"""\text{• } \beta \leftrightarrow \displaystyle \frac{R}{2L} \text{ (damping constant)}""",
      r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{ (natural frequency when damping is 0)}""",
      r"""\text{• } \sqrt{\omega_0^2 - \beta^2} \leftrightarrow \sqrt{\displaystyle \frac{1}{LC} - \left(\displaystyle \frac{R}{2L}\right)^2} \text{ (damped angular frequency)}""",
      r"""\text{• } f_0 \leftrightarrow Q_0 \text{ (initial charge)}""",
      r"""\text{• } v_0 \leftrightarrow I_0 \text{ (initial current)}""",
      r"""\textcolor{brown}{\large{[Physical\ Meaning]}}""",
      r"""\text{• Envelope: Oscillates while decaying exponentially as } e^{-\beta t}""",
      r"""\text{• Oscillation frequency: } \sqrt{\omega_0^2 - \beta^2} \text{ (lower than natural frequency)}""",
      r"""\text{• Condition } \omega_0 > \beta \text{ results in underdamped oscillation}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\textcolor{green}{Formula\ when\ \ f'\ \ coefficient\ \ R\ \ is\ \ 0}""",
      r"""\text{The solution to the initial value problem for } f''(t) = -\omega^2 f(t) \text{ with }""",
      r"""f(0) = A_0, f'(0) = v_0 \text{ is}""",
      r"""f(t) = A_0\cos(\omega t) + \displaystyle \frac{v_0}{\omega}\sin(\omega t) \text{.}""",
      r"""\textcolor{blue}{Use\ this\ formula\ to\ solve\ this\ problem.}""",
      r"""\textcolor{green}{1.} \textcolor{green}{Eliminate\ 1st\ derivative\ by\ variable\ transformation}""",
      r"""\text{Multiply both sides of the original differential equation by } e^{\beta t} \text{:}""",
      r"""\quad \ \ f''(t) + 2\beta f'(t) + \omega_0^2 f(t) = 0""",
      r""" \Leftrightarrow \textcolor{red}{e^{\beta t}f''(t)} + \textcolor{red}{2e^{\beta t} \beta f'(t)} +  e^{\beta t} \omega_0^2 f(t) = 0 \cdots (1)""",
      r"""\text{By the product rule for derivatives:}""",
      r"""\left(e^{\beta t}f(t)\right)''(t) = e^{\beta t}f''(t) + 2e^{\beta t} \beta f'(t) + e^{\beta t} \beta^2 f(t) """,
      r"""\text{Thus,}""",
      r"""\textcolor{red}{e^{\beta t}f''(t)} + \textcolor{red}{2e^{\beta t} \beta f'(t)} = \textcolor{blue}{\left(e^{\beta t}f(t)\right)''(t) - \beta^2 e^{\beta t}f(t)}""",
      r"""\text{Substituting this into (1):}""",
      r"""\quad \ \textcolor{blue}{\left(e^{\beta t}f(t)\right)'' - \beta^2 e^{\beta t}f(t)} + \omega_0^2 e^{\beta t}f(t) = 0""",
      r"""\Leftrightarrow \left(e^{\beta t}f(t)\right)'' + \left(\omega_0^2 - \beta^2\right) e^{\beta t}f(t) = 0""",
      r"""\text{Letting } g(t) = e^{\beta t} f(t) \text{:}""",
      r"""g''(t) + \left(\omega_0^2 - \beta^2\right) g(t) = 0\ \ \cdots (2)""",
      r"""\textcolor{green}{2. } \textcolor{green}{Apply\ formula\ to\ find\ } \textcolor{green}{g}""",
      r"""\text{(2) is an equation for simple harmonic motion. Applying the formula (with } \omega = \sqrt{\omega_0^2 - \beta^2} \text{):}""",
      r"""g(t) = g(0)\cos\left(\sqrt{\omega_0^2 - \beta^2}\ \,t\right) + \displaystyle \frac{g'(0)}{\sqrt{\omega_0^2 - \beta^2}}\sin\left(\sqrt{\omega_0^2 - \beta^2}\ \,t\right)""",
      r"""\textcolor{green}{3.} \textcolor{green}{Find\ initial\ conditions\ for\ \ g}""",
      r"""\text{From } g(t) = e^{\beta t} f(t) \text{:}""",
      r"""\begin{aligned}
      g(0) &= e^{\beta \cdot 0} f(0) = f_0\\[6pt]
      g'(0) &= \beta e^{\beta \cdot 0} f(0) + e^{\beta \cdot 0} f'(0) = \beta f_0 + v_0
      \end{aligned}""",
      r"""\textcolor{green}{4.\ } \textcolor{green}{Find\ \ g}""",
      r"""\text{Substituting into the formula:}""",
      r"""g(t) = f_0\cos\left(\sqrt{\omega_0^2 - \beta^2}\ \,t\right) + \displaystyle \frac{v_0 + \beta f_0}{\sqrt{\omega_0^2 - \beta^2}}\sin\left(\sqrt{\omega_0^2 - \beta^2}\ \,t\right)""",
      r"""\textcolor{green}{5.\ } \textcolor{green}{Find\ \ f\ \ from\ \ g}""",
      r"""\text{From } g(t) = e^{\beta t} f(t) \text{, } f(t) = e^{-\beta t} g(t) \text{.}""",
      r"""\text{Thus,}""",
      r"""f(t) = e^{-\beta t}\left(f_0\cos\left(\sqrt{\omega_0^2 - \beta^2}\ \,t\right) + \displaystyle \frac{v_0 + \beta f_0}{\sqrt{\omega_0^2 - \beta^2}}\sin\left(\sqrt{\omega_0^2 - \beta^2}\ \,t\right)\right)""",
    ],
  ),
  "7336BB06-1577-4C05-8048-358FE98E59A8": ProblemTranslation(
    category: '2nd Order Homogeneous - Constant Coefficients (Damping)',
    level: 'Advanced',
    constants: r"""\gamma>0,\ \omega_0>0,\ \gamma>\omega_0""",
    hint: r"""\text{To eliminate the damping term } 2\gamma f' \text{, multiply both sides by } e^{\gamma t} \text{ and perform variable transformation to reduce it to an undamped hyperbolic type equation.}""",
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• Overdamped motion}""",
      r"""\text{• In mechanics, it often appears in the form } mx''(t) + 2cx'(t) + kx(t) = 0 \text{. This represents overdamped free vibration.}""",
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• Overdamped response of an RLC circuit}""",
      r"""\text{• In electromagnetism, it often appears in the form } LI'(t) + RI(t) + \displaystyle \frac{q(t)}{C} = 0 \text{. This represents Kirchhoff's law for an RLC circuit.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Mechanics]}}""",
      r"""\text{Overdamped motion:} \ mx''(t) + 2cx'(t) + kx(t) = 0""",
      r"""\text{• } f(t) \leftrightarrow x(t) \text{ (position)}""",
      r"""\text{• } f'(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } f''(t) \leftrightarrow a(t) \text{ (acceleration)}""",
      r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{2c}{m} \text{ (damping coefficient)}""",
      r"""\text{• } \omega_0 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{ (natural angular frequency)}""",
      r"""\text{• } \omega_h \leftrightarrow \sqrt{\displaystyle \frac{b^2}{4m^2} - \displaystyle \frac{k}{m}} \text{ (overdamped angular frequency)}""",
      r"""\text{• } f_0 \leftrightarrow x_0 \text{ (initial position)}""",
      r"""\text{• } v_0 \leftrightarrow v_0 \text{ (initial velocity)}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{Overdamped response of RLC circuit:} \ Lq''(t) + Rq'(t) + \displaystyle \frac{q(t)}{C} = 0""",
      r"""\text{• } f(t) \leftrightarrow q(t) \text{ (charge)}""",
      r"""\text{• } f'(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } f''(t) \leftrightarrow I' \text{ (rate of current change)}""",
      r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{R}{2L} \text{ (damping coefficient)}""",
      r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{ (natural angular frequency)}""",
      r"""\text{• } \omega_h \leftrightarrow \sqrt{\displaystyle \frac{R^2}{4L^2} - \displaystyle \frac{1}{LC}} \text{ (overdamped angular frequency)}""",
      r"""\text{• } f_0 \leftrightarrow q_0 \text{ (initial charge)}""",
      r"""\text{• } v_0 \leftrightarrow I_0 \text{ (initial current)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\textbf{[Strategy]}""",
      r"""\text{To eliminate the damping term } 2\gamma f' \text{, multiply both sides by } e^{\gamma t} \text{ and perform variable transformation to reduce it to an undamped hyperbolic type equation.}""",
      r"""\text{Steps for equivalent transformation:}""",
      r"""\text{1. Multiply both sides by } e^{\gamma t}""",
      r"""\text{2. Transform to form } (e^{\gamma t}f(t))''""",
      r"""\text{3. Variable transformation } y(t) = e^{\gamma t}f(t)""",
      r"""\text{4. Reduce to hyperbolic equation } y'' - \omega_h^2 y = 0""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""f''(t) + 2\gamma f'(t) + \omega_0^2 f(t) = 0""",
      r"""\text{Variable transformation: let } y(t) = e^{\gamma t} f(t) \text{:}""",
      r"""\Leftrightarrow \ y''(t) - \omega_h^2 y(t) = 0 \quad (\omega_h = \sqrt{\gamma^2 - \omega_0^2})""",
      r"""\text{General solution:}""",
      r"""\Leftrightarrow \ y(t) = C_1 e^{\omega_h t} + C_2 e^{-\omega_h t}""",
      r"""\text{Apply initial conditions:}""",
      r"""\Leftrightarrow \ C_1 = \displaystyle \frac{f_0\omega_h + (v_0 + \gamma f_0)}{2\omega_h}, \quad C_2 = \displaystyle \frac{f_0\omega_h - (v_0 + \gamma f_0)}{2\omega_h}""",
      r"""\text{Revert to original variable:}""",
      r"""\Leftrightarrow \ f(t) = \displaystyle \frac{f_0\omega_h + (v_0 + \gamma f_0)}{2\omega_h}e^{(-\gamma + \omega_h)t} + \displaystyle \frac{f_0\omega_h - (v_0 + \gamma f_0)}{2\omega_h}e^{(-\gamma - \omega_h)t}""",
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• In mechanics, it often appears in the form } mx''(t) + cx'(t) + kx(t) = 0 \text{. This represents overdamped motion.}""",
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{Transient response of RLC circuit (overdamped). Converges exponentially with damping constant } \gamma = \displaystyle \frac{R}{2L} \text{.}""",
      r"""\text{In electromagnetism, it often appears in the form } Lq''(t) + Rq'(t) + \displaystyle \frac{q(t)}{C} = 0 \text{. This represents an overdamped RLC circuit.}""",
      r"""\text{Impedance magnitude is } |Z| = \sqrt{R^2 + \left(\omega L - \displaystyle \frac{1}{\omega C}\right)^2}\text{, and phase lag angle } \alpha \text{ is } \alpha = \arctan\left(\displaystyle \frac{\omega L - \displaystyle \frac{1}{\omega C}}{R}\right)\text{.}""",
      r"""\text{Resonant frequency is } \omega_0 = \displaystyle \frac{1}{\sqrt{LC}}\text{, and when } \gamma > \omega_0 \text{ it is overdamped.}""",
    ],
  ),
  "0B9BFE1C-6950-40C5-BBAC-776B7F1E855F": ProblemTranslation(
    category: '2nd Order Homogeneous - Constant Coefficients (Damping)',
    level: 'Advanced',
    constants: r"""\gamma>0,\ \omega_0>0,\ \gamma=\omega_0""",
    hint: r"""\text{Eliminate the velocity term } 2\gamma f' \text{ by substitution to reduce to undamped form, then use standard simple harmonic motion formulas.}""",
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• Damped free vibration (critical damping)}""",
      r"""\text{• In mechanics, it often appears in the form } mx''(t) + 2cx'(t) + kx(t) = 0 \text{. This represents critically damped free vibration. Envelope is } e^{-\gamma t} \text{.}""",
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• Transient response of RLC circuit (critical damping)}""",
      r"""\text{• In electromagnetism, it often appears in the form } LI'(t) + RI(t) + \displaystyle \frac{q(t)}{C} = 0 \text{. This represents Kirchhoff's law for an RLC circuit where } R, L, C \text{ (positive constants) satisfy } \gamma=\omega_0=\sqrt{\tfrac{1}{LC}}\text{.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Mechanics]}}""",
      r"""\text{Critically damped motion:} \ mx''(t) + 2cx'(t) + kx(t) = 0""",
      r"""\text{• } f(t) \leftrightarrow x(t) \text{ (position)}""",
      r"""\text{• } f'(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } f''(t) \leftrightarrow a(t) \text{ (acceleration)}""",
      r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{2c}{m} \text{ (damping coefficient)}""",
      r"""\text{• } \omega_0 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{ (natural angular frequency)}""",
      r"""\text{• } A_0 \leftrightarrow x_0 \text{ (initial position)}""",
      r"""\text{• } v_0 \leftrightarrow v_0 \text{ (initial velocity)}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{Critically damped response of RLC circuit:} \ Lq''(t) + Rq'(t) + \displaystyle \frac{q(t)}{C} = 0""",
      r"""\text{• } f(t) \leftrightarrow q(t) \text{ (charge)}""",
      r"""\text{• } f'(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } f''(t) \leftrightarrow I' \text{ (rate of current change)}""",
      r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{R}{2L} \text{ (damping coefficient)}""",
      r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{ (natural angular frequency)}""",
      r"""\text{• } A_0 \leftrightarrow q_0 \text{ (initial charge)}""",
      r"""\text{• } v_0 \leftrightarrow I_0 \text{ (initial current)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\textbf{[Strategy]}""",
      r"""\text{Eliminate the velocity term } 2\gamma f' \text{ by substitution to reduce to undamped form, then use standard simple harmonic motion formulas.}""",
      r"""\textbf{1. Removal of 1st order term}""",
      r"""\textbf{1.1 Multiply both sides by } e^{\gamma t}""",
      r"""f''+2\gamma f'+\omega_0^2 f=0 \quad \Leftrightarrow\quad e^{\gamma t}(f''+2\gamma f'+\omega_0^2 f)=0""",
      r"""\textbf{1.2 Apply product rule for derivatives}""",
      r"""\text{From product rule } (e^{\gamma t}f)'=e^{\gamma t}(f'+\gamma f) \text{:}""",
      r"""\text{ } (e^{\gamma t}f)''=e^{\gamma t}(f''+2\gamma f'+\gamma^2 f) \text{ so}""",
      r"""e^{\gamma t}(f''+2\gamma f'+\omega_0^2 f)=(e^{\gamma t}f)''-(\gamma^2-\omega_0^2)(e^{\gamma t}f)=0""",
      r"""\textbf{1.3 Variable transformation}""",
      r"""Let y(t):=e^{\gamma t}f(t) \text{, then } y''=0 \quad \cdots (1)""",
      r"""\textbf{1.4 Characteristic of critical damping:} \quad \gamma=\omega_0 \text{ so } \gamma^2-\omega_0^2=0 \text{.}""",
      r"""\textbf{2. Apply standard formula for linear functions}""",
      r"""\textbf{2.1 Standard formula}""",
      r"""\text{ } y''=0 \quad \Rightarrow\quad y(t)=y(0)+y'(0)t \quad \text{(Formula).}""",
      r"""\textbf{2.2 Mapping initial values}""",
      r"""\text{Since } y=e^{\gamma t}f\text{, } y(0)=A_0,\ y'(0)=v_0+\gamma A_0 \quad \cdots (2)""",
      r"""\textbf{2.3 Substitute into formula}""",
      r"""\text{From (1) let } y''=0 \text{ and substitute (2): } y(t)=A_0+(v_0+\gamma A_0)t""",
      r"""\textbf{2.4 Revert to original variables to obtain solution}""",
      r"""\text{ } 
  \begin{aligned}
  f(t)&=e^{-\gamma t}y(t)\\[6pt]
  &=e^{-\gamma t}\Bigl( A_0+(v_0+\gamma A_0)t\Bigr)
  \end{aligned}
  """,
    ],
  ),

  // rlc_series_discharge_problems.dart (numeric)
  "1D342CB8-24CD-40BB-A3EA-06BB6AFC1845": ProblemTranslation(
    category: '2nd Order Homogeneous - Constant Coefficients (Damping)',
    level: 'Advanced',
    steps: [
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• For an RLC series circuit, Kirchhoff's second law gives } LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = 0 \text{.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{Transient response of RLC series circuit:} \ LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = 0""",
      r"""\text{• } f(t) \leftrightarrow Q(t) \text{ (charge stored in capacitor)}""",
      r"""\text{• } f'(t) \leftrightarrow Q'(t) \text{ (current)}""",
      r"""\text{• } f''(t) \leftrightarrow Q''(t) \text{ (rate of current change)}""",
      r"""\text{• } \dfrac {6} {2 \cdot 1} = 3 \leftrightarrow \displaystyle \frac{R}{2L} \text{ (damping constant)}""",
      r"""\text{• } \dfrac {1}{\sqrt{1 \cdot \frac {1} {10}}} = \sqrt{10} \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{ (natural frequency when damping is 0)}""",
      r"""\text{• } \sqrt{\frac {1} {1 \cdot \frac {1} {10}} -  \left(\frac {6} {2 \cdot 1}\right) ^2} = 1 \leftrightarrow \sqrt{\displaystyle \frac{1}{LC} - \left(\displaystyle \frac{R}{2L}\right)^2} \text{ (damped angular frequency)}""",
      r"""\text{• } 1 \leftrightarrow Q_0 \text{ (initial charge)}""",
      r"""\text{• } 2 \leftrightarrow I_0 \text{ (initial current)}""",
      r"""\textcolor{brown}{\large{[Physical\ Meaning]}}""",
      r"""\text{• Envelope: oscillates while decaying exponentially as } e^{-\frac {6} {2 \cdot 1} t} = e^{-3t}""",
      r"""\text{• Oscillation frequency: } \sqrt{10 -  \left(\frac {6} {2 \cdot 1}\right) ^2} = 1 \text{ (lower than natural frequency }\sqrt{10}\text{)}""",
      r"""\text{• Condition } \sqrt{10} > \dfrac {6} {2 \cdot 1} = 3 \text{ results in underdamped oscillation}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\textcolor{green}{Formula\ when\ \ f'\ \ coefficient\ \ R\ \ is\ \ 0}""",
      r"""\text{The solution to the initial value problem for } f''(t) = -\omega^2 f(t) \text{ with }""",
      r"""f(0) = A_0,\quad f'(0) = v_0 \text{ is}""",
      r"""f(t) = A_0\cos(\omega t) + \displaystyle \frac{v_0}{\omega}\sin(\omega t) \text{.}""",
      r"""\textcolor{blue}{Use\ this\ formula\ to\ solve\ this\ problem.}""",
      r"""\textcolor{green}{1.} \textcolor{green}{Eliminate\ 1st\ derivative\ by\ variable\ transformation}""",
      r"""\text{Multiply both sides of } f''(t) + 6f'(t) + 10f(t) = 0 \text{ by } e^{3t}\text{:}""",
      r""" \Leftrightarrow \textcolor{red}{e^{3t}f''(t)} + \textcolor{red}{6e^{3t}\ f'(t)} +  10e^{3t} f(t) = 0 \cdots (1)""",
      r"""\text{By the product rule for derivatives:}""",
      r"""\left(e^{3t}f(t)\right)''(t) = e^{3t}f''(t) + 6e^{3t} f'(t) + 9e^{3t} f(t) """,
      r"""\text{Thus,}""",
      r"""\textcolor{red}{e^{3t}f''(t)} + \textcolor{red}{6e^{3t}\ f'(t)} = \textcolor{blue}{\left(e^{3t}f(t)\right)''(t) - 9e^{3t}f(t)}""",
      r"""\text{Substituting into (1):}""",
      r"""\quad \ \textcolor{blue}{\left(e^{3t}f(t)\right)'' - 9e^{3t}f(t)} + 10e^{3t}f(t) = 0""",
      r"""\Leftrightarrow \left(e^{3t}f(t)\right)'' + e^{3t}f(t) = 0""",
      r"""\text{Letting } g(t) = e^{3t} f(t) \text{:}""",
      r"""g''(t) + g(t) = 0\ \ \cdots (2)""",
      r"""\textcolor{green}{2. } \textcolor{green}{Apply\ formula\ to\ find\ } \textcolor{green}{g}""",
      r"""\text{(2) is an equation for simple harmonic motion. Applying the formula (}\omega = 1\text{):}""",
      r"""g(t) = g(0)\cos(t) + \displaystyle \frac{g'(0)}{1}\sin(t) = g(0)\cos(t) + g'(0)\sin(t)""",
      r"""\textcolor{green}{3.} \textcolor{green}{Find\ initial\ conditions\ for\ \ g}""",
      r"""\text{From } g(t) = e^{3t} f(t) \text{:}""",
      r"""\begin{aligned}
      g(0) &= e^{0} f(0) = 1\\[6pt]
      g'(0) &= 3e^{0} f(0) + e^{0} f'(0) = 3 \cdot 1 + 2 = 5
      \end{aligned}""",
      r"""\textcolor{green}{4.\ } \textcolor{green}{Find\ \ g}""",
      r"""\text{Substituting into the formula:}""",
      r"""g(t) = 1 \cdot \cos(t) + 5 \cdot \sin(t) = \cos(t) + 5\sin(t)""",
      r"""\textcolor{green}{5.\ } \textcolor{green}{Find\ \ f\ \ from\ \ g}""",
      r"""\text{From } g(t) = e^{3t} f(t) \text{, } f(t) = e^{-3t} g(t) \text{.}""",
      r"""\text{Thus,}""",
      r"""f(t) = e^{-3t}\left(\cos(t) + 5\sin(t)\right)""",
    ],
  ),
  "965D1819-D776-42C7-84DB-BDF8D5354E74": ProblemTranslation(
    category: '2nd Order Homogeneous - Constant Coefficients (Damping)',
    level: 'Advanced',
    hint: r"""\text{Eliminate the velocity term } 10f' \text{ by substitution to reduce it to an undamped form, then use the standard exponential formula.}""",
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• Overdamped motion}""",
      r"""\text{• In mechanics, it often appears in the form } mx''(t) + 2cx'(t) + kx(t) = 0 \text{. This represents overdamped free vibration. Envelope is } e^{-5t}\text{.}""",
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• Overdamped response of an RLC circuit}""",
      r"""\text{• In electromagnetism, it often appears in the form } LI'(t) + RI(t) + \displaystyle \frac{q(t)}{C} = 0 \text{. This represents Kirchhoff's law for an RLC circuit.} R=10,\ L=1,\ C=\tfrac{1}{9},\ \omega_h=\sqrt{\bigl(\tfrac{R}{2L}\bigr)^2-\tfrac{1}{LC}}=\sqrt{5^2-3^2}=4\text{.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Mechanics]}}""",
      r"""\text{Overdamped motion:} \ mx''(t) + 2cx'(t) + kx(t) = 0""",
      r"""\text{• } f(t) \leftrightarrow x(t) \text{ (position)}""",
      r"""\text{• } f'(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } f''(t) \leftrightarrow a(t) \text{ (acceleration)}""",
      r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{2c}{m} \text{ (damping coefficient, }\gamma = 5\text{)}""",
      r"""\text{• } \omega_0 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{ (natural angular frequency, }\omega_0 = 3\text{)}""",
      r"""\text{• } \omega_h \leftrightarrow \sqrt{\displaystyle \frac{b^2}{4m^2} - \displaystyle \frac{k}{m}} \text{ (overdamped angular frequency, }\omega_h = 4\text{)}""",
      r"""\text{• } f(0) \leftrightarrow x_0 \text{ (initial position, }f(0) = 2\text{)}""",
      r"""\text{• } f'(0) \leftrightarrow v_0 \text{ (initial velocity, }f'(0) = 1\text{)}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{Overdamped response of RLC circuit:} \ Lq''(t) + Rq'(t) + \displaystyle \frac{q(t)}{C} = 0""",
      r"""\text{• } f(t) \leftrightarrow q(t) \text{ (charge)}""",
      r"""\text{• } f'(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } f''(t) \leftrightarrow I' \text{ (rate of current change)}""",
      r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{R}{2L} \text{ (damping coefficient, }\gamma = 5\text{)}""",
      r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{ (natural angular frequency, }\omega_0 = 3\text{)}""",
      r"""\text{• } \omega_h \leftrightarrow \sqrt{\displaystyle \frac{R^2}{4L^2} - \displaystyle \frac{1}{LC}} \text{ (overdamped angular frequency, }\omega_h = 4\text{)}""",
      r"""\text{• } f(0) \leftrightarrow q_0 \text{ (initial charge, }f(0) = 2\text{)}""",
      r"""\text{• } f'(0) \leftrightarrow I_0 \text{ (initial current, }f'(0) = 1\text{)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\textbf{[Strategy]}""",
      r"""\text{Eliminate the velocity term } 10f' \text{ by substitution to reduce it to an undamped hyperbolic type equation.}""",
      r"""\textbf{1. Removal of 1st order term}""",
      r"""\textbf{1.1 Multiply both sides by } e^{5t}""",
      r"""f''+10f'+9f=0 \quad \Leftrightarrow\quad e^{5t}(f''+10f'+9f)=0""",
      r"""\textbf{1.2 Apply product rule for derivatives}""",
      r"""\text{From product rule } (e^{5t}f)'=e^{5t}(f'+5f) \text{:}""",
      r"""\text{ } (e^{5t}f)''=e^{5t}(f''+10f'+25f) \text{ so}""",
      r"""e^{5t}(f''+10f'+9f)=(e^{5t}f)''-(25-9)(e^{5t}f)=(e^{5t}f)''-16(e^{5t}f)=0""",
      r"""\textbf{1.3 Variable transformation}""",
      r"""Let y(t):=e^{5t}f(t) \text{, then } y''-16\,y=0 \quad \cdots (1)""",
      r"""\textbf{1.4 Introduce notation} \quad \omega_h:=\sqrt{5^2-3^2}=4 \text{ (positive constant; overdamping).}""",
      r"""\textbf{2. Apply standard exponential formula}""",
      r"""\textbf{2.1 Standard formula}""",
      r"""\text{ } y''-16 y=0 \quad \Rightarrow\quad y(t)=C_1 e^{4t}+C_2 e^{-4t} \quad \text{(Formula).}""",
      r"""\textbf{2.2 Mapping initial values}""",
      r"""\text{Since } y=e^{5t}f\text{, } y(0)=2,\ y'(0)=1+5\cdot 2=11 \quad \cdots (2)""",
      r"""\textbf{2.3 Determine constants}""",
      r"""\text{From } y(0)=2,\ y'(0)=11 \text{:}""",
      r"""\text{ } y(0)=C_1+C_2=2,\quad y'(0)=4C_1-4C_2=11""",
      r"""\text{ } C_1=\dfrac{2+\dfrac{11}{4}}{2}=\dfrac{19}{8},\quad C_2=\dfrac{2-\dfrac{11}{4}}{2}=-\dfrac{3}{8}""",
      r"""\text{ } y(t)=\dfrac{19}{8}e^{4t}-\dfrac{3}{8}e^{-4t}""",
      r"""\textbf{2.4 Revert to original variables to obtain solution}""",
      r"""\text{ } 
  \begin{aligned}
  f(t)&=e^{-5t}y(t)\\[6pt]
  &=e^{-5t}\Bigl(\dfrac{19}{8}e^{4t}-\dfrac{3}{8}e^{-4t}\Bigr)\\[6pt]
  &=\dfrac{19}{8}e^{-t}-\dfrac{3}{8}e^{-9t}
  \end{aligned}
  """,
    ],
  ),
  "75BB6EAE-4EB6-4F88-9A4D-F56E759E706D": ProblemTranslation(
    category: '2nd Order Homogeneous - Constant Coefficients (Damping)',
    level: 'Advanced',
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• Damped free vibration (critical damping)}""",
      r"""\text{• In mechanics, it often appears in the form } mx''(t) + 2cx'(t) + kx(t) = 0 \text{. This represents critically damped free vibration. Envelope is } e^{-2t}\text{.}""",
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• Transient response of RLC circuit (critical damping)}""",
      r"""\text{• In electromagnetism, it often appears in the form } LI'(t) + RI(t) + \displaystyle \frac{q(t)}{C} = 0 \text{. This represents Kirchhoff's law for an RLC circuit.} R=4,\ L=1,\ C=\tfrac{1}{4},\ \gamma=\omega_0=\sqrt{\tfrac{1}{LC}}=2\text{.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Mechanics]}}""",
      r"""\text{Critically damped motion:} \ mx''(t) + 2cx'(t) + kx(t) = 0""",
      r"""\text{• } f(t) \leftrightarrow x(t) \text{ (position)}""",
      r"""\text{• } f'(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } f''(t) \leftrightarrow a(t) \text{ (acceleration)}""",
      r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{2c}{m} \text{ (damping coefficient, }\gamma = 2\text{)}""",
      r"""\text{• } \omega_0 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{ (natural angular frequency, }\omega_0 = 2\text{)}""",
      r"""\text{• } f(0) \leftrightarrow x_0 \text{ (initial position, }f(0) = 1\text{)}""",
      r"""\text{• } f'(0) \leftrightarrow v_0 \text{ (initial velocity, }f'(0) = 2\text{)}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{Critically damped response of RLC circuit:} \ Lq''(t) + Rq'(t) + \displaystyle \frac{q(t)}{C} = 0""",
      r"""\text{• } f(t) \leftrightarrow q(t) \text{ (charge)}""",
      r"""\text{• } f'(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } f''(t) \leftrightarrow I' \text{ (rate of current change)}""",
      r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{R}{2L} \text{ (damping coefficient, }\gamma = 2\text{)}""",
      r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{ (natural angular frequency, }\omega_0 = 2\text{)}""",
      r"""\text{• } f(0) \leftrightarrow q_0 \text{ (initial charge, }f(0) = 1\text{)}""",
      r"""\text{• } f'(0) \leftrightarrow I_0 \text{ (initial current, }f'(0) = 2\text{)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\textbf{[Strategy]}""",
      r"""\text{Eliminate the velocity term } 4f' \text{ by substitution to reduce to undamped form, then use the standard formula for linear functions.}""",
      r"""\textbf{1. Removal of 1st order term}""",
      r"""\textbf{1.1 Multiply both sides by } e^{2t}""",
      r"""f''+4f'+4f=0 \quad \Leftrightarrow\quad e^{2t}(f''+4f'+4f)=0""",
      r"""\textbf{1.2 Apply product rule for derivatives}""",
      r"""\text{From product rule } (e^{2t}f)'=e^{2t}(f'+2f) \text{:}""",
      r"""\text{ } (e^{2t}f)''=e^{2t}(f''+4f'+4f) \text{ so}""",
      r"""e^{2t}(f''+4f'+4f)=(e^{2t}f)''-(4-4)(e^{2t}f)=0""",
      r"""\textbf{1.3 Variable transformation}""",
      r"""Let y(t):=e^{2t}f(t) \text{, then } y''=0 \quad \cdots (1)""",
      r"""\textbf{1.4 Characteristic of critical damping:} \quad \gamma=2=\omega_0=2 \text{ so } \gamma^2-\omega_0^2=4-4=0 \text{.}""",
      r"""\textbf{2. Apply standard formula for linear functions}""",
      r"""\textbf{2.1 Standard formula}""",
      r"""\text{ } y''=0 \quad \Rightarrow\quad y(t)=y(0)+y'(0)t \quad \text{(Formula).}""",
      r"""\textbf{2.2 Mapping initial values}""",
      r"""\text{Since } y=e^{2t}f\text{, } y(0)=1,\ y'(0)=2+2\cdot 1=4 \quad \cdots (2)""",
      r"""\textbf{2.3 Substitute into formula}""",
      r"""\text{From (1) let } y''=0 \text{ and substitute (2): } y(t)=1+4t""",
      r"""\textbf{2.4 Revert to original variables to obtain solution}""",
      r"""\text{ } \begin{aligned}
  f(t)&=e^{-2t}y(t)\\[6pt]
  &=e^{-2t}\Bigl( 1+4t\Bigr)
  \end{aligned}""",
    ],
  ),

  // rlc_series_voltage_critical_problems.dart
  "3ABE9F4E-68E6-4E65-BBE0-FD6CD99715DD": ProblemTranslation(
    category: 'General - 2nd Order - Non-homogeneous',
    level: 'Advanced',
    constants: r"""\gamma=\omega_0,\ F,\Omega: constant""",
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• Forced vibration in a critically damped system}""",
      r"""\text{• In mechanics, it often appears in the form } mx''(t) + 2cx'(t) + kx(t) = F_0\sin(\Omega t) \text{. This represents forced vibration in a critically damped system. Response to external force } F\sin(\Omega t) \text{. In steady state, damped terms vanish and it oscillates at the same frequency as the forcing term.}""",
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• Forced vibration of RLC circuit (critical damping)}""",
      r"""\text{• In electromagnetism, it often appears in the form } LI'(t) + RI(t) + \displaystyle \frac{q(t)}{C} = V_0\sin(\Omega t) \text{. This represents forced vibration of an RLC circuit. Current has phase difference } \alpha = -\arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right) \text{ relative to voltage, and current amplitude is } \frac{F\Omega}{\sqrt{(\gamma^2+\Omega^2)^2}} \text{.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Mechanics]}}""",
      r"""\text{Forced vibration in critically damped system:} \ mx''(t) + 2cx'(t) + kx(t) = F_0\sin(\Omega t)""",
      r"""\text{• } f(t) \leftrightarrow x(t) \text{ (position)}""",
      r"""\text{• } f'(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } f''(t) \leftrightarrow a(t) \text{ (acceleration)}""",
      r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{2c}{m} \text{ (damping coefficient)}""",
      r"""\text{• } \omega_0 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{ (natural angular frequency)}""",
      r"""\text{• } F \leftrightarrow \displaystyle \frac{F_0}{m} \text{ (external force amplitude / mass)}""",
      r"""\text{• } \Omega \leftrightarrow \Omega \text{ (angular frequency of external force)}""",
      r"""\text{• } f(0)=0 \leftrightarrow x_0=0 \text{ (initial position)}""",
      r"""\text{• } f'(0)=0 \leftrightarrow v_0=0 \text{ (initial velocity)}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{Forced vibration of RLC circuit (critical damping):} \ LI'(t) + RI(t) + \displaystyle \frac{q(t)}{C} = V_0\sin(\Omega t)""",
      r"""\text{• } f(t) \leftrightarrow q(t) \text{ (charge)}""",
      r"""\text{• } f'(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } f''(t) \leftrightarrow I'(t) \text{ (rate of current change)}""",
      r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{R}{2L} \text{ (damping coefficient)}""",
      r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{ (natural angular frequency)}""",
      r"""\text{• } F \leftrightarrow \displaystyle \frac{V_0}{L} \text{ (voltage amplitude / inductance)}""",
      r"""\text{• } \Omega \leftrightarrow \Omega \text{ (driving angular frequency)}""",
      r"""\text{• } f(0)=0 \leftrightarrow q_0=0 \text{ (initial charge)}""",
      r"""\text{• } f'(0)=0 \leftrightarrow I_0=0 \text{ (initial current)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\textbf{[Strategy]}""",
      r"""\text{Find a particular solution using method of undetermined coefficients, define a new function by subtracting it, and apply the homogeneous equation formula (Problem 14).}""",
      r"""\textcolor{green}{Formula\ for\ homogeneous\ case}""",
      r"""\text{The solution to the initial value problem for } f''(t) + 2\gamma f'(t) + \omega_0^2 f(t) = 0 \text{ (critically damped: } \gamma = \omega_0 \text{) with}""",
      r"""f(0) = A_0,\quad f'(0) = v_0""",
      r"""\text{is (from Problem 14):}""",
      r"""f(t) = e^{-\gamma t}\left(A_0 + (v_0 + \gamma A_0)t\right)""",
      r"""\text{.}""", r"""\textcolor{blue}{Use\ this\ formula\ to\ solve\ this\ problem.}""",
      r"""f''(t) + 2\gamma f'(t) + \omega_0^2 f(t) = F\sin(\Omega t),\quad \gamma = \omega_0""",
      r"""\textcolor{green}{1.} \textcolor{green}{Find\ particular\ solution}""",
      r"""\text{Based on non-homogeneous term } F\sin(\Omega t) \text{, estimate particular solution as:}""",
      r"""f_p(t) = A\sin(\Omega t) + B\cos(\Omega t)""",
      r"""\text{(where } A, B \text{ are undetermined coefficients).}""",
      r"""\text{First, differentiate } f_p(t) \text{:}""",
      r"""
  \begin{aligned}
  f_p'(t) &= \Omega A\cos(\Omega t) - \Omega B\sin(\Omega t) \\[5pt]
  f_p''(t) &= -\Omega^2 A\sin(\Omega t) - \Omega^2 B\cos(\Omega t)
  \end{aligned}
  """,
      r"""\text{Substituting these into } f_p''(t) + 2\gamma f_p'(t) + \omega_0^2 f_p(t) = F\sin(\Omega t) \text{:}""",
      r"""\text{Since } \gamma = \omega_0 \text{:}""",
      r"""
  \begin{aligned}
  f_p''(t) + 2\gamma f_p'(t) + \gamma^2 f_p(t) &= (-\Omega^2 A\sin(\Omega t) - \Omega^2 B\cos(\Omega t)) \\[5pt]
  &\quad + 2\gamma(\Omega A\cos(\Omega t) - \Omega B\sin(\Omega t)) \\[5pt]
  &\quad + \gamma^2(A\sin(\Omega t) + B\cos(\Omega t)) \\[5pt]
  &= (-\Omega^2 A - 2\gamma\Omega B + \gamma^2 A)\sin(\Omega t) \\[5pt]
  &\quad + (-\Omega^2 B + 2\gamma\Omega A + \gamma^2 B)\cos(\Omega t) \\[5pt]
  &= ((\gamma^2 - \Omega^2)A - 2\gamma\Omega B)\sin(\Omega t) \\[5pt]
  &\quad + (2\gamma\Omega A + (\gamma^2 - \Omega^2)B)\cos(\Omega t) \\[5pt]
  &= F\sin(\Omega t)
  \end{aligned}
  """,
      r"""\textcolor{green}{2. } \textcolor{green}{Compare\ coefficients}""",
      r"""\text{Comparing coefficients on both sides:}""",
      r"""
  \begin{cases}
  (\gamma^2 - \Omega^2)A - 2\gamma\Omega B = F \\[5pt]
  2\gamma\Omega A + (\gamma^2 - \Omega^2)B = 0
  \end{cases}
  """,
      r"""\text{From the 2nd equation } B = -\frac{2\gamma\Omega A}{\gamma^2 - \Omega^2} \text{. Substituting into the 1st equation:}""",
      r"""
  \begin{aligned}
  (\gamma^2 - \Omega^2)A - 2\gamma\Omega \cdot \left(-\frac{2\gamma\Omega A}{\gamma^2 - \Omega^2}\right) &= F \\[5pt]
  (\gamma^2 - \Omega^2)A + \frac{4\gamma^2\Omega^2 A}{\gamma^2 - \Omega^2} &= F \\[5pt]
  \frac{(\gamma^2 - \Omega^2)^2 + 4\gamma^2\Omega^2}{\gamma^2 - \Omega^2}A &= F
  \end{aligned}
  """,
      r"""\text{Factoring the numerator:}""",
      r"""
  \begin{aligned}
  (\gamma^2 - \Omega^2)^2 + 4\gamma^2\Omega^2 &= \gamma^4 - 2\gamma^2\Omega^2 + \Omega^4 + 4\gamma^2\Omega^2 \\[5pt]
  &= \gamma^4 + 2\gamma^2\Omega^2 + \Omega^4 \\[5pt]
  &= (\gamma^2 + \Omega^2)^2
  \end{aligned}
  """,
      r"""\text{Thus,}""",
      r"""
  \begin{aligned}
  \frac{(\gamma^2 + \Omega^2)^2}{\gamma^2 - \Omega^2}A &= F \\[5pt]
  A &= \frac{F(\gamma^2 - \Omega^2)}{(\gamma^2 + \Omega^2)^2} \\[5pt]
  B &= -\frac{2\gamma\Omega F}{(\gamma^2 + \Omega^2)^2}
  \end{aligned}
  """,
      r"""\text{Particular solution:}""",
      r"""
  \begin{aligned}
  f_p(t) &= \frac{F}{(\gamma^2+\Omega^2)^2}\left((\gamma^2-\Omega^2)\sin(\Omega t) - 2\gamma\Omega\cos(\Omega t)\right)
  \end{aligned}
  """,
      r"""\textcolor{green}{3.} \textcolor{green}{Homogenize\ by\ translating\ to\ new\ function\ } \textcolor{green}{g}""",
      r"""\text{Let } g(t) = f(t) - f_p(t) \text{.}""",
      r"""\text{By linearity of derivatives and } f_p''(t) + 2\gamma f_p'(t) + \gamma^2 f_p(t) = F\sin(\Omega t) \text{:}""",
      r"""
  \begin{aligned}
  g''(t) + 2\gamma g'(t) + \gamma^2 g(t) &= (f(t) - f_p(t))'' + 2\gamma(f(t) - f_p(t))' + \gamma^2(f(t) - f_p(t)) \\[5pt]
  &= (f''(t) + 2\gamma f'(t) + \gamma^2 f(t)) - (f_p''(t) + 2\gamma f_p'(t) + \gamma^2 f_p(t)) \\[5pt]
  &= F\sin(\Omega t) - F\sin(\Omega t) \\[5pt]
  &= 0
  \end{aligned}
  """,
      r"""\text{Thus } g''(t) + 2\gamma g'(t) + \gamma^2 g(t) = 0 \text{ (Homogenization complete)}""",
      r"""\textcolor{green}{4.\ } \textcolor{green}{Find\ initial\ conditions\ for\ \ g}""",
      r"""
  \begin{aligned}
  g(0) &= f(0) - f_p(0) = 0 - B = -B \\[5pt]
  g'(0) &= f'(0) - f_p'(0) = 0 - \Omega A = -\Omega A
  \end{aligned}
  """,
      r"""\textcolor{green}{5.\ } \textcolor{green}{Apply\ formula\ from\ Problem\ 14\ to\ find\ \ g(t)}""",
      r"""\text{For } g''(t) + 2\gamma g'(t) + \gamma^2 g(t) = 0 \text{ (critically damped):}""",
      r"""\text{• Damping constant: } \gamma = \omega_0""",
      r"""\text{• Initial conditions: } g(0) = -B, g'(0) = -\Omega A""",
      r"""\text{From Problem 14 formula:}""",
      r"""
  \begin{aligned}
  g(t) &= e^{-\gamma t}\left(g(0) + (g'(0) + \gamma g(0))t\right) \\[5pt]
  &= e^{-\gamma t}\left(-B + (-\Omega A + \gamma(-B))t\right) \\[5pt]
  &= e^{-\gamma t}\left(-B - (\Omega A + \gamma B)t\right)
  \end{aligned}
  """,
      r"""\textcolor{green}{6.\ } \textcolor{green}{Find\ \ f(t)\ \ by\ combining\ \ g(t)\ \ and\ particular\ solution}""",
      r"""\text{ } f(t) = g(t) + f_p(t)""",
      r"""\text{Substituting } A = \frac{F(\gamma^2 - \Omega^2)}{(\gamma^2 + \Omega^2)^2}, B = -\frac{2\gamma\Omega F}{(\gamma^2 + \Omega^2)^2} \text{:}""",
      r"""
  \begin{aligned}
  f(t) &= \frac{F}{(\gamma^2+\Omega^2)^2}\left\{e^{-\gamma t}\left(2\gamma\Omega - \Omega(3\gamma^2-\Omega^2)t\right) + (\gamma^2-\Omega^2)\sin(\Omega t) - 2\gamma\Omega\cos(\Omega t)\right\}
  \end{aligned}
  """,
      r"""\textcolor{green}{7.\ } \textcolor{green}{Steady-state\ solution}""",
      r"""\text{After sufficient time, the transient term } e^{-\gamma t} \text{ converges to } 0 \text{.}""",
      r"""\text{The steady-state solution (charge) is:}""",
      r"""
  \begin{aligned}
  Q_s(t) = f_s(t) &= \frac{F}{(\gamma^2+\Omega^2)^2}\left((\gamma^2-\Omega^2)\sin(\Omega t) - 2\gamma\Omega\cos(\Omega t)\right)
  \end{aligned}
  """,
      r"""\text{Charge amplitude: } Q_0 = \sqrt{\left(\frac{F(\gamma^2-\Omega^2)}{(\gamma^2+\Omega^2)^2}\right)^2 + \left(\frac{2\gamma\Omega F}{(\gamma^2+\Omega^2)^2}\right)^2} = \frac{F}{(\gamma^2+\Omega^2)^2}\sqrt{(\gamma^2-\Omega^2)^2+4\gamma^2\Omega^2} = \frac{F}{\gamma^2+\Omega^2}""",
      r"""\text{Factoring by root sum of squares and using addition theorem, with } \tan\theta = \frac{2\gamma\Omega}{\gamma^2-\Omega^2} \text{:}""",
      r"""
  \begin{aligned}
  Q_s(t) = f_s(t) = Q_0\sin(\Omega t + \theta) = \frac{F}{\gamma^2+\Omega^2}\sin\left(\Omega t + \arctan\left(\frac{2\gamma\Omega}{\gamma^2-\Omega^2}\right)\right)
  \end{aligned}
  """,
      r"""\text{Steady-state current is charge derivative:}""",
      r"""
  \begin{aligned}
  I_s(t) = f_s'(t) &= Q_0\Omega\cos(\Omega t + \theta) = \frac{F\Omega}{\gamma^2+\Omega^2}\cos\left(\Omega t + \arctan\left(\frac{2\gamma\Omega}{\gamma^2-\Omega^2}\right)\right) \\[5pt]
  &= \frac{F\Omega}{\gamma^2+\Omega^2}\sin\left(\Omega t - \arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right)\right)
  \end{aligned}
  """,
      r"""\text{Current amplitude: } I_0 = Q_0\Omega = \frac{F\Omega}{\gamma^2+\Omega^2}""",
      r"""\textcolor{green}{8.\ } \textcolor{green}{Physical\ Correspondence}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{Kirchhoff's law for RLC series AC circuit:} \ V(t) = L\frac{dI}{dt} + RI + \frac{1}{C}\int_0^t I(s)\,ds""",
      r"""\text{Expressing current } I(t) = \frac{dQ}{dt} \text{ using charge } Q(t) \text{: } V(t) = L\frac{d^2Q}{dt^2} + R\frac{dQ}{dt} + \frac{1}{C}Q(t)""",
      r"""\text{Comparing with differential equation } f''(t) + 2\gamma f'(t) + \omega_0^2 f(t) = F\sin(\Omega t) \text{ (critically damped):}""",
      r"""\text{• } f(t) \leftrightarrow Q(t) \text{ (charge)}""",
      r"""\text{• } f'(t) \leftrightarrow I(t) = \frac{dQ}{dt} \text{ (current)}""",
      r"""\text{• } f''(t) \leftrightarrow \frac{dI}{dt} = \frac{d^2Q}{dt^2} \text{ (rate of current change)}""",
      r"""\text{• } L = 1 \text{ (inductance)}""",
      r"""\text{• } R = 2\gamma \text{ (resistance)}""",
      r"""\text{• } \frac{1}{C} = \omega_0^2 = \gamma^2 \text{, thus } C = \frac{1}{\gamma^2} \text{ (capacitance)}""",
      r"""\text{• } V_0 = F \text{ (voltage amplitude)}""",
      r"""\text{• } \omega = \Omega \text{ (angular frequency)}""",
      r"""\text{• Damping constant: } \gamma = \frac{R}{2L} = \frac{2\gamma}{2 \times 1} = \gamma""",
      r"""\text{• Natural angular frequency: } \omega_0 = \sqrt{\frac{1}{LC}} = \sqrt{\frac{1}{1 \times \frac{1}{\gamma^2}}} = \gamma = \omega_0""",
      r"""\text{• Critical damping condition: } \gamma = \omega_0 \text{ (damped angular frequency is 0)}""",
      r"""\textcolor{green}{9.\ } \textcolor{green}{Impedance}""",
      r"""\text{• Inductive reactance: } X_L = \Omega L = \Omega \times 1 = \Omega""",
      r"""\text{• Capacitive reactance: } X_C = \frac{1}{\Omega C} = \frac{1}{\Omega \times \frac{1}{\gamma^2}} = \frac{\gamma^2}{\Omega}""",
      r"""\text{• Reactance: } X = X_L - X_C = \Omega - \frac{\gamma^2}{\Omega} = \frac{\Omega^2 - \gamma^2}{\Omega}""",
      r"""\text{• Impedance magnitude:}""",
      r"""
  \begin{aligned}
  |Z| &= \sqrt{R^2 + X^2} = \sqrt{(2\gamma)^2 + \left(\frac{\Omega^2 - \gamma^2}{\Omega}\right)^2} \\[5pt]
  &= \sqrt{4\gamma^2 + \frac{(\Omega^2 - \gamma^2)^2}{\Omega^2}} \\[5pt]
  &= \sqrt{\frac{4\gamma^2\Omega^2 + (\Omega^2 - \gamma^2)^2}{\Omega^2}} \\[5pt]
  &= \frac{\sqrt{(\gamma^2 - \Omega^2)^2 + 4\gamma^2\Omega^2}}{\Omega} \\[5pt]
  &= \frac{\gamma^2 + \Omega^2}{\Omega}
  \end{aligned}
  """,
      r"""\text{• Current amplitude: } I_0 = \frac{V_0}{|Z|} = \frac{F}{\frac{\gamma^2+\Omega^2}{\Omega}} = \frac{F\Omega}{\gamma^2+\Omega^2} \text{ (matches Section 7)}""",
      r"""\textcolor{green}{10.\ } \textcolor{green}{Phase\ Lag}""",
      r"""\text{Voltage: } V(t) = V_0\sin(\Omega t) = F\sin(\Omega t)""",
      r"""\text{Current: } I_s(t) = I_0\sin\left(\Omega t - \arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right)\right) = \frac{F\Omega}{\gamma^2+\Omega^2}\sin\left(\Omega t - \arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right)\right)""",
      r"""\text{Phase difference: Current lags voltage by } \alpha = \arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right) \text{.}""",
      r"""\text{Impedance phase angle: } \alpha = \arctan\left(\frac{X}{R}\right) = \arctan\left(\frac{\frac{\Omega^2-\gamma^2}{\Omega}}{2\gamma}\right) = \arctan\left(\frac{\Omega^2-\gamma^2}{2\gamma\Omega}\right) = -\arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right)""",
      r"""\text{This matches the phase difference between voltage and current.}""",
      r"""\textcolor{green}{11.\ } \textcolor{green}{Power\ Consumption,\ Power\ Factor}""",
      r"""\text{Voltage: } V(t) = F\sin(\Omega t) \text{, Current: } I(t) = \frac{F\Omega}{\gamma^2+\Omega^2}\sin\left(\Omega t - \arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right)\right)""",
      r"""\text{Phase difference: } \alpha = -\arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right)""",
      r"""\text{Power factor: } \cos(\alpha) = \cos\left(\arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right)\right) = \frac{2\gamma\Omega}{\gamma^2+\Omega^2} \text{ (cosine of phase difference between voltage and current)}""",
      r"""\text{RMS Voltage: } V_{\text{rms}} = \frac{V_0}{\sqrt{2}} = \frac{F}{\sqrt{2}}""",
      r"""\text{RMS Current: } I_{\text{rms}} = \frac{I_0}{\sqrt{2}} = \frac{F\Omega}{\sqrt{2}(\gamma^2+\Omega^2)}""",
      r"""\text{Average power consumption in resistor:}""",
      r"""
  \begin{aligned}
  \bar{P}_R &= \frac{1}{2}RI_0^2 = \frac{1}{2} \times 2\gamma \times \left(\frac{F\Omega}{\gamma^2+\Omega^2}\right)^2 \\[5pt]
  &= \frac{\gamma F^2\Omega^2}{(\gamma^2+\Omega^2)^2}
  \end{aligned}
  """,
    ],
  ),

  // rlc_series_voltage_critical_problems.dart (numeric)
  "3FA826E6-FD5D-469B-ACB8-D6FEDDF163F0": ProblemTranslation(
    category: 'Numerical - 2nd Order - Non-homogeneous',
    level: 'Advanced',
    hint: r"""\text{Find a particular solution }f_p\text{, set }g=f-f_p\text{ to homogenize, and apply the critically damped homogeneous formula (Problem 14).}""",
    steps: [
      r"""\textbf{[Given]}""",
      r"""f''(t)+8f'(t)+16f(t)=10\sin(2t),\quad f(0)=0,\ f'(0)=0""",
      r"""\textbf{[1. Particular solution]}""",
      r"""\text{Assume }f_p(t)=A\sin(2t)+B\cos(2t)\text{. Then }f_p'(t)=2A\cos(2t)-2B\sin(2t)\text{ and }f_p''(t)=-4A\sin(2t)-4B\cos(2t)\text{.}""",
      r"""\text{Substitute and compare coefficients:}""",
      r"""\begin{aligned} 12A-16B&=10,\\ 16A+12B&=0. \end{aligned}""",
      r"""\text{Thus }A=\displaystyle\frac{3}{10},\ B=-\displaystyle\frac{2}{5}\text{, so}""",
      r"""\begin{aligned} f_p(t)=\frac{3}{10}\sin(2t)-\frac{2}{5}\cos(2t). \end{aligned}""",
      r"""\textbf{[2. Homogenize]}""",
      r"""\text{Let }g(t)=f(t)-f_p(t)\text{. Then }g''+8g'+16g=0\text{.}""",
      r"""\text{Initial conditions: }g(0)=f(0)-f_p(0)=0-\left(-\frac{2}{5}\right)=\frac{2}{5}\text{,}""",
      r"""\text{and }f_p'(t)=\frac{3}{5}\cos(2t)+\frac{4}{5}\sin(2t)\text{ gives }g'(0)=0-\frac{3}{5}=-\frac{3}{5}\text{.}""",
      r"""\textbf{[3. Solve }g\textbf{ (critical damping)]}""",
      r"""\text{Here }2\gamma=8\Rightarrow \gamma=4\text{ and }\omega_0^2=16\Rightarrow \omega_0=4\text{, so }\gamma=\omega_0\text{.}""",
      r"""\text{By the critically damped homogeneous formula (Problem 14): }g(t)=e^{-\gamma t}\left(g(0)+(g'(0)+\gamma g(0))t\right)\text{, hence}""",
      r"""\begin{aligned} g(t)=e^{-4t}\left(\frac{2}{5}+t\right). \end{aligned}""",
      r"""\textbf{[4. Combine]}""",
      r"""\begin{aligned} f(t)=g(t)+f_p(t)=e^{-4t}\left(\frac{2}{5}+t\right)+\frac{3}{10}\sin(2t)-\frac{2}{5}\cos(2t). \end{aligned}""",
      r"""\text{The steady-state part can also be written as } \displaystyle\frac{1}{2}\sin\left(2t+\arctan\left(-\frac{4}{3}\right)\right)\text{.}""",
    ],
  ),

  // rlc_series_voltage_overdamped_problems.dart
  "B2C3D4E5-F6A7-8901-BCDE-F2345678901A": ProblemTranslation(
    category: 'General - 2nd Order - Non-homogeneous',
    level: 'Advanced',
    constants: r"""\gamma>\omega_0>0,\ F,\Omega: constant""",
    hint: r"""\text{Find a particular solution using method of undetermined coefficients, define a new function by subtracting it, and apply the homogeneous equation formula (Problem 13).}""",
    steps: [
      r"""\textcolor{brown}{\large{[Mechanics]}}""",
      r"""\text{• Forced vibration in an overdamped system}""",
      r"""\text{• In mechanics, it often appears in the form } mx''(t) + 2cx'(t) + kx(t) = F_0\sin(\Omega t) \text{. This represents forced vibration in an overdamped system. Response to external force } F\sin(\Omega t) \text{. In steady state, damped terms vanish and it oscillates at the same frequency as the forcing term.}""",
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• Forced vibration of RLC circuit (overdamping)}""",
      r"""\text{• In electromagnetism, it often appears in the form } LI'(t) + RI(t) + \displaystyle \frac{q(t)}{C} = V_0\sin(\Omega t) \text{. This represents forced vibration of an RLC circuit. Current has phase difference } \alpha = -\arctan\left(\frac{2\gamma\Omega}{\omega_0^2-\Omega^2}\right) \text{ relative to voltage, and current amplitude is } \frac{F\Omega}{\sqrt{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}} \text{.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Mechanics]}}""",
      r"""\text{Forced vibration in overdamped system:} \ mx''(t) + 2cx'(t) + kx(t) = F_0\sin(\Omega t)""",
      r"""\text{• } f(t) \leftrightarrow x(t) \text{ (position)}""",
      r"""\text{• } f'(t) \leftrightarrow v(t) \text{ (velocity)}""",
      r"""\text{• } f''(t) \leftrightarrow a(t) \text{ (acceleration)}""",
      r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{2c}{m} \text{ (damping coefficient)}""",
      r"""\text{• } \omega_0 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{ (natural angular frequency)}""",
      r"""\text{• } \omega_h \leftrightarrow \sqrt{\gamma^2 - \omega_0^2} \text{ (overdamped angular frequency)}""",
      r"""\text{• } F \leftrightarrow \displaystyle \frac{F_0}{m} \text{ (external force amplitude / mass)}""",
      r"""\text{• } \Omega \leftrightarrow \Omega \text{ (angular frequency of external force)}""",
      r"""\text{• } f(0)=0 \leftrightarrow x_0=0 \text{ (initial position)}""",
      r"""\text{• } f'(0)=0 \leftrightarrow v_0=0 \text{ (initial velocity)}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{Forced vibration of RLC circuit (overdamping):} \ LI'(t) + RI(t) + \displaystyle \frac{q(t)}{C} = V_0\sin(\Omega t)""",
      r"""\text{• } f(t) \leftrightarrow q(t) \text{ (charge)}""",
      r"""\text{• } f'(t) \leftrightarrow I(t) \text{ (current)}""",
      r"""\text{• } f''(t) \leftrightarrow I'(t) \text{ (rate of current change)}""",
      r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{R}{2L} \text{ (damping coefficient)}""",
      r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{ (natural angular frequency)}""",
      r"""\text{• } \omega_h \leftrightarrow \sqrt{\gamma^2 - \omega_0^2} \text{ (overdamped angular frequency)}""",
      r"""\text{• } F \leftrightarrow \displaystyle \frac{V_0}{L} \text{ (voltage amplitude / inductance)}""",
      r"""\text{• } \Omega \leftrightarrow \Omega \text{ (driving angular frequency)}""",
      r"""\text{• } f(0)=0 \leftrightarrow q_0=0 \text{ (initial charge)}""",
      r"""\text{• } f'(0)=0 \leftrightarrow I_0=0 \text{ (initial current)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\textbf{[Strategy]}""",
      r"""\text{Find a particular solution using method of undetermined coefficients, define a new function by subtracting it, and apply the homogeneous equation formula (Problem 13).}""",
      r"""\textcolor{green}{Formula\ for\ homogeneous\ case}""",
      r"""\text{The solution to the initial value problem for } f''(t) + 2\gamma f'(t) + \omega_0^2 f(t) = 0 \text{ (overdamped: } \gamma > \omega_0 \text{) with}""",
      r"""f(0) = f_0,\quad f'(0) = v_0""",
      r"""\text{is (from Problem 13):}""",
      r"""f(t) = \frac{f_0\omega_h+(v_0+\gamma f_0)}{2\omega_h}e^{(-\gamma+\omega_h)t} + \frac{f_0\omega_h-(v_0+\gamma f_0)}{2\omega_h}e^{(-\gamma-\omega_h)t},\quad \omega_h = \sqrt{\gamma^2 - \omega_0^2}""",
      r"""\text{.}""", r"""\textcolor{blue}{Use\ this\ formula\ to\ solve\ this\ problem.}""",
      r"""f''(t) + 2\gamma f'(t) + \omega_0^2 f(t) = F\sin(\Omega t),\quad \gamma > \omega_0""",
      r"""\textcolor{green}{1.} \textcolor{green}{Find\ particular\ solution}""",
      r"""\text{Based on non-homogeneous term } F\sin(\Omega t) \text{, estimate particular solution as:}""",
      r"""f_p(t) = A\sin(\Omega t) + B\cos(\Omega t)""",
      r"""\text{(where } A, B \text{ are undetermined coefficients).}""",
      r"""\text{First, differentiate } f_p(t) \text{:}""",
      r"""
  \begin{aligned}
  f_p'(t) &= \Omega A\cos(\Omega t) - \Omega B\sin(\Omega t) \\[5pt]
  f_p''(t) &= -\Omega^2 A\sin(\Omega t) - \Omega^2 B\cos(\Omega t)
  \end{aligned}
  """,
      r"""\text{Substituting these into } f_p''(t) + 2\gamma f_p'(t) + \omega_0^2 f_p(t) = F\sin(\Omega t) \text{:}""",
      r"""
  \begin{aligned}
  f_p''(t) + 2\gamma f_p'(t) + \omega_0^2 f_p(t) &= (-\Omega^2 A\sin(\Omega t) - \Omega^2 B\cos(\Omega t)) \\[5pt]
  &\quad + 2\gamma(\Omega A\cos(\Omega t) - \Omega B\sin(\Omega t)) \\[5pt]
  &\quad + \omega_0^2(A\sin(\Omega t) + B\cos(\Omega t)) \\[5pt]
  &= (-\Omega^2 A - 2\gamma\Omega B + \omega_0^2 A)\sin(\Omega t) \\[5pt]
  &\quad + (-\Omega^2 B + 2\gamma\Omega A + \omega_0^2 B)\cos(\Omega t) \\[5pt]
  &= ((\omega_0^2 - \Omega^2)A - 2\gamma\Omega B)\sin(\Omega t) \\[5pt]
  &\quad + (2\gamma\Omega A + (\omega_0^2 - \Omega^2)B)\cos(\Omega t) \\[5pt]
  &= F\sin(\Omega t)
  \end{aligned}
  """,
      r"""\textcolor{green}{2. } \textcolor{green}{Compare\ coefficients}""",
      r"""\text{Comparing coefficients on both sides:}""",
      r"""
  \begin{cases}
  (\omega_0^2 - \Omega^2)A - 2\gamma\Omega B = F \\[5pt]
  2\gamma\Omega A + (\omega_0^2 - \Omega^2)B = 0
  \end{cases}
  """,
      r"""\text{From the 2nd equation } B = -\frac{2\gamma\Omega A}{\omega_0^2 - \Omega^2} \text{. Substituting into the 1st equation:}""",
      r"""
  \begin{aligned}
  (\omega_0^2 - \Omega^2)A - 2\gamma\Omega \cdot \left(-\frac{2\gamma\Omega A}{\omega_0^2 - \Omega^2}\right) &= F \\[5pt]
  (\omega_0^2 - \Omega^2)A + \frac{4\gamma^2\Omega^2 A}{\omega_0^2 - \Omega^2} &= F \\[5pt]
  \frac{(\omega_0^2 - \Omega^2)^2 + 4\gamma^2\Omega^2}{\omega_0^2 - \Omega^2}A &= F \\[5pt]
  A &= \frac{F(\omega_0^2 - \Omega^2)}{(\omega_0^2 - \Omega^2)^2 + 4\gamma^2\Omega^2} \\[5pt]
  B &= -\frac{2\gamma\Omega F}{(\omega_0^2 - \Omega^2)^2 + 4\gamma^2\Omega^2}
  \end{aligned}
  """,
      r"""\text{Particular solution:}""",
      r"""
  \begin{aligned}
  f_p(t) &= \frac{F(\omega_0^2 - \Omega^2)}{(\omega_0^2 - \Omega^2)^2 + 4\gamma^2\Omega^2}\sin(\Omega t) \\[5pt]
  &\quad - \frac{2\gamma\Omega F}{(\omega_0^2 - \Omega^2)^2 + 4\gamma^2\Omega^2}\cos(\Omega t)
  \end{aligned}
  """,
      r"""\textcolor{green}{3.} \textcolor{green}{Homogenize\ by\ translating\ to\ new\ function\ } \textcolor{green}{g}""",
      r"""\text{Let } g(t) = f(t) - f_p(t) \text{.}""",
      r"""\text{By linearity of derivatives and } f_p''(t) + 2\gamma f_p'(t) + \omega_0^2 f_p(t) = F\sin(\Omega t) \text{:}""",
      r"""
  \begin{aligned}
  g''(t) + 2\gamma g'(t) + \omega_0^2 g(t) &= (f(t) - f_p(t))'' + 2\gamma(f(t) - f_p(t))' + \omega_0^2(f(t) - f_p(t)) \\[5pt]
  &= (f''(t) + 2\gamma f'(t) + \omega_0^2 f(t)) - (f_p''(t) + 2\gamma f_p'(t) + \omega_0^2 f_p(t)) \\[5pt]
  &= F\sin(\Omega t) - F\sin(\Omega t) \\[5pt]
  &= 0
  \end{aligned}
  """,
      r"""\text{Thus } g''(t) + 2\gamma g'(t) + \omega_0^2 g(t) = 0 \text{ (Homogenization complete)}""",
      r"""\textcolor{green}{4.\ } \textcolor{green}{Find\ initial\ conditions\ for\ \ g}""",
      r"""
  \begin{aligned}
  g(0) &= f(0) - f_p(0) = 0 - B = -B \\[5pt]
  g'(0) &= f'(0) - f_p'(0) = 0 - \Omega A = -\Omega A
  \end{aligned}
  """,
      r"""\textcolor{green}{5.\ } \textcolor{green}{Apply\ formula\ from\ Problem\ 13\ to\ find\ \ g(t)}""",
      r"""\text{For } g''(t) + 2\gamma g'(t) + \omega_0^2 g(t) = 0 \text{ (overdamped):}""",
      r"""\text{• Damping constant: } \gamma > \omega_0""",
      r"""\text{• Overdamped parameter: } \omega_h = \sqrt{\gamma^2 - \omega_0^2}""",
      r"""\text{• Initial conditions: } g(0) = -B, g'(0) = -\Omega A""",
      r"""\text{From Problem 13 formula:}""",
      r"""
  \begin{aligned}
  g(t) &= \frac{g(0)\omega_h+(g'(0)+\gamma g(0))}{2\omega_h}e^{(-\gamma+\omega_h)t} \\[5pt]
  &\quad + \frac{g(0)\omega_h-(g'(0)+\gamma g(0))}{2\omega_h}e^{(-\gamma-\omega_h)t} \\[5pt]
  &= \frac{-B\omega_h+(-\Omega A+\gamma(-B))}{2\omega_h}e^{(-\gamma+\omega_h)t} \\[5pt]
  &\quad + \frac{-B\omega_h-(-\Omega A+\gamma(-B))}{2\omega_h}e^{(-\gamma-\omega_h)t} \\[5pt]
  &= \frac{-B\omega_h-(\Omega A+\gamma B)}{2\omega_h}e^{(-\gamma+\omega_h)t} \\[5pt]
  &\quad + \frac{-B\omega_h+(\Omega A+\gamma B)}{2\omega_h}e^{(-\gamma-\omega_h)t}
  \end{aligned}
  """,
      r"""\textcolor{green}{6.\ } \textcolor{green}{Find\ \ f(t)\ \ by\ combining\ \ g(t)\ \ and\ particular\ solution}""",
      r"""\text{ } f(t) = g(t) + f_p(t)""",
      r"""\text{Substituting } A = \frac{F(\omega_0^2 - \Omega^2)}{(\omega_0^2 - \Omega^2)^2 + 4\gamma^2\Omega^2}, B = -\frac{2\gamma\Omega F}{(\omega_0^2 - \Omega^2)^2 + 4\gamma^2\Omega^2} \text{:}""",
      r"""
  \begin{aligned}
  f(t) &= e^{-\gamma t}\left(\frac{-\frac{2\gamma\Omega F}{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}\omega_h-\left(\frac{\Omega F(\omega_0^2-\Omega^2)}{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}+\frac{2\gamma^2\Omega F}{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}\right)}{2\omega_h}e^{\omega_h t}\right. \\[5pt]
  &\quad \left. + \frac{-\frac{2\gamma\Omega F}{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}\omega_h+\left(\frac{\Omega F(\omega_0^2-\Omega^2)}{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}+\frac{2\gamma^2\Omega F}{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}\right)}{2\omega_h}e^{-\omega_h t}\right) \\[5pt]
  &\quad + \frac{F(\omega_0^2-\Omega^2)}{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}\sin(\Omega t) - \frac{2\gamma\Omega F}{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}\cos(\Omega t)
  \end{aligned}
  """,
      r"""\textcolor{green}{7.\ } \textcolor{green}{Steady-state\ solution}""",
      r"""\text{After sufficient time, the transient term } e^{-\gamma t} \text{ converges to } 0 \text{.}""",
      r"""\text{The steady-state solution (charge) is:}""",
      r"""
  \begin{aligned}
  Q_s(t) = f_s(t) &= \frac{F(\omega_0^2-\Omega^2)}{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}\sin(\Omega t) - \frac{2\gamma\Omega F}{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}\cos(\Omega t)
  \end{aligned}
  """,
      r"""\text{Charge amplitude: } Q_0 = \sqrt{\left(\frac{F(\omega_0^2-\Omega^2)}{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}\right)^2 + \left(\frac{2\gamma\Omega F}{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}\right)^2} = \frac{F}{\sqrt{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}}""",
      r"""\text{Factoring by root sum of squares and using addition theorem, with } \tan\theta = \frac{2\gamma\Omega}{\omega_0^2-\Omega^2} \text{:}""",
      r"""
  \begin{aligned}
  Q_s(t) = f_s(t) = Q_0\sin(\Omega t + \theta) = \frac{F}{\sqrt{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}}\sin\left(\Omega t + \arctan\left(\frac{2\gamma\Omega}{\omega_0^2-\Omega^2}\right)\right)
  \end{aligned}
  """,
      r"""\text{Steady-state current is charge derivative:}""",
      r"""
  \begin{aligned}
  I_s(t) = f_s'(t) &= Q_0\Omega\cos(\Omega t + \theta) = \frac{F\Omega}{\sqrt{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}}\cos\left(\Omega t + \arctan\left(\frac{2\gamma\Omega}{\omega_0^2-\Omega^2}\right)\right) \\[5pt]
  &= \frac{F\Omega}{\sqrt{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}\sin\left(\Omega t + \arctan\left(\frac{2\gamma\Omega}{\omega_0^2-\Omega^2}\right) + \frac{\pi}{2}\right)
  \end{aligned}
  """,
      r"""\text{Current amplitude: } I_0 = Q_0\Omega = \frac{F\Omega}{\sqrt{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}}""",
      r"""\textcolor{green}{8.\ } \textcolor{green}{Physical\ Correspondence}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{Kirchhoff's law for RLC series AC circuit:} \ V(t) = L\frac{dI}{dt} + RI + \frac{1}{C}\int_0^t I(s)\,ds""",
      r"""\text{Expressing current } I(t) = \frac{dQ}{dt} \text{ using charge } Q(t) \text{: } V(t) = L\frac{d^2Q}{dt^2} + R\frac{dQ}{dt} + \frac{1}{C}Q(t)""",
      r"""\text{Comparing with differential equation } f''(t) + 2\gamma f'(t) + \omega_0^2 f(t) = F\sin(\Omega t) \text{ (overdamped: } \gamma > \omega_0 \text{) variables correspond as follows:}""",
      r"""\text{• } f(t) \leftrightarrow Q(t) \text{ (charge)}""",
      r"""\text{• } f'(t) \leftrightarrow I(t) = \frac{dQ}{dt} \text{ (current)}""",
      r"""\text{• } f''(t) \leftrightarrow \frac{dI}{dt} = \frac{d^2Q}{dt^2} \text{ (rate of current change)}""",
      r"""\text{• } L = 1 \text{ (inductance)}""",
      r"""\text{• } R = 2\gamma \text{ (resistance)}""",
      r"""\text{• } \frac{1}{C} = \omega_0^2 \text{, so } C = \frac{1}{\omega_0^2} \text{ (capacitance)}""",
      r"""\text{• } V_0 = F \text{ (voltage amplitude)}""",
      r"""\text{• } \omega = \Omega \text{ (angular frequency)}""",
      r"""\text{• Damping constant: } \gamma = \frac{R}{2L} = \frac{2\gamma}{2 \times 1} = \gamma""",
      r"""\text{• Natural angular frequency: } \omega_0 = \sqrt{\frac{1}{LC}} = \sqrt{\frac{1}{1 \times \frac{1}{\omega_0^2}}} = \omega_0""",
      r"""\text{• Overdamped parameter: } \omega_h = \sqrt{\gamma^2 - \omega_0^2} \text{ (overdamping condition: } \gamma > \omega_0 \text{)}""",
      r"""\textcolor{green}{9.\ } \textcolor{green}{Impedance}""",
      r"""\text{• Inductive reactance: } X_L = \Omega L = \Omega \times 1 = \Omega""",
      r"""\text{• Capacitive reactance: } X_C = \frac{1}{\Omega C} = \frac{1}{\Omega \times \frac{1}{\omega_0^2}} = \frac{\omega_0^2}{\Omega}""",
      r"""\text{• Reactance: } X = X_L - X_C = \Omega - \frac{\omega_0^2}{\Omega} = \frac{\Omega^2 - \omega_0^2}{\Omega}""",
      r"""\text{• Impedance magnitude:}""",
      r"""
  \begin{aligned}
  |Z| &= \sqrt{R^2 + X^2} = \sqrt{(2\gamma)^2 + \left(\frac{\Omega^2 - \omega_0^2}{\Omega}\right)^2} \\[5pt]
  &= \sqrt{4\gamma^2 + \frac{(\Omega^2 - \omega_0^2)^2}{\Omega^2}} \\[5pt]
  &= \sqrt{\frac{4\gamma^2\Omega^2 + (\Omega^2 - \omega_0^2)^2}{\Omega^2}} \\[5pt]
  &= \frac{\sqrt{(\omega_0^2 - \Omega^2)^2 + 4\gamma^2\Omega^2}}{\Omega}
  \end{aligned}
  """,
      r"""\text{• Current amplitude: } I_0 = \frac{V_0}{|Z|} = \frac{F}{\frac{\sqrt{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}}{\Omega}} = \frac{F\Omega}{\sqrt{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}} \text{ (matches Section 7)}""",
      r"""\textcolor{green}{10.\ } \textcolor{green}{Phase\ Lag}""",
      r"""\text{Voltage: } V(t) = V_0\sin(\Omega t) = F\sin(\Omega t)""",
      r"""\text{Current: } I_s(t) = I_0\sin\left(\Omega t + \arctan\left(\frac{2\gamma\Omega}{\omega_0^2-\Omega^2}\right)\right) = \frac{F\Omega}{\sqrt{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}}\sin\left(\Omega t + \arctan\left(\frac{2\gamma\Omega}{\omega_0^2-\Omega^2}\right)\right)""",
      r"""\text{Phase difference: Current leads voltage (if } \omega_0^2 > \Omega^2 \text{) or lags (if } \omega_0^2 < \Omega^2 \text{) by } \alpha = \arctan\left(\frac{2\gamma\Omega}{\omega_0^2-\Omega^2}\right) \text{.}""",
      r"""\text{Impedance phase angle: } \alpha = \arctan\left(\frac{X}{R}\right) = \arctan\left(\frac{\frac{\Omega^2-\omega_0^2}{\Omega}}{2\gamma}\right) = \arctan\left(\frac{\Omega^2-\omega_0^2}{2\gamma\Omega}\right) = -\arctan\left(\frac{\omega_0^2-\Omega^2}{2\gamma\Omega}\right)""",
      r"""\text{This matches the phase difference between voltage and current.}""",
      r"""\textcolor{green}{11.\ } \textcolor{green}{Power\ Consumption,\ Power\ Factor}""",
      r"""\text{Voltage: } V(t) = F\sin(\Omega t) \text{, Current: } I(t) = \frac{F\Omega}{\sqrt{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}}\sin\left(\Omega t + \arctan\left(\frac{2\gamma\Omega}{\omega_0^2-\Omega^2}\right)\right)""",
      r"""\text{Phase difference: } \alpha = -\arctan\left(\frac{2\gamma\Omega}{\omega_0^2-\Omega^2}\right)""",
      r"""\text{Power factor: } \cos(\alpha) = \cos\left(\arctan\left(\frac{2\gamma\Omega}{\omega_0^2-\Omega^2}\right)\right) = \frac{\omega_0^2-\Omega^2}{\sqrt{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}} \text{ (cosine of phase difference between voltage and current)}""",
      r"""\text{RMS Voltage: } V_{\text{rms}} = \frac{V_0}{\sqrt{2}} = \frac{F}{\sqrt{2}}""",
      r"""\text{RMS Current: } I_{\text{rms}} = \frac{I_0}{\sqrt{2}} = \frac{F\Omega}{\sqrt{2}\sqrt{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}}""",
      r"""\text{Average power consumption in resistor:}""",
      r"""
  \begin{aligned}
  \bar{P}_R &= \frac{1}{2}RI_0^2 = \frac{1}{2} \times 2\gamma \times \left(\frac{F\Omega}{\sqrt{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}}\right)^2 \\[5pt]
  &= \frac{\gamma F^2\Omega^2}{(\omega_0^2-\Omega^2)^2+4\gamma^2\Omega^2}
  \end{aligned}
  """,
    ],
  ),

  // rlc_series_voltage_overdamped_problems.dart (numeric)
  "E86D2CB5-8675-4A3F-B4DF-16C5F5FA1A38": ProblemTranslation(
    category: 'Numerical - 2nd Order - Non-homogeneous',
    level: 'Advanced',
    hint: r"""\text{Find a particular solution }f_p\text{, set }g=f-f_p\text{ to homogenize, and solve }g\text{ using the overdamped homogeneous formula (Problem 13).}""",
    steps: [
      r"""\textbf{[Given]}""",
      r"""f''(t)+12f'(t)+16f(t)=10\sin(2t),\quad f(0)=0,\ f'(0)=0""",
      r"""\textbf{[1. Particular solution]}""",
      r"""\text{Assume }f_p(t)=A\sin(2t)+B\cos(2t)\text{. Then }f_p'(t)=2A\cos(2t)-2B\sin(2t)\text{ and }f_p''(t)=-4A\sin(2t)-4B\cos(2t)\text{.}""",
      r"""\text{Substitute into the ODE and compare coefficients of }\sin(2t),\cos(2t)\text{:}""",
      r"""\begin{aligned} 12A-24B&=10,\\ 24A+12B&=0. \end{aligned}""",
      r"""\text{Solving gives }A=\displaystyle\frac{1}{6},\ B=-\displaystyle\frac{1}{3}\text{, hence}""",
      r"""\begin{aligned} f_p(t)=\frac{1}{6}\sin(2t)-\frac{1}{3}\cos(2t). \end{aligned}""",
      r"""\textbf{[2. Homogenize]}""",
      r"""\text{Let }g(t)=f(t)-f_p(t)\text{. Then }g''+12g'+16g=0\text{.}""",
      r"""\text{Initial conditions: }g(0)=f(0)-f_p(0)=0-\left(-\frac{1}{3}\right)=\frac{1}{3}\text{, and }g'(0)=f'(0)-f_p'(0)=0-\frac{1}{3}=-\frac{1}{3}\text{.}""",
      r"""\textbf{[3. Solve }g\textbf{ (overdamped)]}""",
      r"""\text{Here }2\gamma=12\Rightarrow \gamma=6\text{ and }\omega_0^2=16\Rightarrow \omega_0=4\text{, so }\gamma>\omega_0\text{. Let }\omega_h=\sqrt{\gamma^2-\omega_0^2}=2\sqrt{5}\text{.}""",
      r"""\text{Applying the overdamped homogeneous formula (Problem 13) with }g(0)=\frac{1}{3},\ g'(0)=-\frac{1}{3}\text{ yields}""",
      r"""\begin{aligned} g(t)=e^{-6t}\left(\frac{2+\sqrt{5}}{12}e^{2\sqrt{5}t}+\frac{2-\sqrt{5}}{12}e^{-2\sqrt{5}t}\right). \end{aligned}""",
      r"""\textbf{[4. Combine]}""",
      r"""\begin{aligned} f(t)=g(t)+f_p(t)=e^{-6t}\left(\frac{2+\sqrt{5}}{12}e^{2\sqrt{5}t}+\frac{2-\sqrt{5}}{12}e^{-2\sqrt{5}t}\right)+\frac{1}{6}\sin(2t)-\frac{1}{3}\cos(2t). \end{aligned}""",
      r"""\text{The steady-state part can also be written as } \displaystyle\frac{\sqrt{5}}{6}\sin\left(2t+\arctan(-2)\right)\text{.}""",
    ],
  ),
  // (reserve / commented-out in source)
  "F8A9B0C1-D2E3-4F5A-6B7C-8D9E0F1A2B3C": ProblemTranslation(
    category: 'Numerical - 2nd Order - Non-homogeneous',
    level: 'Advanced',
    hint: r"""\text{Differentiate the integral equation to obtain a 2nd order ODE, then solve it by undetermined coefficients.}""",
    steps: [
      r"""\textbf{[Given]}""",
      r"""f'(t)+2f(t)+4\int_0^t f(s)\,ds=10\sin(2t),\quad f(0)=0""",
      r"""\textbf{[1. Convert to a differential equation]}""",
      r"""\text{Differentiate both sides. Since }\displaystyle \frac{d}{dt}\int_0^t f(s)\,ds=f(t)\text{, we get}""",
      r"""\begin{aligned} f''(t)+2f'(t)+4f(t)=20\cos(2t). \end{aligned}""",
      r"""\text{From the original equation at }t=0\text{: }f'(0)+2f(0)=0\Rightarrow f'(0)=0\text{.}""",
      r"""\textbf{[2. Solve the ODE]}""",
      r"""\text{Try a particular solution }f_p(t)=A\sin(2t)+B\cos(2t)\text{. Comparing coefficients gives }A=5,\ B=0\text{, so }f_p(t)=5\sin(2t)\text{.}""",
      r"""\text{The homogeneous equation }f_h''+2f_h'+4f_h=0\text{ has roots }-1\pm i\sqrt{3}\text{, hence}""",
      r"""\begin{aligned} f_h(t)=e^{-t}\left(C_1\cos(\sqrt{3}t)+C_2\sin(\sqrt{3}t)\right). \end{aligned}""",
      r"""\text{Apply }f(0)=0\text{: }C_1=0\text{. Apply }f'(0)=0\text{: }C_2\sqrt{3}+10=0\Rightarrow C_2=-\displaystyle\frac{10}{\sqrt{3}}\text{.}""",
      r"""\textbf{[Final]}""",
      r"""\begin{aligned} f(t)=e^{-t}\left(-\frac{10}{\sqrt{3}}\sin(\sqrt{3}t)\right)+5\sin(2t). \end{aligned}""",
    ],
  ),

  // rlc_series_voltage_underdamped_problems.dart
  "07FC023A-DAD9-432A-BCD7-B90E3C25404F": ProblemTranslation(
    category: 'General - 2nd Order - Non-homogeneous',
    level: 'Advanced',
    constants: r"""\alpha, \gamma, \beta>0,\ F,\omega: constant""",
    hint: r"""\text{Find a particular solution using method of undetermined coefficients, define a new function by subtracting it, and apply the homogeneous equation formula (Problem 12) for the RHS = 0 case.}""",
    steps: [
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• For an RLC series AC circuit, Kirchhoff's second law gives } LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = V_0\sin(\omega t) \text{.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{Transient response of RLC series AC circuit:} \ LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = V_0\sin(\omega t)""",
      r"""\text{• } f(t) \leftrightarrow Q(t) \text{ (charge in capacitor)}""",
      r"""\text{• } f'(t) \leftrightarrow Q'(t) \text{ (current)}""",
      r"""\text{• } f''(t) \leftrightarrow Q''(t) \text{ (rate of current change)}""",
      r"""\text{• } \alpha \leftrightarrow L \text{ (inductance)}""",
      r"""\text{• } 2\beta \leftrightarrow R \text{ (resistance)}""",
      r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{1}{C} \text{ (reciprocal of capacitance)}""",
      r"""\text{• } \frac{\gamma}{\alpha} \leftrightarrow \frac{1}{LC} = \omega_0^2 \text{ (natural angular frequency squared)}""",
      r"""\text{• } \sqrt{\frac{\gamma}{\alpha} - \frac{\beta^2}{\alpha^2}} \leftrightarrow \sqrt{\displaystyle \frac{1}{LC} - \left(\displaystyle \frac{R}{2L}\right)^2} \text{ (damped angular frequency)}""",
      r"""\text{• } F \leftrightarrow \displaystyle V_0 \text{ (voltage amplitude)}""",
      r"""\text{• } \omega \leftrightarrow \omega \text{ (AC voltage frequency)}""",
      r"""\text{• Steady-state } f'(t) \text{ amplitude to } F \text{ ratio (impedance): } \textcolor{blue}{\displaystyle \frac{F}{f'_{max}} = \sqrt{\left(\frac {\gamma}{\omega} -\alpha\omega\right)^2+4\beta^2} \leftrightarrow  |Z| = \frac {V_0}{I_{max}} = {\sqrt{\left(\frac{1}{\omega C} - \omega L \right) ^2 + R^2}}}""",
      r"""\text{• Phase difference between steady-state } f'(t) \text{ and RHS } F\sin(\omega t) \text{: } \tan \phi = \frac{\omega\alpha- \frac {\gamma}{\omega}}{2\beta} \leftrightarrow \tan \phi = \frac{\omega L -\frac{1}{\omega C}}{R} \text{ (phase difference between current and voltage)}""",
      r"""\text{• } f_0 = 0 \leftrightarrow Q_0 = 0 \text{ (initial charge)}""",
      r"""\text{• } v_0 = 0 \leftrightarrow I_0 = 0 \text{ (initial current)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\textbf{[Strategy]}""",
      r"""\text{Find a particular solution using method of undetermined coefficients, define a new function by subtracting it, and apply the homogeneous equation formula (Problem 12) for the RHS = 0 case.}""",
      r"""\textcolor{blue}{The\ solution\ to\ the\ initial\ value\ problem\ for\ } \textcolor{blue}{\alpha f''(t) + 2\beta f'(t) + \gamma f(t) = 0} \textcolor{blue}{\ with\ } \textcolor{blue}{f(0)\ =\ f_0,\ f'(0)\ =\ v_0} \textcolor{blue}{\ is\ as\ follows\ (Problem\ 12):}""",
      r"""\textcolor{blue}{f(t) = e^{-\frac{\beta}{\alpha} t}\left(f_0\cos\left(\sqrt{\frac{\gamma}{\alpha} - \frac{\beta^2}{\alpha^2}}\ \,t\right) + \frac{v_0 + \frac{\beta}{\alpha} f_0}{\sqrt{\frac{\gamma}{\alpha} - \frac{\beta^2}{\alpha^2}}}\sin\left(\sqrt{\frac{\gamma}{\alpha} - \frac{\beta^2}{\alpha^2}}\ \,t\right)\right)}""",
      r"""\textcolor{green}{1.\ } \textcolor{green}{\frac{F}{\sqrt{(\gamma-\alpha\omega^2)^2+4\beta^2\omega^2}}\sin(\omega t + \theta)} \textcolor{green}{\ satisfies\ this\ differential\ equation,\ where\ } \textcolor{green}{\tan \theta =\frac{2\beta\omega}{\gamma-\alpha\omega^2}}""",
      r"""\textcolor{purple}{[Proof]}""",
      r"""\text{Based on the RHS } F\sin(\omega t) \text{, estimate a particular solution as:}""",
      r"""f_p(t) = A\sin(\omega t) + B\cos(\omega t) \text{ (where } A, B \text{ are time-independent constants).}""",
      r"""\text{First, differentiate } f_p(t) \text{:}""",
      r"""
  \begin{aligned}
  \begin{cases}
  f_p'(t) = \omega A\cos(\omega t) - \omega B\sin(\omega t) \\[5pt]
  f_p''(t) = -\omega^2 A\sin(\omega t) - \omega^2 B\cos(\omega t)
  \end{cases}
  \end{aligned}
  """,
      r"""\text{Substituting these into } \alpha f_p''(t) + 2\beta f_p'(t) + \gamma f_p(t) = F\sin(\omega t)\cdots (1)\text{:}""",
      r"""\text{Comparing the coefficients of } \sin(\omega t)\text{ and }\cos(\omega t)\text{:}""",
      r"""\text{cos coefficient: } 2\beta\omega A + (\gamma - \alpha\omega^2)B = 0""",
      r"""\text{sin coefficient: } (\gamma - \alpha\omega^2)A - 2\beta\omega B = F""",
      r"""\text{(Since (1) is an identity in t, compare coefficients on both sides.)}""",
      r"""\text{From sin coefficient comparison } B = -\frac{2\beta\omega A}{\gamma - \alpha\omega^2} \text{. Substituting into the 1st equation to find A, B:}""",
      r"""\begin{aligned}
  &\ \ \ \ \ \ (\gamma - \alpha\omega^2)A - 2\beta\omega \cdot \left(-\frac{2\beta\omega A}{\gamma - \alpha\omega^2}\right) = F \\[5pt]
  &\Leftrightarrow \ \frac{(\gamma - \alpha\omega^2)^2 + 4\beta^2\omega^2}{\gamma - \alpha\omega^2}A = F \\[5pt]
  &\Leftrightarrow \ A = \frac{F(\gamma - \alpha\omega^2)}{(\gamma - \alpha\omega^2)^2 + 4\beta^2\omega^2} \\[5pt]
  &\text{Thus, }\  B = -\frac{2\beta\omega F}{(\gamma - \alpha\omega^2)^2 + 4\beta^2\omega^2}\end{aligned}""",
      r"""\text{Thus the particular solution is:}""",
      r"""
  f_p(t) = \dfrac{F(\gamma - \alpha\omega^2)}{(\gamma - \alpha\omega^2)^2 + 4\beta^2\omega^2}\sin(\omega t) - \frac{2\beta\omega F}{(\gamma - \alpha\omega^2)^2 + 4\beta^2\omega^2}\cos(\omega t)
  """,
      r"""\textcolor{purple}{(i)\ Case\ } \textcolor{purple}{\omega = \sqrt{\frac{\gamma}{\alpha}}}""",
      r"""\text{Coefficient of sin is 0:}""",
      r"""
  \textcolor{red}{\begin{aligned}
  f_p(t) &= - \frac{2\beta\omega F}{4\beta^2\omega^2}\cos(\omega t)\\[5pt]
  &= - \frac{F}{2\beta \omega}\cos(\omega t) \\[5pt]
  &= - \frac{F}{2\beta \omega}\sin(\omega t + \frac{\pi}{2})\\[5pt]
  &= \frac{F}{2\beta \omega}\sin\left(\omega t - \frac{\pi}{2}\right)
  \end{aligned}}
  """,
      r"""\textcolor{purple}{(ii)\ Case\ } \textcolor{purple}{\omega \neq \sqrt{\frac{\gamma}{\alpha}}}""",
      r"""\text{Synthesizing trigonometric functions:}""",
      r"""\text{Amplitude: } \sqrt{\left(\frac{F(\gamma-\alpha\omega^2)}{(\gamma-\alpha\omega^2)^2+4\beta^2\omega^2}\right)^2 + \left(\frac{2\beta\omega F}{(\gamma-\alpha\omega^2)^2+4\beta^2\omega^2}\right)^2} = \frac{F}{\sqrt{(\gamma-\alpha\omega^2)^2+4\beta^2\omega^2}}""",
      r"""\text{Using phase angle } \theta \text{ s.t. } \tan \theta =\frac{2\beta\omega}{\gamma-\alpha\omega^2} \text{:}""",
      r"""\textcolor{blue}{f_p(t) = \frac{F}{\sqrt{(\gamma-\alpha\omega^2)^2+4\beta^2\omega^2}}\sin(\omega t + \theta)}""",
      r"""\textcolor{green}{3.} \textcolor{green}{Define\ \ g(t)\ =\ f(t)\ -\ f_p(t)\ \ as\ translation\ of\ \ f(t)}""",
      r"""\text{Since } f_p(t) \text{ is a solution, it satisfies } \alpha f_p''(t) + 2\beta f_p'(t) + \gamma f_p(t) = F\sin(\omega t) \text{. Subtracting this from the original equation:}""",
      r"""\text{Subtracting gives:}""",
      r"""
  \begin{aligned}
  &\quad \alpha f''(t) + 2\beta f'(t) + \gamma f(t) = F\sin(\omega t) \\
  -&\quad \alpha f_p''(t) + 2\beta f_p'(t) + \gamma f_p(t) = F\sin(\omega t) \\[5pt]
  \hline \\
  &\quad \alpha(f''(t) - f_p''(t)) + 2\beta(f'(t) - f_p'(t)) + \gamma(f(t) - f_p(t)) = 0
  \end{aligned}
  """,
      r"""\text{Translation: let } g(t) = f(t) - f_p(t) \text{, then } \alpha g''(t) + 2\beta g'(t) + \gamma g(t) = 0 """,
      r"""\textcolor{blue}{Thus,\ } \textcolor{blue}{g(t)} \textcolor{blue}{\ is\ a\ solution\ to\ the\ homogeneous\ equation\ } \textcolor{blue}{\alpha g''(t) + 2\beta g'(t) + \gamma g(t) = 0} \textcolor{blue}{.}""",
      r"""\textcolor{green}{4.\ } \textcolor{green}{Convergence\ of\ \ g(t)\ \ and\ \ f(t)\ =\ f_p(t)\ \ as\ steady-state\ solution}""",
      r"""\text{From the formula, the solution to } \alpha g''(t) + 2\beta g'(t) + \gamma g(t) = 0 \text{ can be written in a form containing } e^{-\frac{\beta}{\alpha} t}\text{.}""",
      r"""\text{In particular, the damping factor } e^{-\frac{\beta}{\alpha} t} \text{ appears in } g(t)\text{.}""",
      r"""\text{Thus } g(t) \to 0 \text{ as } t \to \infty \text{.}""",
      r"""\text{Since } f(t) = g(t) + f_p(t)\text{,}""",
      r"""\text{we have } f(t) \to f_p(t) \text{ as } t \to \infty \text{.}""",
      r"""\text{Thus for sufficiently large t, the solution can be approximated as:}""",
      r"""
  \begin{aligned}
  \begin{cases}
  \omega = \sqrt{\frac{\gamma}{\alpha}} \text{ (resonance condition):} \\[5pt]
  \quad f(t) = f_p(t) = -\frac{F}{2\beta\omega}\cos(\omega t) = \frac{F}{2\beta\omega}\sin\left(\omega t - \frac{\pi}{2}\right) \\[10pt]
  \omega \neq \sqrt{\frac{\gamma}{\alpha}} \text{:} \\[5pt]
  \quad f(t) = f_p(t) = \dfrac{F}{\sqrt{(\gamma-\alpha\omega^2)^2+4\beta^2\omega^2}} \sin(\omega t + \theta) \\[5pt]
  \quad \text{where } \tan \theta = \frac{2\beta\omega}{\gamma-\alpha\omega^2}
  \end{cases}
  \end{aligned}
  """,
      r"""\textcolor{green}{5.\ } \textcolor{green}{Ratio\ of\ steady-state\ \ f'(t)\ \ to\ \ F}""",
      r"""\text{Differentiating steady-state } f(t) \text{ gives } f'(t) \text{:}""",
      r"""
  \begin{aligned}
  \begin{cases}
  \omega = \sqrt{\frac{\gamma}{\alpha}} \text{ (resonance condition):} \\[5pt]
  \quad f'(t) = \frac{F}{2\beta}\sin(\omega t) \\[10pt]
  \omega \neq \sqrt{\frac{\gamma}{\alpha}} \text{:} \\[5pt]
  \quad \begin{aligned}
  f'(t) &= \frac{F\omega}{\sqrt{(\gamma-\alpha\omega^2)^2+4\beta^2\omega^2}}\cos(\omega t + \theta) \\[5pt]
  &= \frac{F}{\sqrt{\left(\frac{\gamma}{\omega} -\alpha\omega\right)^2+4\beta^2}}\sin\left(\omega t + \theta + \frac{\pi}{2}\right) \\[5pt]
  &\quad \text{(where } \tan \theta = \frac{2\beta\omega}{\gamma-\alpha\omega^2}\text{)}\\[5pt]
  &= \frac{F}{\sqrt{\left(\frac{\gamma}{\omega} -\alpha\omega\right)^2+4\beta^2}}\sin\left(\omega t + \phi \right) \\[5pt]
  &\quad \text{(where } \tan \phi = \dfrac {\alpha\omega^2-\gamma}  {2\beta\omega}\text{)}
  \end{aligned}
  \end{cases}
  \end{aligned}
  """,
      r"""\text{Ratio of steady-state } f'(t) \text{ amplitude to } F \text{ is:}""",
      r"""
  \begin{aligned}
  \begin{cases}
  \omega = \sqrt{\frac{\gamma}{\alpha}} \text{ (resonance condition):} \\[5pt]
  \quad \frac{F}{f'_{max}} = 2\beta \\[10pt]
  \omega \neq \sqrt{\frac{\gamma}{\alpha}} \text{:} \\[5pt]
  \quad \frac{F}{f'_{max}} = \sqrt{\left(\frac {\gamma}{\omega} -\alpha\omega\right)^2+4\beta^2}
  \end{cases}
  \end{aligned}
  """,
      r"""\text{Phase difference between steady-state } f'(t) \text{ and RHS } F\sin(\omega t) \text{:}""",
      r"""
  \begin{aligned}
  \begin{cases}
  \omega = \sqrt{\frac{\gamma}{\alpha}} \text{ (resonance condition):} \\[5pt]
  \quad \phi = 0 \text{ (in-phase)} \\[10pt]
  \omega \neq \sqrt{\frac{\gamma}{\alpha}} \text{:} \\[5pt]
  \quad \text{shifts by angle } \phi \text{ s.t. } \tan \phi = \dfrac {\alpha\omega^2-\gamma}  {2\beta\omega}\text{.}
  \end{cases}
  \end{aligned}
  """,
      r"""\textcolor{blue}{Combining\ these,\ steady-state\ } \textcolor{blue}{f'(t)} \textcolor{blue}{\ can\ be\ represented\ regardless\ of\ } \textcolor{blue}{\Omega} \textcolor{blue}{\ as:}""",
      r"""
  \textcolor{blue}{f'(t) = \frac{F}{\sqrt{\left(\frac{\gamma}{\omega} -\alpha\omega\right)^2+4\beta^2}}\sin\left(\omega t + \phi \right)}""",  
      r"""\textcolor{blue}{where\ } \textcolor{blue}{\phi } \textcolor{blue}{\ is\ the\ angle\ s.t.\ } \textcolor{blue}{\tan \phi = \dfrac {\alpha\omega^2-\gamma}  {2\beta\omega}}\textcolor{blue}{.}""",
    ],
  ),
  "B2C3D4E5-F6G7-8901-BCDE-F2345678901": ProblemTranslation(
    category: 'Numerical - 2nd Order - Non-homogeneous',
    level: 'Advanced',
    hint: r"""\text{Find a particular solution using method of undetermined coefficients, define a new function by subtracting it, and apply the formula for homogeneous equation (RHS = 0).}""",
    steps: [
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• For an RLC series AC circuit, Kirchhoff's second law gives } LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = V_0\cos(\omega t) \text{.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{Transient response of RLC series AC circuit:} \ LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = V_0\cos(\omega t)""",
      r"""\text{• } f(t) \leftrightarrow Q(t) \text{ (charge stored in capacitor)}""",
      r"""\text{• } f'(t) \leftrightarrow Q'(t) \text{ (current)}""",
      r"""\text{• } f''(t) \leftrightarrow Q''(t) \text{ (rate of current change)}""",
      r"""\text{• } \dfrac{2}{2 \cdot 1} = 1 \leftrightarrow \displaystyle \frac{R}{2L} \text{ (damping constant)}""",
      r"""\text{• } \dfrac{1}{\sqrt{1 \cdot \frac{1}{3}}} = \sqrt{3} \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{ (natural frequency when damping is 0)}""",
      r"""\text{• } \sqrt{\frac{1}{1 \cdot \frac{1}{3}} - \left(\frac{2}{2 \cdot 1}\right)^2} = \sqrt{2} \leftrightarrow \sqrt{\displaystyle \frac{1}{LC} - \left(\displaystyle \frac{R}{2L}\right)^2} \text{ (damped angular frequency)}""",
      r"""\text{• } 12 \leftrightarrow V_0 \text{ (voltage amplitude)}""",
      r"""\text{• } 3 \leftrightarrow \omega \text{ (AC voltage frequency)}""",
      r"""\text{• Steady-state } f'(t) \text{ amplitude to } F \text{ ratio (impedance): } \displaystyle \frac{F}{f'_{max}} = \sqrt{\left(\frac{3}{3} - 1 \cdot 3\right)^2+4 \cdot 1^2} = 2\sqrt{2} """,
      r"""\leftrightarrow  |Z| = \frac {V_0}{I_{max}} = {\sqrt{\left(\frac{1}{\omega C} - \omega L \right) ^2 + R^2}}""",
      r"""\text{• Phase difference between steady-state } f'(t) \text{ and RHS } 12\cos(3t) \text{: } \phi = \frac{\pi}{4} \text{ lag } \left( \tan \phi  = \frac{1 \cdot 3 - \frac{1}{3 \cdot \frac 1 3}}{2} = 1 \right)""",
      r""" \leftrightarrow \tan \phi = \frac{\omega L -\frac{1}{\omega C}}{R} \text{ (phase difference between current and voltage)}""",
      r"""\text{• } 0 \leftrightarrow Q_0 \text{ (initial charge)}""",
      r"""\text{• } 0 \leftrightarrow I_0 \text{ (initial current)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\textbf{[Strategy]}""",
      r"""\text{Find a particular solution using method of undetermined coefficients, define a new function by subtracting it, and apply the formula for homogeneous equation (RHS = 0).}""",
      r"""\textcolor{blue}{The\ solution\ to\ the\ initial\ value\ problem\ for\ } \textcolor{blue}{f''(t) + 2\beta f'(t) + \omega_0^2 f(t) = 0} \textcolor{blue}{\ with\ } \textcolor{blue}{f(0)\ =\ f_0,\ f'(0)\ =\ v_0} \textcolor{blue}{\ is\ as\ follows\ (Problem\ 12):}""",
      r"""\textcolor{blue}{f(t) = e^{-\beta t}\left(f_0\cos\left(\sqrt{\omega_0^2-\beta^2}\ \,t\right) + \frac{v_0+\beta f_0}{\sqrt{\omega_0^2-\beta^2}}\sin\left(\sqrt{\omega_0^2-\beta^2}\ \,t\right)\right)}""",
      r"""\textcolor{green}{1.\ } \textcolor{green}{Find\ particular\ solution}""",
      r"""\text{Based on the RHS } 12\cos(3t) \text{, estimate particular solution as:}""",
      r"""f_p(t) = A\sin(3t) + B\cos(3t) \text{ (where } A, B \text{ are time-independent constants).}""",
      r"""\text{First, differentiate } f_p(t) \text{:}""",
      r"""
  \begin{aligned}
  \begin{cases}
  f_p'(t) = 3A\cos(3t) - 3B\sin(3t) \\[5pt]
  f_p''(t) = -9A\sin(3t) - 9B\cos(3t)
  \end{cases}
  \end{aligned}
  """,
      r"""\text{Substituting into } f_p''(t) + 2f_p'(t) + 3f_p(t) = 12\cos(3t)\cdots (1) \text{ and comparing sin/cos coefficients:}""",
      r"""
  \begin{aligned}
  &\ \ \ \ \ f_p''(t) + 2f_p'(t) + 3f_p(t) \\[8pt]
  &= (-9A\sin(3t) - 9B\cos(3t)) + 2(3A\cos(3t) - 3B\sin(3t)) \\[5pt]
  &\quad + 3(A\sin(3t) + B\cos(3t)) \\[8pt]
  &= (-6A - 6B)\sin(3t) + (6A - 6B)\cos(3t) \\[8pt]
  &= 12\cos(3t)
  \end{aligned}
  """,
      r"""\text{Comparing coefficients on both sides:}""",
      r"""\text{sin coefficient: } -6A - 6B = 0""",
      r"""\text{cos coefficient: } 6A - 6B = 12""",
      r"""\text{Solving this: } A = 1,\ B = -1""",
      r"""\text{Thus the particular solution is:}""",
      r"""
  f_p(t) = \sin(3t) - \cos(3t) = \sqrt{2}\sin\left(3t - \frac{\pi}{4}\right)
  """,
      r"""\textcolor{green}{2.} \textcolor{green}{Let\ \ g(t)\ =\ f(t)\ -\ f_p(t)\ ,\ then\ }""",
      r"""\textcolor{green}{g(t)} \textcolor{green}{\ is\ a\ solution\ to\ \ g''(t)\ +\ 2g'(t)\ +\ 3g(t)\ =\ 0\ .}""",
      r"""\text{Since } f_p(t) \text{ is a solution, } f_p''(t) + 2f_p'(t) + 3f_p(t) = 12\cos(3t) \text{. Subtracting this from the original equation:}""",
      r"""\text{Subtracting gives:}""",
      r"""
  \begin{aligned}
  &\quad f''(t) + 2f'(t) + 3f(t) = 12\cos(3t) \\
  -&\quad f_p''(t) + 2f_p'(t) + 3f_p(t) = 12\cos(3t) \\[5pt]
  \hline \\
  &\quad (f''(t) - f_p''(t)) + 2(f'(t) - f_p'(t)) + 3(f(t) - f_p(t)) = 0
  \end{aligned}
  """,
      r"""\text{Translation: let } g(t) = f(t) - f_p(t) \text{, then } g''(t) + 2g'(t) + 3g(t) = 0 """,
      r"""\textcolor{blue}{Thus,\ } \textcolor{blue}{g(t)} \textcolor{blue}{\ is\ a\ solution\ to\ the\ homogeneous\ equation\ } \textcolor{blue}{g''(t)\ +\ 2g'(t)\ +\ 3g(t)\ =\ 0} \textcolor{blue}{.}""",
      r"""\textcolor{green}{3.} \textcolor{green}{Find\ initial\ conditions\ for\ \ g}""",
      r"""\text{From } f_p(t) = \sqrt{2}\sin\left(3t - \frac{\pi}{4}\right) \text{:}""",
      r"""
  \begin{aligned}
  g(0) &= f(0) - f_p(0) \\[5pt]
  &= 0 - \left(\sin(0) - \cos(0)\right) \\[5pt]
  &= 1
  \end{aligned}
  """,
      r"""\text{Next, calculate } f_p'(t) \text{:}""",
      r"""
  \begin{aligned}
  f_p'(t) &= 3\cos(3t) + 3\sin(3t)
  \end{aligned}
  """,
      r"""\text{Thus,}""",
      r"""
  \begin{aligned}
  g'(0) &= f'(0) - f_p'(0) \\[5pt]
  &= 0 - \left(3\cos(0) + 3\sin(0)\right) \\[5pt]
  &= -3
  \end{aligned}
  """,
      r"""\textcolor{green}{4.\ } \textcolor{green}{Apply\ formula\ from\ Problem\ 12\ to\ find\ \ g(t)}""",
      r"""\text{For } g''(t) + 2g'(t) + 3g(t) = 0 \text{, apply formula for discharging RLC circuit as per strategy.}""",
      r"""\text{From Problem 12: } g(t) = e^{-\beta t}\left(g(0)\cos(\sqrt{\omega_0^2-\beta^2}t) + \frac{g'(0)+\beta g(0)}{\sqrt{\omega_0^2-\beta^2}}\sin(\sqrt{\omega_0^2-\beta^2}t)\right)""",
      r"""
  \begin{aligned}
  g(t) &=  e^{-\beta t}\left(g(0)\cos(\sqrt{\omega_0^2-\beta^2}t) + \frac{g'(0)+\beta g(0)}{\sqrt{\omega_0^2-\beta^2}}\sin(\sqrt{\omega_0^2-\beta^2}t)\right)\\[5pt]
  &= e^{-t}\left(1 \cdot \cos(\sqrt{2}t) + \frac{-3 + 1 \cdot 1}{\sqrt{2}}\sin(\sqrt{2}t)\right) \\[5pt]
  &= e^{-t}\left(\cos(\sqrt{2}t) + \frac{-2}{\sqrt{2}}\sin(\sqrt{2}t)\right) \\[5pt]
  &= e^{-t}\left(\cos(\sqrt{2}t) - \sqrt{2}\sin(\sqrt{2}t)\right)
  \end{aligned}
  """,
      r"""\textcolor{green}{5.\ } \textcolor{green}{Find\ \ f(t)\ \ by\ combining\ \ g(t)\ \ and\ particular\ solution}""",
      r"""
  \begin{aligned}
  f(t) &= g(t) + f_p(t)\\[5pt]
  &= e^{-t}\left(\cos(\sqrt{2}t) - \sqrt{2}\sin(\sqrt{2}t)\right) + \sqrt{2}\sin\left(3t - \frac{\pi}{4}\right)
  \end{aligned}
  """,
      r"""\text{And } f'(t) \text{ is:}""",
      r"""
  \begin{aligned}
    f'(t) &=  \left[e^{-t}\left(\cos(\sqrt{2}t) - \sqrt{2}\sin(\sqrt{2}t)\right) + \sqrt{2}\sin\left(3t - \frac{\pi}{4}\right)\right]'\\[8pt]
    &= -e^{-t}\left(\cos(\sqrt{2}t) - \sqrt{2}\sin(\sqrt{2}t)\right) \\
    &+ \ e^{-t}\left(-\sqrt{2}\cos(\sqrt{2}t) - 2\sin(\sqrt{2}t)\right) + 3\sqrt{2}\cos\left(3t - \frac{\pi}{4}\right)\\[8pt]
    &= e^{-t}\left(\left(-1 - \sqrt{2}\right)\cos(\sqrt{2}t) + \left(-2 + \sqrt{2}\right)\sin(\sqrt{2}t)\right) \\
    &+ 3\sqrt{2}\cos\left(3t - \frac{\pi}{4}\right)
  \end{aligned}
  """,
      r"""\textcolor{green}{6.\ } \textcolor{green}{Steady-state\ solution}""",
      r"""\text{After sufficient time, the transient term in }f(t)\text{ decays:}""",
      r"""\lim_{t\to\infty} e^{-t}\left(\cos(\sqrt{2}t)-\sqrt{2}\sin(\sqrt{2}t)\right)=0\text{.}""",
      r"""\text{Therefore, in steady state, } f(t)\fallingdotseq f_p(t)\text{.}""",
      r"""f(t) \fallingdotseq f_p(t)=\sqrt{2}\sin\left(3t-\frac{\pi}{4}\right)\text{.}""",
      r"""\text{Likewise, the steady-state derivative satisfies } f'(t)\fallingdotseq f_p'(t)\text{.}""",
      r"""\begin{aligned}
\textcolor{blue}{f'(t)\ \fallingdotseq\ f_p'(t)} &= \left[\sqrt{2}\sin\left(3t-\frac{\pi}{4}\right)\right]'\\[5pt]
&= 3\sqrt{2}\cos\left(3t-\frac{\pi}{4}\right)
\end{aligned}""",
      r"""\text{So the steady-state current is } \textcolor{blue}{f'(t)\approx 3\sqrt{2}\cos\left(3t-\frac{\pi}{4}\right)}\text{.}""",
      r"""\text{The amplitude of the steady-state }f'(t)\text{ is } f'_{\max}=3\sqrt{2}\text{.}""",
      r"""\textcolor{green}{7.\ } \textcolor{green}{Ratio\ of\ } \textcolor{green}{F} \textcolor{green}{to\ the\ steady-state\ amplitude\ of\ } \textcolor{green}{f'(t)}""",
      r"""\frac{F}{f'_{\max}}=\frac{12}{3\sqrt{2}}=\frac{4}{\sqrt{2}}=2\sqrt{2}\text{.}""",
      r"""\text{This matches the impedance magnitude }|Z| \text{ in the circuit correspondence.}""",
    ],
  ),

  // rlc_series_voltage_underdamped_problems.dart (numeric)
  "E32CEEE3-F0E5-44C6-838C-7BEF0531E460": ProblemTranslation(
    category: 'Numerical - 2nd Order - Non-homogeneous',
    level: 'Advanced',
    hint: r"""\text{In steady state, the transient (decaying) terms vanish; compute a particular solution and differentiate to obtain the steady-state }f'(t)\text{.}""",
    steps: [
      r"""\textcolor{brown}{\large{[Electromagnetism]}}""",
      r"""\text{• For an RLC series AC circuit, Kirchhoff's second law gives }
LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = V_0\cos(\omega_0 t) \text{. }\textcolor{purple}{In\ this\ problem,\ the\ resonance\ condition\ }""",
      r"""\textcolor{purple}{\omega = \omega_0 = \sqrt{\frac{1}{LC}}}\textcolor{purple}{\ holds.}""",
      r"""\textcolor{brown}{\large{[Correspondence:\ Problem\ vs\ Electromagnetism]}}""",
      r"""\text{Transient response (resonance) of an RLC series AC circuit:} \ LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = V_0\cos(\omega_0 t)""",
      r"""\text{• } f(t) \leftrightarrow Q(t) \text{ (charge stored in capacitor)}""",
      r"""\text{• } f'(t) \leftrightarrow Q'(t) \text{ (current)}""",
      r"""\text{• } f''(t) \leftrightarrow Q''(t) \text{ (rate of current change)}""",
      r"""\text{• } \dfrac{2}{2 \cdot 1} = 1 \leftrightarrow \displaystyle \frac{R}{2L} \text{ (damping constant)}""",
      r"""\text{• } \dfrac{1}{\sqrt{1 \cdot \frac{1}{4}}} = 2 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{ (natural angular frequency when damping is 0)}""",
      r"""\text{• } \sqrt{\frac{1}{1 \cdot \frac{1}{4}} - \left(\frac{2}{2 \cdot 1}\right)^2} = \sqrt{3} \leftrightarrow \sqrt{\displaystyle \frac{1}{LC} - \left(\displaystyle \frac{R}{2L}\right)^2} \text{ (damped angular frequency)}""",
      r"""\text{• } 20 \leftrightarrow V_0 \text{ (voltage amplitude)}""",
      r"""\text{• } 2 \leftrightarrow \omega \text{ (AC voltage frequency)}""",
      r"""\text{• Impedance (ratio of }F\text{ to the steady-state amplitude of }f'(t)\text{): } \displaystyle \frac{F}{f'_{\max}} = \sqrt{\left(\frac{4}{2} - 1 \cdot 2\right)^2+4 \cdot 1^2} = 2 """,
      r"""\leftrightarrow  |Z| = \frac {V_0}{I_{\max}} = {\sqrt{\left(\frac{1}{\omega C} - \omega L \right) ^2 + R^2}}""",
      r"""\text{• Phase difference between steady-state }f'(t)\text{ and RHS }20\cos(2t)\text{: } \phi = 0 \text{ (in-phase)} \left( \tan \phi  = \frac{2 \cdot 1 - \frac {1} {2 \cdot \frac{1}{4}}} {2} = 0 \right)""",
      r""" \leftrightarrow \tan \phi = \frac{\omega L -\frac{1}{\omega C}}{R} = 0 \text{ (phase difference between current and voltage)}""",
      r"""\text{• } 0 \leftrightarrow Q_0 \text{ (initial charge)}""",
      r"""\text{• } 0 \leftrightarrow I_0 \text{ (initial current)}""",
      r"""\textcolor{brown}{\large{[Solution]}}""",
      r"""\textbf{[Strategy]}""",
      r"""\text{Find a particular solution by the method of undetermined coefficients, define a new function by subtracting it, and apply the formula for the homogeneous case (RHS = 0) from Problem 12. Note that here the resonance condition } \omega = \sqrt{\frac{\gamma}{\alpha}} = 2 \text{ holds.}""",
      r"""\textcolor{blue}{The\ solution\ to\ the\ initial\ value\ problem\ for\ } \textcolor{blue}{f''(t) + 2\beta f'(t) + \omega_0^2 f(t) = 0} \textcolor{blue}{\ with\ } \textcolor{blue}{f(0)\ =\ f_0,\quad\ f'(0)\ =\ v_0} \textcolor{blue}{\ is\ (Problem\ 12):}""",
      r"""\textcolor{blue}{f(t) = e^{-\beta t}\left(f_0\cos\left(\sqrt{\omega_0^2-\beta^2}\ \,t\right) + \frac{v_0+\beta f_0}{\sqrt{\omega_0^2-\beta^2}}\sin\left(\sqrt{\omega_0^2-\beta^2}\ \,t\right)\right)}""",
      r"""\textcolor{green}{1.\ } \textcolor{green}{Find\ a\ particular\ solution}""",
      r"""\text{Based on the RHS }20\cos(2t)\text{, guess a particular solution of the form}""",
      r"""f_p(t) = A\sin(\omega t) + B\cos(\omega t) \text{, where }A,B\text{ are constants and }\omega=2\text{.}""",
      r"""\text{First, differentiate }f_p(t)\text{:}""",
      r"""
  \begin{aligned}
  \begin{cases}
  f_p'(t) = \omega A\cos(\omega t) - \omega B\sin(\omega t) \\[5pt]
  f_p''(t) = -\omega^2 A\sin(\omega t) - \omega^2 B\cos(\omega t)
  \end{cases}
  \end{aligned}
  """,
      r"""\text{Substitute into }f_p''(t) + 2f_p'(t) + 4f_p(t) = 20\cos(2t)\cdots (1)""",
      r"""\text{and compare the coefficients of }\sin\text{ and }\cos\text{.}""",
      r"""
  \begin{aligned}
  f_p''(t) + 2f_p'(t) + 4f_p(t) &= (-4A\sin(2t) - 4B\cos(2t)) + 2(2A\cos(2t) - 2B\sin(2t)) \\[5pt]
  &\quad + 4(A\sin(2t) + B\cos(2t)) \\[5pt]
  &= (-4B)\sin(2t) + (4A)\cos(2t) \\[5pt]
  &= 20\cos(2t)
  \end{aligned}
  """,
      r"""\text{Comparing coefficients on both sides:}""",
      r"""\text{sin coefficient: }-4B = 0""",
      r"""\text{cos coefficient: }4A = 20""",
      r"""\text{Solving gives }A=5,\ B=0\text{.}""",
      r"""\text{Thus the particular solution is}""",
      r"""
  f_p(t) = 5\sin(2t)
  """,
      r"""\textcolor{green}{2.} \textcolor{green}{Let\ } \textcolor{green}{g(t)=f(t)-f_p(t)}\textcolor{green}{.\ Then}""",
      r"""\textcolor{green}{g(t)} \textcolor{green}{\ is\ a\ solution\ to\ } \textcolor{green}{g''(t)+2g'(t)+4g(t)=0}\textcolor{green}{.}""",
      r"""Since \(f_p(t)\) satisfies \(f_p''(t)+2f_p'(t)+4f_p(t)=20\cos(2t)\), subtract it from the original equation.""",
      r"""\text{Subtracting gives}""",
      r"""
  \begin{aligned}
  &\quad f''(t) + 2f'(t) + 4f(t) = 20\cos(2t) \\
  -&\quad f_p''(t) + 2f_p'(t) + 4f_p(t) = 20\cos(2t) \\[5pt]
  \hline \\
  &\quad (f''(t) - f_p''(t)) + 2(f'(t) - f_p'(t)) + 4(f(t) - f_p(t)) = 0
  \end{aligned}
  """,
      r"""\text{Thus, letting } g(t)=f(t)-f_p(t)\text{, we obtain } g''(t)+2g'(t)+4g(t)=0\text{.}""",
      r"""\textcolor{blue}{That\ is,\ } \textcolor{blue}{g(t)} \textcolor{blue}{\ solves\ the\ homogeneous\ equation\ } \textcolor{blue}{g''(t)+2g'(t)+4g(t)=0}\textcolor{blue}{.}""",
      r"""\textcolor{green}{3.\ } \textcolor{green}{Find\ initial\ conditions\ for\ } \textcolor{green}{g}""",
      r"""\text{From } f_p(t)=5\sin(2t)\text{:}""",
      r"""
  \begin{aligned}
  g(0) &= f(0) - f_p(0) \\[5pt]
  &= 0 - 5\sin(0) \\[5pt]
  &= 0
  \end{aligned}
  """,
      r"""\text{Next, compute } f_p'(t)\text{:}""",
      r"""
  \begin{aligned}
  f_p'(t) &= 5 \cdot 2\cos(2t) = 10\cos(2t)
  \end{aligned}
  """,
      r"""\text{Therefore,}""",
      r"""
  \begin{aligned}
  g'(0) &= f'(0) - f_p'(0) \\[5pt]
  &= 0 - 10\cos(0) \\[5pt]
  &= -10
  \end{aligned}
  """,
      r"""\textcolor{green}{4.\ } \textcolor{green}{Apply\ the\ formula\ from\ Problem\ 12\ to\ find\ } \textcolor{green}{g(t)}""",
      r"""\text{For }g''(t)+2g'(t)+4g(t)=0\text{, apply the discharging RLC formula as planned.}""",
      r"""\text{From Problem 12: } g(t) = e^{-\beta t}\left(g(0)\cos(\sqrt{\omega_0^2-\beta^2}t) + \frac{g'(0)+\beta g(0)}{\sqrt{\omega_0^2-\beta^2}}\sin(\sqrt{\omega_0^2-\beta^2}t)\right)""",
      r"""\text{Substitute } \beta=1,\ \omega_0^2=4,\ g(0)=0,\ g'(0)=-10\text{:}""",
      r"""
  \begin{aligned}
  g(t) &=  e^{-\beta t}\left(g(0)\cos(\sqrt{\omega_0^2-\beta^2}t) + \frac{g'(0)+\beta g(0)}{\sqrt{\omega_0^2-\beta^2}}\sin(\sqrt{\omega_0^2-\beta^2}t)\right)\\[5pt]
  &= e^{-t}\left(0 \cdot \cos(\sqrt{3}t) + \frac{-10 + 1 \cdot 0}{\sqrt{3}}\sin(\sqrt{3}t)\right) \\[5pt]
  &= e^{-t}\left(-\frac{10}{\sqrt{3}}\sin(\sqrt{3}t)\right)
  \end{aligned}
  """,
      r"""\textcolor{green}{5.\ } \textcolor{green}{Combine\ } \textcolor{green}{g(t)} \textcolor{green}{\ and\ } \textcolor{green}{f_p(t)} \textcolor{green}{\ to\ get\ } \textcolor{green}{f(t)}""",
      r"""
  \begin{aligned}
  f(t) &= g(t) + f_p(t)\\[5pt]
  &= e^{-t}\left(-\frac{10}{\sqrt{3}}\sin(\sqrt{3}t)\right) + 5\sin(2t)
  \end{aligned}
  """,
      r"""\text{Also, } f'(t)\text{ is}""",
      r"""
  \begin{aligned}
    f'(t) &=  \left[e^{-t}\left(-\frac{10}{\sqrt{3}}\sin(\sqrt{3}t)\right) + 5\sin(2t)\right]'\\[8pt]
    &= -e^{-t}\left(-\frac{10}{\sqrt{3}}\sin(\sqrt{3}t)\right) + e^{-t}\left(-\frac{10}{\sqrt{3}} \cdot \sqrt{3}\cos(\sqrt{3}t)\right) + 5 \cdot 2\cos(2t)\\[8pt]
    &= e^{-t}\left(\frac{10}{\sqrt{3}}\sin(\sqrt{3}t) - 10\cos(\sqrt{3}t)\right) + 10\cos(2t)
  \end{aligned}
  """,
      r"""\textcolor{green}{6.\ } \textcolor{green}{Steady-state\ solution}""",
      r"""\text{Now find the steady state.}""",
      r"""\text{After sufficient time, the steady-state form is:}""",
      r"""\lim_{t \to \infty} e^{-t}\left(-\frac{10}{\sqrt{3}}\sin(\sqrt{3}t)\right) = 0 \text{, so}""",
      r"""f(t) \fallingdotseq f_p(t) = 5\sin(2t)""",
      r"""\text{and the steady-state }f'(t)\text{ is}""",
      r"""
  \begin{aligned}
  f'(t) \fallingdotseq f'_p(t) = \left[5\sin(2t)\right]' = 10\cos(2t)
  \end{aligned}
  """,
      r"""\text{(steady-state approximation).}""",
      r"""\textcolor{green}{7.\ } \textcolor{green}{Ratio\ of\ steady-state\ } \textcolor{green}{f'(t)} \textcolor{green}{\ and\ } \textcolor{green}{F}""",
      r"""\text{The ratio of the steady-state amplitude of }f'(t)\text{ to }F\text{ is } \displaystyle \dfrac{F}{f'_{\max}} = \frac{20}{10} = 2\text{.}""",
      r"""\text{Comparing phases, the phase } \omega t \text{ of the steady-state solution matches the phase } \omega t \text{ of the RHS }20\cos(2t)\text{ (in-phase).}""",
    ],
  ),
};
