import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../l10n/app_localizations.dart';
import '../../pages/common/aggregation_mode.dart';
import '../../services/problems/exclusion_logic.dart';
import '../../models/learning_status.dart';
import '../../pages/gacha/gacha_settings_page.dart' show GachaFilterMode, GachaFilterModeExt, kGachaDisplayOrder, GachaFilterModeConversion, ExclusionModeConversion;
import '../../services/problems/simple_data_manager.dart';
import '../../pages/common/problem_list_menu_utils.dart' show showFilterMenu;

/// 除外設定フィルターチップ（共通化）
class ExclusionFilterChip extends StatelessWidget {
  final ExclusionMode exclusionMode;
  final GlobalKey filterChipKey;
  final VoidCallback onTap;
  final Widget Function() buildContent;

  const ExclusionFilterChip({
    super.key,
    required this.exclusionMode,
    required this.filterChipKey,
    required this.onTap,
    required this.buildContent,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          key: filterChipKey,
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
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(Icons.filter_list, size: 18, color: Colors.purple[700]),
              const SizedBox(width: 8),
              Expanded(
                child: Center(child: buildContent()),
              ),
              const SizedBox(width: 8),
              Icon(Icons.expand_more, size: 20, color: Colors.purple[600]),
            ],
          ),
        ),
      ),
    );
  }
}

/// 集計設定フィルターチップ（共通化）
class AggregationFilterChip extends StatelessWidget {
  final AggregationMode aggregationMode;
  final VoidCallback onTap;

