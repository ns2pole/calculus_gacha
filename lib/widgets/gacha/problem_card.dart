// lib/widgets/problem_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/l10n_utils.dart';
import '../../models/math_problem.dart';
import '../../models/step_item.dart';
import '../../models/learning_status.dart';
import '../constants/app_constants.dart';
import '../../pages/common/common.dart';

/// 問題カードのウィジェット
class ProblemCard extends StatelessWidget {
  final MathProblem? problem;
  final bool showAnswer;
  final bool showExplanation;
  final LearningStatus learningStatus;
  final VoidCallback? onAnswerToggle;
  final VoidCallback? onExplanationToggle;
  final VoidCallback? onLearningStatusCycle;
  final VoidCallback? onSaveLearningRecord;
  final VoidCallback? onScratchPaperOpen;
  final bool shouldHighlightScratchPaper;

  const ProblemCard({
    super.key,
    required this.problem,
    required this.showAnswer,
    required this.showExplanation,
    required this.learningStatus,
    this.onAnswerToggle,
    this.onExplanationToggle,
    this.onLearningStatusCycle,
    this.onSaveLearningRecord,
    this.onScratchPaperOpen,
    this.shouldHighlightScratchPaper = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (problem == null) {
      return _buildEmptyCard(context);
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProblemContent(context),
            const SizedBox(height: AppConstants.defaultPadding),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Center(
          child: Text(
            l10n.noProblems,
            style: const TextStyle(fontSize: AppConstants.largeFontSize),
          ),
        ),
      ),
    );
  }

  Widget _buildProblemContent(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 問題文
        MixedTextMath(
          problem!.getLocalizedQuestion(context),
          labelStyle: const TextStyle(fontSize: AppConstants.largeFontSize),
          mathStyle: const TextStyle(fontSize: AppConstants.extraLargeFontSize),
          forceTex: false,
        ),
        
        // 解答表示
        if (showAnswer) ...[
          const SizedBox(height: AppConstants.defaultPadding),
          Text(
            l10n.answerLabel,
            style: const TextStyle(
              fontSize: AppConstants.largeFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.smallPadding),
          MixedTextMath(
            problem!.getLocalizedAnswer(context),
            labelStyle: const TextStyle(fontSize: AppConstants.largeFontSize),
            mathStyle: const TextStyle(
              fontSize: AppConstants.extraLargeFontSize,
              color: Colors.green,
            ),
            forceTex: false,
          ),
        ],
        
        // 解説表示
        if (showExplanation) ...[
          const SizedBox(height: AppConstants.defaultPadding),
          Text(
            l10n.explanationLabel,
            style: const TextStyle(
              fontSize: AppConstants.largeFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.smallPadding),
          _buildExplanationContent(context),
        ],
      ],
    );
  }

  Widget _buildExplanationContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 問題画像
        if (problem!.imageAsset != null) ...[
          _buildProblemImage(context),
          const SizedBox(height: AppConstants.defaultPadding),
        ],
        
        // 解説ステップ
        ...problem!.getLocalizedSteps(context).map((step) => _buildExplanationStep(context, step)),
      ],
    );
  }

  Widget _buildProblemImage(BuildContext context) {
    return FutureBuilder<bool>(
      future: _assetExists(context, problem!.imageAsset!),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox.shrink();
        }
        
        if (snapshot.hasData && snapshot.data == true) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = MediaQuery.of(context).size.width * AppConstants.maxImageWidthRatio;
              return ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Image.asset(
                  problem!.imageAsset!,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                ),
              );
            },
          );
        }
        
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildExplanationStep(BuildContext context, StepItem step) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.smallPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (step.tex != null && step.tex!.trim().isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: MixedTextMath(
                step.tex!,
                forceTex: true,
                labelStyle: const TextStyle(fontSize: AppConstants.largeFontSize),
                mathStyle: const TextStyle(fontSize: AppConstants.largeFontSize),
              ),
            ),
          if (step.imageAsset != null) _buildStepImage(context, step.imageAsset!),
        ],
      ),
    );
  }

  Widget _buildStepImage(BuildContext context, String imageAsset) {
    return FutureBuilder<bool>(
      future: _assetExists(context, imageAsset),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox.shrink();
        }
        
        if (snapshot.hasData && snapshot.data == true) {
          // StepItem内画像を統一的に2倍大きくしてセンタリング
          return Column(
            children: [
              const SizedBox(height: 6),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 400),
                  child: Image.asset(
                    imageAsset,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                  ),
                ),
              ),
            ],
          );
        }
        
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 解答表示ボタン
        IconButton(
          icon: Icon(
            showAnswer ? Icons.visibility : Icons.visibility_off,
            color: showAnswer ? Colors.orange : Colors.blue,
          ),
          onPressed: onAnswerToggle,
          tooltip: showAnswer ? l10n.hideAnswer : l10n.showAnswer,
        ),
        
        // 解説表示ボタン
        IconButton(
          icon: Icon(
            showExplanation ? Icons.close : Icons.psychology,
            color: showExplanation ? Colors.red : Colors.purple,
          ),
          onPressed: onExplanationToggle,
          tooltip: showExplanation ? l10n.hideSolution : l10n.showSolution,
        ),
        
        // 学習記録状態ボタン
        IconButton(
          icon: Icon(
            learningStatus.icon,
            color: learningStatus.color,
          ),
          onPressed: onLearningStatusCycle,
          tooltip: learningStatus.getLocalizedTooltip(context),
        ),
        
        // セーブボタン
        IconButton(
          icon: Icon(
            Icons.save,
            color: learningStatus != LearningStatus.none ? Colors.blue : Colors.grey,
          ),
          onPressed: learningStatus != LearningStatus.none ? onSaveLearningRecord : null,
          tooltip: l10n.saveLearningRecord,
        ),
        
        // 計算用紙ボタン
        IconButton(
          icon: Icon(
            Icons.edit_note,
            size: shouldHighlightScratchPaper ? 24 : 22,
            color: shouldHighlightScratchPaper ? Colors.orange[600] : Colors.blue,
          ),
          onPressed: onScratchPaperOpen,
          tooltip: l10n.openScratchPaper,
        ),
      ],
    );
  }

  Future<bool> _assetExists(BuildContext context, String assetPath) async {
    try {
      await DefaultAssetBundle.of(context).load(assetPath);
      return true;
    } catch (e) {
      return false;
    }
  }
}
