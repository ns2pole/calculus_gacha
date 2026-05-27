import 'dart:async';
import 'dart:convert';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../ai/ai_chat_api_config.dart';

enum AiTutorEntitlementSyncFailureReason {
  endpointNotConfigured,
  notSignedIn,
  serverRejected,
  inactive,
  timeout,
  unexpected,
}

class AiTutorEntitlementSyncResult {
  final bool active;
  final AiTutorEntitlementSyncFailureReason? failureReason;
  final String? detail;

  const AiTutorEntitlementSyncResult._({
    required this.active,
    this.failureReason,
    this.detail,
  });

  const AiTutorEntitlementSyncResult.active() : this._(active: true);

  const AiTutorEntitlementSyncResult.failed(
    AiTutorEntitlementSyncFailureReason reason, {
    String? detail,
  }) : this._(active: false, failureReason: reason, detail: detail);
}

class AiTutorEntitlementSyncService {
  AiTutorEntitlementSyncService._();

  static Future<bool> syncAfterPurchaseOrRestore({
    AiChatApiConfig? config,
    http.Client? httpClient,
  }) async {
    final result = await syncAfterPurchaseOrRestoreDetailed(
      config: config,
      httpClient: httpClient,
    );
    return result.active;
  }

  static Future<AiTutorEntitlementSyncResult>
  syncAfterPurchaseOrRestoreDetailed({
    AiChatApiConfig? config,
    http.Client? httpClient,
  }) async {
    final resolvedConfig = config ?? AiChatApiConfig.fromEnvironment();
    final endpoint = resolvedConfig.entitlementSyncEndpoint;
    if (endpoint == null) {
      debugPrint('[AiTutorEntitlementSync] Endpoint is not configured');
      return const AiTutorEntitlementSyncResult.failed(
        AiTutorEntitlementSyncFailureReason.endpointNotConfigured,
      );
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      debugPrint(
        '[AiTutorEntitlementSync] Skipped because user is not signed in',
      );
      return const AiTutorEntitlementSyncResult.failed(
        AiTutorEntitlementSyncFailureReason.notSignedIn,
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
          .timeout(const Duration(seconds: 20));

      if (response.statusCode != 200) {
        debugPrint(
          '[AiTutorEntitlementSync] Failed: status=${response.statusCode}, '
          'body=${response.body}',
        );
        return AiTutorEntitlementSyncResult.failed(
          AiTutorEntitlementSyncFailureReason.serverRejected,
          detail: 'HTTP ${response.statusCode}',
        );
      }

      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      final active =
          decoded is Map<String, dynamic> && decoded['active'] == true;
      debugPrint('[AiTutorEntitlementSync] Synced: active=$active');
      if (active) return const AiTutorEntitlementSyncResult.active();
      return const AiTutorEntitlementSyncResult.failed(
        AiTutorEntitlementSyncFailureReason.inactive,
      );
    } on TimeoutException {
      debugPrint('[AiTutorEntitlementSync] Timed out');
      return const AiTutorEntitlementSyncResult.failed(
        AiTutorEntitlementSyncFailureReason.timeout,
      );
    } catch (e) {
      debugPrint('[AiTutorEntitlementSync] Failed: $e');
      return AiTutorEntitlementSyncResult.failed(
        AiTutorEntitlementSyncFailureReason.unexpected,
        detail: e.toString(),
      );
    } finally {
      if (shouldCloseClient) client.close();
    }
  }
}
