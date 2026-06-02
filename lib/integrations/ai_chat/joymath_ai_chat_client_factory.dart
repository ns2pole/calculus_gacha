import 'package:ai_chat_kit/ai_chat_kit.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'joymath_ai_chat_config.dart';

class JoymathAiChatClientFactory {
  const JoymathAiChatClientFactory._();

  static AiChatClient createDefault() {
    final config = JoymathAiChatConfig.apiConfigFromEnvironment();
    if (!config.isConfigured) {
      return const StubAiChatClient();
    }

    return HttpAiChatClient(
      config: config,
      headersProvider: authHeaders,
    );
  }

  static Future<Map<String, String>> authHeaders() async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    final appCheckToken = await FirebaseAppCheck.instance.getToken();
    return {
      if (token != null) 'Authorization': 'Bearer $token',
      if (appCheckToken != null) 'X-Firebase-AppCheck': appCheckToken,
    };
  }
}
