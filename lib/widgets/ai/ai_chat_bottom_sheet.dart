import 'package:ai_chat_kit/ai_chat_kit.dart';
import 'package:flutter/material.dart';

import '../../integrations/ai_chat/joymath_ai_chat_launcher.dart';
import '../../models/ai_chat_context.dart';
import '../../models/ai_chat_message.dart';
import '../../services/ai/ai_chat_client.dart';
import '../../services/ai/ai_chat_client_factory.dart';

typedef MathTextBuilder = Widget Function(String text);

@Deprecated('Use JoymathAiChatLauncher.open or AiChatKit.showSession')
Future<void> showAiChatBottomSheet({
  required BuildContext context,
  required AiChatContext chatContext,
  AiChatClient? client,
  MathTextBuilder? mathTextBuilder,
  MathTextBuilder? assistantTextBuilder,
  List<AiChatMessage> initialMessages = const [],
  ValueChanged<List<AiChatMessage>>? onMessagesChanged,
}) {
  return JoymathAiChatLauncher.open(
    context: context,
    session: chatContext,
    client: client ?? AiChatClientFactory.createDefault(),
    textRenderer: mathTextBuilder,
    assistantTextRenderer: assistantTextBuilder,
    initialMessages: initialMessages,
    onMessagesChanged: onMessagesChanged,
  );
}
