import 'package:ai_chat_kit/ai_chat_kit.dart';
import 'package:flutter/material.dart';

import 'joymath_ai_chat_client_factory.dart';
import 'joymath_ai_chat_ports.dart';
import '../../models/math_problem.dart';
import 'joymath_session_mapper.dart';

typedef JoymathAiChatTextRenderer = Widget Function(String text);

class JoymathAiChatLauncher {
  const JoymathAiChatLauncher._();

  static Future<void> open({
    required BuildContext context,
    required AiChatSessionPayload session,
    JoymathAiChatTextRenderer? textRenderer,
    JoymathAiChatTextRenderer? assistantTextRenderer,
    List<AiChatMessage> initialMessages = const [],
    ValueChanged<List<AiChatMessage>>? onMessagesChanged,
    AiChatClient? client,
    AiChatVoiceOptions voice = AiChatVoiceOptions.defaults,
  }) async {
    final ports = JoymathAiChatPorts(context);
    await ports.preloadPrice();

    if (!context.mounted) return;

    return AiChatKit.showSession(
      context: context,
      session: session,
      client: client ?? JoymathAiChatClientFactory.createDefault(),
      host: ports,
      textRenderer: textRenderer,
      assistantTextRenderer: assistantTextRenderer,
      initialMessages: initialMessages,
      onMessagesChanged: onMessagesChanged,
      voice: voice,
    );
  }

  static AiChatSessionPayload mapMathProblem({
    required BuildContext context,
    required MathProblem problem,
    required int problemIndex,
    required bool hintShown,
    required bool answerShown,
    required String questionText,
    String? referenceAnswer,
    String? referenceSolution,
  }) {
    return JoymathSessionMapper.fromMathProblem(
      context: context,
      problem: problem,
      problemIndex: problemIndex,
      hintShown: hintShown,
      answerShown: answerShown,
      questionText: questionText,
      referenceAnswer: referenceAnswer,
      referenceSolution: referenceSolution,
    );
  }
}
