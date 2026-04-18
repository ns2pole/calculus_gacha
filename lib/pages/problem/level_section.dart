import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/math_problem.dart';
import '../../utils/problem_level_utils.dart';
import '../common/aggregation_mode.dart';
import '../common/problem_status.dart';
import 'problem_tile.dart';

/// LevelSection（改良版：展開時にチャンクで徐々に項目を追加していく）
class LevelSection extends StatefulWidget {
  final String level;
  final List<MathProblem> items;
  final Map<ProblemStatus, int>? precomputedCounts;
  final Future<List<Map<String, dynamic>>> Function(MathProblem) getSlots;
  final AggregationMode aggregationMode;
  final Future<void> Function(MathProblem, int, ProblemStatus) onSetSlot;
  final Future<void> Function(MathProblem) onClearAll;
  final void Function(MathProblem, int displayNo) onOpenDetail;
  final int startIndex; // 全体を通しての開始インデックス
  final String? prefsPrefix; // ガチャタイプの識別子

  const LevelSection({
    super.key,
    required this.level,
    required this.items,
    this.precomputedCounts,
    required this.getSlots,
    required this.aggregationMode,
    required this.onSetSlot,
    required this.onClearAll,
    required this.onOpenDetail,
    this.startIndex = 0,
    this.prefsPrefix,
  });

  @override
  State<LevelSection> createState() => _LevelSectionState();
}

class _LevelSectionState extends State<LevelSection> {
  bool _expanded = false;

  // 非同期段階表示用
  int _visibleCount = 0;
  bool _isPopulating = false;
  bool _disposed = false;

  // チューニング可能
  final int initialChunk = 12; // 最初に表示
  final int chunk = 12; // 以降一度に追加
  final int delayMs = 80; // チャンク間の待ち時間（ms）

  @override
  void initState() {
    super.initState();
    _expanded = false;
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LevelSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items.length < oldWidget.items.length) {
      final newVisible = math.min(_visibleCount, widget.items.length);
      if (newVisible != _visibleCount) {
        _visibleCount = newVisible;
        if (mounted) setState(() {});
      }
    } else if (widget.items.length > oldWidget.items.length) {
      if (_expanded && !_isPopulating && _visibleCount < widget.items.length) {
        _startLazyPopulate();
      }
    }
  }

  Widget _buildCountChip(IconData icon, Color color, int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: Colors.white),
        ),
        const SizedBox(width: 6),
        Text(count.toString(), style: const TextStyle(fontSize: 13, color: Colors.black87)),
      ],
    );
  }

  /// 非同期でチャンクごとに _visibleCount を増やす
  Future<void> _startLazyPopulate() async {
    if (_isPopulating) return;
    _isPopulating = true;
    try {
      if (_disposed) return;
      setState(() {
        _visibleCount = widget.items.isEmpty ? 0 : math.min(widget.items.length, initialChunk);
      });

      while (!_disposed && _visibleCount < widget.items.length) {
        await Future.delayed(Duration(milliseconds: delayMs));
        if (_disposed) return;
        final next = math.min(widget.items.length, _visibleCount + chunk);
        if (next == _visibleCount) break;
        if (_disposed) return;
        setState(() {
          _visibleCount = next;
        });
      }
    } finally {
      _isPopulating = false;
    }
  }

  void _stopPopulateAndReset() {
    _visibleCount = 0;
    _isPopulating = false;
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.items.length;
    final visible = math.min(_visibleCount, widget.items.length);
    final l10n = AppLocalizations.of(context)!;

    final counts = widget.precomputedCounts;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ExpansionTile(
        initiallyExpanded: _expanded,
        onExpansionChanged: (v) {
          setState(() => _expanded = v);
          if (v) {
            _startLazyPopulate();
          } else {
            _stopPopulateAndReset();
            if (mounted) setState(() {});
          }
        },
        title: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 4,
          children: [
            Text(
              () {
                final parsed = parseProblemLevel(widget.level);
                return parsed == null ? widget.level : problemLevelLabel(context, parsed);
              }(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('(${itemCount})', style: const TextStyle(color: Colors.black54)),
            if (counts != null) ...[
              const SizedBox(width: 4),
              _buildCountChip(Icons.check_circle, Colors.green, counts[ProblemStatus.solved] ?? 0),
              _buildCountChip(Icons.lightbulb, Colors.orange, counts[ProblemStatus.understood] ?? 0),
              _buildCountChip(Icons.cancel, Colors.red, counts[ProblemStatus.failed] ?? 0),
            ],
            Icon(
              _expanded ? Icons.expand_less : Icons.expand_more,
              size: 20,
              color: Colors.grey[700],
            ),
          ],
        ),
        trailing: const SizedBox.shrink(),
        children: _expanded
            ? [
                SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: visible + (visible < widget.items.length ? 1 : 0),
                    itemBuilder: (ctx, i) {
                      if (i < visible) {
                        final p = widget.items[i];
                        return FutureBuilder<List<Map<String, dynamic>>>(
                          future: widget.getSlots(p),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return ListTile(
                                title: Text(l10n.loading),
                                leading: const CircularProgressIndicator(),
                              );
                            }
                            final slots = snapshot.data!;
                            return ProblemTile(
                              problem: p,
                              slots: slots,
                              displayNo: widget.startIndex + i + 1, // 全体を通しての連番
                              onSetSlot: (idx, st) => widget.onSetSlot(p, idx, st),
                              onClearAll: () => widget.onClearAll(p),
                              onOpenDetail: () => widget.onOpenDetail(p, widget.startIndex + i + 1),
                              prefsPrefix: widget.prefsPrefix,
                            );
                          },
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
                              const SizedBox(width: 10),
                              Text(l10n.loading),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ]
            : [],
      ),
    );
  }
}

