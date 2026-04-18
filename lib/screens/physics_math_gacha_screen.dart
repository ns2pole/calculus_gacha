// physics_math_gacha_screen.dart
// 微分方程式ガチャ画面

import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../pages/gacha/gacha_page.dart';
import '../problems/physics_math/physics_math_gacha.dart';

class PhysicsMathGachaScreen extends StatelessWidget {
  const PhysicsMathGachaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GachaPage(
      problemPool: physicsMathGachaProblems,
      title: l10n.differentialEquationGacha,
      prefsPrefix: 'physics_math',
    );
  }
}
