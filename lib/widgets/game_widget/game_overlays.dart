import 'package:flutter/material.dart';
import '../../configs/config.dart';
import '../../configs/game_level.dart';
import '../../configs/tier.dart';
import '../../utils/asset_manager.dart';
import '../../view_models/game_view_model.dart';
import '../number_blocks/basic_number_block.dart';

/// Start screen overlay when game is not started
class StartGameOverlay extends StatelessWidget {
  final VoidCallback onStartGame;
  
  const StartGameOverlay({
    super.key,
    required this.onStartGame,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                AssetManager.samuraiImagePath,
                width: 200,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
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
              onPressed: onStartGame,
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
    );
  }
}

/// Level transition overlay
class LevelTransitionOverlay extends StatelessWidget {
  final GameViewModel gameViewModel;
  
  const LevelTransitionOverlay({
    super.key,
    required this.gameViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            _buildNextLevelInfo(),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildNextLevelInfo() {
    if (gameViewModel.gameState.level >= GameLevel.totalLevels) {
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
    final comingGameLevel = GameLevel.getLevel(comingLevel);
    final comingTier = comingGameLevel.tier;
    final comingDivisor = comingGameLevel.divisor;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${comingTier.emoji} ${comingTier.name}',
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
      ],
    );
  }
}

/// Tier transition (campfire) overlay
class TierTransitionOverlay extends StatelessWidget {
  final GameViewModel gameViewModel;
  final VoidCallback onProceed;
  
  const TierTransitionOverlay({
    super.key,
    required this.gameViewModel,
    required this.onProceed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Config.playAreaWidth,
      height: Config.playAreaHeight,
      decoration: BoxDecoration(
        color: Colors.indigo[900]!.withValues(alpha: 0.95),
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
            _buildCampfireRestInfo(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: onProceed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[200],
                foregroundColor: Colors.brown[900],
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: _buildCampfireButtonText(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampfireRestInfo() {
    final currentTier = GameLevel.getLevel(gameViewModel.gameState.level).tier;
    final nextLevel = gameViewModel.gameState.level + 1;
    final nextTier = GameLevel.getLevel(nextLevel).tier;
    
    String restMessage;
    switch (currentTier) {
      case Tier.study:
        restMessage = 'Knowledge acquired! 📖✨\nRest by the warm fire, young scholar.';
        break;
      case Tier.bronze:
        restMessage = 'First trials completed! ⚔️\nLet the flames restore your spirit.';
        break;
      case Tier.silver:
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
          'Next journey: ${nextTier.emoji} ${nextTier.name} Tier',
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

  Widget _buildCampfireButtonText() {
    final nextLevel = gameViewModel.gameState.level + 1;
    final nextTier = GameLevel.getLevel(nextLevel).tier;
    
    final campfireTexts = {
      Tier.bronze: 'Venture Forth, Brave Soul! 🗡️',
      Tier.silver: 'Answer the Call to Glory! ⚔️',
      Tier.gold: 'Embrace Your Destiny! 👑',
    };
    
    return Text(campfireTexts[nextTier] ?? 'Continue the Journey! 🌟');
  }
}