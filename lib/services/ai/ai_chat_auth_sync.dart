import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../auth/firebase_auth_service.dart';
import 'ai_chat_session_store.dart';

/// Listens for auth changes to migrate anonymous AI chat sessions on sign-in.
class AiChatAuthSync {
  AiChatAuthSync._();

  static StreamSubscription<User?>? _subscription;
  static String? _lastUid;

  static void initialize() {
    if (_subscription != null) return;
    _lastUid = FirebaseAuthService.userId;
    _subscription = FirebaseAuthService.authStateChanges.listen(_onAuthState);
  }

  static Future<void> _onAuthState(User? user) async {
    final uid = user?.uid;
    if (uid != null && uid != _lastUid) {
      try {
        await AiChatSessionStore.onUserSignedIn(uid);
      } catch (e, stack) {
        debugPrint('[AiChatAuthSync] Sign-in sync failed: $e');
        debugPrintStack(stackTrace: stack, label: '[AiChatAuthSync]');
      }
    }
    _lastUid = uid;
  }

  static void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _lastUid = null;
  }
}
