class Config {
  // Game mechanics
  static const List<int> divisors = [2, 3, 4, 5, 6, 8, 9, 10, 12];
  
  // Level tiers
  static const int bronzeLevels = 9; // All divisors with 2-digit numbers
  static const int silverLevels = 9; // All divisors with 3-digit numbers  
  static const int goldLevels = 9; // All divisors with 4-digit numbers
  static int get totalLevels => bronzeLevels + silverLevels + goldLevels;
  
  // Number ranges for each tier
  static const int bronzeMinNumber = 10;
  static const int bronzeMaxNumber = 99;
  static const int silverMinNumber = 100;
  static const int silverMaxNumber = 999;
  static const int goldMinNumber = 1000;
  static const int goldMaxNumber = 9999;
  
  // Tier-based difficulty progression
  static int getBlocksNeededForLevel(int level) {
    String tier = getLevelTier(level);
    switch (tier) {
      case 'Bronze': return 5;
      case 'Silver': return 4;
      case 'Gold': return 3;
      default: return 3;
    }
  }
  static const int totalLives = 5;
  static const int maxNumberBlocksInPlayArea = 2;
  static const int scorePerCorrectBlock = 100;
  static const Duration blockGenerationInterval = Duration(milliseconds: 300);
  static const double blockGenerationChance = 0.9;
  static const double correctBlockProbability = 0.5; // Probability of generating a divisible block
  
  // Physics - Mobile optimized
  static const double gravity = 500.0;
  static const double bounceDamping = 0.8;
  static const double minHorizontalVelocity = -100.0; // Adjusted for mobile width (360px)
  static const double maxHorizontalVelocity = 100.0;
  static const double minVerticalVelocity = -450.0; // Reaches ~40% height (192px)
  static const double maxVerticalVelocity = -630.0; // Reaches ~80% height (384px)
  
  // Animation
  static const Duration numberBlockAnimationDuration = Duration(milliseconds: 400);
  static const Duration blockCleanupDelay = numberBlockAnimationDuration;
  
  // Sound effects
  static const String slashSoundPath = 'sounds/sword-sound-2-36274.mp3';
  
  // Game lifecycle
  static const Duration levelTransitionDelay = Duration(seconds: 2);
  
  // UI dimensions - Mobile optimized
  static const double playAreaWidth = 360.0; // Mobile-friendly width
  static const double playAreaHeight = 480.0; // Mobile-friendly height
  static const double numberBlockWidth = 60.0;
  static const double numberBlockHeight = 40.0;
  
  // Helper methods for level management
  static String getLevelTier(int level) {
    if (level <= bronzeLevels) return 'Bronze';
    if (level <= bronzeLevels + silverLevels) return 'Silver';
    return 'Gold';
  }
  
  static int getDivisorForLevel(int level) {
    int divisorIndex = (level - 1) % divisors.length;
    return divisors[divisorIndex];
  }
  
  static int getMinNumberForLevel(int level) {
    if (level <= bronzeLevels) return bronzeMinNumber;
    if (level <= bronzeLevels + silverLevels) return silverMinNumber;
    return goldMinNumber;
  }
  
  static int getMaxNumberForLevel(int level) {
    if (level <= bronzeLevels) return bronzeMaxNumber;
    if (level <= bronzeLevels + silverLevels) return silverMaxNumber;
    return goldMaxNumber;
  }
  
  static String getLevelDescription(int level) {
    String tier = getLevelTier(level);
    int divisor = getDivisorForLevel(level);
    int minNum = getMinNumberForLevel(level);
    int maxNum = getMaxNumberForLevel(level);
    return '$tier Level: Find numbers divisible by $divisor ($minNum-$maxNum)';
  }
}