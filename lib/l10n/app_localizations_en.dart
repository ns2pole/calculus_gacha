// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get updateDialogTitle => 'New update available';

  @override
  String get updateDialogMessage => 'Would you like to update?';

  @override
  String get updateDialogLater => 'Later';

  @override
  String get updateDialogUpdate => 'Update';

  @override
  String get updateDialogReleaseNotes => 'Release notes';

  @override
  String get categoryMechanics => 'Mechanics';

  @override
  String get categoryElectromagnetism => 'Electromagnetism';

  @override
  String get categoryThermodynamics => 'Thermodynamics';

  @override
  String get categoryWaves => 'Waves';

  @override
  String problemListTitle(String gachaTypeName) {
    return '$gachaTypeName Problem List';
  }

  @override
  String get unitGachaProblemListTitle => 'Unit Gacha Problem List';

  @override
  String get allProblemsSolved => 'All problems have been solved!';

  @override
  String get appTitle => '[Extreme] Calculus Gacha!';

  @override
  String get showProgressRate => 'Show Achievement Rate';

  @override
  String get integralGacha => 'Integral Gacha!';

  @override
  String get integralGachaTitle => 'Integral Gacha';

  @override
  String get limitGachaTitle => 'Limit Gacha';

  @override
  String get physicsMathGachaTitle => 'Physics Math Gacha';

  @override
  String get physicsMathGachaProblemListTitle => 'Physics Math Problem List';

  @override
  String get factorizationGachaTitle => 'Factorization Gacha';

  @override
  String get indeterminateEqGachaTitle => 'Indeterminate Eq. Gacha';

  @override
  String get sequenceGachaTitle => 'Sequence Gacha';

  @override
  String get genericGachaTitle => 'Math Gacha';

  @override
  String get gachaContentsTitle => 'Gacha Contents';

  @override
  String get content_integral_abs => 'Definite Integrals with Absolute Values';

  @override
  String get content_integral_basic => 'Basic Formulas';

  @override
  String get content_integral_parts => 'Integration by Parts';

  @override
  String get content_integral_substitution => 'Integration by Substitution';

  @override
  String get content_integral_partial_fraction =>
      'Partial Fraction Decomposition';

  @override
  String get content_integral_trig_power => 'Powers of Trigonometric Functions';

  @override
  String get content_integral_exp_log =>
      'Exponential and Logarithmic Functions';

  @override
  String get content_integral_irrational_1 => 'Irrational Functions (Linear)';

  @override
  String get content_integral_irrational_2 =>
      'Irrational Functions (Quadratic)';

  @override
  String get content_integral_beta => 'Beta Function Formulas';

  @override
  String get content_limit_basic => 'Basic Limits';

  @override
  String get content_limit_rationalization => 'Rationalization';

  @override
  String get content_limit_trig => 'Limits of Trigonometric Functions';

  @override
  String get content_limit_exp_log =>
      'Limits of Exponential and Logarithmic Functions';

  @override
  String get content_limit_partial_fraction => 'Partial Fractions and Sums';

  @override
  String get content_limit_squeeze => 'Squeeze Theorem';

  @override
  String get content_limit_riemann => 'Riemann Sums';

  @override
  String get content_limit_famous => 'Famous Limits / Definition of e';

  @override
  String get content_pm_uniform_accel => 'Uniformly Accelerated Motion';

  @override
  String get content_pm_shm_lc => 'Simple Harmonic Motion / LC Circuits';

  @override
  String get content_pm_air_rl => 'Air Resistance / RL Circuits';

  @override
  String get content_pm_rc => 'RC Circuits';

  @override
  String get content_pm_ac => 'AC Circuits';

  @override
  String get content_fact_cross => 'Cross Multiplication';

  @override
  String get content_fact_factor_theorem => 'Factor Theorem';

  @override
  String get content_fact_replacement => 'Substitution Method';

  @override
  String get content_fact_4th_degree => 'Bi-quadratic Expressions';

  @override
  String get content_fact_low_degree => 'Sorting by Lowest Degree';

  @override
  String get content_fact_sort_by_var => 'Sorting by Specific Variable';

  @override
  String get content_fact_5th_degree => '5th Degree or Higher';

  @override
  String get content_indet_basic => 'Linear Indeterminate Equations';

  @override
  String get content_indet_3vars => 'Indeterminate Equations with 3 Variables';

  @override
  String get content_indet_quadratic_hyperbola =>
      'Quadratic Indeterminate Eq (Hyperbolic)';

  @override
  String get content_indet_quadratic_ellipse =>
      'Quadratic Indeterminate Eq (Elliptic)';

  @override
  String get content_indet_high_degree => 'Higher Degree Indeterminate Eq';

  @override
  String get content_seq_2terms => '2-term Recurrence Relations';

  @override
  String get content_seq_3terms => '3-term Recurrence Relations';

  @override
  String get content_seq_simultaneous => 'Simultaneous Recurrence Relations';

  @override
  String get content_seq_fractional => 'Fractional Recurrence Relations';

  @override
  String get content_seq_variable_coeff => 'Variable Coefficient Equations';

  @override
  String get content_seq_root_power => 'Power / Root Type';

  @override
  String integralCount(int count) {
    return '$count problems';
  }

  @override
  String get randomIntegralPractice => 'Random Integral Practice 🎲';

  @override
  String get limitGacha => 'Limit Gacha!';

  @override
  String limitCount(int count) {
    return '$count problems';
  }

  @override
  String get someDontConverge => 'Some problems don\'t converge ⤴️';

  @override
  String get differentialEquationGacha => 'Differential Eq. Gacha';

  @override
  String deCount(int count) {
    return '$count problems';
  }

  @override
  String get physicsDECollection =>
      'Physics Differential\nEquations Collection 🧲';

  @override
  String get bonusGachaHome => 'Bonus Gacha Home';

  @override
  String get bonusGachaDescription =>
      'Factorization, Indeterminate Eq.\nCongruence (mod), Sequences 🎁';

  @override
  String get scratchPaper => 'Scratch Paper';

  @override
  String get learningHistoryFeature => 'Learning History Feature';

  @override
  String get learningHistoryDescription =>
      'You can manage your learning history in this app.';

  @override
  String get greenCheckDescription => 'Green Check = Solved by self';

  @override
  String get yellowCheckDescription => 'Yellow Check = Understood';

  @override
  String get redCheckDescription => 'Red Check = Don\'t understand';

  @override
  String get registrationGuidePart1 =>
      'Register as shown above to use.\nFrom settings,';

  @override
  String get registrationGuidePart2 =>
      'you can exclude problems with these checks.';

  @override
  String get proVersion => 'Pro Version';

  @override
  String proVersionPrice(String price) {
    return 'Pro Version ($price)';
  }

  @override
  String get proVersionDescription =>
      'allows you to manage history for all gachas.';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get loggedOut => 'Logged out';

  @override
  String get syncWithCloud => 'Sync with Cloud';

  @override
  String get syncCompleted => 'Cloud data sync completed';

  @override
  String get noExclusion => 'No Exclusion';

  @override
  String latestNTimes(int n) {
    return 'Latest $n times are ';
  }

  @override
  String get ifSo => 'if so';

  @override
  String get removeFromGacha => 'then remove from Gacha';

  @override
  String aggregateLatestN(int n) {
    return 'Aggregate latest $n times';
  }

  @override
  String aggregateLatestNLong(int n) {
    return 'Aggregate latest $n learning records';
  }

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String privacyPolicyDescription(String link) {
    return 'This app uses Google Firebase for account and data sync, and RevenueCat for purchase management. See $link for details.';
  }

  @override
  String get purchaseTitle => 'Pro Version - Learning History';

  @override
  String priceLabel(String price) {
    return 'Price: $price';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get purchase => 'Purchase';

  @override
  String get purchaseComplete => 'Purchase complete';

  @override
  String purchaseFailed(String error) {
    return 'Purchase failed: $error';
  }

  @override
  String errorOccurred(String error) {
    return 'An error occurred: $error';
  }

  @override
  String get pastPurchasesRestored => 'Past purchases restored👍';

  @override
  String get ok => 'OK';

  @override
  String get details => 'Details';

  @override
  String get aggregatedBy => ' Aggregated by';

  @override
  String achievedCount(Object achieved, Object total) {
    return '$achieved/$total solved';
  }

  @override
  String get rolling => 'Rolling...';

  @override
  String get rollGacha => 'Roll Gacha';

  @override
  String get noProblems => 'No problems available';

  @override
  String problemIndex(int index) {
    return 'Problem $index';
  }

  @override
  String get hideAnswer => 'Hide Answer';

  @override
  String get showAnswer => 'Show Answer';

  @override
  String recordSaved(String status) {
    return 'Learning record saved: $status';
  }

  @override
  String get preparingProblemList => 'Preparing problem list...';

  @override
  String get allDisplayed => 'Show All';

  @override
  String recordSavedAt(String date) {
    return 'Saved: $date';
  }

  @override
  String latestNTimesShort(int n) {
    return 'Latest $n times';
  }

  @override
  String get excludeSuffix => 'excluding';

  @override
  String get restoredPurchases => 'Purchases restored';

  @override
  String get noRestorablePurchases => 'No restorable purchases found';

  @override
  String restoreFailed(String error) {
    return 'Restore failed: $error';
  }

  @override
  String get clearAllSlots => 'Clear all slots';

  @override
  String get hideSolution => 'Hide Solution';

  @override
  String get showSolution => 'Show Solution';

  @override
  String get answerLabel => '【Answer】';

  @override
  String get pointLabel => '【Point】';

  @override
  String get explanationLabel => '【Explanation】';

  @override
  String get hintLabelTitle => '【Hint】';

  @override
  String get bonusGachaTitle => 'Bonus Gacha!';

  @override
  String get unitGachaComingSoon => '*Unit Gacha coming soon!';

  @override
  String get factorizationGachaSubtitle =>
      'Factorize within integer coefficients 0️⃣';

  @override
  String get indetEqGachaTitleOnly => 'Indeterminate Eq. Gacha';

  @override
  String get indetEqGachaSubtitle => 'Find integer solutions 🔢';

  @override
  String get modGachaTitle => 'mod Gacha!';

  @override
  String get modGachaSubtitle => 'Algebraic calculations with remainders ≡';

  @override
  String get sequenceGachaSubtitle =>
      'Deepen understanding by comparing with differential equations Σ';

  @override
  String get keywordSelectorTitle => 'Keyword Selection';

  @override
  String selectedKeywordsLabel(int count, String keywords) {
    return 'Selected ($count): $keywords';
  }

  @override
  String get noKeywordsSelected => 'No keywords selected (Show all problems)';

  @override
  String filteredCountLabel(int filtered, int total) {
    return ' $filtered problems / Total $total';
  }

  @override
  String get noMatchingProblems => 'No matching problems found';

  @override
  String get loading => 'Loading...';

  @override
  String updatedAt(String time) {
    return 'Updated: $time';
  }

  @override
  String get detail => 'Details';

  @override
  String get keyword_numerical => 'Numerical';

  @override
  String get keyword_general => 'General';

  @override
  String get keyword_uam => 'Uniformly Accelerated Motion';

  @override
  String get keyword_air_resistance => 'Air Resistance';

  @override
  String get keyword_shm => 'Simple Harmonic Motion';

  @override
  String get keyword_dc => 'DC';

  @override
  String get keyword_ac => 'AC';

  @override
  String get keyword_voltage0 => 'Voltage 0';

  @override
  String get keyword_capacitor => 'Capacitor';

  @override
  String get keyword_inductor => 'Inductor';

  @override
  String get keyword_resistor => 'Resistor';

  @override
  String get modGachaTitleOnly => 'mod Gacha!';

  @override
  String get problemList => 'Problem List';

  @override
  String get howManyCards => 'How many cards to choose?';

  @override
  String nCards(int count) {
    return '$count cards';
  }

  @override
  String get startingAutomatically => 'Starting automatically...';

  @override
  String get timerFinished => 'Timer finished';

  @override
  String get selectCards => 'Please select cards';

  @override
  String get backToCardSelection => 'Back to card selection';

  @override
  String get hideDetails => 'Hide details';

  @override
  String get showDetails => 'Show details';

  @override
  String get next => 'Next';

  @override
  String get complete => 'Complete';

  @override
  String get allProblemsSolvedSimple => 'All problems solved!';

  @override
  String remainingCards(int count) {
    return '$count cards remaining';
  }

  @override
  String get back => 'Back';

  @override
  String get hideHint => 'Hide hint';

  @override
  String get showHint => 'Show hint';

  @override
  String get closeScratchPaper => 'Close scratch paper';

  @override
  String get openScratchPaper => 'Open scratch paper';

  @override
  String get excludingLabel => 'excluding';

  @override
  String get gachaSettings => 'Gacha Settings';

  @override
  String get filteringSettings => 'Filtering Settings';

  @override
  String get filterModeRandom => 'Full Random (No exclusion)';

  @override
  String get filterModeExcludeSolved => 'Exclude solved problems';

  @override
  String get filterModeOnlyUnsolved => 'Only unsolved problems';

  @override
  String get settingsSaved => 'Settings saved';

  @override
  String difficultyForProblem(int index) {
    return 'Difficulty for problem #$index';
  }

  @override
  String get selectDifficultyForEachSlot => 'Select difficulty for each slot';

  @override
  String get exclusionRuleDescription =>
      '*Exclusion rules are based on the latest 3 learning records.';

  @override
  String get pmGachaKeywordDescription =>
      '*In Physics Math Gacha, problems are categorized by keywords.';

  @override
  String get keywordSelectionInGachaScreen =>
      '*Keyword selection can be done in the gacha screen.';

  @override
  String get easy => 'Easy';

  @override
  String get mid => 'Mid';

  @override
  String get advanced => 'Advanced';

  @override
  String get expert => 'Expert';

  @override
  String latestN(int n) {
    return 'Latest $n times';
  }

  @override
  String get drawWithFinger => 'Draw with finger';

  @override
  String get clearAll => 'Clear All';

  @override
  String get undo => 'Undo';

  @override
  String get redo => 'Redo';

  @override
  String get showExplanation => 'Show Explanation';

  @override
  String get close => 'Close';

  @override
  String get selectColor => 'Select Color';

  @override
  String get storagePermissionRequired => 'Storage permission required';

  @override
  String imageSaved(String path) {
    return 'Image saved: $path';
  }

  @override
  String saveFailed(String error) {
    return 'Save failed: $error';
  }

  @override
  String get learningRecordSaved => 'Learning record saved';

  @override
  String get learningRecordSaveFailed => 'Failed to save learning record';

  @override
  String get defaultPrice => '\$4.99';

  @override
  String get unknownError => 'Unknown Error';

  @override
  String get noFirestorePermission =>
      'No permission to access Firestore. Please check your settings.';

  @override
  String get syncError =>
      'An error occurred during sync. Some data may not have been synchronized.';

  @override
  String get auth_passwordResetEmailSent =>
      'Password reset email sent.\nPlease check your inbox.';

  @override
  String get auth_passwordResetFailed => 'Failed to send password reset email';

  @override
  String get auth_userNotFound => 'No account found for this email address.';

  @override
  String get auth_invalidEmail => 'Invalid email address.';

  @override
  String get auth_tooManyRequests =>
      'Too many requests.\nPlease wait a while and try again.';

  @override
  String auth_emailSignInSuccess(String method) {
    return 'Saved to cloud using $method';
  }

  @override
  String auth_signUpSuccess(String method) {
    return 'Signed up successfully using $method';
  }

  @override
  String get auth_signInFailed => 'Failed to save to cloud';

  @override
  String get auth_signUpFailed => 'Sign up failed';

  @override
  String get auth_lockTitle => 'Login Locked';

  @override
  String get auth_lockMessageResetRequired =>
      'Login attempts exceeded the limit.\nPassword reset is required.\n\nPlease send a password reset email\nfrom \'Forgot password\'.';

  @override
  String auth_lockMessageWait(int minutes) {
    return 'Login attempts exceeded the limit.\nIt will be unlocked automatically in about $minutes minutes.\n\nPlease wait a while and try again.';
  }

  @override
  String get auth_emailAlreadyInUse =>
      'This email address is already in use.\nPlease sign in.';

  @override
  String get auth_weakPassword =>
      'Password is too weak.\nPlease set a stronger password.';

  @override
  String get auth_wrongPassword =>
      'Incorrect email address or password.\nPlease check again.';

  @override
  String get auth_credentialAlreadyInUse =>
      'This account is already registered with a different method.\nPlease use your existing sign-in method.';

  @override
  String get auth_operationNotAllowed => 'This sign-in method is not enabled.';

  @override
  String get auth_smsCodeSent => 'SMS code sent';

  @override
  String get auth_smsVerificationFailed => 'SMS code verification failed';

  @override
  String get auth_invalidVerificationCode =>
      'Incorrect SMS code.\nPlease check again.';

  @override
  String get auth_invalidVerificationId =>
      'Invalid verification ID.\nPlease enter your phone number again.';

  @override
  String get auth_sessionExpired =>
      'Session expired.\nPlease enter your phone number again.';

  @override
  String get auth_phoneAlreadyInUse =>
      'This phone number is already in use.\nPlease use your existing sign-in method.';

  @override
  String get auth_providerAlreadyLinked =>
      'This phone number is already linked to this account.';

  @override
  String get auth_phoneAuthDisabled =>
      'Phone number authentication is not enabled.\nPlease check your settings in Firebase Console.';

  @override
  String auth_phoneVerificationInternalError(String code, String details) {
    return 'An internal error occurred.\nPlease ensure phone number authentication is enabled in Firebase Console.\nError code: $code\nDetails: $details';
  }

  @override
  String get auth_phoneVerificationTooManyRequests =>
      'Too many requests from this device.\nPlease wait and try again later.';

  @override
  String get auth_phoneVerificationQuotaExceeded =>
      'SMS quota exceeded.\nPlease try again later or review your Firebase billing/limits.';

  @override
  String get auth_phoneVerificationCaptchaFailed =>
      'reCAPTCHA verification failed.\nPlease try again.';

  @override
  String get auth_phoneVerificationInvalidAppCredential =>
      'App credential is invalid.\nPlease check your Firebase configuration file.';

  @override
  String auth_phoneVerificationStartFailed(String error) {
    return 'Failed to start phone verification: $error';
  }

  @override
  String auth_unexpectedError(String error) {
    return 'An error occurred: $error';
  }

  @override
  String get auth_firebaseNotConfigured => 'Firebase is not configured';

  @override
  String get auth_firebaseConfigGuide =>
      'Firebase configuration file is required to save to the cloud.\nPlease download and place the configuration file from Firebase Console.';

  @override
  String get auth_phoneSignInButton => 'Save to cloud with Phone Number';

  @override
  String get auth_emailSignInButton => 'Save to cloud with Email Address';

  @override
  String get auth_googleSignInButton => 'Save to cloud with Google';

  @override
  String get auth_appleSignInButton => 'Save to cloud with Apple';

  @override
  String get auth_emailLabel => 'Email Address';

  @override
  String get auth_passwordLabel => 'Password';

  @override
  String get auth_emailRequired => 'Please enter your email address';

  @override
  String get auth_passwordRequired => 'Please enter your password';

  @override
  String get auth_passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get auth_forgotPassword => 'Forgot password';

  @override
  String get auth_alreadyHaveAccount => 'Already have an account? Sign in here';

  @override
  String get auth_createNewAccount => 'New user? Create an account here';

  @override
  String get auth_sendResetEmailButton => 'Send Password Reset Email';

  @override
  String get auth_phoneNumberLabel => 'Phone Number';

  @override
  String get auth_phoneNumberHint => '09012345678 or +819012345678';

  @override
  String get auth_phoneNumberRequired => 'Please enter your phone number';

  @override
  String get auth_invalidPhoneNumber => 'Please enter a valid phone number';

  @override
  String get auth_sendSmsCodeButton => 'Send SMS Code';

  @override
  String get auth_enterSmsCode => 'Please enter SMS code';

  @override
  String auth_smsCodeSentTo(String phoneNumber) {
    return 'Sent to $phoneNumber';
  }

  @override
  String get auth_smsCodeLabel => 'SMS Code';

  @override
  String get auth_smsCodeHint => '6-digit code';

  @override
  String get auth_smsCodeRequired => 'Please enter SMS code';

  @override
  String get auth_smsCodeLength => 'Please enter a 6-digit code';

  @override
  String get auth_resendCodeButton => 'Resend Code';

  @override
  String get auth_changePhoneNumberButton => 'Change Phone Number';

  @override
  String get auth_cloudSyncDescription =>
      'Saving to the cloud stores your learning records online\n and synchronizes them across multiple devices.';

  @override
  String get auth_methodEmail => 'Email Address';

  @override
  String get auth_methodPhone => 'Phone Number';

  @override
  String get auth_methodGoogle => 'Google Account';

  @override
  String get auth_methodApple => 'Apple Account';

  @override
  String get auth_signUpButton => 'Sign Up';

  @override
  String get auth_signInButton => 'Save to Cloud';

  @override
  String get auth_backButton => 'Back';

  @override
  String get auth_verifyButton => 'Verify';

  @override
  String get rerollSlot => 'Reroll this slot';

  @override
  String get saveLearningRecord => 'Save learning record';

  @override
  String usingCloudWith(String method) {
    return 'Using cloud with $method';
  }

  @override
  String problemCountRemaining(int filteredCount, int totalCount) {
    return '($filteredCount/$totalCount rem.)';
  }

  @override
  String noExclusionAllCount(int count) {
    return 'All $count problems';
  }

  @override
  String problemCountOutOf(int filteredCount, int totalCount) {
    return '($filteredCount/$totalCount problems)';
  }

  @override
  String problemCount(int count) {
    return '$count problems';
  }

  @override
  String latestNPrefix(int n) {
    return 'Latest $n';
  }

  @override
  String get category_congruence => 'Congruence (mod) Equations';

  @override
  String get category_indeterminate => 'Indeterminate Equations';

  @override
  String get category_factorization => 'Factorization';

  @override
  String get category_factorization_desc =>
      'From basic to advanced factorization';

  @override
  String get category_recurrence => 'Recurrence Relations';

  @override
  String get category_recurrence_desc =>
      'Solving recurrence relations and applications';

  @override
  String get category_limits => 'Limits';

  @override
  String get category_limits_desc => 'Limit calculations and applications';

  @override
  String get category_integrals => 'Integrals';

  @override
  String get category_integrals_desc =>
      'From basic techniques to advanced applications';

  @override
  String get category_physics_math => 'Physics Math';

  @override
  String get category_differential => 'Differentiation';

  @override
  String get category_differential_desc =>
      'Differentiation calculations and applications';

  @override
  String get category_series => 'Series';

  @override
  String get category_series_desc => 'Convergence and divergence of series';

  @override
  String get category_probability => 'Probability';

  @override
  String get category_probability_desc => 'Probability basics and applications';

  @override
  String get keyword_other => 'Other';

  @override
  String get keyword_resonance => 'Resonance';

  @override
  String get keyword_firstOrderHomogeneous => '1st-order homogeneous';

  @override
  String get keyword_homogeneous => 'Homogeneous';

  @override
  String get keyword_nonHomogeneous => 'Non-homogeneous';

  @override
  String get keyword_university => 'University';

  @override
  String get cloudBackupConfirmTitle => 'Back up your data to the cloud?';

  @override
  String get gachaSuffix => 'Gacha';

  @override
  String get storekitTestTitle => 'StoreKit Configuration Test';

  @override
  String get storekitTestHeader => 'StoreKit Configuration File Test';

  @override
  String get storekitTestDescription =>
      'Tests whether product info can be fetched using native SKProductsRequest.';

  @override
  String get storekitTestButtonIndeterminateOption =>
      'Test Indeterminate Eq. option (160 JPY)';

  @override
  String get storekitTestButtonFactorizationOption =>
      'Test Factorization option (80 JPY)';

  @override
  String get errorTitle => 'Error';

  @override
  String get storekitTestSucceeded => 'Test succeeded';

  @override
  String get storekitHowToReadResults => 'How to read results';

  @override
  String get storekitResultSuccess =>
      '✅ Success: StoreKit Configuration file is correctly set.';

  @override
  String get storekitResultFailure =>
      '❌ Failure: StoreKit Configuration file is missing or product ID is incorrect.';

  @override
  String get storekitSimulatorNote =>
      'Note: On simulator, StoreKit Configuration must be set in the Xcode scheme.';

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
  String get equationLabel => 'Equation';

  @override
  String get timerTooltipMinus1Min => 'Minus 1 min';

  @override
  String get timerTooltipMinus30Sec => 'Minus 30 sec';

  @override
  String get timerTooltipPlus30Sec => 'Plus 30 sec';

  @override
  String get timerTooltipPlus1Min => 'Plus 1 min';

  @override
  String get timerTooltipReset => 'Reset';

  @override
  String get drawingToolPen => 'Pen';

  @override
  String get drawingToolColor => 'Color';

  @override
  String get drawingToolWidth => 'Width';

  @override
  String get calculatorTooltipShow => 'Show calculator';

  @override
  String get calculatorTooltipClose => 'Close calculator';

  @override
  String get congruenceHintExample => 'Example: x≡ 2,3 (mod 5)';

  @override
  String get freeGachaSelectionInstruction =>
      'Select 2 gachas to enable learning history';

  @override
  String freeGachaConfirmDialog(String gacha1, String gacha2) {
    return 'Manage learning history for $gacha1 and $gacha2. Proceed?';
  }

  @override
  String freeGachaEnabledMessage(String gacha1, String gacha2) {
    return 'Learning history is now enabled for $gacha1 and $gacha2.';
  }

  @override
  String get freeGachaEnjoyMessage => 'Enjoy the app.';

  @override
  String freeGachaProNote(String price) {
    return 'The 2 selected gachas can store learning history for free.\nPurchase Pro ($price) to enable learning history for all gachas.';
  }

  @override
  String get comingSoon => 'Coming Soon';

  @override
  String storeVersionLabel(String storeVersion) {
    return 'Store version: $storeVersion';
  }

  @override
  String get auth_googleSignInFailed => 'Google Sign-In failed';

  @override
  String get auth_networkErrorCheckConnection =>
      'Network error. Please check your internet connection.';

  @override
  String get auth_appleSignInFailed => 'Apple Sign-In failed';

  @override
  String get auth_appleSignInFailedEnsureEnabled =>
      'Apple Sign-In failed. Please ensure Apple Sign-In is enabled in Firebase Console.';

  @override
  String get auth_invalidCredentialTryAgain =>
      'Invalid credential. Please try again.';

  @override
  String get auth_invalidIdTokenTryAgain =>
      'Invalid ID token. Please try again.';

  @override
  String get auth_appleSignInNotConfigured =>
      'Apple Sign-In is not configured. Please enable Apple Sign-In in Firebase Console.';

  @override
  String get learningStatus_none => 'Not studied';

  @override
  String get learningStatus_solved => 'Solved';

  @override
  String get learningStatus_understood => 'Understood';

  @override
  String get learningStatus_failed => 'Failed';

  @override
  String get learningStatusTooltip_none => 'Select learning status';

  @override
  String get learningStatusTooltip_solved => 'Solved by myself';

  @override
  String get learningStatusTooltip_understood => 'Understood';

  @override
  String get learningStatusTooltip_failed => 'Could not solve';
}
