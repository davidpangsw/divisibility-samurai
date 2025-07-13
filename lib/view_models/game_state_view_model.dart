import '../configs/config.dart';
import '../utils/sound_manager.dart';

class GameStateViewModel {
  int score = 0;
  int lives = Config.totalLives;
  int level = 1;
  int divisor = Config.getDivisorForLevel(1);
  int correctBlocksInCurrentLevel = 0;
  List<String> wrongAnswers = [];

  void increaseScore() {
    score += Config.scorePerCorrectBlock;
    correctBlocksInCurrentLevel++;
    // Play sound only for correct answers
    SoundManager.playSlashSound();
  }

  void deductLife() {
    lives--;
    // Deduct score for wrong answer
    score = (score - Config.scorePerCorrectBlock).clamp(0, double.infinity).toInt();
  }

  void addWrongAnswer(int number) {
    wrongAnswers.add('$number was not divisible by $divisor');
  }

  bool get isGameLost => lives <= 0;
  bool get isLevelCompleted => correctBlocksInCurrentLevel >= Config.getBlocksNeededForLevel(level);
  bool get isGameWon => level >= Config.totalLevels && isLevelCompleted;

  void nextLevel() {
    if (level < Config.totalLevels) {
      int previousLevel = level;
      level++;
      divisor = Config.getDivisorForLevel(level);
      correctBlocksInCurrentLevel = 0;
      
      // Only refill lives when moving to a new tier (Silver or Gold)
      String previousTier = Config.getLevelTier(previousLevel);
      String currentTier = Config.getLevelTier(level);
      if (previousTier != currentTier) {
        lives = Config.totalLives; // Refill lives when entering new tier
      }
    }
  }

  void resetGame() {
    score = 0;
    lives = Config.totalLives;
    level = 1;
    divisor = Config.getDivisorForLevel(1);
    correctBlocksInCurrentLevel = 0;
    wrongAnswers.clear();
  }
  
  // Helper methods for level info
  String get currentLevelTier => Config.getLevelTier(level);
  String get currentLevelDescription => Config.getLevelDescription(level);
  String get nextLevelDescription => level < Config.totalLevels ? Config.getLevelDescription(level + 1) : '';
  int get minNumberForCurrentLevel => Config.getMinNumberForLevel(level);
  int get maxNumberForCurrentLevel => Config.getMaxNumberForLevel(level);
}