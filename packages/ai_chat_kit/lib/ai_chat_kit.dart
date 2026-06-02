library ai_chat_kit;

export 'src/models/ai_chat_message.dart';
export 'src/models/ai_chat_quick_reply.dart';
export 'src/models/ai_chat_session_payload.dart';
export 'src/ports/ai_chat_host_ports.dart';
export 'src/ports/ai_chat_strings.dart';
export 'src/services/ai_chat_api_config.dart';
export 'src/services/ai_chat_client.dart';
export 'src/services/ai_chat_installation_id.dart';
export 'src/services/ai_chat_request_codec.dart';
export 'src/services/http_ai_chat_client.dart';
export 'src/voice/ai_chat_preferences.dart';
export 'src/voice/ai_chat_voice_options.dart';
export 'src/voice/voice_send_mode.dart';
export 'src/widgets/ai_chat_bottom_sheet.dart';

import 'package:flutter/material.dart';

import 'src/models/ai_chat_message.dart';
import 'src/models/ai_chat_session_payload.dart';
import 'src/ports/ai_chat_host_ports.dart';
import 'src/services/ai_chat_client.dart';
import 'src/voice/ai_chat_voice_options.dart';
import 'src/widgets/ai_chat_bottom_sheet.dart';

/// Entry point for host apps to open a problem-scoped AI chat session.
class AiChatKit {
  const AiChatKit._();

  static Future<void> showSession({
    required BuildContext context,
    required AiChatSessionPayload session,
    required AiChatClient client,
    required AiChatHostPorts host,
    AiChatTextRenderer? textRenderer,
    AiChatTextRenderer? assistantTextRenderer,
    List<AiChatMessage> initialMessages = const [],
    ValueChanged<List<AiChatMessage>>? onMessagesChanged,
    AiChatVoiceOptions voice = AiChatVoiceOptions.defaults,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => AiChatBottomSheet(
        session: session,
        client: client,
        host: host,
        textRenderer: textRenderer,
        assistantTextRenderer: assistantTextRenderer,
        initialMessages: initialMessages,
        onMessagesChanged: onMessagesChanged,
        voice: voice,
      ),
    );
  }
}
