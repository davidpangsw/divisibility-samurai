import 'dart:math';
import '../../configs/config.dart';
import '../number_blocks/animated_number_block_model.dart';

class BlockFactory {
  static final Random _random = Random();

  static AnimatedNumberBlock createBlock(int divisor) {
    // First, decide if this block should be correct (divisible) or not
    final shouldBeCorrect = _random.nextDouble() < Config.correctBlockProbability;
    
    int number;
    if (shouldBeCorrect) {
      // Generate a number that IS divisible by the divisor
      number = _generateDivisibleNumber(divisor);
    } else {
      // Generate a number that is NOT divisible by the divisor
      number = _generateNonDivisibleNumber(divisor);
    }
    
    return AnimatedNumberBlock(
      number: number,
      isCorrect: shouldBeCorrect,
      x: _random.nextDouble() * (Config.playAreaWidth - Config.numberBlockWidth),
      y: Config.playAreaHeight - Config.numberBlockHeight,
      velocityX: Config.minHorizontalVelocity + _random.nextDouble() * (Config.maxHorizontalVelocity - Config.minHorizontalVelocity),
      velocityY: Config.minVerticalVelocity + _random.nextDouble() * (Config.maxVerticalVelocity - Config.minVerticalVelocity),
    );
  }

  /// Generates a number that IS divisible by the given divisor
  static int _generateDivisibleNumber(int divisor) {
    // Calculate how many multiples of divisor are in our range
    final minMultiple = (Config.minNumber / divisor).ceil();
    final maxMultiple = (Config.maxNumber / divisor).floor();
    
    // If no multiples exist in range, fallback to minimum multiple
    if (minMultiple > maxMultiple) {
      return divisor * minMultiple;
    }
    
    // Pick a random multiple and multiply by divisor
    final randomMultiple = minMultiple + _random.nextInt(maxMultiple - minMultiple + 1);
    return randomMultiple * divisor;
  }

  /// Generates a number that is NOT divisible by the given divisor
  static int _generateNonDivisibleNumber(int divisor) {
    int number;
    int attempts = 0;
    const maxAttempts = 100; // Prevent infinite loops
    
    do {
      number = Config.minNumber + _random.nextInt(Config.maxNumber - Config.minNumber + 1);
      attempts++;
    } while (number % divisor == 0 && attempts < maxAttempts);
    
    // If we couldn't find a non-divisible number, modify the last one slightly
    if (number % divisor == 0) {
      // Add 1 if it doesn't exceed max, otherwise subtract 1
      if (number + 1 <= Config.maxNumber) {
        number += 1;
      } else {
        number -= 1;
      }
    }
    
    return number;
  }
}