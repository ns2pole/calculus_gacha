import 'package:flutter/material.dart';

/// Whether [text] should be rendered with a custom [textRenderer] instead of plain [Text].
bool userChatTextNeedsCustomRenderer(String text) {
  return RegExp(r'(\\[A-Za-z]+|[_^]|\$)').hasMatch(text);
}

/// Intended inner content for a user message bubble (host supplies [textRenderer]).
@visibleForTesting
Widget buildUserChatMessageBody({
  required String text,
  required Widget Function(String text)? textRenderer,
  TextStyle style = const TextStyle(fontSize: 16, height: 1.45),
}) {
  if (textRenderer != null && userChatTextNeedsCustomRenderer(text)) {
    return textRenderer(text);
  }
  return Text(text, softWrap: true, style: style);
}

/// Whether [_MessageBubble] currently routes user TeX through [textRenderer].
@visibleForTesting
bool get aiChatUserBubbleUsesTextRenderer => true;
