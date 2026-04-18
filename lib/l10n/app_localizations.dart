import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
  ];

  /// No description provided for @updateDialogTitle.
  ///
  /// In ja, this message translates to:
  /// **'新しいアップデートがあります'**
  String get updateDialogTitle;

  /// No description provided for @updateDialogMessage.
  ///
  /// In ja, this message translates to:
  /// **'更新してみませんか？'**
  String get updateDialogMessage;

  /// No description provided for @updateDialogLater.
  ///
  /// In ja, this message translates to:
  /// **'あとで'**
  String get updateDialogLater;

  /// No description provided for @updateDialogUpdate.
  ///
  /// In ja, this message translates to:
  /// **'更新する'**
  String get updateDialogUpdate;

  /// No description provided for @updateDialogReleaseNotes.
  ///
  /// In ja, this message translates to:
  /// **'更新内容'**
  String get updateDialogReleaseNotes;

  /// No description provided for @categoryMechanics.
  ///
  /// In ja, this message translates to:
  /// **'力学'**
  String get categoryMechanics;

  /// No description provided for @categoryElectromagnetism.
  ///
  /// In ja, this message translates to:
  /// **'電磁気学'**
  String get categoryElectromagnetism;

  /// No description provided for @categoryThermodynamics.
  ///
  /// In ja, this message translates to:
  /// **'熱力学'**
  String get categoryThermodynamics;

  /// No description provided for @categoryWaves.
  ///
  /// In ja, this message translates to:
  /// **'波動'**
  String get categoryWaves;

  /// No description provided for @problemListTitle.
  ///
  /// In ja, this message translates to:
  /// **'{gachaTypeName}問題一覧'**
  String problemListTitle(String gachaTypeName);

  /// No description provided for @unitGachaProblemListTitle.
  ///
  /// In ja, this message translates to:
  /// **'Unit Gacha 問題一覧'**
  String get unitGachaProblemListTitle;

  /// No description provided for @allProblemsSolved.
  ///
  /// In ja, this message translates to:
  /// **'全ての問題を解き切りました！'**
  String get allProblemsSolved;

  /// No description provided for @appTitle.
  ///
  /// In ja, this message translates to:
  /// **'【極】微積ガチャ！'**
  String get appTitle;

  /// No description provided for @showProgressRate.
  ///
  /// In ja, this message translates to:
  /// **'達成率を表示'**
  String get showProgressRate;

  /// No description provided for @integralGacha.
  ///
  /// In ja, this message translates to:
  /// **'積分ガチャ！'**
  String get integralGacha;

  /// No description provided for @integralGachaTitle.
  ///
  /// In ja, this message translates to:
  /// **'積分ガチャ'**
  String get integralGachaTitle;

  /// No description provided for @limitGachaTitle.
  ///
  /// In ja, this message translates to:
  /// **'極限ガチャ'**
  String get limitGachaTitle;

  /// No description provided for @physicsMathGachaTitle.
  ///
  /// In ja, this message translates to:
  /// **'物理数学ガチャ'**
  String get physicsMathGachaTitle;

  /// No description provided for @physicsMathGachaProblemListTitle.
  ///
  /// In ja, this message translates to:
  /// **'物理数学ガチャ 問題一覧'**
  String get physicsMathGachaProblemListTitle;

  /// No description provided for @factorizationGachaTitle.
  ///
  /// In ja, this message translates to:
  /// **'因数分解ガチャ'**
  String get factorizationGachaTitle;

  /// No description provided for @indeterminateEqGachaTitle.
  ///
  /// In ja, this message translates to:
  /// **'不定方程式ガチャ'**
  String get indeterminateEqGachaTitle;

  /// No description provided for @sequenceGachaTitle.
  ///
  /// In ja, this message translates to:
  /// **'漸化式ガチャ'**
  String get sequenceGachaTitle;

  /// No description provided for @genericGachaTitle.
  ///
  /// In ja, this message translates to:
  /// **'数学ガチャ'**
  String get genericGachaTitle;

  /// No description provided for @gachaContentsTitle.
  ///
  /// In ja, this message translates to:
  /// **'ガチャの内容'**
  String get gachaContentsTitle;

  /// No description provided for @content_integral_abs.
  ///
  /// In ja, this message translates to:
  /// **'絶対値を含む定積分'**
  String get content_integral_abs;

  /// No description provided for @content_integral_basic.
  ///
  /// In ja, this message translates to:
  /// **'基本公式の利用'**
  String get content_integral_basic;

  /// No description provided for @content_integral_parts.
  ///
  /// In ja, this message translates to:
  /// **'部分積分'**
  String get content_integral_parts;

  /// No description provided for @content_integral_substitution.
  ///
  /// In ja, this message translates to:
  /// **'置換積分'**
  String get content_integral_substitution;

  /// No description provided for @content_integral_partial_fraction.
  ///
  /// In ja, this message translates to:
  /// **'部分分数分解'**
  String get content_integral_partial_fraction;

  /// No description provided for @content_integral_trig_power.
  ///
  /// In ja, this message translates to:
  /// **'三角関数の累乗'**
  String get content_integral_trig_power;

  /// No description provided for @content_integral_exp_log.
  ///
  /// In ja, this message translates to:
  /// **'指数・対数関数'**
  String get content_integral_exp_log;

  /// No description provided for @content_integral_irrational_1.
  ///
  /// In ja, this message translates to:
  /// **'無理関数（1次式）'**
  String get content_integral_irrational_1;

  /// No description provided for @content_integral_irrational_2.
  ///
  /// In ja, this message translates to:
  /// **'無理関数（2次式）'**
  String get content_integral_irrational_2;

  /// No description provided for @content_integral_beta.
  ///
  /// In ja, this message translates to:
  /// **'ベータ関数の公式'**
  String get content_integral_beta;

  /// No description provided for @content_limit_basic.
  ///
  /// In ja, this message translates to:
  /// **'基本公式・有理化'**
  String get content_limit_basic;

  /// No description provided for @content_limit_rationalization.
  ///
  /// In ja, this message translates to:
  /// **'有理化・無理式'**
  String get content_limit_rationalization;

  /// No description provided for @content_limit_trig.
  ///
  /// In ja, this message translates to:
  /// **'三角関数の極限'**
  String get content_limit_trig;

  /// No description provided for @content_limit_exp_log.
  ///
  /// In ja, this message translates to:
  /// **'指数・対数関数の極限'**
  String get content_limit_exp_log;

  /// No description provided for @content_limit_partial_fraction.
  ///
  /// In ja, this message translates to:
  /// **'部分分数分解と和'**
  String get content_limit_partial_fraction;

  /// No description provided for @content_limit_squeeze.
  ///
  /// In ja, this message translates to:
  /// **'はさみうちの原理'**
  String get content_limit_squeeze;

  /// No description provided for @content_limit_riemann.
  ///
  /// In ja, this message translates to:
  /// **'区分求積法'**
  String get content_limit_riemann;

  /// No description provided for @content_limit_famous.
  ///
  /// In ja, this message translates to:
  /// **'有名な極限・eの定義'**
  String get content_limit_famous;

  /// No description provided for @content_pm_uniform_accel.
  ///
  /// In ja, this message translates to:
  /// **'等加速度直線運動'**
  String get content_pm_uniform_accel;

  /// No description provided for @content_pm_shm_lc.
  ///
  /// In ja, this message translates to:
  /// **'単振動・LC回路'**
  String get content_pm_shm_lc;

  /// No description provided for @content_pm_air_rl.
  ///
  /// In ja, this message translates to:
  /// **'空気抵抗・RL回路'**
  String get content_pm_air_rl;

  /// No description provided for @content_pm_rc.
  ///
  /// In ja, this message translates to:
  /// **'RC回路'**
  String get content_pm_rc;

  /// No description provided for @content_pm_ac.
  ///
  /// In ja, this message translates to:
  /// **'交流回路'**
  String get content_pm_ac;

  /// No description provided for @content_fact_cross.
  ///
  /// In ja, this message translates to:
  /// **'たすき掛け'**
  String get content_fact_cross;

  /// No description provided for @content_fact_factor_theorem.
  ///
  /// In ja, this message translates to:
  /// **'因数定理'**
  String get content_fact_factor_theorem;

  /// No description provided for @content_fact_replacement.
  ///
  /// In ja, this message translates to:
  /// **'置き換え'**
  String get content_fact_replacement;

  /// No description provided for @content_fact_4th_degree.
  ///
  /// In ja, this message translates to:
  /// **'複二次式'**
  String get content_fact_4th_degree;

  /// No description provided for @content_fact_low_degree.
  ///
  /// In ja, this message translates to:
  /// **'最低次数の文字で整理'**
  String get content_fact_low_degree;

  /// No description provided for @content_fact_sort_by_var.
  ///
  /// In ja, this message translates to:
  /// **'特定の文字で整理'**
  String get content_fact_sort_by_var;

  /// No description provided for @content_fact_5th_degree.
  ///
  /// In ja, this message translates to:
  /// **'5次以上の因数分解'**
  String get content_fact_5th_degree;

  /// No description provided for @content_indet_basic.
  ///
  /// In ja, this message translates to:
  /// **'1次不定方程式'**
  String get content_indet_basic;

  /// No description provided for @content_indet_3vars.
  ///
  /// In ja, this message translates to:
  /// **'3変数不定方程式'**
  String get content_indet_3vars;

  /// No description provided for @content_indet_quadratic_hyperbola.
  ///
  /// In ja, this message translates to:
  /// **'2次不定方程式（双曲線型）'**
  String get content_indet_quadratic_hyperbola;

  /// No description provided for @content_indet_quadratic_ellipse.
  ///
  /// In ja, this message translates to:
  /// **'2次不定方程式（楕円型）'**
  String get content_indet_quadratic_ellipse;

  /// No description provided for @content_indet_high_degree.
  ///
  /// In ja, this message translates to:
  /// **'高次不定方程式'**
  String get content_indet_high_degree;

  /// No description provided for @content_seq_2terms.
  ///
  /// In ja, this message translates to:
  /// **'2項間漸化式'**
  String get content_seq_2terms;

  /// No description provided for @content_seq_3terms.
  ///
  /// In ja, this message translates to:
  /// **'3項間漸化式'**
  String get content_seq_3terms;

  /// No description provided for @content_seq_simultaneous.
  ///
  /// In ja, this message translates to:
  /// **'連立漸化式'**
  String get content_seq_simultaneous;

  /// No description provided for @content_seq_fractional.
  ///
  /// In ja, this message translates to:
  /// **'分数型漸化式'**
  String get content_seq_fractional;

  /// No description provided for @content_seq_variable_coeff.
  ///
  /// In ja, this message translates to:
  /// **'係数が変数の方程式'**
  String get content_seq_variable_coeff;

  /// No description provided for @content_seq_root_power.
  ///
  /// In ja, this message translates to:
  /// **'べき乗・ルート型'**
  String get content_seq_root_power;

  /// No description provided for @integralCount.
  ///
  /// In ja, this message translates to:
  /// **'{count}問'**
  String integralCount(int count);

  /// No description provided for @randomIntegralPractice.
  ///
  /// In ja, this message translates to:
  /// **'ランダム積分練習 🎲'**
  String get randomIntegralPractice;

  /// No description provided for @limitGacha.
  ///
  /// In ja, this message translates to:
  /// **'極限ガチャ！'**
  String get limitGacha;

  /// No description provided for @limitCount.
  ///
  /// In ja, this message translates to:
  /// **'{count}問'**
  String limitCount(int count);

  /// No description provided for @someDontConverge.
  ///
  /// In ja, this message translates to:
  /// **'収束しない問題もあります ⤴️'**
  String get someDontConverge;

  /// No description provided for @differentialEquationGacha.
  ///
  /// In ja, this message translates to:
  /// **'微分方程式ガチャ'**
  String get differentialEquationGacha;

  /// No description provided for @deCount.
  ///
  /// In ja, this message translates to:
  /// **'{count}問'**
  String deCount(int count);

  /// No description provided for @physicsDECollection.
  ///
  /// In ja, this message translates to:
  /// **'物理に登場する\n微分方程式を集めました 🧲'**
  String get physicsDECollection;

  /// No description provided for @bonusGachaHome.
  ///
  /// In ja, this message translates to:
  /// **'おまけガチャ Home'**
  String get bonusGachaHome;

  /// No description provided for @bonusGachaDescription.
  ///
  /// In ja, this message translates to:
  /// **'因数分解・不定方程式\n 合同方程式(mod)・漸化式 🎁'**
  String get bonusGachaDescription;

  /// No description provided for @scratchPaper.
  ///
  /// In ja, this message translates to:
  /// **'計算用紙'**
  String get scratchPaper;

  /// No description provided for @learningHistoryFeature.
  ///
  /// In ja, this message translates to:
  /// **'学習履歴登録機能'**
  String get learningHistoryFeature;

  /// No description provided for @learningHistoryDescription.
  ///
  /// In ja, this message translates to:
  /// **'本アプリでは学習履歴を管理できます。'**
  String get learningHistoryDescription;

  /// No description provided for @greenCheckDescription.
  ///
  /// In ja, this message translates to:
  /// **'緑チェック = 自力で解けた'**
  String get greenCheckDescription;

  /// No description provided for @yellowCheckDescription.
  ///
  /// In ja, this message translates to:
  /// **'黄色チェック = 理解できた'**
  String get yellowCheckDescription;

  /// No description provided for @redCheckDescription.
  ///
  /// In ja, this message translates to:
  /// **'赤チェック = 分からない'**
  String get redCheckDescription;

  /// No description provided for @registrationGuidePart1.
  ///
  /// In ja, this message translates to:
  /// **'のように登録してご活用下さい。\n設定により'**
  String get registrationGuidePart1;

  /// No description provided for @registrationGuidePart2.
  ///
  /// In ja, this message translates to:
  /// **'をつけた問題をガチャから除外できます。'**
  String get registrationGuidePart2;

  /// No description provided for @proVersion.
  ///
  /// In ja, this message translates to:
  /// **'Pro版'**
  String get proVersion;

  /// No description provided for @proVersionPrice.
  ///
  /// In ja, this message translates to:
  /// **'Pro版({price})'**
  String proVersionPrice(String price);

  /// No description provided for @proVersionDescription.
  ///
  /// In ja, this message translates to:
  /// **'では全ガチャの学習履歴を管理できます。'**
  String get proVersionDescription;

  /// No description provided for @login.
  ///
  /// In ja, this message translates to:
  /// **'ログイン'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In ja, this message translates to:
  /// **'ログアウト'**
  String get logout;

  /// No description provided for @loggedOut.
  ///
  /// In ja, this message translates to:
  /// **'ログアウトしました'**
  String get loggedOut;

  /// No description provided for @syncWithCloud.
  ///
  /// In ja, this message translates to:
  /// **'クラウドデータと同期'**
  String get syncWithCloud;

  /// No description provided for @syncCompleted.
  ///
  /// In ja, this message translates to:
  /// **'クラウドデータとの同期が完了しました'**
  String get syncCompleted;

  /// No description provided for @noExclusion.
  ///
  /// In ja, this message translates to:
  /// **'除外なし'**
  String get noExclusion;

  /// No description provided for @latestNTimes.
  ///
  /// In ja, this message translates to:
  /// **'最新{n}回が '**
  String latestNTimes(int n);

  /// No description provided for @ifSo.
  ///
  /// In ja, this message translates to:
  /// **'なら'**
  String get ifSo;

  /// No description provided for @removeFromGacha.
  ///
  /// In ja, this message translates to:
  /// **'ならガチャから外す'**
  String get removeFromGacha;

  /// No description provided for @aggregateLatestN.
  ///
  /// In ja, this message translates to:
  /// **'最新{n}回分集計'**
  String aggregateLatestN(int n);

  /// No description provided for @aggregateLatestNLong.
  ///
  /// In ja, this message translates to:
  /// **'最新{n}回分の記録を集計'**
  String aggregateLatestNLong(int n);

  /// No description provided for @privacyPolicy.
  ///
  /// In ja, this message translates to:
  /// **'プライバシーポリシー'**
  String get privacyPolicy;

  /// No description provided for @privacyPolicyDescription.
  ///
  /// In ja, this message translates to:
  /// **'当アプリはアカウント管理とデータ同期のために Google Firebase 、および課金管理に RevenueCat を利用しています。詳細は{link}をご確認ください。'**
  String privacyPolicyDescription(String link);

  /// No description provided for @purchaseTitle.
  ///
  /// In ja, this message translates to:
  /// **'Pro版 - 学習履歴機能'**
  String get purchaseTitle;

  /// No description provided for @priceLabel.
  ///
  /// In ja, this message translates to:
  /// **'価格: {price}'**
  String priceLabel(String price);

  /// No description provided for @cancel.
  ///
  /// In ja, this message translates to:
  /// **'キャンセル'**
  String get cancel;

  /// No description provided for @purchase.
  ///
  /// In ja, this message translates to:
  /// **'購入する'**
  String get purchase;

  /// No description provided for @purchaseComplete.
  ///
  /// In ja, this message translates to:
  /// **'購入が完了しました'**
  String get purchaseComplete;

  /// No description provided for @purchaseFailed.
  ///
  /// In ja, this message translates to:
  /// **'購入に失敗しました: {error}'**
  String purchaseFailed(String error);

  /// No description provided for @errorOccurred.
  ///
  /// In ja, this message translates to:
  /// **'エラーが発生しました: {error}'**
  String errorOccurred(String error);

  /// No description provided for @pastPurchasesRestored.
  ///
  /// In ja, this message translates to:
  /// **'過去の購入を復元しました👍'**
  String get pastPurchasesRestored;

  /// No description provided for @ok.
  ///
  /// In ja, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @details.
  ///
  /// In ja, this message translates to:
  /// **'詳細'**
  String get details;

  /// No description provided for @aggregatedBy.
  ///
  /// In ja, this message translates to:
  /// **'で集計'**
  String get aggregatedBy;

  /// No description provided for @achievedCount.
  ///
  /// In ja, this message translates to:
  /// **'{achieved}問/{total}問 達成'**
  String achievedCount(Object achieved, Object total);

  /// No description provided for @rolling.
  ///
  /// In ja, this message translates to:
  /// **'ガチャ中...'**
  String get rolling;

  /// No description provided for @rollGacha.
  ///
  /// In ja, this message translates to:
  /// **'ガチャを回す'**
  String get rollGacha;

  /// No description provided for @noProblems.
  ///
  /// In ja, this message translates to:
  /// **'問題がありません'**
  String get noProblems;

  /// No description provided for @problemIndex.
  ///
  /// In ja, this message translates to:
  /// **'第{index}問'**
  String problemIndex(int index);

  /// No description provided for @hideAnswer.
  ///
  /// In ja, this message translates to:
  /// **'答えを隠す'**
  String get hideAnswer;

  /// No description provided for @showAnswer.
  ///
  /// In ja, this message translates to:
  /// **'答えを見る'**
  String get showAnswer;

  /// No description provided for @recordSaved.
  ///
  /// In ja, this message translates to:
  /// **'学習記録を保存しました: {status}'**
  String recordSaved(String status);

  /// No description provided for @preparingProblemList.
  ///
  /// In ja, this message translates to:
  /// **'問題一覧を準備中…'**
  String get preparingProblemList;

  /// No description provided for @allDisplayed.
  ///
  /// In ja, this message translates to:
  /// **'全て表示'**
  String get allDisplayed;

  /// No description provided for @recordSavedAt.
  ///
  /// In ja, this message translates to:
  /// **'保存: {date}'**
  String recordSavedAt(String date);

  /// No description provided for @latestNTimesShort.
  ///
  /// In ja, this message translates to:
  /// **'最新{n}回が'**
  String latestNTimesShort(int n);

  /// No description provided for @excludeSuffix.
  ///
  /// In ja, this message translates to:
  /// **'の問題を除く'**
  String get excludeSuffix;

  /// No description provided for @restoredPurchases.
  ///
  /// In ja, this message translates to:
  /// **'購入を復元しました'**
  String get restoredPurchases;

  /// No description provided for @noRestorablePurchases.
  ///
  /// In ja, this message translates to:
  /// **'復元できる購入が見つかりませんでした'**
  String get noRestorablePurchases;

  /// No description provided for @restoreFailed.
  ///
  /// In ja, this message translates to:
  /// **'復元に失敗しました: {error}'**
  String restoreFailed(String error);

  /// No description provided for @clearAllSlots.
  ///
  /// In ja, this message translates to:
  /// **'全スロット消去'**
  String get clearAllSlots;

  /// No description provided for @hideSolution.
  ///
  /// In ja, this message translates to:
  /// **'解答を隠す'**
  String get hideSolution;

  /// No description provided for @showSolution.
  ///
  /// In ja, this message translates to:
  /// **'解答を表示'**
  String get showSolution;

  /// No description provided for @answerLabel.
  ///
  /// In ja, this message translates to:
  /// **'【答え】'**
  String get answerLabel;

  /// No description provided for @pointLabel.
  ///
  /// In ja, this message translates to:
  /// **'【ポイント】'**
  String get pointLabel;

  /// No description provided for @explanationLabel.
  ///
  /// In ja, this message translates to:
  /// **'【解説】'**
  String get explanationLabel;

  /// No description provided for @hintLabelTitle.
  ///
  /// In ja, this message translates to:
  /// **'【ヒント】'**
  String get hintLabelTitle;

  /// No description provided for @bonusGachaTitle.
  ///
  /// In ja, this message translates to:
  /// **'おまけガチャ！'**
  String get bonusGachaTitle;

  /// No description provided for @unitGachaComingSoon.
  ///
  /// In ja, this message translates to:
  /// **'※単位ガチャは別アプリでリリース予定！'**
  String get unitGachaComingSoon;

  /// No description provided for @factorizationGachaSubtitle.
  ///
  /// In ja, this message translates to:
  /// **'整数係数の範囲で\n因数分解してください 0️⃣'**
  String get factorizationGachaSubtitle;

  /// No description provided for @indetEqGachaTitleOnly.
  ///
  /// In ja, this message translates to:
  /// **'不定方程式ガチャ'**
  String get indetEqGachaTitleOnly;

  /// No description provided for @indetEqGachaSubtitle.
  ///
  /// In ja, this message translates to:
  /// **'整数解を探してみよう 🔢'**
  String get indetEqGachaSubtitle;

  /// No description provided for @modGachaTitle.
  ///
  /// In ja, this message translates to:
  /// **'modガチャ！'**
  String get modGachaTitle;

  /// No description provided for @modGachaSubtitle.
  ///
  /// In ja, this message translates to:
  /// **'余りを扱う代数学の計算 ≡'**
  String get modGachaSubtitle;

  /// No description provided for @sequenceGachaSubtitle.
  ///
  /// In ja, this message translates to:
  /// **'微分方程式との対応を考えると\n理解が深まります Σ'**
  String get sequenceGachaSubtitle;

  /// No description provided for @keywordSelectorTitle.
  ///
  /// In ja, this message translates to:
  /// **'キーワード選択'**
  String get keywordSelectorTitle;

  /// No description provided for @selectedKeywordsLabel.
  ///
  /// In ja, this message translates to:
  /// **'選択中({count}個): {keywords}'**
  String selectedKeywordsLabel(int count, String keywords);

  /// No description provided for @noKeywordsSelected.
  ///
  /// In ja, this message translates to:
  /// **'キーワード未選択（全問題を表示します）'**
  String get noKeywordsSelected;

  /// No description provided for @filteredCountLabel.
  ///
  /// In ja, this message translates to:
  /// **' {filtered}問 / 全{total}問'**
  String filteredCountLabel(int filtered, int total);

  /// No description provided for @noMatchingProblems.
  ///
  /// In ja, this message translates to:
  /// **'該当する問題がありません'**
  String get noMatchingProblems;

  /// No description provided for @loading.
  ///
  /// In ja, this message translates to:
  /// **'読み込み中...'**
  String get loading;

  /// No description provided for @updatedAt.
  ///
  /// In ja, this message translates to:
  /// **'更新: {time}'**
  String updatedAt(String time);

  /// No description provided for @detail.
  ///
  /// In ja, this message translates to:
  /// **'詳細'**
  String get detail;

  /// No description provided for @keyword_numerical.
  ///
  /// In ja, this message translates to:
  /// **'数値'**
  String get keyword_numerical;

  /// No description provided for @keyword_general.
  ///
  /// In ja, this message translates to:
  /// **'一般'**
  String get keyword_general;

  /// No description provided for @keyword_uam.
  ///
  /// In ja, this message translates to:
  /// **'等加速度直線運動'**
  String get keyword_uam;

  /// No description provided for @keyword_air_resistance.
  ///
  /// In ja, this message translates to:
  /// **'空気抵抗'**
  String get keyword_air_resistance;

  /// No description provided for @keyword_shm.
  ///
  /// In ja, this message translates to:
  /// **'単振動'**
  String get keyword_shm;

  /// No description provided for @keyword_dc.
  ///
  /// In ja, this message translates to:
  /// **'直流'**
  String get keyword_dc;

  /// No description provided for @keyword_ac.
  ///
  /// In ja, this message translates to:
  /// **'交流'**
  String get keyword_ac;

  /// No description provided for @keyword_voltage0.
  ///
  /// In ja, this message translates to:
  /// **'電圧0'**
  String get keyword_voltage0;

  /// No description provided for @keyword_capacitor.
  ///
  /// In ja, this message translates to:
  /// **'コンデンサ'**
  String get keyword_capacitor;

  /// No description provided for @keyword_inductor.
  ///
  /// In ja, this message translates to:
  /// **'コイル'**
  String get keyword_inductor;

  /// No description provided for @keyword_resistor.
  ///
  /// In ja, this message translates to:
  /// **'抵抗'**
  String get keyword_resistor;

  /// No description provided for @modGachaTitleOnly.
  ///
  /// In ja, this message translates to:
  /// **'modガチャ！'**
  String get modGachaTitleOnly;

  /// No description provided for @problemList.
  ///
  /// In ja, this message translates to:
  /// **'問題一覧'**
  String get problemList;

  /// No description provided for @howManyCards.
  ///
  /// In ja, this message translates to:
  /// **'カードを何枚選びますか？'**
  String get howManyCards;

  /// No description provided for @nCards.
  ///
  /// In ja, this message translates to:
  /// **'{count}枚'**
  String nCards(int count);

  /// No description provided for @startingAutomatically.
  ///
  /// In ja, this message translates to:
  /// **'自動的に開始します...'**
  String get startingAutomatically;

  /// No description provided for @timerFinished.
  ///
  /// In ja, this message translates to:
  /// **'タイマーが終了しました'**
  String get timerFinished;

  /// No description provided for @selectCards.
  ///
  /// In ja, this message translates to:
  /// **'カードを選択してください'**
  String get selectCards;

  /// No description provided for @backToCardSelection.
  ///
  /// In ja, this message translates to:
  /// **'カード選択に戻る'**
  String get backToCardSelection;

  /// No description provided for @hideDetails.
  ///
  /// In ja, this message translates to:
  /// **'詳細を閉じる'**
  String get hideDetails;

  /// No description provided for @showDetails.
  ///
  /// In ja, this message translates to:
  /// **'詳細を読む'**
  String get showDetails;

  /// No description provided for @next.
  ///
  /// In ja, this message translates to:
  /// **'次へ'**
  String get next;

  /// No description provided for @complete.
  ///
  /// In ja, this message translates to:
  /// **'完了'**
  String get complete;

  /// No description provided for @allProblemsSolvedSimple.
  ///
  /// In ja, this message translates to:
  /// **'すべての問題を解きました！'**
  String get allProblemsSolvedSimple;

  /// No description provided for @remainingCards.
  ///
  /// In ja, this message translates to:
  /// **'残り{count}枚'**
  String remainingCards(int count);

  /// No description provided for @back.
  ///
  /// In ja, this message translates to:
  /// **'戻る'**
  String get back;

  /// No description provided for @hideHint.
  ///
  /// In ja, this message translates to:
  /// **'ヒントを隠す'**
  String get hideHint;

  /// No description provided for @showHint.
  ///
  /// In ja, this message translates to:
  /// **'ヒントを表示'**
  String get showHint;

  /// No description provided for @closeScratchPaper.
  ///
  /// In ja, this message translates to:
  /// **'計算用紙を閉じる'**
  String get closeScratchPaper;

  /// No description provided for @openScratchPaper.
  ///
  /// In ja, this message translates to:
  /// **'計算用紙を開く'**
  String get openScratchPaper;

  /// No description provided for @excludingLabel.
  ///
  /// In ja, this message translates to:
  /// **'を除く'**
  String get excludingLabel;

  /// No description provided for @gachaSettings.
  ///
  /// In ja, this message translates to:
  /// **'ガチャ設定'**
  String get gachaSettings;

  /// No description provided for @filteringSettings.
  ///
  /// In ja, this message translates to:
  /// **'フィルタリング設定'**
  String get filteringSettings;

  /// No description provided for @filterModeRandom.
  ///
  /// In ja, this message translates to:
  /// **'完全ランダム（除外なし）'**
  String get filterModeRandom;

  /// No description provided for @filterModeExcludeSolved.
  ///
  /// In ja, this message translates to:
  /// **'解決済みの問題を除く'**
  String get filterModeExcludeSolved;

  /// No description provided for @filterModeOnlyUnsolved.
  ///
  /// In ja, this message translates to:
  /// **'未解決の問題のみ'**
  String get filterModeOnlyUnsolved;

  /// No description provided for @settingsSaved.
  ///
  /// In ja, this message translates to:
  /// **'設定を保存しました'**
  String get settingsSaved;

  /// No description provided for @difficultyForProblem.
  ///
  /// In ja, this message translates to:
  /// **'第{index}問の難易度'**
  String difficultyForProblem(int index);

  /// No description provided for @selectDifficultyForEachSlot.
  ///
  /// In ja, this message translates to:
  /// **'各枠の難易度を選択してください'**
  String get selectDifficultyForEachSlot;

  /// No description provided for @exclusionRuleDescription.
  ///
  /// In ja, this message translates to:
  /// **'※除外ルールは問題一覧で見られる最新3回分の学習記録を用いて判定します。'**
  String get exclusionRuleDescription;

  /// No description provided for @pmGachaKeywordDescription.
  ///
  /// In ja, this message translates to:
  /// **'※微分方程式ガチャでは、キーワードで問題を分類しています。'**
  String get pmGachaKeywordDescription;

  /// No description provided for @keywordSelectionInGachaScreen.
  ///
  /// In ja, this message translates to:
  /// **'※キーワード選択はガチャ画面で行えます。'**
  String get keywordSelectionInGachaScreen;

  /// No description provided for @easy.
  ///
  /// In ja, this message translates to:
  /// **'初級'**
  String get easy;

  /// No description provided for @mid.
  ///
  /// In ja, this message translates to:
  /// **'中級'**
  String get mid;

  /// No description provided for @advanced.
  ///
  /// In ja, this message translates to:
  /// **'上級'**
  String get advanced;

  /// No description provided for @expert.
  ///
  /// In ja, this message translates to:
  /// **'発展'**
  String get expert;

  /// No description provided for @latestN.
  ///
  /// In ja, this message translates to:
  /// **'最新{n}回が'**
  String latestN(int n);

  /// No description provided for @drawWithFinger.
  ///
  /// In ja, this message translates to:
  /// **'指で描画'**
  String get drawWithFinger;

  /// No description provided for @clearAll.
  ///
  /// In ja, this message translates to:
  /// **'全消し'**
  String get clearAll;

  /// No description provided for @undo.
  ///
  /// In ja, this message translates to:
  /// **'元に戻す'**
  String get undo;

  /// No description provided for @redo.
  ///
  /// In ja, this message translates to:
  /// **'やり直し'**
  String get redo;

  /// No description provided for @showExplanation.
  ///
  /// In ja, this message translates to:
  /// **'解説を表示'**
  String get showExplanation;

  /// No description provided for @close.
  ///
  /// In ja, this message translates to:
  /// **'閉じる'**
  String get close;

  /// No description provided for @selectColor.
  ///
  /// In ja, this message translates to:
  /// **'色を選択'**
  String get selectColor;

  /// No description provided for @storagePermissionRequired.
  ///
  /// In ja, this message translates to:
  /// **'ストレージ権限が必要です'**
  String get storagePermissionRequired;

  /// No description provided for @imageSaved.
  ///
  /// In ja, this message translates to:
  /// **'画像を保存しました: {path}'**
  String imageSaved(String path);

  /// No description provided for @saveFailed.
  ///
  /// In ja, this message translates to:
  /// **'保存に失敗しました: {error}'**
  String saveFailed(String error);

  /// No description provided for @learningRecordSaved.
  ///
  /// In ja, this message translates to:
  /// **'学習記録を保存しました'**
  String get learningRecordSaved;

  /// No description provided for @learningRecordSaveFailed.
  ///
  /// In ja, this message translates to:
  /// **'学習記録の保存に失敗しました'**
  String get learningRecordSaveFailed;

  /// No description provided for @defaultPrice.
  ///
  /// In ja, this message translates to:
  /// **'500円'**
  String get defaultPrice;

  /// No description provided for @unknownError.
  ///
  /// In ja, this message translates to:
  /// **'不明なエラー'**
  String get unknownError;

  /// No description provided for @noFirestorePermission.
  ///
  /// In ja, this message translates to:
  /// **'Firestoreへのアクセス権限がありません。設定を確認してください。'**
  String get noFirestorePermission;

  /// No description provided for @syncError.
  ///
  /// In ja, this message translates to:
  /// **'同期中にエラーが発生しました。一部のデータは同期されていない可能性があります。'**
  String get syncError;

  /// No description provided for @auth_passwordResetEmailSent.
  ///
  /// In ja, this message translates to:
  /// **'パスワードリセットメールを送信しました。\nメールボックスを確認してください。'**
  String get auth_passwordResetEmailSent;

  /// No description provided for @auth_passwordResetFailed.
  ///
  /// In ja, this message translates to:
  /// **'パスワードリセットメールの送信に失敗しました'**
  String get auth_passwordResetFailed;

  /// No description provided for @auth_userNotFound.
  ///
  /// In ja, this message translates to:
  /// **'このメールアドレスのアカウントが見つかりません。'**
  String get auth_userNotFound;

  /// No description provided for @auth_invalidEmail.
  ///
  /// In ja, this message translates to:
  /// **'無効なメールアドレスです。'**
  String get auth_invalidEmail;

  /// No description provided for @auth_tooManyRequests.
  ///
  /// In ja, this message translates to:
  /// **'リクエストが多すぎます。\nしばらく待ってから再度お試しください。'**
  String get auth_tooManyRequests;

  /// No description provided for @auth_emailSignInSuccess.
  ///
  /// In ja, this message translates to:
  /// **'{method}でクラウドに保存しました'**
  String auth_emailSignInSuccess(String method);

  /// No description provided for @auth_signUpSuccess.
  ///
  /// In ja, this message translates to:
  /// **'{method}で新規登録しました'**
  String auth_signUpSuccess(String method);

  /// No description provided for @auth_signInFailed.
  ///
  /// In ja, this message translates to:
  /// **'クラウドに保存に失敗しました'**
  String get auth_signInFailed;

  /// No description provided for @auth_signUpFailed.
  ///
  /// In ja, this message translates to:
  /// **'サインアップに失敗しました'**
  String get auth_signUpFailed;

  /// No description provided for @auth_lockTitle.
  ///
  /// In ja, this message translates to:
  /// **'ログインがロックされています'**
  String get auth_lockTitle;

  /// No description provided for @auth_lockMessageResetRequired.
  ///
  /// In ja, this message translates to:
  /// **'ログイン試行回数が上限に達しました。\nパスワードリセットが必要です。\n\n「パスワードを忘れた場合」から\nパスワードリセットメールを送信してください。'**
  String get auth_lockMessageResetRequired;

  /// No description provided for @auth_lockMessageWait.
  ///
  /// In ja, this message translates to:
  /// **'ログイン試行回数が上限に達しました。\n約{minutes}分後に自動的に解除されます。\n\nしばらく待ってから再度お試しください。'**
  String auth_lockMessageWait(int minutes);

  /// No description provided for @auth_emailAlreadyInUse.
  ///
  /// In ja, this message translates to:
  /// **'このメールアドレスは既に使用されています。\nクラウドに保存してください。'**
  String get auth_emailAlreadyInUse;

  /// No description provided for @auth_weakPassword.
  ///
  /// In ja, this message translates to:
  /// **'パスワードが弱すぎます。\nより強力なパスワードを設定してください。'**
  String get auth_weakPassword;

  /// No description provided for @auth_wrongPassword.
  ///
  /// In ja, this message translates to:
  /// **'メールアドレスまたはパスワードが正しくありません。\nもう一度確認してください。'**
  String get auth_wrongPassword;

  /// No description provided for @auth_credentialAlreadyInUse.
  ///
  /// In ja, this message translates to:
  /// **'このアカウントは既に別の方法で登録されています。\n既存の認証方法を使用してください。'**
  String get auth_credentialAlreadyInUse;

  /// No description provided for @auth_operationNotAllowed.
  ///
  /// In ja, this message translates to:
  /// **'この認証方法は有効になっていません。'**
  String get auth_operationNotAllowed;

  /// No description provided for @auth_smsCodeSent.
  ///
  /// In ja, this message translates to:
  /// **'SMSコードを送信しました'**
  String get auth_smsCodeSent;

  /// No description provided for @auth_smsVerificationFailed.
  ///
  /// In ja, this message translates to:
  /// **'SMSコードの認証に失敗しました'**
  String get auth_smsVerificationFailed;

  /// No description provided for @auth_invalidVerificationCode.
  ///
  /// In ja, this message translates to:
  /// **'SMSコードが正しくありません。\nもう一度確認してください。'**
  String get auth_invalidVerificationCode;

  /// No description provided for @auth_invalidVerificationId.
  ///
  /// In ja, this message translates to:
  /// **'検証IDが無効です。\nもう一度電話番号を入力してください。'**
  String get auth_invalidVerificationId;

  /// No description provided for @auth_sessionExpired.
  ///
  /// In ja, this message translates to:
  /// **'セッションが期限切れです。\nもう一度電話番号を入力してください。'**
  String get auth_sessionExpired;

  /// No description provided for @auth_phoneAlreadyInUse.
  ///
  /// In ja, this message translates to:
  /// **'この電話番号は既に使用されています。\n既存の認証方法を使用してください。'**
  String get auth_phoneAlreadyInUse;

  /// No description provided for @auth_providerAlreadyLinked.
  ///
  /// In ja, this message translates to:
  /// **'この電話番号は既にこのアカウントにリンクされています。'**
  String get auth_providerAlreadyLinked;

  /// No description provided for @auth_phoneAuthDisabled.
  ///
  /// In ja, this message translates to:
  /// **'電話番号認証が有効になっていません。\nFirebase Consoleで設定を確認してください。'**
  String get auth_phoneAuthDisabled;

  /// No description provided for @auth_phoneVerificationInternalError.
  ///
  /// In ja, this message translates to:
  /// **'内部エラーが発生しました。\nFirebase Consoleで電話番号認証が有効になっているか確認してください。\nエラーコード: {code}\n詳細: {details}'**
  String auth_phoneVerificationInternalError(String code, String details);

  /// No description provided for @auth_phoneVerificationTooManyRequests.
  ///
  /// In ja, this message translates to:
  /// **'このデバイスからのリクエストが多すぎます。\nしばらく待ってから再度お試しください。'**
  String get auth_phoneVerificationTooManyRequests;

  /// No description provided for @auth_phoneVerificationQuotaExceeded.
  ///
  /// In ja, this message translates to:
  /// **'SMS送信の上限に達しました。\nしばらく待ってから再度お試しください。必要ならFirebaseの請求/上限をご確認ください。'**
  String get auth_phoneVerificationQuotaExceeded;

  /// No description provided for @auth_phoneVerificationCaptchaFailed.
  ///
  /// In ja, this message translates to:
  /// **'reCAPTCHA認証に失敗しました。\nもう一度お試しください。'**
  String get auth_phoneVerificationCaptchaFailed;

  /// No description provided for @auth_phoneVerificationInvalidAppCredential.
  ///
  /// In ja, this message translates to:
  /// **'アプリの認証情報が無効です。\nFirebase設定ファイルを確認してください。'**
  String get auth_phoneVerificationInvalidAppCredential;

  /// No description provided for @auth_phoneVerificationStartFailed.
  ///
  /// In ja, this message translates to:
  /// **'電話番号認証の開始に失敗しました: {error}'**
  String auth_phoneVerificationStartFailed(String error);

  /// No description provided for @auth_unexpectedError.
  ///
  /// In ja, this message translates to:
  /// **'エラーが発生しました: {error}'**
  String auth_unexpectedError(String error);

  /// No description provided for @auth_firebaseNotConfigured.
  ///
  /// In ja, this message translates to:
  /// **'Firebaseが設定されていません'**
  String get auth_firebaseNotConfigured;

  /// No description provided for @auth_firebaseConfigGuide.
  ///
  /// In ja, this message translates to:
  /// **'クラウドに保存するには、Firebase設定ファイルが必要です。\nFirebase Consoleから設定ファイルをダウンロードして配置してください。'**
  String get auth_firebaseConfigGuide;

  /// No description provided for @auth_phoneSignInButton.
  ///
  /// In ja, this message translates to:
  /// **'電話番号でクラウドに保存'**
  String get auth_phoneSignInButton;

  /// No description provided for @auth_emailSignInButton.
  ///
  /// In ja, this message translates to:
  /// **'メールアドレスでクラウドに保存'**
  String get auth_emailSignInButton;

  /// No description provided for @auth_googleSignInButton.
  ///
  /// In ja, this message translates to:
  /// **'Googleでクラウドに保存'**
  String get auth_googleSignInButton;

  /// No description provided for @auth_appleSignInButton.
  ///
  /// In ja, this message translates to:
  /// **'Appleアカウントでクラウドに保存'**
  String get auth_appleSignInButton;

  /// No description provided for @auth_emailLabel.
  ///
  /// In ja, this message translates to:
  /// **'メールアドレス'**
  String get auth_emailLabel;

  /// No description provided for @auth_passwordLabel.
  ///
  /// In ja, this message translates to:
  /// **'パスワード'**
  String get auth_passwordLabel;

  /// No description provided for @auth_emailRequired.
  ///
  /// In ja, this message translates to:
  /// **'メールアドレスを入力してください'**
  String get auth_emailRequired;

  /// No description provided for @auth_passwordRequired.
  ///
  /// In ja, this message translates to:
  /// **'パスワードを入力してください'**
  String get auth_passwordRequired;

  /// No description provided for @auth_passwordTooShort.
  ///
  /// In ja, this message translates to:
  /// **'パスワードは6文字以上で入力してください'**
  String get auth_passwordTooShort;

  /// No description provided for @auth_forgotPassword.
  ///
  /// In ja, this message translates to:
  /// **'パスワードを忘れた場合'**
  String get auth_forgotPassword;

  /// No description provided for @auth_alreadyHaveAccount.
  ///
  /// In ja, this message translates to:
  /// **'既にアカウントをお持ちの方はこちら'**
  String get auth_alreadyHaveAccount;

  /// No description provided for @auth_createNewAccount.
  ///
  /// In ja, this message translates to:
  /// **'新規登録はこちら'**
  String get auth_createNewAccount;

  /// No description provided for @auth_sendResetEmailButton.
  ///
  /// In ja, this message translates to:
  /// **'パスワードリセットメールを送信'**
  String get auth_sendResetEmailButton;

  /// No description provided for @auth_phoneNumberLabel.
  ///
  /// In ja, this message translates to:
  /// **'電話番号'**
  String get auth_phoneNumberLabel;

  /// No description provided for @auth_phoneNumberHint.
  ///
  /// In ja, this message translates to:
  /// **'09012345678 または +819012345678'**
  String get auth_phoneNumberHint;

  /// No description provided for @auth_phoneNumberRequired.
  ///
  /// In ja, this message translates to:
  /// **'電話番号を入力してください'**
  String get auth_phoneNumberRequired;

  /// No description provided for @auth_invalidPhoneNumber.
  ///
  /// In ja, this message translates to:
  /// **'有効な電話番号を入力してください'**
  String get auth_invalidPhoneNumber;

  /// No description provided for @auth_sendSmsCodeButton.
  ///
  /// In ja, this message translates to:
  /// **'SMSコードを送信'**
  String get auth_sendSmsCodeButton;

  /// No description provided for @auth_enterSmsCode.
  ///
  /// In ja, this message translates to:
  /// **'SMSコードを入力してください'**
  String get auth_enterSmsCode;

  /// No description provided for @auth_smsCodeSentTo.
  ///
  /// In ja, this message translates to:
  /// **'{phoneNumber} に送信しました'**
  String auth_smsCodeSentTo(String phoneNumber);

  /// No description provided for @auth_smsCodeLabel.
  ///
  /// In ja, this message translates to:
  /// **'SMSコード'**
  String get auth_smsCodeLabel;

  /// No description provided for @auth_smsCodeHint.
  ///
  /// In ja, this message translates to:
  /// **'6桁のコード'**
  String get auth_smsCodeHint;

  /// No description provided for @auth_smsCodeRequired.
  ///
  /// In ja, this message translates to:
  /// **'SMSコードを入力してください'**
  String get auth_smsCodeRequired;

  /// No description provided for @auth_smsCodeLength.
  ///
  /// In ja, this message translates to:
  /// **'6桁のコードを入力してください'**
  String get auth_smsCodeLength;

  /// No description provided for @auth_resendCodeButton.
  ///
  /// In ja, this message translates to:
  /// **'コードを再送信'**
  String get auth_resendCodeButton;

  /// No description provided for @auth_changePhoneNumberButton.
  ///
  /// In ja, this message translates to:
  /// **'電話番号を変更'**
  String get auth_changePhoneNumberButton;

  /// No description provided for @auth_cloudSyncDescription.
  ///
  /// In ja, this message translates to:
  /// **'クラウドに保存すると、学習記録がクラウドに保存され、\n複数のデバイス間で同期されます。'**
  String get auth_cloudSyncDescription;

  /// No description provided for @auth_methodEmail.
  ///
  /// In ja, this message translates to:
  /// **'メールアドレス'**
  String get auth_methodEmail;

  /// No description provided for @auth_methodPhone.
  ///
  /// In ja, this message translates to:
  /// **'電話番号'**
  String get auth_methodPhone;

  /// No description provided for @auth_methodGoogle.
  ///
  /// In ja, this message translates to:
  /// **'Googleアカウント'**
  String get auth_methodGoogle;

  /// No description provided for @auth_methodApple.
  ///
  /// In ja, this message translates to:
  /// **'Appleアカウント'**
  String get auth_methodApple;

  /// No description provided for @auth_signUpButton.
  ///
  /// In ja, this message translates to:
  /// **'新規登録'**
  String get auth_signUpButton;

  /// No description provided for @auth_signInButton.
  ///
  /// In ja, this message translates to:
  /// **'クラウドに保存'**
  String get auth_signInButton;

  /// No description provided for @auth_backButton.
  ///
  /// In ja, this message translates to:
  /// **'戻る'**
  String get auth_backButton;

  /// No description provided for @auth_verifyButton.
  ///
  /// In ja, this message translates to:
  /// **'認証する'**
  String get auth_verifyButton;

  /// No description provided for @rerollSlot.
  ///
  /// In ja, this message translates to:
  /// **'この枠だけリロール'**
  String get rerollSlot;

  /// No description provided for @saveLearningRecord.
  ///
  /// In ja, this message translates to:
  /// **'学習記録を保存'**
  String get saveLearningRecord;

  /// No description provided for @usingCloudWith.
  ///
  /// In ja, this message translates to:
  /// **'{method}でクラウドを利用中'**
  String usingCloudWith(String method);

  /// No description provided for @problemCountRemaining.
  ///
  /// In ja, this message translates to:
  /// **'(残 {filteredCount}問/{totalCount}問)'**
  String problemCountRemaining(int filteredCount, int totalCount);

  /// No description provided for @noExclusionAllCount.
  ///
  /// In ja, this message translates to:
  /// **'除外なし 全{count}問'**
  String noExclusionAllCount(int count);

  /// No description provided for @problemCountOutOf.
  ///
  /// In ja, this message translates to:
  /// **'({filteredCount}/{totalCount}問中)'**
  String problemCountOutOf(int filteredCount, int totalCount);

  /// No description provided for @problemCount.
  ///
  /// In ja, this message translates to:
  /// **'{count}問'**
  String problemCount(int count);

  /// No description provided for @latestNPrefix.
  ///
  /// In ja, this message translates to:
  /// **'最新{n}回の'**
  String latestNPrefix(int n);

  /// No description provided for @category_congruence.
  ///
  /// In ja, this message translates to:
  /// **'合同方程式'**
  String get category_congruence;

  /// No description provided for @category_indeterminate.
  ///
  /// In ja, this message translates to:
  /// **'不定方程式'**
  String get category_indeterminate;

  /// No description provided for @category_factorization.
  ///
  /// In ja, this message translates to:
  /// **'因数分解'**
  String get category_factorization;

  /// No description provided for @category_factorization_desc.
  ///
  /// In ja, this message translates to:
  /// **'因数分解の基礎から応用まで'**
  String get category_factorization_desc;

  /// No description provided for @category_recurrence.
  ///
  /// In ja, this message translates to:
  /// **'漸化式'**
  String get category_recurrence;

  /// No description provided for @category_recurrence_desc.
  ///
  /// In ja, this message translates to:
  /// **'漸化式の解法と応用'**
  String get category_recurrence_desc;

  /// No description provided for @category_limits.
  ///
  /// In ja, this message translates to:
  /// **'極限'**
  String get category_limits;

  /// No description provided for @category_limits_desc.
  ///
  /// In ja, this message translates to:
  /// **'極限の計算と応用'**
  String get category_limits_desc;

  /// No description provided for @category_integrals.
  ///
  /// In ja, this message translates to:
  /// **'積分'**
  String get category_integrals;

  /// No description provided for @category_integrals_desc.
  ///
  /// In ja, this message translates to:
  /// **'積分計算の基礎から応用まで'**
  String get category_integrals_desc;

  /// No description provided for @category_physics_math.
  ///
  /// In ja, this message translates to:
  /// **'物理数学'**
  String get category_physics_math;

  /// No description provided for @category_differential.
  ///
  /// In ja, this message translates to:
  /// **'微分'**
  String get category_differential;

  /// No description provided for @category_differential_desc.
  ///
  /// In ja, this message translates to:
  /// **'微分の計算と応用'**
  String get category_differential_desc;

  /// No description provided for @category_series.
  ///
  /// In ja, this message translates to:
  /// **'級数'**
  String get category_series;

  /// No description provided for @category_series_desc.
  ///
  /// In ja, this message translates to:
  /// **'級数の収束と発散'**
  String get category_series_desc;

  /// No description provided for @category_probability.
  ///
  /// In ja, this message translates to:
  /// **'確率'**
  String get category_probability;

  /// No description provided for @category_probability_desc.
  ///
  /// In ja, this message translates to:
  /// **'確率の基礎と応用'**
  String get category_probability_desc;

  /// No description provided for @keyword_other.
  ///
  /// In ja, this message translates to:
  /// **'その他'**
  String get keyword_other;

  /// No description provided for @keyword_resonance.
  ///
  /// In ja, this message translates to:
  /// **'共振'**
  String get keyword_resonance;

  /// No description provided for @keyword_firstOrderHomogeneous.
  ///
  /// In ja, this message translates to:
  /// **'一階斉次'**
  String get keyword_firstOrderHomogeneous;

  /// No description provided for @keyword_homogeneous.
  ///
  /// In ja, this message translates to:
  /// **'斉次'**
  String get keyword_homogeneous;

  /// No description provided for @keyword_nonHomogeneous.
  ///
  /// In ja, this message translates to:
  /// **'非斉次'**
  String get keyword_nonHomogeneous;

  /// No description provided for @keyword_university.
  ///
  /// In ja, this message translates to:
  /// **'大学'**
  String get keyword_university;

  /// No description provided for @cloudBackupConfirmTitle.
  ///
  /// In ja, this message translates to:
  /// **'クラウドにデータをバックアップしますか？'**
  String get cloudBackupConfirmTitle;

  /// No description provided for @gachaSuffix.
  ///
  /// In ja, this message translates to:
  /// **'ガチャ'**
  String get gachaSuffix;

  /// No description provided for @storekitTestTitle.
  ///
  /// In ja, this message translates to:
  /// **'StoreKit Configuration テスト'**
  String get storekitTestTitle;

  /// No description provided for @storekitTestHeader.
  ///
  /// In ja, this message translates to:
  /// **'StoreKit Configurationファイルのテスト'**
  String get storekitTestHeader;

  /// No description provided for @storekitTestDescription.
  ///
  /// In ja, this message translates to:
  /// **'ネイティブのSKProductsRequestを使用して、商品情報が取得できるかテストします。'**
  String get storekitTestDescription;

  /// No description provided for @storekitTestButtonIndeterminateOption.
  ///
  /// In ja, this message translates to:
  /// **'不定方程式オプション (160円) をテスト'**
  String get storekitTestButtonIndeterminateOption;

  /// No description provided for @storekitTestButtonFactorizationOption.
  ///
  /// In ja, this message translates to:
  /// **'因数分解オプション (80円) をテスト'**
  String get storekitTestButtonFactorizationOption;

  /// No description provided for @errorTitle.
  ///
  /// In ja, this message translates to:
  /// **'エラー'**
  String get errorTitle;

  /// No description provided for @storekitTestSucceeded.
  ///
  /// In ja, this message translates to:
  /// **'テスト成功'**
  String get storekitTestSucceeded;

  /// No description provided for @storekitHowToReadResults.
  ///
  /// In ja, this message translates to:
  /// **'テスト結果の見方'**
  String get storekitHowToReadResults;

  /// No description provided for @storekitResultSuccess.
  ///
  /// In ja, this message translates to:
  /// **'✅ 成功: StoreKit Configurationファイルが正しく設定されています'**
  String get storekitResultSuccess;

  /// No description provided for @storekitResultFailure.
  ///
  /// In ja, this message translates to:
  /// **'❌ 失敗: StoreKit Configurationファイルが設定されていないか、商品IDが間違っています'**
  String get storekitResultFailure;

  /// No description provided for @storekitSimulatorNote.
  ///
  /// In ja, this message translates to:
  /// **'注意: シミュレーターの場合、XcodeスキームでStoreKit Configurationファイルが設定されている必要があります。'**
  String get storekitSimulatorNote;

  /// No description provided for @storekitLabelProductId.
  ///
  /// In ja, this message translates to:
  /// **'Product ID'**
  String get storekitLabelProductId;

  /// No description provided for @storekitLabelTitle.
  ///
  /// In ja, this message translates to:
  /// **'Title'**
  String get storekitLabelTitle;

  /// No description provided for @storekitLabelDescription.
  ///
  /// In ja, this message translates to:
  /// **'Description'**
  String get storekitLabelDescription;

  /// No description provided for @storekitLabelPrice.
  ///
  /// In ja, this message translates to:
  /// **'Price'**
  String get storekitLabelPrice;

  /// No description provided for @storekitLabelPriceLocale.
  ///
  /// In ja, this message translates to:
  /// **'Price Locale'**
  String get storekitLabelPriceLocale;

  /// No description provided for @storekitLabelLocalizedPrice.
  ///
  /// In ja, this message translates to:
  /// **'Localized Price'**
  String get storekitLabelLocalizedPrice;

  /// No description provided for @equationLabel.
  ///
  /// In ja, this message translates to:
  /// **'式'**
  String get equationLabel;

  /// No description provided for @timerTooltipMinus1Min.
  ///
  /// In ja, this message translates to:
  /// **'1分削減'**
  String get timerTooltipMinus1Min;

  /// No description provided for @timerTooltipMinus30Sec.
  ///
  /// In ja, this message translates to:
  /// **'30秒削減'**
  String get timerTooltipMinus30Sec;

  /// No description provided for @timerTooltipPlus30Sec.
  ///
  /// In ja, this message translates to:
  /// **'30秒追加'**
  String get timerTooltipPlus30Sec;

  /// No description provided for @timerTooltipPlus1Min.
  ///
  /// In ja, this message translates to:
  /// **'1分追加'**
  String get timerTooltipPlus1Min;

  /// No description provided for @timerTooltipReset.
  ///
  /// In ja, this message translates to:
  /// **'リセット'**
  String get timerTooltipReset;

  /// No description provided for @drawingToolPen.
  ///
  /// In ja, this message translates to:
  /// **'ペン'**
  String get drawingToolPen;

  /// No description provided for @drawingToolColor.
  ///
  /// In ja, this message translates to:
  /// **'色'**
  String get drawingToolColor;

  /// No description provided for @drawingToolWidth.
  ///
  /// In ja, this message translates to:
  /// **'太さ'**
  String get drawingToolWidth;

  /// No description provided for @calculatorTooltipShow.
  ///
  /// In ja, this message translates to:
  /// **'電卓を表示'**
  String get calculatorTooltipShow;

  /// No description provided for @calculatorTooltipClose.
  ///
  /// In ja, this message translates to:
  /// **'電卓を閉じる'**
  String get calculatorTooltipClose;

  /// No description provided for @congruenceHintExample.
  ///
  /// In ja, this message translates to:
  /// **'例: x≡ 2,3 (mod 5)'**
  String get congruenceHintExample;

  /// No description provided for @freeGachaSelectionInstruction.
  ///
  /// In ja, this message translates to:
  /// **'履歴管理を行うガチャを2つ選んでください'**
  String get freeGachaSelectionInstruction;

  /// No description provided for @freeGachaConfirmDialog.
  ///
  /// In ja, this message translates to:
  /// **'{gacha1}と{gacha2}の学習履歴を管理します。よろしいですか？'**
  String freeGachaConfirmDialog(String gacha1, String gacha2);

  /// No description provided for @freeGachaEnabledMessage.
  ///
  /// In ja, this message translates to:
  /// **'{gacha1}と{gacha2}の学習履歴が管理できるようになりました。'**
  String freeGachaEnabledMessage(String gacha1, String gacha2);

  /// No description provided for @freeGachaEnjoyMessage.
  ///
  /// In ja, this message translates to:
  /// **'どうぞ本アプリをお楽しみ下さい 🔢'**
  String get freeGachaEnjoyMessage;

  /// No description provided for @freeGachaProNote.
  ///
  /// In ja, this message translates to:
  /// **'※ 選択した2つのガチャは無料で\n学習履歴の登録ができます\n※ Pro版({price})を購入すると全ガチャで\n履歴管理が可能になります'**
  String freeGachaProNote(String price);

  /// No description provided for @comingSoon.
  ///
  /// In ja, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// No description provided for @storeVersionLabel.
  ///
  /// In ja, this message translates to:
  /// **'ストアバージョン: {storeVersion}'**
  String storeVersionLabel(String storeVersion);

  /// No description provided for @auth_googleSignInFailed.
  ///
  /// In ja, this message translates to:
  /// **'Google Sign-Inに失敗しました'**
  String get auth_googleSignInFailed;

  /// No description provided for @auth_networkErrorCheckConnection.
  ///
  /// In ja, this message translates to:
  /// **'ネットワークエラーが発生しました。\nインターネット接続を確認してください。'**
  String get auth_networkErrorCheckConnection;

  /// No description provided for @auth_appleSignInFailed.
  ///
  /// In ja, this message translates to:
  /// **'Apple Sign-Inに失敗しました'**
  String get auth_appleSignInFailed;

  /// No description provided for @auth_appleSignInFailedEnsureEnabled.
  ///
  /// In ja, this message translates to:
  /// **'Apple Sign-Inに失敗しました。\nFirebase ConsoleでApple Sign-Inが有効になっているか確認してください。'**
  String get auth_appleSignInFailedEnsureEnabled;

  /// No description provided for @auth_invalidCredentialTryAgain.
  ///
  /// In ja, this message translates to:
  /// **'認証情報が無効です。\nもう一度お試しください。'**
  String get auth_invalidCredentialTryAgain;

  /// No description provided for @auth_invalidIdTokenTryAgain.
  ///
  /// In ja, this message translates to:
  /// **'認証トークンが無効です。\nもう一度お試しください。'**
  String get auth_invalidIdTokenTryAgain;

  /// No description provided for @auth_appleSignInNotConfigured.
  ///
  /// In ja, this message translates to:
  /// **'Apple Sign-InがFirebase Consoleで設定されていません。\nFirebase Console > Authentication > Sign-in method で\nAppleを有効にしてください。'**
  String get auth_appleSignInNotConfigured;

  /// No description provided for @learningStatus_none.
  ///
  /// In ja, this message translates to:
  /// **'未学習'**
  String get learningStatus_none;

  /// No description provided for @learningStatus_solved.
  ///
  /// In ja, this message translates to:
  /// **'解決済み'**
  String get learningStatus_solved;

  /// No description provided for @learningStatus_understood.
  ///
  /// In ja, this message translates to:
  /// **'理解済み'**
  String get learningStatus_understood;

  /// No description provided for @learningStatus_failed.
  ///
  /// In ja, this message translates to:
  /// **'失敗'**
  String get learningStatus_failed;

  /// No description provided for @learningStatusTooltip_none.
  ///
  /// In ja, this message translates to:
  /// **'学習状態を選択'**
  String get learningStatusTooltip_none;

  /// No description provided for @learningStatusTooltip_solved.
  ///
  /// In ja, this message translates to:
  /// **'解けた'**
  String get learningStatusTooltip_solved;

  /// No description provided for @learningStatusTooltip_understood.
  ///
  /// In ja, this message translates to:
  /// **'理解できた'**
  String get learningStatusTooltip_understood;

  /// No description provided for @learningStatusTooltip_failed.
  ///
  /// In ja, this message translates to:
  /// **'できなかった'**
  String get learningStatusTooltip_failed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
