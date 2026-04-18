// lib/pages/gacha_page.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/math_problem.dart';
import '../../models/learning_status.dart';
import '../../utils/l10n_utils.dart';
import '../../services/problems/simple_data_manager.dart';
import '../../widgets/gacha/problem_card.dart';
import '../../widgets/gacha/physics_math_case_display.dart';
import '../../widgets/home/background_image_widget.dart';
import '../../widgets/common/back_button.dart' as custom;
import '../../managers/timer_manager.dart';
import '../../widgets/timer/timer_display.dart';
import '../../widgets/timer/timer_toggle.dart';
import '../common/common.dart' show categorizeKeywords4Groups, filterProblemsByKeywords, MixedTextMath;
import '../other/scratch_paper_page.dart';
import '../../utils/l10n_utils.dart';
import 'gacha_settings_page.dart' show GachaFilterMode, GachaFilterModeExt, GachaFilterModeFactory, GachaSettingsPage, kGachaDisplayOrder;
import '../../utils/navigation_utils.dart' show navigateToProblemList;
import '../../problems/all_problems.dart';
import '../../widgets/gacha/filter_chips.dart' show GachaExclusionFilterWidget;
import '../../utils/progress_display_utils.dart' show getTotalProblemCount;
import '../../l10n/app_localizations.dart';
import '../../utils/problem_level_utils.dart';

/// ============================================================================
/// Gacha page — キャッシュ系処理を完全に排除し、スクロール操作性を最優先にした版
/// - RepaintBoundary / precacheImage / KeyedSubtree 等は除去
/// - ブロック数式は横スクロールで表示（SingleChildScrollView）
// — インライン数式は行内で行幅に合うよう ConstrainedBox + FittedBox(scaleDown)
/// - 数式ウィジェットは毎回新規生成
/// ============================================================================

// LearningStatus列挙型は削除し、LearningStatusを使用

// 古い関数は削除し、LearningStatusの拡張メソッドを使用

