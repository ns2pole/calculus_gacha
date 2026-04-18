// lib/pages/problem_list_page.dart
import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/math_problem.dart';
import '../../utils/progress_display_utils.dart' show getTotalProblemCount;
import '../../services/problems/simple_data_manager.dart';
import '../../services/problems/exclusion_logic.dart'
    show ExclusionMode, shouldExcludeByModeUsingHistory, sortHistoryByTimeNewestFirst;
import '../../widgets/home/background_image_widget.dart';
import '../../widgets/common/back_button.dart' as custom;
import '../common/problem_status.dart';
import '../common/aggregation_mode.dart';
import 'level_section.dart';
import 'problem_detail_page.dart';
import '../common/problem_list_menu_utils.dart' show showFilterMenu;
import '../../widgets/gacha/filter_chips.dart' show ExclusionFilterChip;
import '../gacha/gacha_settings_page.dart' show GachaFilterMode, GachaFilterModeConversion, ExclusionModeConversion;
import '../../l10n/app_localizations.dart';
import '../../utils/l10n_utils.dart';
import '../../utils/problem_level_utils.dart';

/// ProblemListPage を外から問題リストと prefsPrefix を受け取るようにする
class ProblemListPage extends StatefulWidget {
  final List<MathProblem> problemPool;
  final String prefsPrefix;

  const ProblemListPage({super.key, required this.problemPool, this.prefsPrefix = 'integral'});

  @override
  State<ProblemListPage> createState() => _ProblemListPageState();
}

class _ProblemListPageState extends State<ProblemListPage> {
  late final List<MathProblem> _allIntegralProblems;
  static const List<String> _levelKeys = ['easy', 'mid', 'advanced'];

  String? _levelKeyForProblem(MathProblem p) {
    final parsed = parseProblemLevel(p.getLocalizedLevel(context)) ?? parseProblemLevel(p.level);
    switch (parsed) {
      case ProblemLevel.easy:
        return 'easy';
      case ProblemLevel.mid:
        return 'mid';
      case ProblemLevel.advanced:
        return 'advanced';
      case ProblemLevel.expert:
        return 'expert';
      case null:
        return null;
    }
  }

  // SimpleDataManagerに統一されたため、_statusesは不要
  // Map<String, dynamic> _statuses = {};

  GachaFilterMode _gachaFilterMode = GachaFilterMode.random;

  // 集計モードは常に最新3回分に固定
  static const AggregationMode _aggregationMode = AggregationMode.latest3;
  
  // スロット数（最新3回分）
  static const int slotCount = 3;

  bool _contentExpanded = false;

  final GlobalKey _filterChipKey = GlobalKey();

  // SimpleDataManagerに統一されたため、古いキーは不要
  // late final String _prefsKeyLocal;

  late AppLocalizations _l10n;

  Timer? _refreshDebounce;

