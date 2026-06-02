import 'package:ai_chat_kit/ai_chat_kit.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

AiChatStrings joymathAiChatStrings(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  return AiChatStrings(
    greeting: l10n.askAiGreeting,
    placeholder: l10n.askAiPlaceholder,
    send: l10n.askAiSend,
    moreDetail: l10n.askAiMoreDetail,
    genericError: l10n.askAiError,
    starterChoiceHint: l10n.askAiChoiceHint,
    starterChoiceApproach: l10n.askAiChoiceApproach,
    starterChoiceFirstStep: l10n.askAiChoiceFirstStep,
    freeMonthlyLimitReached: l10n.aiChatFreeMonthlyLimitReached,
    paidMonthlyLimitReached: l10n.aiChatPaidMonthlyLimitReached,
    voiceListeningHint: l10n.aiChatVoiceListening,
    voiceSendModeAuto: l10n.aiChatVoiceSendModeAuto,
    voiceSendModeManual: l10n.aiChatVoiceSendModeManual,
    voiceSendModeAutoLabel: l10n.aiChatVoiceSendModeAutoLabel,
    voiceSendModeManualLabel: l10n.aiChatVoiceSendModeManualLabel,
    voicePermissionDenied: l10n.aiChatVoicePermissionDenied,
  );
}
