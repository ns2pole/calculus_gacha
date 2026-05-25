import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/ai_chat_context.dart';
import '../../models/ai_chat_message.dart';
import 'ai_chat_api_config.dart';
import 'ai_chat_client.dart';
import 'ai_chat_request_codec.dart';
import 'ai_chat_usage_policy.dart';

typedef AiChatAuthTokenProvider = Future<String?> Function();
typedef AiChatInstallationIdProvider = Future<String> Function();

class CloudAiChatClient implements AiChatClient {
  static const _installationIdKey = 'joymath/ai_chat_installation_id';

  final AiChatApiConfig config;
  final AiChatUsagePolicy usagePolicy;
  final AiChatRequestCodec requestCodec;
  final AiChatAuthTokenProvider authTokenProvider;
  final AiChatInstallationIdProvider installationIdProvider;
  final http.Client _httpClient;

  CloudAiChatClient({
    required this.config,
    this.usagePolicy = const AiChatUsagePolicy(),
    this.requestCodec = const AiChatRequestCodec(),
    AiChatAuthTokenProvider? authTokenProvider,
    AiChatInstallationIdProvider? installationIdProvider,
    http.Client? httpClient,
  }) : authTokenProvider = authTokenProvider ?? _defaultAuthTokenProvider,
       installationIdProvider =
           installationIdProvider ?? _defaultInstallationIdProvider,
       _httpClient = httpClient ?? http.Client();

  @override
  Future<AiChatMessage> sendMessage({
    required AiChatContext context,
    required List<AiChatMessage> history,
    required AiChatMessage userMessage,
  }) async {
    final endpoint = config.endpoint;
    if (endpoint == null) {
      throw const AiChatClientException('AIチャットの接続先が設定されていません。');
    }

    final token = await authTokenProvider();
    final installationId = await installationIdProvider();

    final payload = requestCodec.encode(
      context: context,
      history: _trimHistory(history),
      userMessage: userMessage,
      clientInstallationId: installationId,
      usagePolicy: usagePolicy,
    );

    final headers = <String, String>{
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await _httpClient
        .post(endpoint, headers: headers, body: jsonEncode(payload))
        .timeout(config.timeout);

    final decoded = _decodeResponseBody(response);
    if (response.statusCode == 200) {
      final text = _readText(decoded);
      if (text.trim().isEmpty) {
        throw const AiChatClientException('AIから空の応答が返されました。');
      }
      return AiChatMessage(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        role: AiChatMessageRole.assistant,
        text: text,
        createdAt: DateTime.now(),
      );
    }

    throw AiChatClientException(
      _readErrorMessage(decoded) ?? 'AIチャットの応答取得に失敗しました。',
    );
  }

  List<AiChatMessage> _trimHistory(List<AiChatMessage> history) {
    const maxMessages = 12;
    if (history.length <= maxMessages) return history;
    return history.sublist(history.length - maxMessages);
  }

  Map<String, dynamic> _decodeResponseBody(http.Response response) {
    try {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      if (decoded is Map<String, dynamic>) return decoded;
    } catch (_) {
      // Fall through to the generic error message.
    }
    return const {};
  }

  String _readText(Map<String, dynamic> decoded) {
    final message = decoded['message'];
    if (message is Map<String, dynamic> && message['text'] is String) {
      return message['text'] as String;
    }
    final text = decoded['text'];
    return text is String ? text : '';
  }

  String? _readErrorMessage(Map<String, dynamic> decoded) {
    final error = decoded['error'];
    if (error is Map<String, dynamic> && error['message'] is String) {
      return error['message'] as String;
    }
    return null;
  }

  static Future<String?> _defaultAuthTokenProvider() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    return user.getIdToken();
  }

  static Future<String> _defaultInstallationIdProvider() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_installationIdKey);
    if (existing != null && existing.isNotEmpty) return existing;

    final generated = _generateInstallationId();
    await prefs.setString(_installationIdKey, generated);
    return generated;
  }

  static String _generateInstallationId() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    return base64UrlEncode(bytes).replaceAll('=', '');
  }
}
