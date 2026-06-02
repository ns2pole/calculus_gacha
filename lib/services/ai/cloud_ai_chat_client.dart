import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/ai_chat_context.dart';
import '../../models/ai_chat_message.dart';
import '../../models/ai_chat_quick_reply.dart';
import 'ai_chat_api_config.dart';
import 'ai_chat_client.dart';
import 'ai_chat_request_codec.dart';

typedef AiChatAuthTokenProvider = Future<String?> Function();
typedef AiChatAppCheckTokenProvider = Future<String?> Function();
typedef AiChatInstallationIdProvider = Future<String> Function();

class CloudAiChatClient implements AiChatClient {
  static const _installationIdKey = 'joymath/ai_chat_installation_id';

  final AiChatApiConfig config;
  final AiChatRequestCodec requestCodec;
  final AiChatAuthTokenProvider authTokenProvider;
  final AiChatAppCheckTokenProvider appCheckTokenProvider;
  final AiChatInstallationIdProvider installationIdProvider;
  final http.Client _httpClient;

  CloudAiChatClient({
    required this.config,
    this.requestCodec = const AiChatRequestCodec(),
    AiChatAuthTokenProvider? authTokenProvider,
    AiChatAppCheckTokenProvider? appCheckTokenProvider,
    AiChatInstallationIdProvider? installationIdProvider,
    http.Client? httpClient,
  }) : authTokenProvider = authTokenProvider ?? _defaultAuthTokenProvider,
       appCheckTokenProvider =
           appCheckTokenProvider ?? _defaultAppCheckTokenProvider,
       installationIdProvider =
           installationIdProvider ?? _defaultInstallationIdProvider,
       _httpClient = httpClient ?? http.Client();

  @override
  Future<AiChatMessage> sendMessage({
    required AiChatContext context,
    required List<AiChatMessage> history,
    required AiChatMessage userMessage,
    String? locale,
  }) async {
    final endpoint = config.endpoint;
    if (endpoint == null) {
      throw const AiChatClientException('AIチャットの接続先が設定されていません。');
    }

    try {
      final token = await authTokenProvider();
      final appCheckToken = await appCheckTokenProvider();
      final installationId = await installationIdProvider();

      final payload = requestCodec.encode(
        context: context,
        history: _trimHistory(history),
        userMessage: userMessage,
        clientInstallationId: installationId,
        locale: locale ?? _resolveLocale(),
      );

      final headers = <String, String>{
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
        if (appCheckToken != null) 'X-Firebase-AppCheck': appCheckToken,
      };

      final response = await _httpClient
          .post(endpoint, headers: headers, body: jsonEncode(payload))
          .timeout(config.timeout);

      final decoded = _decodeResponseBody(response);
      if (response.statusCode == 200) {
        final text = _readText(decoded);
        if (text.trim().isEmpty) {
          throw const AiChatClientException(
            'AIが回答を生成できませんでした。表現を変えてもう一度お試しください。',
            code: 'empty_ai_response',
          );
        }
        return AiChatMessage(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          role: AiChatMessageRole.assistant,
          text: text,
          quickReplies: _readQuickReplies(decoded),
          createdAt: DateTime.now(),
        );
      }

      final errorCode = _readErrorCode(decoded);
      final errorMessage = _readErrorMessage(decoded) ?? 'AIチャットの応答取得に失敗しました。';
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
        _toUserMessage(response.statusCode, errorCode),
        code: errorCode,
        statusCode: response.statusCode,
      );
    } on AiChatClientException {
      rethrow;
    } on TimeoutException catch (e, stackTrace) {
      _logFailure('timeout', e, stackTrace);
      throw const AiChatClientException(
        'AIの返答に時間がかかっています。短めに質問するか、もう一度お試しください。',
        code: 'timeout',
      );
    } on SocketException catch (e, stackTrace) {
      _logFailure('socket', e, stackTrace);
      throw const AiChatClientException(
        '通信状態を確認して、もう一度お試しください。',
        code: 'network',
      );
    } on http.ClientException catch (e, stackTrace) {
      _logFailure('http_client', e, stackTrace);
      throw const AiChatClientException(
        '通信状態を確認して、もう一度お試しください。',
        code: 'network',
      );
    } on FirebaseException catch (e, stackTrace) {
      _logFailure('firebase_${e.code}', e, stackTrace);
      throw const AiChatClientException(
        'AIチャットの認証確認に失敗しました。アプリを再起動してもう一度お試しください。',
        code: 'firebase',
      );
    } catch (e, stackTrace) {
      _logFailure('unexpected', e, stackTrace);
      throw const AiChatClientException(
        'AIチャットの通信に失敗しました。もう一度お試しください。',
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

  String _toUserMessage(int statusCode, String? code) {
    switch (code) {
      case 'app_check_required':
      case 'app_check_failed':
        return 'アプリの認証確認に失敗しました。アプリを再起動してもう一度お試しください。';
      case 'empty_gemini_response':
      case 'empty_ai_response':
        return 'AIが回答を生成できませんでした。表現を変えてもう一度お試しください。';
      case 'invalid_request':
      case 'invalid_context':
      case 'invalid_history':
      case 'invalid_message':
        return 'メッセージ内容を確認して、短くしてもう一度お試しください。';
      case 'gemini_error':
        if (statusCode == 503 || statusCode == 504) {
          return 'AIサーバーが混み合っています。少し時間をおいてお試しください。';
        }
        return 'AIが回答を生成できませんでした。表現を変えてもう一度お試しください。';
      case 'internal':
        return 'AIチャット側でエラーが発生しました。少し時間をおいてお試しください。';
    }

    if (statusCode == 408 || statusCode == 504) {
      return 'AIの返答に時間がかかっています。短めに質問するか、もう一度お試しください。';
    }
    if (statusCode == 413) {
      return 'メッセージが長すぎます。短くしてもう一度お試しください。';
    }
    if (statusCode >= 500) {
      return 'AIサーバーが混み合っています。少し時間をおいてお試しください。';
    }
    if (statusCode == 401 || statusCode == 403) {
      return 'アプリの認証確認に失敗しました。アプリを再起動してもう一度お試しください。';
    }
    if (statusCode >= 400) {
      return 'メッセージ内容を確認して、もう一度お試しください。';
    }

    return 'AIチャットの応答取得に失敗しました。もう一度お試しください。';
  }

  void _logHttpError(int statusCode, String? code, String message) {
    debugPrint(
      '[AiChat] HTTP error: status=$statusCode, code=${code ?? 'unknown'}, '
      'message=$message',
    );
  }

  void _logFailure(String code, Object error, StackTrace stackTrace) {
    debugPrint('[AiChat] Request failed: code=$code, error=$error');
    debugPrintStack(stackTrace: stackTrace, label: '[AiChat] stack');
  }

  static Future<String?> _defaultAuthTokenProvider() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    return user.getIdToken();
  }

  static Future<String?> _defaultAppCheckTokenProvider() {
    return FirebaseAppCheck.instance.getToken();
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

  static String _resolveLocale() {
    final locale = PlatformDispatcher.instance.locale;
    if (locale.languageCode == 'en') return 'en';
    return 'ja';
  }
}
