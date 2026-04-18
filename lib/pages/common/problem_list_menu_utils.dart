// lib/pages/problem_list_menu_utils.dart
// 問題一覧ページのメニュー表示ユーティリティ（problem_list_page.dartから分離）

import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/learning_status.dart';
import 'problem_status.dart';
import 'aggregation_mode.dart';
import '../../services/problems/exclusion_logic.dart';

// ヘルパー関数：ProblemStatusから色を取得
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

// ヘルパー関数：ProblemStatusからアイコンを取得
IconData _iconOfSmall(ProblemStatus s) {
  switch (s) {
    case ProblemStatus.solved:
      return Icons.check_circle;
    case ProblemStatus.understood:
      return Icons.lightbulb;
    case ProblemStatus.failed:
      return Icons.cancel;
    case ProblemStatus.none:
      return Icons.help_outline;
  }
}

// ヘルパー関数：ステータスバッジを構築
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

/// 集計設定メニューを表示
Future<AggregationMode?> showAggregationMenu(
  BuildContext context,
  AggregationMode currentMode, {
  Offset? position,
  Size? size,
}) async {
  final RenderBox? overlay = Overlay.of(context).context.findRenderObject() as RenderBox?;
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  // If we can measure anchor position/size, widen the menu beyond the chip width.
  // This prevents Row overflow for long localized strings.
  double? menuLeft;
  double? menuTop;
  double? menuWidth;
  if (position != null && size != null && overlay != null) {
    // Aim for a comfortable width, but clamp to the screen.
    const minMenuWidth = 260.0;
    menuWidth = (size.width > minMenuWidth ? size.width : minMenuWidth);
    menuWidth = menuWidth.clamp(160.0, screenWidth - 16.0);

    menuLeft = position.dx + (size.width / 2) - (menuWidth / 2);
    if (menuLeft < 8) {
      menuLeft = 8;
    } else if (menuLeft + menuWidth > screenWidth - 8) {
      menuLeft = screenWidth - menuWidth - 8;
    }
    menuTop = position.dy + size.height;
  }
  
  final AggregationMode? selected = await showMenu<AggregationMode>(
    context: context,
    position: (menuLeft != null && menuTop != null && menuWidth != null && overlay != null)
        ? RelativeRect.fromLTRB(
            menuLeft,
            menuTop,
            screenWidth - menuLeft - menuWidth,
            overlay.size.height - menuTop,
          )
        : null,
    items: AggregationMode.values.map((mode) {
      final l10n = AppLocalizations.of(context)!;
      Widget title = Text(mode == AggregationMode.latest1 ? l10n.aggregateLatestNLong(1) : l10n.aggregateLatestNLong(3), style: TextStyle(fontSize: 14, color: Colors.grey[900]));

      return PopupMenuItem<AggregationMode>(
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

  return selected;
}

/// フィルタ選択メニューを表示
Future<ExclusionMode?> showFilterMenu(
  BuildContext context,
  ExclusionMode currentMode, {
  Offset? position,
  Size? size,
}) async {
  final RenderBox? overlay = Overlay.of(context).context.findRenderObject() as RenderBox?;
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  // Widen the menu beyond the chip width to avoid RenderFlex overflow in menu rows.
  double? menuLeft;
  double? menuTop;
  double? menuWidth;
  if (position != null && size != null && overlay != null) {
    // The filter menu has a badge + 2 texts; give it a bit more room.
    const minMenuWidth = 280.0;
    menuWidth = (size.width > minMenuWidth ? size.width : minMenuWidth);
    menuWidth = menuWidth.clamp(180.0, screenWidth - 16.0);

    menuLeft = position.dx + (size.width / 2) - (menuWidth / 2);
    if (menuLeft < 8) {
      menuLeft = 8;
    } else if (menuLeft + menuWidth > screenWidth - 8) {
      menuLeft = screenWidth - menuWidth - 8;
    }
    menuTop = position.dy + size.height;
  }
  
  final ExclusionMode? selected = await showMenu<ExclusionMode>(
    context: context,
    position: (menuLeft != null && menuTop != null && menuWidth != null && overlay != null)
        ? RelativeRect.fromLTRB(
            menuLeft,
            menuTop,
            screenWidth - menuLeft - menuWidth,
            overlay.size.height - menuTop,
          )
        : null,
    items: kExclusionDisplayOrder.map((mode) {
      final l10n = AppLocalizations.of(context)!;
      Widget title;
      if (mode == ExclusionMode.none) {
        title = Text(l10n.allDisplayed, style: TextStyle(fontSize: 14, color: Colors.grey[900]));
      } else {
        int n;
        switch (mode) {
          case ExclusionMode.latest1:
            n = 1;
            break;
          case ExclusionMode.latest2:
            n = 2;
            break;
          case ExclusionMode.latest3:
          default:
            n = 3;
            break;
        }
        // Use Wrap so the label can naturally flow into 2 lines on small screens.
        title = Wrap(
          spacing: 4,
          runSpacing: 2,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(l10n.latestNTimesShort(n), style: TextStyle(fontSize: 14, color: Colors.grey[900])),
            _statusBadgeSmall(ProblemStatus.solved, diameter: 16.0),
            Text(l10n.excludeSuffix, style: TextStyle(fontSize: 14, color: Colors.grey[900])),
          ],
        );
      }

      return PopupMenuItem<ExclusionMode>(
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

  return selected;
}

