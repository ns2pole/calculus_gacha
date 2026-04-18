// lib/widgets/timer_display.dart
import 'package:flutter/material.dart';
import '../../managers/timer_manager.dart';
import '../../l10n/app_localizations.dart';

/// タイマー表示ウィジェット（共通化）
class TimerDisplay extends StatelessWidget {
  final TimerManager timerManager;
  final FocusNode? focusNode;

  const TimerDisplay({
    super.key,
    required this.timerManager,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: timerManager.isTimerEnabledNotifier,
      builder: (context, isEnabled, child) {
        if (!isEnabled) {
          return const SizedBox.shrink();
        }

        return ValueListenableBuilder<int>(
          valueListenable: timerManager.remainingSecondsNotifier,
          builder: (context, remainingSeconds, child) {
            final minutes = remainingSeconds ~/ 60;
            final seconds = remainingSeconds % 60;
            final timeString = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

            return ValueListenableBuilder<bool>(
              valueListenable: timerManager.isTimerRunningNotifier,
              builder: (context, isRunning, child) {
                return _TimerContent(
                  timeString: timeString,
                  isRunning: isRunning,
                  timerManager: timerManager,
                  focusNode: focusNode,
                );
              },
            );
          },
        );
      },
    );
  }
}

class _TimerContent extends StatelessWidget {
  final String timeString;
  final bool isRunning;
  final TimerManager timerManager;
  final FocusNode? focusNode;

  const _TimerContent({
    required this.timeString,
    required this.isRunning,
    required this.timerManager,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade100, Colors.green.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.green.shade400,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 再生/停止ボタン
            IconButton(
              focusNode: focusNode,
              icon: Icon(isRunning ? Icons.pause_circle : Icons.play_circle),
              onPressed: () => timerManager.toggleTimerPlayPause(),
              iconSize: 32,
              color: Colors.green[900],
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              visualDensity: VisualDensity.compact,
            ),
            // 時間調整ボタン（--、1分削減）
            IconButton(
              focusNode: focusNode,
              icon: const Icon(Icons.remove_circle),
              onPressed: () => timerManager.decrementTimer60(),
              iconSize: 24,
              color: Colors.green[900],
              tooltip: l10n.timerTooltipMinus1Min,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              visualDensity: VisualDensity.compact,
            ),
            // 時間調整ボタン（-、30秒削減）
            IconButton(
              focusNode: focusNode,
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () => timerManager.decrementTimer30(),
              iconSize: 24,
              color: Colors.green[900],
              tooltip: l10n.timerTooltipMinus30Sec,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              visualDensity: VisualDensity.compact,
            ),
            // 時間表示
            Text(
              timeString,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            // 時間調整ボタン（+、30秒追加）
            IconButton(
              focusNode: focusNode,
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () => timerManager.incrementTimer30(),
              iconSize: 24,
              color: Colors.green[900],
              tooltip: l10n.timerTooltipPlus30Sec,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              visualDensity: VisualDensity.compact,
            ),
            // 時間調整ボタン（++、1分追加）
            IconButton(
              focusNode: focusNode,
              icon: const Icon(Icons.add_circle),
              onPressed: () => timerManager.incrementTimer60(),
              iconSize: 24,
              color: Colors.green[900],
              tooltip: l10n.timerTooltipPlus1Min,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              visualDensity: VisualDensity.compact,
            ),
            // リセットボタン
            IconButton(
              focusNode: focusNode,
              icon: const Icon(Icons.refresh),
              onPressed: () => timerManager.resetTimer(),
              iconSize: 24,
              color: Colors.green[900],
              tooltip: l10n.timerTooltipReset,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }
}



