// lib/pages/other/free_gacha_selection_page.dart
import 'dart:math';
import 'package:flutter/material.dart';
import '../../services/problems/simple_data_manager.dart';
import '../../widgets/home/background_image_widget.dart';
import '../../widgets/home/home_card_widgets.dart';
import '../../problems/all_problems.dart' show allIntegralProblems, allLimitProblems;
import '../../problems/physics_math/physics_math_gacha.dart' show physicsMathGachaProblems;
import '../../problems/all_problems.dart' show allFactorizationProblems, allIndeterminateEquationProblems, allSequenceProblems;
import '../../problems/congruence_equations/congruence_equations.dart' show congruenceGachaProblems;
import 'cloud_backup_confirmation_page.dart';
import '../../l10n/app_localizations.dart';

/// 無料で履歴管理可能なガチャ選択画面
/// 初回インストール時に2つのガチャを選択
class FreeGachaSelectionPage extends StatefulWidget {
  const FreeGachaSelectionPage({Key? key}) : super(key: key);

  @override
  State<FreeGachaSelectionPage> createState() => _FreeGachaSelectionPageState();
}

class _FreeGachaSelectionPageState extends State<FreeGachaSelectionPage> {
  final Set<String> _selectedGachas = {};
  bool _isShowingDialog = false;

