import 'package:flutter/material.dart';
import '../../../configs/config.dart';
import '../../../configs/game_level.dart';
import '../../../configs/tier.dart';
import '../../../view_models/game_view_model.dart';

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