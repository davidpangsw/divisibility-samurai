import 'package:flutter/material.dart';
import 'number_block_animation.dart';

class WrongNumberBlockAnimation extends NumberBlockAnimation {
  final Color startColor;
  final Color endColor;

  const WrongNumberBlockAnimation({
    super.key,
    required super.child,
    required this.startColor,
    required this.endColor,
  });

  @override
  State<WrongNumberBlockAnimation> createState() => _WrongNumberBlockAnimationState();
}

class _WrongNumberBlockAnimationState extends NumberBlockAnimationState<WrongNumberBlockAnimation> {
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _colorAnimation = ColorTween(
      begin: widget.startColor,
      end: widget.endColor,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.25), // 100ms color change
    ));
  }

  @override
  Widget buildAnimatedChild() {
    return Container(
      decoration: BoxDecoration(
        color: _colorAnimation.value ?? widget.startColor,
      ),
      child: widget.child,
    );
  }
}