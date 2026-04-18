// lib/models/learning_status.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

/// 学習状態を表す列挙型
enum LearningStatus {
  none,
  solved,
  understood,
  failed,
}

/// 学習状態の拡張メソッド
extension LearningStatusExtension on LearningStatus {
  /// 学習状態を文字列に変換
  String get key {
    switch (this) {
      case LearningStatus.solved:
        return 'solved';
      case LearningStatus.understood:
        return 'understood';
      case LearningStatus.failed:
        return 'failed';
      case LearningStatus.none:
      default:
        return 'none';
    }
  }
  
  /// ローカライズされた表示名を取得
  String getLocalizedDisplayName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case LearningStatus.solved:
        return l10n.learningStatus_solved;
      case LearningStatus.understood:
        return l10n.learningStatus_understood;
      case LearningStatus.failed:
        return l10n.learningStatus_failed;
      case LearningStatus.none:
      default:
        return l10n.learningStatus_none;
    }
  }
  
  /// 文字列から学習状態を取得
  static LearningStatus fromKey(String key) {
    switch (key) {
      case 'solved':
        return LearningStatus.solved;
      case 'understood':
        return LearningStatus.understood;
      case 'failed':
        return LearningStatus.failed;
      default:
        return LearningStatus.none;
    }
  }
  
  /// 学習状態に対応するアイコンを取得
  IconData get icon {
    switch (this) {
      case LearningStatus.solved:
        return Icons.check_circle;
      case LearningStatus.understood:
        return Icons.lightbulb;
      case LearningStatus.failed:
        return Icons.cancel;
      case LearningStatus.none:
      default:
        return Icons.radio_button_unchecked;
    }
  }
  
  /// 学習状態に対応する色を取得
  Color get color {
    switch (this) {
      case LearningStatus.solved:
        return Colors.green;
      case LearningStatus.understood:
        return Colors.amber;
      case LearningStatus.failed:
        return Colors.red;
      case LearningStatus.none:
      default:
        return Colors.grey;
    }
  }
  
  /// ローカライズされたツールチップテキストを取得
  String getLocalizedTooltip(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case LearningStatus.solved:
        return l10n.learningStatusTooltip_solved;
      case LearningStatus.understood:
        return l10n.learningStatusTooltip_understood;
      case LearningStatus.failed:
        return l10n.learningStatusTooltip_failed;
      case LearningStatus.none:
      default:
        return l10n.learningStatusTooltip_none;
    }
  }
  
  /// 次の学習状態を取得（循環）
  LearningStatus get next {
    switch (this) {
      case LearningStatus.none:
        return LearningStatus.solved;
      case LearningStatus.solved:
        return LearningStatus.understood;
      case LearningStatus.understood:
        return LearningStatus.failed;
      case LearningStatus.failed:
        return LearningStatus.none;
    }
  }
}
