// lib/pages/gacha_wrappers.dart
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'gacha_page.dart'; // 先ほどの汎用 GachaPage
import '../../problems/all_problems.dart'; // allIntegralProblems, allIndeterminateEquationProblems
// import '../problems/limit_problems1.dart'; // 削除済み

// 積分ガチャ
class IntegralGachaPage extends StatelessWidget {
  const IntegralGachaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GachaPage(
      problemPool: allIntegralProblems,
      title: l10n.integralGachaTitle,
      prefsPrefix: 'integral', // 保存用接頭辞（既存データと揃えるなら 'integral'）
    );
  }
}

// 極限ガチャ
class LimitGachaPage extends StatelessWidget {
  const LimitGachaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GachaPage(
      problemPool: allLimitProblems, // 下記注意参照
      title: l10n.limitGachaTitle,
      prefsPrefix: 'limit', // 適宜変更可（'limits' や 'limit' など）
    );
  }
}

// 因数分解ガチャ
class FactorizationGachaPage extends StatelessWidget {
  const FactorizationGachaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GachaPage(
      problemPool: allFactorizationProblems,
      title: l10n.factorizationGachaTitle,
      prefsPrefix: 'factorization',
    );
  }
}

// 不定方程式ガチャ
class IndeterminateEquationGachaPage extends StatelessWidget {
  const IndeterminateEquationGachaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GachaPage(
      problemPool: allIndeterminateEquationProblems,
      title: l10n.indeterminateEqGachaTitle,
      prefsPrefix: 'indeterminate_equation',
    );
  }
}

// 漸化式ガチャ
class SequenceGachaPage extends StatelessWidget {
  const SequenceGachaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GachaPage(
      problemPool: allSequenceProblems,
      title: l10n.sequenceGachaTitle,
      prefsPrefix: 'sequence',
    );
  }
}

// 三角指数対数ガチャ
class TrigExpLogEquationGachaPage extends StatelessWidget {
  const TrigExpLogEquationGachaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GachaPage(
      problemPool: allTrigExpLogEquationProblems,
      title: l10n.genericGachaTitle,
      prefsPrefix: 'trig_exp_log_equation',
    );
  }
}
