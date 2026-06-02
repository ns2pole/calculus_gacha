import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/ai_chat_context.dart';
import '../../models/ai_chat_message.dart';
import '../../data/ai_chat/starter_quick_replies_by_problem_id.dart';
import '../../models/ai_chat_quick_reply.dart';
import '../../services/ai/ai_chat_client.dart';
import '../../services/ai/ai_chat_client_factory.dart';
import '../../services/auth/cloud_sync_preference_service.dart';
import '../../services/auth/firebase_auth_service.dart';
import '../../services/payment/ai_tutor_entitlement_sync_service.dart';
import '../../services/payment/revenuecat_service.dart';
import '../legal/iap_product_info_section.dart';
import '../legal/legal_notice_footer.dart';

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

void _showAiTutorResultSnackBar(
  BuildContext context, {
  required bool success,
  required String message,
}) {
  final backgroundColor = success ? Colors.green.shade700 : Colors.red.shade700;
  final icon = success ? Icons.check_circle : Icons.cancel;
  final overlay = Overlay.of(context, rootOverlay: true);

  late final OverlayEntry entry;
  entry = OverlayEntry(
    builder: (context) {
      return Positioned(
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
                    Icon(icon, color: Colors.white),
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
      );
    },
  );
  overlay.insert(entry);
  Future<void>.delayed(const Duration(seconds: 4), entry.remove);
}

String _restoreSyncFailureMessage(
  AppLocalizations l10n,
  AiTutorEntitlementSyncResult result,
) {
  return switch (result.failureReason) {
    AiTutorEntitlementSyncFailureReason.endpointNotConfigured =>
      l10n.aiTutorRestoreFailureSyncNotConfigured,
    AiTutorEntitlementSyncFailureReason.notSignedIn =>
      l10n.aiTutorRestoreFailureNotSignedIn,
    AiTutorEntitlementSyncFailureReason.serverRejected =>
      l10n.aiTutorRestoreFailureServerRejected(result.detail ?? ''),
    AiTutorEntitlementSyncFailureReason.inactive =>
      l10n.aiTutorRestoreFailureInactive,
    AiTutorEntitlementSyncFailureReason.timeout =>
      l10n.aiTutorRestoreFailureSyncTimeout,
    AiTutorEntitlementSyncFailureReason.unexpected =>
      l10n.aiTutorRestoreFailureUnexpected(result.detail ?? ''),
    null => l10n.aiTutorRestoreFailureSyncUnknown,
  };
}

class _AiTutorRestoreFlowResult {
  const _AiTutorRestoreFlowResult._({
    this.cancelled = false,
    this.restored = false,
    this.syncResult,
  });

  const _AiTutorRestoreFlowResult.cancelled() : this._(cancelled: true);

  const _AiTutorRestoreFlowResult.noPurchase() : this._(restored: false);

  const _AiTutorRestoreFlowResult.completed({
    required this.syncResult,
  }) : cancelled = false,
       restored = true;

  final bool cancelled;
  final bool restored;
  final AiTutorEntitlementSyncResult? syncResult;

  bool get success => restored && (syncResult?.active ?? false);
}

class _AiTutorPurchaseFlowResult {
  const _AiTutorPurchaseFlowResult._({
    required this.success,
    this.cancelled = false,
    this.purchaseError,
    this.syncResult,
  });

  const _AiTutorPurchaseFlowResult.success({
    required AiTutorEntitlementSyncResult syncResult,
  }) : this._(success: true, syncResult: syncResult);

  const _AiTutorPurchaseFlowResult.cancelled()
    : this._(success: false, cancelled: true);

  const _AiTutorPurchaseFlowResult.purchaseFailed(String? error)
    : this._(success: false, purchaseError: error);

  const _AiTutorPurchaseFlowResult.syncFailed({
    required AiTutorEntitlementSyncResult syncResult,
  }) : this._(success: false, syncResult: syncResult);

  final bool success;
  final bool cancelled;
  final String? purchaseError;
  final AiTutorEntitlementSyncResult? syncResult;
}

