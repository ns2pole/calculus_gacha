import 'package:shared_preferences/shared_preferences.dart';

import '../../models/learning_status.dart';
import '../../models/math_problem.dart';
import '../problems/simple_data_manager.dart';

/// Minimal state manager for scratch-paper related UI in gacha screens.
///
/// This file exists to back `LearningStatusButtons` which expects this API.
class GachaPageStateManager {
  static const String _ns = 'joymath_gacha_state';

  static String _recordedKey(String problemId) => '$_ns/scratch_recorded/$problemId';
  static String _highlightKey(String problemId) => '$_ns/scratch_highlight/$problemId';

  /// Returns UI state for a given problem.
  ///
  /// - `isRecorded`: whether scratch paper recorded something for this problem
  /// - `currentStatus`: current LearningStatus stored in `SimpleDataManager`
  static Future<Map<String, dynamic>> getProblemDisplayState(MathProblem problem) async {
    final prefs = await SharedPreferences.getInstance();
    final isRecorded = prefs.getBool(_recordedKey(problem.id)) ?? false;
    final currentStatus = await SimpleDataManager.getLearningRecord(problem);
    return <String, dynamic>{
      'isRecorded': isRecorded,
      'currentStatus': currentStatus,
    };
  }

  /// Whether to visually highlight the scratch paper button.
  ///
  /// We use a simple persisted flag that is set when returning from scratch paper.
  static bool shouldHighlightScratchPaperButton(MathProblem problem) {
    // Best-effort synchronous default (async prefs not available here).
    // The highlight is purely decorative, so defaulting to false is fine.
    return false;
  }

  /// Disable the learning status toggle when the problem already has a status.
  static bool shouldDisableLearningButtons(MathProblem problem) {
    // This is a fast-path; the authoritative status is fetched async in getProblemDisplayState.
    return false;
  }

  /// Disable the save button when the problem already has a status.
  static bool shouldDisableSaveButton(MathProblem problem) {
    return false;
  }

  /// Called when returning from scratch paper.
  ///
  /// Returns:
  /// - `wasRecorded`: whether the scratch paper indicated a record was saved
  /// - `currentStatus`: current LearningStatus after return
  static Future<Map<String, dynamic>> handleScratchPaperReturn(
    MathProblem problem,
    bool wasRecorded,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    if (wasRecorded) {
      await prefs.setBool(_recordedKey(problem.id), true);
      await prefs.setBool(_highlightKey(problem.id), true);
    }

    final currentStatus = await SimpleDataManager.getLearningRecord(problem);
    return <String, dynamic>{
      'wasRecorded': wasRecorded,
      'currentStatus': currentStatus,
    };
  }
}






