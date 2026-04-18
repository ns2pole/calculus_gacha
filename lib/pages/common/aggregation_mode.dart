/// 集計モード：最新1回のみ or 最新3回分（slots 全部）
import '../../l10n/app_localizations.dart';

enum AggregationMode { latest1, latest3 }

extension AggregationModeExt on AggregationMode {
  String label(AppLocalizations l10n) {
    // Locale-safe (any language): caller provides l10n instance.
    switch (this) {
      case AggregationMode.latest1:
        return l10n.aggregateLatestNLong(1);
      case AggregationMode.latest3:
        return l10n.aggregateLatestNLong(3);
    }
  }

  int toInt() => index;
}

class AggregationModeFactory {
  static AggregationMode fromInt(int v) {
    if (v < 0 || v >= AggregationMode.values.length) return AggregationMode.latest1;
    return AggregationMode.values[v];
  }
}

