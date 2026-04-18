// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get updateDialogTitle => '新しいアップデートがあります';

  @override
  String get updateDialogMessage => '更新してみませんか？';

  @override
  String get updateDialogLater => 'あとで';

  @override
  String get updateDialogUpdate => '更新する';

  @override
  String get updateDialogReleaseNotes => '更新内容';

  @override
  String get categoryMechanics => '力学';

  @override
  String get categoryElectromagnetism => '電磁気学';

  @override
  String get categoryThermodynamics => '熱力学';

  @override
  String get categoryWaves => '波動';

  @override
  String problemListTitle(String gachaTypeName) {
    return '$gachaTypeName問題一覧';
  }

  @override
  String get unitGachaProblemListTitle => 'Unit Gacha 問題一覧';

  @override
  String get allProblemsSolved => '全ての問題を解き切りました！';

  @override
  String get appTitle => '【極】微積ガチャ！';

  @override
  String get showProgressRate => '達成率を表示';

  @override
  String get integralGacha => '積分ガチャ！';

  @override
  String get integralGachaTitle => '積分ガチャ';

  @override
  String get limitGachaTitle => '極限ガチャ';

  @override
  String get physicsMathGachaTitle => '物理数学ガチャ';

  @override
  String get physicsMathGachaProblemListTitle => '物理数学ガチャ 問題一覧';

  @override
  String get factorizationGachaTitle => '因数分解ガチャ';

  @override
  String get indeterminateEqGachaTitle => '不定方程式ガチャ';

  @override
  String get sequenceGachaTitle => '漸化式ガチャ';

  @override
  String get genericGachaTitle => '数学ガチャ';

  @override
  String get gachaContentsTitle => 'ガチャの内容';

  @override
  String get content_integral_abs => '絶対値を含む定積分';

  @override
  String get content_integral_basic => '基本公式の利用';

  @override
  String get content_integral_parts => '部分積分';

  @override
  String get content_integral_substitution => '置換積分';

  @override
  String get content_integral_partial_fraction => '部分分数分解';

  @override
  String get content_integral_trig_power => '三角関数の累乗';

  @override
  String get content_integral_exp_log => '指数・対数関数';

  @override
  String get content_integral_irrational_1 => '無理関数（1次式）';

  @override
  String get content_integral_irrational_2 => '無理関数（2次式）';

  @override
  String get content_integral_beta => 'ベータ関数の公式';

  @override
  String get content_limit_basic => '基本公式・有理化';

  @override
  String get content_limit_rationalization => '有理化・無理式';

  @override
  String get content_limit_trig => '三角関数の極限';

  @override
  String get content_limit_exp_log => '指数・対数関数の極限';

  @override
  String get content_limit_partial_fraction => '部分分数分解と和';

  @override
  String get content_limit_squeeze => 'はさみうちの原理';

  @override
  String get content_limit_riemann => '区分求積法';

  @override
  String get content_limit_famous => '有名な極限・eの定義';

  @override
  String get content_pm_uniform_accel => '等加速度直線運動';

  @override
  String get content_pm_shm_lc => '単振動・LC回路';

  @override
  String get content_pm_air_rl => '空気抵抗・RL回路';

  @override
  String get content_pm_rc => 'RC回路';

  @override
  String get content_pm_ac => '交流回路';

  @override
  String get content_fact_cross => 'たすき掛け';

  @override
  String get content_fact_factor_theorem => '因数定理';

  @override
  String get content_fact_replacement => '置き換え';

  @override
  String get content_fact_4th_degree => '複二次式';

  @override
  String get content_fact_low_degree => '最低次数の文字で整理';

  @override
  String get content_fact_sort_by_var => '特定の文字で整理';

  @override
  String get content_fact_5th_degree => '5次以上の因数分解';

  @override
  String get content_indet_basic => '1次不定方程式';

  @override
  String get content_indet_3vars => '3変数不定方程式';

  @override
  String get content_indet_quadratic_hyperbola => '2次不定方程式（双曲線型）';

  @override
  String get content_indet_quadratic_ellipse => '2次不定方程式（楕円型）';

  @override
  String get content_indet_high_degree => '高次不定方程式';

  @override
  String get content_seq_2terms => '2項間漸化式';

  @override
  String get content_seq_3terms => '3項間漸化式';

  @override
  String get content_seq_simultaneous => '連立漸化式';

  @override
  String get content_seq_fractional => '分数型漸化式';

  @override
  String get content_seq_variable_coeff => '係数が変数の方程式';

  @override
  String get content_seq_root_power => 'べき乗・ルート型';

  @override
  String integralCount(int count) {
    return '$count問';
  }

  @override
  String get randomIntegralPractice => 'ランダム積分練習 🎲';

  @override
  String get limitGacha => '極限ガチャ！';

  @override
  String limitCount(int count) {
    return '$count問';
  }

  @override
  String get someDontConverge => '収束しない問題もあります ⤴️';

  @override
  String get differentialEquationGacha => '微分方程式ガチャ';

  @override
  String deCount(int count) {
    return '$count問';
  }

  @override
  String get physicsDECollection => '物理に登場する\n微分方程式を集めました 🧲';

  @override
  String get bonusGachaHome => 'おまけガチャ Home';

  @override
  String get bonusGachaDescription => '因数分解・不定方程式\n 合同方程式(mod)・漸化式 🎁';

  @override
  String get scratchPaper => '計算用紙';

  @override
  String get learningHistoryFeature => '学習履歴登録機能';

  @override
  String get learningHistoryDescription => '本アプリでは学習履歴を管理できます。';

  @override
  String get greenCheckDescription => '緑チェック = 自力で解けた';

  @override
  String get yellowCheckDescription => '黄色チェック = 理解できた';

  @override
  String get redCheckDescription => '赤チェック = 分からない';

  @override
  String get registrationGuidePart1 => 'のように登録してご活用下さい。\n設定により';

  @override
  String get registrationGuidePart2 => 'をつけた問題をガチャから除外できます。';

  @override
  String get proVersion => 'Pro版';

  @override
  String proVersionPrice(String price) {
    return 'Pro版($price)';
  }

  @override
  String get proVersionDescription => 'では全ガチャの学習履歴を管理できます。';

  @override
  String get login => 'ログイン';

  @override
  String get logout => 'ログアウト';

  @override
  String get loggedOut => 'ログアウトしました';

  @override
  String get syncWithCloud => 'クラウドデータと同期';

  @override
  String get syncCompleted => 'クラウドデータとの同期が完了しました';

  @override
  String get noExclusion => '除外なし';

  @override
  String latestNTimes(int n) {
    return '最新$n回が ';
  }

  @override
  String get ifSo => 'なら';

  @override
  String get removeFromGacha => 'ならガチャから外す';

  @override
  String aggregateLatestN(int n) {
    return '最新$n回分集計';
  }

  @override
  String aggregateLatestNLong(int n) {
    return '最新$n回分の記録を集計';
  }

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String privacyPolicyDescription(String link) {
    return '当アプリはアカウント管理とデータ同期のために Google Firebase 、および課金管理に RevenueCat を利用しています。詳細は$linkをご確認ください。';
  }

  @override
  String get purchaseTitle => 'Pro版 - 学習履歴機能';

  @override
  String priceLabel(String price) {
    return '価格: $price';
  }

  @override
  String get cancel => 'キャンセル';

  @override
  String get purchase => '購入する';

  @override
  String get purchaseComplete => '購入が完了しました';

  @override
  String purchaseFailed(String error) {
    return '購入に失敗しました: $error';
  }

  @override
  String errorOccurred(String error) {
    return 'エラーが発生しました: $error';
  }

  @override
  String get pastPurchasesRestored => '過去の購入を復元しました👍';

  @override
  String get ok => 'OK';

  @override
  String get details => '詳細';

  @override
  String get aggregatedBy => 'で集計';

  @override
  String achievedCount(Object achieved, Object total) {
    return '$achieved問/$total問 達成';
  }

  @override
  String get rolling => 'ガチャ中...';

  @override
  String get rollGacha => 'ガチャを回す';

  @override
  String get noProblems => '問題がありません';

  @override
  String problemIndex(int index) {
    return '第$index問';
  }

  @override
  String get hideAnswer => '答えを隠す';

  @override
  String get showAnswer => '答えを見る';

  @override
  String recordSaved(String status) {
    return '学習記録を保存しました: $status';
  }

  @override
  String get preparingProblemList => '問題一覧を準備中…';

  @override
  String get allDisplayed => '全て表示';

  @override
  String recordSavedAt(String date) {
    return '保存: $date';
  }

  @override
  String latestNTimesShort(int n) {
    return '最新$n回が';
  }

  @override
  String get excludeSuffix => 'の問題を除く';

  @override
  String get restoredPurchases => '購入を復元しました';

  @override
  String get noRestorablePurchases => '復元できる購入が見つかりませんでした';

  @override
  String restoreFailed(String error) {
    return '復元に失敗しました: $error';
  }

  @override
  String get clearAllSlots => '全スロット消去';

  @override
  String get hideSolution => '解答を隠す';

  @override
  String get showSolution => '解答を表示';

  @override
  String get answerLabel => '【答え】';

  @override
  String get pointLabel => '【ポイント】';

  @override
  String get explanationLabel => '【解説】';

  @override
  String get hintLabelTitle => '【ヒント】';

  @override
  String get bonusGachaTitle => 'おまけガチャ！';

  @override
  String get unitGachaComingSoon => '※単位ガチャは別アプリでリリース予定！';

  @override
  String get factorizationGachaSubtitle => '整数係数の範囲で\n因数分解してください 0️⃣';

  @override
  String get indetEqGachaTitleOnly => '不定方程式ガチャ';

  @override
  String get indetEqGachaSubtitle => '整数解を探してみよう 🔢';

  @override
  String get modGachaTitle => 'modガチャ！';

  @override
  String get modGachaSubtitle => '余りを扱う代数学の計算 ≡';

  @override
  String get sequenceGachaSubtitle => '微分方程式との対応を考えると\n理解が深まります Σ';

  @override
  String get keywordSelectorTitle => 'キーワード選択';

  @override
  String selectedKeywordsLabel(int count, String keywords) {
    return '選択中($count個): $keywords';
  }

  @override
  String get noKeywordsSelected => 'キーワード未選択（全問題を表示します）';

  @override
  String filteredCountLabel(int filtered, int total) {
    return ' $filtered問 / 全$total問';
  }

  @override
  String get noMatchingProblems => '該当する問題がありません';

  @override
  String get loading => '読み込み中...';

  @override
  String updatedAt(String time) {
    return '更新: $time';
  }

  @override
  String get detail => '詳細';

  @override
  String get keyword_numerical => '数値';

  @override
  String get keyword_general => '一般';

  @override
  String get keyword_uam => '等加速度直線運動';

  @override
  String get keyword_air_resistance => '空気抵抗';

  @override
  String get keyword_shm => '単振動';

  @override
  String get keyword_dc => '直流';

  @override
  String get keyword_ac => '交流';

  @override
  String get keyword_voltage0 => '電圧0';

  @override
  String get keyword_capacitor => 'コンデンサ';

  @override
  String get keyword_inductor => 'コイル';

  @override
  String get keyword_resistor => '抵抗';

  @override
  String get modGachaTitleOnly => 'modガチャ！';

  @override
  String get problemList => '問題一覧';

  @override
  String get howManyCards => 'カードを何枚選びますか？';

  @override
  String nCards(int count) {
    return '$count枚';
  }

  @override
  String get startingAutomatically => '自動的に開始します...';

  @override
  String get timerFinished => 'タイマーが終了しました';

  @override
  String get selectCards => 'カードを選択してください';

  @override
  String get backToCardSelection => 'カード選択に戻る';

  @override
  String get hideDetails => '詳細を閉じる';

  @override
  String get showDetails => '詳細を読む';

  @override
  String get next => '次へ';

  @override
  String get complete => '完了';

  @override
  String get allProblemsSolvedSimple => 'すべての問題を解きました！';

  @override
  String remainingCards(int count) {
    return '残り$count枚';
  }

  @override
  String get back => '戻る';

  @override
  String get hideHint => 'ヒントを隠す';

  @override
  String get showHint => 'ヒントを表示';

  @override
  String get closeScratchPaper => '計算用紙を閉じる';

  @override
  String get openScratchPaper => '計算用紙を開く';

  @override
  String get excludingLabel => 'を除く';

  @override
  String get gachaSettings => 'ガチャ設定';

  @override
  String get filteringSettings => 'フィルタリング設定';

  @override
  String get filterModeRandom => '完全ランダム（除外なし）';

  @override
  String get filterModeExcludeSolved => '解決済みの問題を除く';

  @override
  String get filterModeOnlyUnsolved => '未解決の問題のみ';

  @override
  String get settingsSaved => '設定を保存しました';

  @override
  String difficultyForProblem(int index) {
    return '第$index問の難易度';
  }

  @override
  String get selectDifficultyForEachSlot => '各枠の難易度を選択してください';

  @override
  String get exclusionRuleDescription => '※除外ルールは問題一覧で見られる最新3回分の学習記録を用いて判定します。';

  @override
  String get pmGachaKeywordDescription => '※微分方程式ガチャでは、キーワードで問題を分類しています。';

  @override
  String get keywordSelectionInGachaScreen => '※キーワード選択はガチャ画面で行えます。';

  @override
  String get easy => '初級';

  @override
  String get mid => '中級';

  @override
  String get advanced => '上級';

  @override
  String get expert => '発展';

  @override
  String latestN(int n) {
    return '最新$n回が';
  }

  @override
  String get drawWithFinger => '指で描画';

  @override
  String get clearAll => '全消し';

  @override
  String get undo => '元に戻す';

  @override
  String get redo => 'やり直し';

  @override
  String get showExplanation => '解説を表示';

  @override
  String get close => '閉じる';

  @override
  String get selectColor => '色を選択';

  @override
  String get storagePermissionRequired => 'ストレージ権限が必要です';

  @override
  String imageSaved(String path) {
    return '画像を保存しました: $path';
  }

  @override
  String saveFailed(String error) {
    return '保存に失敗しました: $error';
  }

  @override
  String get learningRecordSaved => '学習記録を保存しました';

  @override
  String get learningRecordSaveFailed => '学習記録の保存に失敗しました';

  @override
  String get defaultPrice => '500円';

  @override
  String get unknownError => '不明なエラー';

  @override
  String get noFirestorePermission => 'Firestoreへのアクセス権限がありません。設定を確認してください。';

  @override
  String get syncError => '同期中にエラーが発生しました。一部のデータは同期されていない可能性があります。';

  @override
  String get auth_passwordResetEmailSent =>
      'パスワードリセットメールを送信しました。\nメールボックスを確認してください。';

  @override
  String get auth_passwordResetFailed => 'パスワードリセットメールの送信に失敗しました';

  @override
  String get auth_userNotFound => 'このメールアドレスのアカウントが見つかりません。';

  @override
  String get auth_invalidEmail => '無効なメールアドレスです。';

  @override
  String get auth_tooManyRequests => 'リクエストが多すぎます。\nしばらく待ってから再度お試しください。';

  @override
  String auth_emailSignInSuccess(String method) {
    return '$methodでクラウドに保存しました';
  }

  @override
  String auth_signUpSuccess(String method) {
    return '$methodで新規登録しました';
  }

  @override
  String get auth_signInFailed => 'クラウドに保存に失敗しました';

  @override
  String get auth_signUpFailed => 'サインアップに失敗しました';

  @override
  String get auth_lockTitle => 'ログインがロックされています';

  @override
  String get auth_lockMessageResetRequired =>
      'ログイン試行回数が上限に達しました。\nパスワードリセットが必要です。\n\n「パスワードを忘れた場合」から\nパスワードリセットメールを送信してください。';

  @override
  String auth_lockMessageWait(int minutes) {
    return 'ログイン試行回数が上限に達しました。\n約$minutes分後に自動的に解除されます。\n\nしばらく待ってから再度お試しください。';
  }

  @override
  String get auth_emailAlreadyInUse => 'このメールアドレスは既に使用されています。\nクラウドに保存してください。';

  @override
  String get auth_weakPassword => 'パスワードが弱すぎます。\nより強力なパスワードを設定してください。';

  @override
  String get auth_wrongPassword => 'メールアドレスまたはパスワードが正しくありません。\nもう一度確認してください。';

  @override
  String get auth_credentialAlreadyInUse =>
      'このアカウントは既に別の方法で登録されています。\n既存の認証方法を使用してください。';

  @override
  String get auth_operationNotAllowed => 'この認証方法は有効になっていません。';

  @override
  String get auth_smsCodeSent => 'SMSコードを送信しました';

  @override
  String get auth_smsVerificationFailed => 'SMSコードの認証に失敗しました';

  @override
  String get auth_invalidVerificationCode => 'SMSコードが正しくありません。\nもう一度確認してください。';

  @override
  String get auth_invalidVerificationId => '検証IDが無効です。\nもう一度電話番号を入力してください。';

  @override
  String get auth_sessionExpired => 'セッションが期限切れです。\nもう一度電話番号を入力してください。';

  @override
  String get auth_phoneAlreadyInUse => 'この電話番号は既に使用されています。\n既存の認証方法を使用してください。';

  @override
  String get auth_providerAlreadyLinked => 'この電話番号は既にこのアカウントにリンクされています。';

  @override
  String get auth_phoneAuthDisabled =>
      '電話番号認証が有効になっていません。\nFirebase Consoleで設定を確認してください。';

  @override
  String auth_phoneVerificationInternalError(String code, String details) {
    return '内部エラーが発生しました。\nFirebase Consoleで電話番号認証が有効になっているか確認してください。\nエラーコード: $code\n詳細: $details';
  }

  @override
  String get auth_phoneVerificationTooManyRequests =>
      'このデバイスからのリクエストが多すぎます。\nしばらく待ってから再度お試しください。';

  @override
  String get auth_phoneVerificationQuotaExceeded =>
      'SMS送信の上限に達しました。\nしばらく待ってから再度お試しください。必要ならFirebaseの請求/上限をご確認ください。';

  @override
  String get auth_phoneVerificationCaptchaFailed =>
      'reCAPTCHA認証に失敗しました。\nもう一度お試しください。';

  @override
  String get auth_phoneVerificationInvalidAppCredential =>
      'アプリの認証情報が無効です。\nFirebase設定ファイルを確認してください。';

  @override
  String auth_phoneVerificationStartFailed(String error) {
    return '電話番号認証の開始に失敗しました: $error';
  }

  @override
  String auth_unexpectedError(String error) {
    return 'エラーが発生しました: $error';
  }

  @override
  String get auth_firebaseNotConfigured => 'Firebaseが設定されていません';

  @override
  String get auth_firebaseConfigGuide =>
      'クラウドに保存するには、Firebase設定ファイルが必要です。\nFirebase Consoleから設定ファイルをダウンロードして配置してください。';

  @override
  String get auth_phoneSignInButton => '電話番号でクラウドに保存';

  @override
  String get auth_emailSignInButton => 'メールアドレスでクラウドに保存';

  @override
  String get auth_googleSignInButton => 'Googleでクラウドに保存';

  @override
  String get auth_appleSignInButton => 'Appleアカウントでクラウドに保存';

  @override
  String get auth_emailLabel => 'メールアドレス';

  @override
  String get auth_passwordLabel => 'パスワード';

  @override
  String get auth_emailRequired => 'メールアドレスを入力してください';

  @override
  String get auth_passwordRequired => 'パスワードを入力してください';

  @override
  String get auth_passwordTooShort => 'パスワードは6文字以上で入力してください';

  @override
  String get auth_forgotPassword => 'パスワードを忘れた場合';

  @override
  String get auth_alreadyHaveAccount => '既にアカウントをお持ちの方はこちら';

  @override
  String get auth_createNewAccount => '新規登録はこちら';

  @override
  String get auth_sendResetEmailButton => 'パスワードリセットメールを送信';

  @override
  String get auth_phoneNumberLabel => '電話番号';

  @override
  String get auth_phoneNumberHint => '09012345678 または +819012345678';

  @override
  String get auth_phoneNumberRequired => '電話番号を入力してください';

  @override
  String get auth_invalidPhoneNumber => '有効な電話番号を入力してください';

  @override
  String get auth_sendSmsCodeButton => 'SMSコードを送信';

  @override
  String get auth_enterSmsCode => 'SMSコードを入力してください';

  @override
  String auth_smsCodeSentTo(String phoneNumber) {
    return '$phoneNumber に送信しました';
  }

  @override
  String get auth_smsCodeLabel => 'SMSコード';

  @override
  String get auth_smsCodeHint => '6桁のコード';

  @override
  String get auth_smsCodeRequired => 'SMSコードを入力してください';

  @override
  String get auth_smsCodeLength => '6桁のコードを入力してください';

  @override
  String get auth_resendCodeButton => 'コードを再送信';

  @override
  String get auth_changePhoneNumberButton => '電話番号を変更';

  @override
  String get auth_cloudSyncDescription =>
      'クラウドに保存すると、学習記録がクラウドに保存され、\n複数のデバイス間で同期されます。';

  @override
  String get auth_methodEmail => 'メールアドレス';

  @override
  String get auth_methodPhone => '電話番号';

  @override
  String get auth_methodGoogle => 'Googleアカウント';

  @override
  String get auth_methodApple => 'Appleアカウント';

  @override
  String get auth_signUpButton => '新規登録';

  @override
  String get auth_signInButton => 'クラウドに保存';

  @override
  String get auth_backButton => '戻る';

  @override
  String get auth_verifyButton => '認証する';

  @override
  String get rerollSlot => 'この枠だけリロール';

  @override
  String get saveLearningRecord => '学習記録を保存';

  @override
  String usingCloudWith(String method) {
    return '$methodでクラウドを利用中';
  }

  @override
  String problemCountRemaining(int filteredCount, int totalCount) {
    return '(残 $filteredCount問/$totalCount問)';
  }

  @override
  String noExclusionAllCount(int count) {
    return '除外なし 全$count問';
  }

  @override
  String problemCountOutOf(int filteredCount, int totalCount) {
    return '($filteredCount/$totalCount問中)';
  }

  @override
  String problemCount(int count) {
    return '$count問';
  }

  @override
  String latestNPrefix(int n) {
    return '最新$n回の';
  }

  @override
  String get category_congruence => '合同方程式';

  @override
  String get category_indeterminate => '不定方程式';

  @override
  String get category_factorization => '因数分解';

  @override
  String get category_factorization_desc => '因数分解の基礎から応用まで';

  @override
  String get category_recurrence => '漸化式';

  @override
  String get category_recurrence_desc => '漸化式の解法と応用';

  @override
  String get category_limits => '極限';

  @override
  String get category_limits_desc => '極限の計算と応用';

  @override
  String get category_integrals => '積分';

  @override
  String get category_integrals_desc => '積分計算の基礎から応用まで';

  @override
  String get category_physics_math => '物理数学';

  @override
  String get category_differential => '微分';

  @override
  String get category_differential_desc => '微分の計算と応用';

  @override
  String get category_series => '級数';

  @override
  String get category_series_desc => '級数の収束と発散';

  @override
  String get category_probability => '確率';

  @override
  String get category_probability_desc => '確率の基礎と応用';

  @override
  String get keyword_other => 'その他';

  @override
  String get keyword_resonance => '共振';

  @override
  String get keyword_firstOrderHomogeneous => '一階斉次';

  @override
  String get keyword_homogeneous => '斉次';

  @override
  String get keyword_nonHomogeneous => '非斉次';

  @override
  String get keyword_university => '大学';

  @override
  String get cloudBackupConfirmTitle => 'クラウドにデータをバックアップしますか？';

  @override
  String get gachaSuffix => 'ガチャ';

  @override
  String get storekitTestTitle => 'StoreKit Configuration テスト';

  @override
  String get storekitTestHeader => 'StoreKit Configurationファイルのテスト';

  @override
  String get storekitTestDescription =>
      'ネイティブのSKProductsRequestを使用して、商品情報が取得できるかテストします。';

  @override
  String get storekitTestButtonIndeterminateOption => '不定方程式オプション (160円) をテスト';

  @override
  String get storekitTestButtonFactorizationOption => '因数分解オプション (80円) をテスト';

  @override
  String get errorTitle => 'エラー';

  @override
  String get storekitTestSucceeded => 'テスト成功';

  @override
  String get storekitHowToReadResults => 'テスト結果の見方';

  @override
  String get storekitResultSuccess =>
      '✅ 成功: StoreKit Configurationファイルが正しく設定されています';

  @override
  String get storekitResultFailure =>
      '❌ 失敗: StoreKit Configurationファイルが設定されていないか、商品IDが間違っています';

  @override
  String get storekitSimulatorNote =>
      '注意: シミュレーターの場合、XcodeスキームでStoreKit Configurationファイルが設定されている必要があります。';

  @override
  String get storekitLabelProductId => 'Product ID';

  @override
  String get storekitLabelTitle => 'Title';

  @override
  String get storekitLabelDescription => 'Description';

  @override
  String get storekitLabelPrice => 'Price';

  @override
  String get storekitLabelPriceLocale => 'Price Locale';

  @override
  String get storekitLabelLocalizedPrice => 'Localized Price';

  @override
  String get equationLabel => '式';

  @override
  String get timerTooltipMinus1Min => '1分削減';

  @override
  String get timerTooltipMinus30Sec => '30秒削減';

  @override
  String get timerTooltipPlus30Sec => '30秒追加';

  @override
  String get timerTooltipPlus1Min => '1分追加';

  @override
  String get timerTooltipReset => 'リセット';

  @override
  String get drawingToolPen => 'ペン';

  @override
  String get drawingToolColor => '色';

  @override
  String get drawingToolWidth => '太さ';

  @override
  String get calculatorTooltipShow => '電卓を表示';

  @override
  String get calculatorTooltipClose => '電卓を閉じる';

  @override
  String get congruenceHintExample => '例: x≡ 2,3 (mod 5)';

  @override
  String get freeGachaSelectionInstruction => '履歴管理を行うガチャを2つ選んでください';

  @override
  String freeGachaConfirmDialog(String gacha1, String gacha2) {
    return '$gacha1と$gacha2の学習履歴を管理します。よろしいですか？';
  }

  @override
  String freeGachaEnabledMessage(String gacha1, String gacha2) {
    return '$gacha1と$gacha2の学習履歴が管理できるようになりました。';
  }

  @override
  String get freeGachaEnjoyMessage => 'どうぞ本アプリをお楽しみ下さい 🔢';

  @override
  String freeGachaProNote(String price) {
    return '※ 選択した2つのガチャは無料で\n学習履歴の登録ができます\n※ Pro版($price)を購入すると全ガチャで\n履歴管理が可能になります';
  }

  @override
  String get comingSoon => 'Coming Soon';

  @override
  String storeVersionLabel(String storeVersion) {
    return 'ストアバージョン: $storeVersion';
  }

  @override
  String get auth_googleSignInFailed => 'Google Sign-Inに失敗しました';

  @override
  String get auth_networkErrorCheckConnection =>
      'ネットワークエラーが発生しました。\nインターネット接続を確認してください。';

  @override
  String get auth_appleSignInFailed => 'Apple Sign-Inに失敗しました';

  @override
  String get auth_appleSignInFailedEnsureEnabled =>
      'Apple Sign-Inに失敗しました。\nFirebase ConsoleでApple Sign-Inが有効になっているか確認してください。';

  @override
  String get auth_invalidCredentialTryAgain => '認証情報が無効です。\nもう一度お試しください。';

  @override
  String get auth_invalidIdTokenTryAgain => '認証トークンが無効です。\nもう一度お試しください。';

  @override
  String get auth_appleSignInNotConfigured =>
      'Apple Sign-InがFirebase Consoleで設定されていません。\nFirebase Console > Authentication > Sign-in method で\nAppleを有効にしてください。';

  @override
  String get learningStatus_none => '未学習';

  @override
  String get learningStatus_solved => '解決済み';

  @override
  String get learningStatus_understood => '理解済み';

  @override
  String get learningStatus_failed => '失敗';

  @override
  String get learningStatusTooltip_none => '学習状態を選択';

  @override
  String get learningStatusTooltip_solved => '解けた';

  @override
  String get learningStatusTooltip_understood => '理解できた';

  @override
  String get learningStatusTooltip_failed => 'できなかった';
}
