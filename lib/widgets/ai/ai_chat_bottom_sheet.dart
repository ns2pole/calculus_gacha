import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/ai_chat_context.dart';
import '../../models/ai_chat_message.dart';
import '../../services/ai/ai_chat_client.dart';
import '../../services/ai/ai_chat_client_factory.dart';

typedef MathTextBuilder = Widget Function(String text);

Future<void> showAiChatBottomSheet({
  required BuildContext context,
  required AiChatContext chatContext,
  AiChatClient? client,
  MathTextBuilder? mathTextBuilder,
  MathTextBuilder? assistantTextBuilder,
  List<AiChatMessage> initialMessages = const [],
  ValueChanged<List<AiChatMessage>>? onMessagesChanged,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => AiChatBottomSheet(
      chatContext: chatContext,
      client: client ?? AiChatClientFactory.createDefault(),
      mathTextBuilder: mathTextBuilder,
      assistantTextBuilder: assistantTextBuilder,
      initialMessages: initialMessages,
      onMessagesChanged: onMessagesChanged,
    ),
  );
}

class AiChatBottomSheet extends StatefulWidget {
  final AiChatContext chatContext;
  final AiChatClient client;
  final MathTextBuilder? mathTextBuilder;
  final MathTextBuilder? assistantTextBuilder;
  final List<AiChatMessage> initialMessages;
  final ValueChanged<List<AiChatMessage>>? onMessagesChanged;

  const AiChatBottomSheet({
    super.key,
    required this.chatContext,
    required this.client,
    this.mathTextBuilder,
    this.assistantTextBuilder,
    this.initialMessages = const [],
    this.onMessagesChanged,
  });

  @override
  State<AiChatBottomSheet> createState() => _AiChatBottomSheetState();
}

class _AiChatBottomSheetState extends State<AiChatBottomSheet> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  late final List<AiChatMessage> _messages;
  bool _isSending = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _messages = List<AiChatMessage>.of(widget.initialMessages);
    if (_messages.isNotEmpty) _scrollToBottom();
  }

  @override
  void dispose() {
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
    });
    _notifyMessagesChanged();
    _scrollToBottom();

    try {
      final response = await widget.client.sendMessage(
        context: widget.chatContext,
        history: List<AiChatMessage>.unmodifiable(_messages),
        userMessage: userMessage,
      );
      if (!mounted) return;
      setState(() {
        _messages.add(response);
        _isSending = false;
      });
      _notifyMessagesChanged();
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
        _errorText = AppLocalizations.of(context)!.askAiError;
      });
    }
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

  String _newMessageId() => DateTime.now().microsecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                      text: l10n.askAiGreeting,
                      mathTextBuilder:
                          widget.assistantTextBuilder ?? widget.mathTextBuilder,
                    ),
                    if (_messages.isEmpty) ...[
                      const SizedBox(height: 12),
                      _buildChoiceChips(l10n),
                    ],
                    for (final message in _messages) ...[
                      const SizedBox(height: 12),
                      _MessageBubble(
                        message: message,
                        mathTextBuilder: widget.mathTextBuilder,
                        assistantTextBuilder: widget.assistantTextBuilder,
                      ),
                    ],
                    if (_isSending) ...[
                      const SizedBox(height: 12),
                      const _TypingIndicator(),
                    ],
                    if (_errorText != null) ...[
                      const SizedBox(height: 12),
                      _ErrorMessage(text: _errorText!),
                    ],
                    if (_canShowMoreDetailButton) ...[
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: OutlinedButton(
                          onPressed: () => _sendText(l10n.askAiMoreDetail),
                          child: Text(l10n.askAiMoreDetail),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Divider(height: 1),
              _buildInputBar(l10n),
            ],
          ),
        ),
      ),
    );
  }

  bool get _canShowMoreDetailButton {
    if (_isSending || _messages.isEmpty) return false;
    return _messages.last.role == AiChatMessageRole.assistant;
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

  Widget _buildHeader(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              l10n.askAiSheetTitle,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget _buildProblemPreview() {
    final text = widget.chatContext.questionText;
    final builder = widget.mathTextBuilder;
    final content = builder != null ? builder(text) : Text(text);
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

  Widget _buildChoiceChips(AppLocalizations l10n) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ActionChip(
          label: Text(l10n.askAiChoiceHint),
          onPressed: () => _sendText(l10n.askAiChoiceHint, choiceId: 'hint'),
        ),
        ActionChip(
          label: Text(l10n.askAiChoiceApproach),
          onPressed: () =>
              _sendText(l10n.askAiChoiceApproach, choiceId: 'approach_only'),
        ),
        ActionChip(
          label: Text(l10n.askAiChoiceFirstStep),
          onPressed: () =>
              _sendText(l10n.askAiChoiceFirstStep, choiceId: 'first_step'),
        ),
      ],
    );
  }

  Widget _buildInputBar(AppLocalizations l10n) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: _sendText,
                decoration: InputDecoration(
                  hintText: l10n.askAiPlaceholder,
                  border: const OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: _isSending ? null : () => _sendText(_controller.text),
              child: Text(l10n.askAiSend),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final AiChatMessage message;
  final MathTextBuilder? mathTextBuilder;
  final MathTextBuilder? assistantTextBuilder;

  const _MessageBubble({
    required this.message,
    this.mathTextBuilder,
    this.assistantTextBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == AiChatMessageRole.user;
    if (!isUser) {
      return _AssistantBubble(
        text: message.text,
        mathTextBuilder: assistantTextBuilder ?? mathTextBuilder,
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
  final MathTextBuilder? mathTextBuilder;

  const _AssistantBubble({required this.text, this.mathTextBuilder});

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
        child: mathTextBuilder != null ? mathTextBuilder!(text) : Text(text),
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
