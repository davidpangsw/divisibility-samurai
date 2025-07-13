import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/game_view_model.dart';
import '../../configs/config.dart';
import '../game_result_dialog.dart';
import '../number_blocks/basic_number_block.dart';
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
                  PlayArea(key: _playAreaKey),
                  if (gameViewModel.status == GameStatus.notStarted)
                    Container(
                      width: Config.playAreaWidth,
                      height: Config.playAreaHeight,
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '🎮 Math Block Slash',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'Find numbers divisible by the given divisor!',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () => gameViewModel.startGame(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                textStyle: const TextStyle(fontSize: 18),
                              ),
                              child: const Text('Start Game'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (_showingLevelTransition)
                    Container(
                      width: Config.playAreaWidth,
                      height: Config.playAreaHeight,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '✅ Level Complete!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            _buildNextLevelInfo(gameViewModel),
                            const SizedBox(height: 20),
                            const CircularProgressIndicator(color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNextLevelInfo(GameViewModel gameViewModel) {
    if (gameViewModel.gameState.level >= Config.totalLevels) {
      return const Text(
        '🎉 Game Complete!',
        style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold),
      );
    }
    
    final nextLevel = gameViewModel.gameState.level + 1;
    final nextTier = gameViewModel.gameState.currentLevelTier;
    final nextLevelTier = Config.getLevelTier(nextLevel);
    final nextDivisor = Config.getDivisorForLevel(nextLevel);
    final willRefillLives = nextTier != nextLevelTier;
    
    String tierIcon;
    switch (nextLevelTier) {
      case 'Bronze':
        tierIcon = '🥉';
        break;
      case 'Silver':
        tierIcon = '🥈';
        break;
      case 'Gold':
        tierIcon = '🥇';
        break;
      default:
        tierIcon = '';
    }
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$tierIcon$nextDivisor',
          style: const TextStyle(
            color: Colors.yellow,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 80,
          height: 60,
          child: BasicNumberBlock(number: nextDivisor, color: Colors.red),
        ),
        if (willRefillLives) ...[
          const SizedBox(height: 10),
          const Text(
            '❤️ Lives Refilled',
            style: TextStyle(
              color: Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
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
        correctAnswersByLevel: gameViewModel.gameState.correctAnswersByLevel,
        wrongAnswersByLevel: gameViewModel.gameState.wrongAnswersByLevel,
        totalBlocksMissed: gameViewModel.gameState.totalBlocksMissed,
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