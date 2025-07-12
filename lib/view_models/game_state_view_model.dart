import '../configs/config.dart';

class GameStateViewModel {
  int score = 0;
  int lives = Config.totalLives;
  int level = 1;
  int divisor = Config.divisors[0];

  void increaseScore() {
    score += Config.scorePerCorrectBlock;
  }

  void deductLife() {
    lives--;
  }

  void resetGame() {
    score = 0;
    lives = Config.totalLives;
    level = 1;
    divisor = Config.divisors[0];
  }
}