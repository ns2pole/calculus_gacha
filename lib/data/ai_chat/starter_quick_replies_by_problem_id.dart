import '../../models/ai_chat_quick_reply.dart';

/// Auto-generated starter quick replies per [MathProblem.id].
/// Regenerate: tool/generate-starter-quick-replies.mjs
const starterQuickRepliesByProblemId = <String, List<AiChatQuickReply>>{
//x^2 + xy + 2y^2 = 11 : 不定方程式ガチャ
  "00E2A046-7CC1-48D5-ADCB-A48C3F5A250B": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この方程式のタイプは何ですか？", actionId: "equation_type"),
    AiChatQuickReply(label: "どういう方針で解き進めれば良いですか？", actionId: "approach_only"),
  ],
//\int_0^{\pi} x\cos x dx : 積分ガチャ
  "01AB7A0C-4FD8-4E11-B537-50DFBEF48965": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
  ],
//f'(t)=-2 f(t), f(0)=f_0 : 微分方程式ガチャ
  "035BEF48-5556-4099-9AD4-1FBE772833CE": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "これはどのような種類の微分方程式ですか？", actionId: "equation_type"),
    AiChatQuickReply(label: "解き始めるための方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "f'(t)は何を表していますか？", actionId: "term_meaning"),
    AiChatQuickReply(label: "初期条件f(0)=f_0はどのように使いますか？", actionId: "initial_condition_use"),
  ],
//\alpha f''(t)+2\beta f'(t)+\gamma f(t)=F\sin(\omega t), \alpha>0,\ \gamma>0,\ (\gamma)/(\alpha)>(\beta^2)/(\alpha^2),\ \beta>0,\ f(0)=0,\... : 微分方程式ガチャ
  "07FC023A-DAD9-432A-BCD7-B90E3C25404F": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "特解の求め方の方針を教えてください", actionId: "particular_solution_approach"),
    AiChatQuickReply(label: "RLC回路との関連について教えてください", actionId: "rlc_connection"),
  ],
//x^3 + y^3 + z^3 - 3xyz : 因数分解ガチャ
  "09338EE1-388B-4048-ABC3-CD11A1297220": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この式の因数分解の考え方を教えてください。", actionId: "approach_only"),
  ],
//\lim_{n\to\infty}\frac{1}{n^{3}}\sum_{k=1}^{n}k^{2} : 極限ガチャ
  "0DDAAC08-A9CF-4240-9166-64922F384992": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "極限の計算のポイントは何ですか？", actionId: "approach_only"),
  ],
//a_{n+1} = 2a_n + n + 1, a_1 = 1 : 漸化式ガチャ
  "0E10892B-45E0-4994-9281-EDB35CE38498": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この漸化式のタイプは何ですか？", actionId: "identify_type"),
  ],
//\int_{0}^{2} \frac{dx}{(4+x^2)^{(3)/(2)}} : 積分ガチャ
  "14D0F717-BEC3-49D9-98CF-F56C33CB6B3B": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分、どう解けばいいですか？", actionId: "approach_only"),
  ],
//9x^2 - 24xy + 16y^2 : 因数分解ガチャ
  "14E178D7-FC09-4439-B145-92688182FC44": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この式はどんな因数分解の形ですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "二乗の形にまとめるにはどうすればいいですか？", actionId: "specific_approach"),
  ],
//4x^2 - 20xy + 25y^2 : 因数分解ガチャ
  "15CEC271-B2C8-40A9-9B84-C64590472E61": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の基本方針を教えて", sendText: "この式の因数分解の基本的な方針を教えてください。", actionId: "approach_only"),
  ],
//842x + 495y = 1 : 不定方程式ガチャ
  "16F18597-C6FC-4AE9-B600-B230BB5F5405": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", sendText: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "不定方程式の解き方について教えてください", sendText: "不定方程式の解き方について教えてください。", actionId: "how_to_solve_diophantine"),
  ],
//\int_{(1)/(4)}^{(3)/(4)} \frac{dx}{\sqrt{x(1-x)}} : 積分ガチャ
  "17D1526C-1324-4C82-8D05-59B9308E14D2": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
  ],
//\int_{1}^{e} \log x dx : 積分ガチャ
  "180399F4-71C4-4CAE-8392-D57061DDCBA6": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "定積分の計算で注意することはありますか？", actionId: "definite_integral_tip"),
  ],
//\int_{0}^{\sqrt{3}} \frac{x}{\sqrt{1+x^{2}}} dx : 積分ガチャ
  "183166B0-C425-4604-B488-2D51C73267D5": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "どの部分を置換すればいい？", actionId: "substitution_target"),
  ],
//\int_{-1}^{1}(1-x^{2})^{3} dx : 積分ガチャ
  "18A36D0E-7123-4A0D-8AE6-E8453099D9A9": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この定積分のポイントは何ですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "積分の計算手順を教えてください。", actionId: "calculation_steps"),
    AiChatQuickReply(label: "(1-x^2)^3 の展開方法を教えてください。", actionId: "expansion_help"),
  ],
//x^4 + 9x^3 + 16x^2 - x - 3 : 因数分解ガチャ
  "1BD1750A-06EA-42B5-81DB-57091773730C": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この多項式の因数分解の方針を教えて", actionId: "approach_only"),
    AiChatQuickReply(label: "1次式の因数がない場合、どうすればいい？", actionId: "no_linear_factors"),
  ],
//f''(t) + 6 f'(t) + 10 f(t) = 0, f(0) = 1,\ f'(0) = 2 : 微分方程式ガチャ
  "1D342CB8-24CD-40BB-A3EA-06BB6AFC1845": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この微分方程式の解き方の基本方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "初期条件 f(0)=1, f'(0)=2 をどのように使いますか？", actionId: "initial_conditions"),
    AiChatQuickReply(label: "減衰振動とはどういう意味ですか？", actionId: "damped_oscillation_meaning"),
  ],
//f'(t)+a f(t)=F\cos(\omega t) : 微分方程式ガチャ
  "1DAE0FE3-E342-4547-956C-6CD1EA31EAD3": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この微分方程式の解き方の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "初期条件f(0)=f_0はどのように使いますか？", actionId: "initial_condition_usage"),
    AiChatQuickReply(label: "定常解と過渡解について教えてください。", actionId: "steady_transient_solution"),
  ],
//\lim_{h\to 0}(1+2h)^{(1)/(h)} : 極限ガチャ
  "1E209006-69B2-4DAE-8B9D-036D1800D855": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "式変形のヒントが欲しいです", actionId: "transformation_hint"),
  ],
//x^4 + 4 : 因数分解ガチャ
  "1EC3C384-44E0-4C3B-8FE4-2E3814FD7CB3": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の基本的な方針を教えて", sendText: "この式の因数分解の基本的な方針を教えてください。", actionId: "approach_only"),
  ],
//\lim_{n\to\infty}\frac{n^{2}}{2^{n}} : 極限ガチャ
  "1ECE1CDE-BFDC-4524-B8B5-6501A91BD8BE": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この極限の形は何ですか？", actionId: "limit_form"),
    AiChatQuickReply(label: "指数関数と多項式、どちらが速く増加しますか？", actionId: "growth_comparison"),
  ],
//x^4 + x^2 - 2 : 因数分解ガチャ
  "1F0413C9-47F5-44A8-A3C3-519334677C68": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の解き方を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "x^4 の項がある式の因数分解は初めてです。", sendText: "x^4 の項がある式の因数分解は初めてです。どのように考えたらいいですか？"),
  ],
//\frac{3^x - 3^{-x}}{2} = 5 : 三角指数対数ガチャ
  "205667D9-8B8F-43B6-A590-037AAE61339F": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "3の-x乗はどう扱えばいいですか？", actionId: "term_meaning"),
    AiChatQuickReply(label: "指数方程式の一般的な解き方を知りたい", actionId: "approach_only"),
    AiChatQuickReply(label: "3のx乗をtと置くのはどうですか？", actionId: "specific_approach"),
  ],
//x^5 - x^4 - 1 : 因数分解ガチャ
  "227D1ED5-9BAE-49E1-BD62-02531FB8ADF1": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の一般的な方針は何ですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "1次式の因数がない場合、どうすればいいですか？", actionId: "next_step"),
    AiChatQuickReply(label: "係数比較とはどういう方法ですか？", actionId: "method_explanation"),
  ],
//x^3 - 9xy + 27y^3 + 1 : 因数分解ガチャ
  "24D47C58-831B-4D01-A30E-3BD84A0D741E": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の一般的な方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "x^3 + 27y^3 の部分から始めますか？", actionId: "hint_specific_part"),
  ],
// : 積分ガチャ
  "26D1B6CC-77F8-4522-88A0-0A06A41D8D67": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "e^(-x) の積分はどうなりますか？", actionId: "specific_calculation"),
  ],
//\lim_{x\to 0}(|\sin x|)/(x) : 極限ガチャ
  "26E37810-7237-4FC5-8876-910F55F7133E": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "絶対値記号の外し方がわかりません。", actionId: "absolute_value_hint"),
    AiChatQuickReply(label: "左右極限を考えるのはなぜですか？", actionId: "why_left_right_limit"),
    AiChatQuickReply(label: "右側極限から計算を始めたいです。", actionId: "first_step_right_limit"),
  ],
//x^3 + 125 : 因数分解ガチャ
  "2BC52EFA-C75B-4E77-B1E5-E7ECCA113394": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "どういう方針で解けばいいですか？", actionId: "approach_only"),
  ],
//f''(t) = -4 f(t) + 2, f(0) = 0,\ f'(0) = 0 : 微分方程式ガチャ
  "2C1016F1-C7DD-4BE8-8BC8-0C5AA7F05FB5": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この微分方程式の解き方の基本方針を教えてください。", actionId: "approach_only"),
  ],
//\lim_{x\to 0}\frac{1-\cos x}{x^{2}} : 極限ガチャ
  "2D7ED2C9-2759-46FC-B597-619EB2FA6A3B": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", sendText: "この問題の方針を教えてください。", actionId: "approach_only"),
  ],
//\int_0^{2\pi}\sin(2x)\cos(3x) dx : 積分ガチャ
  "2E68B281-EA4E-4B67-879E-59A9AE7EC762": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "sin(2x)cos(3x)をどう変形しますか？", actionId: "specific_transformation"),
  ],
