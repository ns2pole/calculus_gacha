import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../integrations/ai_chat/joymath_ai_chat_purchase.dart';
import '../../l10n/app_localizations.dart';
import '../../navigation/app_route_observer.dart';
import '../../models/ai_tutor_usage_snapshot.dart';
import '../../services/auth/cloud_sign_in_flow.dart';
import '../../services/auth/firebase_auth_service.dart';
import '../../services/payment/ai_tutor_usage_service.dart';

class AiTutorPassStatusButton extends StatefulWidget {
  const AiTutorPassStatusButton({super.key});

  @override
  State<AiTutorPassStatusButton> createState() => _AiTutorPassStatusButtonState();
}

class _AiTutorPassStatusButtonState extends State<AiTutorPassStatusButton>
    with RouteAware, WidgetsBindingObserver {
  AiTutorUsageSnapshot? _usage;
  bool _isLoading = false;
  PageRoute<dynamic>? _route;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshUsage();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute && route != _route) {
      if (_route != null) {
        appRouteObserver.unsubscribe(this);
      }
      _route = route;
      appRouteObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_route != null) {
      appRouteObserver.unsubscribe(this);
    }
    super.dispose();
  }

  @override
  void didPopNext() {
    _refreshUsage(silent: true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshUsage(silent: true);
    }
  }

  Future<void> _refreshUsage({bool silent = false}) async {
    if (!FirebaseAuthService.isAuthenticated) {
      if (!mounted) return;
      setState(() => _usage = AiTutorUsageSnapshot.emptyFree);
      return;
    }

    if (!silent) {
      setState(() => _isLoading = true);
    }
    final usage = await AiTutorUsageService.fetchUsage();
    if (!mounted) return;
    setState(() {
      _usage = usage ?? AiTutorUsageSnapshot.emptyFree;
      _isLoading = false;
    });
  }

  Future<void> _openDetails() async {
    if (!FirebaseAuthService.isAuthenticated) {
      final signedIn = await CloudSignInFlow.signIn(context);
      if (!signedIn || !mounted) return;
      await _refreshUsage();
    }
    if (!mounted) return;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => _AiTutorPassStatusSheet(
        usage: _usage,
        isLoading: _isLoading,
        onPurchase: () async {
          Navigator.of(context).pop();
          final result = await joymathPurchaseAiTutor(context);
          if (!mounted) return;
          if (result.success) {
            await _refreshUsage();
          }
        },
      ),
    );
    if (mounted) await _refreshUsage();
  }

  @override
  Widget build(BuildContext context) {
    final remaining = _usage?.totalRemaining;
    final badgeText = _isLoading
        ? null
        : remaining != null && remaining > 0
            ? '$remaining'
            : null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _openDetails,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Badge(
            isLabelVisible: badgeText != null,
            label: Text(badgeText ?? ''),
            child: const Icon(
              Icons.auto_awesome_outlined,
              color: Color(0xFF8B7355),
              size: 36,
            ),
          ),
        ),
      ),
    );
  }
}

class _AiTutorPassStatusSheet extends StatelessWidget {
  final AiTutorUsageSnapshot? usage;
  final bool isLoading;
  final Future<void> Function() onPurchase;

  const _AiTutorPassStatusSheet({
    required this.usage,
    required this.isLoading,
    required this.onPurchase,
  });

  String _formatDate(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context).toString();
    return DateFormat.yMMMd(locale).format(date.toLocal());
  }

  Widget _buildBodyContent(BuildContext context, AppLocalizations l10n) {
    final snapshot = usage;

    if (!FirebaseAuthService.isAuthenticated) {
      return Text(
        l10n.aiTutorPassSignInPrompt,
        textAlign: TextAlign.center,
      );
    }
    if (isLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 10),
            Text(l10n.aiTutorPassLoading),
          ],
        ),
      );
    }
    if (snapshot == null) {
      return Text(
        l10n.aiTutorPassNoPasses,
        textAlign: TextAlign.center,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _buildUsageContent(context, l10n, snapshot),
    );
  }

  List<Widget> _buildUsageContent(
    BuildContext context,
    AppLocalizations l10n,
    AiTutorUsageSnapshot snapshot,
  ) {
    if (snapshot.hasPasses) {
      final widgets = <Widget>[
        Text(
          l10n.aiTutorPassCombinedRemaining(snapshot.totalRemaining),
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
      ];

      if (snapshot.freeRemaining > 0) {
        widgets.add(
          Text(
            l10n.aiTutorPassFreeRemaining(snapshot.freeRemaining),
            textAlign: TextAlign.center,
          ),
        );
        widgets.add(const SizedBox(height: 12));
      }

      widgets.addAll(_buildPaidContent(context, l10n, snapshot));
      return widgets;
    }

    return _buildFreeContent(context, l10n, snapshot);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.85;

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.aiTutorPassStatusTitle,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Flexible(
                child: SingleChildScrollView(
                  child: _buildBodyContent(context, l10n),
                ),
              ),
              if (FirebaseAuthService.isAuthenticated) ...[
                const SizedBox(height: 16),
                Text(
                  l10n.aiTutorPurchaseBenefitPassLimit,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: onPurchase,
                  child: Text(l10n.aiTutorPassBuyMore),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPaidContent(
    BuildContext context,
    AppLocalizations l10n,
    AiTutorUsageSnapshot snapshot,
  ) {
    if (snapshot.passes.isEmpty) {
      return [
        Text(
          l10n.aiTutorPassNoPasses,
          textAlign: TextAlign.center,
        ),
      ];
    }

    return [
      Text(
        l10n.aiTutorPassTotalRemaining(
          snapshot.passRemaining,
          snapshot.passLimit,
        ),
        style: Theme.of(context).textTheme.titleSmall,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 16),
      ...snapshot.passes.map((pass) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.aiTutorPassLotRemaining(pass.remaining),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(l10n.aiTutorPassPurchasedAt(
                    _formatDate(context, pass.purchasedAt),
                  )),
                  Text(l10n.aiTutorPassExpiresAt(
                    _formatDate(context, pass.expiresAt),
                  )),
                ],
              ),
            ),
          )),
    ];
  }

  List<Widget> _buildFreeContent(
    BuildContext context,
    AppLocalizations l10n,
    AiTutorUsageSnapshot snapshot,
  ) {
    return [
      Text(
        l10n.aiTutorPassFreeRemaining(snapshot.freeRemaining),
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
    ];
  }
}
