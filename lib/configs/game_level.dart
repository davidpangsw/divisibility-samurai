import 'dart:math';
import 'tier.dart';

class GameLevel {
  final Tier tier;
  final int divisor;
  final int minNumber;
  final int maxNumber;
  final double gravity;
  final int blocksNeeded;
  final int blockLimit;
  final double minVerticalVelocity;
  final double maxVerticalVelocity;

  const GameLevel._({
    required this.tier,
    required this.divisor,
    required this.minNumber,
    required this.maxNumber,
    required this.gravity,
    required this.blocksNeeded,
    required this.blockLimit,
    required this.minVerticalVelocity,
    required this.maxVerticalVelocity,
  });

  String toDisplayString() => "${tier.emoji} $divisor";

  static const double _playAreaHeight = 480.0;
  static const List<int> _divisors = [2, 3, 4, 5, 6, 8, 9, 10, 12];

  static int _getStudyMaxForDivisor(int divisor) {
    switch (divisor) {
      case 2: return 20;
      case 3: return 30;
      case 4: return 40;
      case 5: return 50;
      case 6: return 60;
      case 8: return 80;
      case 9: return 90;
      case 10: return 100;
      case 12: return 100;
      default: return 20;
    }
  }

  static double _calculateMinVerticalVelocity(double gravity) {
    double targetHeight = _playAreaHeight * 0.5;
    return -sqrt(2 * gravity * targetHeight);
  }

  static double _calculateMaxVerticalVelocity(double gravity) {
    double targetHeight = _playAreaHeight * 0.8;
    return -sqrt(2 * gravity * targetHeight);
  }

  static final List<GameLevel> levels = [
    // Study Tier (9 levels)
    ...List.generate(9, (index) {
      final divisor = _divisors[index];
      const gravity = 250.0;
      return GameLevel._(
        tier: Tier.study,
        divisor: divisor,
        minNumber: 1,
        maxNumber: _getStudyMaxForDivisor(divisor),
        gravity: gravity,
        blocksNeeded: 5,
        blockLimit: 30,
        minVerticalVelocity: _calculateMinVerticalVelocity(gravity),
        maxVerticalVelocity: _calculateMaxVerticalVelocity(gravity),
      );
    }),

    // Bronze Tier (9 levels)
    ...List.generate(9, (index) {
      final divisor = _divisors[index];
      const gravity = 200.0;
      return GameLevel._(
        tier: Tier.bronze,
        divisor: divisor,
        minNumber: 10,
        maxNumber: 99,
        gravity: gravity,
        blocksNeeded: 5,
        blockLimit: 30,
        minVerticalVelocity: _calculateMinVerticalVelocity(gravity),
        maxVerticalVelocity: _calculateMaxVerticalVelocity(gravity),
      );
    }),

    // Silver Tier (9 levels)
    ...List.generate(9, (index) {
      final divisor = _divisors[index];
      const gravity = 150.0;
      return GameLevel._(
        tier: Tier.silver,
        divisor: divisor,
        minNumber: 100,
        maxNumber: 999,
        gravity: gravity,
        blocksNeeded: 5,
        blockLimit: 30,
        minVerticalVelocity: _calculateMinVerticalVelocity(gravity),
        maxVerticalVelocity: _calculateMaxVerticalVelocity(gravity),
      );
    }),

    // Gold Tier (9 levels)
    ...List.generate(9, (index) {
      final divisor = _divisors[index];
      const gravity = 100.0;
      return GameLevel._(
        tier: Tier.gold,
        divisor: divisor,
        minNumber: 1000,
        maxNumber: 9999,
        gravity: gravity,
        blocksNeeded: 5,
        blockLimit: 30,
        minVerticalVelocity: _calculateMinVerticalVelocity(gravity),
        maxVerticalVelocity: _calculateMaxVerticalVelocity(gravity),
      );
    }),
  ];

  static int get totalLevels => levels.length;

  static GameLevel getLevel(int levelNumber) {
    if (levelNumber < 1 || levelNumber > levels.length) {
      throw ArgumentError('Level $levelNumber is out of range (1-${levels.length})');
    }
    return levels[levelNumber - 1];
  }
}