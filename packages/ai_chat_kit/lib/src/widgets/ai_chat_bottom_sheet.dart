import 'package:flutter/material.dart';

import '../models/ai_chat_message.dart';
import '../models/ai_chat_quick_reply.dart';
import '../models/ai_chat_session_payload.dart';
import '../ports/ai_chat_host_ports.dart';
import '../ports/ai_chat_strings.dart';
import '../services/ai_chat_client.dart';
import '../voice/ai_chat_preferences.dart';
import '../voice/ai_chat_voice_options.dart';
import '../voice/voice_input_controller.dart';
import '../voice/voice_send_mode.dart';

typedef AiChatTextRenderer = Widget Function(String text);

class AiChatBottomSheet extends StatefulWidget {
  final AiChatSessionPayload session;
  final AiChatClient client;
  final AiChatHostPorts host;
  final AiChatTextRenderer? textRenderer;
  final AiChatTextRenderer? assistantTextRenderer;
  final List<AiChatMessage> initialMessages;
  final ValueChanged<List<AiChatMessage>>? onMessagesChanged;
  final AiChatVoiceOptions voice;

  const AiChatBottomSheet({
    super.key,
    required this.session,
    required this.client,
    required this.host,
    this.textRenderer,
    this.assistantTextRenderer,
    this.initialMessages = const [],
    this.onMessagesChanged,
    this.voice = AiChatVoiceOptions.defaults,
  });

  @override
  State<AiChatBottomSheet> createState() => _AiChatBottomSheetState();
}

