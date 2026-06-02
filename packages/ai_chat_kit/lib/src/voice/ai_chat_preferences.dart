import 'package:shared_preferences/shared_preferences.dart';

import 'voice_send_mode.dart';

class AiChatPreferences {
  static const voiceSendModeKey = 'ai_chat_kit.voice_send_mode';

  Future<VoiceSendMode> loadVoiceSendMode({
    VoiceSendMode defaultMode = VoiceSendMode.manual,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(voiceSendModeKey);
    if (raw == VoiceSendMode.auto.name) return VoiceSendMode.auto;
    if (raw == VoiceSendMode.manual.name) return VoiceSendMode.manual;
    return defaultMode;
  }

  Future<void> saveVoiceSendMode(VoiceSendMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(voiceSendModeKey, mode.name);
  }
}
