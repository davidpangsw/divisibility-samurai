import '../configs/config.dart';

class GameStateViewModel {
  int score = 0;
  int lives = Config.totalLives;
  int level = 1;
  int divisor = Config.divisors[0];
  int correctBlocksInCurrentLevel = 0;
  List<String> wrongAnswers = [];

  void increaseScore() {
    score += Config.scorePerCorrectBlock;
    correctBlocksInCurrentLevel++;
  }

  void deductLife() {
    lives--;
  }

  void addWrongAnswer(int number) {
    wrongAnswers.add('$number was not divisible by $divisor');
  }

  bool get isGameLost => lives <= 0;
  bool get isLevelCompleted => correctBlocksInCurrentLevel >= Config.blocksNeededPerLevel;
  bool get isGameWon => level >= Config.totalLevels && isLevelCompleted;

  void nextLevel() {
    if (level < Config.totalLevels) {
      level++;
      divisor = Config.divisors[level - 1];
      correctBlocksInCurrentLevel = 0;
    }
  }

  void resetGame() {
    score = 0;
    lives = Config.totalLives;
    level = 1;
    divisor = Config.divisors[0];
    correctBlocksInCurrentLevel = 0;
    wrongAnswers.clear();
  }
}