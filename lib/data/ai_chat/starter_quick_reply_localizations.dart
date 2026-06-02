import 'package:ai_chat_kit/ai_chat_kit.dart';
import 'package:flutter/widgets.dart';

import 'starter_quick_reply_en_translations.dart';

/// Returns starter quick replies with labels/sendText localized for [locale].
List<AiChatQuickReply> localizeStarterQuickReplies(
  List<AiChatQuickReply> replies,
  Locale locale,
) {
  if (!locale.languageCode.toLowerCase().startsWith('en')) {
    return replies;
  }
  return [
    for (final reply in replies) _localizeReply(reply),
  ];
}

AiChatQuickReply _localizeReply(AiChatQuickReply reply) {
  final labelEn = starterQuickReplyJaToEn[reply.label];
  final sendTextEn = reply.sendText != null
      ? starterQuickReplyJaToEn[reply.sendText!]
      : null;

  if (labelEn == null && sendTextEn == null) {
    return reply;
  }

  return AiChatQuickReply(
    label: labelEn ?? reply.label,
    sendText: sendTextEn ?? reply.sendText,
    actionId: reply.actionId,
  );
}
