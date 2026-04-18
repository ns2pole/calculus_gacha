// lib/pages/congruence_gacha_page.dart
// modガチャ専用ページ

import 'dart:math';
import 'dart:ui';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../l10n/app_localizations.dart';
import '../../problems/congruence_equations/congruence_equations.dart';
import '../../widgets/congruence/congruence_card.dart';
import '../../widgets/congruence/congruence_calculator.dart';
import '../../services/problems/simple_data_manager.dart';
import '../../models/math_problem.dart';
import '../common/common.dart';
import '../common/problem_status.dart';
import '../common/aggregation_mode.dart';
import '../../services/problems/exclusion_logic.dart' show shouldExcludeByMode, ExclusionMode;
import '../../widgets/common/back_button.dart';
import '../../widgets/common/expandable_calculator_wrapper.dart';
import '../../widgets/home/background_image_widget.dart';
import '../../managers/timer_manager.dart';
import '../../widgets/timer/timer_display.dart';
import '../../widgets/timer/timer_toggle.dart';
import '../../widgets/gacha/filter_chips.dart';
import '../../utils/navigation_utils.dart' show navigateToProblemList;
import '../../utils/gacha_settings_utils.dart' show GachaSettingsLoader, GachaSettingsSaver;
import 'gacha_settings_page.dart';
import '../../problems/congruence_equations/congruence_equations.dart';
import '../../models/math_problem.dart';
import '../../models/step_item.dart';
import '../other/scratch_paper_page.dart' show DrawingPoint, DrawingPainter, DrawingTool, isIPad;
import '../../widgets/drawing/drawing_toolbar.dart';
import '../../widgets/drawing/draggable_tool_buttons.dart' show DraggablePenButton;
import '../../widgets/drawing/draggable_eraser_button.dart';
import '../../widgets/drawing/draggable_scroll_button.dart';
import '../../widgets/gacha/physics_math_case_display.dart';
import '../common/common.dart' show MixedTextMath;
import '../../utils/l10n_utils.dart';
import '../../services/problems/translation_manager.dart';
import '../../models/problem_translation.dart';

/// modガチャページ
class CongruenceGachaPage extends StatefulWidget {
  const CongruenceGachaPage({Key? key}) : super(key: key);

  @override
  State<CongruenceGachaPage> createState() => _CongruenceGachaPageState();
}

class _CongruenceGachaPageState extends State<CongruenceGachaPage> {
  // カード選択状態
  final Set<int> _selectedCardIndices = {};
  int _maxSelections = 2; // デフォルトは2枚
  final Set<int> _flippedCardIndices = {}; // めくられたカードのインデックス

  // 問題表示状態
  bool _isProblemMode = false;
  int _currentProblemIndex = 0;
  List<CongruenceProblem> _selectedProblems = [];

  // 電卓状態
  String _userInput = '';
  bool _isAnswered = false;
  bool _isCorrect = false;
  bool _showHint = false; // ヒント表示状態
  bool _showDetailedExplanation = false; // 詳細解説表示状態

  // 計算用紙モード状態
  bool _isScratchPaperMode = false;
  bool _isCalculatorExpanded = false;

  // 描画関連の状態
  final GlobalKey _paintKey = GlobalKey();
  List<DrawingPoint> _points = [];
  List<List<DrawingPoint>> _strokes = [];
  List<List<DrawingPoint>> _undoStack = [];
  List<List<DrawingPoint>> _redoStack = [];
  Color _currentColor = Colors.black;
  double _currentStrokeWidth = 2.0;
  bool _isEraser = false;
  bool _isScrollMode = false;
  DrawingTool _currentTool = DrawingTool.pen; // iPad用のツール
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();
  late final ValueNotifier<String> _activeToolNotifier;
  late final ValueNotifier<bool> _isDrawingNotifier;
  Offset _penButtonPosition = const Offset(0, 0);

  // 筆圧から線幅を計算する関数（iPadのメモアプリと同様の仕様）
  double _calculateStrokeWidth(double pressure) {
    if (pressure <= 0.0) {
      return _currentStrokeWidth; // デフォルト値（筆圧なし）
    }
    const minWidth = 1.0;
    const maxWidth = 8.0;
    // 筆圧値（0.0〜1.0）を線幅にマッピング
    return minWidth + (pressure * (maxWidth - minWidth));
  }

  // ランダム生成用
  final _rand = Random();
  List<CongruenceProblem> _displayProblems = [];

  // 除外設定と集計設定
  GachaFilterMode _gachaFilterMode = GachaFilterMode.random;
  AggregationMode _aggregationMode = AggregationMode.latest1;

  // タイマー関連
  final TimerManager _timerManager = TimerManager();

  bool _isInitialized = false;

  ProblemTranslation? _getProblemTranslation(CongruenceProblem p) {
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    return TranslationManager.getTranslation(
      localeTag,
      p.id,
      expectedStepsLength: p.detailedExplanation?.length,
    );
  }

  bool _hasShortExplanation(CongruenceProblem p) {
    if ((p.shortExplanation?.isNotEmpty ?? false)) return true;
    return (_getProblemTranslation(p)?.shortExplanation?.isNotEmpty ?? false);
  }

  String? _getLocalizedShortExplanation(CongruenceProblem p) {
    final t = _getProblemTranslation(p);
    return t?.shortExplanation ?? p.shortExplanation;
  }

  bool _hasDetailedExplanation(CongruenceProblem p) {
    if ((p.detailedExplanation?.isNotEmpty ?? false)) return true;
    return (_getProblemTranslation(p)?.steps?.isNotEmpty ?? false);
  }

  List<String> _getLocalizedDetailedExplanationTex(CongruenceProblem p) {
    final langCode = Localizations.localeOf(context).languageCode;
    final t = _getProblemTranslation(p);
    final base = p.detailedExplanation;

    // Prefer full EN translation ONLY when it matches the detailedExplanation length.
    // This keeps behavior consistent with other gacha pages and prevents partial/misaligned translations.
    if (langCode != 'ja' &&
        t?.steps != null &&
        base != null &&
        t!.steps!.length == base.length) {
      return t.steps!;
    }

    // Fallback to the original, with small automatic tag translations.
    if (base == null) return const [];
    return base.map((s) => s.getLocalizedTex(context)).toList(growable: false);
  }