//\lim_{h\to 0}(1+h)^{(1)/(h)} : 極限ガチャ
  "3444E69A-5FCB-43A5-8C70-54616A1226D6": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この極限の形は何を表していますか？", actionId: "meaning_of_form"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "なぜこの極限がeになるのですか？", actionId: "why_e"),
  ],
//x^4 + 3x^2 - 4 : 因数分解ガチャ
  "34A820FC-E504-47F2-BBF4-741670A417AE": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "どういう方針で解けばいいですか？", actionId: "approach_only"),
  ],
//\lim_{x\to \infty}\left(1+(1)/(x)\right)^{x} : 極限ガチャ
  "369BD639-C54E-4847-93A1-3B56E19006A2": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この極限の形は何を意味しますか？", actionId: "meaning_of_form"),
    AiChatQuickReply(label: "どういう方針で解き進めればいいですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "変数変換は有効ですか？", actionId: "variable_substitution_hint"),
  ],
//a_{n+1} = 4a_n + b_n,\\[4pt] : 漸化式ガチャ
  "37B80E92-3E58-4BAF-A56B-7425004B28E0": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "連立漸化式の解き方の方針を教えて", actionId: "approach_only"),
    AiChatQuickReply(label: "b_nを消去するにはどうすればいい？", actionId: "eliminate_variable"),
    AiChatQuickReply(label: "3項間漸化式の一般項の求め方を確認したい", actionId: "three_term_recurrence_hint"),
  ],
//\int_{0}^{(1)/(2)} \sqrt{1 - 2x} dx : 積分ガチャ
  "383DCCBD-6B56-4171-856E-F14225EC83D8": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分はどう解けばいいですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "√の中が1次式の場合の積分について教えて", actionId: "concept_irrational_integral"),
    AiChatQuickReply(label: "定積分の計算で気をつけることは？", actionId: "concept_definite_integral"),
  ],
//\lim_{x\to -\infty}\left(1+(1)/(x)\right)^{x} : 極限ガチャ
  "38DF36DC-0268-4E1D-A341-14A39DDE8543": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "変数変換について教えてください。", actionId: "variable_substitution_hint"),
  ],
//\sin x + \sin 2x + \sin 3x = 0, 0 \leq x < 2\pi : 三角指数対数ガチャ
  "3A11C85E-F61C-49FA-BAA5-2BD036093B07": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "sin x + sin 3x の部分をどう処理しますか？", actionId: "specific_hint"),
  ],
//x^5 + x^4 + x^3 + x^2 + x + 1 : 因数分解ガチャ
  "3A5214AB-C386-4C28-AA01-886809BDE55A": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の一般的な方針を教えてください", sendText: "この式の因数分解の一般的な方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この式に何か特徴はありますか？", sendText: "この式に何か特徴的なパターンや性質はありますか？", actionId: "hint_pattern"),
  ],
//\lim_{n\to\infty}\sqrt{n} \int_{0}^{(\pi)/(2)}\sin^n x dx : 極限ガチャ
  "3B2F6F76-9E2E-4C3A-A0C7-6E3C6E8B9B21": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "漸化式を作るにはどうすればいいですか？", actionId: "recurrence_relation"),
  ],
//x^2 - 7x - 18 : 因数分解ガチャ
  "3CEFDD7D-4880-48DF-ABD8-7779C2D0F2C5": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の基本的な考え方を知りたい", sendText: "この式の因数分解の基本的な考え方を教えてください。", actionId: "approach_only"),
  ],
//a_{n+1} = 3a_n - 4, a_1 = 1 : 漸化式ガチャ
  "3F26B444-EA86-4FF8-830B-2AC464BDE3E6": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この漸化式のタイプは何ですか？", actionId: "identify_type"),
    AiChatQuickReply(label: "定数項がある漸化式の解き方を知りたい", actionId: "approach_constant_term"),
  ],
//x^3 + (3y - 5)x^2 - 7yx - 2 = 0 : 不定方程式ガチャ
  "3F983683-4841-44A5-8A49-2AADB866B6D9": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "不定方程式を解く方針を教えて", actionId: "approach_only"),
    AiChatQuickReply(label: "定数項「-2」に注目するのはなぜ？", actionId: "why_constant_term"),
    AiChatQuickReply(label: "xの候補をどうやって絞り込むの？", actionId: "how_to_narrow_x"),
  ],
//a_{n+2} + 3 a_{n+1} - 4 a_n = 0, a_1 = 1,\ a_2 = 2 : 漸化式ガチャ
  "417F69AB-5A9E-4488-9692-AA67DE3BCFF2": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この漸化式の解き方の基本方針を教えて", actionId: "approach_only"),
  ],
//\int_0^{ (\pi)/(2)} \sin^4 x dx : 積分ガチャ
  "422D4451-7399-4187-863C-165C15969BB4": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分の基本的な方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "三角関数の次数を下げるにはどうしますか？", actionId: "hint_power_reduction"),
  ],
//(n+2)a_n = n a_{n-1} + 4,\qquad a_1 = 1 \qquad (n\ge2) : 漸化式ガチャ
  "43D15683-AB09-49EE-8412-0CCB4D260EAF": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この漸化式のタイプは何ですか？", actionId: "identify_type"),
    AiChatQuickReply(label: "定数解を仮定するとはどういうことですか？", actionId: "explain_constant_solution"),
    AiChatQuickReply(label: "変数係数の漸化式を解く方針を教えてください。", actionId: "approach_only"),
  ],
//2f'(t)=12\sin(4t), f(0)=0 : 微分方程式ガチャ
  "448E166D-FEF8-4A70-8541-FCA04C82C7F8": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この微分方程式の解き方の方針を教えて", actionId: "approach_only"),
    AiChatQuickReply(label: "f'(t)は何を表していますか？", actionId: "terminology"),
    AiChatQuickReply(label: "f(0)=0という条件をどう使いますか？", actionId: "initial_condition"),
  ],
//(1)/(x) + (1)/(y) + (1)/(z) = 1 \qquad (0\le x \le y \le z) : 不定方程式ガチャ
  "479E7E6E-ED63-4F1A-BB39-42C4C598782D": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "x=1 の場合、なぜ解がないのですか？", actionId: "specific_case_x1"),
    AiChatQuickReply(label: "x=2 の場合の計算過程を詳しく教えてください", actionId: "specific_case_x2_details"),
    AiChatQuickReply(label: "恒等式 (y-2)(z-2)-4 の使い方が分かりません", actionId: "algebraic_manipulation"),
  ],
//\int_{0}^{2} \frac{dx}{\sqrt{2x + 5}} : 積分ガチャ
  "48615294-8E6C-4EFB-B9F9-5A08205FFF69": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "不定積分を求めるにはどうすればいいですか？", actionId: "hint_indefinite_integral"),
  ],
//\lim_{n\to\infty}\frac{n!}{n^{n}} : 極限ガチャ
  "48677C5D-732B-4C47-B4AA-645616D8C392": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この極限の基本的な考え方は？", actionId: "approach_only"),
    AiChatQuickReply(label: "n! と n^n のどちらが速く増加しますか？", actionId: "comparison_hint"),
  ],
//\sqrt{3}\sin x + \cos x = 1, 0 \leq x < 2\pi : 三角指数対数ガチャ
  "487CBF1E-4AAB-490D-BFF5-86DF2F9F075C": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この式はどうやって解けばいいですか？", actionId: "approach_only"),
  ],
//\int_{2}^{5}(x-2)^2(5-x)^2 dx : 積分ガチャ
  "48B05BE5-7632-4228-BF46-F8476E23E0CF": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "定積分を計算する一般的な方法を教えて", actionId: "general_approach"),
  ],
//(n+1)a_n = (n-1)a_{n-1}, a_1 = 2 (n\ge2) : 漸化式ガチャ
  "48F0A009-A401-42C4-9AC5-E84555D43257": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この漸化式のタイプは何ですか？", actionId: "problem_type"),
    AiChatQuickReply(label: "a_nを求める方針を教えてください", actionId: "approach_only"),
  ],
//\lim_{n\to\infty}\sum_{k=1}^{n}(1)/(k) : 極限ガチャ
  "4E839CEA-B995-4D8D-812D-C23546487B0E": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "発散しそうに見えますが、どう証明しますか？", sendText: "この級数が発散するという直感がありますが、それを数学的にどう証明すれば良いでしょうか？", actionId: "approach_divergence"),
    AiChatQuickReply(label: "積分を使って考えることはできますか？", sendText: "このタイプの級数の極限を考える際に、積分を使う方法は有効ですか？", actionId: "hint_integral"),
  ],
//\int_{1}^{\sqrt{3}}\frac{1}{x^{2}+3} dx : 積分ガチャ
  "4E93591C-AFE6-41F0-A2E9-4A32C796D02B": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分の解き方を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "積分範囲の変換について教えてください", actionId: "range_conversion"),
  ],
//391x + 287y = 1 : 不定方程式ガチャ
  "4F6568BE-B67F-46E7-859C-F22766018567": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", sendText: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "不定方程式の解き方について教えてください", sendText: "不定方程式の解き方について教えてください。", actionId: "how_to_solve_diophantine"),
  ],
//f''(t) = -4 f(t), f(0) = 0,\ f'(0) = 2 : 微分方程式ガチャ
  "4F674DAB-329F-45CC-9417-94C45BE5B203": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この微分方程式の解き方の基本方針は？", actionId: "approach_only"),
    AiChatQuickReply(label: "二階同次・定数係数微分方程式とは？", actionId: "definition_homogeneous_ode"),
    AiChatQuickReply(label: "初期条件 f(0)=0, f'(0)=2 はどう使う？", actionId: "how_to_use_initial_conditions"),
  ],
//x^2 + 8xy + 16y^2 : 因数分解ガチャ
  "51B65EA2-37AB-48F9-ACBE-2482B9740A10": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "どういう方針で解けばいい？", actionId: "approach_only"),
  ],
//\lim_{x\to \infty}\left(1+(1)/(x)\right)^{2x} : 極限ガチャ
  "53BC96C5-2D01-45FE-9A39-F369BA9E2097": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "変数変換は必要ですか？", actionId: "hint_variable_substitution"),
  ],
//9x^3y - 16xy^3 : 因数分解ガチャ
  "546F77A4-9EED-4FED-92F4-8E22927D77C8": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の基本は何ですか？", actionId: "factoring_basics"),
    AiChatQuickReply(label: "共通因数を見つけるには？", actionId: "find_common_factor"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
  ],
