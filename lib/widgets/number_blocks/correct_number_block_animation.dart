import 'package:flutter/material.dart';
import '../../utils/line.dart';
import 'number_block_animation.dart';

class CorrectNumberBlockAnimation extends NumberBlockAnimation {
  final double width;
  final double height;

  const CorrectNumberBlockAnimation({
    super.key,
    required super.child,
    required this.width,
    required this.height,
    super.onAnimationTriggered,
  });

  @override
  State<CorrectNumberBlockAnimation> createState() => _CorrectNumberBlockAnimationState();
}

class _CorrectNumberBlockAnimationState extends NumberBlockAnimationState<CorrectNumberBlockAnimation> {
  late Animation<double> _lineAnimation;
  late Line _slashLine;

  @override
  void initState() {
    super.initState();
    _slashLine = Line.randomSlashing(widget.width, widget.height);
    _lineAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.25), // 100ms line animation
    ));
  }

  @override
  Widget buildAnimatedChild() {
    return CustomPaint(
      foregroundPainter: _SlashPainter(_slashLine, _lineAnimation.value),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
        child: widget.child,
      ),
    );
  }
}

class _SlashPainter extends CustomPainter {
  final Line line;
  final double progress;

  _SlashPainter(this.line, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (progress > 0) {
      final paint = Paint()
        ..color = Colors.red
        ..strokeWidth = 3.0
        ..strokeCap = StrokeCap.round;

      final (endX, endY) = line.evaluate(progress);
      canvas.drawLine(
        Offset(line.x1, line.y1),
        Offset(endX, endY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}