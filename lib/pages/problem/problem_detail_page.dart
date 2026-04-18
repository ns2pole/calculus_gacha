import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../l10n/app_localizations.dart';
import '../../models/math_problem.dart';
import '../../utils/l10n_utils.dart';
import '../../widgets/gacha/physics_math_case_display.dart';
import '../../widgets/home/background_image_widget.dart';
import '../../widgets/common/back_button.dart' as custom;
import '../common/common.dart' show MixedTextMath;
import '../common/problem_status.dart';
import '../../services/problems/simple_data_manager.dart';
import '../../services/problems/exclusion_logic.dart' show sortHistoryByTimeNewestFirst;

/// ProblemDetailPage
class ProblemDetailPage extends StatefulWidget {
  final MathProblem problem;
  final int? displayNo; // 一覧で表示されている番号
  final List<Map<String, dynamic>> initialHistory;
  final void Function(int idx, ProblemStatus status) onAddSlot;
  final VoidCallback onClear;
  final String prefsPrefix;

  const ProblemDetailPage({
    super.key,
    required this.problem,
    this.displayNo,
    required this.initialHistory,
    required this.onAddSlot,
    required this.onClear,
    this.prefsPrefix = 'integral',
  });

  @override
  State<ProblemDetailPage> createState() => _ProblemDetailPageState();
}

class _ProblemDetailPageState extends State<ProblemDetailPage> {
  List<Map<String, dynamic>> _slots = []; // {status: ProblemStatus, time: DateTime?}
  bool _showAnswer = false;
  bool _isLoading = true;
  
  // アセット存在確認のキャッシュ（スロット更新時のちらつきを防ぐため）
  bool? _mainImageExists;
  final Map<String, bool> _stepImageExistsCache = {};

  @override
  void initState() {
    super.initState();
    _loadHistory();
    // アセット存在確認を事前に実行してキャッシュ
    _preloadAssetExistence();
  }

  Future<void> _loadHistory() async {
    // 全履歴を取得
    final history = await SimpleDataManager.getLearningHistory(widget.problem);
    
    // 時刻でソート（最新が先頭）
    final sortedHistory = sortHistoryByTimeNewestFirst(history);
    
    // スロットを作成（最新が右端に来るように逆順にする）
    // 各スロットに元の履歴インデックスを保存
    _slots = sortedHistory.asMap().entries.map((entry) {
      final originalIndex = entry.key;
      final h = entry.value;
      final st = h['status'] is String 
          ? ProblemStatus.values.firstWhere(
              (s) => s.name == h['status'],
              orElse: () => ProblemStatus.none,
            )
          : ProblemStatus.none;
      DateTime? dt;
      if (h['time'] is String) {
        try {
          dt = DateTime.parse(h['time'] as String);
        } catch (_) {
          dt = null;
        }
      }
      return {
        'status': st, 
        'time': dt,
        '_originalIndex': originalIndex, // 元の履歴インデックスを保存
      };
    }).toList().reversed.toList(); // 逆順にして最新が右端に
    
    setState(() {
      _isLoading = false;
    });
  }
  