  @override
  void initState() {
    super.initState();

    // 描画関連のNotifierを初期化
    final initialTool = _isEraser ? 'eraser' : (_isScrollMode ? 'scroll' : 'pen');
    _activeToolNotifier = ValueNotifier<String>(initialTool);
    _isDrawingNotifier = ValueNotifier<bool>(false);

    // タイマーマネージャーのリスナーを設定
    _timerManager.isTimerEnabledNotifier.addListener(_onTimerStateChanged);
    _timerManager.isTimerRunningNotifier.addListener(_onTimerStateChanged);
    _timerManager.remainingSecondsNotifier.addListener(_onTimerStateChanged);

    // タイマー終了時のコールバックを設定
    _timerManager.onTimerFinished = () {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.timerFinished),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    };

    // 保存された設定を読み込む
    _loadSettings();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 初回の初期化後、ページが再表示される時に設定を再読み込み
    if (_isInitialized) {
      _reloadSettings();
    }
  }

  @override
  void dispose() {
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    _activeToolNotifier.dispose();
    _isDrawingNotifier.dispose();
    super.dispose();
  }

  void _onTimerStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _reloadSettings() async {
    // 設定を再読み込み
    await _loadSettings();
  }

  /// 保存された設定を読み込む
  Future<void> _loadSettings() async {
    // 選択枚数を読み込む
    _maxSelections = await GachaSettingsLoader.loadMaxSelections('congruence');

    // 除外設定を読み込む（ガチャ設定から）
    final settings = await SimpleDataManager.getGachaSettings('congruence');
    final filterModeStr = settings['filterMode'] as String?;
    if (filterModeStr != null) {
      switch (filterModeStr) {
        case 'exclude_solved_ge1':
          _gachaFilterMode = GachaFilterMode.excludeSolvedGE1;
          break;
        case 'exclude_solved_ge2':
          _gachaFilterMode = GachaFilterMode.excludeSolvedGE2;
          break;
        case 'exclude_solved_ge3':
          _gachaFilterMode = GachaFilterMode.excludeSolvedGE3;
          break;
        case 'random':
        default:
          _gachaFilterMode = GachaFilterMode.random;
          break;
      }
    } else {
      _gachaFilterMode = GachaFilterMode.random;
    }

    // 集計設定を読み込む
    _aggregationMode = await GachaSettingsLoader.loadAggregationMode('congruence');

    // タイマー設定を読み込む
    await GachaSettingsLoader.loadTimerSettings(_timerManager, 'congruence');

    // 選択枚数に応じてタイマーの初期時間を設定（初回のみ）
    await GachaSettingsLoader.initializeTimerBasedOnSelection(
      'congruence',
      _maxSelections,
      _timerManager,
    );

    if (mounted) {
      await _shuffleProblems();
      setState(() {});
      _isInitialized = true;
    }
  }

  /// 選択枚数に応じてタイマーの初期時間を設定
  Future<void> _updateTimerBasedOnSelection() async {
    final minutes = _maxSelections;
    final settings = await SimpleDataManager.getGachaSettings('congruence');
    settings['timerMinutes'] = minutes;
    settings['remainingSeconds'] = minutes * 60;
    await SimpleDataManager.saveGachaSettings('congruence', settings);
    await _timerManager.loadTimerSettings('congruence');
  }

  /// 設定を保存する
  Future<void> _saveSettings() async {
    // 選択枚数を保存
    await GachaSettingsSaver.saveMaxSelections('congruence', _maxSelections);
  }

  /// ✅ フィルタ（除外設定）を反映して、配るカードを作る
  /// - 候補が5未満ならその枚数だけ配る（フォールバックで5枚に戻さない）
  /// - 候補が0件なら0枚（カードを出さない）
  Future<void> _shuffleProblems() async {
    List<CongruenceProblem> pool = [];

    // 1) 除外なし（random）のときは全体から選ぶ
    if (_gachaFilterMode == GachaFilterMode.random) {
      pool = List<CongruenceProblem>.from(congruenceGachaProblems);
    } else {
      final l10n = AppLocalizations.of(context)!;
      // 2) 除外ありのときは、学習履歴に応じて除外したリストを作る
      final exclusionMode = _gachaFilterMode.toExclusionMode();

      for (final cp in congruenceGachaProblems) {
        final mathProblem = MathProblem(
          id: cp.id,
          no: cp.no,
          category: l10n.modGachaTitleOnly,
          level: '初級',
          question: cp.question,
          answer: cp.answer.toString(),
          imageAsset: null,
          steps: const [],
          shortExplanation: cp.shortExplanation,
          detailedExplanation: cp.detailedExplanation,
        );

        final shouldExclude = await shouldExcludeByMode(mathProblem, exclusionMode);
        if (!shouldExclude) {
          pool.add(cp);
        }
      }
    }

    // ✅ 候補が0件/少数件でも、そのままの枚数で配る（フォールバックしない）
    for (var i = 0; i < 3; i++) {
      pool.shuffle(_rand);
    }

    _displayProblems = pool.length > 5 ? pool.sublist(0, 5) : pool;
  }

  /// 選択枚数セレクタボタン（単一選択）
  Widget _buildCountSelector(String label, int count, {required double width}) {
    final isSelected = _maxSelections == count;
    return GestureDetector(
      onTap: () async {
        setState(() {
          _maxSelections = count;
          if (_selectedCardIndices.length > _maxSelections) {
            final toRemove = _selectedCardIndices.length - _maxSelections;
            final indices = _selectedCardIndices.toList();
            for (var i = 0; i < toRemove; i++) {
              _selectedCardIndices.remove(indices[indices.length - 1 - i]);
            }
          }
        });
        await _updateTimerBasedOnSelection();
        _saveSettings();
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.orange.shade700 : Colors.grey.shade400,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  void _toggleCardSelection(int index) {
    setState(() {
      if (_selectedCardIndices.contains(index)) {
        _selectedCardIndices.remove(index);
      } else {
        if (_selectedCardIndices.length < _maxSelections) {
          _selectedCardIndices.add(index);

          if (_selectedCardIndices.length == _maxSelections) {
            Future.delayed(const Duration(milliseconds: 300), () {
              _startProblems();
            });
          }
        }
      }
    });
  }

  void _startProblems() {
    final l10n = AppLocalizations.of(context)!;
    if (_selectedCardIndices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.selectCards)),
      );
      return;
    }

    setState(() {
      _selectedProblems = _selectedCardIndices.map((idx) => _displayProblems[idx]).toList();

      _isProblemMode = true;
      _currentProblemIndex = 0;
      _isAnswered = false;
      _isCorrect = false;
      _userInput = '';
      _showHint = false;
      _showDetailedExplanation = false;
    });
  }

  /// 文字列からmodulus（法）を抽出する
  /// 例: "x ≡ 2 (mod 5)" -> 5
  int? _parseModulus(String text) {
    // \pmod{n} または mod n を検索
    final pmodMatch = RegExp(r'\\pmod\{(\d+)\}').firstMatch(text);
    if (pmodMatch != null) {
      return int.tryParse(pmodMatch.group(1)!);
    }

    final modMatch = RegExp(r'mod\s*(\d+)').firstMatch(text);
    if (modMatch != null) {
      return int.tryParse(modMatch.group(1)!);
    }

    return null;
  }

  /// 解の集合をパースする
  Set<int> _parseValues(String text, int modulus) {
    final values = <int>{};

    String cleanText = text;
    // mod以降を削除
    if (cleanText.contains(r'\pmod')) {
      cleanText = cleanText.substring(0, cleanText.indexOf(r'\pmod'));
    } else if (cleanText.contains('mod')) {
      cleanText = cleanText.substring(0, cleanText.indexOf('mod'));
    }

    // 不要な文字を削除
    cleanText = cleanText
        .replaceAll('x', '')
        .replaceAll('≡', '')
        .replaceAll(r'\equiv', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .trim();

    final parts = cleanText.split(',');
    for (var part in parts) {
      part = part.trim();
      if (part.isEmpty) continue;

      bool isPlusMinus = part.contains(r'\pm');
      part = part.replaceAll(r'\pm', '').trim();

      final val = int.tryParse(part);
      if (val != null) {
        values.add(val % modulus);
        if (isPlusMinus) {
          values.add((-val) % modulus);
        }
      }
    }
    return values;
  }

  void _handleAnswer(String input) {
    if (_isAnswered) return;

    final currentProblem = _selectedProblems[_currentProblemIndex];

    // 入力が空（またはプレフィックスのみ）の場合は不正解とする
    // （電卓に初期値 "x≡ " が入るため、数値が含まれているか確認）
    final cleanInput =
        input.replaceAll('x≡ ', '').replaceAll('x', '').replaceAll('≡', '').trim();
    if (cleanInput.isEmpty) {
      setState(() {
        _isAnswered = true;
        _isCorrect = false;
        _userInput = input;
      });
      _saveLearningRecord(false);
      return;
    }

    // モジュラスのチェック（ユーザーが入力した場合）
    final userModulus = _parseModulus(input);
    if (userModulus != null && userModulus != currentProblem.modulus) {
      // モジュラスが間違っている場合は不正解
      setState(() {
        _isAnswered = true;
        _isCorrect = false;
        _userInput = input;
      });
      _saveLearningRecord(false);
      return;
    }

    // 解の集合を比較
    final userValues = _parseValues(input, currentProblem.modulus);
    final correctValues = _parseValues(currentProblem.answer, currentProblem.modulus);

    // 解がパースできなかった場合も不正解
    if (userValues.isEmpty) {
      setState(() {
        _isAnswered = true;
        _isCorrect = false;
        _userInput = input;
      });
      _saveLearningRecord(false);
      return;
    }

    // すべての正解が含まれており、かつ余分な解がないこと
    final isCorrect =
        userValues.length == correctValues.length && userValues.containsAll(correctValues);

    setState(() {
      _isAnswered = true;
      _isCorrect = isCorrect;
      _userInput = input;
    });

    _saveLearningRecord(isCorrect);
  }

  Future<void> _saveLearningRecord(bool isCorrect) async {
    final l10n = AppLocalizations.of(context)!;
    // 合同方程式問題に対応するMathProblemを作成（簡易版）
    final mathProblem = MathProblem(
      id: _selectedProblems[_currentProblemIndex].id,
      no: _selectedProblems[_currentProblemIndex].no,
      category: l10n.modGachaTitleOnly,
      level: '初級',
      question: _selectedProblems[_currentProblemIndex].question,
      answer: '${_selectedProblems[_currentProblemIndex].answer}',
      imageAsset: null,
      steps: [],
    );

    final status = isCorrect ? ProblemStatus.solved : ProblemStatus.failed;

    final history = await SimpleDataManager.getLearningHistory(mathProblem);
    final current = <Map<String, dynamic>>[];

    const slotCount = 3;
    for (var i = 0; i < slotCount; i++) {
      if (i < history.length) {
        final h = history[i];
        final status = ProblemStatus.values.firstWhere(
          (s) => s.name == h['status'],
          orElse: () => ProblemStatus.none,
        );
        final timeStr = h['time'] as String?;
        current.add({'status': status, 'time': timeStr});
      } else {
        current.add({'status': ProblemStatus.none, 'time': null});
      }
    }

    while (current.length < slotCount) {
      current.add({'status': ProblemStatus.none, 'time': null});
    }

    int targetSlot = -1;
    for (var i = 0; i < slotCount; i++) {
      final slotStatus = current[i]['status'] as ProblemStatus? ?? ProblemStatus.none;
      if (slotStatus == ProblemStatus.none) {
        targetSlot = i;
        break;
      }
    }

    if (targetSlot == -1) {
      targetSlot = 0;
    }

    final t = DateTime.now().toIso8601String();
    current[targetSlot] = {'status': status, 'time': t};

    for (var j = targetSlot + 1; j < current.length; j++) {
      current[j] = {'status': ProblemStatus.none, 'time': null};
    }

    await SimpleDataManager.saveLearningHistory(mathProblem, current);
  }

  void _nextProblem() {
    if (_currentProblemIndex < _selectedProblems.length - 1) {
      setState(() {
        _currentProblemIndex++;
        _isAnswered = false;
        _isCorrect = false;
        _userInput = '';
        _showHint = false;
        _showDetailedExplanation = false;
      });
    } else {
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.complete),
        content: Text(l10n.allProblemsSolvedSimple),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              setState(() {
                _isProblemMode = false;
                _selectedCardIndices.clear();
                _flippedCardIndices.clear();
              });
              await _shuffleProblems();
              if (mounted) {
                setState(() {});
              }
            },
            child: Text(l10n.backToCardSelection),
          ),
        ],
      ),
    );
  }

  /// 全問題数を取得
  int _getTotalProblemCount() {
    return congruenceGachaProblems.length;
  }

  /// フィルタリング後の問題数を計算（除外設定）
  Future<int> _getFilteredProblemCount() async {
    final l10n = AppLocalizations.of(context)!;
    if (_gachaFilterMode == GachaFilterMode.random) {
      return _getTotalProblemCount();
    }

    // CongruenceProblemをMathProblemに変換して除外判定
    // GachaFilterModeをExclusionModeに変換
    final exclusionMode = _gachaFilterMode.toExclusionMode();
    int count = 0;
    for (final cp in congruenceGachaProblems) {
      final mathProblem = MathProblem(
        id: cp.id,
        no: cp.no,
        category: l10n.modGachaTitleOnly,
        level: '初級',
        question: cp.question,
        answer: cp.answer.toString(),
        imageAsset: null,
        steps: [],
        shortExplanation: cp.shortExplanation,
        detailedExplanation: cp.detailedExplanation,
      );

      final shouldExclude = await shouldExcludeByMode(mathProblem, exclusionMode);
      if (!shouldExclude) {
        count++;
      }
    }

    return count;
  }

  /// フィルター設定部分を構築
  Widget _buildFilterSection() {
    final totalCount = _getTotalProblemCount();
    final l10n = AppLocalizations.of(context)!;

    return FutureBuilder<int>(
      future: _getFilteredProblemCount(),
      builder: (context, snapshot) {
        final filteredCount = snapshot.hasData ? snapshot.data! : totalCount;
        final problemCountText = _gachaFilterMode == GachaFilterMode.random
            ? l10n.noExclusionAllCount(totalCount)
            : l10n.problemCountRemaining(filteredCount, totalCount);

        return GachaExclusionFilterWidget(
          gachaFilterMode: _gachaFilterMode,
          onGachaFilterModeChanged: (GachaFilterMode newMode) async {
            setState(() {
              _gachaFilterMode = newMode;
              _selectedCardIndices.clear();
              _flippedCardIndices.clear();
            });
            // ガチャ設定に保存
            final settings = await SimpleDataManager.getGachaSettings('congruence');
            String filterModeStr;
            switch (newMode) {
              case GachaFilterMode.excludeSolvedGE1:
                filterModeStr = 'exclude_solved_ge1';
                break;
              case GachaFilterMode.excludeSolvedGE2:
                filterModeStr = 'exclude_solved_ge2';
                break;
              case GachaFilterMode.excludeSolvedGE3:
                filterModeStr = 'exclude_solved_ge3';
                break;
              case GachaFilterMode.random:
              default:
                filterModeStr = 'random';
                break;
            }
            settings['filterMode'] = filterModeStr;
            await SimpleDataManager.saveGachaSettings('congruence', settings);

            // ✅ フィルタ変更を即座にカード配布へ反映
            await _shuffleProblems();
            if (mounted) {
              setState(() {});
            }
          },
          prefsPrefix: 'congruence',
          problemCountText: problemCountText,
          showStatusBadge: _gachaFilterMode != GachaFilterMode.random,
          additionalText: _gachaFilterMode != GachaFilterMode.random ? l10n.excludingLabel : null,
          iconSize: 20,
        );
      },
    );
  }

  /// タイマー表示ウィジェット
  Widget _buildTimerDisplay() {
    return TimerDisplay(timerManager: _timerManager);
  }

  /// スロット表示ウィジェット
  Widget _buildSlotDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_maxSelections, (index) {
        final selectedIndices = _selectedCardIndices.toList();
        final isFilled = index < selectedIndices.length;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 50,
          height: 62,
          child: isFilled
              ? AbsorbPointer(
                  child: ClipRect(
                    child: SizedBox(
                      width: 50,
                      height: 62,
                      child: OverflowBox(
                        maxWidth: 58,
                        maxHeight: 70,
                        child: CongruenceCard(
                          problem: _displayProblems[selectedIndices[index]],
                          isSelected: false,
                          isFlipped: false,
                          fixedWidth: 50.0,
                          fixedHeight: 62.0,
                          onTap: null,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  width: 50,
                  height: 62,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isProblemMode) {
      return _buildProblemView();
    } else {
      return _buildCardSelectionView();
    }
  }

  Widget _buildCardSelectionView() {
    final displayProblems = _displayProblems;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: const BackgroundImageWidget(),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top + 24.0 - 14.0,
                            bottom: 20.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  l10n.modGachaTitleOnly,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF8B7355),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(width: 8),
                              TimerToggle(timerManager: _timerManager),
                              const SizedBox(width: 12),
                              // 問題一覧ボタン
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  minimumSize: const Size(90, 40),
                                  backgroundColor: Colors.grey.shade200,
                                  foregroundColor: Colors.black,
                                  elevation: 0,
                                  side: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 2,
                                  ),
                                ),
                                onPressed: () async {
                                  // CongruenceProblemをMathProblemに変換
                                  final mathProblems = congruenceGachaProblems.map((cp) {
                                    return MathProblem(
                                      id: cp.id,
                                      no: cp.no,
                                      category: l10n.modGachaTitleOnly,
                                      level: '初級',
                                      question: cp.question,
                                      answer: cp.answer.toString(),
                                      steps: [],
                                      shortExplanation: cp.shortExplanation,
                                      detailedExplanation: cp.detailedExplanation,
                                      equation: cp.equation,
                                      conditions: cp.conditions,
                                    );
                                  }).toList();
                                  await navigateToProblemList(
                                    context: context,
                                    problemPool: mathProblems,
                                    prefsPrefix: 'congruence',
                                  );
                                  // 問題一覧から戻ってきた時に設定を再読み込み
                                  if (mounted) {
                                    await _loadSettings();
                                    setState(() {});
                                  }
                                },
                                child: Text(
                                  l10n.problemList,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF8B7355),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // フィルタリングガジェット（除外設定と集計設定）
                        _buildFilterSection(),
                        const SizedBox(height: 8),
                        // 選択枚数の設定
                        Column(
                          children: [
                            Text(
                              l10n.howManyCards,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // 1枚、2枚、3枚のセレクタボタン
                            LayoutBuilder(
                              builder: (context, constraints) {
                                // Target: ~2.2x wider than the old 80px => ~176px.
                                // On narrow screens, clamp to available width to avoid overflow.
                                const targetWidth = 176.0;
                                const gap = 12.0;
                                final maxPerButton = (constraints.maxWidth - gap * 2) / 3.0;
                                final buttonWidth = maxPerButton.isFinite
                                    ? maxPerButton.clamp(110.0, targetWidth)
                                    : targetWidth;

                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildCountSelector(l10n.nCards(1), 1, width: buttonWidth),
                                    const SizedBox(width: gap),
                                    _buildCountSelector(l10n.nCards(2), 2, width: buttonWidth),
                                    const SizedBox(width: gap),
                                    _buildCountSelector(l10n.nCards(3), 3, width: buttonWidth),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            // スロット表示
                            _buildSlotDisplay(),
                          ],
                        ),
                        SizedBox(
                          height: 52,
                          child: Center(
                            child: _selectedCardIndices.length == _maxSelections
                                ? Text(
                                    l10n.startingAutomatically,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                        // 仕切り線
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey.shade400,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        const SizedBox(height: 16),
                        // タイマー表示
                        _buildTimerDisplay(),
                        const SizedBox(height: 16),
                        // カードレイアウト（スマホ対応）
                        Builder(
                          builder: (context) {
                            final screenWidth = MediaQuery.of(context).size.width;
                            final isSmallScreen = screenWidth < 600;

                            if (isSmallScreen) {
                              final cardWidth = (screenWidth - 32) / 3 - 8;
                              final cardHeight = cardWidth * 5 / 4;

                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (displayProblems.isNotEmpty)
                                        SizedBox(
                                          width: cardWidth,
                                          height: cardHeight,
                                          child: CongruenceCard(
                                            problem: displayProblems[0],
                                            isSelected: _selectedCardIndices.contains(0),
                                            isFlipped: _flippedCardIndices.contains(0),
                                            onTap: () => _toggleCardSelection(0),
                                          ),
                                        ),
                                      if (displayProblems.length > 1)
                                        SizedBox(
                                          width: cardWidth,
                                          height: cardHeight,
                                          child: CongruenceCard(
                                            problem: displayProblems[1],
                                            isSelected: _selectedCardIndices.contains(1),
                                            isFlipped: _flippedCardIndices.contains(1),
                                            onTap: () => _toggleCardSelection(1),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  if (displayProblems.length > 2)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if (displayProblems.length > 2)
                                          SizedBox(
                                            width: cardWidth,
                                            height: cardHeight,
                                            child: CongruenceCard(
                                              problem: displayProblems[2],
                                              isSelected: _selectedCardIndices.contains(2),
                                              isFlipped: _flippedCardIndices.contains(2),
                                              onTap: () => _toggleCardSelection(2),
                                            ),
                                          ),
                                        if (displayProblems.length > 3)
                                          SizedBox(
                                            width: cardWidth,
                                            height: cardHeight,
                                            child: CongruenceCard(
                                              problem: displayProblems[3],
                                              isSelected: _selectedCardIndices.contains(3),
                                              isFlipped: _flippedCardIndices.contains(3),
                                              onTap: () => _toggleCardSelection(3),
                                            ),
                                          ),
                                        if (displayProblems.length > 4)
                                          SizedBox(
                                            width: cardWidth,
                                            height: cardHeight,
                                            child: CongruenceCard(
                                              problem: displayProblems[4],
                                              isSelected: _selectedCardIndices.contains(4),
                                              isFlipped: _flippedCardIndices.contains(4),
                                              onTap: () => _toggleCardSelection(4),
                                            ),
                                          ),
                                      ],
                                    ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (displayProblems.isNotEmpty)
                                        CongruenceCard(
                                          problem: displayProblems[0],
                                          isSelected: _selectedCardIndices.contains(0),
                                          isFlipped: _flippedCardIndices.contains(0),
                                          onTap: () => _toggleCardSelection(0),
                                        ),
                                      if (displayProblems.length > 1)
                                        CongruenceCard(
                                          problem: displayProblems[1],
                                          isSelected: _selectedCardIndices.contains(1),
                                          isFlipped: _flippedCardIndices.contains(1),
                                          onTap: () => _toggleCardSelection(1),
                                        ),
                                    ],
                                  ),
                                  if (displayProblems.length > 2)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if (displayProblems.length > 2)
                                          CongruenceCard(
                                            problem: displayProblems[2],
                                            isSelected: _selectedCardIndices.contains(2),
                                            isFlipped: _flippedCardIndices.contains(2),
                                            onTap: () => _toggleCardSelection(2),
                                          ),
                                        if (displayProblems.length > 3)
                                          CongruenceCard(
                                            problem: displayProblems[3],
                                            isSelected: _selectedCardIndices.contains(3),
                                            isFlipped: _flippedCardIndices.contains(3),
                                            onTap: () => _toggleCardSelection(3),
                                          ),
                                        if (displayProblems.length > 4)
                                          CongruenceCard(
                                            problem: displayProblems[4],
                                            isSelected: _selectedCardIndices.contains(4),
                                            isFlipped: _flippedCardIndices.contains(4),
                                            onTap: () => _toggleCardSelection(4),
                                          ),
                                      ],
                                    ),
                                ],
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const BackButton(),
        ],
      ),
    );
  }



  /// 合同式を2行に分けて表示（合同式とmod nを分離）
  Widget _buildTwoLineCongruence(String question, {String? equation, String? conditions}) {
    // equationとconditionsがある場合はcase形式で表示
    if (equation != null && conditions != null) {
      return PhysicsMathCaseDisplay(
        equation: equation,
        conditions: conditions,
        fontSize: 36,
      );
    }
    
    // \pmod{n}の部分を検出
    final modPattern = RegExp(r'\\pmod\{[^}]+\}');
    final modMatch = modPattern.firstMatch(question);
    
    if (modMatch != null) {
      // \pmod{n}の部分を抽出
      final modPart = modMatch.group(0)!;
      // 合同式の部分（\pmod{n}を除く）
      final congruencePart = question.substring(0, modMatch.start).trim();
      
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1行目: 合同式
          Math.tex(
            congruencePart,
            textStyle: const TextStyle(
              fontSize: 42,
              fontFamily: 'serif',
            ),
            mathStyle: MathStyle.display,
          ),
          const SizedBox(height: 20),
          // 2行目: mod n
          Math.tex(
            modPart,
            textStyle: const TextStyle(
              fontSize: 32,
              fontFamily: 'serif',
            ),
            mathStyle: MathStyle.display,
          ),
        ],
      );
    } else {
      // \pmod{n}が見つからない場合は従来通り1行で表示
      return Math.tex(
        question,
        textStyle: const TextStyle(
          fontSize: 42,
          fontFamily: 'serif',
        ),
        mathStyle: MathStyle.display,
      );
    }
  }
  
  /// 計算用紙モード用の小さな合同式表示
  Widget _buildTwoLineCongruenceSmall(String question, {String? equation, String? conditions}) {
    // equationとconditionsがある場合はcase形式で表示
    if (equation != null && conditions != null) {
      return PhysicsMathCaseDisplay(
        equation: equation,
        conditions: conditions,
        fontSize: 28,
      );
    }
    
    // \pmod{n}の部分を検出
    final modPattern = RegExp(r'\\pmod\{[^}]+\}');
    final modMatch = modPattern.firstMatch(question);
    
    if (modMatch != null) {
      // \pmod{n}の部分を抽出
      final modPart = modMatch.group(0)!;
      // 合同式の部分（\pmod{n}を除く）
      final congruencePart = question.substring(0, modMatch.start).trim();
      
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1行目: 合同式
          Math.tex(
            congruencePart,
            textStyle: const TextStyle(
              fontSize: 36,
              fontFamily: 'serif',
            ),
            mathStyle: MathStyle.display,
          ),
          const SizedBox(height: 12),
          // 2行目: mod n
          Math.tex(
            modPart,
            textStyle: const TextStyle(
              fontSize: 26,
              fontFamily: 'serif',
            ),
            mathStyle: MathStyle.display,
          ),
        ],
      );
    } else {
      // \pmod{n}が見つからない場合は従来通り1行で表示
      return Math.tex(
        question,
        textStyle: const TextStyle(
          fontSize: 36,
          fontFamily: 'serif',
        ),
        mathStyle: MathStyle.display,
      );
    }
  }

  Widget _buildProblemView() {
    final problem = _selectedProblems[_currentProblemIndex];
    // 平方合同式（x^2 ≡ ...）の場合は shortExplanation から完全な答えを取得
    final isQuadratic = problem.question.contains('x^2');
    String correctAnswer;
    final localizedShortExplanation = _getLocalizedShortExplanation(problem);
    if (isQuadratic && localizedShortExplanation != null) {
      // shortExplanation から「x ≡ ...」の部分を抽出
      final explanation = localizedShortExplanation;
      final match =
          RegExp(r'x\s*(?:≡|\\equiv)\s*[^。．\.\n]+').firstMatch(explanation);
      if (match != null) {
        correctAnswer = match.group(0)!;
      } else {
        // マッチしない場合は shortExplanation 全体を使用
        correctAnswer = explanation.replaceAll(RegExp(r'[。．\.]\s*$'), '');
      }
    } else {
      // answerは既にTeX形式の文字列として保存されているので、そのまま使用
      correctAnswer = problem.answer;
    }

    final remainingCount = _selectedProblems.length - _currentProblemIndex - 1;
    final remainingProblems = remainingCount > 0
        ? _selectedProblems.sublist(
            _currentProblemIndex + 1,
            _currentProblemIndex + 1 + (remainingCount > 2 ? 2 : remainingCount),
          )
        : <CongruenceProblem>[];

    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_isScratchPaperMode) {
              setState(() {
                _isScratchPaperMode = false;
                _isCalculatorExpanded = false;
              });
            } else if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
          tooltip: l10n.back,
        ),
        actions: [
          // Hintボタン（shortExplanationがある場合のみ表示）
          if (_hasShortExplanation(problem))
            IconButton(
              iconSize: 42.0,
              tooltip: _showHint ? l10n.hideHint : l10n.showHint,
              onPressed: () {
                setState(() {
                  _showHint = !_showHint;
                });
              },
              icon: Icon(
                Icons.lightbulb_outline,
                color: _showHint ? Colors.orange : Colors.grey[600],
                size: 42.0,
              ),
            ),
          // 計算用紙ボタン
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              iconSize: 42.0,
              tooltip: _isScratchPaperMode ? l10n.closeScratchPaper : l10n.openScratchPaper,
              onPressed: () {
                setState(() {
                  _isScratchPaperMode = !_isScratchPaperMode;
                  if (!_isScratchPaperMode) {
                    // 計算用紙モードを閉じる時、電卓も折りたたむ
                    _isCalculatorExpanded = false;
                  }
                });
              },
              icon: Icon(
                Icons.edit_note,
                color: _isScratchPaperMode ? Colors.orange : Colors.blue,
                size: 42.0,
              ),
            ),
          ),
        ],
      ),
      // ここで外側のStackがクリップしないようにする
      body: _isScratchPaperMode ? _buildScratchPaperModeBody(problem, correctAnswer, remainingProblems, remainingCount) : _buildNormalModeBody(problem, correctAnswer, remainingProblems, remainingCount),
    );
  }
  
  // 描画関連のメソッド
  void _onPointerDown(PointerDownEvent event) {
    if (isIPad(context) && event.kind == PointerDeviceKind.touch) {
      return;
    }

    if (_isScrollMode) {
      return;
    }

    // スクロールモードでない場合のみ描画を開始
    final pressure = event.pressure;
    final strokeWidth = _calculateStrokeWidth(pressure);
    
    _isDrawingNotifier.value = true;
    
    setState(() {
      _points = [
        DrawingPoint(
          event.localPosition,
          _currentColor,
          strokeWidth,
          _isEraser,
        ),
      ];
    });
  }
  
  void _onPointerMove(PointerMoveEvent event) {
    if (isIPad(context) && event.kind == PointerDeviceKind.touch) {
      return;
    }

    if (_isScrollMode) {
      return;
    }

    final pressure = event.pressure;
    final strokeWidth = _calculateStrokeWidth(pressure);

    if (_isEraser) {
      _eraseAtPoint(event.localPosition);
    } else {
      setState(() {
        _points.add(
          DrawingPoint(
            event.localPosition,
            _currentColor,
            strokeWidth,
            false,
          ),
        );
      });
    }
  }
  
  void _onPointerUp(PointerUpEvent event) {
    if (isIPad(context) && event.kind == PointerDeviceKind.touch) {
      return;
    }

    _isDrawingNotifier.value = false;
    
    if (_isScrollMode) {
      return;
    }
    
    if (!_isEraser) {
      setState(() {
        _strokes.add(List.from(_points));
        _points = [];
        _redoStack.clear();
      });
    }
  }

  void _onPointerCancel(PointerCancelEvent event) {
    _isDrawingNotifier.value = false;

    if (_isScrollMode) {
      return;
    }

    if (!_isEraser && _points.isNotEmpty) {
      setState(() {
        _strokes.add(List.from(_points));
        _points = [];
        _redoStack.clear();
      });
    }
  }
  
  void _eraseAtPoint(Offset point) {
    setState(() {
      const eraseRadius = 20.0;
      final List<List<DrawingPoint>> newStrokes = [];
      
      for (final stroke in _strokes) {
        final List<DrawingPoint> remainingPoints = [];
        bool wasErasing = false;
        
        for (int i = 0; i < stroke.length; i++) {
          final distance = (stroke[i].point - point).distance;
          
          if (distance < eraseRadius) {
            // 消しゴムの範囲内のポイントはスキップ
            wasErasing = true;
          } else {
            // 消しゴムの範囲外のポイント
            if (wasErasing && remainingPoints.isNotEmpty) {
              // 前回の消去範囲から離れたので、新しいストロークとして保存
              if (remainingPoints.length > 1) {
                newStrokes.add(List.from(remainingPoints));
              }
              remainingPoints.clear();
            }
            remainingPoints.add(stroke[i]);
            wasErasing = false;
          }
        }
        
        // 残りのポイントがある場合は追加
        if (remainingPoints.length > 1) {
          newStrokes.add(remainingPoints);
        }
      }
      
      _strokes = newStrokes;
    });
  }
  
  Widget _buildScrollableCanvas() {
    final isPad = isIPad(context);
    final physics = (isPad || _isScrollMode)
        ? const AlwaysScrollableScrollPhysics()
        : const NeverScrollableScrollPhysics();

    Widget scrollView = SingleChildScrollView(
      controller: _verticalScrollController,
      scrollDirection: Axis.vertical,
      physics: physics,
      child: SingleChildScrollView(
        controller: _horizontalScrollController,
        scrollDirection: Axis.horizontal,
        physics: physics,
        child: SizedBox(
          width: 2000,
          height: 2000,
          child: Listener(
            onPointerDown: _onPointerDown,
            onPointerMove: _onPointerMove,
            onPointerUp: _onPointerUp,
            onPointerCancel: _onPointerCancel,
            child: CustomPaint(
              painter: DrawingPainter(
                strokes: _strokes,
                currentStroke: _points,
              ),
              size: const Size(2000, 2000),
            ),
          ),
        ),
      ),
    );

    if (isPad) {
      return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: scrollView,
      );
    }

    return scrollView;
  }
  
  Widget _buildNormalModeBody(CongruenceProblem problem, String correctAnswer, List<CongruenceProblem> remainingProblems, int remainingCount) {
    final l10n = AppLocalizations.of(context)!;
    final hintOrPointText = _getLocalizedShortExplanation(problem);
    final detailedExplanationTex = _getLocalizedDetailedExplanationTex(problem);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 375, // カードの高さ
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 300,
                        height: 375,
                        margin: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
                        decoration: BoxDecoration(
                          color: _isAnswered
                              ? (_isCorrect ? Colors.green.shade50 : Colors.red.shade50)
                              : Colors.white,
                          border: Border.all(
                            color: _isAnswered
                                ? (_isCorrect ? Colors.green.shade400 : Colors.red.shade400)
                                : Colors.grey.shade300,
                            width: _isAnswered ? 3 : 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: _isAnswered
                                  ? (_isCorrect ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3))
                                  : Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: _buildTwoLineCongruence(
                                      problem.question,
                                      equation: problem.equation,
                                      conditions: problem.conditions,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // 答え表示（解答後に表示、完了ボタンの上）
                              if (_isAnswered) ...[
                                const SizedBox(height: 8),
                                Text(
                                  l10n.answerLabel,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Center(
                                    child: MixedTextMath(
                                      correctAnswer,
                                      forceTex: true,
                                      labelStyle: TextStyle(
                                        fontSize: 18,
                                        color: _isCorrect ? Colors.green.shade700 : Colors.red.shade700,
                                      ),
                                      mathStyle: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: _isCorrect ? Colors.green.shade700 : Colors.red.shade700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              // 次へボタン（解答後に表示）
                              if (_isAnswered)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: _nextProblem,
                                      icon: const Icon(Icons.arrow_forward),
                                      label: Text(
                                        _currentProblemIndex < _selectedProblems.length - 1
                                            ? l10n.next
                                            : l10n.complete,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.purple,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      // 正解/不正解のマーク（カードの上部中央に小さく表示）
                      if (_isAnswered)
                        Positioned(
                          top: 8,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Icon(
                              _isCorrect ? Icons.check_circle : Icons.cancel,
                              size: 32,
                              color: _isCorrect 
                                  ? Colors.green.shade700
                                  : Colors.red.shade700,
                            ),
                          ),
                        ),
                      // 残りカードを最前面に表示
                      if (remainingProblems.isNotEmpty)
                        Positioned(
                          top: 8,
                          right: -8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 60.0,
                                height: 75.0,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: remainingProblems.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final remainingProblem = entry.value;
                                    final offsetX = index == 0 ? 0.0 : 6.0;
                                    final offsetY = index == 0 ? 0.0 : -6.0;
                                    return Positioned(
                                      left: offsetX,
                                      top: offsetY,
                                      child: CongruenceCard(
                                        problem: remainingProblem,
                                        isFlipped: false,
                                        isSelected: false,
                                        fixedWidth: 60.0,
                                        fixedHeight: 75.0,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  l10n.remainingCards(remainingCount),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // ヒント表示（オプション）
              if (_showHint && hintOrPointText != null && hintOrPointText.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.hintLabelTitle,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      MixedTextMath(
                        hintOrPointText,
                        forceTex: true,
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade700,
                        ),
                        mathStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              // shortExplanation表示（解答後に自動表示、カードの下と電卓の間）
              if (_isAnswered && hintOrPointText != null && hintOrPointText.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      MixedTextMath(
                        hintOrPointText,
                        forceTex: true,
                        labelStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        mathStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      // 詳細を読むボタン
                      if (_hasDetailedExplanation(problem)) ...[
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _showDetailedExplanation = !_showDetailedExplanation;
                            });
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            backgroundColor: Colors.blue[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            _showDetailedExplanation ? l10n.hideDetails : l10n.showDetails,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
              // 詳細解説表示
              if (_showDetailedExplanation && detailedExplanationTex.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...detailedExplanationTex.map((tex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: MixedTextMath(
                            tex,
                            forceTex: true,
                            labelStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            mathStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
              CongruenceCalculator(
                key: ValueKey('calc_${_currentProblemIndex}'),
                onEnter: _handleAnswer,
                isAnswered: _isAnswered,
                onNext: _isAnswered ? _nextProblem : null,
                nextButtonText: _currentProblemIndex < _selectedProblems.length - 1
                    ? l10n.next
                    : l10n.complete,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildScratchPaperModeBody(CongruenceProblem problem, String correctAnswer, List<CongruenceProblem> remainingProblems, int remainingCount) {
    final l10n = AppLocalizations.of(context)!;
    final hintOrPointText = _getLocalizedShortExplanation(problem);
    final detailedExplanationTex = _getLocalizedDetailedExplanationTex(problem);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            // 横長カード（ヘッダーの下に配置）
            Container(
              width: double.infinity,
              height: 120,
              margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: _isAnswered
                    ? (_isCorrect ? Colors.green.shade50 : Colors.red.shade50)
                    : Colors.white,
                border: Border.all(
                  color: _isAnswered
                      ? (_isCorrect ? Colors.green.shade400 : Colors.red.shade400)
                      : Colors.grey.shade300,
                  width: _isAnswered ? 3 : 2,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _isAnswered
                        ? (_isCorrect ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3))
                        : Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: _buildTwoLineCongruenceSmall(
                            problem.question,
                            equation: problem.equation,
                            conditions: problem.conditions,
                          ),
                        ),
                      ),
                      if (_isAnswered)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Icon(
                            _isCorrect ? Icons.check_circle : Icons.cancel,
                            size: 24,
                            color: _isCorrect 
                                ? Colors.green.shade700
                                : Colors.red.shade700,
                          ),
                        ),
                    ],
                  ),
                  // 次へボタン（解答後に表示）
                  if (_isAnswered)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _nextProblem,
                          icon: const Icon(Icons.arrow_forward, size: 20),
                          label: Text(
                            _currentProblemIndex < _selectedProblems.length - 1
                                ? l10n.next
                                : l10n.complete,
                            style: const TextStyle(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // ヒント表示（オプション）
            if (_showHint && hintOrPointText != null && hintOrPointText.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.hintLabelTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    MixedTextMath(
                      hintOrPointText,
                      forceTex: true,
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      mathStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            // shortExplanation表示（解答後に自動表示、カードの下と電卓の間）
            if (_isAnswered && hintOrPointText != null && hintOrPointText.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
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
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                      MixedTextMath(
                      hintOrPointText,
                        forceTex: true,
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        mathStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                      ),
                    ),
                    // 詳細を読むボタン
                    if (_hasDetailedExplanation(problem)) ...[
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _showDetailedExplanation = !_showDetailedExplanation;
                          });
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          backgroundColor: Colors.blue[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          _showDetailedExplanation ? l10n.hideDetails : l10n.showDetails,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
            // 詳細解説表示（スクロール可能）
            if (_showDetailedExplanation && detailedExplanationTex.isNotEmpty) ...[
              Flexible(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
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
                        ...detailedExplanationTex.map((tex) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: MixedTextMath(
                              tex,
                              forceTex: true,
                              labelStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              mathStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            // 電卓（折りたたみ/展開可能）
            ExpandableCalculatorWrapper(
              isExpanded: _isCalculatorExpanded,
              onToggle: () {
                setState(() {
                  _isCalculatorExpanded = !_isCalculatorExpanded;
                });
              },
              calculator: CongruenceCalculator(
                key: ValueKey('calc_${_currentProblemIndex}'),
                onEnter: _handleAnswer,
                isAnswered: _isAnswered,
                onNext: _isAnswered ? _nextProblem : null,
                nextButtonText: _currentProblemIndex < _selectedProblems.length - 1
                    ? l10n.next
                    : l10n.complete,
              ),
            ),
            // 計算用紙スペース
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: RepaintBoundary(
                  key: _paintKey,
                  child: _buildScrollableCanvas(),
                ),
              ),
            ),
          ],
        ),
        // ドラッグ可能なツールボタン（iPadの場合は非表示）
        if (_isScratchPaperMode && !isIPad(context)) ...[
          DraggablePenButton(
            position: _penButtonPosition,
            isSelected: !_isEraser && !_isScrollMode,
            currentColor: _currentColor,
            currentStrokeWidth: _currentStrokeWidth,
            onPositionChanged: (newPosition) {
              if (_penButtonPosition != newPosition) {
                setState(() {
                  _penButtonPosition = newPosition;
                });
              }
            },
            onPenModeChanged: () {
              setState(() {
                _isEraser = false;
                _isScrollMode = false;
              });
              _activeToolNotifier.value = 'pen';
            },
            onColorChanged: (color) {
              setState(() {
                _currentColor = color;
              });
            },
            onStrokeWidthChanged: (width) {
              setState(() {
                _currentStrokeWidth = width;
              });
            },
            activeToolNotifier: _activeToolNotifier,
            isDrawingNotifier: _isDrawingNotifier,
          ),
          DraggableEraserButton(
            isSelected: _isEraser && !_isScrollMode,
            onTap: () {
              setState(() {
                _isEraser = !_isEraser;
                _isScrollMode = false;
              });
              _activeToolNotifier.value = _isEraser ? 'eraser' : 'pen';
            },
          ),
          DraggableScrollButton(
            isSelected: _isScrollMode,
            onTap: () {
              setState(() {
                _isScrollMode = !_isScrollMode;
                _isEraser = false;
              });
              _activeToolNotifier.value = _isScrollMode ? 'scroll' : 'pen';
            },
          ),
        ],
      ],
    );
  }
}

