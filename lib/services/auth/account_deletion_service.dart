import 'dart:async';
import 'dart:convert';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../ai/ai_chat_api_config.dart';
import '../problems/simple_data_manager.dart';
import 'cloud_sync_preference_service.dart';
import 'firebase_auth_service.dart';

class AccountDeletionException implements Exception {
  final String code;
  final String message;
  final int? statusCode;

  const AccountDeletionException(
    this.message, {
    required this.code,
    this.statusCode,
  });

  @override
  String toString() => 'AccountDeletionException($code): $message';
}

class AccountDeletionService {
  AccountDeletionService._();

  static Future<void> deleteCurrentAccount({
    AiChatApiConfig? config,
    http.Client? httpClient,
  }) async {
    final endpoint =
        (config ?? AiChatApiConfig.fromEnvironment()).accountDeletionEndpoint;
    if (endpoint == null) {
      throw const AccountDeletionException(
        'アカウント削除の接続先が設定されていません。',
        code: 'endpoint_not_configured',
      );
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw const AccountDeletionException(
        'ログイン状態を確認できませんでした。',
        code: 'not_signed_in',
      );
    }

    final client = httpClient ?? http.Client();
    final shouldCloseClient = httpClient == null;
    try {
      final idToken = await user.getIdToken(true);
      final appCheckToken = await FirebaseAppCheck.instance.getToken();
      final response = await client
          .post(
            endpoint,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $idToken',
              if (appCheckToken != null) 'X-Firebase-AppCheck': appCheckToken,
            },
            body: jsonEncode(const <String, dynamic>{}),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode != 200) {
        throw AccountDeletionException(
          _readErrorMessage(response) ?? 'アカウント削除に失敗しました。',
          code: _readErrorCode(response) ?? 'server_rejected',
          statusCode: response.statusCode,
        );
      }

      await CloudSyncPreferenceService.removeForUser(user.uid);
      final cleared = await SimpleDataManager.clearAllData();
      if (!cleared) {
        debugPrint(
          '[AccountDeletion] Local data clear failed after server deletion',
        );
      }
      await FirebaseAuthService.signOut();
    } on TimeoutException {
      throw const AccountDeletionException(
        '通信に時間がかかっています。しばらくしてからもう一度お試しください。',
        code: 'timeout',
      );
    } on AccountDeletionException {
      rethrow;
    } catch (e) {
      debugPrint('[AccountDeletion] Failed: $e');
      throw AccountDeletionException(e.toString(), code: 'unexpected');
    } finally {
      if (shouldCloseClient) {
        client.close();
      }
    }
  }

  static String? _readErrorCode(http.Response response) {
    final decoded = _decodeResponse(response);
    if (decoded is Map<String, dynamic>) {
      final error = decoded['error'];
      if (error is Map<String, dynamic> && error['code'] is String) {
        return error['code'] as String;
      }
    }
    return null;
  }

  static String? _readErrorMessage(http.Response response) {
    final decoded = _decodeResponse(response);
    if (decoded is Map<String, dynamic>) {
      final error = decoded['error'];
      if (error is Map<String, dynamic> && error['message'] is String) {
        return error['message'] as String;
      }
    }
    return null;
  }

  static Object? _decodeResponse(http.Response response) {
    try {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } catch (_) {
      return null;
    }
  }
}
