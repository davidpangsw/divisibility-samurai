import '../configs/config.dart';
import '../configs/game_level.dart';

class GameStateViewModel {
  int score = 0;
  int lives = Config.totalLives;
  int level = 1;
  int divisor = GameLevel.getLevel(1).divisor;
  int correctBlocksInCurrentLevel = 0;
  int correctBlocksDisappearedInCurrentLevel = 0; // Track correct blocks that disappeared in current level
  List<String> wrongAnswers = [];
  Map<String, List<int>> correctAnswersByLevel = {}; // Track correct answers by level
  Map<String, List<int>> wrongAnswersByLevel = {}; // Track wrong answers by level
  int totalBlocksMissed = 0; // Track total blocks that fell off screen

  void increaseScore(int number, {Function? onPlaySlashSound}) {
    score += Config.scorePerCorrectBlock;
    correctBlocksInCurrentLevel++;
    correctBlocksDisappearedInCurrentLevel++;
    
    // Track correct answer for this level
    final gameLevel = GameLevel.getLevel(level);
    String levelKey = '${gameLevel.tier.name} $divisor';
    correctAnswersByLevel[levelKey] ??= [];
    correctAnswersByLevel[levelKey]!.add(number);
    
    // Play sound only for correct answers
    onPlaySlashSound?.call();
  }

  void deductLife(int number) {
    lives--;
    // Deduct score for wrong answer
    score = (score - Config.scorePerCorrectBlock).clamp(0, double.infinity).toInt();
    
    // Track wrong answer for this level
    final gameLevel = GameLevel.getLevel(level);
    String levelKey = '${gameLevel.tier.name} $divisor';
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
  bool get isLevelCompleted => correctBlocksInCurrentLevel >= GameLevel.getLevel(level).blocksNeeded;
  bool get isGameWon => level >= GameLevel.totalLevels && isLevelCompleted;
  bool get isBlockLimitExceeded => correctBlocksDisappearedInCurrentLevel >= GameLevel.getLevel(level).blockLimit && !isLevelCompleted;
  
  // Check if completing this level means completing a tier
  bool get isTierCompleted {
    if (!isLevelCompleted) return false;
    
    int nextLevel = level + 1;
    if (nextLevel > GameLevel.totalLevels) return false; // Game won, not tier completed
    
    String currentTier = GameLevel.getLevel(level).tier.name;
    String nextTier = GameLevel.getLevel(nextLevel).tier.name;
    return currentTier != nextTier;
  }

  void nextLevel({Function(String)? onPlayBgmForTier}) {
    if (level < GameLevel.totalLevels) {
      int previousLevel = level;
      level++;
      divisor = GameLevel.getLevel(level).divisor;
      correctBlocksInCurrentLevel = 0;
      correctBlocksDisappearedInCurrentLevel = 0; // Reset correct block disappeared count for new level
      
      // Only refill lives when moving to a new tier (Silver or Gold)
      String previousTier = GameLevel.getLevel(previousLevel).tier.name;
      String currentTier = GameLevel.getLevel(level).tier.name;
      if (previousTier != currentTier) {
        lives = Config.totalLives; // Refill lives when entering new tier
        // Change BGM for the new tier
        onPlayBgmForTier?.call(currentTier);
      }
    }
  }

  void resetGame({Function? onResetSound}) {
    score = 0;
    lives = Config.totalLives;
    level = 1;
    divisor = GameLevel.getLevel(1).divisor;
    correctBlocksInCurrentLevel = 0;
    correctBlocksDisappearedInCurrentLevel = 0;
    wrongAnswers.clear();
    correctAnswersByLevel.clear();
    wrongAnswersByLevel.clear();
    totalBlocksMissed = 0;
    // Reset sound manager but don't start BGM until game actually starts
    onResetSound?.call();
  }

  void startGameAudio({Function(String)? onPlayBgmForTier}) {
    // Start BGM when game actually begins
    onPlayBgmForTier?.call('Study');
  }
  
  // Helper methods for level info
  String get currentLevelTier => GameLevel.getLevel(level).tier.name;
  String get currentLevelDescription {
    final gameLevel = GameLevel.getLevel(level);
    return '${gameLevel.tier.name} Level: Find numbers divisible by ${gameLevel.divisor} (${gameLevel.minNumber}-${gameLevel.maxNumber})';
  }
  String get nextLevelDescription {
    if (level >= GameLevel.totalLevels) return '';
    final nextGameLevel = GameLevel.getLevel(level + 1);
    return '${nextGameLevel.tier.name} Level: Find numbers divisible by ${nextGameLevel.divisor} (${nextGameLevel.minNumber}-${nextGameLevel.maxNumber})';
  }
  int get minNumberForCurrentLevel => GameLevel.getLevel(level).minNumber;
  int get maxNumberForCurrentLevel => GameLevel.getLevel(level).maxNumber;
  
  // Block limit helpers
  int get blocksNeededForCurrentLevel => GameLevel.getLevel(level).blocksNeeded;
  int get blockLimitForCurrentLevel => GameLevel.getLevel(level).blockLimit;
  int get remainingCorrectBlocksAllowed => (blockLimitForCurrentLevel - correctBlocksDisappearedInCurrentLevel).clamp(0, blockLimitForCurrentLevel);
  int get remainingCorrectNeeded => (blocksNeededForCurrentLevel - correctBlocksInCurrentLevel).clamp(0, blocksNeededForCurrentLevel);
}