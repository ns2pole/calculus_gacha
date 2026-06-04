import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/ai_chat_message.dart';
import '../models/ai_chat_quick_reply.dart';
import '../models/ai_chat_session_payload.dart';
import 'ai_chat_api_config.dart';
import 'ai_chat_client.dart';
import 'ai_chat_installation_id.dart';
import 'ai_chat_request_codec.dart';

typedef AiChatHeadersProvider = Future<Map<String, String>> Function();
typedef AiChatLocaleResolver = String Function();

class HttpAiChatClient implements AiChatClient {
  final AiChatApiConfig config;
  final AiChatRequestCodec requestCodec;
  final AiChatHeadersProvider headersProvider;
  final AiChatInstallationIdStore installationIdStore;
  final AiChatLocaleResolver localeResolver;
  final http.Client _httpClient;

  HttpAiChatClient({
    required this.config,
    required this.headersProvider,
    this.requestCodec = const AiChatRequestCodec(),
    AiChatInstallationIdStore? installationIdStore,
    AiChatLocaleResolver? localeResolver,
    http.Client? httpClient,
  })  : installationIdStore = installationIdStore ??
            AiChatInstallationIdStore(
              storageKey: config.installationIdStorageKey,
            ),
        localeResolver = localeResolver ?? _defaultLocaleResolver,
        _httpClient = httpClient ?? http.Client();

  @override
  Future<AiChatMessage> sendMessage({
    required AiChatSessionPayload session,
    required List<AiChatMessage> history,
    required AiChatMessage userMessage,
    String? locale,
  }) async {
    final endpoint = config.endpoint;
    if (endpoint == null) {
      throw const AiChatClientException('AI chat endpoint is not configured.');
    }

    try {
      final installationId = await installationIdStore.getOrCreate();
      final payload = requestCodec.encode(
        session: session,
        history: _trimHistory(history),
        userMessage: userMessage,
        clientInstallationId: installationId,
        locale: locale ?? localeResolver(),
      );

      final authHeaders = await headersProvider();
      final headers = <String, String>{
        'Content-Type': 'application/json',
        ...authHeaders,
      };

      final response = await _httpClient
          .post(endpoint, headers: headers, body: jsonEncode(payload))
          .timeout(config.timeout);

      final decoded = _decodeResponseBody(response);
      if (response.statusCode == 200) {
        final text = _readText(decoded);
        if (text.trim().isEmpty) {
          throw const AiChatClientException(
            'AI could not generate a response. Try rephrasing your question.',
            code: 'empty_ai_response',
          );
        }
        return AiChatMessage(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          role: AiChatMessageRole.assistant,
          text: text,
          textRaw: _readTextRaw(decoded),
          quickReplies: _readQuickReplies(decoded),
          createdAt: DateTime.now(),
        );
      }

      final errorCode = _readErrorCode(decoded);
      final errorMessage =
          _readErrorMessage(decoded) ?? 'Failed to fetch AI chat response.';
      _logHttpError(response.statusCode, errorCode, errorMessage);
      if (response.statusCode == 429 || errorCode == 'rate_limited') {
        final rateLimit = _readRateLimitDetails(decoded);
        throw AiChatRateLimitException(
          errorMessage,
          code: errorCode,
          statusCode: response.statusCode,
          tier: rateLimit?.tier,
          monthlyLimit: rateLimit?.limit,
        );
      }

      throw AiChatClientException(
        errorMessage,
        code: errorCode,
        statusCode: response.statusCode,
      );
    } on AiChatClientException {
      rethrow;
    } on TimeoutException {
      throw const AiChatClientException(
        'The AI response timed out. Try a shorter question.',
        code: 'timeout',
      );
    } on SocketException {
      throw const AiChatClientException(
        'Check your network connection and try again.',
        code: 'network',
      );
    } on http.ClientException {
      throw const AiChatClientException(
        'Check your network connection and try again.',
        code: 'network',
      );
    } catch (e, stackTrace) {
      debugPrint('[HttpAiChatClient] Unexpected error: $e');
      debugPrintStack(stackTrace: stackTrace, label: '[HttpAiChatClient]');
      throw const AiChatClientException(
        'AI chat request failed. Please try again.',
        code: 'unexpected',
      );
    }
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
    } catch (_) {}
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

  String? _readTextRaw(Map<String, dynamic> decoded) {
    final message = decoded['message'];
    if (message is! Map<String, dynamic>) return null;
    final textRaw = message['textRaw'];
    if (textRaw is! String) return null;
    final trimmed = textRaw.trim();
    return trimmed.isEmpty ? null : textRaw;
  }

  List<AiChatQuickReply> _readQuickReplies(Map<String, dynamic> decoded) {
    final raw = decoded['quickReplies'];
    if (raw is! List) return const [];

    final replies = <AiChatQuickReply>[];
    for (final item in raw) {
      if (item is! Map<String, dynamic>) continue;
      try {
        replies.add(AiChatQuickReply.fromJson(item));
      } catch (_) {
        continue;
      }
      if (replies.length >= 5) break;
    }
    return List<AiChatQuickReply>.unmodifiable(replies);
  }

  String? _readErrorMessage(Map<String, dynamic> decoded) {
    final error = decoded['error'];
    if (error is Map<String, dynamic> && error['message'] is String) {
      return error['message'] as String;
    }
    return null;
  }

  String? _readErrorCode(Map<String, dynamic> decoded) {
    final error = decoded['error'];
    if (error is Map<String, dynamic> && error['code'] is String) {
      return error['code'] as String;
    }
    return null;
  }

  ({String? tier, int? limit})? _readRateLimitDetails(
    Map<String, dynamic> decoded,
  ) {
    final error = decoded['error'];
    if (error is! Map<String, dynamic>) return null;

    final tier = error['tier'];
    final limit = error['limit'];
    return (
      tier: tier is String ? tier : null,
      limit: limit is num ? limit.toInt() : null,
    );
  }

  void _logHttpError(int statusCode, String? code, String message) {
    debugPrint(
      '[HttpAiChatClient] HTTP error: status=$statusCode, '
      'code=${code ?? 'unknown'}, message=$message',
    );
  }

  static String _defaultLocaleResolver() {
    final locale = PlatformDispatcher.instance.locale;
    if (locale.languageCode == 'en') return 'en';
    return 'ja';
  }
}
