import 'package:flutter/material.dart';

class GameRuleSection extends StatelessWidget {
  const GameRuleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How to play:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Slash numbers divisible by the given divisor.\n\n'
          '• Wrong answers lose lives\n'
          '• Lives refill when advancing to the next tier\n'
          '• Tiers: 📚 Study → 🥉 Bronze → 🥈 Silver → 🥇 Gold',
        ),
      ],
    );
  }
}