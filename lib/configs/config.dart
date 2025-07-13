class Config {
  // Game mechanics
  static const int minNumber = 10;
  static const int maxNumber = 100;
  static const List<int> divisors = [2, 3, 4, 5, 6];
  static int get totalLevels => divisors.length;
  static const int blocksNeededPerLevel = 3; // Reduced for testing
  static const int totalLives = 5; // Reduced for testing
  static const int maxNumberBlocksInPlayArea = 2;
  static const int scorePerCorrectBlock = 100;
  static const Duration blockGenerationInterval = Duration(milliseconds: 300);
  static const double blockGenerationChance = 0.9;
  static const double correctBlockProbability = 0.5; // Probability of generating a divisible block
  
  // Physics
  static const double gravity = 500.0;
  static const double bounceDamping = 0.8;
  static const double minHorizontalVelocity = -100.0;
  static const double maxHorizontalVelocity = 100.0;
  static const double minVerticalVelocity = -630.0;
  static const double maxVerticalVelocity = -450.0;
  
  // Animation
  static const Duration numberBlockAnimationDuration = Duration(milliseconds: 400);
  static const Duration blockCleanupDelay = numberBlockAnimationDuration;
  
  // Game lifecycle
  static const Duration levelTransitionDelay = Duration(seconds: 2);
  
  // UI dimensions
  static const double playAreaWidth = 400.0;
  static const double playAreaHeight = 400.0;
  static const double numberBlockWidth = 60.0;
  static const double numberBlockHeight = 40.0;
}