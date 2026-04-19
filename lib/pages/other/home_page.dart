// lib/pages/home_page.dart
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../l10n/app_localizations.dart';
import '../../services/auth/firebase_auth_service.dart';
import 'auth_page.dart';
import '../../utils/l10n_utils.dart';

// Pages
import '../gacha/gacha_wrappers.dart'; // IntegralGachaPage / LimitGachaPage
import 'scratch_paper_page.dart';
import '../gacha/bonus_gacha_page.dart';
import '../../screens/physics_math_gacha_screen.dart';
// Widgets
import '../../widgets/home/background_image_widget.dart';
import '../../widgets/home/home_card_widgets.dart';

// models
import '../../models/math_problem.dart';

// Services
import '../../services/problems/simple_data_manager.dart';
// Utils
import '../../utils/progress_display_utils.dart';
import '../../utils/progress_update_mixin.dart';
import '../gacha/gacha_settings_page.dart' show GachaFilterMode, kGachaDisplayOrder;
import '../../models/learning_status.dart';
import '../../utils/responsive_layout.dart';

// 追加：集約リスト（積分／極限／物理数学）
import '../../problems/all_problems.dart' show allIntegralProblems, allLimitProblems;
import '../../problems/physics_math/physics_math_gacha.dart' show physicsMathGachaProblems;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ProgressUpdateMixin {
  bool _showProgress = false;

  @override
  void initState() {
    super.initState();
    _loadShowProgressSetting();
  }

  Future<void> _loadShowProgressSetting() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _showProgress = prefs.getBool('show_progress_on_home') ?? false;
    });
  }

  Future<void> _toggleShowProgress(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('show_progress_on_home', value);
    setState(() {
      _showProgress = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final responsive = context.appResponsive;
    final buttonWidth = min(400.0, responsive.contentMaxWidth * 0.95);

    final List<MathProblem> integralPool = allIntegralProblems;
    final List<MathProblem> limitPool = allLimitProblems;
    final List<MathProblem> physicsMathPool = physicsMathGachaProblems;

    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          // 背景画像（薄く、画面サイズに合わせて4枚周期的に表示）
          Positioned.fill(
            child: const BackgroundImageWidget(),
          ),
          // コンテンツ
          SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ResponsiveContentFrame(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.pageHorizontalPadding,
            vertical: 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            // タイトル（スクロール可能）
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 60.0, // タイトル上のスペースを詰める
                bottom: 20.0,
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  Image.asset(
                    'assets/icon/home_icon_removebg.png',
                    width: responsive.isCompact ? 36 : 43,
                    height: responsive.isCompact ? 36 : 43,
                    errorBuilder: (context, error, stackTrace) {
                      // アイコンが見つからない場合のフォールバック
                      return Icon(
                        Icons.apps,
                        size: responsive.isCompact ? 36 : 43,
                        color: Color(0xFF8B7355),
                      );
                    },
                  ),
                  // タイトルを一つのRowとしてセンタリング
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        l10n.appTitle,
                        style: TextStyle(
                          fontSize: responsive.titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B7355), // クリーム色っぽい色
                        ),
                      ),
                      // Firebaseログイン中の場合は雲マークを表示
                      StreamBuilder(
                        stream: FirebaseAuthService.authStateChanges,
                        builder: (context, snapshot) {
                          final isAuthenticated = FirebaseAuthService.isAuthenticated;
                          final isNonJapanese = Localizations.localeOf(context).languageCode != 'ja';
                          // Firebaseログイン中の場合のみ雲マークを表示
                          if (isAuthenticated) {
                            return Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                // 基準となるサイズを持つ子要素（雲アイコンの位置合わせ用）
                                const SizedBox(width: 20, height: 20),
                                // クラウド利用中の場合は雲のアイコンを表示
                                Positioned(
                                  top: -35,
                                  // 英語のときはタイトル文字に近づきやすいので少し右にずらす
                                  left: isNonJapanese ? 2 : -5,
                                  child: const Icon(
                                    Icons.cloud_outlined,
                                    size: 28,
                                    color: Color(0xFF8B7355),
                                  ),
                                ),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2.0),
            
            // 達成率表示トグルボタン
            _buildProgressToggleButton(),
            
            const SizedBox(height: 20),

            // メインボタン群
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 積分ガチャ
                Column(
                  children: [
                    ModernCard(
                      buttonWidth: buttonWidth,
                      icon: Icons.layers,
                      title: '${l10n.integralGacha} ${l10n.integralCount(integralPool.length)}',
                      subtitle: l10n.randomIntegralPractice,
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.blueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      showBorder: false,
                      onPressed: () async {
                        await Navigator.push(context, MaterialPageRoute(builder: (_) => const IntegralGachaPage()));
                        updateProgress();
                      },
                    ),
                    if (_showProgress)
                      _buildProgressDisplay(
                        buttonWidth: buttonWidth,
                        prefsPrefix: 'integral',
                        problemPool: integralPool,
                        gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.blueAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // 極限ガチャ
                Column(
                  children: [
                    ModernCard(
                      buttonWidth: buttonWidth,
                      icon: Icons.arrow_forward,
                      title: '${l10n.limitGacha} ${l10n.limitCount(limitPool.length)}',
                      subtitle: l10n.someDontConverge,
                      gradient: const LinearGradient(
                        colors: [Colors.green, Colors.greenAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      showBorder: false,
                      onPressed: () async {
                        await Navigator.push(context, MaterialPageRoute(builder: (_) => const LimitGachaPage()));
                        updateProgress();
                      },
                    ),
                    if (_showProgress)
                      _buildProgressDisplay(
                        buttonWidth: buttonWidth,
                        prefsPrefix: 'limit',
                        problemPool: limitPool,
                        gradient: const LinearGradient(
                          colors: [Colors.green, Colors.greenAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // 微分方程式ガチャ
                Column(
                  children: [
                    ModernCard(
                      buttonWidth: buttonWidth,
                      icon: Icons.science,
                      title: '${l10n.differentialEquationGacha} ${l10n.deCount(physicsMathPool.length)}',
                      subtitle: l10n.physicsDECollection,
                      gradient: const LinearGradient(
                        colors: [Colors.purple, Colors.purpleAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      showBorder: false,
                      onPressed: () async {
                        await Navigator.push(context, MaterialPageRoute(builder: (_) => const PhysicsMathGachaScreen()));
                        updateProgress();
                      },
                    ),
                    if (_showProgress)
                      _buildProgressDisplay(
                        buttonWidth: buttonWidth,
                        prefsPrefix: 'physics_math',
                        problemPool: physicsMathPool,
                        gradient: const LinearGradient(
                          colors: [Colors.purple, Colors.purpleAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // おまけガチャ
                ModernCard(
                  buttonWidth: buttonWidth,
                  icon: Icons.card_giftcard,
                  title: l10n.bonusGachaHome,
                  subtitle: l10n.bonusGachaDescription,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onPressed: () async {
                    await Navigator.push(context, MaterialPageRoute(builder: (_) => const BonusGachaPage()));
                    updateProgress();
                  },
                ),
                
                const SizedBox(height: 16),
                
                // 計算用紙
                SimpleCard(
                  buttonWidth: buttonWidth,
                  icon: Icons.edit_note,
                  title: l10n.scratchPaper,
                  subtitle: '',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ScratchPaperPage()));
                  },
                ),
                
              ],
            ),
            
            const SizedBox(height: 32),
            
            // 学習履歴登録機能の説明カード
            _buildHistoryInfoCard(
              buttonWidth: buttonWidth,
            ),
            
            const SizedBox(height: 32),
            
            // ヘルプページへのリンク
            _buildHelpLink(),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
          ),
          // 右上端のアカウントアイコンと同期ボタン（最前面に配置）
          Positioned(
            top: MediaQuery.of(context).padding.top + 8.0, // 少し下に移動（見えなくても問題なし）
            right: 16.0, // 右スペースを開ける
            child: StreamBuilder(
              stream: FirebaseAuthService.authStateChanges,
              builder: (context, snapshot) {
                final isAuthenticated = FirebaseAuthService.isAuthenticated;
                final userEmail = FirebaseAuthService.userEmail;
                final userPhoneNumber = FirebaseAuthService.userPhoneNumber;
                final displayName = FirebaseAuthService.displayName;
                final loginMethod = FirebaseAuthService.loginMethod;
                
                if (isAuthenticated) {
                  // 表示するアカウント情報を決定
                  String? accountInfo;
                  if (userPhoneNumber != null && userPhoneNumber.isNotEmpty) {
                    // 電話番号でログインしている場合
                    accountInfo = userPhoneNumber;
                  } else if (userEmail != null && userEmail.isNotEmpty) {
                    // メールアドレスでログインしている場合（メール、Google、Apple）
                    accountInfo = userEmail;
                  } else if (displayName != null && displayName.isNotEmpty) {
                    // 表示名のみの場合
                    accountInfo = displayName;
                  }
                  
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 同期ボタン
                      const _SyncButton(),
                      const SizedBox(width: 8),
                      // アカウントアイコン
                      PopupMenuButton<String>(
                        iconSize: 42.0,
                        icon: const Icon(
                          Icons.account_circle,
                          color: Color(0xFF8B7355),
                          size: 42.0,
                        ),
                        onSelected: (value) async {
                          if (value == 'logout') {
                            await FirebaseAuthService.signOut();
                            if (mounted) {
                              // 成功メッセージを表示
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.loggedOut),
                                  backgroundColor: Colors.green,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                              setState(() {});
                            }
                          }
                        },
                        itemBuilder: (context) => [
                          if (accountInfo != null)
                            PopupMenuItem(
                              enabled: false,
                              child: Text(
                                accountInfo,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          if (loginMethod != null)
                            PopupMenuItem(
                              enabled: false,
                              child: Row(
                                children: [
                                  const Icon(Icons.login, size: 16, color: Colors.grey),
                                  const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    l10n.usingCloudWith(getLocalizedLoginMethod(context, loginMethod)),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          PopupMenuItem(
                            value: 'logout',
                            child: Row(
                              children: [
                                const Icon(Icons.logout, size: 20),
                                const SizedBox(width: 8),
                                Text(l10n.logout),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Material(
                    color: Colors.transparent,
                    child: IconButton(
                      iconSize: 42.0,
                      icon: const Icon(
                        Icons.cloud_outlined,
                        color: Color(0xFF8B7355),
                        size: 42.0,
                      ),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AuthPage()),
                        );
                        if (result == true && mounted) {
                          setState(() {});
                        }
                      },
                      tooltip: l10n.login,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryInfoCard({
    required double buttonWidth,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.history,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  l10n.learningHistoryFeature,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              l10n.learningHistoryDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            _buildCheckItem(
              icon: Icons.check_circle,
              iconColor: Colors.green,
              text: l10n.greenCheckDescription,
            ),
            const SizedBox(height: 8),
            _buildCheckItem(
              icon: Icons.lightbulb,
              iconColor: Colors.orange,
              text: l10n.yellowCheckDescription,
            ),
            const SizedBox(height: 8),
            _buildCheckItem(
              icon: Icons.cancel,
              iconColor: Colors.red,
              text: l10n.redCheckDescription,
            ),
            const SizedBox(height: 12),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: l10n.registrationGuidePart1,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: l10n.registrationGuidePart2,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckItem({
    required IconData icon,
    required Color iconColor,
    required String text,
  }) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressToggleButton() {
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () {
        _toggleShowProgress(!_showProgress);
      },
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _showProgress ? Icons.check_circle : Icons.circle_outlined,
              color: Colors.teal,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              l10n.showProgressRate,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressDisplay({
    required double buttonWidth,
    required String prefsPrefix,
    required List<MathProblem> problemPool,
    required Gradient gradient,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return FutureBuilder<ProgressInfo>(
      key: buildProgressKey(prefsPrefix: prefsPrefix, showProgress: _showProgress),
      future: getGachaProgress(
        context: context,
        prefsPrefix: prefsPrefix,
        problemPool: problemPool,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final progress = snapshot.data!;
        final colors = gradient.colors;
        final mainColor = colors.isNotEmpty ? colors[0] : Colors.blue;

        final GlobalKey containerKey = GlobalKey();
        return InkWell(
          onTap: () {
            final RenderBox? renderBox = containerKey.currentContext?.findRenderObject() as RenderBox?;
            if (renderBox != null) {
              final position = renderBox.localToGlobal(Offset.zero);
              final size = renderBox.size;
              _showFilterMenu(context, prefsPrefix, position: position, size: size);
            } else {
              _showFilterMenu(context, prefsPrefix);
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            key: containerKey,
            width: buttonWidth,
            margin: const EdgeInsets.only(top: 3),
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  mainColor.withOpacity(0.1),
                  mainColor.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: mainColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: LayoutBuilder(
            builder: (context, constraints) {
              final responsive = context.appResponsive;
              // 星の数を計算（星が二段になるかどうかを判定）
              final progressRate = progress.totalCount > 0 
                  ? progress.achievedCount / progress.totalCount 
                  : 0.0;
              int starCount = 0;
              if (progressRate > 0.2) {
                if (progressRate < 0.4) {
                  starCount = 1;
                } else if (progressRate < 0.6) {
                  starCount = 2;
                } else if (progressRate < 0.8) {
                  starCount = 3;
                } else if (progressRate < 1.0) {
                  starCount = 4;
                } else {
                  starCount = 5;
                }
              }
              // 星が二段になるかどうか（3つ以上）
              final isTwoRows = starCount >= 3;
              
              return IntrinsicHeight(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // 虹をContainerの左端に配置（達成率が0%の時は表示しない）
                    if (progress.filterCount > 0 && progress.filterCount <= 3 && progressRate > 0)
                      Positioned(
                        left: 20,
                        top: 0,
                        bottom: isTwoRows ? 0 : null, // 二段の場合はコンテナの高さいっぱい
                        child: Opacity(
                          opacity: 0.5,
                          child: Image.asset(
                            'assets/background/rainbow${progress.filterCount}.png',
                            width: 70,
                            height: isTwoRows ? null : 50, // 二段の場合は高さを指定せず、bottom: 0で引き伸ばす
                            fit: isTwoRows ? BoxFit.contain : BoxFit.contain, // 全体が表示されるようにcontainを使用
                          ),
                        ),
                      ),
                    // 星と文字は中央寄せ
                    Center(
                      child: IntrinsicHeight(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runSpacing: 6,
                          spacing: 8,
                          children: [
                            if (progress.totalCount > 0) ...[
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: _buildStarBadges(
                                  progress.achievedCount / progress.totalCount,
                                  progress.filterCount,
                                ),
                              ),
                            ],
                            // 右側に2行のテキストを配置
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: max(180, constraints.maxWidth - 110),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (progress.filterCount > 0) ...[
                                    Wrap(
                                      alignment: WrapAlignment.center,
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      spacing: 2,
                                      runSpacing: 2,
                                      children: [
                                        Text(
                                          progress.filterDescription,
                                          style: TextStyle(
                                            fontSize: responsive.isCompact ? 14 : 16,
                                            fontWeight: FontWeight.bold,
                                            color: mainColor,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        ...List.generate(progress.filterCount, (index) => _buildStatusBadge()),
                                        Text(
                                          l10n.aggregatedBy,
                                          style: TextStyle(
                                            fontSize: responsive.isCompact ? 14 : 16,
                                            fontWeight: FontWeight.bold,
                                            color: mainColor,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    spacing: 4,
                                    runSpacing: 2,
                                    children: [
                                      Text(
                                        l10n.achievedCount(progress.achievedCount, progress.totalCount),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: responsive.isCompact ? 14 : 16,
                                          fontWeight: FontWeight.bold,
                                          color: mainColor,
                                        ),
                                      ),
                                      if (progress.totalCount > 0)
                                        Text(
                                          '(${((progress.achievedCount / progress.totalCount) * 100).toStringAsFixed(1)}%)',
                                          style: TextStyle(
                                            fontSize: responsive.isCompact ? 14 : 16,
                                            fontWeight: FontWeight.bold,
                                            color: mainColor.withOpacity(0.7),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          ),
        );
      },
    );
  }

  /// フィルタリング設定メニューを表示
  Future<void> _showFilterMenu(BuildContext context, String prefsPrefix, {Offset? position, Size? size}) async {
    final l10n = AppLocalizations.of(context)!;
    // 現在のフィルタリング設定を読み込む
    final settings = await SimpleDataManager.getGachaSettings(prefsPrefix);
    final filterModeStr = settings['filterMode'] as String?;
    
    GachaFilterMode currentMode;
    if (filterModeStr != null) {
      switch (filterModeStr) {
        case 'exclude_solved_ge1':
          currentMode = GachaFilterMode.excludeSolvedGE1;
          break;
        case 'exclude_solved_ge2':
          currentMode = GachaFilterMode.excludeSolvedGE2;
          break;
        case 'exclude_solved_ge3':
          currentMode = GachaFilterMode.excludeSolvedGE3;
          break;
        case 'random':
        default:
          currentMode = GachaFilterMode.random;
          break;
      }
    } else {
      currentMode = GachaFilterMode.random;
    }

    final RenderBox? overlay = Overlay.of(context).context.findRenderObject() as RenderBox?;
    
    Offset? menuPosition;
    if (position != null && size != null && overlay != null) {
      menuPosition = Offset(position.dx, position.dy + size.height);
    }
    
    final GachaFilterMode? selected = await showMenu<GachaFilterMode>(
      context: context,
      position: (menuPosition != null && size != null && overlay != null)
          ? RelativeRect.fromLTRB(
              menuPosition.dx,
              menuPosition.dy,
              overlay.size.width - menuPosition.dx - size.width,
              overlay.size.height - menuPosition.dy,
            )
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      items: kGachaDisplayOrder.map((mode) {
        Widget title;
        if (mode == GachaFilterMode.random) {
          title = Text(l10n.noExclusion, style: TextStyle(fontSize: 14, color: Colors.grey[900]));
        } else {
          int n;
          switch (mode) {
            case GachaFilterMode.excludeSolvedGE1:
              n = 1;
              break;
            case GachaFilterMode.excludeSolvedGE2:
              n = 2;
              break;
            case GachaFilterMode.excludeSolvedGE3:
            default:
              n = 3;
              break;
          }
          title = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.latestNTimes(n), style: TextStyle(fontSize: 14, color: Colors.grey[900])),
                  _buildStatusBadgeForMenu(LearningStatus.solved, diameter: 16.0),
                  Text(l10n.ifSo, style: TextStyle(fontSize: 14, color: Colors.grey[900])),
                ],
              ),
              Text(
                l10n.removeFromGacha,
                style: TextStyle(fontSize: 14, color: Colors.grey[900]),
              ),
            ],
          );
        }
        
        return PopupMenuItem<GachaFilterMode>(
          value: mode,
          child: Row(
            children: [
              if (currentMode == mode)
                const Icon(Icons.check, size: 20, color: Colors.blue)
              else
                const SizedBox(width: 20),
              const SizedBox(width: 8),
              Expanded(child: title),
            ],
          ),
        );
      }).toList(),
    );
    
    if (selected != null && selected != currentMode) {
      // 設定を保存
      String newFilterModeStr;
      switch (selected) {
        case GachaFilterMode.random:
          newFilterModeStr = 'random';
          break;
        case GachaFilterMode.excludeSolvedGE1:
          newFilterModeStr = 'exclude_solved_ge1';
          break;
        case GachaFilterMode.excludeSolvedGE2:
          newFilterModeStr = 'exclude_solved_ge2';
          break;
        case GachaFilterMode.excludeSolvedGE3:
          newFilterModeStr = 'exclude_solved_ge3';
          break;
        default:
          newFilterModeStr = 'random';
      }
      settings['filterMode'] = newFilterModeStr;
      await SimpleDataManager.saveGachaSettings(prefsPrefix, settings);
      
      // 達成率を更新
      if (mounted) {
        updateProgress();
      }
    }
  }

  /// メニュー用のステータスバッジを生成
  Widget _buildStatusBadgeForMenu(LearningStatus status, {double diameter = 16.0}) {
    final double iconSize = diameter * 0.6;
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        color: status.color,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(status.icon, size: iconSize, color: Colors.white),
    );
  }

  Widget _buildStatusBadge({double diameter = 16.0}) {
    final double iconSize = diameter * 0.6;
    return Container(
      width: diameter,
      height: diameter,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: const BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(Icons.check_circle, size: iconSize, color: Colors.white),
    );
  }

  /// 達成率に応じた星バッジを表示
  /// 達成率に基づいて星数を決定し、すべての星に統一された質感の高いデザインを適用
  Widget _buildStarBadges(double progressRate, int filterCount) {
    if (progressRate <= 0.2) {
      return const SizedBox.shrink();
    }

    // 達成率に基づいて星数を決定
    int starCount;
    if (progressRate < 0.4) {
      starCount = 1;
    } else if (progressRate < 0.6) {
      starCount = 2;
    } else if (progressRate < 0.8) {
      starCount = 3;
    } else if (progressRate < 1.0) {
      starCount = 4;
    } else {
      starCount = 5;
    }

    if (starCount == 5) {
      // 5つの場合は上段2つ、下段3つ
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStarBadge(),
              const SizedBox(width: 2),
              _buildStarBadge(),
            ],
          ),
          const SizedBox(height: 0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStarBadge(),
              const SizedBox(width: 2),
              _buildStarBadge(),
              const SizedBox(width: 2),
              _buildStarBadge(),
            ],
          ),
        ],
      );
    } else if (starCount == 4) {
      // 4つの場合は上段2つ、下段2つ
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStarBadge(),
              const SizedBox(width: 2),
              _buildStarBadge(),
            ],
          ),
          const SizedBox(height: 0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStarBadge(),
              const SizedBox(width: 2),
              _buildStarBadge(),
            ],
          ),
        ],
      );
    } else if (starCount == 3) {
      // 3つの場合は上段2つ、下段1つ
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStarBadge(),
              const SizedBox(width: 2),
              _buildStarBadge(),
            ],
          ),
          const SizedBox(height: 0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStarBadge(),
            ],
          ),
        ],
      );
    } else {
      // 1~2つの場合は横一列
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(starCount, (index) {
          return Padding(
            padding: EdgeInsets.only(left: index > 0 ? 2 : 0),
            child: _buildStarBadge(),
          );
        }),
      );
    }
  }

  /// 統一された質感の高い星バッジを1つ作成
  /// 最新3回分の集計のデザイン（濃い金色、強い輝き、美しい）をすべての星に適用
  Widget _buildStarBadge() {
    return Text(
      '⭐️',
      style: TextStyle(
        fontSize: 24,
      ),
    );
  }

  /// ヘルプページへのリンクを表示
  Widget _buildHelpLink() {
    final l10n = AppLocalizations.of(context)!;
    
    const privacyPolicyUrl = 'https://www.notion.so/calculus-gacha-joy-math-27ae4f0afd3b80cb9754ce138cbc80ca?source=copy_link';
    
    Future<void> launchPrivacyPolicy() async {
      final uri = Uri.parse(privacyPolicyUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }
    }
    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: l10n.privacyPolicyDescription('').split(l10n.privacyPolicy)[0],
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
              ),
            ),
            WidgetSpan(
              child: InkWell(
                onTap: launchPrivacyPolicy,
                child: Text(
                  l10n.privacyPolicy,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                  ),
                ),
              ),
            ),
            TextSpan(
              text: l10n.privacyPolicyDescription('').split(l10n.privacyPolicy).length > 1 
                  ? l10n.privacyPolicyDescription('').split(l10n.privacyPolicy)[1]
                  : '',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// Firebaseクラウドデータとの同期ボタン
class _SyncButton extends StatefulWidget {
  const _SyncButton();

  @override
  State<_SyncButton> createState() => _SyncButtonState();
}

class _SyncButtonState extends State<_SyncButton> {
  bool _isSyncing = false;

  Future<void> _performSync() async {
    if (_isSyncing) return;
    final l10n = AppLocalizations.of(context)!;
    
    setState(() {
      _isSyncing = true;
    });

    try {
      // ローカルデータをFirestoreに同期（並列実行で高速化）
      await Future.wait([
        SimpleDataManager.syncLocalDataToFirestore(),
        SimpleDataManager.syncLocalSettingsToFirestore(),
      ], eagerError: false);
      
      // Firestoreからデータを取得してマージ（エラーが発生しても続行）
      try {
        await SimpleDataManager.initialize();
      } catch (e) {
        print('Warning: Error initializing from Firestore: $e');
        // 初期化エラーは無視（ローカルデータは既に同期済み）
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.syncCompleted),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error syncing: $e');
      if (mounted) {
        final errorStr = e.toString().toLowerCase();
        final message = errorStr.contains('permission')
            ? l10n.noFirestorePermission
            : l10n.syncError;
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSyncing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Material(
      color: Colors.transparent,
      child: IconButton(
        iconSize: 42.0,
        icon: _isSyncing
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8B7355)),
                ),
              )
            : const Icon(
                Icons.cloud_sync,
                color: Color(0xFF8B7355),
                size: 42.0,
              ),
        onPressed: _isSyncing ? null : _performSync,
        tooltip: l10n.syncWithCloud,
      ),
    );
  }
}

