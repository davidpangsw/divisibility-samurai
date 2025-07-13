import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/game_view_model.dart';
import '../../configs/config.dart';
import '../game_result_dialog.dart';
import 'stats_bar.dart';
import 'play_area.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({super.key});

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  final GlobalKey<State<PlayArea>> _playAreaKey = GlobalKey();
  bool _showingLevelTransition = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameViewModel(),
      child: Consumer<GameViewModel>(
        builder: (context, gameViewModel, child) {
          // Handle status changes
          if (gameViewModel.hasStatusChanged) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _handleStatusChange(gameViewModel);
            });
          }
          
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StatsBar(
                score: gameViewModel.gameState.score,
                level: gameViewModel.gameState.level,
                lives: gameViewModel.gameState.lives,
                divisor: gameViewModel.gameState.divisor,
              ),
              Stack(
                children: [
                  PlayArea(key: _playAreaKey),
                  if (_showingLevelTransition)
                    Container(
                      width: Config.playAreaWidth,
                      height: Config.playAreaHeight,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Level Complete!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Preparing next level...',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 20),
                            CircularProgressIndicator(color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void _handleGameEnd(GameViewModel gameViewModel, bool isWin) {
    // Stop all game activity immediately
    final playAreaState = _playAreaKey.currentState;
    if (playAreaState != null) {
      (playAreaState as dynamic).stopAllAnimationsAndClearBlocks();
    }
    
    // Show result dialog
    _showGameResultDialog(gameViewModel, isWin: isWin);
  }

  void _handleStatusChange(GameViewModel gameViewModel) {
    switch (gameViewModel.status) {
      case GameStatus.gameLost:
        _handleGameEnd(gameViewModel, false);
        break;
      case GameStatus.gameWon:
        _handleGameEnd(gameViewModel, true);
        break;
      case GameStatus.levelCompleted:
        _handleLevelCompleted(gameViewModel);
        break;
      default:
        break;
    }
    gameViewModel.markStatusAsHandled();
  }

  void _handleLevelCompleted(GameViewModel gameViewModel) {
    // Stop all game activity for level transition
    final playAreaState = _playAreaKey.currentState;
    if (playAreaState != null) {
      (playAreaState as dynamic).stopAllAnimationsAndClearBlocks();
    }
    
    // Show transition overlay and proceed to next level
    _showLevelTransition(() {
      gameViewModel.proceedToNextLevel();
      if (playAreaState != null) {
        (playAreaState as dynamic).resumeGame();
      }
    });
  }

  void _showLevelTransition(VoidCallback onComplete) {
    setState(() => _showingLevelTransition = true);
    
    Future.delayed(Config.levelTransitionDelay, () {
      if (mounted) {
        setState(() => _showingLevelTransition = false);
        onComplete();
      }
    });
  }

  void _showGameResultDialog(GameViewModel gameViewModel, {required bool isWin}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => GameResultDialog(
        isWin: isWin,
        finalScore: gameViewModel.gameState.score,
        finalLevel: gameViewModel.gameState.level,
        wrongAnswers: gameViewModel.gameState.wrongAnswers,
        onRestart: () {
          Navigator.of(context).pop();
          gameViewModel.restartGame();
          // Resume the physics loop in PlayArea
          final playAreaState = _playAreaKey.currentState;
          if (playAreaState != null) {
            (playAreaState as dynamic).resumeGame();
          }
        },
      ),
    );
  }
}