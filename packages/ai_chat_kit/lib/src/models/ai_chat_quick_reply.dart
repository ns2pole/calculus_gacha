class AiChatQuickReply {
  final String label;
  final String? sendText;
  final String? actionId;

  const AiChatQuickReply({
    required this.label,
    this.sendText,
    this.actionId,
  });

  String get effectiveSendText =>
      (sendText != null && sendText!.trim().isNotEmpty) ? sendText!.trim() : label;

  factory AiChatQuickReply.fromJson(Map<String, dynamic> json) {
    final label = json['label'];
    if (label is! String || label.trim().isEmpty) {
      throw const FormatException('quickReply label is required');
    }
    final sendText = json['sendText'];
    final actionId = json['actionId'];
    return AiChatQuickReply(
      label: label.trim(),
      sendText: sendText is String && sendText.trim().isNotEmpty
          ? sendText.trim()
          : null,
      actionId: actionId is String && actionId.trim().isNotEmpty
          ? actionId.trim()
          : null,
    );
  }
}
