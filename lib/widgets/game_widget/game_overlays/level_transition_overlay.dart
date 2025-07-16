import 'package:flutter/material.dart';
import '../../../configs/config.dart';
import '../../../configs/game_level.dart';
import '../../../view_models/game_view_model.dart';
import '../../number_blocks/basic_number_block.dart';

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