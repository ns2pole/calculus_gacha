// lib/services/exclusion_logic.dart
// 除外ルール系の処理

import '../../models/math_problem.dart';
import 'simple_data_manager.dart';

/// フィルタリング（除外）モード
enum ExclusionMode { none, latest1, latest2, latest3 }

extension ExclusionModeExt on ExclusionMode {
  int neededSolvedStreak() {
    switch (this) {
      case ExclusionMode.none:
        return 0;
      case ExclusionMode.latest1:
        return 1;
      case ExclusionMode.latest2:
        return 2;
      case ExclusionMode.latest3:
        return 3;
    }
  }

  String label() {
    switch (this) {
      case ExclusionMode.none:
        return '除外なし';
      case ExclusionMode.latest1:
        return '(最新1回が[緑アイコン]の問題を除く)';
      case ExclusionMode.latest2:
        return '(最新2回が[緑アイコン]の問題を除く)';
      case ExclusionMode.latest3:
        return '(最新3回が[緑アイコン]の問題を除く)';
    }
  }
}

/// 表示順（UI用）
const List<ExclusionMode> kExclusionDisplayOrder = [
  ExclusionMode.none,
  ExclusionMode.latest3,
  ExclusionMode.latest2,
  ExclusionMode.latest1,
];

/// 学習履歴を時刻でソート（最新が先頭になるように）
/// 除外フィルタの「最新から緑が連続」の判定に使用する。
/// 問題一覧タイルの丸アイコン順は [recentHistoryRecordsNewestFirstLeft]（保存スロット順）を使う。
List<Map<String, dynamic>> sortHistoryByTimeNewestFirst(List<Map<String, dynamic>> history) {
  final sorted = List<Map<String, dynamic>>.from(history);
  sorted.sort((a, b) {
    final timeAStr = a['time'] as String?;
    final timeBStr = b['time'] as String?;

    if (timeAStr == null && timeBStr == null) return 0;
    if (timeAStr == null) return 1; // nullは後ろに
    if (timeBStr == null) return -1; // nullは後ろに

    try {
      final timeA = DateTime.parse(timeAStr);
      final timeB = DateTime.parse(timeBStr);
      // 昇順ソート（古い順）→ その後逆順にして最新が先頭に
      return timeA.compareTo(timeB);
    } catch (_) {
      return 0;
    }
  });

  // ソート後、逆順にして最新が先頭になるようにする
  return sorted.reversed.toList();
}

/// `getLearningHistory` の配列は左から埋まる3スロット（インデックス昇順＝古い試行→新しい試行の並び）。
/// 一覧では左から「最新の試行」を並べるため、左端埋めの連続区間 `[0..lastNonNone]` を逆順にしたうえで
/// 先頭 [displayCount] 件を返す（時刻ソートはしない＝タップ編集 `_setSlot` と同じ物理スロットを見る）。
List<Map<String, dynamic>> recentHistoryRecordsNewestFirstLeft(
  List<Map<String, dynamic>> history, {
  required int displayCount,
  int storageSlotCount = 3,
}) {
  if (displayCount <= 0) return [];

  var buf = List<Map<String, dynamic>>.from(history);
  if (buf.length > storageSlotCount) {
    buf = buf.sublist(buf.length - storageSlotCount);
  }
  while (buf.length < storageSlotCount) {
    buf.add({'status': 'none', 'time': null});
  }

  var lastNonNone = -1;
  for (var i = 0; i < storageSlotCount; i++) {
    final st = (buf[i]['status'] as String?) ?? 'none';
    if (st != 'none') lastNonNone = i;
  }

  if (lastNonNone < 0) {
    return List.generate(
      displayCount,
      (_) => {'status': 'none', 'time': null},
    );
  }

  final prefix = buf.sublist(0, lastNonNone + 1);
  final newestFirst = prefix.reversed.toList();

  final out = <Map<String, dynamic>>[];
  for (var i = 0; i < displayCount; i++) {
    if (i < newestFirst.length) {
      out.add(Map<String, dynamic>.from(newestFirst[i]));
    } else {
      out.add({'status': 'none', 'time': null});
    }
  }
  return out;
}

/// 除外判定：最新の学習記録から見て緑が連続して何個並んでいるかを数え、needed以上なら除外
Future<bool> shouldExcludeByMode(MathProblem problem, ExclusionMode exclusionMode) async {
  // 除外モードがnoneの場合は除外しない
  if (exclusionMode == ExclusionMode.none) {
    return false;
  }

  final needed = exclusionMode.neededSolvedStreak();

  if (needed == 0) {
    return false;
  }

  // 学習履歴を取得
  final history = await SimpleDataManager.getLearningHistory(problem);
  return shouldExcludeByModeUsingHistory(history, exclusionMode);
}

/// 履歴（ローカルで既に取得済みのもの）から除外判定を行う。
/// - history は `SimpleDataManager.getLearningHistory()` と同じ形式を想定（{status: String, time: String?}）。
/// - UI側で大量の除外判定をする時に、SharedPreferencesアクセスを避けるために使う。
bool shouldExcludeByModeUsingHistory(
  List<Map<String, dynamic>> history,
  ExclusionMode exclusionMode,
) {
  if (exclusionMode == ExclusionMode.none) return false;

  final needed = exclusionMode.neededSolvedStreak();
  if (needed <= 0) return false;
  if (history.isEmpty) return false;

  // 時刻でソート（最新が先頭になるように）
  final reversed = sortHistoryByTimeNewestFirst(history);

  // 最新から順に、緑（solved）が連続して何個並んでいるかを数える
  var count = 0;
  for (final record in reversed) {
    final statusStr = record['status'] as String?;
    if (statusStr == 'solved') {
      count++;
      if (count >= needed) return true;
      continue;
    }
    if (statusStr != null && statusStr != 'none') {
      // 緑以外のステータスが来たら連続が途切れる
      break;
    }
  }
  return false;
}