//\frac{3^x - 3^{-x}}{3^x + 3^{-x}} = (1)/(5) : 三角指数対数ガチャ
  "54B8A495-B84C-4CFE-8B99-9C45B22E2CE0": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "分母分子に何かをかけると良さそうでしょうか？", actionId: "hint_manipulation"),
    AiChatQuickReply(label: "指数法則について確認したいです", actionId: "review_exponent_rules"),
  ],
//(\int_0^t f(s) ds)/(a)+bf(t)=F\cos(\omega t), f(0)=f_0 : 微分方程式ガチャ
  "574DF54B-E141-4B50-944D-F38724F1ADC3": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この方程式の種類は何ですか？", actionId: "equation_type"),
    AiChatQuickReply(label: "解法の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "初期条件 f(0)=F/b はどう使いますか？", actionId: "initial_condition_usage"),
    AiChatQuickReply(label: "積分を含む方程式の解き方について教えてください。", actionId: "integral_equation_hint"),
  ],
//3x^2−2xy+2y^2−2x+4y−1=0 : 不定方程式ガチャ
  "595AEE6D-B85D-45AE-AB48-641EC064B6EB": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "判別式を使うのはなぜですか？", actionId: "why_discriminant"),
    AiChatQuickReply(label: "整数解を求めるにはどうすればいいですか？", actionId: "how_to_find_integer_solutions"),
  ],
//a_n = 4\sqrt{a_{n-1}},\qquad a_1 = 8 \qquad (n\ge2) : 漸化式ガチャ
  "5AE63216-BADE-46E5-A90B-18933C16F2FE": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この漸化式のタイプは何ですか？", actionId: "identify_type"),
    AiChatQuickReply(label: "両辺を2乗してみるのはどうですか？", actionId: "try_squaring"),
    AiChatQuickReply(label: "対数を取るのは有効ですか？", actionId: "consider_logarithm"),
  ],
//4x^2 - y^2 = 32 : 不定方程式ガチャ
  "5B9CCE39-6329-4F9D-8E86-20D97B7760A2": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "左辺の因数分解について教えてください。", actionId: "factorization_hint"),
    AiChatQuickReply(label: "32の約数をどう使えばいいですか？", actionId: "divisor_usage"),
  ],
//x^2 + 6xy + 9y^2 : 因数分解ガチャ
  "5F7F2DCD-4A6E-4BA1-B97A-1F9B7B6809A4": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この式の特徴は何ですか？", sendText: "x^2 + 6xy + 9y^2 の式には、何か特徴がありますか？"),
  ],
//\int_{0}^{(\pi)/(4)} \tan^6 x dx : 積分ガチャ
  "5F800251-23AC-4487-8BD4-3BC209617EF6": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "tan^n x の積分でよく使う変形はありますか？", actionId: "hint_tan_integral"),
    AiChatQuickReply(label: "漸化式を使うのはなぜですか？", actionId: "why_recurrence"),
  ],
//f'(t)=g, f(0) = f_0 : 微分方程式ガチャ
  "5FDE5472-2F31-46C7-89A5-F564360CD6C5": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この微分方程式の解き方を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "f'(t)は何を表していますか？", actionId: "term_meaning"),
    AiChatQuickReply(label: "積分を使って解くにはどうすればいいですか？", actionId: "hint_integration"),
  ],
//f''(t)+3 f'(t)=2, f(0)=1,\ f'(0)=5 : 微分方程式ガチャ
  "5FFA2B66-BA71-44F4-9834-EF997E17081D": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この微分方程式の解き方を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "f'(t) = u(t) と置換するのはなぜですか？", actionId: "why_substitution"),
    AiChatQuickReply(label: "初期条件をどのように使いますか？", actionId: "how_to_use_initial_conditions"),
  ],
//\lim_{n \to \infty} \sum_{k=1}^{n} (1)/(n+k) : 極限ガチャ
  "630FBD47-A86B-4108-8F90-86F202047B8D": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えて", actionId: "approach_only"),
    AiChatQuickReply(label: "シグマの中の式を変形するには？", actionId: "transform_expression"),
  ],
//3x^2 + 8xy + 4y^2 - 11x - 6y - 4 : 因数分解ガチャ
  "656CDF93-3968-4527-81AE-9376B3E5B66B": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "どういう方針で解けばいいですか？", sendText: "この問題は、どういう方針で解けばいいですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "xについて整理するとはどういうことですか？"),
  ],
//\sqrt{3}f'(t)+2f(t)=3\sqrt{3}\cos(2t), f(0)=0 : 微分方程式ガチャ
  "666687A5-6EF8-434E-9209-818CE7092863": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この微分方程式の種類は何ですか？", actionId: "equation_type"),
    AiChatQuickReply(label: "非斉次微分方程式の解き方を教えてください。", actionId: "approach_nonhomogeneous"),
    AiChatQuickReply(label: "初期条件f(0)=0はどのように使いますか？", actionId: "initial_condition_usage"),
  ],
//\cos 5x = 0, 0 \leq x < 2\pi : 三角指数対数ガチャ
  "66847D9E-40D3-437C-9499-BF4A62B783B7": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "cos A = 0 の一般解は何ですか？", actionId: "general_solution"),
    AiChatQuickReply(label: "5x の範囲はどうなりますか？", actionId: "range_of_argument"),
  ],
//\int_{ \frac12}^{ \frac32}\left(x-\frac12\right)\left(\frac32-x\right)^2 dx : 積分ガチャ
  "6705BE2F-10DF-484F-8E32-768EE0F07E15": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分の形に何か特徴はありますか？", actionId: "approach_only"),
  ],
//\int_{0}^{(\pi)/(4)} \sin x \cos x dx : 積分ガチャ
  "680C8A2D-4E18-4E76-97F7-5F59531CD4DD": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "sin x cos x の積分はどうすればいいですか？", actionId: "specific_integral_hint"),
  ],
//f''(t)=2, f(0)=-1,\ f'(0)=3 : 微分方程式ガチャ
  "6B6506AA-7296-4C18-9A00-44CAF515FDD4": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "初期条件をどのように使いますか？", actionId: "initial_conditions_usage"),
  ],
//a^3 + 18ab - 8b^3 + 27 : 因数分解ガチャ
  "6C4F2FA4-742F-474E-8103-E3BA3E979350": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の一般的な方針は？", actionId: "approach_only"),
  ],
//\lim_{n\to\infty}(1)/(n)\sum_{k=0}^{2n}\cos\!\left((\pi k)/(n)\right) : 極限ガチャ
  "6C703101-29A6-4005-87D6-594F60194AFC": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えて", actionId: "approach_only"),
    AiChatQuickReply(label: "積分区間はどうやって決めるの？", actionId: "integral_range"),
    AiChatQuickReply(label: "cos(πk/n) をどう扱えばいい？", actionId: "handle_expression"),
  ],
//\lim_{x\to 0}(\log(1+2x))/(x) : 極限ガチャ
  "6D0B855E-7E52-4C1B-8A44-AA9FF0FB03B3": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この極限の基本的な考え方を知りたい", actionId: "approach_only"),
    AiChatQuickReply(label: "log(1+x)/x の極限と関係ありますか？", actionId: "relate_to_standard_limit"),
  ],
//5x^2 + 2xy + y^2 - 12x + 4y + 11 = 0 : 不定方程式ガチャ
  "6ED3659C-A465-4E25-A2B2-4CAF4FEAEDA5": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この方程式の形から、どんな解法が考えられますか？", actionId: "approach_only"),
    AiChatQuickReply(label: "判別式を使うとどうなりますか？", actionId: "discriminant_hint"),
  ],
//\int_{0}^{\log 2} \frac{e^{2x}}{(1+e^x)^2} dx : 積分ガチャ
  "6FD0F698-5284-4008-A239-84083F7520B2": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分の基本的な方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "e^x を含む積分の解き方のコツはありますか？", actionId: "hint_exponential_integral"),
  ],
//\lim_{x\to 0}(\sin(3x))/(x) : 極限ガチャ
  "701CF34C-DB84-4CD4-BD3B-0DDE311D6A0F": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の解き方を教えてください", sendText: "この問題の解き方を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "sin(ax)/x の極限について教えてください", sendText: "sin(ax)/x の極限について教えてください。", actionId: "concept_explanation"),
  ],
//x^4 + x^2 + 1 : 因数分解ガチャ
  "703AE189-789C-4F2D-83A4-55C68DD65991": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の基本的な方針を教えて", sendText: "この式の因数分解について、基本的な方針を教えてください。", actionId: "approach_only"),
  ],
//(1)/(x) + (1)/(y) = (1)/(7) : 不定方程式ガチャ
  "70FFD2EF-5335-4593-86B4-0060A4295D31": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
  ],
//\lim_{x\to 0}\frac{1-e^{-x}}{x} : 極限ガチャ
  "71ECF2CF-206F-43FF-BA35-F097D1FEB231": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "eのx乗の極限の性質について教えてください。", actionId: "e_limit_property"),
  ],
//a_{n+2} - 4a_{n+1} + 4a_n = 0, a_1 = 1,\ a_2 = 6 : 漸化式ガチャ
  "73D06F52-2C0D-4118-84C6-662FAA49A553": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この漸化式の解き方の基本方針を教えて", actionId: "approach_only"),
    AiChatQuickReply(label: "重根の場合の一般項の形を教えて", actionId: "general_term_form"),
  ],
//x^2 + 13y^2 = 413 : 不定方程式ガチャ
  "73F50D01-0B10-4D81-A565-163E48987C2E": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "不定方程式の解き方の基本は？", actionId: "approach_only"),
    AiChatQuickReply(label: "mod 13で考えるのはなぜ？", actionId: "why_mod_13"),
  ],
//a^3 - a b^2 - b^2 c + a^2 c : 因数分解ガチャ
  "7474E9C1-6272-4491-8807-C095BDE7AD6F": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の基本的な方針を教えて", actionId: "approach_only"),
    AiChatQuickReply(label: "この式をどう整理すればいい？", actionId: "how_to_organize"),
    AiChatQuickReply(label: "共通因数を見つけるコツは？", actionId: "common_factor_tip"),
  ],
//\int_{0}^{1} \frac{dx}{1 + x^{2}} : 積分ガチャ
  "76E997DF-6492-444C-91C9-F3EC13EB7F41": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分の解き方の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "1/(1+x^2) の積分はどのように考えますか？", actionId: "function_hint"),
    AiChatQuickReply(label: "積分の範囲はどのように変わりますか？", actionId: "limits_hint"),
  ],
