import 'package:flutter/material.dart';
import '../configs/config.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Help'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'How to play:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Identify numbers divisible by the given divisor. Numbers appear as blocks with physics-based movement. Slash correct numbers to score points.\n\n'
              '• ${Config.totalLevels} levels with divisors ${Config.minDivisor}-${Config.maxDivisor}\n'
              '• ${Config.totalLives} lives total\n'
              '• ${Config.blocksNeededPerLevel} correct blocks needed per level\n'
              '• Max ${Config.maxNumberBlocks} blocks on screen',
            ),
            const SizedBox(height: 20),
            const Text(
              'Examples:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Divisor = 3:\n'
              '✓ 12 (12 ÷ 3 = 4)\n'
              '✓ 21 (21 ÷ 3 = 7)\n'
              '✗ 13 (not divisible by 3)\n'
              '✗ 25 (not divisible by 3)',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}