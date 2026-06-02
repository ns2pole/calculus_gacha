import 'package:ai_chat_kit/ai_chat_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joymath/models/ai_chat_session_snapshot.dart';
import 'package:joymath/services/ai/ai_chat_message_codec.dart';

void main() {
  const codec = AiChatMessageCodec();

  group('AiChatMessageCodec', () {
    test('round-trips a message', () {
      final message = AiChatMessage(
        id: 'm1',
        role: AiChatMessageRole.user,
        text: 'Hello \$x^2\$',
        choiceId: 'approach_hint',
        createdAt: DateTime.utc(2026, 1, 2, 3, 4, 5),
      );

      final decoded = codec.decodeMessage(codec.encodeMessage(message));
      expect(decoded.id, message.id);
      expect(decoded.role, message.role);
      expect(decoded.text, message.text);
      expect(decoded.choiceId, message.choiceId);
      expect(decoded.createdAt, message.createdAt);
    });

    test('round-trips a session', () {
      final snapshot = AiChatSessionSnapshot(
        problemId: 'calc/integral_1',
        messages: [
          AiChatMessage(
            id: 'a1',
            role: AiChatMessageRole.assistant,
            text: 'hint',
            createdAt: DateTime.utc(2026, 2, 1),
          ),
        ],
        updatedAt: DateTime.utc(2026, 2, 2),
      );

      final decoded = codec.decodeSession(codec.encodeSession(snapshot));
      expect(decoded.problemId, snapshot.problemId);
      expect(decoded.messages.length, 1);
      expect(decoded.updatedAt, snapshot.updatedAt);
    });

    test('sanitizes problem ids for storage keys', () {
      expect(
        AiChatMessageCodec.sanitizeProblemIdForStorage('a/b'),
        'a_b',
      );
    });

    test('trims sessions beyond maxMessages', () {
      final messages = List.generate(
        AiChatSessionSnapshot.maxMessages + 5,
        (i) => AiChatMessage(
          id: '$i',
          role: AiChatMessageRole.user,
          text: 'm$i',
          createdAt: DateTime.utc(2026, 1, 1).add(Duration(minutes: i)),
        ),
      );

      final trimmed = AiChatSessionSnapshot(
        problemId: 'p1',
        messages: messages,
        updatedAt: DateTime.utc(2026, 3, 1),
      ).trimmed();

      expect(trimmed.messages.length, AiChatSessionSnapshot.maxMessages);
      expect(trimmed.messages.first.text, 'm5');
      expect(trimmed.messages.last.text, 'm54');
    });
  });

  group('snapshot merge helpers', () {
    AiChatSessionSnapshot snap(DateTime updatedAt) => AiChatSessionSnapshot(
          problemId: 'p1',
          messages: const [],
          updatedAt: updatedAt,
        );

    test('pickNewerSnapshot prefers newer updatedAt', () {
      final local = snap(DateTime.utc(2026, 1, 1));
      final cloud = snap(DateTime.utc(2026, 2, 1));
      expect(pickNewerSnapshot(local, cloud), cloud);
      expect(pickNewerSnapshot(cloud, local), cloud);
    });

    test('authoritativeSnapshot prefers cloud whenever it exists', () {
      final local = snap(DateTime.utc(2026, 3, 1));
      final cloud = snap(DateTime.utc(2026, 2, 1));
      expect(authoritativeSnapshot(null, cloud), cloud);
      expect(authoritativeSnapshot(local, cloud), cloud);
      expect(authoritativeSnapshot(local, null), local);
      expect(authoritativeSnapshot(null, null), isNull);
    });
  });
}
