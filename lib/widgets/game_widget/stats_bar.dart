import 'package:flutter/material.dart';
import '../../configs/config.dart';

class StatsBar extends StatelessWidget {
  final int score;
  final int level;
  final int lives;
  final int divisor;

  const StatsBar({
    super.key,
    required this.score,
    required this.level,
    required this.lives,
    required this.divisor,
  });
  
  String _getTierIcon(String tier) {
    switch (tier) {
      case 'Bronze':
        return '🥉';
      case 'Silver':
        return '🥈';
      case 'Gold':
        return '🥇';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final tier = Config.getLevelTier(level);
    final tierIcon = _getTierIcon(tier);
    
    return Container(
      width: Config.playAreaWidth,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Score: $score', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('Level: $tierIcon $divisor', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text('Lives: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('❤️' * lives, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}