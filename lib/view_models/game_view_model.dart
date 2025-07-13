import 'package:flutter/foundation.dart';
import 'game_state_view_model.dart';

enum GameStatus { playing, paused, levelCompleted, gameWon, gameLost }

class GameViewModel extends ChangeNotifier {
  final GameStateViewModel _gameState = GameStateViewModel();
  GameStatus _status = GameStatus.playing;
  GameStatus? _previousStatus;

  GameStateViewModel get gameState => _gameState;
  GameStatus get status => _status;
  bool get isGameActive => _status == GameStatus.playing;
  bool get hasStatusChanged => _status != _previousStatus;

  GameViewModel() {
    _startGame();
  }

  void _startGame() {
    _gameState.resetGame();
    _setStatus(GameStatus.playing);
  }

  void _setStatus(GameStatus newStatus) {
    _previousStatus = _status;
    _status = newStatus;
    notifyListeners();
  }

  void markStatusAsHandled() {
    _previousStatus = _status;
  }

  void onBlockSlashed(bool isCorrect, int number) {
    if (!isGameActive) return;

    if (isCorrect) {
      _gameState.increaseScore();
      _checkLevelCompletion();
    } else {
      _gameState.deductLife();
      _gameState.addWrongAnswer(number);
      _checkGameLost();
    }
    notifyListeners();
  }

  void _checkLevelCompletion() {
    if (_gameState.isLevelCompleted) {
      if (_gameState.isGameWon) {
        _setStatus(GameStatus.gameWon);
      } else {
        _setStatus(GameStatus.levelCompleted);
      }
    }
  }

  void _checkGameLost() {
    if (_gameState.isGameLost) {
      _setStatus(GameStatus.gameLost);
    }
  }

  void proceedToNextLevel() {
    if (_status == GameStatus.levelCompleted) {
      _gameState.nextLevel();
      _setStatus(GameStatus.playing);
    }
  }

  void restartGame() {
    _startGame();
  }

  void stopGame() {
    _setStatus(GameStatus.paused);
  }
}