class _AiChatBottomSheetState extends State<AiChatBottomSheet> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final _voiceController = VoiceInputController();
  final _preferences = AiChatPreferences();

  late final List<AiChatMessage> _messages;
  List<AiChatQuickReply>? _starterQuickReplies;
  bool _isSending = false;
  bool _showUpgradeOffer = false;
  bool _isRestoring = false;
  String? _errorText;
  AiChatRateLimitInfo? _rateLimitInfo;

  VoiceSendMode _voiceSendMode = VoiceSendMode.manual;
  bool _isListening = false;
  String? _voiceStatusMessage;

  AiChatStrings get _strings => widget.host.strings;

  @override
  void initState() {
    super.initState();
    _messages = List<AiChatMessage>.of(widget.initialMessages);
    if (_messages.isEmpty) {
      _starterQuickReplies =
          widget.host.starterQuickReplies(widget.session.contentId);
    }
    if (_messages.isNotEmpty) _scrollToBottom();
    _loadVoiceMode();
  }

  Future<void> _loadVoiceMode() async {
    if (!widget.voice.enabled) return;
    final mode = await _preferences.loadVoiceSendMode(
      defaultMode: widget.voice.defaultSendMode,
    );
    if (!mounted) return;
    setState(() => _voiceSendMode = mode);
  }

  @override
  void dispose() {
    _voiceController.dispose();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _notifyMessagesChanged() {
    widget.onMessagesChanged?.call(List<AiChatMessage>.unmodifiable(_messages));
  }

  Future<void> _sendText(String text, {String? choiceId}) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || _isSending) return;

    final userMessage = AiChatMessage(
      id: _newMessageId(),
      role: AiChatMessageRole.user,
      text: trimmed,
      choiceId: choiceId,
      createdAt: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
      _isSending = true;
      _errorText = null;
      _controller.clear();
      _voiceStatusMessage = null;
    });
    _notifyMessagesChanged();
    _scrollToBottom();

    try {
      final response = await widget.client.sendMessage(
        session: widget.session,
        history: List<AiChatMessage>.unmodifiable(_messages),
        userMessage: userMessage,
      );
      if (!mounted) return;
      setState(() {
        _messages.add(response);
        _isSending = false;
        _showUpgradeOffer = false;
        _rateLimitInfo = null;
      });
      _notifyMessagesChanged();
      _scrollToBottom();
    } on AiChatRateLimitException catch (e) {
      if (!mounted) return;
      final info = AiChatRateLimitInfo(
        message: _rateLimitMessage(e),
        tier: e.tier,
        monthlyLimit: e.monthlyLimit,
      );
      setState(() {
        _isSending = false;
        _errorText = info.message;
        _rateLimitInfo = info;
        _showUpgradeOffer = !info.isPaidTier;
      });
      _scrollToBottom();
    } on AiChatClientException catch (e) {
      if (!mounted) return;
      setState(() {
        _isSending = false;
        _errorText = e.message;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isSending = false;
        _errorText = _strings.genericError;
      });
    }
  }

  String _rateLimitMessage(AiChatRateLimitException e) {
    final limit = e.monthlyLimit ?? (e.tier == 'paid' ? 500 : 10);
    if (e.tier == 'paid') {
      return _strings.paidMonthlyLimitReached(limit);
    }
    return _strings.freeMonthlyLimitReached(limit);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _toggleVoiceSendMode() async {
    final next = _voiceSendMode == VoiceSendMode.auto
        ? VoiceSendMode.manual
        : VoiceSendMode.auto;
    await _preferences.saveVoiceSendMode(next);
    if (!mounted) return;
    setState(() => _voiceSendMode = next);
  }

  Future<void> _toggleListening() async {
    if (_isListening) {
      await _voiceController.stopListening();
      if (!mounted) return;
      setState(() {
        _isListening = false;
        _voiceStatusMessage = null;
      });
      return;
    }

    final permitted = await _voiceController.ensureMicrophonePermission();
    if (!permitted) {
      if (!mounted) return;
      setState(() => _voiceStatusMessage = _strings.voicePermissionDenied);
      return;
    }

    setState(() {
      _isListening = true;
      _voiceStatusMessage = _strings.voiceListeningHint;
    });

    await _voiceController.startListening(
      onResult: (text, isFinal) {
        if (!mounted) return;
        _controller.text = text;
        _controller.selection = TextSelection.collapsed(offset: text.length);
        if (!isFinal) return;

        if (_voiceSendMode == VoiceSendMode.auto) {
          _voiceController.stopListening();
          setState(() {
            _isListening = false;
            _voiceStatusMessage = null;
          });
          _sendText(text);
          return;
        }

        setState(() {
          _isListening = false;
          _voiceStatusMessage = null;
        });
      },
    );
  }

  Future<void> _onPurchase() async {
    final result = await widget.host.purchaseUpgrade(context);
    if (!mounted || result.cancelled) return;
    if (result.success) {
      setState(() {
        _showUpgradeOffer = false;
        _errorText = null;
        _rateLimitInfo = null;
      });
      if (result.userMessage != null) {
        _showSnackBar(result.userMessage!, success: true);
      }
      return;
    }
    if (result.userMessage != null) {
      _showSnackBar(result.userMessage!, success: false);
    }
  }

  Future<void> _onRestore() async {
    if (_isRestoring) return;
    setState(() => _isRestoring = true);
    try {
      final result = await widget.host.restoreUpgrade(context);
      if (!mounted) return;
      if (result.cancelled) return;
      if (result.success) {
        setState(() {
          _showUpgradeOffer = false;
          _errorText = null;
          _rateLimitInfo = null;
        });
      }
      if (result.userMessage != null) {
        _showSnackBar(result.userMessage!, success: result.success);
      }
    } finally {
      if (mounted) setState(() => _isRestoring = false);
    }
  }

  void _showSnackBar(String message, {required bool success}) {
    final backgroundColor =
        success ? Colors.green.shade700 : Colors.red.shade700;
    final overlay = Overlay.of(context, rootOverlay: true);
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: 16,
        left: 16,
        right: 16,
        child: SafeArea(
          child: IgnorePointer(
            child: Material(
              color: backgroundColor,
              elevation: 8,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    Icon(
                      success ? Icons.check_circle : Icons.cancel,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        message,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    Future<void>.delayed(const Duration(seconds: 4), entry.remove);
  }

  String _newMessageId() => DateTime.now().microsecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);

    return AnimatedPadding(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: viewInsets.bottom),
      child: FractionallySizedBox(
        heightFactor: 0.99,
        child: Material(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              _buildHandle(),
              _buildProblemPreview(),
              const Divider(height: 1),
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                  children: [
                    _AssistantBubble(
                      text: _strings.greeting,
                      textRenderer:
                          widget.assistantTextRenderer ?? widget.textRenderer,
                    ),
                    if (_messages.isEmpty) ...[
                      const SizedBox(height: 12),
                      _buildStarterQuickReplySection(),
                    ],
                    ..._buildMessageList(),
                    if (_isSending) ...[
                      const SizedBox(height: 12),
                      const _TypingIndicator(),
                    ],
                    if (_errorText != null) ...[
                      const SizedBox(height: 12),
                      _ErrorMessage(text: _errorText!),
                    ],
                    if (_showUpgradeOffer && _rateLimitInfo != null) ...[
                      const SizedBox(height: 12),
                      widget.host.buildUpgradeOffer(
                            context,
                            limitInfo: _rateLimitInfo!,
                            isRestoring: _isRestoring,
                            onPurchase: _onPurchase,
                            onRestore: _onRestore,
                          ) ??
                          const SizedBox.shrink(),
                    ],
                  ],
                ),
              ),
              const Divider(height: 1),
              _buildInputBar(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMessageList() {
    final widgets = <Widget>[];
    for (var i = 0; i < _messages.length; i++) {
      final message = _messages[i];
      widgets.add(const SizedBox(height: 12));
      widgets.add(
        _MessageBubble(
          message: message,
          textRenderer: widget.textRenderer,
          assistantTextRenderer: widget.assistantTextRenderer,
        ),
      );
      if (_shouldShowQuickRepliesForMessage(message, i)) {
        widgets.add(const SizedBox(height: 8));
        widgets.add(_buildQuickReplyChips(_activeQuickRepliesForMessage(message)));
      }
    }
    return widgets;
  }

  bool _shouldShowQuickRepliesForMessage(AiChatMessage message, int index) {
    if (message.role != AiChatMessageRole.assistant) return false;
    if (_isSending) return false;
    if (index != _messages.length - 1) return false;
    return true;
  }

  List<AiChatQuickReply> _activeQuickRepliesForMessage(AiChatMessage message) {
    if (message.quickReplies.isNotEmpty) return message.quickReplies;
    return [AiChatQuickReply(label: _strings.moreDetail)];
  }

  Widget _buildHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 4),
      child: Container(
        width: 42,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }

  Widget _buildProblemPreview() {
    final text = widget.session.questionText;
    final renderer = widget.textRenderer;
    final content = renderer != null ? renderer(text) : Text(text);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.subject, size: 20),
          const SizedBox(width: 8),
          Expanded(child: content),
        ],
      ),
    );
  }

  List<AiChatQuickReply> _fallbackStarterQuickReplies() {
    return [
      AiChatQuickReply(
        label: _strings.starterChoiceHint,
        sendText: _strings.starterChoiceHint,
        actionId: 'hint',
      ),
      AiChatQuickReply(
        label: _strings.starterChoiceApproach,
        sendText: _strings.starterChoiceApproach,
        actionId: 'approach_only',
      ),
      AiChatQuickReply(
        label: _strings.starterChoiceFirstStep,
        sendText: _strings.starterChoiceFirstStep,
        actionId: 'first_step',
      ),
    ];
  }

  Widget _buildStarterQuickReplySection() {
    final replies = _starterQuickReplies ?? _fallbackStarterQuickReplies();
    return _buildQuickReplyChips(replies);
  }

  Widget _buildQuickReplyChips(List<AiChatQuickReply> replies) {
    if (replies.isEmpty) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final reply in replies)
            ActionChip(
              label: Text(reply.label),
              onPressed: _isSending
                  ? null
                  : () => _sendText(
                        reply.effectiveSendText,
                        choiceId: reply.actionId,
                      ),
            ),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_voiceStatusMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  _voiceStatusMessage!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            Row(
              children: [
                if (widget.voice.enabled) ...[
                  IconButton(
                    tooltip: _voiceSendMode == VoiceSendMode.auto
                        ? _strings.voiceSendModeAuto
                        : _strings.voiceSendModeManual,
                    onPressed: _isSending ? null : _toggleVoiceSendMode,
                    icon: Icon(
                      _voiceSendMode == VoiceSendMode.auto
                          ? Icons.send_and_archive_outlined
                          : Icons.edit_note_outlined,
                    ),
                  ),
                  IconButton(
                    tooltip: _isListening ? 'Stop' : 'Voice input',
                    onPressed: _isSending ? null : _toggleListening,
                    icon: Icon(
                      _isListening ? Icons.mic : Icons.mic_none_outlined,
                      color: _isListening
                          ? Theme.of(context).colorScheme.error
                          : null,
                    ),
                  ),
                ],
                Expanded(
                  child: TextField(
                    controller: _controller,
                    minLines: 1,
                    maxLines: 4,
                    textInputAction: TextInputAction.send,
                    onSubmitted: _sendText,
                    decoration: InputDecoration(
                      hintText: _strings.placeholder,
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed:
                      _isSending ? null : () => _sendText(_controller.text),
                  child: Text(_strings.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final AiChatMessage message;
  final AiChatTextRenderer? textRenderer;
  final AiChatTextRenderer? assistantTextRenderer;

  const _MessageBubble({
    required this.message,
    this.textRenderer,
    this.assistantTextRenderer,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == AiChatMessageRole.user;
    if (!isUser) {
      return _AssistantBubble(
        text: message.text,
        textRenderer: assistantTextRenderer ?? textRenderer,
      );
    }

    final colorScheme = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 320),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(message.text),
      ),
    );
  }
}

class _AssistantBubble extends StatelessWidget {
  final String text;
  final AiChatTextRenderer? textRenderer;

  const _AssistantBubble({required this.text, this.textRenderer});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 360),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: textRenderer != null ? textRenderer!(text) : Text(text),
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  final String text;

  const _ErrorMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Theme.of(context).colorScheme.error),
    );
  }
}
