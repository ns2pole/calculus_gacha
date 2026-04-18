// lib/pages/bonus_gacha_page.dart
import 'dart:math';
import 'package:flutter/material.dart' hide BackButton;
import '../../l10n/app_localizations.dart';
import 'gacha_wrappers.dart';
import '../problem/problem_list_page.dart';
import 'congruence_gacha_page.dart';
import '../../problems/all_problems.dart';
import '../../problems/congruence_equations/congruence_equations.dart';
import '../../models/math_problem.dart';
// Widgets
import '../../widgets/home/background_image_widget.dart';
import '../../widgets/common/back_button.dart';
import '../../widgets/home/home_card_widgets.dart';
// Utils
import '../../utils/progress_display_utils.dart';
import '../../utils/progress_update_mixin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'gacha_settings_page.dart' show GachaFilterMode, GachaFilterModeExt, kGachaDisplayOrder;
import '../../services/problems/simple_data_manager.dart';
import '../../services/auth/firebase_auth_service.dart';
import '../../models/learning_status.dart';
import '../other/auth_page.dart';
import '../../utils/l10n_utils.dart';

class BonusGachaPage extends StatefulWidget {
  const BonusGachaPage({super.key});

  @override
  State<BonusGachaPage> createState() => _BonusGachaPageState();
}

class _BonusGachaPageState extends State<BonusGachaPage> with ProgressUpdateMixin {
  bool _showProgress = false;
  
  // ガチャの無効化フラグ（Coming Soon表示用）
  // 有効化する場合は false に変更するか、このフラグと関連するロジックを削除すること
  static const bool _isModGachaDisabled = false;

  @override
  void initState() {
    super.initState();
    _loadShowProgressSetting();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ページが再表示される時に達成率を更新
    updateProgress();
  }

