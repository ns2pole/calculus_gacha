import 'dart:convert';

import 'package:ai_chat_kit/ai_chat_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joymath/models/ai_chat_session_snapshot.dart';
import 'package:joymath/services/ai/ai_chat_message_codec.dart';
import 'package:joymath/services/ai/ai_chat_session_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('AiChatSessionStore local persistence', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('load returns empty when no data', () async {
      final messages = await AiChatSessionStore.load('problem_a');
      expect(messages, isEmpty);
    });

    test('save and load round-trip locally when not logged in', () async {
      final messages = [
        AiChatMessage(
          id: '1',
          role: AiChatMessageRole.user,
          text: 'question',
          createdAt: DateTime.utc(2026, 4, 1),
        ),
        AiChatMessage(
          id: '2',
          role: AiChatMessageRole.assistant,
          text: 'answer',
          createdAt: DateTime.utc(2026, 4, 1, 0, 1),
        ),
      ];

      await AiChatSessionStore.save('problem_a', messages);
      final loaded = await AiChatSessionStore.load('problem_a');

      expect(loaded.length, 2);
      expect(loaded.first.text, 'question');
      expect(loaded.last.text, 'answer');
    });

    test('migrateAnonymousSessionsToUser copies anonymous local to uid key', () async {
      const codec = AiChatMessageCodec();
      final prefs = await SharedPreferences.getInstance();
      const problemId = 'prob_1';
      final sanitized = AiChatMessageCodec.sanitizeProblemIdForStorage(problemId);
      const uid = 'test_uid_123';
      const installationId = 'abcdefghijklmnopqrstuv';

      await prefs.setString('joymath/ai_chat_installation_id', installationId);
      await prefs.setString(
        'joymath_simple/ai_chat/anonymous/$sanitized',
        jsonEncode(
          codec.encodeSession(
            AiChatSessionSnapshot(
              problemId: problemId,
              messages: [
                AiChatMessage(
                  id: '1',
                  role: AiChatMessageRole.user,
                  text: 'stored offline',
                  createdAt: DateTime.utc(2026, 5, 1),
                ),
              ],
              updatedAt: DateTime.utc(2026, 5, 2),
            ),
          ),
        ),
      );

      await AiChatSessionStore.migrateAnonymousSessionsToUser(uid);

      expect(prefs.containsKey('joymath_simple/ai_chat/anonymous/$sanitized'), isFalse);
      expect(
        prefs.containsKey('joymath_simple/ai_chat/$uid/$sanitized'),
        isTrue,
      );
    });

    test('legacy anonymous local migrates to installation owner on save', () async {
      const codec = AiChatMessageCodec();
      final prefs = await SharedPreferences.getInstance();
      const problemId = 'prob_legacy';
      final sanitized = AiChatMessageCodec.sanitizeProblemIdForStorage(problemId);
      const installationId = 'abcdefghijklmnopqrstuv';

      await prefs.setString('joymath/ai_chat_installation_id', installationId);
      await prefs.setString(
        'joymath_simple/ai_chat/anonymous/$sanitized',
        jsonEncode(
          codec.encodeSession(
            AiChatSessionSnapshot(
              problemId: problemId,
              messages: [
                AiChatMessage(
                  id: '1',
                  role: AiChatMessageRole.user,
                  text: 'legacy offline',
                  createdAt: DateTime.utc(2026, 5, 1),
                ),
              ],
              updatedAt: DateTime.utc(2026, 5, 2),
            ),
          ),
        ),
      );

      await AiChatSessionStore.save(problemId, [
        AiChatMessage(
          id: '2',
          role: AiChatMessageRole.user,
          text: 'new message',
          createdAt: DateTime.utc(2026, 5, 3),
        ),
      ]);

      expect(prefs.containsKey('joymath_simple/ai_chat/anonymous/$sanitized'), isFalse);
      expect(
        prefs.containsKey('joymath_simple/ai_chat/$installationId/$sanitized'),
        isTrue,
      );
    });
  });
}