Future<_AiTutorPurchaseFlowResult> _purchaseAiTutorWithSync() async {
  await RevenueCatService.syncCurrentFirebaseUser();
  debugPrint('[AiTutorPurchase] RevenueCat purchase started');
  final result = await RevenueCatService.purchaseAiTutorSubscription();
  debugPrint(
    '[AiTutorPurchase] RevenueCat purchase result: '
    'success=${result.success}, cancelled=${result.cancelled}, error=${result.error}',
  );
  if (!result.success) {
    if (result.cancelled) return const _AiTutorPurchaseFlowResult.cancelled();
    return _AiTutorPurchaseFlowResult.purchaseFailed(result.error);
  }

  final syncResult =
      await AiTutorEntitlementSyncService.syncAfterPurchaseOrRestoreDetailed();
  debugPrint('[AiTutorPurchase] Server entitlement synced: ${syncResult.active}');
  if (syncResult.active) {
    return _AiTutorPurchaseFlowResult.success(syncResult: syncResult);
  }
  return _AiTutorPurchaseFlowResult.syncFailed(syncResult: syncResult);
}

/// 復元の前にログアウトし、購入時のアカウントで再ログインしてから復元する。
Future<_AiTutorRestoreFlowResult> _runAiTutorRestoreWithAccountSwitch({
  required bool usesAppleSignIn,
}) async {
  debugPrint('[AiTutorRestore] Signing out before account selection');
  await FirebaseAuthService.signOut();
  await RevenueCatService.logOutCurrentUser();

  final providerLabel = usesAppleSignIn ? 'Apple' : 'Google';
  debugPrint('[AiTutorRestore] $providerLabel sign-in for restore started');
  final credential = usesAppleSignIn
      ? await FirebaseAuthService.signInWithApple()
      : await FirebaseAuthService.signInWithGoogle();
  if (credential == null) {
    debugPrint('[AiTutorRestore] $providerLabel sign-in cancelled');
    return const _AiTutorRestoreFlowResult.cancelled();
  }

  final uid = credential.user?.uid;
  if (uid != null) {
    await CloudSyncPreferenceService.refreshForUser(uid);
  }

  await RevenueCatService.syncCurrentFirebaseUser();
  final restored = await RevenueCatService.restoreAiTutorSubscription();
  debugPrint('[AiTutorRestore] Restore result: $restored');
  if (!restored) {
    return const _AiTutorRestoreFlowResult.noPurchase();
  }

  final syncResult =
      await AiTutorEntitlementSyncService.syncAfterPurchaseOrRestoreDetailed();
  debugPrint(
    '[AiTutorRestore] Server entitlement synced: ${syncResult.active}',
  );
  return _AiTutorRestoreFlowResult.completed(syncResult: syncResult);
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
  List<AiChatQuickReply>? _starterQuickReplies;
  bool _isSending = false;
  bool _showUpgradeOffer = false;
  bool _isRestoringPurchase = false;
  String? _errorText;
  String? _aiTutorPrice;

  @override
  void initState() {
    super.initState();
    _messages = List<AiChatMessage>.of(widget.initialMessages);
    if (_messages.isEmpty) {
      _starterQuickReplies = _resolveStarterQuickReplies();
    }
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

  List<AiChatQuickReply>? _resolveStarterQuickReplies() {
    final problemId = widget.chatContext.problemId;
    if (problemId != null) {
      final hardcoded = lookupStarterQuickReplies(problemId);
      if (hardcoded != null) return hardcoded;
    }
    return null;
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
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _isSending = false;
        _errorText = _rateLimitMessage(l10n, e);
        _showUpgradeOffer = e.tier != 'paid';
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
    if (FirebaseAuthService.isAuthenticated) {
      await _purchaseAiTutorDirectly();
      return;
    }

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
    _showAiTutorResultSnackBar(
      context,
      success: true,
      message: AppLocalizations.of(context)!.aiTutorPurchaseSuccess,
    );
  }

  Future<void> _purchaseAiTutorDirectly() async {
    final l10n = AppLocalizations.of(context)!;
    debugPrint('[AiTutorPurchase] Direct purchase started (authenticated user)');

    final result = await _purchaseAiTutorWithSync();
    if (!mounted) return;

    if (result.success) {
      setState(() {
        _showUpgradeOffer = false;
        _errorText = null;
      });
      _showAiTutorResultSnackBar(
        context,
        success: true,
        message: l10n.aiTutorPurchaseSuccess,
      );
      return;
    }

    if (result.cancelled) return;
    if (result.syncResult != null) {
      _showAiTutorResultSnackBar(
        context,
        success: false,
        message: _restoreSyncFailureMessage(l10n, result.syncResult!),
      );
      return;
    }

    _showAiTutorResultSnackBar(
      context,
      success: false,
      message: l10n.purchaseFailed(result.purchaseError ?? l10n.unknownError),
    );
  }

  bool get _usesAppleSignIn =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  Future<void> _restoreAiTutorPurchase() async {
    if (_isRestoringPurchase) return;

    final l10n = AppLocalizations.of(context)!;
    debugPrint('[AiTutorRestore] Restore from upgrade card started');
    setState(() {
      _isRestoringPurchase = true;
    });

    try {
      final result = await _runAiTutorRestoreWithAccountSwitch(
        usesAppleSignIn: _usesAppleSignIn,
      );
      if (!mounted) return;
      if (result.cancelled) {
        setState(() {
          _isRestoringPurchase = false;
        });
        return;
      }

      final restoreSucceeded = result.success;
      setState(() {
        _isRestoringPurchase = false;
        if (restoreSucceeded) {
          _showUpgradeOffer = false;
          _errorText = null;
        }
      });

      _showAiTutorResultSnackBar(
        context,
        success: restoreSucceeded,
        message: restoreSucceeded
            ? l10n.aiTutorRestoreSuccessVerified
            : result.restored
            ? _restoreSyncFailureMessage(l10n, result.syncResult!)
            : l10n.aiTutorRestoreFailureNoPurchase,
      );
    } catch (e) {
      debugPrint('[AiTutorRestore] Restore failed: $e');
      if (!mounted) return;
      setState(() {
        _isRestoringPurchase = false;
      });
      _showAiTutorResultSnackBar(
        context,
        success: false,
        message: l10n.restoreFailed(e.toString()),
      );
    }
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
                      _buildStarterQuickReplySection(l10n),
                    ],
                    ..._buildMessageList(l10n),
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
                        onRestorePressed: _restoreAiTutorPurchase,
                        isRestoring: _isRestoringPurchase,
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

  List<Widget> _buildMessageList(AppLocalizations l10n) {
    final widgets = <Widget>[];
    for (var i = 0; i < _messages.length; i++) {
      final message = _messages[i];
      widgets.add(const SizedBox(height: 12));
      widgets.add(
        _MessageBubble(
          message: message,
          mathTextBuilder: widget.mathTextBuilder,
          assistantTextBuilder: widget.assistantTextBuilder,
        ),
      );
      if (_shouldShowQuickRepliesForMessage(message, i)) {
        widgets.add(const SizedBox(height: 8));
        widgets.add(
          _buildQuickReplyChips(_activeQuickRepliesForMessage(message, l10n)),
        );
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

  List<AiChatQuickReply> _activeQuickRepliesForMessage(
    AiChatMessage message,
    AppLocalizations l10n,
  ) {
    if (message.quickReplies.isNotEmpty) {
      return message.quickReplies;
    }
    return [AiChatQuickReply(label: l10n.askAiMoreDetail)];
  }

  String _rateLimitMessage(AppLocalizations l10n, AiChatRateLimitException e) {
    final limit = e.monthlyLimit ?? (e.tier == 'paid' ? 500 : 10);
    if (e.tier == 'paid') {
      return l10n.aiChatPaidMonthlyLimitReached(limit);
    }
    return l10n.aiChatFreeMonthlyLimitReached(limit);
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

  List<AiChatQuickReply> _fallbackStarterQuickReplies(AppLocalizations l10n) {
    return [
      AiChatQuickReply(
        label: l10n.askAiChoiceHint,
        sendText: l10n.askAiChoiceHint,
        actionId: 'hint',
      ),
      AiChatQuickReply(
        label: l10n.askAiChoiceApproach,
        sendText: l10n.askAiChoiceApproach,
        actionId: 'approach_only',
      ),
      AiChatQuickReply(
        label: l10n.askAiChoiceFirstStep,
        sendText: l10n.askAiChoiceFirstStep,
        actionId: 'first_step',
      ),
    ];
  }

  Widget _buildStarterQuickReplySection(AppLocalizations l10n) {
    final replies = _starterQuickReplies ?? _fallbackStarterQuickReplies(l10n);
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
  final VoidCallback onRestorePressed;
  final bool isRestoring;

  const _AiTutorUpgradeCard({
    required this.price,
    required this.onPressed,
    required this.onRestorePressed,
    required this.isRestoring,
  });

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
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: isRestoring ? null : onRestorePressed,
                icon: isRestoring
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.restore),
                label: Text(
                  isRestoring
                      ? l10n.aiTutorRestoreInProgress
                      : l10n.aiTutorRestorePurchasedButton,
                ),
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
  bool _isSigningInBeforePurchase = false;

  bool get _usesAppleSignIn =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  String _platformBillingBenefitText(AppLocalizations l10n) {
    if (!kIsWeb) {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          return l10n.aiTutorPurchaseBenefitPlatformBilling('Google Play');
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          return l10n.aiTutorPurchaseBenefitPlatformBilling('App Store');
        default:
          break;
      }
    }
    return l10n.aiTutorPurchaseBenefitPlatformBillingAny;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAuthenticated = FirebaseAuthService.isAuthenticated;
    final signInButtonText = _usesAppleSignIn
        ? l10n.aiTutorSignInWithAppleToPurchase
        : l10n.aiTutorSignInWithGoogleToPurchase;

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IapProductInfoSection(
            productName: l10n.aiTutorPurchaseProductName,
            price: widget.price,
            duration: l10n.aiTutorPurchaseDurationValue,
          ),
          const SizedBox(height: 14),
          _BenefitRow(text: l10n.aiTutorPurchaseBenefitMonthlyLimit),
          const SizedBox(height: 8),
          _BenefitRow(text: _platformBillingBenefitText(l10n)),
          const SizedBox(height: 14),
          const LegalNoticeFooter(),
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
                Expanded(
                  child: Text(
                    _isSigningInBeforePurchase
                        ? l10n.aiTutorSignInInProgress
                        : l10n.aiTutorPurchaseInProgress,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        FilledButton(
          onPressed: _isProcessing
              ? null
              : (isAuthenticated ? _purchase : _signInAndPurchase),
          child: Text(isAuthenticated ? l10n.purchase : signInButtonText),
        ),
        TextButton(
          onPressed: _isProcessing
              ? null
              : () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
      ],
    );
  }

  Future<void> _purchase() async {
    debugPrint('[AiTutorPurchase] Purchase button tapped');
    await _runPurchaseAction();
  }

  Future<void> _signInAndPurchase() async {
    final l10n = AppLocalizations.of(context)!;
    final providerLabel = _usesAppleSignIn ? 'Apple' : 'Google';
    debugPrint(
      '[AiTutorPurchase] $providerLabel sign-in before purchase started',
    );
    setState(() {
      _isProcessing = true;
      _isSigningInBeforePurchase = true;
    });

    try {
      final credential = _usesAppleSignIn
          ? await FirebaseAuthService.signInWithApple()
          : await FirebaseAuthService.signInWithGoogle();
      if (!mounted) return;
      if (credential == null) {
        debugPrint('[AiTutorPurchase] $providerLabel sign-in cancelled');
        setState(() {
          _isProcessing = false;
          _isSigningInBeforePurchase = false;
        });
        return;
      }

      final uid = credential.user?.uid;
      if (uid != null) {
        await CloudSyncPreferenceService.refreshForUser(uid);
      }

      debugPrint(
        '[AiTutorPurchase] $providerLabel sign-in succeeded, syncing RevenueCat user',
      );
      await RevenueCatService.syncCurrentFirebaseUser();
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _isSigningInBeforePurchase = false;
      });
      await _purchase();
    } catch (e) {
      debugPrint('[AiTutorPurchase] $providerLabel sign-in failed: $e');
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _isSigningInBeforePurchase = false;
      });
      _showAiTutorResultSnackBar(
        context,
        success: false,
        message:
            '${_usesAppleSignIn ? l10n.auth_appleSignInFailed : l10n.auth_googleSignInFailed}: $e',
      );
    }
  }

  Future<void> _runPurchaseAction() async {
    setState(() {
      _isProcessing = true;
      _isSigningInBeforePurchase = false;
    });
    try {
      final flowResult = await _purchaseAiTutorWithSync();
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _isSigningInBeforePurchase = false;
      });
      if (flowResult.success) {
        Navigator.of(context).pop(true);
        return;
      }
      if (flowResult.cancelled) return;
      if (flowResult.syncResult != null) {
        _showAiTutorResultSnackBar(
          context,
          success: false,
          message: _restoreSyncFailureMessage(
            AppLocalizations.of(context)!,
            flowResult.syncResult!,
          ),
        );
        return;
      }

      _showAiTutorResultSnackBar(
        context,
        success: false,
        message: AppLocalizations.of(context)!.purchaseFailed(
          flowResult.purchaseError ?? AppLocalizations.of(context)!.unknownError,
        ),
      );
    } catch (e) {
      debugPrint('[AiTutorPurchase] RevenueCat purchase threw: $e');
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _isSigningInBeforePurchase = false;
      });
      _showAiTutorResultSnackBar(
        context,
        success: false,
        message: AppLocalizations.of(context)!.purchaseFailed(e.toString()),
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
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
