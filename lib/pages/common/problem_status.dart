/// スロットが取りうる状態
enum ProblemStatus { none, solved, understood, failed }

/// 文字列キーからProblemStatusに変換
ProblemStatus keyToStatus(String k) {
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

/// スロット数（定数）
const int slotCount = 3;

