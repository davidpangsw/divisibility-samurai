import '../configs/config.dart';
import '../utils/sound_manager.dart';

class GameStateViewModel {
  int score = 0;
  int lives = Config.totalLives;
  int level = 1;
  int divisor = Config.getDivisorForLevel(1);
  int correctBlocksInCurrentLevel = 0;
  int correctBlocksDisappearedInCurrentLevel = 0; // Track correct blocks that disappeared in current level
  List<String> wrongAnswers = [];
  Map<String, List<int>> correctAnswersByLevel = {}; // Track correct answers by level
  Map<String, List<int>> wrongAnswersByLevel = {}; // Track wrong answers by level
  int totalBlocksMissed = 0; // Track total blocks that fell off screen

  void increaseScore(int number) {
    score += Config.scorePerCorrectBlock;
    correctBlocksInCurrentLevel++;
    correctBlocksDisappearedInCurrentLevel++;
    
    // Track correct answer for this level
    String levelKey = '${Config.getLevelTier(level)} $divisor';
    correctAnswersByLevel[levelKey] ??= [];
    correctAnswersByLevel[levelKey]!.add(number);
    
    // Play sound only for correct answers
    SoundManager.playSlashSound();
  }

  void deductLife(int number) {
    lives--;
    // Deduct score for wrong answer
    score = (score - Config.scorePerCorrectBlock).clamp(0, double.infinity).toInt();
    
    // Track wrong answer for this level
    String levelKey = '${Config.getLevelTier(level)} $divisor';
    wrongAnswersByLevel[levelKey] ??= [];
    wrongAnswersByLevel[levelKey]!.add(number);
  }

  void incrementCorrectBlockDisappeared() {
    correctBlocksDisappearedInCurrentLevel++;
    totalBlocksMissed++;
  }

  void addWrongAnswer(int number) {
    wrongAnswers.add('$number was not divisible by $divisor');
  }

  bool get isGameLost => lives <= 0 || isBlockLimitExceeded;
  bool get isLevelCompleted => correctBlocksInCurrentLevel >= Config.getBlocksNeededForLevel(level);
  bool get isGameWon => level >= Config.totalLevels && isLevelCompleted;
  bool get isBlockLimitExceeded => correctBlocksDisappearedInCurrentLevel >= Config.getBlockLimitForLevel(level) && !isLevelCompleted;
  
  // Check if completing this level means completing a tier
  bool get isTierCompleted {
    if (!isLevelCompleted) return false;
    
    int nextLevel = level + 1;
    if (nextLevel > Config.totalLevels) return false; // Game won, not tier completed
    
    String currentTier = Config.getLevelTier(level);
    String nextTier = Config.getLevelTier(nextLevel);
    return currentTier != nextTier;
  }

  void nextLevel() {
    if (level < Config.totalLevels) {
      int previousLevel = level;
      level++;
      divisor = Config.getDivisorForLevel(level);
      correctBlocksInCurrentLevel = 0;
      correctBlocksDisappearedInCurrentLevel = 0; // Reset correct block disappeared count for new level
      
      // Only refill lives when moving to a new tier (Silver or Gold)
      String previousTier = Config.getLevelTier(previousLevel);
      String currentTier = Config.getLevelTier(level);
      if (previousTier != currentTier) {
        lives = Config.totalLives; // Refill lives when entering new tier
        // Change BGM for the new tier
        SoundManager.playBgmForTier(currentTier);
      }
    }
  }

  void resetGame() {
    score = 0;
    lives = Config.totalLives;
    level = 1;
    divisor = Config.getDivisorForLevel(1);
    correctBlocksInCurrentLevel = 0;
    correctBlocksDisappearedInCurrentLevel = 0;
    wrongAnswers.clear();
    correctAnswersByLevel.clear();
    wrongAnswersByLevel.clear();
    totalBlocksMissed = 0;
    // Reset sound manager but don't start BGM until game actually starts
    SoundManager.reset();
  }

  void startGameAudio() {
    // Start BGM when game actually begins
    SoundManager.playBgmForTier('Study');
  }
  
  // Helper methods for level info
  String get currentLevelTier => Config.getLevelTier(level);
  String get currentLevelDescription => Config.getLevelDescription(level);
  String get nextLevelDescription => level < Config.totalLevels ? Config.getLevelDescription(level + 1) : '';
  int get minNumberForCurrentLevel => Config.getMinNumberForLevel(level);
  int get maxNumberForCurrentLevel => Config.getMaxNumberForLevel(level);
  
  // Block limit helpers
  int get blocksNeededForCurrentLevel => Config.getBlocksNeededForLevel(level);
  int get blockLimitForCurrentLevel => Config.getBlockLimitForLevel(level);
  int get remainingCorrectBlocksAllowed => (blockLimitForCurrentLevel - correctBlocksDisappearedInCurrentLevel).clamp(0, blockLimitForCurrentLevel);
  int get remainingCorrectNeeded => (blocksNeededForCurrentLevel - correctBlocksInCurrentLevel).clamp(0, blocksNeededForCurrentLevel);
}