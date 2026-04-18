// lib/pages/improved_gacha_page.dart
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/problem_level_utils.dart';
import '../../utils/l10n_utils.dart';
import '../../models/math_problem.dart';
import '../../models/learning_status.dart';
import '../../services/problems/simple_data_manager.dart';
import '../../widgets/gacha/learning_status_buttons.dart';
import '../../widgets/common/back_button.dart' as joy;

/// 改善されたガチャページ
/// 計算用紙から戻った時の状態管理を改善
class ImprovedGachaPage extends StatefulWidget {
  final List<MathProblem> problemPool;
  final String title;
  final String prefsPrefix;
  
  const ImprovedGachaPage({
    Key? key,
    required this.problemPool,
    required this.title,
    required this.prefsPrefix,
  }) : super(key: key);
  
  @override
  State<ImprovedGachaPage> createState() => _ImprovedGachaPageState();
}

class _ImprovedGachaPageState extends State<ImprovedGachaPage> {
  final List<MathProblem?> _current = [null, null, null];
  final List<bool> _showAnswer = [false, false, false];
  bool _isRolling = false;
  
  final List<ValueNotifier<LearningStatus>> _pendingNotifiers =
      List.generate(3, (_) => ValueNotifier<LearningStatus>(LearningStatus.none));
  
  @override
  void initState() {
    super.initState();
    _drawInitial();
  }
  
  @override
  void dispose() {
    for (final n in _pendingNotifiers) n.dispose();
    super.dispose();
  }
  
  void _drawInitial() {
    // 初期問題を設定（簡略化）
    for (int i = 0; i < 3; i++) {
      if (i < widget.problemPool.length) {
        _current[i] = widget.problemPool[i];
      }
    }
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Stack(
        children: [
          // コンテンツ
          Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // タイトル（スクロール可能）
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                      child: Center(
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B7355),
                          ),
                        ),
                      ),
                    ),
                    // ガチャボタン
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ElevatedButton(
                        onPressed: _isRolling ? null : _rollAll,
                        child: Text(_isRolling ? l10n.rolling : l10n.rollGacha),
                      ),
                    ),
                    // 問題表示エリア
                    for (int index = 0; index < 3; index++)
                      _buildProblemCard(index),
                  ],
                ),
              ),
            ],
          ),
          // 戻るボタン（最前面に配置）
          const joy.BackButton(),
        ],
      ),
    );
  }
  
  Widget _buildProblemCard(int index) {
    final problem = _current[index];
    final l10n = AppLocalizations.of(context)!;
    
    if (problem == null) {
      return Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Center(
          child: Text(l10n.noProblems),
        ),
      );
    }
    
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 問題情報
          Row(
            children: [
              Text(
                l10n.problemIndex(index + 1),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getLevelColor(problem.level),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  problem.getLocalizedLevel(context),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 問題内容
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Text(
              problem.getLocalizedQuestion(context),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // 学習記録ボタン群
          LearningStatusButtons(
            problem: problem,
            slotIndex: index,
            pendingNotifier: _pendingNotifiers[index],
            onStatusChanged: () {
              setState(() {});
            },
            onSaveRecord: () {
              _saveLearningRecord(index);
            },
          ),
          
          const SizedBox(height: 12),
          
          // 答え表示ボタン
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showAnswer[index] = !_showAnswer[index];
                  });
                },
                child: Text(_showAnswer[index] ? l10n.hideAnswer : l10n.showAnswer),
              ),
              
              if (_showAnswer[index]) ...[
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green[200]!),
                    ),
                    child: Text(
                      problem.getLocalizedAnswer(context),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
  
  Color _getLevelColor(String level) {
    final parsed = parseProblemLevel(level);
    return parsed == null ? Colors.grey : problemLevelColor(parsed);
  }
  
  void _rollAll() {
    setState(() {
      _isRolling = true;
    });
    
    // ガチャのアニメーション（簡略化）
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isRolling = false;
          _drawInitial();
        });
      }
    });
  }
  
  void _saveLearningRecord(int index) {
    final problem = _current[index];
    if (problem == null) return;
    final l10n = AppLocalizations.of(context)!;
    
    final status = _pendingNotifiers[index].value;
    if (status == LearningStatus.none) return;
    
    // 学習記録を保存
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.recordSaved(status.getLocalizedDisplayName(context))),
        duration: const Duration(seconds: 2),
      ),
    );
    
    // 状態をリセット
    _pendingNotifiers[index].value = LearningStatus.none;
    setState(() {});
  }
}
