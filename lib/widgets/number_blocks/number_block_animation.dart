import 'package:flutter/material.dart';

abstract class NumberBlockAnimation extends StatefulWidget {
  final Widget child;

  const NumberBlockAnimation({
    super.key,
    required this.child,
  });
}

abstract class NumberBlockAnimationState<T extends NumberBlockAnimation> extends State<T> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeOutAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _fadeOutAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.25, 1.0), // 300ms fade out after 100ms
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerAnimation() {
    if (!_hasAnimated) {
      _hasAnimated = true;
      _controller.forward();
    }
  }

  Widget buildAnimatedChild();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _triggerAnimation(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeOutAnimation.value,
            child: buildAnimatedChild(),
          );
        },
      ),
    );
  }

  AnimationController get controller => _controller;
}