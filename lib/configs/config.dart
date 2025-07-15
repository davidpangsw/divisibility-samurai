
class Config {
  
  
  
  static const int totalLives = 5;
  static const int maxNumberBlocksInPlayArea = 2;
  static const int scorePerCorrectBlock = 100;
  static const Duration blockGenerationInterval = Duration(milliseconds: 300);
  static const double blockGenerationChance = 0.9;
  static const double correctBlockProbability = 0.5; // Probability of generating a divisible block
  
  static const double bounceDamping = 0.8;
  static const double minHorizontalVelocity = -100.0; // Adjusted for mobile width (360px)
  static const double maxHorizontalVelocity = 100.0;
  
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
  
  
}