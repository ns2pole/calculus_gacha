// 計算用紙ページの学習履歴保存と同一のスロット更新ロジック。
// ProblemStatus は必ず pages/common/problem_status.dart のものを使うこと
// （SimpleDataManager の型判定と整合させる）。

import '../../models/math_problem.dart';
import '../../pages/common/problem_status.dart';
import 'simple_data_manager.dart';

/// 既存の3スロット履歴に [newStatus] を書き込み、SimpleDataManager へ保存する。
///
/// - 左から最初の `none` に記録を入れる。全スロット埋まりならインデックス0に上書きし、
///   それより右のスロットを `none` にクリアする（計算用紙と同じ）。
/// - [newStatus] が [ProblemStatus.none] のときは保存せず `false` を返す。
Future<bool> appendLearningHistorySlot(
  MathProblem problem,
  ProblemStatus newStatus, {
  int slots = slotCount,
}) async {
  if (newStatus == ProblemStatus.none) {
    return false;
  }

  final history = await SimpleDataManager.getLearningHistory(problem);
  final current = <Map<String, dynamic>>[];

  for (var i = 0; i < slots; i++) {
    if (i < history.length) {
      final h = history[i];
      final parsed = ProblemStatus.values.firstWhere(
        (s) => s.name == h['status'],
        orElse: () => ProblemStatus.none,
      );
      final timeStr = h['time'] as String?;
      current.add({'status': parsed, 'time': timeStr});
    } else {
      current.add({'status': ProblemStatus.none, 'time': null});
    }
  }

  while (current.length < slots) {
    current.add({'status': ProblemStatus.none, 'time': null});
  }

  var targetSlot = -1;
  for (var i = 0; i < slots; i++) {
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
  current[targetSlot] = {'status': newStatus, 'time': t};

  for (var j = targetSlot + 1; j < current.length; j++) {
    current[j] = {'status': ProblemStatus.none, 'time': null};
  }

  return SimpleDataManager.saveLearningHistory(problem, current);
}
