import 'package:ai_chat_kit/ai_chat_kit.dart';

/// Persisted AI chat state for one problem.
class AiChatSessionSnapshot {
  static const int schemaVersion = 2;
  static const int maxMessages = 50;

  final String problemId;
  final List<AiChatMessage> messages;
  final DateTime updatedAt;
  final int schemaVersionValue;

  const AiChatSessionSnapshot({
    required this.problemId,
    required this.messages,
    required this.updatedAt,
    this.schemaVersionValue = schemaVersion,
  });

  AiChatSessionSnapshot trimmed() {
    if (messages.length <= maxMessages) return this;
    return AiChatSessionSnapshot(
      problemId: problemId,
      messages: messages.sublist(messages.length - maxMessages),
      updatedAt: updatedAt,
      schemaVersionValue: schemaVersionValue,
    );
  }
}

/// Firestore is the source of truth when [cloud] exists.
AiChatSessionSnapshot? authoritativeSnapshot(
  AiChatSessionSnapshot? local,
  AiChatSessionSnapshot? cloud,
) {
  return cloud ?? local;
}

/// Chooses the newer snapshot by [updatedAt]; ties prefer [cloud].
/// Used only when seeding Firestore from pre-login data.
AiChatSessionSnapshot? pickNewerSnapshot(
  AiChatSessionSnapshot? local,
  AiChatSessionSnapshot? cloud,
) {
  if (local == null) return cloud;
  if (cloud == null) return local;
  if (cloud.updatedAt.isAfter(local.updatedAt)) return cloud;
  if (local.updatedAt.isAfter(cloud.updatedAt)) return local;
  return cloud;
}
