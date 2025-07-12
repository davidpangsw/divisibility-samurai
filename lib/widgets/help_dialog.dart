import 'package:flutter/material.dart';
import '../configs/config.dart';
import 'number_blocks/number_block.dart';

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
              '• ${Config.totalLevels} levels with divisors ${Config.divisors.join(', ')}\n'
              '• ${Config.totalLives} lives total\n'
              '• ${Config.blocksNeededPerLevel} correct blocks needed per level\n'
              '• Max ${Config.maxNumberBlocksInPlayArea} blocks on screen',
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
            const Text('Divisor = 3:'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    NumberBlock(number: 12, isCorrect: true),
                    const SizedBox(height: 5),
                    const Text('✓', style: TextStyle(color: Colors.green, fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    NumberBlock(number: 21, isCorrect: true),
                    const SizedBox(height: 5),
                    const Text('✓', style: TextStyle(color: Colors.green, fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    NumberBlock(number: 13, isCorrect: false),
                    const SizedBox(height: 5),
                    const Text('✗', style: TextStyle(color: Colors.red, fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    NumberBlock(number: 25, isCorrect: false),
                    const SizedBox(height: 5),
                    const Text('✗', style: TextStyle(color: Colors.red, fontSize: 16)),
                  ],
                ),
              ],
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