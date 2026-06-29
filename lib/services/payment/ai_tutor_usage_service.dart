import 'dart:async';
import 'dart:convert';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../integrations/ai_chat/joymath_ai_chat_config.dart';
import '../../models/ai_tutor_usage_snapshot.dart';

class AiTutorUsageService {
  AiTutorUsageService._();

  static Future<AiTutorUsageSnapshot?> fetchUsage({
    http.Client? httpClient,
  }) async {
    final endpoint = JoymathAiChatConfig.aiTutorUsageEndpointFromEnvironment();
    if (endpoint == null) {
      debugPrint('[AiTutorUsage] Endpoint is not configured');
      return null;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return AiTutorUsageSnapshot.emptyFree;
    }

    final client = httpClient ?? http.Client();
    final shouldCloseClient = httpClient == null;
    try {
      final idToken = await user.getIdToken();
      final appCheckToken = await FirebaseAppCheck.instance.getToken();
      final response = await client
          .post(
            endpoint,
            headers: {
              'Content-Type': 'application/json',
              if (idToken != null) 'Authorization': 'Bearer $idToken',
              if (appCheckToken != null) 'X-Firebase-AppCheck': appCheckToken,
            },
            body: jsonEncode(const <String, dynamic>{}),
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode != 200) {
        debugPrint(
          '[AiTutorUsage] Failed: status=${response.statusCode}, '
          'body=${response.body}',
        );
        return null;
      }

      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      if (decoded is! Map<String, dynamic>) return null;
      return AiTutorUsageSnapshot.fromJson(decoded);
    } on TimeoutException {
      debugPrint('[AiTutorUsage] Timed out');
      return null;
    } catch (e) {
      debugPrint('[AiTutorUsage] Failed: $e');
      return null;
    } finally {
      if (shouldCloseClient) client.close();
    }
  }
}