  Future<void> _preloadAssetExistence() async {
    final p = widget.problem;
    // メイン画像の存在確認
    if (p.imageAsset != null) {
      _mainImageExists = await _assetExists(p.imageAsset!);
    }
    // ステップ画像の存在確認
    // Use localized steps so the preloaded image set matches what the UI will render.
    for (final step in p.getLocalizedSteps(context)) {
      if (step.imageAsset != null && !_stepImageExistsCache.containsKey(step.imageAsset)) {
        _stepImageExistsCache[step.imageAsset!] = await _assetExists(step.imageAsset!);
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<bool> _assetExists(String asset) async {
    try {
      await rootBundle.load(asset);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _toggleSlot(int idx) async {
    if (_isLoading) return;
    
    if (idx >= _slots.length) return;
    
    final cur = _slots[idx]['status'] as ProblemStatus? ?? ProblemStatus.none;
    final next = cur == ProblemStatus.none
        ? ProblemStatus.solved
        : (cur == ProblemStatus.solved
            ? ProblemStatus.understood
            : (cur == ProblemStatus.understood ? ProblemStatus.failed : ProblemStatus.none));

    // 全履歴を取得してソート
    final history = await SimpleDataManager.getLearningHistory(widget.problem);
    final sortedHistory = sortHistoryByTimeNewestFirst(history);
    
    // 元の履歴インデックスを取得
    final originalIndex = _slots[idx]['_originalIndex'] as int?;
    
    if (originalIndex != null && originalIndex < sortedHistory.length) {
      // 既存の履歴を更新
      sortedHistory[originalIndex] = {
        'status': next.name,
        'time': next == ProblemStatus.none ? null : DateTime.now().toIso8601String(),
      };
    } else {
      // 新しい履歴を追加
      sortedHistory.add({
        'status': next.name,
        'time': next == ProblemStatus.none ? null : DateTime.now().toIso8601String(),
      });
    }
    
    // 保存
    await SimpleDataManager.saveLearningHistory(widget.problem, sortedHistory);
    
    // 再読み込み
    await _loadHistory();
    
    // コールバック呼び出し（一覧画面の更新用）
    widget.onAddSlot(idx, next);
  }

  Future<void> _clearAll() async {
    if (_isLoading) return;
    
    // 全履歴をnoneにする
    final history = await SimpleDataManager.getLearningHistory(widget.problem);
    final clearedHistory = history.map((h) => {
      'status': 'none',
      'time': null,
    }).toList();
    
    await SimpleDataManager.saveLearningHistory(widget.problem, clearedHistory);
    
    // 再読み込み
    await _loadHistory();
    
    widget.onClear();
  }

  String _formatDt(DateTime dt) =>
      '${dt.year}/${dt.month.toString().padLeft(2, '0')}/${dt.day.toString().padLeft(2, '0')} '
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

  Color _colorOf(ProblemStatus st) {
    switch (st) {
      case ProblemStatus.solved:
        return Colors.green;
      case ProblemStatus.understood:
        return Colors.orange;
      case ProblemStatus.failed:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _iconOf(ProblemStatus st) {
    switch (st) {
      case ProblemStatus.solved:
        return Icons.check_circle;
      case ProblemStatus.understood:
        return Icons.lightbulb;
      case ProblemStatus.failed:
        return Icons.close;
      default:
        return Icons.radio_button_unchecked;
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.problem;
    final l10n = AppLocalizations.of(context)!;
    final langCode = Localizations.localeOf(context).languageCode;
    final isCjk = const {'ja', 'zh', 'ko'}.contains(langCode);
    final isEn = langCode == 'en';

    // English explanation text tends to look smaller (especially when rendered via \text{...}),
    // so bump the base sizes a bit only for English.
    final explanationLabelFontSize = isCjk ? 15.0 : (isEn ? 18.0 : 16.0);
    final explanationMathFontSize = isCjk ? 20.0 : (isEn ? 26.0 : 22.0);
    final pointLabelFontSize = isEn ? 18.0 : 16.0;
    final pointMathFontSize = isEn ? 22.0 : 18.0;
    return Scaffold(
      body: Stack(
        children: [
          // 背景画像（薄く、画面サイズに合わせて4枚周期的に表示）
          Positioned.fill(
            child: const BackgroundImageWidget(opacity: 0.15),
          ),
          // コンテンツ
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 90, left: 12, right: 12, bottom: 12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // 問題番号を表示（一覧の番号に合わせる）
              Text(
                'No. ${widget.displayNo ?? p.no ?? 'N/A'}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              // equationとconditionsがある場合はPhysicsMathCaseDisplayを使用
              if (p.equation != null && p.conditions != null)
                PhysicsMathCaseDisplay(
                  equation: p.getLocalizedEquation(context) ?? p.equation!,
                  conditions: p.getLocalizedConditions(context)!,
                  constants: p.getLocalizedConstants(context),
                  fontSize: widget.prefsPrefix == 'sequence' ? 24 : 20,
                )
              else
                MixedTextMath(p.getLocalizedQuestion(context), labelStyle: const TextStyle(fontSize: 16), mathStyle: const TextStyle(fontSize: 20)),
              const SizedBox(height: 12),
              Align(alignment: Alignment.centerRight, child: TextButton(onPressed: _clearAll, child: Text(l10n.clearAllSlots))),
              const SizedBox(height: 6),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i = 0; i < _slots.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Builder(
                            builder: (context) {
                              final currentStatus = _slots[i]['status'] as ProblemStatus?;
                              final selected = currentStatus != null && currentStatus != ProblemStatus.none;
                              final status = currentStatus ?? ProblemStatus.none;
                              final color = _colorOf(status);
                              final borderColor = selected ? Colors.transparent : Colors.grey.shade300;
                              final bgColor = selected ? color : null;
                              final iconColor = selected ? Colors.white : Colors.grey;
                              
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: bgColor,
                                      minimumSize: const Size(56, 36),
                                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(color: borderColor, width: 1),
                                      ),
                                      elevation: 0,
                                    ),
                                    onPressed: () => _toggleSlot(i),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(_iconOf(status), color: iconColor, size: 18),
                                        const SizedBox(height: 2),
                                        Text('Slot ${i + 1}', style: TextStyle(fontSize: 12, color: iconColor)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  if (_slots[i]['time'] != null)
                                    Text(
                                      _formatDt(_slots[i]['time'] as DateTime),
                                      style: const TextStyle(fontSize: 11, color: Colors.black54),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: () => setState(() => _showAnswer = !_showAnswer), child: Text(_showAnswer ? l10n.hideSolution : l10n.showSolution)),
              const SizedBox(height: 33),

              // --- 解答・解説表示部分 ---
              if (_showAnswer)
                RepaintBoundary(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (p.imageAsset != null && _mainImageExists == true) ...[
                        Builder(
                          builder: (ctx) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              try {
                                precacheImage(AssetImage(p.imageAsset!), ctx);
                              } catch (_) {}
                            });
                            // 全画像を不定方程式と同じサイズ感（1.65倍）で統一し、センタリング
                            final maxHeight = 220 * 1.65;
                            return Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: maxHeight),
                                child: Image.asset(
                                  p.imageAsset!,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 18),
                      ],
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.answerLabel,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MixedTextMath(
                          p.getLocalizedAnswer(context),
                          labelStyle: const TextStyle(fontSize: 19),
                          mathStyle: const TextStyle(fontSize: 28, color: Colors.green),
                          forceTex: false,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // shortExplanation表示
                      if (p.shortExplanation != null) ...[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue[200]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.pointLabel,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[800],
                                ),
                              ),
                              const SizedBox(height: 8),
                              MixedTextMath(
                                p.getLocalizedShortExplanation(context)!,
                                forceTex: true,
                                labelStyle: TextStyle(fontSize: pointLabelFontSize, color: Colors.black),
                                mathStyle: TextStyle(
                                  fontSize: pointMathFontSize,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // detailedExplanation表示（翻訳があればそれを優先）
                      ...() {
                        final localizedDetailed = p.getLocalizedDetailedExplanation(context);
                        if (localizedDetailed == null || localizedDetailed.isEmpty) {
                          return const <Widget>[];
                        }

                        return <Widget>[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.purple[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.purple[200]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.explanationLabel,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple[800],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ...localizedDetailed.map((step) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                                    child: MixedTextMath(
                                      step.tex,
                                      forceTex: true,
                                      labelStyle: TextStyle(fontSize: explanationLabelFontSize, color: Colors.black),
                                      mathStyle: TextStyle(
                                        fontSize: explanationMathFontSize,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ];
                      }(),

                      // stepsは表示しない（答え・ポイント・解説のみ表示）
                      // detailedExplanationがない場合のみstepsを表示（他の問題タイプとの互換性のため）
                      if (p.detailedExplanation == null || p.detailedExplanation!.isEmpty) ...() {
                        bool isAnySectionHeader(String t) {
                          const ja = ['【ポイント】', '【解説】', '【計算】', '【方針】', '【補足】'];
                          const en = ['[Key Points]', '[Explanation]', '[Calculation]', '[Strategy]', '[Supplement]'];
                          return ja.any(t.contains) || en.any(t.contains);
                        }

                        bool isExplanationHeader(String t) => t.contains('【解説】') || t.contains('[Explanation]');

                        final localizedSteps = p.getLocalizedSteps(context);
                        bool inExplanation = false;

                        return localizedSteps.map((s) {
                          final localizedTex = s.getLocalizedTex(context);
                          final trimmed = localizedTex.trim();

                          final isExplHeader = isExplanationHeader(localizedTex);
                          if (isExplHeader) {
                            inExplanation = true;
                          } else if (isAnySectionHeader(localizedTex)) {
                            // Switching to another section ends the explanation section.
                            inExplanation = false;
                          }

                          // For English, make the whole explanation body a bit larger for readability.
                          // For CJK, keep the existing sizing.
                          final bumpExplanationFont = isEn && inExplanation;
                          final labelFontSize = bumpExplanationFont
                              ? explanationLabelFontSize
                              : (isCjk ? 15.0 : (isEn ? 17.0 : 15.0));
                          final mathFontSize = bumpExplanationFont
                              ? explanationMathFontSize
                              : (isCjk ? 20.0 : (isEn ? 24.0 : 20.0));

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (trimmed.isNotEmpty)
                                  MixedTextMath(
                                    localizedTex,
                                    forceTex: true,
                                    labelStyle: TextStyle(fontSize: labelFontSize),
                                    mathStyle: TextStyle(fontSize: mathFontSize),
                                  ),
                                if (s.imageAsset != null && _stepImageExistsCache[s.imageAsset] == true)
                                  Column(
                                    children: [
                                      const SizedBox(height: 6),
                                      Center(
                                        child: ConstrainedBox(
                                          constraints: const BoxConstraints(maxHeight: 400),
                                          child: Image.asset(
                                            s.imageAsset!,
                                            fit: BoxFit.contain,
                                            errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          );
                        }).toList();
                      }(),
                    ],
                  ),
                ),
            ]),
          ),
          // 戻るボタン（最前面に配置）
          const custom.BackButton(),
        ],
      ),
    );
  }
}

