// lib/widgets/learning_status_buttons.dart
import 'package:flutter/material.dart';
import '../../models/math_problem.dart';
import '../../models/learning_status.dart';
import '../../l10n/app_localizations.dart';
import '../../pages/other/scratch_paper_page.dart';
import '../../services/gacha/gacha_page_state_manager.dart';

/// 学習記録ボタン群のウィジェット
/// 計算用紙で記録された問題の状態を管理
class LearningStatusButtons extends StatefulWidget {
  final MathProblem problem;
  final int slotIndex;
  final ValueNotifier<LearningStatus> pendingNotifier;
  final VoidCallback onStatusChanged;
  final VoidCallback onSaveRecord;
  
  const LearningStatusButtons({
    Key? key,
    required this.problem,
    required this.slotIndex,
    required this.pendingNotifier,
    required this.onStatusChanged,
    required this.onSaveRecord,
  }) : super(key: key);
  
  @override
  State<LearningStatusButtons> createState() => _LearningStatusButtonsState();
}

class _LearningStatusButtonsState extends State<LearningStatusButtons> {
  bool _isRecorded = false;
  LearningStatus _currentStatus = LearningStatus.none;
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadProblemState();
  }
  
  Future<void> _loadProblemState() async {
    final state = await GachaPageStateManager.getProblemDisplayState(widget.problem);
    
    if (mounted) {
      setState(() {
        _isRecorded = state['isRecorded'] as bool;
        _currentStatus = state['currentStatus'] as LearningStatus;
        _isLoading = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        width: 120,
        height: 48,
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 計算用紙ボタン
        _buildScratchPaperButton(),
        const SizedBox(width: 16),
        // 学習記録切り替えボタン
        _buildLearningStatusButton(),
        const SizedBox(width: 8),
        // 保存ボタン
        _buildSaveButton(),
      ],
    );
  }
  
  Widget _buildScratchPaperButton() {
    final shouldHighlight = GachaPageStateManager.shouldHighlightScratchPaperButton(widget.problem);
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      decoration: shouldHighlight ? BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange[400]!, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.orange[400]!.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ) : null,
      child: IconButton(
        tooltip: l10n.openScratchPaper,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ScratchPaperPage(problem: widget.problem),
            ),
          );
          
          // 計算用紙から戻った際の処理
          if (result == true) {
            await _handleScratchPaperReturn();
          }
        },
        icon: Icon(
          Icons.edit_note,
          size: shouldHighlight ? 28 : 26,
          color: shouldHighlight ? Colors.orange[600] : Colors.green[600],
        ),
      ),
    );
  }
  
  Widget _buildLearningStatusButton() {
    final isDisabled = GachaPageStateManager.shouldDisableLearningButtons(widget.problem);
    final l10n = AppLocalizations.of(context)!;
    
    return ValueListenableBuilder<LearningStatus>(
      valueListenable: widget.pendingNotifier,
      builder: (context, status, child) {
        return IconButton(
          tooltip: isDisabled ? l10n.learningRecordSaved : status.getLocalizedTooltip(context),
          onPressed: isDisabled ? null : () {
            widget.pendingNotifier.value = status.next;
            widget.onStatusChanged();
          },
          icon: Icon(
            status.icon,
            size: 28,
            color: isDisabled ? Colors.grey[400] : status.color,
          ),
        );
      },
    );
  }
  
  Widget _buildSaveButton() {
    final isDisabled = GachaPageStateManager.shouldDisableSaveButton(widget.problem);
    final l10n = AppLocalizations.of(context)!;
    
    return ValueListenableBuilder<LearningStatus>(
      valueListenable: widget.pendingNotifier,
      builder: (context, status, child) {
        return IconButton(
          tooltip: isDisabled ? l10n.learningRecordSaved : l10n.saveLearningRecord,
          onPressed: (isDisabled || status == LearningStatus.none) ? null : () {
            widget.onSaveRecord();
          },
          icon: Icon(
            Icons.save,
            size: 28,
            color: isDisabled ? Colors.grey[400] : 
                   (status != LearningStatus.none ? Colors.blue : Colors.grey[400]),
          ),
        );
      },
    );
  }
  
  Future<void> _handleScratchPaperReturn() async {
    // 計算用紙で記録された場合の処理
    final result = await GachaPageStateManager.handleScratchPaperReturn(
      widget.problem,
      true, // 計算用紙で記録された
    );
    
    if (mounted) {
      setState(() {
        _isRecorded = result['wasRecorded'] as bool;
        _currentStatus = result['currentStatus'] as LearningStatus;
      });
      
      // スナックバーを表示
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.learningRecordSaved),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
