import 'package:ai_chat_kit/ai_chat_kit.dart';

import '../../integrations/ai_chat/joymath_ai_chat_client_factory.dart';

/// Legacy export. Instantiate via [JoymathAiChatClientFactory.createDefault].
@Deprecated('Use JoymathAiChatClientFactory.createDefault()')
typedef CloudAiChatClient = HttpAiChatClient;

AiChatClient createCloudAiChatClient() =>
    JoymathAiChatClientFactory.createDefault();