//\lim_{x\to 0}\frac{\sqrt{1+x}-1}{x} : 極限ガチャ
  "774E49FD-A51A-4756-916A-52C94A3810BA": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
  ],
//x^4 + 2x^3 + 2x^2 + 2x + 1 : 因数分解ガチャ
  "79E62DF5-7FEB-4D58-A989-DF5110913E3C": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の一般的な方針を教えて", sendText: "この式の因数分解の一般的な方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "何か特別な形に気づく？", sendText: "この式は何か特別な形をしていますか？", actionId: "hint_special_form"),
  ],
//\lim_{x\to\infty}\int_{0}^{x}t^{5}e^{-t} dt : 極限ガチャ
  "7A1F3B90-6E2C-4D8A-9B4F-1C2D3E4F5A33": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分の計算方針を教えて", actionId: "approach_only"),
  ],
//64x^3 - 27y^3 : 因数分解ガチャ
  "7AF1A86F-615F-4E44-AEE8-F3BA22B7E6CC": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "64x^3と27y^3をどう見ればいいですか？", actionId: "hint_rephrase"),
  ],
//a_{n+1} = 2a_n + 3, a_1 = 1 : 漸化式ガチャ
  "7D0760FF-946D-469A-842D-60D426A01724": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この漸化式のタイプは何ですか？", actionId: "identify_type"),
  ],
//49x^2 - 36y^2 : 因数分解ガチャ
  "7D86EF83-52D7-4F6D-9A35-E085E17DA59C": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の基本方針を教えて", actionId: "approach_only"),
  ],
//(\int_0^t f(s) ds)/(0.2)=8\sin(10t), f(0)=0 : 微分方程式ガチャ
  "7E10C37B-AB59-4B49-8037-D1D34D1B3055": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "式をf(t)について解く方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "積分の式を微分するとどうなりますか？", actionId: "hint_differentiation"),
    AiChatQuickReply(label: "f(0)=0の条件はどのように使いますか？", actionId: "hint_initial_condition"),
  ],
//\int_{1}^{2} (dx)/(x\log x) : 積分ガチャ
  "7FF2277B-44DC-480A-B1BF-7D1990121B24": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", sendText: "この問題の方針を教えてください。", actionId: "approach_only"),
  ],
//\lim_{x\to 1}\frac{x^{5}-1}{x-1} : 極限ガチャ
  "81279279-68BC-46E4-96E8-C6188AD7617D": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", sendText: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "x^5-1 の因数分解について教えてください", sendText: "x^5-1 をどのように因数分解すればよいですか？", actionId: "factoring_hint"),
    AiChatQuickReply(label: "極限の計算で注意すべき点はありますか？", sendText: "このタイプの極限を計算する上で、何か注意すべき点はありますか？", actionId: "limit_caution"),
  ],
//x^5 + x^4 + 1 : 因数分解ガチャ
  "8207893B-5988-4EF1-80C7-74D75FECFE3E": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の一般的な方針は何ですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "他に試せる因数分解の方法はありますか？", actionId: "hint_method"),
    AiChatQuickReply(label: "この式の特徴は何ですか？", actionId: "analyze_expression"),
  ],
//a_{n+1} = 6a_n + b_n,\\[4pt] : 漸化式ガチャ
  "863C1DB8-6D69-4926-93D3-24FE77194C4D": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "連立漸化式の解き方の基本方針は？", actionId: "approach_only"),
    AiChatQuickReply(label: "3項間漸化式に帰着させるには？", actionId: "hint_three_term"),
  ],
//36x^2 - 25y^2 : 因数分解ガチャ
  "897713C5-D885-4103-937C-62F11F4E5C18": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の基本方針を教えて", actionId: "approach_only"),
  ],
//x^3 + 2x^2 - 5x - 6 : 因数分解ガチャ
  "8B1C27DD-2BAC-41F5-8D5B-2B1F58AB12ED": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の一般的な方針を教えて", sendText: "この式の因数分解の一般的な方針を教えてください。", actionId: "approach_only"),
  ],
//\lim_{x\to 0}\frac{e^{x}-e^{-x}}{2x} : 極限ガチャ
  "8BB1FDF5-A692-41E5-9B88-E62F9E4B96BA": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "e^x - e^-x の部分はどう変形しますか？", actionId: "specific_transformation"),
  ],
//x^4 - 3x^3 + 3x^2 - 3x + 2 : 因数分解ガチャ
  "8C5A89E9-86F8-4300-9179-3C9CF22FDF90": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の一般的な方針を教えて", actionId: "approach_only"),
  ],
//a_{n+1} = (4a_n + 3)/(a_n + 2), a_1 = 2 : 漸化式ガチャ
  "8CF61D01-3229-4ABF-BC3F-46A7681BBFEF": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この漸化式のタイプは何ですか？", actionId: "recurrence_type"),
    AiChatQuickReply(label: "どういう方針で解き進めますか？", actionId: "approach_only"),
  ],
//\int_{3}^{6}\frac{1}{x^{2}-4} dx : 積分ガチャ
  "8FB8536A-3433-4F7A-8B29-B44DC4186F09": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "定積分の計算で注意することはありますか？", actionId: "definite_integral_tip"),
  ],
//\lim_{h\to \infty}(1+h)^{(1)/(h)} : 極限ガチャ
  "9161EDD7-12DE-4729-A2A7-9A55E060C466": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この極限の形は何を表していますか？", actionId: "limit_form_meaning"),
    AiChatQuickReply(label: "どういう方針で解き始めればいいですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "指数に変数がある極限の一般的な解き方は？", actionId: "general_method_exponential_limit"),
    AiChatQuickReply(label: "対数を使うのはなぜですか？", actionId: "why_logarithm"),
  ],
//4x^3y - 9xy^3 : 因数分解ガチャ
  "93BDE66A-D463-457F-A1C0-249A521A0B81": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "因数分解の基本は何ですか？", actionId: "factoring_basics"),
    AiChatQuickReply(label: "共通因数を見つけるには？", actionId: "common_factor_hint"),
  ],
//\int_{-1}^{1}\left|x^2-(1)/(4)\right| dx : 積分ガチャ
  "9477B6DC-F0A3-4B53-8891-212FED0C5886": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "絶対値の外し方を教えて", actionId: "remove_abs_value"),
    AiChatQuickReply(label: "偶関数を使うとどうなりますか？", actionId: "even_function_hint"),
    AiChatQuickReply(label: "積分区間の分け方を教えてください", actionId: "split_interval"),
  ],
//a_{n+1} = 2a_n + n^2 + 1, a_1 = 1 : 漸化式ガチャ
  "98C763E5-86DB-47A3-B2EF-D070244EC978": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この漸化式の解き方の基本方針を教えて", actionId: "approach_only"),
    AiChatQuickReply(label: "右辺にnの2次式がある場合、どう考えればいい？", actionId: "hint_specific_form"),
  ],
//\sum_{k=1}^{\infty}\frac{1}{2^{k}}\sin\!\left((2k\pi)/(3)\right) : 極限ガチャ
  "9A2E7C44-1B3A-4D7B-9E7F-2E3C1F6B8C10": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "sin(2kπ/3) の値の周期性について教えてください", actionId: "term_meaning"),
    AiChatQuickReply(label: "無限級数の和の求め方の方針を教えてください", actionId: "approach_only"),
  ],
//f'(t)=2, f(0)=1 : 微分方程式ガチャ
  "9B75DE01-6B72-487F-B653-EE769057E58B": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "f'(t)=2は何を意味していますか？", actionId: "meaning_of_notation"),
    AiChatQuickReply(label: "f'(t)からf(t)を求めるにはどうすればいいですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "f(0)=1という条件をどう使いますか？", actionId: "initial_condition_usage"),
  ],
//\int_{ \frac {\pi} {2}}^{ \frac {5} {2}\pi}\sqrt{1+\sin x}\ dx : 積分ガチャ
  "9BC1C756-BFC5-41C7-8751-D78DF6430084": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "まずは方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "絶対値の処理について教えてください", actionId: "absolute_value_hint"),
    AiChatQuickReply(label: "積分区間の分割について教えてください", actionId: "integration_interval_hint"),
  ],
//\lim_{x\to 0}(\cos x-\cos x^2)/(x-x^2) : 極限ガチャ
  "9D8F2E21-0F37-4C8B-A5B4-7A4F2B3A0C11": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
  ],
//\int_0^{2\pi} \sqrt{2 - 2\cos x} dx : 積分ガチャ
  "9E0F1A2B-3C4D-5E6F-7A8B-9C0D1E2F3C4D": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "どういう方針で解けばいいですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "ルートの中身を簡単にするには？", actionId: "simplify_radical"),
    AiChatQuickReply(label: "絶対値の扱いについて教えてください", actionId: "absolute_value_handling"),
  ],
//a_{n+1} = 2a_n + 3^n, a_1 = 1 : 漸化式ガチャ
  "9F9BF526-C923-4508-A690-C5E04D27A79E": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この漸化式のタイプは何ですか？", actionId: "identify_type"),
    AiChatQuickReply(label: "解き方の基本的な方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "右辺に3^nがあるのが特徴的ですね。", actionId: "focus_on_rhs"),
  ],
//3^x + 3^{x+1} = 9^x : 三角指数対数ガチャ
  "A029A6D1-EB0C-4D46-9DDE-51ED580623C7": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "3の累乗で表すにはどうすればいいですか？", actionId: "simplify_terms"),
    AiChatQuickReply(label: "指数方程式を解くときのポイントは？", actionId: "hint_strategy"),
  ],
//\int_{2}^{5}(x-2)(5-x) dx : 積分ガチャ
  "A056E0E4-7F5B-4EC7-ACC2-F91C38585F7E": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分の計算方法を教えてください", actionId: "approach_only"),
  ],
//\int_{ \frac {\pi} {4}}^{(\pi)/(3)}\tan^{2}x\left(\tan^{2}x+1\right) dx : 積分ガチャ
  "A191EF43-6467-4047-8FE9-BFEE5B89D08E": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分の解き方の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "tan x を含む積分のコツはありますか？", actionId: "hint_tan_integral"),
  ],
//\int_0^1 \sqrt{1 + 4x^2} dx : 積分ガチャ
  "A1B2C3D4-E5F6-7890-ABCD-EF1234567890": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この積分がどのような問題で現れるか教えてください。", actionId: "context"),
  ],