  Future<void> _loadShowProgressSetting() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _showProgress = prefs.getBool('show_progress_on_home') ?? false;
    });
  }

  /// ガチャページに遷移し、戻ってきた時に達成率を更新する共通メソッド
  Future<void> _navigateToGachaPage(Widget gachaPage) async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => gachaPage));
    updateProgress();
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
    final buttonWidth = min(400.0, screenSize.width * 0.9);
    final l10n = AppLocalizations.of(context)!;

    final List<MathProblem> factorizationPool = allFactorizationProblems;
    final List<MathProblem> indeterminateEquationPool = allIndeterminateEquationProblems;
    final List<MathProblem> sequencePool = allSequenceProblems;
    final List<MathProblem> trigExpLogEquationPool = allTrigExpLogEquationProblems;

    return Scaffold(
      body: Stack(
        children: [
          // 背景画像（薄く、画面サイズに合わせて4枚周期的に表示）
          Positioned.fill(
            child: const BackgroundImageWidget(),
          ),
          // コンテンツ
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              // タイトル（スクロール可能）
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 60.0, // 右上端のアイコンの高さを考慮
                  bottom: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 4),
                    Image.asset(
                      'assets/icon/home_icon_removebg.png',
                      width: 43,
                      height: 43,
                      errorBuilder: (context, error, stackTrace) {
                        // アイコンが見つからない場合のフォールバック
                        return Icon(
                          Icons.apps,
                          size: 43,
                          color: Color(0xFF8B7355),
                        );
                      },
                    ),
                    const SizedBox(width: 14),
                    // タイトルとProバッジを一つのRowとしてセンタリング
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          l10n.bonusGachaTitle,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B7355), // クリーム色っぽい色
                          ),
                        ),
                        // Firebaseログイン中またはPro版の場合はバッジ/雲マークを表示
                        StreamBuilder(
                          stream: FirebaseAuthService.authStateChanges,
                          builder: (context, snapshot) {
                            final isAuthenticated = FirebaseAuthService.isAuthenticated;
                          final isNonJapanese = Localizations.localeOf(context).languageCode != 'ja';
                            // Firebaseログイン中の場合のみ雲マークを表示（Pro Versionバッジは表示しない）
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                // 物理単位ガチャは別アプリへ移行
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    l10n.unitGachaComingSoon,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 16),
                
                // 因数分解ガチャ
                Column(
                  children: [
                    ModernCard(
                      buttonWidth: buttonWidth,
                      icon: Icons.call_split,
                      title: '${l10n.factorizationGachaTitle} ${l10n.integralCount(factorizationPool.length)}',
                      subtitle: l10n.factorizationGachaSubtitle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00BCD4), Color(0xFF00ACC1)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      showBorder: false,
                      onPressed: () => _navigateToGachaPage(const FactorizationGachaPage()),
                    ),
                    if (_showProgress)
                      _buildProgressDisplay(
                        buttonWidth: buttonWidth,
                        prefsPrefix: 'factorization',
                        problemPool: factorizationPool,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00BCD4), Color(0xFF00ACC1)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // 不定方程式ガチャ
                _buildIndefiniteEquationGachaCard(
                  context: context,
                  buttonWidth: buttonWidth,
                  indeterminateEquationPool: indeterminateEquationPool,
                ),
                
                const SizedBox(height: 16),
                
                // modガチャ
                Column(
                  children: [
                    Stack(
                      children: [
                        ModernCard(
                          buttonWidth: buttonWidth,
                          icon: Icons.calculate,
                          title: '${l10n.modGachaTitle} ${l10n.integralCount(congruenceGachaProblems.length)}',
                          subtitle: l10n.modGachaSubtitle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF6B6B), Color(0xFFEE5A6F)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          showBorder: false,
                          onPressed: _isModGachaDisabled
                              ? () {}
                              : () => _navigateToGachaPage(const CongruenceGachaPage()),
                        ),
                        // Coming Soon透かし
                        if (_isModGachaDisabled)
                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  // タップを無効化（何もしない）
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                  child: const Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Coming Soon',
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0x99FFFFFF),
                                            shadows: [
                                              Shadow(
                                                color: Color(0x80000000),
                                                offset: Offset(2, 2),
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    if (_showProgress)
                      _buildProgressDisplay(
                        buttonWidth: buttonWidth,
                        prefsPrefix: 'congruence',
                        problemPool: congruenceGachaProblems.map((cp) => MathProblem(
                          id: cp.id,
                          no: cp.no,
                          category: '合同方程式',
                          level: '初級',
                          question: cp.question,
                          answer: cp.answer.toString(),
                          imageAsset: null,
                          steps: [],
                        )).toList(),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF6B6B), Color(0xFFEE5A6F)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // 漸化式ガチャ
                Column(
                  children: [
                    ModernCard(
                      buttonWidth: buttonWidth,
                      icon: Icons.trending_up,
                      title: '${l10n.sequenceGachaTitle} ${l10n.integralCount(sequencePool.length)}',
                      subtitle: l10n.sequenceGachaSubtitle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF9C27B0), Color(0xFF7B1FA2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      showBorder: false,
                      onPressed: () => _navigateToGachaPage(const SequenceGachaPage()),
                    ),
                    if (_showProgress)
                      _buildProgressDisplay(
                        buttonWidth: buttonWidth,
                        prefsPrefix: 'sequence',
                        problemPool: sequencePool,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF9C27B0), Color(0xFF7B1FA2)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // 三角指数対数ガチャ（一旦非表示）
                // Column(
                //   children: [
                //     ModernCard(
                //       buttonWidth: buttonWidth,
                //       icon: Icons.functions,
                //       title: '三角指数対数ガチャ ${trigExpLogEquationPool.length}問',
                //       subtitle: '超越関数の方程式 〰︎',
                //       gradient: const LinearGradient(
                //         colors: [Color(0xFF4CAF50), Color(0xFF388E3C)],
                //         begin: Alignment.topLeft,
                //         end: Alignment.bottomRight,
                //       ),
                //       onPressed: () {
                //         Navigator.push(context, MaterialPageRoute(builder: (_) => const TrigExpLogEquationGachaPage()));
                //       },
                //     ),
                //     if (_showProgress)
                //       _buildProgressDisplay(
                //         buttonWidth: buttonWidth,
                //         prefsPrefix: 'trig_exp_log_equation',
                //         problemPool: trigExpLogEquationPool,
                //         gradient: const LinearGradient(
                //           colors: [Color(0xFF4CAF50), Color(0xFF388E3C)],
                //           begin: Alignment.topLeft,
                //           end: Alignment.bottomRight,
                //         ),
                //       ),
                //   ],
                // ),
              ],
            ),
            
            const SizedBox(height: 32),
            ],
          ),
        ),
      ),
          // 戻るボタン
          const BackButton(),
          // 右上端のアカウントアイコンと同期ボタン（最前面に配置）
          Positioned(
            top: MediaQuery.of(context).padding.top - 8.0, // 上スペースを詰める
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
                      _SyncButton(),
                      const SizedBox(width: 8),
                      // アカウントアイコン
                      PopupMenuButton<String>(
                        iconSize: 42.0,
                        icon: Icon(
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          if (loginMethod != null)
                            PopupMenuItem(
                              enabled: false,
                              child: Row(
                                children: [
                                  Icon(Icons.login, size: 16, color: Colors.grey),
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
                      icon: Icon(
                        Icons.cloud_outlined,
                        color: const Color(0xFF8B7355),
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

  Widget _buildIndefiniteEquationGachaCard({
    required BuildContext context,
    required double buttonWidth,
    required List<MathProblem> indeterminateEquationPool,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        ModernCard(
          buttonWidth: buttonWidth,
          icon: Icons.calculate,
          title: '${l10n.indetEqGachaTitleOnly} ${l10n.integralCount(indeterminateEquationPool.length)}',
          subtitle: l10n.indetEqGachaSubtitle,
          gradient: const LinearGradient(
            colors: [Color(0xFFFF9800), Color(0xFFFF5722)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          showBorder: false,
          onPressed: () => _navigateToGachaPage(const IndeterminateEquationGachaPage()),
        ),
        if (_showProgress)
          _buildProgressDisplay(
            buttonWidth: buttonWidth,
            prefsPrefix: 'indeterminate_equation',
            problemPool: indeterminateEquationPool,
            gradient: const LinearGradient(
              colors: [Color(0xFFFF9800), Color(0xFFFF5722)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
      ],
    );
  }

  Widget _buildIndefiniteEquationListCard({
    required BuildContext context,
    required double buttonWidth,
    required List<MathProblem> indeterminateEquationPool,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return SimpleCard(
      buttonWidth: buttonWidth,
      icon: Icons.calculate,
      title: '${l10n.indetEqGachaTitleOnly}\n${l10n.genericGachaTitle}',
      subtitle: '',
      color: const Color(0xFFFF9800),
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProblemListPage(
              problemPool: indeterminateEquationPool,
              prefsPrefix: 'indeterminate_equation',
            ),
          ),
        );
        // 戻ってきた時に達成率を更新
        updateProgress();
      },
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
        final colors = gradient.colors as List<Color>;
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (progress.filterCount > 0) ...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        progress.filterDescription,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: mainColor,
                                        ),
                                      ),
                                      ...List.generate(progress.filterCount, (index) => _buildStatusBadge()),
                                      Text(
                                        l10n.aggregatedBy,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: mainColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                ],
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      l10n.achievedCount(progress.achievedCount, progress.totalCount),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: mainColor,
                                      ),
                                    ),
                                    if (progress.totalCount > 0) ...[
                                      const SizedBox(width: 4),
                                      Text(
                                        '(${((progress.achievedCount / progress.totalCount) * 100).toStringAsFixed(1)}%)',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: mainColor.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
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
        final l10n = AppLocalizations.of(context)!;
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

  /// 達成率に応じた星バッジを表示（虹の背景付き）
  /// 達成率に基づいて星数を決定し、すべての星に統一された質感の高いデザインを適用
  /// filterCountに応じて星の領域全体に縦方向の虹の背景を配置
  Widget _buildStarBadgesWithRainbow(double progressRate, int filterCount, double containerHeight) {
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

    Widget starsWidget;
    if (starCount == 5) {
      // 5つの場合は上段2つ、下段3つ
      starsWidget = Column(
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
      // 4つの場合は正方形状（2x2）
      starsWidget = Column(
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
      // 3つの場合は三角形状（上1つ、下2つ）
      starsWidget = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStarBadge(),
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
    } else {
      // 1~2つの場合は横一列
      starsWidget = Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(starCount, (index) {
          return Padding(
            padding: EdgeInsets.only(left: index > 0 ? 2 : 0),
            child: _buildStarBadge(),
          );
        }),
      );
    }

    // filterCountに応じて虹の背景を配置（縦方向、領域全体を覆う）
    if (filterCount > 0 && filterCount <= 3) {
      // containerHeightがInfinityまたは無効な値の場合は、適切なデフォルト値を使用
      final double? effectiveHeight = (containerHeight > 0 && containerHeight.isFinite) 
          ? containerHeight 
          : null;
      
      // effectiveHeightがnullの場合は、IntrinsicHeightでラップして高さを決定
      Widget stackWidget = Stack(
        alignment: Alignment.topLeft, // 左上に配置
        clipBehavior: Clip.none, // 星からはみ出すことを許可
        children: [
          // 虹の背景（filterCountの本数分、縦方向に配置、星側に寄せて表示）
          Positioned(
            left: 0, // 左端に配置
            top: 0, // 枠内いっぱいの高さ
            bottom: 0, // 枠内いっぱいの高さ
            right: null,
            child: filterCount == 3
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start, // 左側に寄せる
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch, // 縦方向を伸ばす
                    children: List.generate(filterCount, (index) {
                      return Opacity(
                        opacity: 0.5, // 薄くする
                        child: Image.asset(
                          'assets/background/rainbow.png',
                          width: 70, // 幅を狭くする
                          fit: BoxFit.fitHeight, // 高さに合わせて縦方向を枠全体に
                        ),
                      );
                    }),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(filterCount, (index) {
                      return Padding(
                        padding: EdgeInsets.only(left: index > 0 ? 4 : 0),
                        child: Opacity(
                          opacity: 0.3, // 薄くする
                          child: Image.asset(
                            'assets/background/rainbow.png',
                            width: 70, // 幅を狭くする
                            fit: BoxFit.fitHeight, // 高さに合わせて縦方向を枠全体に
                          ),
                        ),
                      );
                    }),
                  ),
          ),
          // 星を前面に配置（虹の背景に自然にかかる位置）
          Padding(
            padding: const EdgeInsets.only(left: 2), // 星の位置を少し調整
            child: starsWidget,
          ),
        ],
      );
      
      if (effectiveHeight != null) {
        return SizedBox(
          height: effectiveHeight,
          child: stackWidget,
        );
      } else {
        return IntrinsicHeight(
          child: stackWidget,
        );
      }
    } else {
      // filterCountが0または3より大きい場合は虹なし
      return starsWidget;
    }
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
    
    setState(() {
      _isSyncing = true;
    });

    try {
      // ローカルデータをFirestoreに同期（並列実行で高速化）
      final results = await Future.wait([
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
        final l10n = AppLocalizations.of(context)!;
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
        final l10n = AppLocalizations.of(context)!;
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

