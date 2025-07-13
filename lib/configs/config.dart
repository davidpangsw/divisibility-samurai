import 'dart:math';

class Config {
  // Game mechanics
  static const List<int> divisors = [2, 3, 4, 5, 6, 8, 9, 10, 12];
  
  // Level tiers
  static const int studyLevels = 9; // All divisors with custom ranges
  static const int bronzeLevels = 9; // All divisors with 2-digit numbers
  static const int silverLevels = 9; // All divisors with 3-digit numbers  
  static const int goldLevels = 9; // All divisors with 4-digit numbers
  static int get totalLevels => studyLevels + bronzeLevels + silverLevels + goldLevels;
  
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
      case 'Study': return 5;
      case 'Bronze': return 5;
      case 'Silver': return 5;
      case 'Gold': return 5;
      default: return 5;
    }
  }
  
  // Block limit system - tracks correct blocks that disappear
  static int getBlockLimitForLevel(int level) {
    String tier = getLevelTier(level);
    switch (tier) {
      case 'Study': return 30; // 5 correct before 30 correct blocks disappear
      case 'Bronze': return 30; // 5 correct before 30 correct blocks disappear
      case 'Silver': return 30; // 3 correct before 30 correct blocks disappear  
      case 'Gold': return 30;   // 2 correct before 30 correct blocks disappear
      default: return 30;
    }
  }
  static const int totalLives = 5;
  static const int maxNumberBlocksInPlayArea = 2;
  static const int scorePerCorrectBlock = 100;
  static const Duration blockGenerationInterval = Duration(milliseconds: 300);
  static const double blockGenerationChance = 0.9;
  static const double correctBlockProbability = 0.5; // Probability of generating a divisible block
  
  // Physics - Mobile optimized with tier-based difficulty
  static double getGravityForLevel(int level) {
    String tier = getLevelTier(level);
    switch (tier) {
      case 'Study': return 250.0;  // Easiest tier for learning
      case 'Bronze': return 200.0; // Moderate difficulty
      case 'Silver': return 150.0; // Easier than Bronze
      case 'Gold': return 100.0;   // Hardest tier
      default: return 250.0;
    }
  }
  static const double bounceDamping = 0.8;
  static const double minHorizontalVelocity = -100.0; // Adjusted for mobile width (360px)
  static const double maxHorizontalVelocity = 100.0;
  // Tier-based vertical velocities to maintain consistent 50-80% height reach
  static double getMinVerticalVelocityForLevel(int level) {
    double gravity = getGravityForLevel(level);
    double targetHeight = playAreaHeight * 0.5; // 50% height
    return -sqrt(2 * gravity * targetHeight); // v = √(2gh)
  }
  
  static double getMaxVerticalVelocityForLevel(int level) {
    double gravity = getGravityForLevel(level);
    double targetHeight = playAreaHeight * 0.8; // 80% height
    return -sqrt(2 * gravity * targetHeight); // v = √(2gh)
  }
  
  // Animation
  static const Duration numberBlockAnimationDuration = Duration(milliseconds: 400);
  static const Duration blockCleanupDelay = numberBlockAnimationDuration;
  
  // Sound files - hardcoded but organized
  static const List<String> slashSoundPaths = [
    'sounds/effects/slash/sword-sound-2-36274.mp3',
  ];
  
  static const List<String> studyBgmPaths = [
    'sounds/music/study-bgm/sedative-110241.mp3',
    'sounds/music/study-bgm/jazz-lounge-elevator-music-332339.mp3',
  ];
  
  static const List<String> bronzeBgmPaths = [
    'sounds/music/bronze-bgm/adventure-cinematic-music-faith-journey-324896.mp3',
  ];
  
  static const List<String> silverBgmPaths = [
    'sounds/music/silver-bgm/battle-fight-music-dynamic-warrior-background-intro-theme-272176.mp3',
  ];
  
  static const List<String> goldBgmPaths = [
    'sounds/music/gold-bgm/battle-background-music-309756.mp3',
  ];
  
  static const List<String> campfireBgmPaths = [
    'sounds/music/campfire-bgm/campfire-crackling-fireplace-sound-119594.mp3',
  ];
  
  // Game lifecycle
  static const Duration levelTransitionDelay = Duration(seconds: 2);
  
  // UI dimensions - Mobile optimized
  static const double playAreaWidth = 360.0; // Mobile-friendly width
  static const double playAreaHeight = 480.0; // Mobile-friendly height
  static const double numberBlockWidth = 60.0;
  static const double numberBlockHeight = 40.0;
  
  // Helper methods for level management
  static String getLevelTier(int level) {
    if (level <= studyLevels) return 'Study';
    if (level <= studyLevels + bronzeLevels) return 'Bronze';
    if (level <= studyLevels + bronzeLevels + silverLevels) return 'Silver';
    return 'Gold';
  }
  
  static int getDivisorForLevel(int level) {
    int divisorIndex = (level - 1) % divisors.length;
    return divisors[divisorIndex];
  }
  
  // Study tier specific ranges based on divisor
  static int getStudyMinForDivisor(int divisor) {
    return 1; // All Study levels start from 1
  }
  
  static int getStudyMaxForDivisor(int divisor) {
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

  static int getMinNumberForLevel(int level) {
    String tier = getLevelTier(level);
    if (tier == 'Study') {
      int divisor = getDivisorForLevel(level);
      return getStudyMinForDivisor(divisor);
    }
    if (level <= studyLevels + bronzeLevels) return bronzeMinNumber;
    if (level <= studyLevels + bronzeLevels + silverLevels) return silverMinNumber;
    return goldMinNumber;
  }
  
  static int getMaxNumberForLevel(int level) {
    String tier = getLevelTier(level);
    if (tier == 'Study') {
      int divisor = getDivisorForLevel(level);
      return getStudyMaxForDivisor(divisor);
    }
    if (level <= studyLevels + bronzeLevels) return bronzeMaxNumber;
    if (level <= studyLevels + bronzeLevels + silverLevels) return silverMaxNumber;
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