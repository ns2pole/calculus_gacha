/// Localized strings for the chat UI (provided by each host app).
class AiChatStrings {
  final String greeting;
  final String placeholder;
  final String send;
  final String moreDetail;
  final String genericError;

  final String starterChoiceHint;
  final String starterChoiceApproach;
  final String starterChoiceFirstStep;

  final String Function(int limit) freeMonthlyLimitReached;
  final String Function(int limit) paidPassLimitReached;

  final String voiceListeningHint;
  final String voiceSendModeAuto;
  final String voiceSendModeManual;
  final String voiceSendModeAutoLabel;
  final String voiceSendModeManualLabel;
  final String voicePermissionDenied;

  const AiChatStrings({
    required this.greeting,
    required this.placeholder,
    required this.send,
    required this.moreDetail,
    required this.genericError,
    required this.starterChoiceHint,
    required this.starterChoiceApproach,
    required this.starterChoiceFirstStep,
    required this.freeMonthlyLimitReached,
    required this.paidPassLimitReached,
    this.voiceListeningHint = 'Listening…',
    this.voiceSendModeAuto = 'Auto-send voice',
    this.voiceSendModeManual = 'Edit before send',
    this.voiceSendModeAutoLabel = 'Auto Send',
    this.voiceSendModeManualLabel = 'Manual',
    this.voicePermissionDenied =
        'Microphone permission is required for voice input.',
  });
}
