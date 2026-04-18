// lib/widgets/congruence_calculator.dart
// 合同方程式入力用電卓ウィジェット

import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

/// 合同方程式入力用電卓
class CongruenceCalculator extends StatefulWidget {
  final Function(String) onEnter;
  final String? initialValue;
  final bool isAnswered;
  final VoidCallback? onNext;
  final String? nextButtonText;

  const CongruenceCalculator({
    Key? key,
    required this.onEnter,
    this.initialValue,
    this.isAnswered = false,
    this.onNext,
    this.nextButtonText,
  }) : super(key: key);

  @override
  State<CongruenceCalculator> createState() => _CongruenceCalculatorState();
}

class _CongruenceCalculatorState extends State<CongruenceCalculator> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  final String _prefix = "x≡ ";

  @override
  void initState() {
    super.initState();
    // 初期値が設定されている場合はそれを使用し、なければプレフィックスのみを設定
    final initialText = widget.initialValue != null && widget.initialValue!.isNotEmpty
        ? widget.initialValue!
        : _prefix;
        
    // プレフィックスが含まれていない場合は追加する（既存の動作との互換性のため）
    _controller = TextEditingController(
      text: initialText.startsWith(_prefix) ? initialText : _prefix + initialText
    );
    
    _controller.addListener(() {
      setState(() {}); // テキスト変更時にUIを更新
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 入力フィールド（幅を制限）
          SizedBox(
            width: isMobile ? 260 : 280,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              readOnly: true, // キーボード入力を無効化（ボタンからのみ入力）
              enableInteractiveSelection: false, // 選択を無効化
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              onTap: () {
                // タップしてもフォーカスしないようにする
                _focusNode.unfocus();
              },
              decoration: InputDecoration(
                hintText: l10n.congruenceHintExample,
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: isMobile ? 12 : 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // 数字キーボードボタン（4x4グリッド）
          _buildNumberButtons(),
          
          // 次へボタン（解答後のみ表示）
          if (widget.isAnswered && widget.onNext != null) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: widget.onNext,
                icon: const Icon(Icons.arrow_forward),
                label: Text(
                  widget.nextButtonText ?? l10n.next,
                  style: const TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 数字ボタン（4x4グリッド）
  Widget _buildNumberButtons() {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = MediaQuery.of(context).size.width < 600;
    final buttonPadding = isMobile
        ? const EdgeInsets.symmetric(horizontal: 4, vertical: 6)
        : const EdgeInsets.symmetric(horizontal: 4, vertical: 8);
    final buttonMinSize = isMobile ? const Size(58, 46) : const Size(64, 52);
    
    // 4段で配置
    // Row 1: 7, 8, 9, AC
    // Row 2: 4, 5, 6, ×
    // Row 3: 1, 2, 3, mod
    // Row 4: 0, ,, 確定
    
    return Column(
      children: [
        // 1行目: 7, 8, 9, AC
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNumberButton('7', () => _insertText('7'), buttonPadding, buttonMinSize),
            _buildNumberButton('8', () => _insertText('8'), buttonPadding, buttonMinSize),
            _buildNumberButton('9', () => _insertText('9'), buttonPadding, buttonMinSize),
            _buildControlButton('AC', _canClear() ? _clearAll : null, Colors.red.shade400, buttonPadding, buttonMinSize),
          ],
        ),
        // 2行目: 4, 5, 6, ×
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNumberButton('4', () => _insertText('4'), buttonPadding, buttonMinSize),
            _buildNumberButton('5', () => _insertText('5'), buttonPadding, buttonMinSize),
            _buildNumberButton('6', () => _insertText('6'), buttonPadding, buttonMinSize),
            _buildControlButton('×', _canDelete() ? _deleteLastChar : null, Colors.orange.shade400, buttonPadding, buttonMinSize),
          ],
        ),
        // 3行目: 1, 2, 3, mod
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNumberButton('1', () => _insertText('1'), buttonPadding, buttonMinSize),
            _buildNumberButton('2', () => _insertText('2'), buttonPadding, buttonMinSize),
            _buildNumberButton('3', () => _insertText('3'), buttonPadding, buttonMinSize),
            _buildTextButton('mod', _insertMod, buttonPadding, buttonMinSize),
          ],
        ),
        // 4行目: 0, ,, 確定
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNumberButton('0', () => _insertText('0'), buttonPadding, buttonMinSize),
            _buildTextButton(',', () => _insertText(','), buttonPadding, buttonMinSize),
            
            // 確定ボタン（横長）- 幅を調整するためにExpandedは使わず、固定幅x2 + padding分にする
            Padding(
              padding: const EdgeInsets.all(4),
              child: ElevatedButton(
                onPressed: widget.isAnswered
                    ? null  // 解答後は無効化
                    : (_isValidInput() ? _handleEnter : null),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade400,
                  disabledForegroundColor: Colors.grey.shade600,
                  padding: buttonPadding,
                  minimumSize: Size(buttonMinSize.width * 2 + 8, buttonMinSize.height), // 2つ分の幅
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  l10n.complete,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNumberButton(String text, VoidCallback onPressed, EdgeInsets padding, Size minSize) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ElevatedButton(
        onPressed: widget.isAnswered ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          padding: padding,
          minimumSize: minSize,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 1,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
  
  Widget _buildTextButton(String text, VoidCallback onPressed, EdgeInsets padding, Size minSize) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ElevatedButton(
        onPressed: widget.isAnswered ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          padding: padding,
          minimumSize: minSize,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 1,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildControlButton(String text, VoidCallback? onPressed, Color backgroundColor, EdgeInsets padding, Size minSize) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ElevatedButton(
        onPressed: widget.isAnswered ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: onPressed != null ? backgroundColor : Colors.grey.shade300,
          foregroundColor: Colors.white,
          padding: padding,
          minimumSize: minSize,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 1,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _insertMod() {
    final text = _controller.text;
    // すでにmodが含まれている場合は何もしない（重複防止）
    if (text.contains("(mod")) {
      return;
    }
    
    // (mod )を追加
    final newText = "$text (mod )";
    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: newText.length,
      ),
    );
  }

  void _insertText(String str) {
    final text = _controller.text;
    
    String newText;
    int newSelectionIndex;
    
    // 末尾が ) で、かつ入力が数字の場合は、) の前に挿入する
    // ただしカンマの場合は ) の中に入れない（または ) の外に出す）
    // ユーザー要望: "** (mod )" -> "** (mod 19)"
    if (text.endsWith(')') && RegExp(r'[0-9]').hasMatch(str)) {
      // ) の直前に挿入
      newText = text.substring(0, text.length - 1) + str + ")";
      // カーソルは末尾（)の後ろ）に維持するか、) の前にするか？
      // ここでは単純に newText を設定し、カーソルは末尾へ（readOnlyなのでユーザーはカーソル移動できない前提）
      // _insertTextの最後で offset: newText.length としているので、これに合わせる
      newSelectionIndex = newText.length;
    } else {
      // 通常追加
      newText = text + str;
      newSelectionIndex = newText.length;
    }

    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: newSelectionIndex,
      ),
    );
  }
  
  bool _canDelete() {
    return _controller.text.length > _prefix.length;
  }
  
  bool _canClear() {
    return _controller.text.length > _prefix.length;
  }

  void _deleteLastChar() {
    final text = _controller.text;
    if (text.length > _prefix.length) {
      String newText;
      
      // 末尾が ) の場合の特殊削除ロジック
      if (text.endsWith(')')) {
        // (mod ) のパターンを探す
        final modIndex = text.lastIndexOf("(mod ");
        if (modIndex != -1) {
          final content = text.substring(modIndex + 5, text.length - 1); // " (mod "の長さは5ではない。" (mod "はスペース含め6文字か、"(mod "なら5文字。
          // _insertMod で " (mod )" を追加している -> スペース1つ + (mod + スペース1つ = "(mod " length=5
          // 実装: "$text (mod )" -> " (mod )" length=7
          
          // text.lastIndexOf("(mod ") は "(mod " の開始位置。
          // "(mod " の後ろから ")" の前までがコンテンツ。
          
          // もしコンテンツが空なら、ブロックごと削除
          if (content.trim().isEmpty) {
             // " (mod )" または "(mod )" を削除
             // 直前にスペースがあるかも考慮
             newText = text.substring(0, modIndex).trimRight();
          } else {
            // 数字が入っている場合、最後の数字を削除
            // 例: (mod 19) -> (mod 1)
            newText = text.substring(0, text.length - 2) + ")";
          }
        } else {
          // (mod が見つからない場合（異常系）、通常削除
          newText = text.substring(0, text.length - 1);
        }
      } else if (text.endsWith(" mod ")) {
        // 旧仕様の互換性（念のため残す）
        newText = text.substring(0, text.length - 5);
      } else {
        newText = text.substring(0, text.length - 1);
      }
      
      // プレフィックスより短くならないように保護
      if (newText.length < _prefix.length) {
        newText = _prefix;
      }
      
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: newText.length,
        ),
      );
    }
  }

  void _clearAll() {
    setState(() {
      _controller.text = _prefix;
      _controller.selection = TextSelection.collapsed(offset: _prefix.length);
    });
  }

  bool _isValidInput() {
    return _controller.text.length > _prefix.length;
  }

  void _handleEnter() {
    final input = _controller.text.trim();
    if (_isValidInput()) {
      widget.onEnter(input);
    }
  }
}