//3^x + 3^{-x} + 9^x + 9^{-x} = 4 : 三角指数対数ガチャ
  "A1B2C3D4-E5F6-A7B8-C9D0-E1F2A3B4C5D6": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "どういう方針で解けばいいですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "指数方程式を解くときのポイントは？", actionId: "general_tip"),
  ],
//\int_{(\pi)/(6)}^{(\pi)/(2)} (dx)/(\sin x) : 積分ガチャ
  "A1B2C3D4-E5F6-G7H8-I9J0-K1L2M3N4O5": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "積分の基本的な方針を教えて", actionId: "approach_only"),
  ],
//\int_{0}^{1}\frac{1}{1+x^{3}} dx : 積分ガチャ
  "A36F411F-99B5-40E0-8BE1-F9126992BA14": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "まずは方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "定積分の計算で注意すべき点は？", actionId: "integral_tips"),
  ],
//\int_{0}^{ (1)/(2)\log 3} \frac{2}{e^x+e^{-x}}dx : 積分ガチャ
  "A370BF54-FFB7-4B23-BFA7-522C277250B8": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "どういう方針で解き進めればいいですか？", actionId: "approach_only"),
  ],
//\lim_{n\to\infty}\sqrt[n]{n} : 極限ガチャ
  "A39DF72B-47BA-473A-83D4-5D35E8ADD533": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "どういう方針で解けばいいですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "対数変換を使うのはなぜですか？", actionId: "why_log_transform"),
  ],
//(\int_0^t f(s) ds)/(C)=A\sin(\omega t), f(0)=0 : 微分方程式ガチャ
  "A3ECB1EE-67C3-4B41-B8ED-13669F16A63D": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "積分の記号を消すにはどうすればいい？", actionId: "hint_integral_removal"),
    AiChatQuickReply(label: "両辺を微分する方針で合ってる？", actionId: "approach_confirmation"),
    AiChatQuickReply(label: "三角関数の変換について教えて", actionId: "hint_trigonometric_identity"),
  ],
//\lim_{n\to\infty}(\log(n!))/(n\log n-n) : 極限ガチャ
  "A4F3C2D1-7B6E-4C2A-9E3B-1D8C0E7F5A12": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "問題の方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "スターリングの近似を使えますか？", actionId: "related_concept"),
    AiChatQuickReply(label: "計算で注意すべき点はありますか？", actionId: "calculation_tip"),
  ],
//\int_{-(\pi)/(4)}^{(\pi)/(4)} \cos^3 x dx : 積分ガチャ
  "A5B6C7D8-E9F0-1234-5678-9ABCDEF01234": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この定積分の計算方針を教えて", actionId: "approach_only"),
    AiChatQuickReply(label: "積分区間が対称なときに使える性質は？", actionId: "hint_symmetry"),
    AiChatQuickReply(label: "三角関数の3乗の積分は、どう変形する？", actionId: "hint_transformation"),
  ],
//a^3 - 4a b^2 - 4b^2 c + a^2 c : 因数分解ガチャ
  "A5BA5B5C-1557-48C1-B4D3-7C57FC5E3A41": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の基本的な方針を教えて", actionId: "approach_only"),
    AiChatQuickReply(label: "共通因数を見つけるにはどうすればいい？", actionId: "hint_common_factor"),
    AiChatQuickReply(label: "文字が複数あるときの整理の仕方は？", actionId: "hint_organize_variables"),
  ],
//\lim_{n \to \infty} (1)/(n) \sum_{k=1}^{n} (1)/(n+k) : 極限ガチャ
  "A5E3309B-0558-4CCE-8B01-62E93D2FC90E": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "どういう方針で解けばいい？", actionId: "approach_only"),
    AiChatQuickReply(label: "シグマの中身をどう変形する？", actionId: "transform_sum_term"),
  ],
//\lim_{n\to\infty}\frac{2^{n}}{n!} : 極限ガチャ
  "A60C22EA-24D4-4C3B-A60A-90996784D9C5": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この極限の考え方を教えてください", sendText: "この極限の問題をどのように考えれば良いですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "指数関数と階乗の成長速度について教えて", sendText: "指数関数と階乗の成長速度について教えてください。", actionId: "concept_comparison"),
  ],
//x^3 + 64 : 因数分解ガチャ
  "A60F2EC9-A23B-420B-89BE-6D8708B0DFA8": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", sendText: "この問題の方針を教えてください。", actionId: "approach_only"),
  ],
//(\int_0^t f(s) ds)/(2)+\sqrt{3}f(t)=4\cos\left((t)/(2)\right), f(0)=0 : 微分方程式ガチャ
  "A6304C30-50F4-40E4-A056-A57A60548064": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "積分を含む方程式の解き方について教えてください。", actionId: "hint_integral_equation"),
    AiChatQuickReply(label: "微分方程式に変換できますか？", actionId: "hint_convert_to_ode"),
    AiChatQuickReply(label: "f(0)=0という条件をどう使いますか？", actionId: "hint_initial_condition"),
  ],
//ab - bc + cd - da : 因数分解ガチャ
  "A73464B2-66D9-47E5-8069-94AC68CDB90F": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の基本的な方針を教えて", actionId: "approach_only"),
    AiChatQuickReply(label: "共通因数を見つけるコツは？", actionId: "hint_common_factor"),
    AiChatQuickReply(label: "項の並べ替え方について教えて", actionId: "hint_rearrange_terms"),
  ],
//a_{n+1} = (a_n - 9)/(a_n - 5), a_1 = 2 : 漸化式ガチャ
  "A8B9C0D1-2E3F-4A5B-6C7D-8E9F0A1B2C3": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この漸化式のタイプは何ですか？", actionId: "identify_type"),
    AiChatQuickReply(label: "定数解を使う方法について教えてください。", actionId: "explain_fixed_point"),
    AiChatQuickReply(label: "分数型の漸化式の解き方の基本方針を知りたい。", actionId: "approach_only"),
  ],
//x^2 + 6y^2 = 223 : 不定方程式ガチャ
  "A8B9C0D1-E2F3-4A5B-6C7D-8E9F0A1B2C3": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "不定方程式を解く方針を知りたい", actionId: "approach_only"),
    AiChatQuickReply(label: "moduloを使うとどうなる？", actionId: "hint_modulo"),
    AiChatQuickReply(label: "x^2 + 6y^2 = 223 の意味は？", actionId: "problem_meaning"),
  ],
//\lim_{x\to(\pi)/(2)}\cos(3x)\tan(5x) : 極限ガチャ
  "A8B9C0D1-E2F3-4A5B-6C7D-8E9F0A1B2C3D": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この極限を解くための方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "変数変換は何のために行いますか？", actionId: "why_substitution"),
    AiChatQuickReply(label: "t=x-π/2と置換すると、式はどう変わりますか？", actionId: "substitution_details"),
  ],
//xy - 2x - y = 5 : 不定方程式ガチャ
  "AA271833-9840-40EE-924F-1D94AD63FEB6": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "式を変形するヒントが欲しいです。", actionId: "hint_rearrange_equation"),
  ],
//a_n = \frac {1}{2}(a_{n-1})^2,\qquad a_1 = 5 \qquad (n\ge2) : 漸化式ガチャ
  "AB08A968-36A0-40E9-B392-651BAE535DA9": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この漸化式のタイプは何ですか？", actionId: "identify_type"),
    AiChatQuickReply(label: "非線形漸化式の一般的な解法は？", actionId: "general_approach"),
    AiChatQuickReply(label: "対数を取るのはなぜ有効なのですか？", actionId: "why_logarithm"),
  ],
//(2-2)+(2-2)+(2-2)+\cdots : 極限ガチャ
  "ABE37AA2-9FEC-4ADD-9022-1A38340249F1": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この式はどんな数列を表しているの？", sendText: "この無限級数の各項はどのような値になりますか？", actionId: "analyze_series_terms"),
  ],
//\int_{-2}^{2} x^4 \sin^5 x dx : 積分ガチャ
  "AC0C8F06-65FE-4FDD-8DB8-04252764D3CB": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分を解くための方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "偶関数と奇関数の性質について教えてください。", actionId: "hint_odd_even_properties"),
    AiChatQuickReply(label: "sin^5 x は偶関数ですか、奇関数ですか？", actionId: "check_sin_power"),
  ],
//f''(t) + 2\beta f'(t) + \omega_0^2 f(t) = 0, f(0) = f_0,\ f'(0) = v_0,\ \omega_0 > \beta > 0 : 微分方程式ガチャ
  "ADC1559C-5A8D-490C-9D10-8722FECF3115": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この微分方程式の解き方の基本方針を教えて", actionId: "approach_only"),
    AiChatQuickReply(label: "変数変換で1階微分を消すとはどういうこと？", actionId: "variable_substitution"),
    AiChatQuickReply(label: "初期条件の扱い方について教えて", actionId: "initial_conditions"),
    AiChatQuickReply(label: "物理的な意味合いについて教えて", actionId: "physical_meaning"),
  ],
//\lim_{n\to\infty}\sum_{k=1}^{n}\frac{(-1)^{k+1}}{k} : 極限ガチャ
  "AF028FDC-E4ED-4B5D-907A-FD053AA682F0": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この級数の名前は何ですか？", actionId: "series_name"),
    AiChatQuickReply(label: "極限の計算方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "積分を使って考える方法はありますか？", actionId: "integral_approach"),
  ],
//2x^2 + 11xy + 12y^2 - 5y - 5 = 0 : 不定方程式ガチャ
  "AF7A04F4-3FFC-435D-ACF7-C0741E7B23F8": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の解き方の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "二変数二次方程式の解法について教えてください。", actionId: "method_explanation"),
    AiChatQuickReply(label: "式を因数分解できますか？", actionId: "factorization_hint"),
  ],
//\int_{0}^{(\pi)/(2)} \sin^7 x \cos^9 x dx : 積分ガチャ
  "B1C2D3E4-F5G6-7890-HIJK-LM1234567890": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分の一般的な解法方針は？", actionId: "approach_only"),
    AiChatQuickReply(label: "sinとcosの指数が両方奇数の場合、どうすればいい？", actionId: "strategy_odd_powers"),
  ],
//7x - 3y + 13z = 2 : 不定方程式ガチャ
  "B1D8559E-D3F4-45DA-A889-8056A50EE5A8": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "不定方程式の解き方の方針を知りたい", actionId: "approach_only"),
    AiChatQuickReply(label: "3つの文字があるけど、どう考えればいい？", actionId: "how_to_handle_3_variables"),
    AiChatQuickReply(label: "係数の7, 3, 13に何か意味はある？", actionId: "meaning_of_coefficients"),
  ],
