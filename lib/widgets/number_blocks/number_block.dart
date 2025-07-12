import 'package:flutter/material.dart';
import '../../configs/config.dart';
import 'basic_number_block.dart';
import 'correct_number_block_animation.dart';
import 'wrong_number_block_animation.dart';

class NumberBlock extends StatelessWidget {
  final int number;
  final bool isCorrect;

  const NumberBlock({
    super.key,
    required this.number,
    required this.isCorrect,
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
        width: Config.numberBlockWidth,
        height: Config.numberBlockHeight,
        child: child,
      );
    } else {
      return WrongNumberBlockAnimation(
        startColor: Colors.blue,
        endColor: Colors.red,
        child: child,
      );
    }
  }
}