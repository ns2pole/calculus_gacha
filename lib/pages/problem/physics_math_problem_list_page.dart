// lib/pages/physics_math_problem_list_page.dart
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import '../../l10n/app_localizations.dart';
import '../../models/math_problem.dart';
import '../../models/learning_status.dart';
import '../../utils/l10n_utils.dart';
import '../common/common.dart' show categorizeKeywords4Groups, filterProblemsByKeywords;
import '../common/problem_status.dart';
import 'problem_detail_page.dart';
import '../common/problem_list_menu_utils.dart' show showFilterMenu;
import '../common/aggregation_mode.dart';
import '../../services/problems/simple_data_manager.dart';
import '../../services/problems/exclusion_logic.dart' show sortHistoryByTimeNewestFirst, shouldExcludeByMode, ExclusionMode;
import '../../widgets/gacha/physics_math_case_display.dart';
import '../../widgets/home/background_image_widget.dart';
import '../../widgets/common/back_button.dart';
import '../gacha/gacha_settings_page.dart';
import '../../widgets/gacha/filter_chips.dart';

const int _slotCount = 3;

// ExclusionMode、ExclusionModeExt、kExclusionDisplayOrderはexclusion_logic.dartからインポート

/// 微分方程式ガチャの問題一覧ページ（カテゴリーベース）
class PhysicsMathProblemListPage extends StatefulWidget {
  final List<MathProblem> problemPool;
  final String prefsPrefix;

  const PhysicsMathProblemListPage({
    super.key,
    required this.problemPool,
    this.prefsPrefix = 'physics_math',
  });

  @override
  State<PhysicsMathProblemListPage> createState() => _PhysicsMathProblemListPageState();
}

class _PhysicsMathProblemListPageState extends State<PhysicsMathProblemListPage> {
  late final List<MathProblem> _allProblems;
  late AppLocalizations _l10n;

  GachaFilterMode _gachaFilterMode = GachaFilterMode.random;

  // 集計モードは常に最新3回分に固定
  static const AggregationMode _aggregationMode = AggregationMode.latest3;

  final GlobalKey _filterChipKey = GlobalKey();

  // キーワード選択関連
  Set<String> _selectedKeywords = {};