//\lim_{x\to \infty} x \sin\!\left((1)/(x)\right) : 極限ガチャ
  "B2198AC3-050B-4F1D-B584-A2C5DC3CA60F": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", sendText: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "極限の公式で使えるものはありますか？", sendText: "この極限の問題を解く上で、使える公式はありますか？"),
  ],
//\begin{cases} \sin x + \cos y = 1 \\[8pt] \cos x + \sin y = \sqrt{3} \end{cases}, 0 \leq x < 2\pi, 0 \leq y < 2\pi : 三角指数対数ガチャ
  "B2C3D4E5-F6A7-B8C9-D0E1-F2A3B4C5D6E7": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "2つの式を足したり引いたりするのは有効ですか？", actionId: "approach_add_subtract"),
    AiChatQuickReply(label: "xとyの範囲はどのように考慮しますか？", actionId: "hint_range"),
  ],
//f''(t)+2 f'(t)+3 f(t)=12\cos(3t), f(0)=0,\ f'(0)=0 : 微分方程式ガチャ
  "B2C3D4E5-F6G7-8901-BCDE-F2345678901": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "「定常状態」とはどういう意味ですか？", actionId: "meaning_steady_state"),
    AiChatQuickReply(label: "この微分方程式の解き方の全体像を教えてください。", actionId: "approach_only"),
  ],
//\int_{0}^{(\pi)/(4)} (dx)/(\cos x) : 積分ガチャ
  "B2C3D4E5-F6G7-H8I9-J0K1-L2M3N4O5P6": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分の解き方の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "分母にcos xがあるのが難しいです。", sendText: "分母にcos xがあるのが難しいです。どうすればいいですか？"),
  ],
//x^7 + x^6 + x^5 + x^4 + x^3 + x^2 + x + 1 : 因数分解ガチャ
  "B38E9107-4CB3-4966-AAA8-6966FC3F8B17": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の一般的な方針を教えて", sendText: "この式の因数分解の一般的な方針を教えてください。", actionId: "approach_only"),
  ],
//Lf'(t)=A\sin(\omega t), f(0)=0 : 微分方程式ガチャ
  "B4FDC2FF-78D4-5C52-C9FE-2477A027B74E": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この微分方程式の解き方の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "sin(ωt)の積分はどうなりますか？", actionId: "integration_hint"),
    AiChatQuickReply(label: "初期条件f(0)=0はどう使いますか？", actionId: "initial_condition"),
  ],
//x^2 - 2xy - 2x + 6y - 6 = 0 : 不定方程式ガチャ
  "B8F9C5D2-4E6A-4F8B-9C1D-3A5B7C9D1E2F": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この方程式をどう解けばいいですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "因数分解はできますか？", actionId: "hint_factorization"),
    AiChatQuickReply(label: "二変数二次方程式の解き方を教えて", actionId: "approach_general"),
  ],
//\int_{-(\pi)/(6)}^{(\pi)/(6)} (dx)/(\cos^3 x) : 積分ガチャ
  "B9B22B73-65CB-4AE7-A6BF-79E52EEDA3BC": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "被積分関数が偶関数であることは利用できますか？", actionId: "approach_even_function"),
    AiChatQuickReply(label: "三角関数の分数式の積分でよく使う手法はありますか？", actionId: "approach_technique"),
  ],
//x^3 - 2x^2 - 5x + 6 : 因数分解ガチャ
  "B9C0D1E2-F3A4-5B6C-7D8E-9F0A1B2C3D4": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この式の因数分解の基本的な方針を教えて", sendText: "この式の因数分解の基本的な方針を教えてください。", actionId: "approach_only"),
  ],
//\lim_{x\to 0}(\log(1+x))/(x) : 極限ガチャ
  "BB41368E-ACE1-4D11-B8A8-CEB3918B6EE5": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この極限の形は何を表していますか？", actionId: "what_form"),
  ],
//\lim_{n\to\infty} n\!\left(\sqrt{n+1}-\sqrt{n}\right) : 極限ガチャ
  "BCC5BF01-27BE-4D8C-8E40-8923C764BBEC": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えて", sendText: "この問題の方針を教えてください。", actionId: "approach_only"),
  ],
//\int_{2}^{2\sqrt{3}} \frac{dx}{\sqrt{16 - x^{2}}} : 積分ガチャ
  "BDCAAAB3-8109-4E6B-8A45-9EFD024A0B05": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分の解き方の方針を教えてください。", actionId: "approach_only"),
  ],
//a_{n+1} = (a_n)/(a_n + 1), a_1 = 1 : 漸化式ガチャ
  "BE1669B0-E7C4-4855-B98E-2F2AE53B7981": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この漸化式のタイプは何ですか？", actionId: "identify_type"),
    AiChatQuickReply(label: "a_2, a_3 を計算してみましょう", actionId: "calculate_terms"),
    AiChatQuickReply(label: "この分数式の形をどう扱えばいいですか？", actionId: "handle_fraction"),
  ],
//\lim_{n\to\infty}\sum_{k=1}^{n}\frac{(-1)^{k-1}}{2k-1} : 極限ガチャ
  "BE3EC919-60B4-4334-BE8F-389731CF565D": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この級数の名前は何ですか？", actionId: "what_is_this_series"),
    AiChatQuickReply(label: "問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "各項を積分で表すとはどういうことですか？", actionId: "term_as_integral"),
    AiChatQuickReply(label: "ライプニッツ級数について教えてください。", actionId: "about_leibniz_series"),
  ],
//2x^2 + 5xy + 2y^2 - 5x - y - 3 : 因数分解ガチャ
  "BE5B4E1D-4297-4F80-98BC-F74655BF03F9": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この式を因数分解する方針を教えて", actionId: "approach_only"),
    AiChatQuickReply(label: "xについて整理するとはどういうこと？", actionId: "meaning_of_organize_by_x"),
  ],
//f''(t) = -\omega_0^2 f(t), f(0) = A_0,\ f'(0) = v_0 : 微分方程式ガチャ
  "BEB5E18C-4AF5-4411-8578-2CE052A3CDE8": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この微分方程式の解き方の基本方針は？", actionId: "approach_only"),
    AiChatQuickReply(label: "二階同次・定数係数微分方程式とは？", actionId: "definition_ode"),
    AiChatQuickReply(label: "初期条件はどのように使うの？", actionId: "initial_conditions"),
    AiChatQuickReply(label: "ヒントを見せてください", actionId: "show_hint"),
  ],
//\int_{0}^{(\pi)/(6)} \sin^{2}x \cos x dx : 積分ガチャ
  "BED49300-099F-4DD3-9DC6-1AB5635BEC1B": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "積分の計算手順を確認したい", sendText: "積分の計算手順を最初から確認したいです。", actionId: "calculation_steps"),
    AiChatQuickReply(label: "三角関数の積分のコツは？", sendText: "三角関数の積分でよく使うコツはありますか？", actionId: "hint_trig_integral"),
  ],
//abcd = a + b + c + d \qquad (0 < a, b, c, d) : 不定方程式ガチャ
  "C0367E7C-E68E-4377-B638-8C6EDB803AEB": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "どういう方針で解けばいいですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "0 < a, b, c, d という条件はどう使いますか？", actionId: "condition_usage"),
  ],
//\log_3(x+1) - \log_3(x-1) = 1 : 三角指数対数ガチャ
  "C07C6DF1-7283-4797-936F-1DFD8D597680": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "対数の性質について教えてください", actionId: "log_properties"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
  ],
//\int_{-1}^{1}\frac{1}{x^{2}+2x+5} dx : 積分ガチャ
  "C08EC860-F248-4E0A-90FD-F321E66616A4": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "定積分の計算方針が知りたい", sendText: "この定積分の計算方針について教えてください。", actionId: "approach_only"),
  ],
//\int_{-(\pi)/(12)}^{(\pi)/(12)} (dx)/(\cos^2(3x)) : 積分ガチャ
  "C1D2E3F4-G5H6-I7J8-K9L0-M1N2O3P4Q5": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分の基本的な方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "1/cos^2(x) の積分は何になりますか？", actionId: "hint_basic_integral"),
  ],
//\lim_{x\to 0}x\sin\!\left((1)/(x)\right) : 極限ガチャ
  "C1F3E989-594D-446A-8E94-FD7E70C7450F": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "xを掛けるときに注意することはありますか？", actionId: "caution_multiplication"),
  ],
//2\sin^2 x - \sin x - 1 = 0, 0 \leq x < 2\pi : 三角指数対数ガチャ
  "C286F6A2-9859-42E0-9719-C29CE61F82AC": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "どういう方針で解けばいいですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "二次方程式の解き方を教えてください。", actionId: "quadratic_solve"),
    AiChatQuickReply(label: "sin x = t と置いたときの t の範囲は？", actionId: "range_check"),
    AiChatQuickReply(label: "三角方程式の解き方が知りたいです。", actionId: "trig_equation_basics"),
  ],
//\lim_{x\to 0}(1)/(x)\int_{0}^{x}\sqrt{1+\cos^{3}t} dt : 極限ガチャ
  "C2A4D7E9-8C31-4B67-9D1C-7B1F9F4D2C22": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この式の形は何を表していますか？", actionId: "meaning_of_form"),
    AiChatQuickReply(label: "積分の平均値の定理について教えてください", actionId: "mean_value_theorem_integral"),
  ],
//\cos 2x + \cos 3x = 0, 0 \leq x < 2\pi : 三角指数対数ガチャ
  "C3D4E5F6-A7B8-C9D0-E1F2-A3B4C5D6E7F8": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "cos A + cos B の公式が思い出せません。", actionId: "formula_cos_sum"),
  ],
//f''(t)=g,\ f(0)=f_0,\ f'(0)=v_0 : 微分方程式ガチャ
  "C5C2514A-CF06-4F19-BE62-4F99731FA905": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この微分方程式の解き方の基本方針を教えて", actionId: "approach_only"),
    AiChatQuickReply(label: "f''(t) = g は何を意味するの？", actionId: "meaning_of_equation"),
    AiChatQuickReply(label: "初期条件 f(0) と f'(0) はどう使うの？", actionId: "how_to_use_initial_conditions"),
  ],
