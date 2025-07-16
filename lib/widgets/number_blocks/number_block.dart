import 'package:flutter/material.dart';
import '../../configs/config.dart';
import 'basic_number_block.dart';
import 'correct_number_block_animation.dart';
import 'wrong_number_block_animation.dart';

class NumberBlock extends StatelessWidget {
  final int number;
  final bool isCorrect;
  final VoidCallback? onSlashed;

  const NumberBlock({
    super.key,
    required this.number,
    required this.isCorrect,
    this.onSlashed,
  });

  @override
  Widget build(BuildContext context) {
    final child = SizedBox(
      width: Config.numberBlockWidth,
      height: Config.numberBlockHeight,
      child: BasicNumberBlock(
        number: number,
      ),
    );

    if (isCorrect) {
      return CorrectNumberBlockAnimation(
        key: key,
        width: Config.numberBlockWidth,
        height: Config.numberBlockHeight,
        onAnimationTriggered: onSlashed,
        child: child,
      );
    } else {
      return WrongNumberBlockAnimation(
        key: key,
        startColor: Colors.transparent, // Start transparent to show wood
        endColor: Colors.red,          // Change to red when slashed
        onAnimationTriggered: onSlashed,
        child: child,
      );
    }
  }
}