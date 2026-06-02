import 'package:ai_chat_kit/ai_chat_kit.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/math_problem.dart';
import '../../utils/l10n_utils.dart';

class JoymathSessionMapper {
  const JoymathSessionMapper._();

  static AiChatSessionPayload fromMathProblem({
    required BuildContext context,
    required MathProblem problem,
    required int problemIndex,
    required bool hintShown,
    required bool answerShown,
    required String questionText,
    String? referenceAnswer,
    String? referenceSolution,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return AiChatSessionPayload(
      contentId: problem.id,
      title: '${l10n.askAi} - ${l10n.problemIndex(problemIndex)}',
      questionText: questionText,
      category: problem.getLocalizedCategory(context),
      level: problem.getLocalizedLevel(context),
      referenceAnswer: referenceAnswer,
      referenceSolution: referenceSolution,
      hintShown: hintShown,
      answerShown: answerShown,
    );
  }
}
