// lib/data/congruence_equations/congruence_equations.dart
// 合同方程式問題データ（性質の証明つき・丁寧版）
//
// 変更点：
// - 「k ∈ Z」表記をやめ、すべて「〜となる整数kが存在する」に統一
// - 「性質（証明）」部分は StepItem を細かく分割してこまめに改行
// - 改行を含むTeXは r"""...""" を使用

import '../../models/step_item.dart';

/// 合同方程式問題
class CongruenceProblem {
  final String id;
  final int no;
  final String question; // 例: "2 x ≡ 5 (mod 7)"
  final String answer; // 例: "6 (mod 7 での解)"
  final int modulus; // 例: 7
  final int? coefficient; // 例: 2 (オプショナル)
  final int? constant; // 例: 5 (オプショナル)
  final String? shortExplanation; // ワンフレーズ解説（オプショナル）
  final List<StepItem>? detailedExplanation; // 詳細解説（StepItemの配列）
  final String? equation; // 中国剰余定理などで使用（オプショナル）
  final String? conditions; // 中国剰余定理などで使用（オプショナル）

  const CongruenceProblem({
    required this.id,
    required this.no,
    required this.question,
    required this.answer,
    required this.modulus,
    this.coefficient,
    this.constant,
    this.shortExplanation,
    this.detailedExplanation,
    this.equation,
    this.conditions,
  });
}

