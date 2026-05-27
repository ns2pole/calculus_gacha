import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/ai_chat_context.dart';
import '../../models/ai_chat_message.dart';
import '../../services/ai/ai_chat_client.dart';
import '../../services/ai/ai_chat_client_factory.dart';
import '../../services/auth/firebase_auth_service.dart';
import '../../services/payment/revenuecat_service.dart';

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
  bool _showUpgradeOffer = false;
  String? _errorText;
  String? _aiTutorPrice;

  @override
  void initState() {
    super.initState();
    _messages = List<AiChatMessage>.of(widget.initialMessages);
    if (_messages.isNotEmpty) _scrollToBottom();
    _loadAiTutorPrice();
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
        _showUpgradeOffer = false;
      });
      _notifyMessagesChanged();
      _scrollToBottom();
    } on AiChatRateLimitException catch (e) {
      if (!mounted) return;
      setState(() {
        _isSending = false;
        _errorText = e.message;
        _showUpgradeOffer = true;
      });
      _scrollToBottom();
    } on AiChatClientException catch (e) {
      debugPrint(
        '[AiChatBottomSheet] Client error: '
        'code=${e.code ?? 'unknown'}, status=${e.statusCode ?? 'none'}, '
        'message=${e.message}',
      );
      if (!mounted) return;
      setState(() {
        _isSending = false;
        _errorText = e.message;
      });
    } catch (error, stackTrace) {
      debugPrint('[AiChatBottomSheet] Unexpected error: $error');
      debugPrintStack(
        stackTrace: stackTrace,
        label: '[AiChatBottomSheet] stack',
      );
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

  Future<void> _loadAiTutorPrice() async {
    final price = await RevenueCatService.getAiTutorSubscriptionPrice();
    if (!mounted || price == null || price.isEmpty) return;
    setState(() {
      _aiTutorPrice = price;
    });
  }

  Future<void> _showAiTutorPurchaseDialog() async {
    final purchased = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return _AiTutorPurchaseDialog(
          price: _aiTutorPrice ?? AppLocalizations.of(context)!.defaultPrice,
        );
      },
    );

    if (!mounted || purchased != true) return;
    setState(() {
      _showUpgradeOffer = false;
      _errorText = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.aiTutorPurchaseSuccess),
      ),
    );
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
                    if (_showUpgradeOffer) ...[
                      const SizedBox(height: 12),
                      _AiTutorUpgradeCard(
                        price: _aiTutorPrice ?? l10n.defaultPrice,
                        onPressed: _showAiTutorPurchaseDialog,
                      ),
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

class _AiTutorUpgradeCard extends StatelessWidget {
  final String price;
  final VoidCallback onPressed;

  const _AiTutorUpgradeCard({required this.price, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.workspace_premium,
                  color: colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.aiTutorLimitReachedTitle,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onPrimaryContainer,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.aiTutorLimitReachedBody(price),
                        style: TextStyle(color: colorScheme.onPrimaryContainer),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onPressed,
                child: Text(l10n.aiTutorUpgradeButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AiTutorPurchaseDialog extends StatefulWidget {
  final String price;

  const _AiTutorPurchaseDialog({required this.price});

  @override
  State<_AiTutorPurchaseDialog> createState() => _AiTutorPurchaseDialogState();
}

class _AiTutorPurchaseDialogState extends State<_AiTutorPurchaseDialog> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAuthenticated = FirebaseAuthService.isAuthenticated;

    return AlertDialog(
      title: Text(l10n.aiTutorPurchaseTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.aiTutorPurchaseDescription(widget.price)),
          const SizedBox(height: 14),
          _BenefitRow(text: l10n.aiTutorPurchaseBenefitMonthlyLimit),
          const SizedBox(height: 8),
          _BenefitRow(text: l10n.aiTutorPurchaseBenefitPlatformBilling),
          if (!isAuthenticated) ...[
            const SizedBox(height: 16),
            _SignInNotice(),
          ],
          if (_isProcessing) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(l10n.aiTutorPurchaseInProgress)),
              ],
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isProcessing
              ? null
              : () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        if (!isAuthenticated)
          FilledButton(
            onPressed: _isProcessing ? null : _signInWithGoogleAndPurchase,
            child: Text(l10n.aiTutorSignInToPurchase),
          )
        else ...[
          TextButton(
            onPressed: _isProcessing ? null : _restorePurchases,
            child: Text(l10n.aiTutorPurchaseRestore),
          ),
          FilledButton(
            onPressed: _isProcessing ? null : _purchase,
            child: Text(l10n.purchase),
          ),
        ],
      ],
    );
  }

  Future<void> _purchase() async {
    debugPrint('[AiTutorPurchase] Purchase button tapped');
    await _runPurchaseAction(RevenueCatService.purchaseAiTutorSubscription);
  }

  Future<void> _signInWithGoogleAndPurchase() async {
    final l10n = AppLocalizations.of(context)!;
    debugPrint('[AiTutorPurchase] Google sign-in before purchase started');
    setState(() {
      _isProcessing = true;
    });

    try {
      final credential = await FirebaseAuthService.signInWithGoogle();
      if (!mounted) return;
      if (credential == null) {
        debugPrint('[AiTutorPurchase] Google sign-in cancelled');
        setState(() {
          _isProcessing = false;
        });
        return;
      }

      debugPrint(
        '[AiTutorPurchase] Google sign-in succeeded, syncing RevenueCat user',
      );
      await RevenueCatService.syncCurrentFirebaseUser();
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
      });
      await _purchase();
    } catch (e) {
      debugPrint('[AiTutorPurchase] Google sign-in failed: $e');
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${l10n.auth_googleSignInFailed}: $e')),
      );
    }
  }

  Future<void> _restorePurchases() async {
    debugPrint('[AiTutorPurchase] Restore button tapped');
    setState(() {
      _isProcessing = true;
    });
    try {
      final restored = await RevenueCatService.restoreAiTutorSubscription();
      debugPrint('[AiTutorPurchase] Restore result: $restored');
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
      });
      if (restored) {
        Navigator.of(context).pop(true);
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.noRestorablePurchases),
        ),
      );
    } catch (e) {
      debugPrint('[AiTutorPurchase] Restore failed: $e');
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.restoreFailed(e.toString()),
          ),
        ),
      );
    }
  }

  Future<void> _runPurchaseAction(
    Future<PurchaseResult> Function() action,
  ) async {
    setState(() {
      _isProcessing = true;
    });
    try {
      debugPrint('[AiTutorPurchase] RevenueCat purchase started');
      final result = await action();
      debugPrint(
        '[AiTutorPurchase] RevenueCat purchase result: '
        'success=${result.success}, cancelled=${result.cancelled}, error=${result.error}',
      );
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
      });
      if (result.success) {
        Navigator.of(context).pop(true);
        return;
      }
      if (result.cancelled) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.purchaseFailed(
              result.error ?? AppLocalizations.of(context)!.unknownError,
            ),
          ),
        ),
      );
    } catch (e) {
      debugPrint('[AiTutorPurchase] RevenueCat purchase threw: $e');
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.purchaseFailed(e.toString()),
          ),
        ),
      );
    }
  }
}

class _BenefitRow extends StatelessWidget {
  final String text;

  const _BenefitRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle,
          size: 18,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    );
  }
}

class _SignInNotice extends StatelessWidget {
  const _SignInNotice();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: colorScheme.onErrorContainer),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.aiTutorSignInRequiredTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onErrorContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.aiTutorSignInRequiredBody,
                  style: TextStyle(color: colorScheme.onErrorContainer),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
