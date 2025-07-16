import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/game_view_model.dart';
import '../../configs/config.dart';
import '../../configs/game_level.dart';
import '../../utils/asset_manager.dart';
import '../game_result_dialog.dart';
import 'stats_bar.dart';
import 'play_area.dart';
import 'game_overlays.dart';

class GameWidget extends StatefulWidget {
  final GameViewModel gameViewModel;
  
  const GameWidget({
    super.key,
    required this.gameViewModel,
  });

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  final GlobalKey<State<PlayArea>> _playAreaKey = GlobalKey();
  bool _showingLevelTransition = false;
  bool _showingTierTransition = false;


  @override
  Widget build(BuildContext context) {
    return Consumer<GameViewModel>(
      builder: (context, gameViewModel, child) {
        // Handle status changes
        if (gameViewModel.hasStatusChanged) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _handleStatusChange(gameViewModel);
          });
        }
        
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
            StatsBar(
              score: gameViewModel.gameState.score,
              level: gameViewModel.gameState.level,
              lives: gameViewModel.gameState.lives,
              divisor: gameViewModel.gameState.divisor,
              remainingCorrectBlocksAllowed: gameViewModel.gameState.remainingCorrectBlocksAllowed,
              remainingCorrectNeeded: gameViewModel.gameState.remainingCorrectNeeded,
              ),
              Stack(
                children: [
                  // Background image layer
                  SizedBox(
                    width: Config.playAreaWidth,
                    height: Config.playAreaHeight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.asset(
                        AssetManager.getBackgroundImagePath(GameLevel.getLevel(gameViewModel.gameState.level).tier),
                        width: Config.playAreaWidth,
                        height: Config.playAreaHeight,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: Config.playAreaWidth,
                            height: Config.playAreaHeight,
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Very high transparency watermark overlay
                  Container(
                    width: Config.playAreaWidth,
                    height: Config.playAreaHeight,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  PlayArea(key: _playAreaKey),
                  if (gameViewModel.status == GameStatus.notStarted)
                    StartGameOverlay(
                      onStartGame: () => gameViewModel.startGame(),
                    ),
                  if (_showingLevelTransition)
                    LevelTransitionOverlay(
                      gameViewModel: gameViewModel,
                    ),
                  if (_showingTierTransition)
                    TierTransitionOverlay(
                      gameViewModel: gameViewModel,
                      onProceed: () {
                        setState(() => _showingTierTransition = false);
                        gameViewModel.proceedToNextTier();
                        // Resume the physics loop in PlayArea
                        final playAreaState = _playAreaKey.currentState;
                        if (playAreaState != null) {
                          (playAreaState as dynamic).resumeGame();
                        }
                      },
                    ),
                ],
              ),
            ],
          ),
        );
      },
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
      case GameStatus.firstLevelTransition:
        _handleFirstLevelTransition(gameViewModel);
        break;
      case GameStatus.levelCompleted:
        _handleLevelCompleted(gameViewModel);
        break;
      case GameStatus.tierCompleted:
        _handleTierCompleted(gameViewModel);
        break;
      default:
        break;
    }
    gameViewModel.markStatusAsHandled();
  }

  void _handleFirstLevelTransition(GameViewModel gameViewModel) {
    // Stop all game activity for first level transition
    final playAreaState = _playAreaKey.currentState;
    if (playAreaState != null) {
      (playAreaState as dynamic).stopAllAnimationsAndClearBlocks();
    }
    
    // Show transition overlay and proceed to playing state
    _showLevelTransition(() {
      gameViewModel.proceedFromFirstLevelTransition();
      if (playAreaState != null) {
        (playAreaState as dynamic).resumeGame();
      }
    });
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

  void _handleTierCompleted(GameViewModel gameViewModel) {
    // Stop all game activity for tier transition
    final playAreaState = _playAreaKey.currentState;
    if (playAreaState != null) {
      (playAreaState as dynamic).stopAllAnimationsAndClearBlocks();
    }
    
    // Start campfire BGM for the rest period
    widget.gameViewModel.playBgmForTier('campfire');
    
    // Show tier transition overlay and wait for user action
    setState(() => _showingTierTransition = true);
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
        correctAnswersByLevel: gameViewModel.gameState.correctAnswersByLevel,
        wrongAnswersByLevel: gameViewModel.gameState.wrongAnswersByLevel,
        totalBlocksMissed: gameViewModel.gameState.totalBlocksMissed,
        onRestart: () {
          Navigator.of(context).pop();
          gameViewModel.resetToStartScreen();
          // Clear any blocks and stop physics
          final playAreaState = _playAreaKey.currentState;
          if (playAreaState != null) {
            (playAreaState as dynamic).stopAllAnimationsAndClearBlocks();
          }
        },
      ),
    );
  }

}