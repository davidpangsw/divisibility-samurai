import 'package:flutter/material.dart';
import '../../configs/config.dart';
import '../../configs/game_level.dart';

class StatsBar extends StatelessWidget {
  final int score;
  final int level;
  final int lives;
  final int divisor;
  final int remainingCorrectBlocksAllowed;
  final int remainingCorrectNeeded;

  const StatsBar({
    super.key,
    required this.score,
    required this.level,
    required this.lives,
    required this.divisor,
    required this.remainingCorrectBlocksAllowed,
    required this.remainingCorrectNeeded,
  });
  

  @override
  Widget build(BuildContext context) {
    final gameLevel = GameLevel.getLevel(level);
    final tier = gameLevel.tier.name;
    final tierIcon = gameLevel.tier.emoji;
    
    return Container(
      width: Config.playAreaWidth,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          // Left column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Score: $score', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Tier: $tierIcon$tier', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Divisor: $divisor', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text('Lives: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('❤️' * lives, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
          // Right column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Blocks to slash: $remainingCorrectNeeded',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                ),
                const SizedBox(height: 4),
                Text(
                  'Correct Block Left: $remainingCorrectBlocksAllowed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: remainingCorrectBlocksAllowed < 10 ? Colors.red : Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}