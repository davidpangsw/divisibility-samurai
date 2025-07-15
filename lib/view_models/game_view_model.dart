import 'package:flutter/foundation.dart';
import 'game_state_view_model.dart';
import '../utils/sound_manager.dart';

enum GameStatus { notStarted, firstLevelTransition, playing, paused, levelCompleted, tierCompleted, gameWon, gameLost }

class GameViewModel extends ChangeNotifier {
  final GameStateViewModel _gameState = GameStateViewModel();
  GameStatus _status = GameStatus.notStarted;
  GameStatus? _previousStatus;

  GameStateViewModel get gameState => _gameState;
  GameStatus get status => _status;
  bool get isGameActive => _status == GameStatus.playing;
  bool get hasStatusChanged => _status != _previousStatus;

  GameViewModel() {
    // Don't auto-start game, wait for user to click start button
    _gameState.resetGame();
  }

  void _startGame() {
    _gameState.resetGame();
    _gameState.startGameAudio();
    _setStatus(GameStatus.firstLevelTransition);
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
      _gameState.increaseScore(number);
      _checkLevelCompletion();
    } else {
      _gameState.deductLife(number);
      _gameState.addWrongAnswer(number);
      _checkGameLost();
    }
    notifyListeners();
  }

  void onCorrectBlockDisappeared() {
    if (!isGameActive) return;
    
    _gameState.incrementCorrectBlockDisappeared();
    _checkGameLost();
    notifyListeners();
  }

  void _checkLevelCompletion() {
    if (_gameState.isLevelCompleted) {
      if (_gameState.isGameWon) {
        _setStatus(GameStatus.gameWon);
        // Stop BGM when game is won
        SoundManager.stopBgm();
      } else if (_gameState.isTierCompleted) {
        _setStatus(GameStatus.tierCompleted);
      } else {
        _setStatus(GameStatus.levelCompleted);
      }
    }
  }

  void _checkGameLost() {
    if (_gameState.isGameLost) {
      _setStatus(GameStatus.gameLost);
      // Stop BGM when game is lost
      SoundManager.stopBgm();
    }
  }

  void proceedToNextLevel() {
    if (_status == GameStatus.levelCompleted) {
      _gameState.nextLevel();
      _setStatus(GameStatus.playing);
    }
  }

  void proceedToNextTier() {
    if (_status == GameStatus.tierCompleted) {
      _gameState.nextLevel();
      _setStatus(GameStatus.playing);
    }
  }

  void proceedFromFirstLevelTransition() {
    if (_status == GameStatus.firstLevelTransition) {
      _setStatus(GameStatus.playing);
    }
  }

  void startGame() {
    _startGame();
  }

  void restartGame() {
    _startGame();
  }

  void stopGame() {
    _setStatus(GameStatus.paused);
  }
}