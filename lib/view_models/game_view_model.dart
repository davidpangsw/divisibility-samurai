import 'package:flutter/foundation.dart';
import 'game_state_view_model.dart';

class GameViewModel extends ChangeNotifier {
  final GameStateViewModel _gameState = GameStateViewModel();

  GameStateViewModel get gameState => _gameState;

  GameViewModel() {
    _startGame();
  }

  void _startGame() {
    _gameState.resetGame();
    notifyListeners();
  }

  void onBlockSlashed(bool isCorrect) {
    if (isCorrect) {
      _gameState.increaseScore();
    } else {
      _gameState.deductLife();
    }
    notifyListeners();
  }
}