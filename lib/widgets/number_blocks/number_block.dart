import 'package:flutter/material.dart';
import '../../configs/config.dart';
import 'basic_number_block.dart';
import 'number_block_animation.dart';

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
    return NumberBlockAnimation(
      child: SizedBox(
        width: Config.numberBlockWidth,
        height: Config.numberBlockHeight,
        child: BasicNumberBlock(
          number: number,
          color: Colors.blue,
        ),
      ),
    );
  }
}