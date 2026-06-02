/// Snapshot of one problem/session sent to the AI backend (host builds this).
class AiChatSessionPayload {
  /// Optional key for host-specific starter quick replies (e.g. problem UUID).
  final String? contentId;

  final String title;
  final String questionText;
  final String? category;
  final String? level;
  final String? referenceAnswer;
  final String? referenceSolution;
  final bool hintShown;
  final bool answerShown;
  final bool attachmentsEnabled;
  final Map<String, dynamic>? extras;

  /// Back-compat alias for joymath `problemId`.
  String? get problemId => contentId;

  const AiChatSessionPayload({
    this.contentId,
    required this.title,
    required this.questionText,
    this.category,
    this.level,
    this.referenceAnswer,
    this.referenceSolution,
    this.hintShown = false,
    this.answerShown = false,
    this.attachmentsEnabled = false,
    this.extras,
  });
}

/// Back-compat alias used during joymath migration.
typedef AiChatContext = AiChatSessionPayload;