  String _formatProblemCount(int count) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.problemCount(count);
  }

  String _resolveTitle(Map<String, dynamic> gacha) {
    final l10n = AppLocalizations.of(context)!;
    final key = gacha['titleKey'] as String?;
    switch (key) {
      case 'integralGacha':
        return l10n.integralGacha;
      case 'limitGacha':
        return l10n.limitGacha;
      case 'differentialEquationGacha':
        return l10n.differentialEquationGacha;
      case 'factorizationGachaTitle':
        return l10n.factorizationGachaTitle;
      case 'indetEqGachaTitleOnly':
        return l10n.indetEqGachaTitleOnly;
      case 'modGachaTitleOnly':
        return l10n.modGachaTitleOnly;
      case 'sequenceGachaTitle':
        return l10n.sequenceGachaTitle;
      default:
        return (gacha['prefsPrefix'] as String?) ?? '';
    }
  }

  String _resolveSubtitle(Map<String, dynamic> gacha) {
    final l10n = AppLocalizations.of(context)!;
    final key = gacha['subtitleKey'] as String?;
    switch (key) {
      case 'randomIntegralPractice':
        return l10n.randomIntegralPractice;
      case 'someDontConverge':
        return l10n.someDontConverge;
      case 'physicsDECollection':
        return l10n.physicsDECollection;
      case 'factorizationGachaSubtitle':
        return l10n.factorizationGachaSubtitle;
      case 'indetEqGachaSubtitle':
        return l10n.indetEqGachaSubtitle;
      case 'modGachaSubtitle':
        return l10n.modGachaSubtitle;
      case 'sequenceGachaSubtitle':
        return l10n.sequenceGachaSubtitle;
      default:
        return '';
    }
  }
  
  // ガチャの無効化フラグ（Coming Soon表示用）
  static const bool _isModGachaDisabled = false;
  
  // メインガチャの情報（home_page.dartから取得）
  static const List<Map<String, dynamic>> _mainGachas = [
    {
      'prefsPrefix': 'integral',
      'titleKey': 'integralGacha',
      'subtitleKey': 'randomIntegralPractice',
      'icon': Icons.layers,
      'gradient': LinearGradient(
        colors: [Colors.blue, Colors.blueAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    },
    {
      'prefsPrefix': 'limit',
      'titleKey': 'limitGacha',
      'subtitleKey': 'someDontConverge',
      'icon': Icons.arrow_forward,
      'gradient': LinearGradient(
        colors: [Colors.green, Colors.greenAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    },
    {
      'prefsPrefix': 'physics_math',
      'titleKey': 'differentialEquationGacha',
      'subtitleKey': 'physicsDECollection',
      'icon': Icons.science,
      'gradient': LinearGradient(
        colors: [Colors.purple, Colors.purpleAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    },
  ];

  // おまけガチャの情報（bonus_gacha_page.dartから取得）
  static const List<Map<String, dynamic>> _bonusGachas = [
    {
      'prefsPrefix': 'factorization',
      'titleKey': 'factorizationGachaTitle',
      'subtitleKey': 'factorizationGachaSubtitle',
      'icon': Icons.call_split,
      'gradient': LinearGradient(
        colors: [Color(0xFF00BCD4), Color(0xFF00ACC1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    },
    {
      'prefsPrefix': 'indeterminate_equation',
      'titleKey': 'indetEqGachaTitleOnly',
      'subtitleKey': 'indetEqGachaSubtitle',
      'icon': Icons.calculate,
      'gradient': LinearGradient(
        colors: [Color(0xFFFF9800), Color(0xFFFF5722)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    },
    {
      'prefsPrefix': 'congruence',
      'titleKey': 'modGachaTitleOnly',
      'subtitleKey': 'modGachaSubtitle',
      'icon': Icons.calculate,
      'gradient': LinearGradient(
        colors: [Color(0xFFFF6B6B), Color(0xFFEE5A6F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    },
    {
      'prefsPrefix': 'sequence',
      'titleKey': 'sequenceGachaTitle',
      'subtitleKey': 'sequenceGachaSubtitle',
      'icon': Icons.trending_up,
      'gradient': LinearGradient(
        colors: [Color(0xFF9C27B0), Color(0xFF7B1FA2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    },
  ];

  void _onGachaTapped(String prefsPrefix) {
    // 無効化されているガチャは選択できない
    if (prefsPrefix == 'congruence' && _isModGachaDisabled) {
      return;
    }
    
    setState(() {
      if (_selectedGachas.contains(prefsPrefix)) {
        _selectedGachas.remove(prefsPrefix);
      } else {
        if (_selectedGachas.length < 2) {
          _selectedGachas.add(prefsPrefix);
          // 2つ選択されたら確認ダイアログを表示
          if (_selectedGachas.length == 2 && !_isShowingDialog) {
            _isShowingDialog = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showConfirmationDialog();
            });
          }
        } else {
          // 既に2つ選択されている場合は、最初の選択を解除して新しい選択を追加
          final firstSelected = _selectedGachas.first;
          _selectedGachas.remove(firstSelected);
          _selectedGachas.add(prefsPrefix);
          if (!_isShowingDialog) {
            _isShowingDialog = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showConfirmationDialog();
            });
          }
        }
      }
    });
  }
  
  bool _isGachaDisabled(String prefsPrefix) {
    return prefsPrefix == 'congruence' && _isModGachaDisabled;
  }

  Future<void> _showConfirmationDialog() async {
    if (_selectedGachas.length != 2) {
      _isShowingDialog = false;
      return;
    }

    final gachaNames = _selectedGachas.map((prefix) {
      final allGachas = [..._mainGachas, ..._bonusGachas];
      final gacha = allGachas.firstWhere(
        (g) => g['prefsPrefix'] == prefix,
        orElse: () => {'titleKey': null, 'prefsPrefix': prefix},
      );
      return _resolveTitle(gacha);
    }).toList();

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Text(
          AppLocalizations.of(context)!.freeGachaConfirmDialog(gachaNames[0], gachaNames[1]),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: Text(AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );

    _isShowingDialog = false;

    if (result == true) {
      await _onConfirm();
    } else {
      // キャンセルされた場合は選択を解除
      setState(() {
        _selectedGachas.clear();
      });
    }
  }

  Future<void> _onConfirm() async {
    if (_selectedGachas.length != 2) {
      return;
    }
    
    try {
      final success = await SimpleDataManager.saveSelectedFreeGachas(
        _selectedGachas.toList(),
      );
      
      if (success && mounted) {
        // ガチャ名を取得
        final gachaNames = _selectedGachas.map((prefix) {
          final allGachas = [..._mainGachas, ..._bonusGachas];
          final gacha = allGachas.firstWhere(
            (g) => g['prefsPrefix'] == prefix,
            orElse: () => {'titleKey': null, 'prefsPrefix': prefix},
          );
          return _resolveTitle(gacha);
        }).toList();
        final l10n = AppLocalizations.of(context)!;
        
        // 成功メッセージを表示
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.freeGachaEnabledMessage(gachaNames[0], gachaNames[1]),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.freeGachaEnjoyMessage,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // ダイアログを閉じる
                  // クラウドバックアップ確認ページに遷移
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const CloudBackupConfirmationPage(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text(AppLocalizations.of(context)!.ok),
              ),
            ],
          ),
        );
      } else {
        if (mounted) {
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.saveFailed(l10n.unknownError)),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorOccurred(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonWidth = min(400.0, screenSize.width * 0.9);
    final l10n = AppLocalizations.of(context)!;

    return WillPopScope(
      onWillPop: () async => false, // 戻るボタンを無効化
      child: Scaffold(
        body: Stack(
          children: [
            // 背景画像（薄く、画面サイズに合わせて4枚周期的に表示）
            Positioned.fill(
              child: const BackgroundImageWidget(),
            ),
            // コンテンツ
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  // タイトル（スクロール可能）
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 60.0,
                      bottom: 20.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/icon/home_icon_removebg.png',
                          width: 43,
                          height: 43,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.apps,
                              size: 43,
                              color: Color(0xFF8B7355),
                            );
                          },
                        ),
                        const SizedBox(width: 0),
                        Text(
                          l10n.appTitle,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B7355),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  
                  // 説明文
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: Colors.blue.shade700,
                              width: 3.0,
                            ),
                          ),
                          child: Text(
                            l10n.freeGachaSelectionInstruction,
                            style: const TextStyle(
                              fontSize: 28,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '（${_selectedGachas.length}/2）',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),

                  // メインガチャボタン群
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _mainGachas.map((gacha) {
                      final prefsPrefix = gacha['prefsPrefix'] as String;
                      final title = _resolveTitle(gacha);
                      final subtitle = _resolveSubtitle(gacha);
                      final icon = gacha['icon'] as IconData;
                      final gradient = gacha['gradient'] as Gradient;
                      final isSelected = _selectedGachas.contains(prefsPrefix);
                      
                      // 問題数を取得
                      int problemCount = 0;
                      if (prefsPrefix == 'integral') {
                        problemCount = allIntegralProblems.length;
                      } else if (prefsPrefix == 'limit') {
                        problemCount = allLimitProblems.length;
                      } else if (prefsPrefix == 'physics_math') {
                        problemCount = physicsMathGachaProblems.length;
                      }
                      
                      final isDisabled = _isGachaDisabled(prefsPrefix);
                      
                      return Column(
                        children: [
                          Stack(
                            children: [
                              SelectableModernCard(
                                buttonWidth: buttonWidth,
                                icon: icon,
                                title: problemCount > 0 ? '$title ${_formatProblemCount(problemCount)}' : title,
                                subtitle: subtitle,
                                gradient: gradient,
                                isSelected: isSelected && !isDisabled,
                                onPressed: isDisabled ? () {} : () => _onGachaTapped(prefsPrefix),
                              ),
                              // Coming Soon透かし
                              if (isDisabled)
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
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                l10n.comingSoon,
                                                style: TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white.withOpacity(0.6),
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black.withOpacity(0.5),
                                                      offset: const Offset(2, 2),
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
                          const SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  ),
                  
                  // おまけガチャタイトル
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
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
                            return Icon(
                              Icons.apps,
                              size: 43,
                              color: Color(0xFF8B7355),
                            );
                          },
                        ),
                        const SizedBox(width: 14),
                        Text(
                          l10n.bonusGachaTitle,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B7355),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // おまけガチャボタン群
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _bonusGachas.map((gacha) {
                      final prefsPrefix = gacha['prefsPrefix'] as String;
                      final title = _resolveTitle(gacha);
                      final subtitle = _resolveSubtitle(gacha);
                      final icon = gacha['icon'] as IconData;
                      final gradient = gacha['gradient'] as Gradient;
                      final isSelected = _selectedGachas.contains(prefsPrefix);
                      
                      // 問題数を取得
                      int problemCount = 0;
                      if (prefsPrefix == 'factorization') {
                        problemCount = allFactorizationProblems.length;
                      } else if (prefsPrefix == 'indeterminate_equation') {
                        problemCount = allIndeterminateEquationProblems.length;
                      } else if (prefsPrefix == 'sequence') {
                        problemCount = allSequenceProblems.length;
                      } else if (prefsPrefix == 'congruence') {
                        problemCount = congruenceGachaProblems.length;
                      }
                      
                      final isDisabled = _isGachaDisabled(prefsPrefix);
                      
                      return Column(
                        children: [
                          Stack(
                            children: [
                              SelectableModernCard(
                                buttonWidth: buttonWidth,
                                icon: icon,
                                title: problemCount > 0 ? '$title ${_formatProblemCount(problemCount)}' : title,
                                subtitle: subtitle,
                                gradient: gradient,
                                isSelected: isSelected && !isDisabled,
                                onPressed: isDisabled ? () {} : () => _onGachaTapped(prefsPrefix),
                              ),
                              // Coming Soon透かし
                              if (isDisabled)
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
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Coming Soon',
                                                style: TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white.withOpacity(0.6),
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black.withOpacity(0.5),
                                                      offset: const Offset(2, 2),
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
                          const SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // 説明文
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      () {
                        final price = l10n.defaultPrice;
                        return l10n.freeGachaProNote(price);
                      }(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
