import 'ai_chat_api_config.dart';
import 'ai_chat_client.dart';
import 'cloud_ai_chat_client.dart';

class AiChatClientFactory {
  const AiChatClientFactory._();

  static AiChatClient createDefault() {
    final config = AiChatApiConfig.fromEnvironment();
    if (!config.isConfigured) {
      return const StubAiChatClient();
    }

    return CloudAiChatClient(config: config);
  }
}