  Future<_ProblemListData>? _dataFuture;
  _ProblemListData? _data; // 直近の計算結果（再計算中も表示に使う）

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _l10n = AppLocalizations.of(context)!;
  }

  @override
  void initState() {
    super.initState();
    _allIntegralProblems = widget.problemPool; // 外から渡された pool を使う
    // 集計モードは常に最新3回分に固定のため、読み込み不要
    _loadGachaFilterMode();

    // 画面遷移直後の体感を良くするため、まず1フレーム描画してから重い計算を開始
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _refreshData();
    });
  }

  @override
  void dispose() {
    _refreshDebounce?.cancel();
    super.dispose();
  }

  void _refreshData() {
    setState(() {
      _dataFuture = _computeData();
    });
    _dataFuture!.then((d) {
      if (!mounted) return;
      setState(() {
        _data = d;
      });
    }).catchError((e) {
      // ignore: avoid_print
      print('ProblemListPage: compute failed: $e');
    });
  }

  void _requestRefreshData({Duration delay = const Duration(milliseconds: 80)}) {
    _refreshDebounce?.cancel();
    _refreshDebounce = Timer(delay, () {
      if (!mounted) return;
      _refreshData();
    });
  }

  // 集計モードは常に最新3回分に固定のため、読み込み・保存処理は不要

  Future<void> _loadGachaFilterMode() async {
    final settings = await SimpleDataManager.getGachaSettings(widget.prefsPrefix);
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
    if (!mounted) return;
    setState(() {});
    _requestRefreshData(delay: Duration.zero);
  }

  Future<void> _saveGachaFilterMode() async {
    final settings = await SimpleDataManager.getGachaSettings(widget.prefsPrefix);
    String filterModeStr;
    switch (_gachaFilterMode) {
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
    await SimpleDataManager.saveGachaSettings(widget.prefsPrefix, settings);
  }

  // SimpleDataManagerに統一されたため、古いロード・セーブメソッドは不要

  /// _getSlots を堅牢化：入力形式の揺らぎを吸収し、常に slotCount 長で ProblemStatus/DateTime に変換して返す
  Future<List<Map<String, dynamic>>> _getSlots(MathProblem p) async {
    final history = await SimpleDataManager.getLearningHistory(p);
    // 履歴が3つを超える場合は、時刻でソートしてから最新3つを取得
    final latestHistory = history.length > slotCount
        ? sortHistoryByTimeNewestFirst(history).take(slotCount).toList()
        : history;
    
    final slots = <Map<String, dynamic>>[];
    for (var i = 0; i < slotCount; i++) {
      if (i < latestHistory.length) {
        final h = latestHistory[i];
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

  /// p.id を使って更新する（連鎖クリア・前詰め制約あり）
  Future<void> _setSlot(MathProblem p, int idx, ProblemStatus newStatus) async {
    // SimpleDataManagerから履歴を取得
    final history = await SimpleDataManager.getLearningHistory(p);
    final current = <Map<String, dynamic>>[];
    for (var i = 0; i < slotCount; i++) {
      if (i < history.length) {
        final h = history[i];
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
        current.add({'status': status, 'time': dt});
      } else {
        current.add({'status': ProblemStatus.none, 'time': null});
      }
    }

    while (current.length < slotCount) {
      current.add({'status': ProblemStatus.none, 'time': null});
    }

    // 次のスロットに入れるには前が埋まっている必要がある
    if (newStatus != ProblemStatus.none && idx > 0) {
      for (var j = 0; j < idx; j++) {
        final prevStatus = current[j]['status'] as ProblemStatus? ?? ProblemStatus.none;
        if (prevStatus == ProblemStatus.none) {
          // 前スロットが空なら操作を拒否
          return;
        }
      }
    }

    final t = newStatus == ProblemStatus.none ? null : DateTime.now().toIso8601String();
    current[idx] = {'status': newStatus, 'time': t};

    // none に戻したら右側を連鎖クリア
    if (newStatus == ProblemStatus.none) {
      for (var j = idx + 1; j < current.length; j++) {
        current[j] = {'status': ProblemStatus.none, 'time': null};
      }
    }

    // SimpleDataManagerに保存
    await SimpleDataManager.saveLearningHistory(p, current);
    if (!mounted) return;
    setState(() {});
    _requestRefreshData();
  }


  // 除外判定ロジックはexclusion_logic.dartに移動

  int _compareNo(dynamic noA, dynamic noB) {
    if (noA == null && noB == null) return 0;
    if (noA == null) return 1;
    if (noB == null) return -1;

    if (noA is int && noB is int) return noA.compareTo(noB);

    if (noA is String && noB is String) {
      if (noA.startsWith('op') && noB.startsWith('op')) {
        final numA = int.tryParse(noA.substring(2)) ?? 0;
        final numB = int.tryParse(noB.substring(2)) ?? 0;
        return numA.compareTo(numB);
      }
      return noA.compareTo(noB);
    }

    if (noA is int) return -1;
    if (noB is int) return 1;
    return 0;
  }

  Future<_ProblemListData> _computeData() async {
    // 遷移直後の初回描画を邪魔しない
    await Future<void>.delayed(Duration.zero);

    final levels = _levelKeys;
    final rawByLevel = <String, List<MathProblem>>{};
    final idsToPrefetch = <String>{};

    for (final level in levels) {
      var list = _allIntegralProblems.where((p) => _levelKeyForProblem(p) == level).toList();

      // 予備問題は廃止されたため、非表示にする（prefetch対象にも含めない）
      list = list.where((p) => !(p.no is String && (p.no as String).startsWith('op'))).toList();

      rawByLevel[level] = list;
      for (final p in list) {
        idsToPrefetch.add(p.id);
      }
    }

    // 履歴を一括で読み込んでメモリキャッシュを温める
    final historyMap = await SimpleDataManager.getLearningHistoryMap(idsToPrefetch);
    final exclusionMode = _gachaFilterMode.toExclusionMode();

    // 除外判定（履歴は historyMap から読むので高速）
    final filteredByLevel = <String, List<MathProblem>>{};
    for (final level in levels) {
      final src = rawByLevel[level] ?? const <MathProblem>[];
      final out = <MathProblem>[];
      for (var i = 0; i < src.length; i++) {
        final p = src[i];
        final history = historyMap[p.id] ?? const <Map<String, dynamic>>[];
        final exclude = shouldExcludeByModeUsingHistory(history, exclusionMode);
        if (!exclude) out.add(p);
        if (i > 0 && i % 220 == 0) await Future<void>.delayed(Duration.zero);
      }
      out.sort((a, b) => _compareNo(a.no, b.no));
      filteredByLevel[level] = out;
    }

    // 各レベルの集計値（表示用）もここで一度だけ作る
    final countsByLevel = <String, Map<ProblemStatus, int>>{};
    for (final level in levels) {
      var solved = 0, understood = 0, failed = 0;
      final list = filteredByLevel[level] ?? const <MathProblem>[];

      for (var i = 0; i < list.length; i++) {
        final p = list[i];
        final h = historyMap[p.id] ?? const <Map<String, dynamic>>[];
        final latest = h.length > slotCount ? sortHistoryByTimeNewestFirst(h).take(slotCount).toList() : h;
        for (final rec in latest) {
          final st = rec['status'] as String?;
          if (st == 'solved') {
            solved++;
          } else if (st == 'understood') {
            understood++;
          } else if (st == 'failed') {
            failed++;
          }
        }
        if (i > 0 && i % 240 == 0) await Future<void>.delayed(Duration.zero);
      }

      countsByLevel[level] = {
        ProblemStatus.solved: solved,
        ProblemStatus.understood: understood,
        ProblemStatus.failed: failed,
      };
    }

    final filteredCount = filteredByLevel.values.fold<int>(0, (sum, l) => sum + l.length);
    return _ProblemListData(
      problemsByLevel: filteredByLevel,
      countsByLevel: countsByLevel,
      filteredCount: filteredCount,
    );
  }

  // --- ヘルパー（ファイルのトップ付近に追加） ---
  Color _colorOfSmall(ProblemStatus s) {
    switch (s) {
      case ProblemStatus.solved:
        return Colors.green;
      case ProblemStatus.understood:
        return Colors.orange;
      case ProblemStatus.failed:
        return Colors.red;
      case ProblemStatus.none:
        return Colors.grey;
    }
  }

  IconData _iconOfSmall(ProblemStatus s) {
    switch (s) {
      case ProblemStatus.solved:
        return Icons.check_circle;
      case ProblemStatus.understood:
        return Icons.lightbulb;
      case ProblemStatus.failed:
        return Icons.cancel;
      case ProblemStatus.none:
        return Icons.radio_button_unchecked;
    }
  }

  Widget _statusBadgeSmall(ProblemStatus s, {double diameter = 20.0}) {
    final double iconSize = diameter * 0.6;
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        color: _colorOfSmall(s),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(_iconOfSmall(s), size: iconSize, color: Colors.white),
    );
  }

  /// フィルタリングチップの内容を構築
  // フィルタリング後の問題数を取得
  Future<int> _getFilteredProblemCount() async {
    final future = _dataFuture;
    if (future == null) return 0;
    final d = _data ?? await future;
    return d?.filteredCount ?? 0;
  }

  // 全問題数を取得（共通関数を使用）
  int _getTotalProblemCount() {
    return getTotalProblemCount(
      prefsPrefix: widget.prefsPrefix,
      problemPool: _allIntegralProblems,
    );
  }
  Widget _buildFilterChipContent() {
    final totalCount = _getTotalProblemCount();
    final cachedFilteredCount = _data?.filteredCount;
    if (cachedFilteredCount != null) {
      return _buildFilterChipContentCore(totalCount: totalCount, filteredCount: cachedFilteredCount);
    }
    if (_dataFuture == null) {
      return _buildFilterChipContentCore(totalCount: totalCount, filteredCount: totalCount);
    }
    return FutureBuilder<int>(
      future: _getFilteredProblemCount(),
      builder: (context, snapshot) {
        final filteredCount = snapshot.hasData ? snapshot.data! : totalCount;
        return _buildFilterChipContentCore(totalCount: totalCount, filteredCount: filteredCount);
      },
    );
  }

  Widget _buildFilterChipContentCore({
    required int totalCount,
    required int filteredCount,
  }) {
    Widget exclusionText;
    if (_gachaFilterMode == GachaFilterMode.random) {
      exclusionText = Text(
        _l10n.allDisplayed,
        style: TextStyle(fontSize: 17, color: Colors.purple[700], fontWeight: FontWeight.w500),
        softWrap: true,
        overflow: TextOverflow.visible,
        textAlign: TextAlign.center,
      );
    } else {
      int n;
      switch (_gachaFilterMode) {
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
      exclusionText = Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 2,
        runSpacing: 2,
        children: [
          Text(
            _l10n.latestNTimesShort(n),
            style: TextStyle(fontSize: 17, color: Colors.purple[700], fontWeight: FontWeight.w500),
            softWrap: true,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
          ),
          _statusBadgeSmall(ProblemStatus.solved, diameter: 22.4),
          Text(
            _l10n.excludeSuffix,
            style: TextStyle(fontSize: 17, color: Colors.purple[700], fontWeight: FontWeight.w500),
            softWrap: true,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 2,
      children: [
        exclusionText,
        Text(
          _l10n.problemCountOutOf(filteredCount, totalCount),
          style: TextStyle(
            fontSize: 17,
            color: Colors.purple[600],
            fontWeight: FontWeight.w500,
          ),
          softWrap: true,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// 集計設定メニューを表示
  // 集計モードは常に最新3回分に固定のため、メニューは不要

  /// フィルタ選択メニューを表示
  Future<void> _showFilterMenu(BuildContext context, {Offset? position, Size? size}) async {
    // GachaFilterModeをExclusionModeに変換してメニューを表示
    final currentExclusionMode = _gachaFilterMode.toExclusionMode();
    final selected = await showFilterMenu(
      context,
      currentExclusionMode,
      position: position,
      size: size,
    );

    if (selected != null && selected != currentExclusionMode) {
      setState(() {
        // ExclusionModeをGachaFilterModeに変換
        _gachaFilterMode = selected.toGachaFilterMode();
      });
      await _saveGachaFilterMode();
      _requestRefreshData(delay: Duration.zero);
    }
  }

  /// 集計説明（既存アイコン説明＋現在の表示条件を下に動的表示）
  @Deprecated('Not used')
  Widget _aggregationDescription() {
    const double fontSize = 13.0;
    final double chipDiameter = fontSize + 6.0;
    final double innerIconSize = fontSize * 0.95;

    Widget statusChip(ProblemStatus s) {
      return Container(
        width: chipDiameter,
        height: chipDiameter,
        decoration: BoxDecoration(
          color: _colorOfSmall(s),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(_iconOfSmall(s), size: innerIconSize, color: Colors.white),
      );
    }

    // 動的に現在の表示条件を作る（説明用）
    Widget buildExclusionWidget() {
      final l10n = AppLocalizations.of(context)!;
      Widget content;
      if (_gachaFilterMode == GachaFilterMode.random) {
        content = Text(l10n.allDisplayed, style: TextStyle(fontSize: 16, color: Colors.grey[900]));
      } else {
        int n;
        switch (_gachaFilterMode) {
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

        content = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.latestNTimes(n), style: TextStyle(fontSize: 16, color: Colors.grey[900])),
            _statusBadgeSmall(ProblemStatus.solved, diameter: 18.0),
            const SizedBox(width: 2),
            Text(' ${l10n.excludeSuffix}', style: TextStyle(fontSize: 16, color: Colors.grey[900])),
          ],
        );
      }

      return Builder(
        builder: (context) => InkWell(
          onTap: () => _showFilterMenu(context),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                content,
                const SizedBox(width: 4),
                Icon(Icons.arrow_drop_down, size: 20, color: Colors.grey[700]),
              ],
            ),
          ),
        ),
      );
    }

    final exclusionWidget = buildExclusionWidget();
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('※', style: TextStyle(fontSize: 14, height: 1.0)),
              const SizedBox(width: 4),
              statusChip(ProblemStatus.solved),
              const SizedBox(width: 4),
              statusChip(ProblemStatus.understood),
              const SizedBox(width: 4),
              statusChip(ProblemStatus.failed),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  l10n.aggregateLatestNLong(_aggregationMode == AggregationMode.latest1 ? 1 : 3),
                  style: TextStyle(fontSize: 16, height: 1.1, color: Colors.grey[900]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ガチャタイプ名を取得
  String _getGachaTypeName() {
    switch (widget.prefsPrefix) {
      case 'integral':
        return _l10n.integralGachaTitle;
      case 'limit':
        return _l10n.limitGachaTitle;
      case 'physics_math':
        return _l10n.physicsMathGachaTitle;
      case 'factorization':
        return _l10n.factorizationGachaTitle;
      case 'indeterminate_equation':
        return _l10n.indeterminateEqGachaTitle;
      case 'sequence':
        return _l10n.sequenceGachaTitle;
      default:
        return _l10n.genericGachaTitle;
    }
  }

  /// ガチャタイプごとのコンテンツリストを取得
  List<String> _getGachaContents() {
    switch (widget.prefsPrefix) {
      case 'integral':
        return [
          _l10n.content_integral_abs,
          _l10n.content_integral_basic,
          _l10n.content_integral_parts,
          _l10n.content_integral_substitution,
          _l10n.content_integral_partial_fraction,
          _l10n.content_integral_trig_power,
          _l10n.content_integral_exp_log,
          _l10n.content_integral_irrational_1,
          _l10n.content_integral_irrational_2,
          _l10n.content_integral_beta,
        ];
      case 'limit':
        return [
          _l10n.content_limit_basic,
          _l10n.content_limit_rationalization,
          _l10n.content_limit_trig,
          _l10n.content_limit_exp_log,
          _l10n.content_limit_partial_fraction,
          _l10n.content_limit_squeeze,
          _l10n.content_limit_riemann,
          _l10n.content_limit_famous,
        ];
      case 'physics_math':
        return [
          _l10n.content_pm_uniform_accel,
          _l10n.content_pm_shm_lc,
          _l10n.content_pm_air_rl,
          _l10n.content_pm_rc,
          _l10n.content_pm_ac,
        ];
      case 'factorization':
        return [
          _l10n.content_fact_cross,
          _l10n.content_fact_factor_theorem,
          _l10n.content_fact_replacement,
          _l10n.content_fact_4th_degree,
          _l10n.content_fact_low_degree,
          _l10n.content_fact_sort_by_var,
          _l10n.content_fact_5th_degree,
        ];
      case 'indeterminate_equation':
        return [
          _l10n.content_indet_basic,
          _l10n.content_indet_3vars,
          _l10n.content_indet_quadratic_hyperbola,
          _l10n.content_indet_quadratic_ellipse,
          _l10n.content_indet_high_degree,
        ];
      case 'sequence':
        return [
          _l10n.content_seq_2terms,
          _l10n.content_seq_3terms,
          _l10n.content_seq_simultaneous,
          _l10n.content_seq_fractional,
          _l10n.content_seq_variable_coeff,
          _l10n.content_seq_root_power,
        ];
      default:
        return [];
    }
  }

  /// ヘッダー部分を構築（タイトル、カテゴリーチップ、コンテンツ一覧）
  Widget _buildHeaderSection(String gachaTypeName) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, bottom: 20.0),
            child: Column(
              children: [
          // タイトル
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _l10n.problemListTitle(gachaTypeName),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B7355),
                                ),
                              ),
                            ],
                          ),
                          // コンテンツ一覧（プルダウン）
                          const SizedBox(height: 12),
                          ExpansionTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _l10n.gachaContentsTitle,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF8B7355),
                                ),
                              ),
                                const SizedBox(width: 8),
                                Icon(
                                  _contentExpanded ? Icons.expand_less : Icons.expand_more,
                                  color: const Color(0xFF8B7355),
                                  size: 24,
                                ),
                              ],
                            ),
                            trailing: const SizedBox.shrink(),
                            initiallyExpanded: _contentExpanded,
                            onExpansionChanged: (expanded) {
                              setState(() {
                                _contentExpanded = expanded;
                              });
                            },
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: _getGachaContents().map((content) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            '・',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF8B7355),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            content,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Color(0xFF8B7355),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          
        ],
      ),
    );
  }

  /// フィルター設定部分を構築（除外設定のみ、集計設定は常に最新3回分に固定）
  Widget _buildFilterSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 除外設定のみ表示（集計設定は常に最新3回分に固定のため削除）
          ExclusionFilterChip(
            exclusionMode: _gachaFilterMode.toExclusionMode(),
            filterChipKey: _filterChipKey,
            onTap: () {
              final RenderBox? renderBox = _filterChipKey.currentContext?.findRenderObject() as RenderBox?;
              if (renderBox != null) {
                final position = renderBox.localToGlobal(Offset.zero);
                final size = renderBox.size;
                _showFilterMenu(context, position: position, size: size);
              } else {
                _showFilterMenu(context);
              }
            },
            buildContent: _buildFilterChipContent,
          ),
        ],
      ),
    );
  }


  /// 問題リスト部分を構築
  Widget _buildProblemListSection(List<String> levels) {
    return FutureBuilder<_ProblemListData>(
      key: ValueKey(_gachaFilterMode.name),
      future: _dataFuture,
      builder: (context, snapshot) {
        final data = snapshot.data ?? _data;
        if (data == null) {
          return Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                  const SizedBox(width: 10),
                  Text(_l10n.preparingProblemList),
                ],
              ),
            ),
          );
        }

        final allProblems = data.problemsByLevel;
                          // フィルタリング後の問題数を計算
                          int totalFilteredCount = 0;
                          for (final problems in allProblems.values) {
                            totalFilteredCount += problems.length;
                          }
                          
                          // 問題数が0の場合は完了メッセージを表示
                          if (totalFilteredCount == 0) {
                            return Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Center(
                                child: Text(
                                  _l10n.allProblemsSolved,
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
                          
                          int cumulativeIndex = 0;
                          return Column(
                            children: [
                        for (int i = 0; i < levels.length; i++) ...[
                          Builder(
                            builder: (context) {
                              final problems = allProblems[levels[i]] ?? [];
                              final startIndex = cumulativeIndex;
                              cumulativeIndex += problems.length;
                              return LevelSection(
                                level: levels[i],
                                items: problems,
                                precomputedCounts: data.countsByLevel[levels[i]],
                                startIndex: startIndex,
                                prefsPrefix: widget.prefsPrefix,
                                getSlots: (p) => _getSlots(p), // _getSlotsを使用（単位ガチャの場合は仕切り付きスロットを返す）
                                aggregationMode: _aggregationMode,
                                onSetSlot: (p, idx, st) => _setSlot(p, idx, st),
                                onClearAll: (p) async {
                                  // SimpleDataManagerから削除
                                  await SimpleDataManager.clearLearningHistory(p);
                                  if (!mounted) return;
                                  setState(() {});
                                  _requestRefreshData();
                                },
                                onOpenDetail: (p, displayNo) async {
                                  final slots = await _getSlots(p);
                                  // 仕切りを除外してスロットのみをコピー
                                  final deepCopy = slots
                                      .where((e) => e['isDivider'] != true) // 仕切りを除外
                                      .map((e) => {
                                            'status': ((e['status'] as ProblemStatus?) ?? ProblemStatus.none).name,
                                            'time': e['time'] != null
                                                ? (e['time'] as DateTime).toIso8601String()
                                                : null
                                          })
                                      .toList();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProblemDetailPage(
                                        problem: p,
                                        displayNo: displayNo,
                                        initialHistory: deepCopy,
                                        onAddSlot: (idx, st) => _setSlot(p, idx, st),
                                        onClear: () async {
                                          // SimpleDataManagerから削除
                                          await SimpleDataManager.clearLearningHistory(p);
                                          if (!mounted) return;
                                          setState(() {});
                                          _requestRefreshData();
                                        },
                                        prefsPrefix: widget.prefsPrefix,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
                        ),
                        const SizedBox(height: 24),
                      ],
                    );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final levels = _levelKeys;
    final gachaTypeName = _getGachaTypeName();
    return Scaffold(
      body: Stack(
        children: [
          // 背景画像（薄く、画面サイズに合わせて4枚周期的に表示）
          Positioned.fill(
            child: const BackgroundImageWidget(opacity: 0.2),
          ),
          // コンテンツ
              Padding(
            padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                Expanded(
                  child: ListView(
                              children: [
                      _buildHeaderSection(gachaTypeName),
                      _buildFilterSection(),
                      _buildProblemListSection(levels),
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
}

class _ProblemListData {
  final Map<String, List<MathProblem>> problemsByLevel;
  final Map<String, Map<ProblemStatus, int>> countsByLevel;
  final int filteredCount;

  const _ProblemListData({
    required this.problemsByLevel,
    required this.countsByLevel,
    required this.filteredCount,
  });
}

// LevelSection は level_section.dart に移動
// ProblemTile は problem_tile.dart に移動
// ProblemDetailPage は problem_detail_page.dart に移動
// DeferredMixedTextMath は deferred_mixed_text_math.dart に移動