//x^4 - 4x^3 + 5x^2 - 4x + 1 : 因数分解ガチャ
  "C66CEC49-FCD7-42E2-9FF5-628A431A8550": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この式の特徴は何ですか？", actionId: "identify_pattern"),
    AiChatQuickReply(label: "因数分解の一般的な方針を教えてください。", actionId: "approach_only"),
  ],
//\int_0^{ (\pi)/(2)} \sin^9 x dx : 積分ガチャ
  "C7312AD1-233C-42E9-94E7-BF9A59591EE1": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分はどう解けばいいですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "sinのn乗の積分は漸化式を使うのですか？", actionId: "hint_specific_method"),
  ],
//\lim_{n\to\infty}(1)/(n)\sqrt[n]{{}_{2n}P_n} : 極限ガチャ
  "C9E8A1B2-4D7F-4A91-9F5C-2B6E3A1D8C77": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この極限を解くための方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "P(n,k)の定義は何ですか？", sendText: "P(n,k)の定義は何ですか？この問題ではどう展開できますか？", actionId: "definition_permutation"),
    AiChatQuickReply(label: "n乗根の極限を扱う一般的な方法は何ですか？", actionId: "general_method_nth_root"),
  ],
//x^4 + 5x^2 + 9 : 因数分解ガチャ
  "CAF59AF0-A107-4D21-B0E3-2C3D888A83D2": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の基本的な方針を教えて", sendText: "この式の因数分解の基本的な方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "二乗の差の形にできますか？", sendText: "A^2 - B^2 の形に持ち込むことはできますか？", actionId: "strategy_difference_of_squares"),
  ],
//\int_0^{(\pi)/(2)} x^2 \cos x dx : 積分ガチャ
  "CC1A2E7C-04EF-4D32-BB13-907FBEC6515D": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分の解き方の方針を教えてください。", actionId: "approach_only"),
  ],
//\lim_{x\to 0}\frac{3^{x}-1}{x} : 極限ガチャ
  "CCD350BD-2E20-456F-80B5-5646A5070E7E": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この極限の形は何を表していますか？", actionId: "meaning_of_form"),
  ],
//a^2(b-c) + b^2(c-a) + c^2(a-b) : 因数分解ガチャ
  "CE7A2246-F134-4248-86EA-31A0502F58F1": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の基本方針を教えて", actionId: "approach_only"),
  ],
//2+(-2+2)+(-2+2)+\cdots : 極限ガチャ
  "CECF170F-83C3-485D-B0F7-A73B2089A50B": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "無限級数の考え方について教えて", actionId: "approach_only"),
    AiChatQuickReply(label: "この式はどんな数列を表しているの？", actionId: "clarify_problem"),
  ],
//\int_0^{(\pi)/(2)} \cos^2 x dx : 積分ガチャ
  "D04D1417-91C9-4E4F-8558-80C8FF96A50F": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分の解き方の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "定積分の計算で注意すべき点はありますか？", actionId: "hint_definite_integral"),
  ],
//\sin 3x + \sin x = 0, 0 \leq x < 2\pi : 三角指数対数ガチャ
  "D1528690-D756-47FC-8647-0A11E4E5AC4A": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "どういう方針で解けばいいですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "三角方程式の解き方を確認したい", actionId: "review_trig_eq"),
  ],
//f'(t)+3 f(t)=2\ , f(0)=1 : 微分方程式ガチャ
  "D2706488-8F89-46F4-8636-834028B00CFC": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この微分方程式の種類は何ですか？", actionId: "equation_type"),
    AiChatQuickReply(label: "解き方の基本的な方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "定数変化法について教えてください。", actionId: "variation_of_parameters"),
    AiChatQuickReply(label: "積分因子法について教えてください。", actionId: "integrating_factor"),
  ],
//a_{n+1} = a_n + 2n + 1, a_1 = 1 : 漸化式ガチャ
  "D31DD01A-20D0-49DA-9EAD-E9571974B0DB": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この漸化式のタイプは何ですか？", actionId: "identify_type"),
  ],
//\int_{0}^{3} \frac{dx}{\sqrt{x^2+9}} : 積分ガチャ
  "D36E79F5-FF3C-442A-8A3A-DE453F25EA60": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "三角関数置換について教えてください。", actionId: "trig_sub_explanation"),
    AiChatQuickReply(label: "定積分の計算で注意すべき点はありますか？", actionId: "definite_integral_tips"),
  ],
//\lim_{n\to\infty}(1)/(n)\sum_{k=-n}^{n}\sqrt{1-\left((k)/(n)\right)^{2}} : 極限ガチャ
  "D38E0151-81F6-4A38-A100-93A0C0E7A048": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "Σの中の式は何を表していますか？", actionId: "interpret_expression"),
  ],
//\frac{3^x + 3^{-x}}{2} = 5 : 三角指数対数ガチャ
  "D7300A7C-4D0A-4F2D-B723-48757CD78ED0": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "3^xと3^{-x}の関係について教えてください", actionId: "term_explanation"),
  ],
//\lim_{n\to\infty}\sum_{k=1}^{n}\frac{1}{\sqrt{k}} : 極限ガチャ
  "D7F8E9A0-B1C2-4D3E-8F5A-6B7C8D9E0F1A": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この級数の発散をどう判定すればいいですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "積分判定法について教えてください", actionId: "explain_integral_test"),
    AiChatQuickReply(label: "比較する関数は何を選べばいいですか？", actionId: "hint_function_choice"),
  ],
//\int_0^{\pi} \sin^2 x dx : 積分ガチャ
  "D812B02C-7F6E-4FA4-BD61-A05CBAB6D525": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分の基本的な方針を教えてください", sendText: "この積分の基本的な方針を教えてください。", actionId: "approach_only"),
  ],
//f''(t)+a f'(t)=b : 微分方程式ガチャ
  "D87D022C-7BED-4C0D-BC95-8A74C64BCD86": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この微分方程式の解き方の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "f'(t)で置き換えるのはなぜですか？", actionId: "why_substitution"),
    AiChatQuickReply(label: "積分因子法について教えてください。", actionId: "integrating_factor_method"),
    AiChatQuickReply(label: "初期条件はどのように使いますか？", actionId: "how_to_use_initial_conditions"),
  ],
//\ \sum_{k=1}^{n} a_k = n^2 + 2n : 漸化式ガチャ
  "D8CA1CE8-6921-47E2-8A45-728DED579EB0": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題は何を求めればいいですか？", actionId: "understand_goal"),
    AiChatQuickReply(label: "数列の和から一般項を求めるには？", actionId: "approach_only"),
    AiChatQuickReply(label: "S_n と a_n の関係を教えて", actionId: "concept_sn_an"),
    AiChatQuickReply(label: "S_{n-1} をどう計算すればいいですか？", actionId: "calc_sn_minus_1"),
  ],
//\int_{0}^{(\pi)/(5)} e^{-2x}\cos 5x dx : 積分ガチャ
  "D9E29F85-E082-42D3-A2E6-34D162864716": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分の解き方の基本方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "積分区間の扱い方について教えてください。", actionId: "definite_integral_bounds"),
  ],
//27x^3 - 8y^3 : 因数分解ガチャ
  "DB124FEE-EBB5-4940-B445-2D08B1B87E9A": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "27x^3と8y^3をそれぞれどう変形しますか？", actionId: "transformation_hint"),
  ],
//3x + 5y = 2 : 不定方程式ガチャ
  "DB513B4F-55DC-4AB9-87B7-1BCF5F47DC6A": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "不定方程式って何？", actionId: "define_indeterminate_equation"),
    AiChatQuickReply(label: "特殊解はどうやって見つけるの？", actionId: "find_particular_solution"),
  ],
//\lim_{h\to +0}\left(1+(1)/(h)\right)^{h} : 極限ガチャ
  "E03C5F81-3445-4D78-8BC7-9BDD3EF528CD": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この極限の形は何を表していますか？", actionId: "limit_form"),
    AiChatQuickReply(label: "f(x)^g(x) の形の極限を解く方針は？", actionId: "approach_f_g"),
    AiChatQuickReply(label: "対数を使うのはなぜですか？", actionId: "why_logarithm"),
  ],
//x^2 - 9x - 22 : 因数分解ガチャ
  "E0D650DF-7B76-4A37-A0FE-B18A8A041E0B": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解のやり方を教えて", actionId: "approach_only"),
  ],
//4x - 7y = 1 : 不定方程式ガチャ
  "E2B55755-0658-4FBE-911F-C18148799924": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "解き方の基本方針を教えて", sendText: "この不定方程式の解き方の基本方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "特殊解の見つけ方は？", sendText: "特殊解（一つの整数解）はどのように見つけるのですか？", actionId: "find_particular_solution"),
  ],
//\lim_{n\to\infty}\sum_{k=1}^{n}(1)/(k(k+2)) : 極限ガチャ
  "E3253228-3C96-488F-BD6E-A89DC18E84CA": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "シグマの中の分数をどう変形しますか？", actionId: "hint_partial_fraction"),
    AiChatQuickReply(label: "シグマ計算のヒントをください", actionId: "hint_sum_calculation"),
    AiChatQuickReply(label: "極限の計算方法について教えてください", actionId: "explain_limit_calculation"),
  ],
//f''(t)+2f'(t)+4f(t)=20\cos(2t), f(0)=0,\ f'(0)=0 : 微分方程式ガチャ
  "E32CEEE3-F0E5-44C6-838C-7BEF0531E460": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "「定常状態」とはどういう意味ですか？", actionId: "steady_state_meaning"),
    AiChatQuickReply(label: "この微分方程式の解き方の方針を教えてください。", actionId: "approach_only"),
  ],
//\int_{0}^{(\pi)/(6)} \sin^3 x dx : 積分ガチャ
  "E356DB2A-1686-4B3F-8F5C-77FBE782E17F": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "どういう方針で解けばいいですか？", actionId: "approach_only"),
  ],
//x^4 + 4y^4 : 因数分解ガチャ
  "E406BD56-74DE-4603-9695-AE08B0757BE7": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この式の因数分解の基本的な方針は何ですか？", actionId: "approach_only"),
    AiChatQuickReply(label: "この形を見たときに、よく使う公式はありますか？", actionId: "common_formula"),
  ],
//a_{n+2} - a_{n+1} - 6 a_n = 0, a_1 = 1,\ a_2 = 2 : 漸化式ガチャ
  "E460F72E-E848-4B8F-B481-9D3E820FEBAE": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この漸化式のタイプは何ですか？", actionId: "identify_type"),
    AiChatQuickReply(label: "一般項の形はどうなりますか？", actionId: "general_form"),
    AiChatQuickReply(label: "初期条件の使い方は？", actionId: "how_to_use_initial_conditions"),
  ],