  const AggregationFilterChip({
    super.key,
    required this.aggregationMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Builder(
        builder: (context) {
          final GlobalKey aggregationChipKey = GlobalKey();
          return GestureDetector(
            onTap: () {
              final RenderBox? renderBox = aggregationChipKey.currentContext?.findRenderObject() as RenderBox?;
              if (renderBox != null) {
                final position = renderBox.localToGlobal(Offset.zero);
                final size = renderBox.size;
                onTap();
              } else {
                onTap();
              }
            },
            child: Container(
              key: aggregationChipKey,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFF4E6), Color(0xFFFFF9F0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.orange.withOpacity(0.3), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(Icons.bar_chart, size: 18, color: Colors.orange[700]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      aggregationMode == AggregationMode.latest1
                          ? l10n.aggregateLatestN(1)
                          : l10n.aggregateLatestN(3),
                      style: TextStyle(fontSize: 17, color: Colors.orange[700], fontWeight: FontWeight.w500),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.expand_more, size: 20, color: Colors.orange[600]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// 青色フィルタリングガジェット（共通化）
class BlueFilterChip extends StatelessWidget {
  final GlobalKey filterChipKey;
  final VoidCallback onTap;
  final String filterLabel;
  final double iconSize;
  final String problemCountText;
  final Widget? statusBadge;
  final String? additionalText;
  final bool showProblemCountOnSecondLine;

  const BlueFilterChip({
    super.key,
    required this.filterChipKey,
    required this.onTap,
    required this.filterLabel,
    this.iconSize = 18.0,
    required this.problemCountText,
    this.statusBadge,
    this.additionalText,
    this.showProblemCountOnSecondLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          key: filterChipKey,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE3F2FD), Color(0xFFF1F8E9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blue.withOpacity(0.3), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(Icons.filter_list, size: iconSize, color: Colors.blue[700]),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 4,
                      runSpacing: 2,
                      children: [
                        Text(
                          filterLabel,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w500,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                        ),
                        if (statusBadge != null) statusBadge!,
                        if (additionalText != null)
                          Text(
                            additionalText!,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.blue[700],
                              fontWeight: FontWeight.w500,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                          ),
                        if (!showProblemCountOnSecondLine)
                          Text(
                            problemCountText,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.blue[600],
                              fontWeight: FontWeight.w500,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                    if (showProblemCountOnSecondLine) ...[
                      const SizedBox(height: 2),
                      Text(
                        problemCountText,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue[600],
                          fontWeight: FontWeight.w500,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.expand_more, size: 20, color: Colors.blue[600]),
            ],
          ),
        ),
      ),
    );
  }
}

/// ガチャ画面用フィルターチップ
class GachaExclusionFilterWidget extends StatefulWidget {
  final String prefsPrefix;
  final GachaFilterMode? gachaFilterMode;
  final ExclusionMode? exclusionMode;
  final String problemCountText;
  final double iconSize;
  final bool? showStatusBadge;
  final String? additionalText;
  final Function(GachaFilterMode)? onGachaFilterModeChanged;
  final Function(ExclusionMode)? onExclusionModeChanged;

  const GachaExclusionFilterWidget({
    super.key,
    required this.prefsPrefix,
    this.gachaFilterMode,
    this.exclusionMode,
    required this.problemCountText,
    this.iconSize = 18.0,
    this.showStatusBadge,
    this.additionalText,
    this.onGachaFilterModeChanged,
    this.onExclusionModeChanged,
  });

  @override
  State<GachaExclusionFilterWidget> createState() => _GachaExclusionFilterWidgetState();
}

class _GachaExclusionFilterWidgetState extends State<GachaExclusionFilterWidget> {
  final GlobalKey _filterChipKey = GlobalKey();

  Future<void> _showFilterMenu(BuildContext context, {Offset? position, Size? size}) async {
    // 共通のフィルタリングメニューを表示
    final selected = await showFilterMenu(
      context,
      widget.exclusionMode ?? widget.gachaFilterMode?.toExclusionMode() ?? ExclusionMode.none,
      position: position,
      size: size,
    );

    if (selected != null) {
      if (widget.onGachaFilterModeChanged != null) {
        widget.onGachaFilterModeChanged!(selected.toGachaFilterMode());
      }
      if (widget.onExclusionModeChanged != null) {
        widget.onExclusionModeChanged!(selected);
      }
      // 設定を保存
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('${widget.prefsPrefix}_gacha_exclusion_mode', selected.index);
    }
  }

  Widget _buildStatusBadge(LearningStatus s, {double diameter = 20.0}) {
    final double iconSize = diameter * 0.6;
    return Container(
      width: diameter,
      height: diameter,
      decoration: const BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(Icons.check, size: iconSize, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // 因数分解ガチャと同じ形式で表示
    String filterLabel;
    Widget? statusBadge;
    String? additionalText = widget.additionalText;
    
    // GachaFilterModeを使用する場合
    if (widget.gachaFilterMode != null) {
      if (widget.gachaFilterMode == GachaFilterMode.random) {
        filterLabel = l10n.filterModeRandom; // 「完全ランダム」を表示
        statusBadge = null;
        additionalText = null;
      } else {
        filterLabel = widget.gachaFilterMode!.label(context);
        statusBadge = (widget.showStatusBadge ?? true) 
            ? _buildStatusBadge(LearningStatus.solved, diameter: 20.8)
            : null;
        additionalText ??= l10n.removeFromGacha;
      }
    } 
    // ExclusionModeを使用する場合
    else if (widget.exclusionMode != null) {
      if (widget.exclusionMode == ExclusionMode.none) {
        filterLabel = l10n.allDisplayed;
        statusBadge = null;
        additionalText = null;
      } else {
        // 「最新N回が」の形式に変換
        int n;
        switch (widget.exclusionMode!) {
          case ExclusionMode.latest1:
            n = 1;
            break;
          case ExclusionMode.latest2:
            n = 2;
            break;
          case ExclusionMode.latest3:
            n = 3;
            break;
          case ExclusionMode.none:
            n = 0;
            break;
        }
        filterLabel = l10n.latestNTimesShort(n);
        statusBadge = (widget.showStatusBadge ?? true)
            ? _buildStatusBadge(LearningStatus.solved, diameter: 20.8)
            : null;
        additionalText ??= l10n.removeFromGacha;
      }
    } else {
      // フォールバック（通常は到達しない）
      filterLabel = l10n.allDisplayed;
      statusBadge = null;
      additionalText = null;
    }
    
    return BlueFilterChip(
      filterChipKey: _filterChipKey,
      onTap: () async {
        // フィルタリングメニューを直接表示（無償で利用可能）
        final RenderBox? renderBox = _filterChipKey.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          final size = renderBox.size;
          _showFilterMenu(context, position: position, size: size);
        } else {
          _showFilterMenu(context);
        }
      },
      filterLabel: filterLabel,
      iconSize: widget.iconSize,
      problemCountText: widget.problemCountText,
      statusBadge: statusBadge,
      additionalText: additionalText,
      showProblemCountOnSecondLine: widget.gachaFilterMode == GachaFilterMode.random,
    );
  }
}
