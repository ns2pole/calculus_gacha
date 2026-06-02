import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class AiChatInstallationIdStore {
  AiChatInstallationIdStore({required this.storageKey});

  final String storageKey;

  Future<String> getOrCreate() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(storageKey);
    if (existing != null && existing.isNotEmpty) return existing;

    final generated = _generate();
    await prefs.setString(storageKey, generated);
    return generated;
  }

  static String _generate() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    return base64UrlEncode(bytes).replaceAll('=', '');
  }
}