/// 合同方程式問題リスト（ガチャ用）
const congruenceGachaProblems = <CongruenceProblem>[
  // === 問題 1: 17x ≡ 1 (mod 83) ===
  CongruenceProblem(
    id: "589F2436-BB04-435D-B720-66AF8D16F9CB",
    no: 1,
    question: r"17x \equiv 1 \pmod{83}",
    answer: r"x \equiv 44 \pmod{83}",
    modulus: 83,
    shortExplanation: r"""\text{互除法で }17x+83y=1\text{ を作り、}x\text{ を読む。}""",
    detailedExplanation: [
      StepItem(tex: r"\color{black}\textbf{【ステップ1】}"),
      StepItem(tex: r"\color{black}\text{合同式 }17x\equiv1\pmod{83}\text{ は、}17x-1\text{ が }83\text{ の倍数という意味。}"),
      StepItem(tex: r"\color{black}\text{つまり、}17x-1=83k\text{ となる整数 }k\text{ が存在する。}"),
      StepItem(tex: r"\color{black}\text{よって }17x+83(-k)=1\text{。}y=-k\text{ とおけば }17x+83y=1\text{ の形になる。}"),
      StepItem(tex: r"\color{black}\text{結局、}17x+83y=1\text{ を満たす整数 }x\text{ を見つければよい。}"),

      StepItem(tex: r"\color{black}\textbf{【ステップ2：互除法】}"),
      StepItem(tex: r"\color{black}83=17\cdot4+15"),
      StepItem(tex: r"\color{black}17=15\cdot1+2"),
      StepItem(tex: r"\color{black}15=2\cdot7+1"),

      StepItem(tex: r"\color{black}\textbf{【ステップ3：逆にたどる】}"),
      StepItem(tex: r"""\color{black}\begin{aligned}
1&=15-2\cdot7\\
&=15-(17-15)\cdot7\\
&=15\cdot8-17\cdot7\\
&=(83-17\cdot4)\cdot8-17\cdot7\\
&=83\cdot8-17\cdot39
\end{aligned}"""),

      StepItem(tex: r"\color{black}\textbf{【結論】}"),
      StepItem(tex: r"\color{black}83\cdot8-17\cdot39=1"),
      StepItem(tex: r"\color{black}\Rightarrow\ 17\cdot(-39)\equiv1\pmod{83}"),
      StepItem(tex: r"\color{black}-39\equiv83-39=44\pmod{83}"),
      StepItem(tex: r"\color{black}\boxed{x\equiv44\pmod{83}}"),
    ],
  ),

  // ─────────────────────────────────────────────
  // 問題 2: 37x ≡ 10 (mod 73)
  // ─────────────────────────────────────────────
  CongruenceProblem(
    id: "BC4D9736-23D1-4390-B628-C2ADFC23CC06",
    no: 2,
    question: r"37x \equiv 10 \pmod{73}",
    answer: r"x \equiv 20 \pmod{73}",
    modulus: 73,
    coefficient: 37,
    constant: 10,
    shortExplanation: r"""\text{両辺を2倍して }74x\equiv20,\ 74=73+1\text{ を使う。}""",
    detailedExplanation: [
      StepItem(tex: r"\color{black}\textbf{【ステップ1：両辺を2倍】}"),
      StepItem(tex: r"\color{black}37x\equiv10\pmod{73}"),
      StepItem(tex: r"\color{black}\Rightarrow\ 2\cdot37x\equiv2\cdot10\pmod{73}"),
      StepItem(tex: r"\color{black}\Rightarrow\ 74x\equiv20\pmod{73}"),

      StepItem(tex: r"\color{black}\textbf{【ステップ2：}74\equiv1\pmod{73}\text{ を使う】}"),
      StepItem(tex: r"\color{black}74-1=73\text{ は }73\text{ の倍数}"),
      StepItem(tex: r"\color{black}\Rightarrow\ 74\equiv1\pmod{73}"),
      StepItem(tex: r"\color{black}\Rightarrow\ 74x\equiv1\cdot x\equiv x\pmod{73}"),
      StepItem(tex: r"\color{black}\boxed{x\equiv20\pmod{73}}"),

      StepItem(tex: r"\color{black}\textbf{【この問題で使った合同の性質（証明）】}"),

      StepItem(tex: r"\color{black}\textbf{(性質A)}\ a\equiv b\pmod{m}\Rightarrow a-b=km\text{ となる整数 }k\text{ が存在する。}"),
      StepItem(tex: r"\color{black}\text{（定義）}a\equiv b\pmod{m}\text{ とは }m\mid(a-b)\text{ のこと。}"),
      StepItem(tex: r"\color{black}\text{よって }a-b\text{ は }m\text{ の倍数なので、}a-b=km\text{ となる整数 }k\text{ が存在する。}"),

      StepItem(tex: r"\color{black}\textbf{(性質B)}\ a\equiv b\pmod{m}\Rightarrow ca\equiv cb\pmod{m}."),
      StepItem(tex: r"\color{black}a\equiv b\pmod{m}\Rightarrow a-b=km\text{ となる整数 }k\text{ が存在する。}"),
      StepItem(tex: r"\color{black}\text{両辺に }c\text{ を掛けると }c(a-b)=ckm"),
      StepItem(tex: r"\color{black}\Rightarrow\ ca-cb=(ck)m"),
      StepItem(tex: r"\color{black}\Rightarrow\ ca-cb\text{ は }m\text{ の倍数}"),
      StepItem(tex: r"\color{black}\Rightarrow\ ca\equiv cb\pmod{m}"),

      StepItem(tex: r"\color{black}\textbf{(性質C)}\ a\equiv b\pmod{m},\ c\equiv d\pmod{m}\Rightarrow ac\equiv bd\pmod{m}."),
      StepItem(tex: r"\color{black}\text{証明：}ac-bd=(ac-ad)+(ad-bd)=a(c-d)+d(a-b)"),
      StepItem(tex: r"\color{black}a-b\text{ は }m\text{ の倍数、}c-d\text{ も }m\text{ の倍数}"),
      StepItem(tex: r"\color{black}\Rightarrow\ a(c-d),\ d(a-b)\text{ も }m\text{ の倍数}"),
      StepItem(tex: r"\color{black}\Rightarrow\ ac-bd\text{ も }m\text{ の倍数}"),
      StepItem(tex: r"\color{black}\Rightarrow\ ac\equiv bd\pmod{m}"),
    ],
  ),

  // // ─────────────────────────────────────────────
  // // 問題 3: 50x ≡ 25 (mod 131)
  // // ─────────────────────────────────────────────
  // CongruenceProblem(
  //   id: "99634967-B37E-47F2-B477-719B353D6A92",
  //   no: 3,
  //   question: r"50x \equiv 25 \pmod{131}",
  //   answer: r"x \equiv 66 \pmod{131}",
  //   modulus: 131,
  //   coefficient: 50,
  //   constant: 25,
  //   shortExplanation: r"""\text{ }2x\equiv1\text{ に直し、}2\cdot66\equiv1\text{ を使う。}""",
  //   detailedExplanation: [
  //     StepItem(tex: r"\color{black}\textbf{【ステップ1】}"),
  //     StepItem(tex: r"\color{black}50x\equiv25\pmod{131}"),
  //     StepItem(tex: r"\color{black}\Rightarrow\ 2x\equiv1\pmod{131}"),
  //     StepItem(tex: r"\color{black}\text{（理由：}50x\equiv25\text{ を }25\text{ で割る操作は、後の性質で正当化する。）}"),

  //     StepItem(tex: r"\color{black}\textbf{【ステップ2】}"),
  //     StepItem(tex: r"\color{black}2\cdot66=132=131+1"),
  //     StepItem(tex: r"\color{black}\Rightarrow\ 2\cdot66\equiv1\pmod{131}"),

  //     StepItem(tex: r"\color{black}\textbf{【結論】}"),
  //     StepItem(tex: r"\color{black}2x\equiv1\pmod{131}\ \text{の両辺に }66\text{ を掛ける}"),
  //     StepItem(tex: r"\color{black}\Rightarrow\ x\equiv66\pmod{131}"),
  //     StepItem(tex: r"\color{black}\boxed{x\equiv66\pmod{131}}"),

  //     StepItem(tex: r"\color{black}\textbf{【この問題で使った合同の性質（証明）】}"),
  //     StepItem(tex: r"\color{black}\textbf{(性質D)}\ ac\equiv bc\pmod{m}\ \text{かつ }\gcd(c,m)=1\Rightarrow a\equiv b\pmod{m}."),
  //     StepItem(tex: r"\color{black}\text{（言い換え）}c\text{ が }m\text{ と共通の割り切れる数を持たないとき、}"),
  //     StepItem(tex: r"\color{black}\text{両辺から }c\text{ を「消しても」合同が保たれる。}"),
  //     StepItem(tex: r"\color{black}\text{証明：}\gcd(c,m)=1\text{ なら、}ct+ms=1\text{ となる整数 }t,s\text{ が存在（ベズー）。}"),
  //     StepItem(tex: r"\color{black}\text{これを }m\text{ で見ると }ct\equiv1\pmod{m}\text{（}c\text{ に }t\text{ を掛けると }1\text{ 余る）。}"),
  //     StepItem(tex: r"\color{black}ac\equiv bc\pmod{m}\text{ の両辺に }t\text{ を掛けると}"),
  //     StepItem(tex: r"\color{black}a(ct)\equiv b(ct)\pmod{m}"),
  //     StepItem(tex: r"\color{black}ct\equiv1\pmod{m}\text{ より }a\equiv b\pmod{m}."),
  //   ],
  // ),

  // ─────────────────────────────────────────────
  // 問題 4: x + 37 ≡ 10 (mod 73)
  // ─────────────────────────────────────────────
  CongruenceProblem(
    id: "865BAE3D-3F02-46EF-946D-A86D1E370C3D",
    no: 4,
    question: r"x + 37 \equiv 10 \pmod{73}",
    answer: r"x \equiv 46 \pmod{73}",
    modulus: 73,
    shortExplanation: r"""\text{両辺から37を引き、余りを }0\sim72\text{ に直す。}""",
    detailedExplanation: [
      StepItem(tex: r"\color{black}\textbf{【ステップ1】}"),
      StepItem(tex: r"\color{black}x+37\equiv10\pmod{73}"),
      StepItem(tex: r"\color{black}\Rightarrow\ x\equiv10-37\pmod{73}"),
      StepItem(tex: r"\color{black}\Rightarrow\ x\equiv-27\pmod{73}"),

      StepItem(tex: r"\color{black}\textbf{【ステップ2】}"),
      StepItem(tex: r"\color{black}-27\equiv73-27=46\pmod{73}"),
      StepItem(tex: r"\color{black}\boxed{x\equiv46\pmod{73}}"),

      StepItem(tex: r"\color{black}\textbf{【この問題で使った合同の性質（証明）】}"),
      StepItem(tex: r"\color{black}\textbf{(性質E)}\ a\equiv b\pmod{m}\Rightarrow a+c\equiv b+c\pmod{m}."),
      StepItem(tex: r"\color{black}a\equiv b\pmod{m}\Rightarrow a-b=km\text{ となる整数 }k\text{ が存在する。}"),
      StepItem(tex: r"\color{black}\text{両辺に }c\text{ を足すと }(a+c)-(b+c)=a-b=km"),
      StepItem(tex: r"\color{black}\Rightarrow\ (a+c)-(b+c)\text{ は }m\text{ の倍数}"),
      StepItem(tex: r"\color{black}\Rightarrow\ a+c\equiv b+c\pmod{m}."),
    ],
  ),

  // ─────────────────────────────────────────────
  // 問題 5: 37x + 10 ≡ 20 (mod 73)
  // ─────────────────────────────────────────────
  CongruenceProblem(
    id: "1D7448B8-C101-4EFA-8066-B3B65CD986E0",
    no: 5,
    question: r"37x + 10 \equiv 20 \pmod{73}",
    answer: r"x \equiv 20 \pmod{73}",
    modulus: 73,
    shortExplanation: r"""\text{ }37x\equiv10\text{ にして、}37\cdot2\equiv1\text{ を使う。}""",
    detailedExplanation: [
      StepItem(tex: r"\color{black}\textbf{【ステップ1】}"),
      StepItem(tex: r"\color{black}37x+10\equiv20\pmod{73}"),
      StepItem(tex: r"\color{black}\Rightarrow\ 37x\equiv10\pmod{73}"),

      StepItem(tex: r"\color{black}\textbf{【ステップ2】}"),
      StepItem(tex: r"\color{black}37\cdot2=74=73+1"),
      StepItem(tex: r"\color{black}\Rightarrow\ 37\cdot2\equiv1\pmod{73}"),
      StepItem(tex: r"\color{black}\text{（つまり }37\text{ に }2\text{ を掛けると }1\text{ 余る）}"),

      StepItem(tex: r"\color{black}\textbf{【ステップ3】}"),
      StepItem(tex: r"\color{black}37x\equiv10\pmod{73}\text{の両辺に }2\text{ を掛ける}"),
      StepItem(tex: r"\color{black}\Rightarrow\ 74x\equiv20\pmod{73}"),
      StepItem(tex: r"\color{black}74\equiv1\pmod{73}\Rightarrow x\equiv20\pmod{73}"),
      StepItem(tex: r"\color{black}\boxed{x\equiv20\pmod{73}}"),

      StepItem(tex: r"\color{black}\textbf{【この問題で使った合同の性質（証明）】}"),
      StepItem(tex: r"\color{black}\textbf{(性質F)}\ a\equiv b\pmod{m}\Rightarrow a-c\equiv b-c\pmod{m}."),
      StepItem(tex: r"\color{black}a\equiv b\pmod{m}\Rightarrow a-b=km\text{ となる整数 }k\text{ が存在する。}"),
      StepItem(tex: r"\color{black}\text{すると }(a-c)-(b-c)=a-b=km"),
      StepItem(tex: r"\color{black}\Rightarrow\ (a-c)-(b-c)\text{ は }m\text{ の倍数}"),
      StepItem(tex: r"\color{black}\Rightarrow\ a-c\equiv b-c\pmod{m}."),
    ],
  ),


  // ─────────────────────────────────────────────
  // 問題 11: x ≡ 82^41 (mod 83)
  // ─────────────────────────────────────────────
  CongruenceProblem(
    id: "C39FE68B-06CE-490F-8CBE-FF903AE1B051",
    no: 11,
    question: r"x \equiv 82^{41} \pmod{83}",
    answer: r"x \equiv 82 \pmod{83}",
    modulus: 83,
    shortExplanation: r"""82 \equiv -1 \pmod{83}\text{ を利用する。}""",
    detailedExplanation: [
      StepItem(tex: r"\color{black}\textbf{【ステップ1】}"),
      StepItem(tex: r"\color{black}82=83-1\Rightarrow 82\equiv-1\pmod{83}"),
      StepItem(tex: r"\color{black}\textbf{【ステップ2】}"),
      StepItem(tex: r"\color{black}\text{両辺を }41\text{ 乗すると}"),
      StepItem(tex: r"\color{black}82^{41}\equiv(-1)^{41}\pmod{83}"),
      StepItem(tex: r"\color{black}\textbf{【ステップ3】}"),
      StepItem(tex: r"\color{black}(-1)^{41}=-1\ (\text{奇数乗})"),
      StepItem(tex: r"\color{black}\Rightarrow\ 82^{41}\equiv-1 \equiv 82\pmod{83}"),
      StepItem(tex: r"\color{black}\boxed{x\equiv82\pmod{83}}"),

      StepItem(tex: r"\color{black}\textbf{【この問題で使った合同の性質（証明）】}"),
      StepItem(tex: r"\color{black}\textbf{(性質G)}\ a\equiv b\pmod{m}\Rightarrow a^n\equiv b^n\pmod{m}\ (n\text{は自然数})"),
      StepItem(tex: r"\color{black}\text{（証明は問題6の性質Gと同様）}"),
    ],
  ),


  // ─────────────────────────────────────────────
  // 問題 6: x ≡ 3^143 (mod 71)（フェルマー）
  // ─────────────────────────────────────────────
  // CongruenceProblem(
  //   id: "3E7D7EAE-16FB-4DEC-9FD4-D7073A5BC814",
  //   no: 6,
  //   question: r"x \equiv 3^{143} \pmod{71}",
  //   answer: r"x \equiv 27 \pmod{71}",
  //   modulus: 71,
  //   shortExplanation: r"""\text{素数 }71\text{ では }3^{70}\equiv1,\ 143=70\cdot2+3\text{。}""",
  //   detailedExplanation: [
  //     StepItem(tex: r"\color{black}\textbf{【ステップ1】}"),
  //     StepItem(tex: r"\color{black}\text{（補足で示す）素数 }71\text{ に対し }3^{70}\equiv1\pmod{71}"),

  //     StepItem(tex: r"\color{black}\textbf{【ステップ2】}"),
  //     StepItem(tex: r"\color{black}143=70\cdot2+3"),
  //     StepItem(tex: r"\color{black}\Rightarrow\ 3^{143}=(3^{70})^2\cdot3^3"),
  //     StepItem(tex: r"\color{black}\Rightarrow\ 3^{143}\equiv1^2\cdot27\equiv27\pmod{71}"),
  //     StepItem(tex: r"\color{black}\boxed{x\equiv27\pmod{71}}"),

  //     StepItem(tex: r"\color{black}\textbf{【この問題で使った合同の性質（証明）】}"),
  //     StepItem(tex: r"\color{black}\textbf{(性質G)}\ a\equiv b\pmod{m}\Rightarrow a^n\equiv b^n\pmod{m}\ (n\text{は自然数})."),
  //     StepItem(tex: r"\color{black}a\equiv b\pmod{m}\Rightarrow a-b=km\text{ となる整数 }k\text{ が存在する。}"),
  //     StepItem(tex: r"\color{black}\text{そして }a^n-b^n=(a-b)(a^{n-1}+a^{n-2}b+\cdots+b^{n-1})"),
  //     StepItem(tex: r"\color{black}\text{右辺は }(a-b)\text{ を因数にもつので、}a^n-b^n\text{ も }m\text{ の倍数}"),
  //     StepItem(tex: r"\color{black}\Rightarrow\ a^n\equiv b^n\pmod{m}."),
  //   ],
  // ),

  // ─────────────────────────────────────────────
  // 問題 8: x ≡ 3^62 (mod 77)（オイラー）
  // ─────────────────────────────────────────────
  // CongruenceProblem(
  //   id: "38FE1005-F5FD-4AF1-9FEE-E659BDFF657E",
  //   no: 8,
  //   question: r"x \equiv 3^{62} \pmod{77}",
  //   answer: r"x \equiv 9 \pmod{77}",
  //   modulus: 77,
  //   shortExplanation: r"""\gcd(3,77)=1,\ \varphi(77)=60\text{ より }3^{60}\equiv1. """,
  //   detailedExplanation: [
  //     StepItem(tex: r"\color{black}\textbf{【ステップ1：}\varphi(77)\text{】}"),
  //     StepItem(tex: r"\color{black}77=7\cdot11"),
  //     StepItem(tex: r"\color{black}\Rightarrow\ \varphi(77)=77\left(1-\frac17\right)\left(1-\frac{1}{11}\right)=60"),

  //     StepItem(tex: r"\color{black}\textbf{【ステップ2：指数分解】}"),
  //     StepItem(tex: r"\color{black}62=60+2"),
  //     StepItem(tex: r"\color{black}\Rightarrow\ 3^{62}=3^{60}\cdot3^2"),

  //     StepItem(tex: r"\color{black}\textbf{【結論】}"),
  //     StepItem(tex: r"\color{black}3^{60}\equiv1\pmod{77}"),
  //     StepItem(tex: r"\color{black}\Rightarrow\ 3^{62}\equiv1\cdot9\equiv9\pmod{77}"),
  //     StepItem(tex: r"\color{black}\boxed{x\equiv9\pmod{77}}"),

  //     StepItem(tex: r"\color{black}\textbf{【補足：オイラーの定理（並べ替え＋積）】}"),
  //     StepItem(tex: r"\color{black}\text{主張：}\gcd(a,n)=1\Rightarrow a^{\varphi(n)}\equiv1\pmod{n}."),
  //     StepItem(tex: r"\color{black}\text{ }1\le r\le n-1\text{ のうち }\gcd(r,n)=1\text{ のものを }r_1,\ldots,r_{\varphi(n)}\text{ とする。}"),
  //     StepItem(tex: r"\color{black}\text{(1) }ar_i\text{ も }\gcd(ar_i,n)=1\text{。}"),
  //     StepItem(tex: r"\color{black}\text{(2) }ar_i\equiv ar_j\pmod{n}\Rightarrow r_i=r_j\text{（重複なし）}"),
  //     StepItem(tex: r"\color{black}\text{ゆえに }\{ar_1,\ldots,ar_{\varphi(n)}\}\text{ の余りは }\{r_1,\ldots,r_{\varphi(n)}\}\text{ の並べ替え。}"),
  //     StepItem(tex: r"\color{black}\text{積をとると }r_1\cdots r_{\varphi(n)}\equiv (ar_1)\cdots(ar_{\varphi(n)})=a^{\varphi(n)}(r_1\cdots r_{\varphi(n)})\pmod{n}."),
  //     StepItem(tex: r"\color{black}\text{ここで }R=r_1\cdots r_{\varphi(n)}\text{ は }\gcd(R,n)=1\text{ なので }uR\equiv1\pmod{n}\text{ を満たす整数 }u\text{ が存在（ベズー）。}"),
  //     StepItem(tex: r"\color{black}\text{両辺に }u\text{ を掛けて }1\equiv a^{\varphi(n)}\pmod{n}."),
  //   ],
  // ),

  // ─────────────────────────────────────────────
  // // 問題 10: 10! (mod 11)（ウィルソン）
  // // ─────────────────────────────────────────────
  // CongruenceProblem(
  //   id: "A2D8D8C1-4C4B-4B23-9F8A-1D0A1A2C1F10",
  //   no: 10,
  //   question: r"x \equiv 10! \pmod{11}",
  //   answer: r"x \equiv 10 \pmod{11}",
  //   modulus: 11,
  //   shortExplanation: r"""\text{素数 }p\text{ では }(p-1)!\equiv-1\pmod{p}\text{。}""",
  //   detailedExplanation: [
  //     StepItem(tex: r"\color{black}\textbf{【ステップ1】}"),
  //     StepItem(tex: r"\color{black}10!=(11-1)!\equiv-1\pmod{11}"),
  //     StepItem(tex: r"\color{black}\textbf{【ステップ2】}"),
  //     StepItem(tex: r"\color{black}-1\equiv10\pmod{11}"),
  //     StepItem(tex: r"\color{black}\boxed{x\equiv10\pmod{11}}"),

  //     StepItem(tex: r"\color{black}\textbf{【この問題で使った合同の性質（証明）】}"),
  //     StepItem(tex: r"\color{black}\textbf{(性質H)}\ -1\equiv m-1\pmod{m}."),
  //     StepItem(tex: r"\color{black}\text{証明：}(m-1)-(-1)=m\text{ は }m\text{ の倍数}"),
  //     StepItem(tex: r"\color{black}\Rightarrow\ -1\equiv m-1\pmod{m}."),
  //   ],
  // ),

  // // 問題 12: 3^x ≡ 1 (mod 17)
  // CongruenceProblem(
  //   id: "8CA7F224-3945-4DCF-8928-FFA2FFCB398B",
  //   no: 12,
  //   question: r"3^x \equiv 1 \pmod{17}",
  //   answer: "16 (mod 17)",
  //   modulus: 17,
  //   shortExplanation: r"""\text{フェルマーの小定理と位数の性質（約数）を利用する。}""",
  //   detailedExplanation: [
  //     StepItem(tex: r"\color{black}\textbf{【ステップ1：位数の候補を絞る】}"),
  //     StepItem(tex: r"\color{black}\text{フェルマーの小定理より } 3^{16} \equiv 1 \pmod{17} \text{。}"),
  //     StepItem(tex: r"\color{black}\text{ここで、次の重要な命題を利用する。}"),
  //     StepItem(tex: r"\color{black}\textbf{命題：} a^n \equiv 1 \pmod{m} \text{ ならば、} a \text{ の位数 } d \text{ は } n \text{ の約数である。}"),
  //     StepItem(tex: r"\color{black}\text{したがって、求める最小の指数 } x \text{（位数）は } 16 \text{ の約数 } \{1, 2, 4, 8, 16\} \text{ のいずれかである。}"),
  //     StepItem(tex: r"\color{black}\textbf{【ステップ2：順に確認】}"),
  //     StepItem(tex: r"\color{black}3^1 = 3 \not\equiv 1"),
  //     StepItem(tex: r"\color{black}3^2 = 9 \not\equiv 1"),
  //     StepItem(tex: r"\color{black}3^4 = 81 = 17 \times 4 + 13 \equiv 13 \equiv -4 \not\equiv 1"),
  //     StepItem(tex: r"\color{black}3^8 \equiv (-4)^2 = 16 \equiv -1 \not\equiv 1"),
  //     StepItem(tex: r"\color{black}\textbf{【ステップ3】}"),
  //     StepItem(tex: r"\color{black}\text{よって、} x = 16 \text{ が最小である。}"),
  //     StepItem(tex: r"\color{black}\text{したがって } x \equiv 16 \pmod{16} \text{（つまり } 16 \text{ の倍数）が一般解だが、ここでは最小の正整数として } 16 \text{ を答える。}"),
  //     // 補足：命題の証明
  //     StepItem(tex: r"\color{black}\textbf{【補足：命題の証明】}"),
  //     StepItem(tex: r"\color{black}\text{位数 } d \text{ は } a^k \equiv 1 \pmod{m} \text{ となる最小の正整数 } k \text{ である。}"),
  //     StepItem(tex: r"\color{black}n \text{ を } d \text{ で割り算して } n = qd + r \ (0 \le r < d) \text{ とすると、}"),
  //     StepItem(tex: r"\color{black}a^n = a^{qd+r} = (a^d)^q \cdot a^r \equiv 1^q \cdot a^r = a^r \equiv 1 \pmod{m} \text{。}"),
  //     StepItem(tex: r"\color{black}\text{もし } r > 0 \text{ ならば、} d \text{ より小さい正整数 } r \text{ で } a^r \equiv 1 \text{ となり、} d \text{ の最小性に矛盾する。}"),
  //     StepItem(tex: r"\color{black}\text{よって } r = 0 \text{、すなわち } n \text{ は } d \text{ の倍数（} d \text{ は } n \text{ の約数）である。}"),
  //   ],
  // ),

  // // 問題 13: 中国剰余定理
  // CongruenceProblem(
  //   id: "4D9A2714-FE5A-424D-AA3B-843F1271AA63",
  //   no: 13,
  //   question: r"\begin{cases} x \equiv 2 \pmod{3} \\ x \equiv 3 \pmod{5} \end{cases}",
  //   answer: r"x \equiv 8 \pmod{15}",
  //   modulus: 15,
  //   equation: r"x \equiv 2 \pmod{3}",
  //   conditions: r"x \equiv 3 \pmod{5}",
  //   shortExplanation: r"""\text{中国剰余定理より }x \equiv 8 \pmod{15}\text{。}""",
  //   detailedExplanation: [
  //     StepItem(tex: r"\color{black}\textbf{【ステップ1】}"),
  //     StepItem(tex: r"\color{black}x \equiv 2 \pmod{3} \text{を満たす数を列挙する。}"),
  //     StepItem(tex: r"\color{black}x = 2, 5, \color{green}\textbf{8}\color{black}, 11, 14, 17, 20, \color{green}\textbf{23}\color{black}, 26, 29, 32, 35, \color{green}\textbf{38}\color{black}, 41, 44, 47, 50, \color{green}\textbf{53}\color{black}, 56, 59, 62, 65, 68, 71, 74, 77, 80, 83, 86, 89, 92, 95, 98, 101, 104, 107, 110, 113, 116, 119, 122, 125, 128, \ldots"),
  //     StepItem(tex: r"\color{black}\textbf{【ステップ2】}"),
  //     StepItem(tex: r"\color{black}x \equiv 3 \pmod{5} \text{を満たす数を列挙する。}"),
  //     StepItem(tex: r"\color{black}x = 3, \color{green}\textbf{8}\color{black}, 13, 18, \color{green}\textbf{23}\color{black}, 28, 33, \color{green}\textbf{38}\color{black}, 43, 48, \color{green}\textbf{53}\color{black}, 58, 63, 68, 73, 78, 83, 88, 93, 98, 103, 108, 113, 118, 123, 128, 133, 138, 143, 148, 153, 158, 163, 168, 173, 178, 183, 188, 193, 198, 203, 208, 213, 218, 223, 228, \ldots"),
  //     StepItem(tex: r"\color{black}\textbf{【ステップ3】}"),
  //     StepItem(tex: r"\color{black}\text{共通する数：} x \equiv \color{green}\textbf{8}\color{black}, \color{green}\textbf{23}\color{black}, \color{green}\textbf{38}\color{black}, \color{green}\textbf{53}\color{black}, \ldots \text{すなわち } x \equiv \color{green}\textbf{8}\color{black} \pmod{15}"),
  //     StepItem(tex: r"\color{black}\textbf{【補足：中国剰余定理の証明】}"),
  //     StepItem(tex: r"\color{black}\text{互いに素な正の整数}m_1, m_2, \ldots, m_k\text{と整数}a_1, a_2, \ldots, a_k\text{に対して、}"),
  //     StepItem(tex: r"\color{black}x \equiv a_i \pmod{m_i} \quad (i = 1, 2, \ldots, k)"),
  //     StepItem(tex: r"\color{black}\text{を満たす}x\text{が存在し、}M = m_1 m_2 \cdots m_k\text{を法として一意的である。}"),
  //   ],
  // ),

  // // 問題 14: 中国剰余定理（百五減算）
  // CongruenceProblem(
  //   id: "6C68E895-F211-44C7-958C-45D2AA889143",
  //   no: 14,
  //   question: r"\begin{cases} x \equiv 2 \pmod{3} \\ x \equiv 3 \pmod{5} \\ x \equiv 2 \pmod{7} \end{cases}",
  //   answer: r"x \equiv 23 \pmod{105}",
  //   modulus: 105,
  //   equation: r"x \equiv 2 \pmod{3}",
  //   conditions: r"x \equiv 3 \pmod{5} \\ x \equiv 2 \pmod{7}",
  //   shortExplanation: r"""\text{中国剰余定理より }x \equiv 23 \pmod{105}\text{。}""",
  //   detailedExplanation: [
  //     StepItem(tex: r"\color{black}\textbf{【ステップ1】}"),
  //     StepItem(tex: r"\color{black}x \equiv 2 \pmod{3} \text{を満たす数を列挙する。}"),
  //     StepItem(tex: r"\color{black}x = 2, 5, 8, 11, 14, 17, 20, \color{green}\textbf{23}\color{black}, 26, 29, 32, 35, 38, 41, 44, 47, 50, 53, 56, 59, 62, 65, 68, 71, 74, 77, 80, 83, 86, 89, 92, 95, 98, 101, 104, 107, 110, 113, 116, 119, 122, 125, \color{green}\textbf{128}\color{black}, 131, 134, 137, 140, 143, 146, 149, 152, 155, 158, 161, 164, 167, 170, 173, 176, 179, 182, 185, 188, 191, 194, 197, 200, 203, 206, 209, 212, 215, 218, 221, 224, 227, 230, \color{green}\textbf{233}\color{black}, 236, 239, 242, 245, 248, 251, 254, 257, 260, 263, 266, 269, 272, 275, 278, 281, 284, 287, 290, 293, 296, 299, 302, 305, 308, 311, 314, 317, 320, 323, 326, 329, 332, 335, \color{green}\textbf{338}\color{black}, 341, 344, 347, 350, 353, 356, 359, 362, 365, 368, 371, 374, 377, 380, 383, 386, 389, 392, 395, 398, 401, 404, 407, 410, 413, 416, 419, 422, 425, 428, 431, 434, 437, 440, 443, 446, 449, 452, 455, 458, 461, 464, 467, 470, 473, 476, 479, 482, 485, 488, 491, 494, 497, 500, 503, 506, 509, 512, 515, 518, 521, 524, 527, 530, 533, 536, 539, 542, 545, 548, 551, 554, 557, 560, 563, 566, 569, 572, 575, 578, 581, 584, 587, 590, 593, 596, 599, 602, 605, 608, 611, 614, 617, 620, 623, 626, 629, 632, 635, 638, 641, 644, 647, 650, 653, 656, 659, 662, 665, 668, 671, 674, 677, 680, 683, 686, 689, 692, 695, 698, 701, 704, 707, 710, 713, 716, 719, 722, 725, 728, 731, 734, 737, 740, 743, 746, 749, 752, 755, 758, 761, 764, 767, 770, 773, 776, 779, 782, 785, 788, 791, 794, 797, 800, 803, 806, 809, 812, 815, 818, 821, 824, 827, 830, 833, 836, 839, 842, 845, 848, 851, 854, 857, 860, 863, 866, 869, 872, 875, 878, 881, 884, 887, 890, 893, 896, 899, 902, 905, 908, 911, 914, 917, 920, 923, 926, 929, 932, 935, 938, 941, 944, 947, 950, 953, 956, 959, 962, 965, 968, 971, 974, 977, 980, 983, 986, 989, 992, 995, 998, 1001, 1004, 1007, 1010, 1013, 1016, 1019, 1022, 1025, 1028, 1031, 1034, 1037, 1040, 1043, 1046, 1049, 1052, \ldots"),
  //     StepItem(tex: r"\color{black}\textbf{【ステップ2】}"),
  //     StepItem(tex: r"\color{black}x \equiv 3 \pmod{5} \text{を満たす数を列挙する。}"),
  //     StepItem(tex: r"\color{black}x = 3, 8, 13, 18, \color{green}\textbf{23}\color{black}, 28, 33, 38, 43, 48, 53, 58, 63, 68, 73, 78, 83, 88, 93, 98, 103, 108, 113, 118, 123, \color{green}\textbf{128}\color{black}, 133, 138, 143, 148, 153, 158, 163, 168, 173, 178, 183, 188, 193, 198, 203, 208, 213, 218, 223, 228, \color{green}\textbf{233}\color{black}, 238, 243, 248, 253, 258, 263, 268, 273, 278, 283, 288, 293, 298, 303, 308, 313, 318, 323, 328, \color{green}\textbf{338}\color{black}, 343, 348, 353, 358, 363, 368, 373, 378, 383, 388, 393, 398, 403, 408, 413, 418, 423, 428, 433, 438, 443, 448, 453, 458, 463, 468, 473, 478, 483, 488, 493, 498, 503, 508, 513, 518, 523, 528, 533, 538, 543, 548, 553, 558, 563, 568, 573, 578, 583, 588, 593, 598, 603, 608, 613, 618, 623, 628, 633, 638, 643, 648, 653, 658, 663, 668, 673, 678, 683, 688, 693, 698, 703, 708, 713, 718, 723, 728, 733, 738, 743, 748, 753, 758, 763, 768, 773, 778, 783, 788, 793, 798, 803, 808, 813, 818, 823, 828, 833, 838, 843, 848, 853, 858, 863, 868, 873, 878, 883, 888, 893, 898, 903, 908, 913, 918, 923, 928, 933, 938, 943, 948, 953, 958, 963, 968, 973, 978, 983, 988, 993, 998, 1003, 1008, 1013, 1018, 1023, 1028, 1033, 1038, 1043, 1048, 1053, \ldots"),
  //     StepItem(tex: r"\color{black}\textbf{【ステップ3】}"),
  //     StepItem(tex: r"\color{black}x \equiv 2 \pmod{7} \text{を満たす数を列挙する。}"),
  //     StepItem(tex: r"\color{black}x = 2, 9, 16, \color{green}\textbf{23}\color{black}, 30, 37, 44, 51, 58, 65, 72, 79, 86, 93, 100, 107, 114, 121, \color{green}\textbf{128}\color{black}, 135, 142, 149, 156, 163, 170, 177, 184, 191, 198, 205, 212, 219, 226, \color{green}\textbf{233}\color{black}, 240, 247, 254, 261, 268, 275, 282, 289, 296, 303, 310, 317, 324, 331, \color{green}\textbf{338}\color{black}, 345, 352, 359, 366, 373, 380, 387, 394, 401, 408, 415, 422, 429, 436, 443, 450, 457, 464, 471, 478, 485, 492, 499, 506, 513, 520, 527, 534, 541, 548, 555, 562, 569, 576, 583, 590, 597, 604, 611, 618, 625, 632, 639, 646, 653, 660, 667, 674, 681, 688, 695, 702, 709, 716, 723, 730, 737, 744, 751, 758, 765, 772, 779, 786, 793, 800, 807, 814, 821, 828, 835, 842, 849, 856, 863, 870, 877, 884, 891, 898, 905, 912, 919, 926, 933, 940, 947, 954, 961, 968, 975, 982, 989, 996, 1003, 1010, 1017, 1024, 1031, 1038, 1045, 1052, \ldots"),
  //     StepItem(tex: r"\color{black}\textbf{【ステップ4】}"),
  //     StepItem(tex: r"\color{black}\text{3つの条件をすべて満たす数：} x \equiv \color{green}\textbf{23}\color{black}, \color{green}\textbf{128}\color{black}, \color{green}\textbf{233}\color{black}, \color{green}\textbf{338}\color{black}, \ldots \text{すなわち } x \equiv \color{green}\textbf{23}\color{black} \pmod{105}"),
  //     StepItem(tex: r"\color{black}\textbf{【補足：百五減算（孫子算経）】}"),
  //     StepItem(tex: r"\color{black}\text{この問題は、中国の古代数学書『孫子算経』（3世紀頃）に登場する「百五減算（ひゃくごげんざん）」として知られています。}"),
  //     StepItem(tex: r"\color{black}\text{「3で割ると2余り、5で割ると3余り、7で割ると2余る数は何か？」という問題で、}"),
  //     StepItem(tex: r"\color{black}\text{中国剰余定理の典型的な例として、古くから親しまれてきました。}"),
  //     StepItem(tex: r"\color{black}\text{「百五減算」という名称は、解が105（= 3 × 5 × 7）を周期として繰り返すことに由来します。}"),
  //   ],
  // ),
  // // 改訂版 問題 15: x^2 ≡ 2 (mod 97)
  // CongruenceProblem(
  //   id: "3B5FCA4A-27F5-442F-B7DA-0B68E8159F7A",
  //   no: 15,
  //   question: r"x^2 \equiv 2 \pmod{97}",
  //   answer: r"x \equiv \pm 14 \pmod{97}",            // 両方の平方根を明記
  //   modulus: 97,
  //   shortExplanation: r"14^2 = 196 \equiv 2 \pmod{97} に注目。もう一つの解は -14 \equiv 83 \pmod{97}。",
  //   detailedExplanation: [
  //     StepItem(tex: r"\color{black}\textbf{【ステップ1】}"),
  //     StepItem(tex: r"\color{black}14^2 = 196 \text{ を }97\text{ で割ると }196 = 97\times2 + 2。"),
  //     StepItem(tex: r"\color{black}\text{したがって }14^2 \equiv 2 \pmod{97}。"),
  //     StepItem(tex: r"\color{black}\textbf{【ステップ2】}"),
  //     StepItem(tex: r"\color{black}\text{合同式 }x^2\equiv2\pmod{97}\text{ の解は }x\equiv 14\pmod{97}\text{ と }x\equiv -14\pmod{97}\text{（すなわち }83\text{）である。}"),
  //     StepItem(tex: r"\color{black}\textbf{【補足：なぜ解は2つだけなのか】}"),
  //     StepItem(tex: r"\color{black}\text{素数}p\text{について}x^2 \equiv a^2 \pmod p \iff x^2 - a^2 \equiv 0 \pmod p"),
  //     StepItem(tex: r"\color{black}\iff (x-a)(x+a) \equiv 0 \pmod p"),
  //     StepItem(tex: r"\color{black}\text{素数}p\text{は既約（ユークリッドの補題）なので、}p \mid (x-a) \text{ または } p \mid (x+a) \text{。}"),
  //     StepItem(tex: r"\color{black}\text{すなわち } x \equiv a \pmod p \text{ または } x \equiv -a \pmod p \text{ となる。}"),
  //     StepItem(tex: r"\color{black}\text{これらは } a \not\equiv 0 \pmod p \text{ ならば互いに異なる2つの解である。}"),
  //   ],
  // ),

  // // 改訂版 問題 17: 5^x ≡ 1 (mod 23)
  // CongruenceProblem(
  //   id: "1AB33ECC-80CC-42FF-BE39-B79744B95F68",
  //   no: 17,
  //   question: r"5^x \equiv 1 \pmod{23}",
  //   answer: r"x \equiv 0 \pmod{22}",                 // 全解は "x は 22 の倍数"
  //   modulus: 23,
  //   shortExplanation: r"5 の法 23 における位数は 22（原始根の場合）。したがって解は 22 の倍数。",
  //   detailedExplanation: [
  //     StepItem(tex: r"\color{black}\textbf{【ステップ1：位数の候補を絞る】}"),
  //     StepItem(tex: r"\color{black}\text{フェルマーの小定理より }5^{22}\equiv1\pmod{23}\text{。}"),
  //     StepItem(tex: r"\color{black}\textbf{命題：} a^n \equiv 1 \pmod{m} \text{ ならば、位数 } d \text{ は } n \text{ の約数である。}"),
  //     StepItem(tex: r"\color{black}\text{よって、位数は } 22 \text{ の約数 } \{1, 2, 11, 22\} \text{ のいずれかである。}"),
  //     StepItem(tex: r"\color{black}\textbf{【ステップ2：順に確認】}"),
  //     StepItem(tex: r"\color{black}5^1=5\not\equiv1"),
  //     StepItem(tex: r"\color{black}5^2=25\equiv2\not\equiv1"),
  //     StepItem(tex: r"\color{black}5^{11}=(5^2)^5\cdot5\equiv2^5\cdot5\equiv32\cdot5\equiv9\cdot5\equiv45\equiv-1\not\equiv1"),
  //     StepItem(tex: r"\color{black}\text{したがって、最小の正の指数（位数）は } 22 \text{ である。}"),
  //     StepItem(tex: r"\color{black}\text{求める解は } 22 \text{ の倍数となるため、} x \equiv 0 \pmod{22} \text{ である。}"),
  //   ],
  // ),

  // // 改訂版 問題 19: x ≡ 2^{560} (mod 561)
  // CongruenceProblem(
  //   id: "B96F1095-6BFF-43ED-9C06-97F144567941",
  //   no: 19,
  //   question: r"x \equiv 2^{560} \pmod{561}",
  //   answer: r"x \equiv 1 \pmod{561}",
  //   modulus: 561,
  //   shortExplanation: r"561 = 3×11×17 はカーマイケル数。カーマイケル関数 \lambda(561)=80 を利用する。",
  //   detailedExplanation: [
  //     StepItem(tex: r"\color{black}\textbf{【ステップ1：素因数分解】}"),
  //     StepItem(tex: r"\color{black}561 = 3 \times 11 \times 17 \text{ である。}"),
  //     StepItem(tex: r"\color{black}\text{法 } 561 \text{ での合同式を、各素因数を法とする連立合同式に分解して考える（中国剰余定理の考え方）。}"),
  //     StepItem(tex: r"\color{black}\textbf{【ステップ2：各法での計算】}"),
  //     StepItem(tex: r"\color{black}\text{フェルマーの小定理より、}\gcd(a, p)=1\text{ならば } a^{p-1} \equiv 1 \pmod{p} \text{。}"),
  //     StepItem(tex: r"\color{black}2^{560} \pmod{3} : 560 \text{ は } 3-1=2 \text{ の倍数なので } 2^{560} \equiv 1 \pmod{3}"),
  //     StepItem(tex: r"\color{black}2^{560} \pmod{11} : 560 \text{ は } 11-1=10 \text{ の倍数なので } 2^{560} \equiv 1 \pmod{11}"),
  //     StepItem(tex: r"\color{black}2^{560} \pmod{17} : 560 \text{ は } 17-1=16 \text{ の倍数なので } 2^{560} \equiv 1 \pmod{17} \text{（}560 = 16 \times 35\text{）}"),
  //     StepItem(tex: r"\color{black}\textbf{【ステップ3：結論】}"),
  //     StepItem(tex: r"\color{black}2^{560} - 1 \text{ は } 3, 11, 17 \text{ のいずれでも割り切れる。}"),
  //     StepItem(tex: r"\color{black}3, 11, 17 \text{ は互いに素なので、} 2^{560} - 1 \text{ は } 3 \times 11 \times 17 = 561 \text{ で割り切れる。}"),
  //     StepItem(tex: r"\color{black}\text{よって } 2^{560} \equiv 1 \pmod{561} \text{。}"),
  //     StepItem(tex: r"\color{black}\textbf{【補足：カーマイケル数とカーマイケル関数】}"),
  //     StepItem(tex: r"\color{black}\text{合成数 } n \text{ に対して } a^{n-1} \equiv 1 \pmod{n} \text{ が（互いに素な全ての } a \text{ で）成り立つ数をカーマイケル数という。}"),
  //     StepItem(tex: r"\color{black}\text{一般に } a^m \equiv 1 \pmod{n} \text{ が成り立つ最小の } m \text{（カーマイケル関数 } \lambda(n) \text{）は、各素因数の } p-1 \text{ の最小公倍数となる。}"),
  //     StepItem(tex: r"\color{black}\text{ここでは } \lambda(561) = \text{lcm}(2, 10, 16) = 80 \text{。}"),
  //     StepItem(tex: r"\color{black}560 \text{ は } 80 \text{ の倍数なので、} 2^{560} \equiv 1 \pmod{561} \text{ が直ちに導かれる。}"),
  //   ],
  // ),

  // // 改訂版 問題 20: x ≡ C(100,50) (mod 7)
  // CongruenceProblem(
  //   id: "F8AA9480-CDFC-4ED4-958B-97564C38D7BE",
  //   no: 20,
  //   question: r"x \equiv {}_{100}\mathrm{C}_{50} \pmod{7}",
  //   answer: r"x \equiv 4 \pmod{7}",                  // もともと正しい
  //   modulus: 7,
  //   shortExplanation: r"ルーカスの定理を用いると、100=(202)_7, 50=(101)_7 より積は 2×1×2 = 4。",
  //   detailedExplanation: [
  //     StepItem(tex: r"\color{black}\textbf{【ステップ1】}"),
  //     StepItem(tex: r"\color{black}100=(202)_7,\quad50=(101)_7\text{ と書ける。}"),
  //     StepItem(tex: r"\color{black}\text{ルーカスの定理より } \binom{100}{50}\equiv\binom{2}{1}\binom{0}{0}\binom{2}{1}\pmod{7}."),
  //     StepItem(tex: r"\color{black}\text{これにより }2\cdot1\cdot2=4\pmod{7}\text{。よって }x\equiv4\pmod{7}."),
  //   ],
  // ),

  // // 改訂版 問題 21: 2^x ≡ 1 (mod 17) - 原始根ではない例（位数は8）
  // CongruenceProblem(
  //   id: "06396B11-6E56-4AAF-93B2-A2EAF51CA845",
  //   no: 21,
  //   question: r"2^x \equiv 1 \pmod{17}",
  //   answer: r"x \equiv 0 \pmod{8}",                  // 修正：指数の全解は 8 の倍数
  //   modulus: 17,
  //   shortExplanation: r"計算すると 2^8\equiv1\pmod{17} で、位数は 8。したがって解は 8 の倍数。",
  //   detailedExplanation: [
  //     StepItem(tex: r"\color{black}\textbf{【ステップ1：位数の候補】}"),
  //     StepItem(tex: r"\color{black}フェルマーの小定理より 2^{16}\equiv1\pmod{17}。"),
  //     StepItem(tex: r"\color{black}\textbf{命題}により、位数は 16 の約数 \{1, 2, 4, 8, 16\} のいずれか。"),
  //     StepItem(tex: r"\color{black}\textbf{【ステップ2：順に確認】}"),
  //     StepItem(tex: r"\color{black}2^1=2, \quad 2^2=4, \quad 2^4=16\equiv-1"),
  //     StepItem(tex: r"\color{black}2^8=(2^4)^2\equiv(-1)^2=1 \pmod{17}。"),
  //     StepItem(tex: r"\color{black}\text{したがって最小正位数は }8\text{。全解は }x\equiv0\pmod{8}\text{（＝ }x=8k\text{）である。}"),
  //   ],
  // ),

  // // 改訂版 問題 22: 4^x ≡ 1 (mod 19) - 原始根ではない例（位数は9）
  // CongruenceProblem(
  //   id: "A44FADA2-217E-456E-8230-69875F5D3FF3",
  //   no: 22,
  //   question: r"4^x \equiv 1 \pmod{19}",
  //   answer: r"x \equiv 0 \pmod{9}",                  // 修正：指数の全解は 9 の倍数
  //   modulus: 19,
  //   shortExplanation: r"計算すると 4^9\equiv1\pmod{19} で、位数は 9。したがって解は 9 の倍数。",
  //   detailedExplanation: [
  //     StepItem(tex: r"\color{black}\textbf{【ステップ1：位数の候補】}"),
  //     StepItem(tex: r"\color{black}フェルマーの小定理より 4^{18}\equiv1\pmod{19}。"),
  //     StepItem(tex: r"\color{black}\textbf{命題}により、位数は 18 の約数 \{1, 2, 3, 6, 9, 18\} のいずれか。"),
  //     StepItem(tex: r"\color{black}\textbf{【ステップ2：順に確認】}"),
  //     StepItem(tex: r"\color{black}4^1=4, \quad 4^2=16, \quad 4^3=64=19\times3+7\equiv7"),
  //     StepItem(tex: r"\color{black}4^6=(4^3)^2\equiv7^2=49\equiv11 \pmod{19}"),
  //     StepItem(tex: r"\color{black}4^9=4^6\cdot4^3\equiv11\cdot7=77=19\times4+1\equiv1 \pmod{19}"),
  //     StepItem(tex: r"\color{black}\text{したがって最小正位数は }9\text{。全解は }x\equiv0\pmod{9}\text{（＝ }x=9k\text{）である。}"),
  //   ],
  // ),


  // // 問題 23: 割ると間違う例 - 3x ≡ 9 (mod 15)
  // CongruenceProblem(
  //   id: "28B2989A-F492-4A1A-AF07-4CE5ACCF89FA",
  //   no: 23,
  //   question: r"3x \equiv 9 \pmod{15}",
  //   answer: r"x \equiv 3, 8, 13 \pmod{15}",
  //   modulus: 15,
  //   coefficient: 3,
  //   constant: 9,
  //   shortExplanation: r"""\text{両辺を3で割ることはできない（}\gcd(3,15)=3\neq1\text{）。正しくは }x\equiv3,8,13\pmod{15}\text{。}""",
  //   detailedExplanation: [
  //     StepItem(tex: r"\color{black}\textbf{【誤った解法】}"),
  //     StepItem(tex: r"\color{black}\text{両辺を3で割ると、} 3x \equiv 9 \pmod{15} \Rightarrow x \equiv 3 \pmod{15}"),
  //     StepItem(tex: r"\color{red}\text{これは間違いです！なぜなら、}\gcd(3,15)=3\neq1\text{なので、3で割ることはできません。}"),
  //     StepItem(tex: r"\color{black}\textbf{【正しい解法】}"),
  //     StepItem(tex: r"\color{black}3x \equiv 9 \pmod{15} \text{を変形する。}"),
  //     StepItem(tex: r"\color{black}3x - 9 \equiv 0 \pmod{15}"),
  //     StepItem(tex: r"\color{black}3(x - 3) \equiv 0 \pmod{15}"),
  //     StepItem(tex: r"\color{black}\textbf{【ステップ1】}"),
  //     StepItem(tex: r"\color{black}\text{3}(x-3)\text{が15の倍数であることから、}x-3\text{は5の倍数でなければならない。}"),
  //     StepItem(tex: r"\color{black}\text{（なぜなら、}3(x-3)=15k\text{とすると、}x-3=5k\text{となるから）}"),
  //     StepItem(tex: r"\color{black}\textbf{【ステップ2】}"),
  //     StepItem(tex: r"\color{black}x - 3 \equiv 0 \pmod{5} \text{より、} x \equiv 3 \pmod{5}"),
  //     StepItem(tex: r"\color{black}\textbf{【ステップ3】}"),
  //     StepItem(tex: r"\color{black}\text{mod 15で考えると、} x \equiv 3, 8, 13 \pmod{15}"),
  //     StepItem(tex: r"\color{black}\text{（検証：} 3 \times 3 = 9 \equiv 9 \pmod{15}, \quad 3 \times 8 = 24 \equiv 9 \pmod{15}, \quad 3 \times 13 = 39 \equiv 9 \pmod{15} \text{）}"),
  //     StepItem(tex: r"\color{black}\textbf{【補足：なぜ割ることができないのか】}"),
  //     StepItem(tex: r"\color{black}\text{一般に、} ac \equiv bc \pmod{m} \text{で、}\gcd(c,m)=d\text{のとき、}"),
  //     StepItem(tex: r"\color{black}a \equiv b \pmod{\frac{m}{d}} \text{が成り立つ。}"),
  //     StepItem(tex: r"\color{black}\text{本問題では}\gcd(3,15)=3\text{なので、}x\equiv3\pmod{5}\text{が成り立ち、}"),
  //     StepItem(tex: r"\color{black}\text{mod 15では}3\text{つの解} x\equiv3,8,13\pmod{15}\text{が存在する。}"),
  //     StepItem(tex: r"\color{black}\text{両辺を3で割って}x\equiv3\pmod{15}\text{とすると、解が1つしかないと誤って結論づけてしまう。}"),
  //   ],
  // ),
];
