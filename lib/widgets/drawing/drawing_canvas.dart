import 'package:flutter/material.dart';
import '../../pages/other/scratch_paper_page.dart' show DrawingPoint, DrawingPainter;

class DrawingCanvas extends StatefulWidget {
  final bool isEraser;
  final bool isScrollMode;
  final Color currentColor;
  final double currentStrokeWidth;
  final ValueNotifier<bool>? isDrawingNotifier;
  final double width;
  final double height;

  const DrawingCanvas({
    Key? key,
    required this.isEraser,
    required this.isScrollMode,
    required this.currentColor,
    required this.currentStrokeWidth,
    this.isDrawingNotifier,
    this.width = 2000,
    this.height = 2000,
  }) : super(key: key);

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  final GlobalKey _paintKey = GlobalKey();
  List<DrawingPoint> _points = [];
  List<List<DrawingPoint>> _strokes = [];
  List<List<DrawingPoint>> _undoStack = [];
  List<List<DrawingPoint>> _redoStack = [];
  
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  void dispose() {
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  // 筆圧から線幅を計算する関数
  double _calculateStrokeWidth(double pressure) {
    if (pressure <= 0.0) {
      return widget.currentStrokeWidth; // デフォルト値（筆圧なし）
    }
    const minWidth = 1.0;
    const maxWidth = 8.0;
    // 筆圧値（0.0〜1.0）を線幅にマッピング
    return minWidth + (pressure * (maxWidth - minWidth));
  }

  void _onPointerDown(PointerDownEvent event) {
    if (widget.isScrollMode) {
      return;
    }

    final pressure = event.pressure;
    final strokeWidth = _calculateStrokeWidth(pressure);
    
    widget.isDrawingNotifier?.value = true;
    
    setState(() {
      _points = [
        DrawingPoint(
          event.localPosition,
          widget.currentColor,
          strokeWidth,
          widget.isEraser,
        ),
      ];
    });
  }
  
  void _onPointerMove(PointerMoveEvent event) {
    if (widget.isScrollMode) {
      return;
    }

    final pressure = event.pressure;
    final strokeWidth = _calculateStrokeWidth(pressure);

    if (widget.isEraser) {
      _eraseAtPoint(event.localPosition);
    } else {
      setState(() {
        _points.add(
          DrawingPoint(
            event.localPosition,
            widget.currentColor,
            strokeWidth,
            false,
          ),
        );
      });
    }
  }
  
  void _onPointerUp(PointerUpEvent event) {
    widget.isDrawingNotifier?.value = false;
    
    if (widget.isScrollMode) {
      return;
    }
    
    if (!widget.isEraser) {
      setState(() {
        _strokes.add(List.from(_points));
        _points = [];
        _redoStack.clear();
      });
    }
  }

  void _onPointerCancel(PointerCancelEvent event) {
    widget.isDrawingNotifier?.value = false;

    if (widget.isScrollMode) {
      return;
    }

    if (!widget.isEraser && _points.isNotEmpty) {
      setState(() {
        _strokes.add(List.from(_points));
        _points = [];
        _redoStack.clear();
      });
    }
  }
  
  void _eraseAtPoint(Offset point) {
    setState(() {
      const eraseRadius = 20.0;
      final List<List<DrawingPoint>> newStrokes = [];
      
      for (final stroke in _strokes) {
        final List<DrawingPoint> remainingPoints = [];
        bool wasErasing = false;
        
        for (int i = 0; i < stroke.length; i++) {
          final distance = (stroke[i].point - point).distance;
          
          if (distance < eraseRadius) {
            // 消しゴムの範囲内のポイントはスキップ
            wasErasing = true;
          } else {
            // 消しゴムの範囲外のポイント
            if (wasErasing && remainingPoints.isNotEmpty) {
              // 前回の消去範囲から離れたので、新しいストロークとして保存
              if (remainingPoints.length > 1) {
                newStrokes.add(List.from(remainingPoints));
              }
              remainingPoints.clear();
            }
            remainingPoints.add(stroke[i]);
            wasErasing = false;
          }
        }
        
        // 残りのポイントがある場合は追加
        if (remainingPoints.length > 1) {
          newStrokes.add(remainingPoints);
        }
      }
      
      _strokes = newStrokes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _verticalScrollController,
      scrollDirection: Axis.vertical,
      physics: widget.isScrollMode
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      child: SingleChildScrollView(
        controller: _horizontalScrollController,
        scrollDirection: Axis.horizontal,
        physics: widget.isScrollMode
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: Listener(
            onPointerDown: _onPointerDown,
            onPointerMove: _onPointerMove,
            onPointerUp: _onPointerUp,
            onPointerCancel: _onPointerCancel,
            child: RepaintBoundary(
              key: _paintKey,
              child: CustomPaint(
                painter: DrawingPainter(
                  strokes: _strokes,
                  currentStroke: _points,
                ),
                size: Size(widget.width, widget.height),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


