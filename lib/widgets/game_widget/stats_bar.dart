import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Score: $score', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('Level: $level', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('Lives: $lives', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('Divisor: $divisor', style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}