  bool _contentExpanded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _l10n = AppLocalizations.of(context)!;
  }

  @override
  void initState() {
    super.initState();
    _allProblems = widget.problemPool;
    // 集計モードは常に最新3回分に固定のため、読み込み不要
    _loadGachaFilterMode();
    _loadSelectedKeywords();

    // カテゴリー分類は廃止
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

  // 微分方程式ガチャ用：キーワード一覧を取得
  List<String> _getKeywords() {
    final keywords = <String>{};
    for (final p in _allProblems) {
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

  // カテゴリー分類は廃止。全問題を取得する関数に変更（除外モードも適用）
  Future<List<MathProblem>> _getFilteredProblems() async {
    // キーワードフィルタリングを適用（共通関数を使用）
    final keywordFiltered = filterProblemsByKeywords(_allProblems, _selectedKeywords);
    
    // 除外モードに基づいてフィルタリング
    final filteredList = <MathProblem>[];
    // GachaFilterModeをExclusionModeに変換
    final exclusionMode = _gachaFilterMode.toExclusionMode();
    for (final problem in keywordFiltered) {
      if (!await shouldExcludeByMode(problem, exclusionMode)) {
        filteredList.add(problem);
      }
    }
    
    // 問題番号順にソート
    filteredList.sort((a, b) {
      final noA = a.no ?? 0;
      final noB = b.no ?? 0;
      return noA.compareTo(noB);
    });
    
    return filteredList;
  }

  /// 永続化キーは problem.id を返す（ここが最重要）
  String _problemKey(MathProblem p) => p.id;

  Future<List<Map<String, dynamic>>> _getSlots(MathProblem p) async {
    final history = await SimpleDataManager.getLearningHistory(p);
    // 履歴が3つを超える場合は、時刻でソートしてから最新3つを取得
    final latestHistory = history.length > _slotCount
        ? sortHistoryByTimeNewestFirst(history).take(_slotCount).toList()
        : history;
    final slots = <Map<String, dynamic>>[];
    for (var i = 0; i < _slotCount; i++) {
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
    final key = _problemKey(p);
    // SimpleDataManagerから履歴を取得
    final history = await SimpleDataManager.getLearningHistory(p);
    final current = <Map<String, dynamic>>[];
    for (var i = 0; i < _slotCount; i++) {
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

    while (current.length < _slotCount) current.add({'status': ProblemStatus.none, 'time': null});

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
    final success = await SimpleDataManager.saveLearningHistory(p, current);
    if (!success) {
      await SimpleDataManager.ensureWebCloudSyncReady(force: true);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_l10n.learningRecordSaveFailed)),
      );
      setState(() {});
      return;
    }
    if (!mounted) return;
    setState(() {});
  }

  ProblemStatus _nextStatus(ProblemStatus cur) {
    switch (cur) {
      case ProblemStatus.none:
        return ProblemStatus.solved;
      case ProblemStatus.solved:
        return ProblemStatus.understood;
      case ProblemStatus.understood:
        return ProblemStatus.failed;
      case ProblemStatus.failed:
        return ProblemStatus.none;
    }
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
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.label, color: Colors.blue[700], size: 20),
              const SizedBox(width: 8),
              Text(
                _l10n.keywordSelectorTitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
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
              _l10n.selectedKeywordsLabel(_selectedKeywords.length, _selectedKeywords.map((k) => getLocalizedKeyword(context, k)).join(', ')),
              style: TextStyle(color: Colors.blue[700], fontSize: 14),
            ),
          ] else ...[
            Text(
              _l10n.noKeywordsSelected,
              style: TextStyle(color: Colors.grey[600], fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ],
          const SizedBox(height: 8),
          Builder(
            builder: (context) {
              final filteredCount = filterProblemsByKeywords(_allProblems, _selectedKeywords).length;
              final totalCount = _allProblems.length;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.filter_list, color: Colors.blue[700], size: 18),
                    const SizedBox(width: 8),
                    Text(
                      _l10n.filteredCountLabel(filteredCount, totalCount),
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
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
        onSelected: (selected) async {
          setState(() {
            if (selected) {
              _selectedKeywords.add(keyword);
            } else {
              _selectedKeywords.remove(keyword);
            }
          });
          await _saveSelectedKeywords();
        },
        selectedColor: Colors.blue.withOpacity(0.4),
        backgroundColor: Colors.grey.shade200,
        checkmarkColor: Colors.transparent, // チェックマークを透明にして非表示
        showCheckmark: false, // チェックマークを表示しない
        labelStyle: TextStyle(
          color: isSelected ? Colors.blue[900] : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }).toList();
  }

  // フィルタリングチップの内容を構築
  // フィルタリング後の問題数を取得（キーワードフィルタリング + 除外モード）
  Future<int> _getFilteredProblemCount() async {
    final keywordFiltered = filterProblemsByKeywords(_allProblems, _selectedKeywords);
    int count = 0;
    // GachaFilterModeをExclusionModeに変換
    final exclusionMode = _gachaFilterMode.toExclusionMode();
    for (final problem in keywordFiltered) {
      if (!await shouldExcludeByMode(problem, exclusionMode)) {
        count++;
      }
    }
    return count;
  }

  // 全問題数を取得（キーワードフィルタリング後の問題数）
  int _getTotalProblemCount() {
    return filterProblemsByKeywords(_allProblems, _selectedKeywords).length;
  }

  Widget _buildFilterChipContent() {
    final totalCount = _getTotalProblemCount();
    return FutureBuilder<int>(
      key: ValueKey('${_gachaFilterMode.index}_${_selectedKeywords.join(',')}'),
      future: _getFilteredProblemCount(),
      builder: (context, snapshot) {
        final filteredCount = snapshot.hasData ? snapshot.data! : totalCount;
        
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
              '($filteredCount / $totalCount)',
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
      },
    );
  }

  // ステータスバッジ（小）
  Widget _statusBadgeSmall(ProblemStatus status, {double diameter = 20.0}) {
    final double iconSize = diameter * 0.6;
    late final IconData icon;
    late final Color color;
    switch (status) {
      case ProblemStatus.solved:
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case ProblemStatus.understood:
        icon = Icons.lightbulb;
        color = Colors.orange;
        break;
      case ProblemStatus.failed:
        icon = Icons.cancel;
        color = Colors.red;
        break;
      case ProblemStatus.none:
        icon = Icons.circle_outlined;
        color = Colors.grey;
        break;
    }
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: iconSize, color: Colors.white),
    );
  }

  // 集計結果を計算する
  Future<Map<String, int>> _calculateAggregation() async {
    final problems = await _getFilteredProblems();
    int solvedCount = 0;
    int understoodCount = 0;
    int failedCount = 0;

    for (final problem in problems) {
      final slots = await _getSlots(problem);
      
      // 集計モードに基づいて集計
      if (_aggregationMode == AggregationMode.latest1) {
        // 最新1回のみ（インデックス0）
        if (slots.isNotEmpty) {
          final status = slots[0]['status'] as ProblemStatus? ?? ProblemStatus.none;
          switch (status) {
            case ProblemStatus.solved:
              solvedCount++;
              break;
            case ProblemStatus.understood:
              understoodCount++;
              break;
            case ProblemStatus.failed:
              failedCount++;
              break;
            case ProblemStatus.none:
              break;
          }
        }
      } else {
        // 最新3回分（全スロット）
        for (final slot in slots) {
          final status = slot['status'] as ProblemStatus? ?? ProblemStatus.none;
          switch (status) {
            case ProblemStatus.solved:
              solvedCount++;
              break;
            case ProblemStatus.understood:
              understoodCount++;
              break;
            case ProblemStatus.failed:
              failedCount++;
              break;
            case ProblemStatus.none:
              break;
          }
        }
      }
    }

    return {
      'solved': solvedCount,
      'understood': understoodCount,
      'failed': failedCount,
    };
  }

  // 集計結果表示ガジェット
  Widget _buildAggregationSummary() {
    return FutureBuilder<Map<String, int>>(
      key: ValueKey('${_aggregationMode.index}_${_selectedKeywords.join(',')}'),
      future: _calculateAggregation(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 8),
                Text(_l10n.loading, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          );
        }

        final counts = snapshot.data!;
        final solvedCount = counts['solved'] ?? 0;
        final understoodCount = counts['understood'] ?? 0;
        final failedCount = counts['failed'] ?? 0;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 緑チェック
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _statusBadgeSmall(ProblemStatus.solved, diameter: 22),
                  const SizedBox(width: 6),
                  Text(
                    '$solvedCount',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // 黄色チェック
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _statusBadgeSmall(ProblemStatus.understood, diameter: 22),
                  const SizedBox(width: 6),
                  Text(
                    '$understoodCount',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // 赤チェック
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _statusBadgeSmall(ProblemStatus.failed, diameter: 22),
                  const SizedBox(width: 6),
                  Text(
                    '$failedCount',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

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
    }
  }

  /// ガチャタイプごとのコンテンツリストを取得
  List<String> _getGachaContents() {
    switch (widget.prefsPrefix) {
      case 'physics_math':
        return [
          _l10n.content_pm_uniform_accel,
          _l10n.content_pm_shm_lc,
          _l10n.content_pm_air_rl,
          _l10n.content_pm_rc,
          _l10n.content_pm_ac,
        ];
      default:
        return [];
    }
  }

  /// 集計設定メニューを表示
  // 集計モードは常に最新3回分に固定のため、メニューは不要


  @override
  Widget build(BuildContext context) {
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
                      // タイトルと設定ボタン（スクロール可能）
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, bottom: 20.0), // ヘッダの矢印部分と被ってもOK
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                _l10n.physicsMathGachaProblemListTitle,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF8B7355),
                                ),
                              ),
                            ),
                            // コンテンツ一覧（プルダウン）
                            const SizedBox(height: 12),
                            ExpansionTile(
                              title: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(_l10n.gachaContentsTitle,
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
                            // 除外設定と集計設定を2行に配置（キーワードガジェットの上）
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // 除外設定（1行目）- パープル系
                                  Center(
                                    child: GestureDetector(
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
                                      child: Container(
                                        key: _filterChipKey,
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.purple.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(color: Colors.purple.withOpacity(0.3), width: 1),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.purple.withOpacity(0.1),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                              Icon(Icons.filter_list, size: 18, color: Colors.purple[700]),
                                            const SizedBox(width: 4),
                                              _buildFilterChipContent(),
                                            const SizedBox(width: 4),
                                              Icon(Icons.expand_more, size: 20, color: Colors.purple[600]),
                                          ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // 集計設定は常に最新3回分に固定のため削除
                                ],
                              ),
                            ),
                            _buildKeywordSelector(),
                            // 集計結果表示
                            _buildAggregationSummary(),
                          ],
                        ),
                      ),
                    FutureBuilder<List<MathProblem>>(
                      key: ValueKey(_gachaFilterMode),
                      future: _getFilteredProblems(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(24.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        final problems = snapshot.data!;
                        if (problems.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Text(
                                _l10n.noProblems,
                                style: const TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ),
                          );
                        }
                        return Column(
                          children: [
                            for (final problem in problems)
                              _ProblemItemCard(
                                problem: problem,
                                getSlots: (p) => _getSlots(p),
                                onSetSlot: (p, idx, st) => _setSlot(p, idx, st),
                                onClearAll: (p) async {
                                  await SimpleDataManager.clearLearningHistory(p);
                                  if (!mounted) return;
                                  setState(() {});
                                },
                                onOpenDetail: (p) async {
                                  final slots = await _getSlots(p);
                                  final deepCopy = slots
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
                                        initialHistory: deepCopy,
                                        onAddSlot: (idx, st) => _setSlot(p, idx, st),
                                        onClear: () async {
                                          await SimpleDataManager.clearLearningHistory(p);
                                          if (!mounted) return;
                                          setState(() {});
                                        },
                                        prefsPrefix: widget.prefsPrefix,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            const SizedBox(height: 24),
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
          const BackButton(),
        ],
      ),
    );
  }
}

class _ProblemItemCard extends StatelessWidget {
  final MathProblem problem;
  final Future<List<Map<String, dynamic>>> Function(MathProblem) getSlots;
  final void Function(MathProblem p, int idx, ProblemStatus st) onSetSlot;
  final Future<void> Function(MathProblem p) onClearAll;
  final void Function(MathProblem p) onOpenDetail;

  const _ProblemItemCard({
    required this.problem,
    required this.getSlots,
    required this.onSetSlot,
    required this.onClearAll,
    required this.onOpenDetail,
  });

  Widget _statusBadgeSmall(ProblemStatus status, {double diameter = 20.0}) {
    final double iconSize = diameter * 0.6;
    late final IconData icon;
    late final Color color;
    switch (status) {
      case ProblemStatus.solved:
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case ProblemStatus.understood:
        icon = Icons.lightbulb;
        color = Colors.orange;
        break;
      case ProblemStatus.failed:
        icon = Icons.cancel;
        color = Colors.red;
        break;
      case ProblemStatus.none:
        icon = Icons.circle_outlined;
        color = Colors.grey;
        break;
    }
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: iconSize, color: Colors.white),
    );
  }

  String _formatDtShort(DateTime dt) {
    final local = dt.toLocal();
    return '${local.year}/${local.month.toString().padLeft(2, '0')}/${local.day.toString().padLeft(2, '0')} ${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return FutureBuilder<List<Map<String, dynamic>>>(
      key: ValueKey('${problem.id}_slots'),
      future: getSlots(problem),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return ListTile(title: Text(l10n.preparingProblemList));
        }

        final slots = snapshot.data!;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            dense: true,
            title: Row(
              children: [
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'No. ${problem.no ?? 'N/A'}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      for (int i = 0; i < slots.length; i++)
                        Builder(
                          builder: (context) {
                            final status = slots[i]['status'] as ProblemStatus?;
                            if (status == null) return const SizedBox.shrink();
                            return GestureDetector(
                              onTap: () {
                                final current = status;
                                final next = current == ProblemStatus.none
                                    ? ProblemStatus.solved
                                    : current == ProblemStatus.solved
                                        ? ProblemStatus.understood
                                        : current == ProblemStatus.understood
                                            ? ProblemStatus.failed
                                            : ProblemStatus.none;
                                onSetSlot(problem, i, next);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: _statusBadgeSmall(status),
                              ),
                            );
                          },
                        ),
                      const SizedBox(width: 12),
                      // 最新の更新日時を表示
                      Builder(
                        builder: (context) {
                          // noneでない最後のスロットの日時を取得
                          DateTime? latestTime;
                          for (int i = slots.length - 1; i >= 0; i--) {
                            final status = slots[i]['status'] as ProblemStatus?;
                            if (status != null && status != ProblemStatus.none) {
                              final time = slots[i]['time'] as DateTime?;
                              if (time != null) {
                                latestTime = time;
                                break;
                              }
                            }
                          }
                          if (latestTime != null) {
                            return Text(
                              l10n.recordSavedAt(_formatDtShort(latestTime)),
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87),
                              overflow: TextOverflow.ellipsis,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => onOpenDetail(problem),
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: Text(l10n.details),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: const Size(0, 32),
                  ),
                ),
              ],
            ),
            subtitle: Builder(
              builder: (context) {
                final localizedEquation = problem.getLocalizedEquation(context);
                final localizedConditions = problem.getLocalizedConditions(context);
                final localizedConstants = problem.getLocalizedConstants(context);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 微分方程式を表示
                    if (localizedEquation != null && localizedEquation.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 12),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const ClampingScrollPhysics(),
                          child: Math.tex(
                            localizedEquation,
                            mathStyle: MathStyle.text,
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                    // 初期条件を表示
                    if (localizedConditions != null && localizedConditions.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const ClampingScrollPhysics(),
                          child: Math.tex(
                            localizedConditions,
                            mathStyle: MathStyle.text,
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                    // パラメータ条件を表示
                    if (localizedConstants != null && localizedConstants.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const ClampingScrollPhysics(),
                          child: Math.tex(
                            localizedConstants,
                            mathStyle: MathStyle.text,
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
            isThreeLine: problem.equation != null || problem.conditions != null || problem.constants != null,
          ),
        );
      },
    );
  }
}

