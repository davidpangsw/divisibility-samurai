import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/game_view_model.dart';
import '../../configs/config.dart';
import '../../utils/sound_manager.dart';
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
  bool _showingTierTransition = false;

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
                              '⚔️ Divisibility Samurai',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            // Samurai image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/images/samurai/openart-image_oOwjbEGr_1752429681294_raw.jpg',
                                width: 150,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 150,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                                  );
                                },
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
                  if (_showingTierTransition)
                    Container(
                      width: Config.playAreaWidth,
                      height: Config.playAreaHeight,
                      decoration: BoxDecoration(
                        color: Colors.indigo[900]!.withOpacity(0.95),
                        border: Border.all(color: Colors.indigo),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '🔥 Campfire Rest 🔥',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildCampfireRestInfo(gameViewModel),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                                setState(() => _showingTierTransition = false);
                                gameViewModel.proceedToNextTier();
                                // Resume the physics loop in PlayArea
                                final playAreaState = _playAreaKey.currentState;
                                if (playAreaState != null) {
                                  (playAreaState as dynamic).resumeGame();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber[200],
                                foregroundColor: Colors.brown[900],
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              child: _buildCampfireButtonText(gameViewModel),
                            ),
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
    
    // For first level transition, show current level (1)
    // For level/tier completed transitions, show next level
    final comingLevel = gameViewModel.status == GameStatus.firstLevelTransition 
        ? gameViewModel.gameState.level 
        : gameViewModel.gameState.level + 1;
    final comingTier = Config.getLevelTier(comingLevel);
    final comingDivisor = Config.getDivisorForLevel(comingLevel);
    final willRefillLives = false; // Will be determined based on tier changes
    
    String tierIcon;
    switch (comingTier) {
      case 'Study':
        tierIcon = '📚';
        break;
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
          '$tierIcon $comingTier',
          style: const TextStyle(
            color: Colors.yellow,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Divisor:',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: 80,
          height: 60,
          child: BasicNumberBlock(number: comingDivisor, color: Colors.red),
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
    SoundManager.playBgmForTier('campfire');
    
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

  Widget _buildCampfireRestInfo(GameViewModel gameViewModel) {
    final currentTier = Config.getLevelTier(gameViewModel.gameState.level);
    final nextLevel = gameViewModel.gameState.level + 1;
    final nextTier = Config.getLevelTier(nextLevel);
    
    String nextTierEmoji;
    switch (nextTier) {
      case 'Study': nextTierEmoji = '📚'; break;
      case 'Bronze': nextTierEmoji = '🥉'; break;
      case 'Silver': nextTierEmoji = '🥈'; break;
      case 'Gold': nextTierEmoji = '🥇'; break;
      default: nextTierEmoji = '';
    }
    
    String restMessage;
    switch (currentTier) {
      case 'Study':
        restMessage = 'Knowledge acquired! 📖✨\nRest by the warm fire, young scholar.';
        break;
      case 'Bronze':
        restMessage = 'First trials completed! ⚔️\nLet the flames restore your spirit.';
        break;
      case 'Silver':
        restMessage = 'Warrior skills sharpened! 🛡️\nThe fire whispers tales of glory.';
        break;
      default:
        restMessage = 'Journey continues...\nRest and reflect by the campfire.';
    }
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '🏕️',
          style: TextStyle(fontSize: 40),
        ),
        const SizedBox(height: 15),
        Text(
          restMessage,
          style: const TextStyle(
            color: Colors.amber,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15),
        Text(
          'Next journey: $nextTierEmoji $nextTier Tier',
          style: const TextStyle(
            color: Colors.lightBlue,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          '❤️ Lives Restored by the Campfire',
          style: TextStyle(
            color: Colors.lightGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCampfireButtonText(GameViewModel gameViewModel) {
    final nextLevel = gameViewModel.gameState.level + 1;
    final nextTier = Config.getLevelTier(nextLevel);
    
    final campfireTexts = {
      'Bronze': 'Venture Forth, Brave Soul! 🗡️',
      'Silver': 'Answer the Call to Glory! ⚔️',
      'Gold': 'Embrace Your Destiny! 👑',
    };
    
    return Text(campfireTexts[nextTier] ?? 'Continue the Journey! 🌟');
  }
}