// 丸バッジを共通で使う（集計表示と揃える）
Widget _statusBadgeSmall(LearningStatus status, {double diameter = 18.0}) {
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

const int _slotCount = 3;

const List<ProblemLevel> _gachaLevelOrder = [
  ProblemLevel.easy,
  ProblemLevel.mid,
  ProblemLevel.advanced,
];

/// スロットが取りうる状態
enum ProblemStatus { none, solved, understood, failed }


ProblemStatus _keyToStatus(String k) {
  switch (k) {
    case 'solved':
      return ProblemStatus.solved;
    case 'understood':
      return ProblemStatus.understood;
    case 'failed':
      return ProblemStatus.failed;
    default:
      return ProblemStatus.none;
  }
}

ProblemLevel _slotLevelFromIndex(int index) {
  if (index < 0 || index >= _gachaLevelOrder.length) {
    return ProblemLevel.easy;
  }
  return _gachaLevelOrder[index];
}

bool _problemMatchesLevel(BuildContext context, MathProblem p, ProblemLevel target) {
  final localized = p.getLocalizedLevel(context);
  final parsed = parseProblemLevel(localized) ?? parseProblemLevel(p.level);
  return parsed == target;
}

/// ---------------------------------------------------------------------------
/// AutoScrollIfOverflow — KeyedSubtree を使わずに測定/横スクロールを行う
/// ---------------------------------------------------------------------------
class AutoScrollIfOverflow extends StatefulWidget {
  final Widget child;
  final bool centerWhenNotOverflow;
  final EdgeInsetsGeometry? padding;

  const AutoScrollIfOverflow({
    required this.child,
    this.centerWhenNotOverflow = true,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  _AutoScrollIfOverflowState createState() => _AutoScrollIfOverflowState();
}

class _AutoScrollIfOverflowState extends State<AutoScrollIfOverflow> {
  final GlobalKey _childKey = GlobalKey();
  bool _overflow = false;
  double _measuredWidth = 0;
  double _lastMaxWidth = double.nan;
  bool _pendingScheduled = false;

  void _scheduleCheck(double maxWidth) {
    if (_pendingScheduled) return;
    _pendingScheduled = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pendingScheduled = false;
      final ctx = _childKey.currentContext;
      if (ctx == null) return;
      final rb = ctx.findRenderObject();
      if (rb is! RenderBox) return;
      final w = rb.size.width;
      final newOverflow = maxWidth.isFinite && w > maxWidth - 1.0;
      
      // スクロール位置を保持するため、setStateの頻度を制限
      final shouldUpdate = newOverflow != _overflow || w != _measuredWidth || maxWidth != _lastMaxWidth;
      if (shouldUpdate && mounted) {
        // スクロール位置を保持するため、setStateを遅延実行
        Future.microtask(() {
          if (mounted) {
            setState(() {
              _overflow = newOverflow;
              _measuredWidth = w;
              _lastMaxWidth = maxWidth;
            });
          }
        });
      }

      // Math.tex の遅延レイアウト対策で一度だけ再チェック
      if (!_pendingScheduled && (_lastMaxWidth == maxWidth)) {
        _pendingScheduled = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _pendingScheduled = false;
          final ctx2 = _childKey.currentContext;
          if (ctx2 == null) return;
          final rb2 = ctx2.findRenderObject();
          if (rb2 is! RenderBox) return;
          final w2 = rb2.size.width;
          final newOverflow2 = maxWidth.isFinite && w2 > maxWidth - 1.0;
          final shouldUpdate2 = newOverflow2 != _overflow || w2 != _measuredWidth;
          if (shouldUpdate2 && mounted) {
            // スクロール位置を保持するため、setStateを遅延実行
            Future.microtask(() {
              if (mounted) {
                setState(() {
                  _overflow = newOverflow2;
                  _measuredWidth = w2;
                  _lastMaxWidth = maxWidth;
                });
              }
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final maxW = constraints.hasBoundedWidth ? constraints.maxWidth : double.infinity;
      _scheduleCheck(maxW);

      final child = Container(
        key: _childKey,
        padding: widget.padding ?? EdgeInsets.zero,
        child: widget.child,
      );

      if (_overflow) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          child: child,
        );
      } else {
        return widget.centerWhenNotOverflow ? Center(child: child) : child;
      }
    });
  }
}

/// ---------------------------------------------------------------------------
/// GachaPage / Settings — 主要ロジックは元と同じ、ただしキャッシュ処理は一切なし
/// ---------------------------------------------------------------------------
class GachaPage extends StatefulWidget {
  final List<MathProblem> problemPool; // ← 追加
  final String title; // ← 追加（AppBarのタイトル）
  final String prefsPrefix; // ← 追加（SharedPreferencesのキー接頭辞）

  const GachaPage({
    Key? key,
    required this.problemPool,
    this.title = '',
    this.prefsPrefix = 'integral', // 既存の動作と互換をとるデフォルト
  }) : super(key: key);

  @override
  State<GachaPage> createState() => _GachaPageState();
}

class _GachaPageState extends State<GachaPage> {
  final _rand = Random();

  final List<MathProblem?> _current = [null, null, null];
  final List<bool> _showAnswer = [false, false, false];
  final List<bool> _showHint = [false, false, false];
  bool _isRolling = false;

  
  // 計算用紙で学習記録を登録した問題を追跡
  final Set<String> _scratchPaperRecordedProblems = {};
  
  // 学習記録ボタンが押された時に計算用紙ボタンを明るくするための状態
  final List<bool> _shouldHighlightScratchPaperButton = [false, false, false];
  
  // 学習記録のキャッシュ（除外判定用）
  final Map<String, ProblemStatus> _learningStatusCache = {};

  late GachaFilterMode _gachaFilterMode = GachaFilterMode.random;
  List<int> _slotLevels = [0, 1, 2];
  
  // 微分方程式ガチャ用：キーワード選択（複数選択可能）
  Set<String> _selectedKeywords = {};
  // キーワード選択UIの折りたたみ状態
  bool _isKeywordSelectorExpanded = false;

  // SimpleDataManagerに統一されたため、古いマップは不要
  // Map<String, dynamic> _problemStatuses = {};

  final List<ValueNotifier<ProblemStatus>> _pendingNotifiers =
      List.generate(3, (_) => ValueNotifier<ProblemStatus>(ProblemStatus.none));

  // instance-specific prefs keys
  // SimpleDataManagerに統一されたため、古いキーは不要

  final ScrollController _scrollController = ScrollController();
  final FocusNode _noFocusNode = FocusNode(skipTraversal: true, canRequestFocus: false);
  
  // スクロール位置保持のための追加
  double _savedScrollPosition = 0.0;
  bool _isContentUpdating = false;

  // タイマー関連（タイマーマネージャーを使用）
  final TimerManager _timerManager = TimerManager();


  bool _isInitialized = false;
  
  AppLocalizations get l10n => AppLocalizations.of(context)!;

  bool get _allCardsNull =>
      _current[0] == null && _current[1] == null && _current[2] == null;

  bool get _isBootstrapping => !_isInitialized || _isContentUpdating;

  bool get _shouldShowAllProblemsSolved =>
      _allCardsNull && !_isBootstrapping && !_isRolling;

  @override
  void initState() {
    super.initState();
    
    // ウィジェットがマージされた後に実行されるようにスケジュール
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.title.isEmpty) {
        setState(() {
          // titleはGachaPageのフィールドなので直接変更不可。
          // 代わりにローカル変数を使用するか、widget.titleを使わないようにする。
          // ここではwidget.titleが空の場合の表示ロジックをbuildで行う。
        });
      }
    });

    // initialise instance-local preference keys from widget.prefsPrefix
    final prefix = widget.prefsPrefix;
    // SimpleDataManagerに統一されたため、古いキーは不要

    // タイマーマネージャーのリスナーを設定
    _timerManager.isTimerEnabledNotifier.addListener(_onTimerStateChanged);
    _timerManager.isTimerRunningNotifier.addListener(_onTimerStateChanged);
    _timerManager.remainingSecondsNotifier.addListener(_onTimerStateChanged);
    
    // タイマー終了時のコールバックを設定
    _timerManager.onTimerFinished = () {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.timerFinished),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    };

    _initAsync();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 初回の初期化後、ページが再表示される時に設定を再読み込み
    if (_isInitialized) {
      _reloadSettings();
    }
  }

  void _onTimerStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _reloadSettings() async {
    // 設定を再読み込み
    await _loadGachaFilterMode();
    await _loadSlotLevels();
    if (widget.prefsPrefix == 'physics_math') {
      await _loadSelectedKeywords();
    }
    // 設定が変更された可能性があるので、問題を再描画
    await _drawInitial();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _noFocusNode.dispose();
    for (final n in _pendingNotifiers) n.dispose();
    // タイマーマネージャーのリスナーは削除しない（他のページでも使用するため）
    super.dispose();
  }

  Future<void> _initAsync() async {
    // SimpleDataManagerに統一されたため、古いロードは不要
    await _loadGachaFilterMode();
    await _loadSlotLevels();
    if (widget.prefsPrefix == 'physics_math') {
      await _loadSelectedKeywords();
    }
    await _loadTimerSettings();
    await _drawInitial();
    if (!mounted) return;
    setState(() {
      _isInitialized = true;
    });
  }

  // 微分方程式ガチャ用：キーワード一覧を取得
  List<String> _getKeywords() {
    final keywords = <String>{};
    for (final p in widget.problemPool) {
      if (p.keywords.isNotEmpty) {
        keywords.addAll(p.keywords);
      }
    }
    // 「その他」キーワードを除外
    keywords.remove('その他');
    // 「共振」キーワードを除外
    keywords.remove('共振');
    return keywords.toList()..sort();
  }
  
  // 共通関数を使用するため、ローカル関数は削除
  
  // 微分方程式ガチャ用：選択されたキーワードを読み込み
  Future<void> _loadSelectedKeywords() async {
    final settings = await SimpleDataManager.getGachaSettings(widget.prefsPrefix);
    final keywordsList = settings['selectedKeywords'] as List<dynamic>?;
    if (keywordsList != null && keywordsList.isNotEmpty) {
          _selectedKeywords = keywordsList.cast<String>().toSet();
          // 存在しないキーワード（「一階斉次」など）を削除
          _selectedKeywords.remove('一階斉次');
          _selectedKeywords.remove('斉次');
          _selectedKeywords.remove('非斉次');
          // 「その他」キーワードを削除（廃止）
          _selectedKeywords.remove('その他');
          // 「共振」キーワードを削除（廃止）
          _selectedKeywords.remove('共振');
          // 存在するキーワードのみを保持（現在の問題から実際に使われているキーワードのみ）
          final validKeywords = _getKeywords().toSet();
          _selectedKeywords = _selectedKeywords.intersection(validKeywords);
          // もし有効なキーワードが残っていない場合は、デフォルト設定を使用（数値と等加速度直線運動）
          if (_selectedKeywords.isEmpty) {
            _selectedKeywords = {'数値', '等加速度直線運動'};
          }
      // 変更があれば保存
      await _saveSelectedKeywords();
    } else {
      // 旧形式（カテゴリー）からの移行
      final categoriesList = settings['selectedCategories'] as List<dynamic>?;
      if (categoriesList != null && categoriesList.isNotEmpty) {
        _selectedKeywords = categoriesList.cast<String>().toSet();
        // 「その他」キーワードを削除（廃止）
        _selectedKeywords.remove('その他');
        // 存在しないキーワードを削除
          final validKeywords = _getKeywords().toSet();
          _selectedKeywords = _selectedKeywords.intersection(validKeywords);
          if (_selectedKeywords.isEmpty) {
            _selectedKeywords = {'数値', '等加速度直線運動'};
          }
        await _saveSelectedKeywords();
      } else {
        final oldCategory = settings['selectedCategory'] as String?;
        if (oldCategory != null) {
          _selectedKeywords = {oldCategory};
          final validKeywords = _getKeywords().toSet();
          _selectedKeywords = _selectedKeywords.intersection(validKeywords);
          if (_selectedKeywords.isEmpty) {
            _selectedKeywords = {'数値', '等加速度直線運動'};
          }
          await _saveSelectedKeywords();
        } else {
          // デフォルト設定：数値と等加速度直線運動
          _selectedKeywords = {'数値', '等加速度直線運動'};
          // デフォルト設定を保存
          await _saveSelectedKeywords();
        }
      }
    }
    if (!mounted) return;
    setState(() {});
  }
  
  // 微分方程式ガチャ用：選択されたキーワードを保存
  Future<void> _saveSelectedKeywords() async {
    final settings = await SimpleDataManager.getGachaSettings(widget.prefsPrefix);
    if (_selectedKeywords.isNotEmpty) {
      settings['selectedKeywords'] = _selectedKeywords.toList();
    } else {
      settings.remove('selectedKeywords');
    }
    // 旧形式も削除
    settings.remove('selectedCategories');
    settings.remove('selectedCategory');
    await SimpleDataManager.saveGachaSettings(widget.prefsPrefix, settings);
  }
  
  // スクロール位置を保存するメソッド
  void _saveScrollPosition() {
    if (_scrollController.hasClients) {
      _savedScrollPosition = _scrollController.offset;
    }
  }
  
  // スクロール位置を復元するメソッド
  void _restoreScrollPosition() {
    if (_scrollController.hasClients && _savedScrollPosition > 0) {
      // 複数回のコールバックで確実に復元する
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_savedScrollPosition);
        }
        // LaTeXレンダリング完了後に再度復元
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(_savedScrollPosition);
          }
        });
      });
    }
  }

  Future<void> _loadSlotLevels() async {
    // SimpleDataManagerからスロットレベルを読み込み
    final settings = await SimpleDataManager.getGachaSettings(widget.prefsPrefix);
    final slotLevels = settings['slotLevels'] as List<dynamic>?;
    if (slotLevels != null && slotLevels.length >= 3) {
      _slotLevels = slotLevels.cast<int>();
    } else {
      // デフォルト設定
      if (widget.prefsPrefix == 'limit') {
        _slotLevels = [1, 1, 2];
      } else {
        _slotLevels = [0, 1, 2];
      }
    }
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _saveSlotLevels() async {
    // SimpleDataManagerにスロットレベルを保存
    final settings = await SimpleDataManager.getGachaSettings(widget.prefsPrefix);
    settings['slotLevels'] = _slotLevels;
    await SimpleDataManager.saveGachaSettings(widget.prefsPrefix, settings);
  }

  Future<void> _loadGachaFilterMode() async {
    // SimpleDataManagerからフィルタモードを読み込み
    final settings = await SimpleDataManager.getGachaSettings(widget.prefsPrefix);
    final filterMode = settings['filterMode'] as String?;
    switch (filterMode) {
      case 'random':
        _gachaFilterMode = GachaFilterMode.random;
        break;
      case 'exclude_solved':
        _gachaFilterMode = GachaFilterMode.excludeSolved;
        break;
      case 'exclude_solved_ge1':
        _gachaFilterMode = GachaFilterMode.excludeSolvedGE1;
        break;
      case 'exclude_solved_ge2':
        _gachaFilterMode = GachaFilterMode.excludeSolvedGE2;
        break;
      case 'exclude_solved_ge3':
        _gachaFilterMode = GachaFilterMode.excludeSolvedGE3;
        break;
      case 'only_unsolved':
        _gachaFilterMode = GachaFilterMode.onlyUnsolved;
        break;
      default:
        _gachaFilterMode = GachaFilterMode.random;
        break;
    }
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _saveGachaFilterMode() async {
    // SimpleDataManagerにフィルタモードを保存
    final settings = await SimpleDataManager.getGachaSettings(widget.prefsPrefix);
    switch (_gachaFilterMode) {
      case GachaFilterMode.random:
        settings['filterMode'] = 'random';
        break;
      case GachaFilterMode.excludeSolved:
        settings['filterMode'] = 'exclude_solved';
        break;
      case GachaFilterMode.excludeSolvedGE1:
        settings['filterMode'] = 'exclude_solved_ge1';
        break;
      case GachaFilterMode.excludeSolvedGE2:
        settings['filterMode'] = 'exclude_solved_ge2';
        break;
      case GachaFilterMode.excludeSolvedGE3:
        settings['filterMode'] = 'exclude_solved_ge3';
        break;
      case GachaFilterMode.onlyUnsolved:
        settings['filterMode'] = 'only_unsolved';
        break;
    }
    await SimpleDataManager.saveGachaSettings(widget.prefsPrefix, settings);
  }

  // タイマー設定を読み込み
  Future<void> _loadTimerSettings() async {
    await _timerManager.loadTimerSettings(widget.prefsPrefix);
    if (!mounted) return;
    setState(() {});
  }


  // SimpleDataManagerに統一されたため、古いロードメソッドは不要



  String _problemKey(MathProblem p) => p.id;
  
  // 問題一覧の学習記録データを取得（積分ガチャと同じロジック）
  Future<List<Map<String, dynamic>>> _getSlotsForProblem(MathProblem p) async {
    // SimpleDataManagerから学習履歴を取得
    final history = await SimpleDataManager.getLearningHistory(p);
    
    final slots = <Map<String, dynamic>>[];
    
    // 履歴を逆順にして、最新の記録を左から表示
    final reversedHistory = history.reversed.toList();
    
    for (var i = 0; i < _slotCount; i++) {
      if (i < reversedHistory.length) {
        final h = reversedHistory[i];
        final status = ProblemStatus.values.firstWhere(
          (s) => s.name == h['status'],
          orElse: () => ProblemStatus.none,
        );
        final timeStr = h['time'] as String?;
        DateTime? dt;
        if (timeStr != null) {
          try {
            dt = DateTime.parse(timeStr);
          } catch (_) {
            dt = null;
          }
        }
        slots.add({'status': status, 'time': dt});
      } else {
        slots.add({'status': ProblemStatus.none, 'time': null});
      }
    }
    return slots;
  }
  
  Future<void> _saveProblemStatuses() async {
    final prefs = await SharedPreferences.getInstance();
    // SimpleDataManagerに統一されたため、古い保存方法は不要
  }



  // 問題一覧の学習記録データを使用して除外判定を行う（積分ガチャと同じロジック）
  Future<bool> _shouldExcludeProblem(MathProblem p) async {
    if (_gachaFilterMode == GachaFilterMode.random) return false;
    
    try {
      // SimpleDataManagerから学習記録データを取得（タイムアウト付き）
      final slots = await _getSlotsForProblem(p).timeout(
        const Duration(seconds: 3),
        onTimeout: () {
          print('Timeout getting slots for problem ${p.id}, not excluding');
          // タイムアウト時は除外しない（安全側に倒す）
          return <Map<String, dynamic>>[
            {'status': ProblemStatus.none, 'time': null},
            {'status': ProblemStatus.none, 'time': null},
            {'status': ProblemStatus.none, 'time': null},
          ];
        },
      );
      
      int needed;
      switch (_gachaFilterMode) {
        case GachaFilterMode.excludeSolvedGE1:
          needed = 1;
          break;
        case GachaFilterMode.excludeSolvedGE2:
          needed = 2;
          break;
        case GachaFilterMode.excludeSolvedGE3:
          needed = 3;
          break;
        case GachaFilterMode.random:
        default:
          return false;
      }

      // newest to oldest, collect non-none
      final nonNone = <ProblemStatus>[];
      for (var i = slots.length - 1; i >= 0; i--) {
        final st = slots[i]['status'] as ProblemStatus? ?? ProblemStatus.none;
        if (st != ProblemStatus.none) nonNone.add(st);
      }

      // 最新から見て、緑が連続して何個並んでいるかを数える
      int consecutiveSolved = 0;
      for (final status in nonNone) {
        if (status == ProblemStatus.solved) {
          consecutiveSolved++;
        } else {
          // 緑以外が来たら連続が途切れる
          break;
        }
      }

      // 連続数がneeded以上なら除外
      return consecutiveSolved >= needed;
    } catch (e) {
      print('Error in _shouldExcludeProblem for ${p.id}: $e');
      // エラー時は除外しない（安全側に倒す）
      return false;
    }
  }

  Map<int, MathProblem?> _assignSlotsPreferEarly(Map<int, List<MathProblem>> candidatesPerSlot) {
    final assigned = <int, MathProblem?>{0: null, 1: null, 2: null};

    final uniqueMap = <String, MathProblem>{};
    for (final pool in candidatesPerSlot.values) {
      for (final p in pool) {
        uniqueMap[_problemKey(p)] = p;
      }
    }

    final uniqueCount = uniqueMap.length;

    if (uniqueCount > 0 && uniqueCount <= _slotCount) {
      final used = <String>{};
      for (var i = 0; i < _slotCount; i++) {
        final pool = candidatesPerSlot[i] ?? [];
        MathProblem? pick;
        for (final p in pool) {
          final k = _problemKey(p);
          if (!used.contains(k)) {
            pick = p;
            break;
          }
        }
        if (pick != null) {
          assigned[i] = pick;
          used.add(_problemKey(pick));
        } else {
          assigned[i] = null;
        }
      }
      return assigned;
    }

    final usedKeys = <String>{};
    for (var i = 0; i < _slotCount; i++) {
      final pool = candidatesPerSlot[i] ?? [];
      final available = pool.where((p) => !usedKeys.contains(_problemKey(p))).toList();
      if (available.isNotEmpty) {
        final pick = available[_rand.nextInt(available.length)];
        assigned[i] = pick;
        usedKeys.add(_problemKey(pick));
      } else {
        assigned[i] = null;
      }
    }

    final usage = <String, int>{};
    for (final v in assigned.values) {
      if (v != null) {
        final k = _problemKey(v);
        usage[k] = (usage[k] ?? 0) + 1;
      }
    }

    for (var i = 0; i < _slotCount; i++) {
      if (assigned[i] != null) continue;
      final pool = candidatesPerSlot[i] ?? [];
      if (pool.isEmpty) {
        assigned[i] = null;
        continue;
      }
      var minUsage = 1 << 30;
      final cands = <MathProblem>[];
      for (final p in pool) {
        final k = _problemKey(p);
        final u = usage[k] ?? 0;
        if (u < minUsage) {
          minUsage = u;
          cands.clear();
          cands.add(p);
        } else if (u == minUsage) {
          cands.add(p);
        }
      }
      if (cands.isNotEmpty) {
        final pick = cands[_rand.nextInt(cands.length)];
        assigned[i] = pick;
        final pk = _problemKey(pick);
        usage[pk] = (usage[pk] ?? 0) + 1;
      }
    }

    return assigned;
  }

  Future<void> _drawInitial() async {
    _saveScrollPosition();
    if (mounted) {
      setState(() {
        _isContentUpdating = true;
      });
    } else {
      _isContentUpdating = true;
    }
    
    // 有料オプション購入状態を確認
    final isPremium = await SimpleDataManager.isPremiumPurchased();
    
    // 微分方程式ガチャの場合はキーワードベースで3問ランダムに選ぶ（level分類なし）
    if (widget.prefsPrefix == 'physics_math') {
          // キーワードベースのフィルタリング（グループ内OR、グループ間AND）
          final targetProblems = filterProblemsByKeywords(widget.problemPool, _selectedKeywords);
          
          // フィルタリングを非同期で実行
          final filteredProblems = <MathProblem>[];
          for (final p in targetProblems) {
            // 予備問題は廃止されたため、除外する
            final no = p.no;
            final isReserveProblem = no is String && no.startsWith('op');
            if (isReserveProblem) {
              continue;
            }
            
            final shouldExclude = await _shouldExcludeProblem(p);
            if (!shouldExclude) {
              filteredProblems.add(p);
            }
          }
      
      // フィルタリング後の問題数が0の場合は全てnullに設定
      if (filteredProblems.isEmpty) {
        for (var i = 0; i < 3; i++) {
          _current[i] = null;
          _showAnswer[i] = false;
          _showHint[i] = false;
          _pendingNotifiers[i].value = ProblemStatus.none;
        }
      } else {
        // 3問ランダムに選ぶ
        filteredProblems.shuffle(_rand);
        final selected = filteredProblems.take(3).toList();
        
        for (var i = 0; i < 3; i++) {
          _current[i] = i < selected.length ? selected[i] : null;
          _showAnswer[i] = false;
          _showHint[i] = false;
          _pendingNotifiers[i].value = ProblemStatus.none;
        }
      }
    } else {
      // 通常のlevelベースの処理（他のガチャ）
      // 予備問題は廃止されたため、除外する
      final mainProblems = widget.problemPool.where((p) {
        final no = p.no;
        final isReserveProblem = no is String && no.startsWith('op');
        if (isReserveProblem) {
          return false;
        }
        return true;
      }).toList();
      final cand = <int, List<MathProblem>>{};
      for (var i = 0; i < 3; i++) {
        final levelIndex = (i < _slotLevels.length) ? _slotLevels[i] : 0;
        final slotLevel = _slotLevelFromIndex(levelIndex);
        final levelProblems = mainProblems.where((p) => _problemMatchesLevel(context, p, slotLevel)).toList();
        
        // フィルタリングを非同期で実行
        final filteredProblems = <MathProblem>[];
        for (final p in levelProblems) {
          final shouldExclude = await _shouldExcludeProblem(p);
          if (!shouldExclude) {
            filteredProblems.add(p);
          }
        }
        
        cand[i] = filteredProblems;
      }

      // 全てのスロットでフィルタリング後の問題数が0かチェック
      bool allEmpty = true;
      for (var i = 0; i < 3; i++) {
        if (cand[i]?.isNotEmpty ?? false) {
          allEmpty = false;
          break;
        }
      }
      
      if (allEmpty) {
        // 全てのスロットで問題がない場合は全てnullに設定
        for (var i = 0; i < 3; i++) {
          _current[i] = null;
          _showAnswer[i] = false;
          _showHint[i] = false;
          _pendingNotifiers[i].value = ProblemStatus.none;
        }
      } else {
        final assigned = _assignSlotsPreferEarly(cand);

        // カード3枚をシャッフル（難易度ネタバレ防止）
        final shuffled = [assigned[0], assigned[1], assigned[2]]..shuffle(_rand);

        for (var i = 0; i < 3; i++) {
          _current[i] = shuffled[i];
          _showAnswer[i] = false;
          _showHint[i] = false;
          _pendingNotifiers[i].value = ProblemStatus.none;
        }
      }
    }

    if (!mounted) return;

    setState(() {
      _isContentUpdating = false;
    });
    
    // レンダリング完了後にスクロール位置を復元
    _restoreScrollPosition();
  }

  Future<void> _rollAll() async {
    if (_isRolling) return;
    
    _saveScrollPosition();
    
    setState(() {
      _isRolling = true;
      for (var i = 0; i < 3; i++) {
        _showAnswer[i] = false;
        _showHint[i] = false;
      }
    });

    // 有料オプション購入状態を確認
    final isPremium = await SimpleDataManager.isPremiumPurchased();
    
    const iterations = 12;
    for (var t = 0; t < iterations; t++) {
      if (t < iterations - 1) {
        // 微分方程式ガチャの場合はキーワードベース（level分類なし）
        if (widget.prefsPrefix == 'physics_math') {
          // キーワードベースのフィルタリング（グループ内OR、グループ間AND）
          final targetProblems = filterProblemsByKeywords(widget.problemPool, _selectedKeywords);
          
          // フィルタリングを非同期で実行
          final filteredProblems = <MathProblem>[];
          for (final p in targetProblems) {
            // 予備問題は廃止されたため、除外する
            final no = p.no;
            final isReserveProblem = no is String && no.startsWith('op');
            if (isReserveProblem) {
              continue;
            }
            
            final shouldExclude = await _shouldExcludeProblem(p);
            if (!shouldExclude) {
              filteredProblems.add(p);
            }
          }
          
          filteredProblems.shuffle(_rand);
          final selected = filteredProblems.take(3).toList();
          
          setState(() {
            for (var i = 0; i < 3; i++) {
              _current[i] = i < selected.length ? selected[i] : null;
              _pendingNotifiers[i].value = ProblemStatus.none;
            }
          });
        } else {
          // 通常のlevelベースの処理
          // 予備問題は廃止されたため、除外する
          final mainProblems = widget.problemPool.where((p) {
            final no = p.no;
            final isReserveProblem = no is String && no.startsWith('op');
            return !isReserveProblem;
          }).toList();
          final candidatesPerSlot = <int, List<MathProblem>>{};
          for (var i = 0; i < 3; i++) {
            final levelIndex = (i < _slotLevels.length) ? _slotLevels[i] : 0;
            final slotLevel = _slotLevelFromIndex(levelIndex);
            final levelProblems = mainProblems.where((p) => _problemMatchesLevel(context, p, slotLevel)).toList();
            
            // フィルタリングを非同期で実行
            final filteredProblems = <MathProblem>[];
            for (final p in levelProblems) {
              final shouldExclude = await _shouldExcludeProblem(p);
              if (!shouldExclude) {
                filteredProblems.add(p);
              }
            }
            
            candidatesPerSlot[i] = filteredProblems;
          }
          
          setState(() {
            for (var i = 0; i < 3; i++) {
              final pool = candidatesPerSlot[i] ?? [];
              if (pool.isEmpty) {
                _current[i] = null;
              } else {
                _current[i] = pool[_rand.nextInt(pool.length)];
              }
              _pendingNotifiers[i].value = ProblemStatus.none;
            }
          });
        }
        await Future.delayed(Duration(milliseconds: 60 + t * 8));
        if (!mounted) return;
      } else {
        // 有料オプション購入状態を確認
        final isPremium = await SimpleDataManager.isPremiumPurchased();
        
        // 微分方程式ガチャの場合はキーワードベース（level分類なし）
        if (widget.prefsPrefix == 'physics_math') {
          // キーワードベースのフィルタリング（グループ内OR、グループ間AND）
          final targetProblems = filterProblemsByKeywords(widget.problemPool, _selectedKeywords);
          
          // フィルタリングを非同期で実行
          final filteredProblems = <MathProblem>[];
          for (final p in targetProblems) {
            // 予備問題は廃止されたため、除外する
            final no = p.no;
            final isReserveProblem = no is String && no.startsWith('op');
            if (isReserveProblem) {
              continue;
            }
            
            final shouldExclude = await _shouldExcludeProblem(p);
            if (!shouldExclude) {
              filteredProblems.add(p);
            }
          }
          
          filteredProblems.shuffle(_rand);
          final selected = filteredProblems.take(3).toList();
          
          final newList = <MathProblem?>[
            selected.isNotEmpty ? selected[0] : null,
            selected.length > 1 ? selected[1] : null,
            selected.length > 2 ? selected[2] : null,
          ];
          if (!mounted) return;
          setState(() => _current.setRange(0, 3, newList));
          for (var i = 0; i < 3; i++) _pendingNotifiers[i].value = ProblemStatus.none;
        } else {
          // 通常のlevelベースの処理
          // 因数分解ガチャの場合はオプション問題も無料で含める
          final isFactorizationGacha = widget.prefsPrefix == 'factorization';
          // 有料オプション購入者でない場合のみ予備問題を除外（因数分解ガチャは除く）
          final mainProblems = (isPremium || isFactorizationGacha)
              ? widget.problemPool
              : widget.problemPool.where((p) {
                  final no = p.no;
                  return !(no is String && no.startsWith('op'));
                }).toList();
          final candidatesPerSlot = <int, List<MathProblem>>{};
          for (var i = 0; i < 3; i++) {
            final levelIndex = (i < _slotLevels.length) ? _slotLevels[i] : 0;
            final slotLevel = _slotLevelFromIndex(levelIndex);
            final levelProblems = mainProblems.where((p) => _problemMatchesLevel(context, p, slotLevel)).toList();
            
            // フィルタリングを非同期で実行
            final filteredProblems = <MathProblem>[];
            for (final p in levelProblems) {
              final shouldExclude = await _shouldExcludeProblem(p);
              if (!shouldExclude) {
                filteredProblems.add(p);
              }
            }
            
            candidatesPerSlot[i] = filteredProblems;
          }

          final assigned = _assignSlotsPreferEarly(candidatesPerSlot);
          // カード3枚をシャッフル（難易度ネタバレ防止）
          final shuffled = [assigned[0], assigned[1], assigned[2]]..shuffle(_rand);
          final newList = <MathProblem?>[shuffled[0], shuffled[1], shuffled[2]];
          if (!mounted) return;
          setState(() => _current.setRange(0, 3, newList));
          for (var i = 0; i < 3; i++) _pendingNotifiers[i].value = ProblemStatus.none;
        }
      }
    }

    if (!mounted) return;
    setState(() {
      _isRolling = false;
    });
    for (var i = 0; i < 3; i++) _pendingNotifiers[i].value = ProblemStatus.none;
    
    // ロール完了後にスクロール位置を復元
    _restoreScrollPosition();
  }

  void _toggleAnswer(int idx) {
    setState(() {
      _showAnswer[idx] = !_showAnswer[idx];
    });
  }

  void _toggleHint(int idx) {
    setState(() {
      _showHint[idx] = !_showHint[idx];
    });
  }

  void _showLearningRecordedSnack() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.learningRecordSaved),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _updateLearningStatus(int idx) async {
    // 学習記録の状態を更新
    final problem = _current[idx];
    if (problem != null) {
      final problemKey = _problemKey(problem);
      _scratchPaperRecordedProblems.add(problemKey);
      
      // 最新の学習記録を取得してキャッシュを更新
      final latestStatus = await SimpleDataManager.getLearningRecord(problem);
      final problemStatus = ProblemStatus.values.firstWhere(
        (s) => s.name == latestStatus.name,
        orElse: () => ProblemStatus.none,
      );
      _learningStatusCache[problem.id] = problemStatus;
      
      // 学習記録の履歴も取得
      final history = await SimpleDataManager.getLearningHistory(problem);
      if (history.isNotEmpty) {
        // 最新の履歴からステータスを取得
        final latestHistory = history.last;
        final historyStatus = ProblemStatus.values.firstWhere(
          (s) => s.name == latestHistory['status'],
          orElse: () => ProblemStatus.none,
        );
        _learningStatusCache[problem.id] = historyStatus;
      }
    }
    setState(() {
      // 状態を更新してUIを再描画
    });
  }


  void _cycleLearningStatus(int idx) {
    
    final currentStatus = _pendingNotifiers[idx].value;
    ProblemStatus nextStatus;
    switch (currentStatus) {
      case ProblemStatus.none:
        nextStatus = ProblemStatus.solved;
        break;
      case ProblemStatus.solved:
        nextStatus = ProblemStatus.understood;
        break;
      case ProblemStatus.understood:
        nextStatus = ProblemStatus.failed;
        break;
      case ProblemStatus.failed:
        nextStatus = ProblemStatus.none;
        break;
    }
    _pendingNotifiers[idx].value = nextStatus;
  }

  String _getStatusTooltip(BuildContext context, LearningStatus status) {
    return status.getLocalizedTooltip(context);
  }

  /// 学習記録を保存するメソッド
  /// すべてのガチャ（積分、極限、微分方程式、因数分解、不定方程式）で共通のロジックを使用
  /// 因数分解ガチャ・不定方程式ガチャと同じ実装を踏襲
  Future<void> _saveSingleLearningRecord(int idx) async {
    final problem = _current[idx];
    if (problem == null) {
      print('DEBUG: _saveSingleLearningRecord - problem is null for idx $idx');
      return;
    }
    
    final problemStatus = _pendingNotifiers[idx].value;
    print('DEBUG: _saveSingleLearningRecord - problemStatus: $problemStatus for problem ${problem.id}');
    if (problemStatus == ProblemStatus.none) {
      print('DEBUG: _saveSingleLearningRecord - problemStatus is none, returning');
      return;
    }
    
    print('DEBUG: _saveSingleLearningRecord - problemStatus: $problemStatus');
    
    try {
      // 既存の履歴を取得
      final history = await SimpleDataManager.getLearningHistory(problem);
      final current = <Map<String, dynamic>>[];
      
      // 既存の履歴をスロットに配置
      for (var i = 0; i < _slotCount; i++) {
        if (i < history.length) {
          final h = history[i];
          final status = ProblemStatus.values.firstWhere(
            (s) => s.name == h['status'],
            orElse: () => ProblemStatus.none,
          );
          final timeStr = h['time'] as String?;
          // timeはString形式で保存する必要がある
          current.add({'status': status, 'time': timeStr});
        } else {
          current.add({'status': ProblemStatus.none, 'time': null});
        }
      }
      
      while (current.length < _slotCount) {
        current.add({'status': ProblemStatus.none, 'time': null});
      }
      
      // 最初の空いているスロットを見つける
      int targetSlot = -1;
      for (var i = 0; i < _slotCount; i++) {
        final slotStatus = current[i]['status'] as ProblemStatus? ?? ProblemStatus.none;
        if (slotStatus == ProblemStatus.none) {
          targetSlot = i;
          break;
        }
      }
      
      // すべてのスロットが埋まっている場合は、slot0に上書き
      if (targetSlot == -1) {
        targetSlot = 0;
      }
      
      // 新しい記録をスロットに保存
      final t = DateTime.now().toIso8601String();
      current[targetSlot] = {'status': problemStatus, 'time': t};
      
      // 保存したスロットより後ろをクリア（前詰め制約）
      for (var j = targetSlot + 1; j < current.length; j++) {
        current[j] = {'status': ProblemStatus.none, 'time': null};
      }
      
      // SimpleDataManagerに保存
      final success = await SimpleDataManager.saveLearningHistory(problem, current);
      
      if (success) {
        _scratchPaperRecordedProblems.add(_problemKey(problem));
        
        // キャッシュを更新
        _learningStatusCache[problem.id] = problemStatus;
        
        print('DEBUG: _saveSingleLearningRecord - save successful, showing success message');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.learningRecordSaved),
            duration: const Duration(seconds: 2),
          ),
        );
        
        setState(() {
          // UIを更新
        });
      } else {
        print('DEBUG: _saveSingleLearningRecord - save failed, showing error message');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.learningRecordSaveFailed),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('DEBUG: _saveSingleLearningRecord - exception occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.learningRecordSaveFailed),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<LearningStatus> _getProblemLearningStatus(MathProblem problem) async {
    return await SimpleDataManager.getLearningRecord(problem);
  }
  

  Future<void> _rerollSingle(int idx) async {
    if (_isRolling) return;
    
    List<MathProblem> candidateProblems;
    
    // 微分方程式ガチャの場合はキーワードベースでフィルタリング
    if (widget.prefsPrefix == 'physics_math') {
      candidateProblems = filterProblemsByKeywords(widget.problemPool, _selectedKeywords);
    } else {
      // 通常のlevelベースのフィルタリング
      final levelIndex = (idx < _slotLevels.length) ? _slotLevels[idx] : 0;
      final slotLevel = _slotLevelFromIndex(levelIndex);
      candidateProblems = widget.problemPool.where((p) => _problemMatchesLevel(context, p, slotLevel)).toList();
    }
    
    // 予備問題は廃止されたため、除外する
    candidateProblems = candidateProblems.where((p) {
      final no = p.no;
      final isReserveProblem = no is String && no.startsWith('op');
      if (isReserveProblem) {
        return false;
      }
      return true;
    }).toList();
    
    // フィルタリングを非同期で実行
    final filteredProblems = <MathProblem>[];
    for (final p in candidateProblems) {
      final shouldExclude = await _shouldExcludeProblem(p);
      if (!shouldExclude) {
        filteredProblems.add(p);
      }
    }
    
    if (filteredProblems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(widget.prefsPrefix == 'physics_math'
          ? l10n.noProblems
          : '${_getLocalizedLevelName(context, (idx < _slotLevels.length) ? _slotLevels[idx] : 0)} ${l10n.noProblems}')));
      return;
    }

    final usedKeys = <String>{};
    for (var j = 0; j < 3; j++) {
      if (j == idx) continue;
      final mp = _current[j];
      if (mp != null) usedKeys.add(_problemKey(mp));
    }

    final available = filteredProblems.where((p) => !usedKeys.contains(_problemKey(p))).toList();
    if (available.isNotEmpty) {
      final pick = available[_rand.nextInt(available.length)];
      setState(() {
        _current[idx] = pick;
        _showAnswer[idx] = false;
        _showHint[idx] = false;
      });
      _pendingNotifiers[idx].value = ProblemStatus.none;
      return;
    }

    final usage = <String, int>{};
    for (var j = 0; j < 3; j++) {
      final mp = _current[j];
      if (mp != null) {
        final k = _problemKey(mp);
        usage[k] = (usage[k] ?? 0) + 1;
      }
    }

    var minUsage = 1 << 30;
    final cands = <MathProblem>[];
    // 微分方程式ガチャの場合は、キーワードフィルタリング済みのリストから選ぶ
    for (final p in filteredProblems) {
      final k = _problemKey(p);
      final u = usage[k] ?? 0;
      if (u < minUsage) {
        minUsage = u;
        cands.clear();
        cands.add(p);
      } else if (u == minUsage) {
        cands.add(p);
      }
    }

    final pick = cands[_rand.nextInt(cands.length)];
    setState(() {
      _current[idx] = pick;
      _showAnswer[idx] = false;
    });
    _pendingNotifiers[idx].value = ProblemStatus.none;
  }



  // 微分方程式ガチャ用：キーワード選択UI
  Widget _buildKeywordSelector() {
    final allKeywords = _getKeywords();
    
    // キーワードを分類
    final typeKeywords = <String>[]; // 数値、一般
    final mechanicsKeywords = <String>[]; // 力学系
    final dcacKeywords = <String>[]; // 直流、交流
    final electricalKeywords = <String>[]; // その他の電磁気系
    
    // 分類定義
    const typeList = ['数値', '一般'];
    const mechanicsList = ['等加速度直線運動', '空気抵抗', '単振動'];
    const dcacList = ['直流', '交流', '電圧0']; // グループ3の定義順序に合わせる
    const electricalList = ['コンデンサ', 'コイル', '抵抗'];
    
    for (final keyword in allKeywords) {
      if (typeList.contains(keyword)) {
        typeKeywords.add(keyword);
      } else if (mechanicsList.contains(keyword)) {
        mechanicsKeywords.add(keyword);
      } else if (dcacList.contains(keyword)) {
        dcacKeywords.add(keyword);
      } else if (electricalList.contains(keyword)) {
        electricalKeywords.add(keyword);
      } else {
        // 未分類のキーワードは電気系に追加
        electricalKeywords.add(keyword);
      }
    }
    
    // 指定された順序でソート
    typeKeywords.sort((a, b) => typeList.indexOf(a).compareTo(typeList.indexOf(b)));
    mechanicsKeywords.sort((a, b) => mechanicsList.indexOf(a).compareTo(mechanicsList.indexOf(b)));
    dcacKeywords.sort((a, b) => dcacList.indexOf(a).compareTo(dcacList.indexOf(b)));
    electricalKeywords.sort((a, b) {
      final idxA = electricalList.indexOf(a);
      final idxB = electricalList.indexOf(b);
      if (idxA != -1 && idxB != -1) return idxA.compareTo(idxB);
      if (idxA != -1) return -1;
      if (idxB != -1) return 1;
      return a.compareTo(b);
    });
    
    // フィルタリング結果のカウント
    final filteredCount = filterProblemsByKeywords(widget.problemPool, _selectedKeywords).length;
    final totalCount = widget.problemPool.length;
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ヘッダー部分（常に表示、タップ可能）
          GestureDetector(
            onTap: () {
              setState(() {
                _isKeywordSelectorExpanded = !_isKeywordSelectorExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.label, color: Colors.purple[700], size: 20),
                const SizedBox(width: 8),
                Text(
                  l10n.keywordSelectorTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$filteredCount/$totalCount',
                  style: TextStyle(
                    color: Colors.purple[700],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  _isKeywordSelectorExpanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.purple[700],
                  size: 24,
                ),
              ],
            ),
          ),
          // 展開時のみ表示される内容
          if (_isKeywordSelectorExpanded) ...[
            const SizedBox(height: 8),
            // 数値・一般
            if (typeKeywords.isNotEmpty) ...[
              Wrap(
                spacing: 4,
                runSpacing: 6,
                children: _buildKeywordChips(typeKeywords),
              ),
              const SizedBox(height: 10),
            ],
            // 力学系
            if (mechanicsKeywords.isNotEmpty) ...[
              Wrap(
                spacing: 3,
                runSpacing: 5,
                children: _buildKeywordChips(mechanicsKeywords),
              ),
              const SizedBox(height: 10),
            ],
            // 直流・交流
            if (dcacKeywords.isNotEmpty) ...[
              Wrap(
                spacing: 4,
                runSpacing: 6,
                children: _buildKeywordChips(dcacKeywords),
              ),
              const SizedBox(height: 10),
            ],
            // その他の電磁気系
            if (electricalKeywords.isNotEmpty) ...[
              Wrap(
                spacing: 4,
                runSpacing: 6,
                children: _buildKeywordChips(electricalKeywords),
              ),
            ],
            const SizedBox(height: 8),
            if (_selectedKeywords.isNotEmpty) ...[
              Text(
                l10n.selectedKeywordsLabel(
                  _selectedKeywords.length,
                  _selectedKeywords.map((k) => getLocalizedKeyword(context, k)).join(', '),
                ),
                style: TextStyle(color: Colors.purple[700], fontSize: 14),
              ),
            ] else ...[
              Text(
                l10n.noKeywordsSelected,
                style: TextStyle(color: Colors.grey[600], fontSize: 14, fontStyle: FontStyle.italic),
              ),
            ],
          ],
        ],
      ),
    );
  }
  
  // キーワードチップを生成するヘルパーメソッド
  List<Widget> _buildKeywordChips(List<String> keywords) {
    return keywords.map((keyword) {
      final isSelected = _selectedKeywords.contains(keyword);
      return FilterChip(
        label: Text(getLocalizedKeyword(context, keyword), style: const TextStyle(fontSize: 14)),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            if (selected) {
              _selectedKeywords.add(keyword);
            } else {
              _selectedKeywords.remove(keyword);
            }
          });
          _saveSelectedKeywords();
          _drawInitial();
        },
        selectedColor: Colors.purple.withOpacity(0.4),
        backgroundColor: Colors.grey.shade200,
        checkmarkColor: Colors.transparent, // チェックマークを透明にして非表示
        showCheckmark: false, // チェックマークを表示しない
        labelStyle: TextStyle(
          color: isSelected ? Colors.purple[900] : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }).toList();
  }


  // フィルタリング後の問題数を計算
  Future<int> _getFilteredProblemCount() async {
    List<MathProblem> targetProblems;
    
    // 微分方程式ガチャの場合はキーワードフィルタリング後の問題
    if (widget.prefsPrefix == 'physics_math') {
      targetProblems = filterProblemsByKeywords(widget.problemPool, _selectedKeywords);
    } else {
      targetProblems = widget.problemPool;
    }
    
    // 除外判定を実行
    int count = 0;
    for (final p in targetProblems) {
      final shouldExclude = await _shouldExcludeProblem(p);
      if (!shouldExclude) {
        count++;
      }
    }
    
    return count;
  }
  
  // 全問題数を取得（キーワードフィルタリング後の問題数）
  int _getTotalProblemCount() {
    if (widget.prefsPrefix == 'physics_math') {
      // physics_mathの場合はキーワードフィルタリングを考慮
      return filterProblemsByKeywords(widget.problemPool, _selectedKeywords).length;
    } else {
      // それ以外の場合は共通関数を使用
      return getTotalProblemCount(
        prefsPrefix: widget.prefsPrefix,
        problemPool: widget.problemPool,
      );
    }
  }

  String _getLocalizedLevelName(BuildContext context, int index) {
    final l10n = AppLocalizations.of(context)!;
    switch (index) {
      case 0: return l10n.easy;
      case 1: return l10n.mid;
      case 2: return l10n.advanced;
      default: return l10n.easy;
    }
  }

  // ガチャ本画面に表示するフィルタ説明（設定に合わせて読み取る）
  Widget _buildGachaFilterSummary() {
    final totalCount = _getTotalProblemCount();
    
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
            });
            await _saveGachaFilterMode();
            _drawInitial();
          },
          prefsPrefix: widget.prefsPrefix,
          problemCountText: problemCountText,
          showStatusBadge: _gachaFilterMode != GachaFilterMode.random,
          additionalText: _gachaFilterMode != GachaFilterMode.random ? l10n.removeFromGacha : null,
          iconSize: 26,
        );
      },
    );
  }

  // 難易度設定メニューを表示
  Future<void> _showDifficultyMenu(BuildContext context, int slotIndex, {Offset? position, Size? size}) async {
    final l10n = AppLocalizations.of(context)!;
    final RenderBox? overlay = Overlay.of(context).context.findRenderObject() as RenderBox?;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    if (position == null || size == null || overlay == null) {
      return; // positionが取得できない場合は表示しない
    }
    
    // メニューの幅を適切なサイズに設定（200px程度）
    const menuWidth = 200.0;
    
    // ボタンの位置を基準にメニューの左端を計算
    // ボタンの中央にメニューの中央を合わせる
    double menuLeft = position.dx + (size.width / 2) - (menuWidth / 2);
    
    // 画面外にはみ出さないように調整
    if (menuLeft < 8) {
      menuLeft = 8; // 左端から8px
    } else if (menuLeft + menuWidth > screenWidth - 8) {
      menuLeft = screenWidth - menuWidth - 8; // 右端から8px
    }
    
    // メニューのY位置はボタンの下
    final menuY = position.dy + size.height;
    
    final int? selected = await showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(
        menuLeft, // ボタンの下に配置
        menuY,
        screenWidth - menuLeft - menuWidth, // 右側のマージン
        overlay.size.height - menuY,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      items: List.generate(_gachaLevelOrder.length, (index) {
        final localizedLevel = _getLocalizedLevelName(context, index);
        return PopupMenuItem<int>(
          value: index,
          child: Row(
            children: [
              if (_slotLevels[slotIndex] == index)
                const Icon(Icons.check, size: 20, color: Colors.blue)
              else
                const SizedBox(width: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(localizedLevel, style: TextStyle(fontSize: 14, color: Colors.grey[900])),
              ),
            ],
          ),
        );
      }),
    );

    if (selected != null && selected != _slotLevels[slotIndex]) {
      setState(() {
        _slotLevels[slotIndex] = selected;
      });
      await _saveSlotLevels();
      _drawInitial();
    }
  }

  // 難易度設定をボタンオブジェクトで表示
  Widget _buildDifficultySettings() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF4E6), Color(0xFFFFF9F0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.orange.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.tune,
                  color: Colors.orange[700],
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                l10n.selectDifficultyForEachSlot,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[700],
                ),
              ),
            ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (var i = 0; i < 3; i++) ...[
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final GlobalKey difficultyChipKey = GlobalKey();
                      final levelIndex = _slotLevels[i];
                      String localizedLevel;
                      switch (levelIndex) {
                        case 0: localizedLevel = l10n.easy; break;
                        case 1: localizedLevel = l10n.mid; break;
                        case 2: localizedLevel = l10n.advanced; break;
                        default: localizedLevel = l10n.easy;
                      }
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                        onTap: () {
                          final RenderBox? renderBox = difficultyChipKey.currentContext?.findRenderObject() as RenderBox?;
                          if (renderBox != null) {
                            final position = renderBox.localToGlobal(Offset.zero);
                            final size = renderBox.size;
                            _showDifficultyMenu(context, i, position: position, size: size);
                          } else {
                            _showDifficultyMenu(context, i);
                          }
                        },
                          borderRadius: BorderRadius.circular(12),
                        child: Container(
                          key: difficultyChipKey,
                          margin: EdgeInsets.only(right: i < 2 ? 8 : 0),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.orange.withOpacity(0.3),
                              width: 1,
                            ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      localizedLevel,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange[700],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(Icons.expand_more, size: 18, color: Colors.orange[700]),
                              ],
                            ),
                          ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // タイマー表示ウィジェット
  Widget _buildTimerDisplay() {
    return TimerDisplay(timerManager: _timerManager, focusNode: _noFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景画像（薄く、画面サイズに合わせて4枚周期的に表示）
          Positioned.fill(
            child: const BackgroundImageWidget(),
          ),
          // コンテンツ
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    controller: _scrollController,
                    cacheExtent: 1000.0, // レンダリング時の再計算を最小限にする
                    physics: const ClampingScrollPhysics(), // スクロール位置の保持を改善
                    children: [
                  // タイトル、タイマー、問題一覧ボタンをスクロール可能なコンテンツ内に配置
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0, bottom: 20.0), // ヘッダの矢印部分と被ってもOK
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            widget.title.isEmpty ? l10n.rollGacha : widget.title,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8B7355),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // タイマートグルスイッチ
                        TimerToggle(timerManager: _timerManager),
                        const SizedBox(width: 12),
                        // 問題一覧ボタン
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                            await navigateToProblemList(
                              context: context,
                              problemPool: widget.problemPool,
                              prefsPrefix: widget.prefsPrefix,
                            );
                            // 問題一覧から戻ってきた時に設定を再読み込み
                            if (mounted) {
                              await _loadGachaFilterMode();
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
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: _isRolling ? null : _rollAll,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.blueAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.casino,
                                  size: 28,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                _isRolling ? l10n.rolling : l10n.rollGacha,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // フィルタ設定の説明をここに表示
                  // 微分方程式ガチャの場合はキーワード選択を表示
                  if (widget.prefsPrefix == 'physics_math') ...[
                    _buildKeywordSelector(),
                    const SizedBox(height: 6),
                  ],
                  
                  _buildGachaFilterSummary(),

                  // 難易度設定（フィルタ設定の下に配置、微分方程式ガチャ以外）
                  if (widget.prefsPrefix != 'physics_math') ...[
                    const SizedBox(height: 1.5),
                    _buildDifficultySettings(),
                  ],

                  const SizedBox(height: 30),
                  // タイマー表示（トグルがオンの場合のみ表示）
                  _buildTimerDisplay(),

                  const SizedBox(height: 6),

                  // 全てのカードがnullの場合は完了メッセージを1つだけ表示
                  Builder(
                    builder: (context) {
                      if (_isBootstrapping) {
                        return const Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Center(
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(strokeWidth: 3),
                            ),
                          ),
                        );
                      }

                      if (_shouldShowAllProblemsSolved) {
                        return Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.allProblemsSolved,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: [
                          for (var i = 0; i < 3; i++) _buildCard(i),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
          // 戻るボタン（最前面に配置）
          const custom.BackButton(),
        ],
      ),
    );
  }

  Future<bool> _assetExists(String assetPath) async {
    try {
      await rootBundle.load(assetPath);
      return true;
    } catch (_) {
      return false;
    }
  }

  Widget _buildCard(int idx) {
    final l10n = AppLocalizations.of(context)!;
    final p = _current[idx];
    // 難易度表示を削除（ネタバレ防止）
    final label = l10n.problemIndex(idx + 1);
    final hasHintButton = p != null && p.hint != null && p.hint!.isNotEmpty;
    // ヒントボタンが出ると上部アイコン列が横に窮屈になるので、その時だけ少し詰める
    final bool compactTopIconRow = hasHintButton;
    final double gapAfterLabel = compactTopIconRow ? 8 : 12;
    final double gapAfterRefresh = compactTopIconRow ? 4 : 8;
    final double gapAfterScratch = compactTopIconRow ? 10 : 16;
    final double gapAfterHint = compactTopIconRow ? 4 : 8;
    final double gapBeforeSave = compactTopIconRow ? 4 : 8;
    final EdgeInsetsGeometry iconPadding =
        compactTopIconRow ? const EdgeInsets.all(6) : const EdgeInsets.all(8);
    final BoxConstraints? iconConstraints =
        compactTopIconRow ? const BoxConstraints.tightFor(width: 44, height: 44) : null;
    final VisualDensity iconVisualDensity =
        compactTopIconRow ? const VisualDensity(horizontal: -2, vertical: -2) : VisualDensity.standard;
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(width: gapAfterLabel),
                Theme(
                  data: Theme.of(context).copyWith(splashFactory: NoSplash.splashFactory),
                  child: IconButton(
                    focusNode: _noFocusNode,
                    tooltip: l10n.rerollSlot,
                    onPressed: () => _rerollSingle(idx),
                    padding: iconPadding,
                    constraints: iconConstraints,
                    visualDensity: iconVisualDensity,
                    icon: const Icon(Icons.refresh, size: 32),
                  ),
                ),
                SizedBox(width: gapAfterRefresh),
                Theme(
                  data: Theme.of(context).copyWith(splashFactory: NoSplash.splashFactory),
                  child: FutureBuilder<LearningStatus>(
                    future: p != null ? _getProblemLearningStatus(p) : Future.value(LearningStatus.none),
                    builder: (context, snapshot) {
                      final isRecorded = p != null && _scratchPaperRecordedProblems.contains(_problemKey(p));
                      final hasStatus = snapshot.hasData && snapshot.data != null;
                      final shouldHighlight = _shouldHighlightScratchPaperButton[idx];
                      
                      return Container(
                        decoration: shouldHighlight ? BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.orange[400]!, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange[400]!.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ) : null,
                        child: IconButton(
                          focusNode: _noFocusNode,
                          tooltip: l10n.openScratchPaper,
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ScratchPaperPage(
                                  problem: p,
                                  prefsPrefix: widget.prefsPrefix,
                                ),
                              ),
                            );
                            
                            // 計算用紙から戻った際の処理
                            if (result == true) {
                              // 学習記録が登録された場合の処理
                              _showLearningRecordedSnack();
                              // 学習記録の状態を更新
                              await _updateLearningStatus(idx);
                              // 学習記録のキャッシュを再読み込み
                              _learningStatusCache.clear();
                              for (final problem in widget.problemPool) {
                                final status = await SimpleDataManager.getLearningRecord(problem);
                                final problemStatus = ProblemStatus.values.firstWhere(
                                  (s) => s.name == status.name,
                                  orElse: () => ProblemStatus.none,
                                );
                                _learningStatusCache[problem.id] = problemStatus;
                              }
                              // UIを強制的に再描画
                              setState(() {});
                            }
                          },
                          padding: iconPadding,
                          constraints: iconConstraints,
                          visualDensity: iconVisualDensity,
                          icon: Icon(
                            Icons.edit_note, 
                            size: shouldHighlight ? 28 : 26, 
                            color: shouldHighlight ? Colors.orange[600] : Colors.blue,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: gapAfterScratch),
                // ヒントボタン（hintが空でない場合のみ表示）- 5つ中真ん中
                if (p != null && p.hint != null && p.hint!.isNotEmpty) ...[
                  IconButton(
                    focusNode: _noFocusNode,
                    tooltip: _showHint[idx] ? l10n.hideHint : l10n.showHint,
                    onPressed: () => _toggleHint(idx),
                    padding: iconPadding,
                    constraints: iconConstraints,
                    visualDensity: iconVisualDensity,
                    icon: Icon(
                      Icons.lightbulb_outline,
                      size: 28,
                      color: _showHint[idx] ? Colors.orange : Colors.grey[600],
                    ),
                  ),
                  SizedBox(width: gapAfterHint),
                ],
                // 学習記録切り替えボタン
                FutureBuilder<LearningStatus>(
                  future: p != null ? _getProblemLearningStatus(p) : Future.value(LearningStatus.none),
                  builder: (context, snapshot) {
                    final isRecorded = p != null && _scratchPaperRecordedProblems.contains(_problemKey(p));
                    final savedStatus = snapshot.hasData ? snapshot.data! : LearningStatus.none;
                    
                    if (isRecorded && savedStatus != LearningStatus.none) {
                      // 計算用紙で記録済みの場合、保存された状態を表示
                      return Container(
                        decoration: BoxDecoration(
                          color: savedStatus.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: savedStatus.color.withOpacity(0.3), width: 2),
                        ),
                        child: IconButton(
                          focusNode: _noFocusNode,
                          tooltip: '${l10n.recordSavedAt('')}: ${savedStatus.getLocalizedTooltip(context)}',
                          onPressed: null, // 無効化
                          padding: iconPadding,
                          constraints: iconConstraints,
                          visualDensity: iconVisualDensity,
                          icon: Icon(
                            savedStatus.icon,
                            size: 28,
                            color: savedStatus.color,
                          ),
                        ),
                      );
                    } else {
                      // 通常の学習記録ボタン
                      return ValueListenableBuilder<ProblemStatus>(
                  valueListenable: _pendingNotifiers[idx],
                        builder: (context, problemStatus, child) {
                          // ProblemStatusをLearningStatusに変換
                          LearningStatus learningStatus;
                          switch (problemStatus) {
                            case ProblemStatus.solved:
                              learningStatus = LearningStatus.solved;
                              break;
                            case ProblemStatus.understood:
                              learningStatus = LearningStatus.understood;
                              break;
                            case ProblemStatus.failed:
                              learningStatus = LearningStatus.failed;
                              break;
                            case ProblemStatus.none:
                              learningStatus = LearningStatus.none;
                              break;
                          }
                          
                    return IconButton(
                      focusNode: _noFocusNode,
                      tooltip: _getStatusTooltip(context, learningStatus),
                      onPressed: () => _cycleLearningStatus(idx),
                      padding: iconPadding,
                      constraints: iconConstraints,
                      visualDensity: iconVisualDensity,
                      icon: Icon(
                        learningStatus.icon,
                        size: 28,
                        color: learningStatus.color,
                      ),
                    );
                        },
                      );
                    }
                  },
                ),
                SizedBox(width: gapBeforeSave),
                // セーブボタン - 一番右
                FutureBuilder<LearningStatus>(
                  future: p != null ? _getProblemLearningStatus(p) : Future.value(LearningStatus.none),
                  builder: (context, snapshot) {
                    final isRecorded = p != null && _scratchPaperRecordedProblems.contains(_problemKey(p));
                    final savedStatus = snapshot.hasData ? snapshot.data! : LearningStatus.none;
                    
                    if (isRecorded && savedStatus != LearningStatus.none) {
                      // 計算用紙で記録済みの場合、通常の保存アイコンをdisable状態で表示
                      return IconButton(
                        focusNode: _noFocusNode,
                        tooltip: l10n.learningRecordSaved,
                        onPressed: null, // 無効化
                        padding: iconPadding,
                        constraints: iconConstraints,
                        visualDensity: iconVisualDensity,
                        icon: Icon(
                          Icons.save,
                          size: 28,
                          color: Colors.grey[400], // disable状態の色
                        ),
                      );
                    } else {
                      // 通常の保存ボタン
                      return ValueListenableBuilder<ProblemStatus>(
                        valueListenable: _pendingNotifiers[idx],
                        builder: (context, problemStatus, child) {
                          return IconButton(
                            focusNode: _noFocusNode,
                            tooltip: l10n.saveLearningRecord,
                            onPressed: problemStatus != ProblemStatus.none 
                                ? () => _saveSingleLearningRecord(idx) 
                                : null,
                            padding: iconPadding,
                            constraints: iconConstraints,
                            visualDensity: iconVisualDensity,
                            icon: Icon(
                              Icons.save,
                              size: 28,
                              color: problemStatus != ProblemStatus.none 
                                  ? Colors.blue 
                                  : Colors.grey[400],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (p == null)
              Builder(
                builder: (context) {
                  if (_isBootstrapping) {
                    return const SizedBox.shrink();
                  }

                  if (_shouldShowAllProblemsSolved && idx == 0) {
                    // 最初のカードのみ完了メッセージを表示
                    return Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.shade300),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.allProblemsSolved,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else if (!_allCardsNull) {
                    // 一部のカードのみnullの場合は従来のメッセージ
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Center(child: Text(widget.prefsPrefix == 'physics_math'
                          ? l10n.noProblems
                          : '${_getLocalizedLevelName(context, (idx < _slotLevels.length) ? _slotLevels[idx] : 0)} ${l10n.noProblems}')),
                    );
                  }
                  return const SizedBox.shrink();
                },
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  // 微分方程式ガチャまたは漸化式ガチャでequationとconditionsがある場合はCASE形式で表示
                  if (p.equation != null && p.conditions != null)
                    RepaintBoundary(
                      child: Center(
                        child: PhysicsMathCaseDisplay(
                          equation: p.getLocalizedEquation(context) ?? p.equation!,
                          conditions: p.getLocalizedConditions(context)!,
                          constants: p.getLocalizedConstants(context),
                          fontSize: 24,
                        ),
                      ),
                    )
                  else
                    RepaintBoundary(
                      child: Center(
                        child: MixedTextMath(
                          p.getLocalizedQuestion(context),
                          labelStyle: const TextStyle(fontSize: 18),
                          mathStyle: const TextStyle(fontSize: 24),
                          forceTex: false,
                        ),
                      ),
                    ),
                  // ヒント表示
                  if (_showHint[idx] && p.getLocalizedHint(context) != null && p.getLocalizedHint(context)!.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RepaintBoundary(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                l10n.hintLabelTitle,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          RepaintBoundary(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: MixedTextMath(
                                p.getLocalizedHint(context)!,
                                forceTex: true,
                                labelStyle: const TextStyle(fontSize: 18),
                                mathStyle: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 38),
                  Center(
                    child: ElevatedButton(
                      focusNode: _noFocusNode,
                      onPressed: () => _toggleAnswer(idx),
                      child: Text(
                        _showAnswer[idx] ? l10n.hideAnswer : l10n.showAnswer,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ).copyWith(
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        elevation: MaterialStateProperty.all(0),
                      ),
                    ),
                  ),
                  if (_showAnswer[idx]) ...[
                    const SizedBox(height: 16),
                    if (p.imageAsset != null) ...[
                      FutureBuilder<bool>(
                        future: _assetExists(p.imageAsset!),
                        builder: (ctx, snap) {
                          // 全ガチャの画像を不定方程式と同じサイズ感（1.65倍）で表示
                          final maxHeight = 220 * 1.65;
                          final minHeight = 220 * 1.65;
                          
                          if (snap.connectionState != ConnectionState.done) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: minHeight, minHeight: minHeight),
                              child: const SizedBox.shrink(),
                            );
                          }
                          if (snap.hasData && snap.data == true) {
                            // precacheImage を削除（キャッシュ処理を避ける）
                            // 全画像を不定方程式と同じサイズ感（1.65倍）で統一し、センタリング
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
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                      const SizedBox(height: 18),
                    ],

                    RepaintBoundary(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.answerLabel,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    RepaintBoundary(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: MixedTextMath(
                            p.getLocalizedAnswer(context),
                            labelStyle: const TextStyle(fontSize: 19),
                            mathStyle: const TextStyle(fontSize: 28, color: Colors.green),
                            forceTex: false,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    ...p.getLocalizedSteps(context).map((s) {
                      return RepaintBoundary(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (s.tex != null && s.tex!.trim().isNotEmpty)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: MixedTextMath(
                                    s.tex!,
                                    forceTex: true,
                                    labelStyle: const TextStyle(fontSize: 20),
                                    mathStyle: const TextStyle(fontSize: 22),
                                  ),
                                ),
                              if (s.imageAsset != null)
                                FutureBuilder<bool>(
                                  future: _assetExists(s.imageAsset!),
                                  builder: (ctx, snap) {
                                    if (snap.connectionState != ConnectionState.done) {
                                      return const SizedBox.shrink();
                                    }
                                    if (snap.hasData && snap.data == true) {
                                      // StepItem内画像を統一的に2倍大きくしてセンタリング
                                      return Column(
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
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}

