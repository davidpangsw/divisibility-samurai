import 'package:flutter/material.dart';

class NumberBlockAnimation extends StatefulWidget {
  final Widget child;

  const NumberBlockAnimation({
    super.key,
    required this.child,
  });

  @override
  State<NumberBlockAnimation> createState() => _NumberBlockAnimationState();
}

class _NumberBlockAnimationState extends State<NumberBlockAnimation> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        // Animation will be implemented later
      },
      child: widget.child,
    );
  }
}