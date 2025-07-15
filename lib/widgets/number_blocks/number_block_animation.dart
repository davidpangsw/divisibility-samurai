import 'package:flutter/material.dart';
import '../../configs/config.dart';

abstract class NumberBlockAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback? onAnimationTriggered;

  const NumberBlockAnimation({
    super.key,
    required this.child,
    this.onAnimationTriggered,
  });
}

abstract class NumberBlockAnimationState<T extends NumberBlockAnimation> extends State<T> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeOutAnimation;
  bool _hasBeenSlashed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Config.numberBlockAnimationDuration,
      vsync: this,
    );
    
    // Add listener to call callback when animation starts
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        widget.onAnimationTriggered?.call();
      }
    });
    
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
    // Only trigger if animation hasn't started yet and hasn't been slashed
    if (_controller.status == AnimationStatus.dismissed && !_hasBeenSlashed) {
      _hasBeenSlashed = true;
      // Don't play sound here - it should only play for correct answers
      _controller.forward();
    }
  }


  Widget buildAnimatedChild();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _triggerAnimation(), // Desktop: hover to slash
      child: Listener(
        onPointerMove: (_) => _triggerAnimation(), // Mobile: finger moves over
        child: GestureDetector(
          onTap: _triggerAnimation, // Mobile: tap to slash
          onPanDown: (_) => _triggerAnimation(), // Mobile: finger touches down
          behavior: HitTestBehavior.opaque, // Ensure we capture all touches
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeOutAnimation.value,
                child: buildAnimatedChild(),
              );
            },
          ),
        ),
      ),
    );
  }

  // Method to be called by parent when finger enters this block area
  void trySlash() {
    _triggerAnimation();
  }

  AnimationController get controller => _controller;
}