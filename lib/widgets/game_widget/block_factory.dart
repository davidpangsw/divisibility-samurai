import 'dart:math';
import '../../configs/config.dart';
import '../number_blocks/animated_number_block_model.dart';

class BlockFactory {
  static final Random _random = Random();

  static AnimatedNumberBlock createBlock(int divisor) {
    final number = Config.minNumber + _random.nextInt(Config.maxNumber - Config.minNumber + 1);
    final isCorrect = number % divisor == 0;
    
    return AnimatedNumberBlock(
      number: number,
      isCorrect: isCorrect,
      x: _random.nextDouble() * (Config.playAreaWidth - Config.numberBlockWidth),
      y: Config.playAreaHeight - Config.numberBlockHeight,
      velocityX: Config.minHorizontalVelocity + _random.nextDouble() * (Config.maxHorizontalVelocity - Config.minHorizontalVelocity),
      velocityY: Config.minVerticalVelocity + _random.nextDouble() * (Config.maxVerticalVelocity - Config.minVerticalVelocity),
    );
  }
}