//\lim_{x\to 0}(\tan x)/(x) : 極限ガチャ
  "E5CDA38B-2CD3-4F62-AB20-2F4ECDB14681": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", sendText: "この問題の方針を教えてください。", actionId: "approach_only"),
  ],
//f'(t)+a f(t)=b : 微分方程式ガチャ
  "E5E4228F-7819-4063-A4DB-9F1DB3D27225": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この微分方程式の一般的な解き方は？", actionId: "approach_only"),
    AiChatQuickReply(label: "「一階非斉次」とはどういう意味ですか？", actionId: "term_meaning"),
    AiChatQuickReply(label: "この方程式はどんな現象を表しますか？", actionId: "application_context"),
  ],
//xyz = x + y + z \qquad (0< x \le y \le z) : 不定方程式ガチャ
  "E8EA2D7A-4614-47AB-8934-8C7BCF3568C1": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "どういう方針で解き進めますか？", actionId: "approach_only"),
  ],
//\lim_{x\to +0} x\log x : 極限ガチャ
  "E8F3C9A2-7D6A-4E4E-9B6E-XLNXLOGX001": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この極限の形は何ですか？", actionId: "limit_form"),
    AiChatQuickReply(label: "x→+0 のときの xlogx の極限を求めるには？", actionId: "approach_only"),
    AiChatQuickReply(label: "xlogx のグラフをイメージできますか？", actionId: "graph_hint"),
    AiChatQuickReply(label: "x=1/t と置換するのはなぜですか？", actionId: "substitution_reason"),
  ],
//\lim_{n\to\infty}\int_{0}^{(\pi)/(4)}\tan^{2n}x dx : 極限ガチャ
  "E9F0A1B2-C3D4-5E6F-7A8B-9C0D1E2F3A4B": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
    AiChatQuickReply(label: "被積分関数 tan^(2n)x の特徴は？", actionId: "function_properties"),
    AiChatQuickReply(label: "積分区間 [0, π/4] で tan x はどうなりますか？", actionId: "tan_x_range"),
  ],
//xy + 3x - 8y = 33 : 不定方程式ガチャ
  "EBA0562C-23C6-4DE1-95C1-94FB618E1073": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "不定方程式って何？", actionId: "what_is_diophantine"),
    AiChatQuickReply(label: "どういう方針で解けばいい？", actionId: "approach_only"),
    AiChatQuickReply(label: "因数分解のアイデアが欲しい", actionId: "hint_factorization"),
  ],
//2^{2x+1} - 2^{x+2} = 2^x - 2 : 三角指数対数ガチャ
  "EBEA916F-13BA-4F47-8827-8D2546F80AA0": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "どういう方針で解き進めればいいですか？", actionId: "approach_only"),
  ],
//\int_{ \frac {1} {4}}^{ \frac {1} {2}} 2^{x} dx : 積分ガチャ
  "ECB70663-7BFE-4801-8F92-21A71BF20AD3": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", sendText: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "定積分の計算方法を確認したい", sendText: "定積分の計算方法を確認したいです。", actionId: "definite_integral_method"),
  ],
//\int_{1}^{e}\frac{\log x}{x^{2}} dx : 積分ガチャ
  "EE0E5F29-6071-4A82-BBA0-6D3DAAD6BB0C": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この積分の解き方の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "定積分の計算で注意することはありますか？", actionId: "hint_caution"),
  ],
//xy-yz+zu-ux : 因数分解ガチャ
  "F14C7A82-9E10-4B3D-9C2A-1D8E7F6A5B4C": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の基本的な方針を教えて", sendText: "因数分解の基本的な方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "共通因数を見つけるコツは？", sendText: "共通因数を見つけるためのコツや考え方を教えてください。", actionId: "hint_common_factor"),
    AiChatQuickReply(label: "どの文字でまとめると良い？", sendText: "この式を因数分解するとき、どの文字でまとめると良いですか？", actionId: "hint_grouping_variable"),
  ],
//(y-z)^3+(z-x)^3+(x-y)^3 : 因数分解ガチャ
  "F1A2B3C4-D5E6-F7A8-B9C0-D1E2F3A4B5C6": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "因数分解の基本方針は何ですか？", actionId: "approach_only"),
  ],
//\int_{0}^{(\pi)/(4)} (dx)/(\cos^2 x) : 積分ガチャ
  "F1G2H3I4-J5K6-L7M8-N9O0-P1Q2R3S4T5U6": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "1/cos^2 x の積分はどうすればいいですか？", actionId: "hint_specific_term"),
    AiChatQuickReply(label: "定積分の計算手順を確認したいです。", actionId: "review_definite_integral"),
  ],
//f''(t) = -\omega_0^2 f(t) + G, f(0) = f_0,\ f'(0) = v_0 : 微分方程式ガチャ
  "F2C5AEF4-1FD1-4BD6-A7FE-D0E65756456A": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この微分方程式の種類は何ですか？", actionId: "equation_type"),
    AiChatQuickReply(label: "解き方の基本的な方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "定数Gがある場合の解き方が知りたいです。", actionId: "how_to_handle_G"),
  ],
//\int_{ \frac {\pi} {6}}^{ \frac {\pi} {4}} \tan x dx : 積分ガチャ
  "F41A1522-30A9-4428-AB89-02F6A0650991": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "tan x の積分方法が知りたい", actionId: "how_to_integrate_tanx"),
    AiChatQuickReply(label: "定積分の計算手順を確認したい", actionId: "definite_integral_steps"),
    AiChatQuickReply(label: "三角関数の定積分で注意することは？", actionId: "trig_integral_tips"),
  ],
//f'(t)+a f(t)=0, f(0)=f_0 : 微分方程式ガチャ
  "F744D6AB-A8EB-42F0-9740-0FD4DC4EA29D": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "この微分方程式の種類は何ですか？", actionId: "equation_type"),
    AiChatQuickReply(label: "この方程式はどんな現象を表しますか？", actionId: "context_application"),
    AiChatQuickReply(label: "f(t)の形を予想できますか？", actionId: "guess_form"),
  ],
//\lim_{n\to\infty}\sqrt{n^{2}+n}-n : 極限ガチャ
  "F7C0451B-E946-4AB6-90C4-A3B539CE4A1D": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", actionId: "approach_only"),
  ],
//\sin x \cos x + \sqrt{2}(\sin x + \cos x) = (1)/(2), 0 \leq x < 2\pi : 三角指数対数ガチャ
  "F8A3B2C1-9D4E-5F6A-7B8C-9D0E1F2A3B4C": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "どういう方針で解けばいいですか？", actionId: "approach_only"),
  ],
//\int_{0}^{(\pi)/(2)} (dx)/(2 + \sin x) : 積分ガチャ
  "F92FA824-A0AC-486A-95B7-C731A52DEEC9-variant": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "どういう方針で解き進めますか？", actionId: "approach_only"),
    AiChatQuickReply(label: "半角置換について教えてください", actionId: "half_angle_substitution_explanation"),
    AiChatQuickReply(label: "三角関数の積分でよく使う公式は？", actionId: "common_formulas"),
  ],
//a(b^2+c^2) + b(c^2+a^2) + c(a^2+b^2) + 2abc : 因数分解ガチャ
  "FAA00A56-4049-4921-A9C8-93B3F420DA1C": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この式の因数分解の一般的な方針は？", actionId: "approach_only"),
    AiChatQuickReply(label: "展開して整理するとどうなりますか？", actionId: "expand_and_organize"),
    AiChatQuickReply(label: "対称式の特徴を活かせますか？", actionId: "symmetric_expression_hint"),
  ],
//2-2+2-2+2-2+\cdots : 極限ガチャ
  "FAF62CC1-1FE8-41FC-B1B6-5151D088742A": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えて", sendText: "この無限級数の極限を求めるための基本的な方針を教えてください。", actionId: "approach_only"),
  ],
//17x + 29y + 61z = 3 : 不定方程式ガチャ
  "FBFAA113-A701-4D94-9421-3AEF3FA2A96E": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "不定方程式の解き方の方針を知りたい", actionId: "approach_only"),
    AiChatQuickReply(label: "係数が3つある場合の注意点は？", actionId: "considerations_three_variables"),
  ],
//\int_0^{(\pi)/(3)} \sin^2 x \cos^2 x dx : 積分ガチャ
  "FEE633FE-DE9A-4BF9-8E42-52FD6CA67E3A": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "どういう方針で解けばいいですか？", actionId: "approach_only"),
  ],
//\sin x = (1)/(2), 0 \leq x < 2\pi : 三角指数対数ガチャ
  "TRIG-EXP-LOG-001": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "三角関数のグラフをどう使う？", actionId: "graph_approach"),
    AiChatQuickReply(label: "単位円を使った解き方を教えて", actionId: "unit_circle_approach"),
    AiChatQuickReply(label: "sin x = 1/2 となるxの値をどう見つける？", actionId: "find_base_angle"),
    AiChatQuickReply(label: "0 ≤ x < 2π の範囲に注意する点は？", actionId: "range_consideration"),
  ],
//2^{x+1} - 2^{x-1} = 3 : 三角指数対数ガチャ
  "TRIG-EXP-LOG-002": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "この問題の方針を教えてください", sendText: "この問題の方針を教えてください。", actionId: "approach_only"),
    AiChatQuickReply(label: "指数法則について確認したい", sendText: "指数法則について確認したいです。", actionId: "review_exponent_rules"),
    AiChatQuickReply(label: "最初の変形が思いつきません", sendText: "最初の変形が思いつきません。ヒントをください。", actionId: "first_step_hint"),
  ],
//\log_2(x+1) + \log_2(x-1) = 3 : 三角指数対数ガチャ
  "TRIG-EXP-LOG-003": [
    AiChatQuickReply(label: "最初の一歩は何をすればいいですか？", actionId: "first_step"),
    AiChatQuickReply(label: "ヒントをください", actionId: "hint"),
    AiChatQuickReply(label: "対数の性質について教えてください", actionId: "log_properties"),
    AiChatQuickReply(label: "対数方程式の解き方の基本方針が知りたい", actionId: "approach_only"),
  ],
};

List<AiChatQuickReply>? lookupStarterQuickReplies(String problemId) {
  final replies = starterQuickRepliesByProblemId[problemId];
  if (replies == null || replies.isEmpty) return null;
  return replies;
}

