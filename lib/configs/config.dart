class Config {
  // Game mechanics
  static const int minNumber = 10;
  static const int maxNumber = 100;
  static const List<int> divisors = [2, 3, 4, 5, 6];
  static int get totalLevels => divisors.length;
  static const int blocksNeededPerLevel = 10;
  static const int totalLives = 10;
  static const int maxNumberBlocksInPlayArea = 2;
  static const int scorePerCorrectBlock = 100;
  static const int blockGenerationIntervalMs = 300;
  static const double blockGenerationChance = 0.9;
  
  // Physics
  static const double gravity = 500.0;
  static const double bounceDamping = 0.8;
  static const double minHorizontalVelocity = -100.0;
  static const double maxHorizontalVelocity = 100.0;
  static const double minVerticalVelocity = -630.0;
  static const double maxVerticalVelocity = -450.0;
  
  // Animation
  static const int numberBlockAnimationDurationMs = 400;
  static const int blockCleanupDelayMs = numberBlockAnimationDurationMs;
  
  // UI dimensions
  static const double playAreaWidth = 400.0;
  static const double playAreaHeight = 400.0;
  static const double numberBlockWidth = 60.0;
  static const double numberBlockHeight = 40.0;
}