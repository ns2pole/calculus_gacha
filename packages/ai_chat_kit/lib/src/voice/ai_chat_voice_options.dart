import 'voice_send_mode.dart';

class AiChatVoiceOptions {
  final bool enabled;
  final VoiceSendMode defaultSendMode;

  const AiChatVoiceOptions({
    this.enabled = true,
    this.defaultSendMode = VoiceSendMode.manual,
  });

  const AiChatVoiceOptions.disabled()
      : enabled = false,
        defaultSendMode = VoiceSendMode.manual;

  static const defaults = AiChatVoiceOptions();
}
