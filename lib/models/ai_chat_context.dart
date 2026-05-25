class AiChatContext {
  final String title;
  final String questionText;
  final String? category;
  final String? level;
  final bool hintShown;
  final bool answerShown;
  final bool attachmentsEnabled;

  const AiChatContext({
    required this.title,
    required this.questionText,
    this.category,
    this.level,
    this.hintShown = false,
    this.answerShown = false,
    this.attachmentsEnabled = false,
  });
}
