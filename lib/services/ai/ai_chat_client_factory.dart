export '../../integrations/ai_chat/joymath_ai_chat_client_factory.dart'
    show JoymathAiChatClientFactory;

import 'package:ai_chat_kit/ai_chat_kit.dart';

import '../../integrations/ai_chat/joymath_ai_chat_client_factory.dart';

class AiChatClientFactory {
  const AiChatClientFactory._();

  static AiChatClient createDefault() =>
      JoymathAiChatClientFactory.createDefault();
}
