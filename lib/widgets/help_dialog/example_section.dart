import 'package:flutter/material.dart';
import '../number_blocks/number_block.dart';

class ExampleSection extends StatelessWidget {
  const ExampleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Examples:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 10),
        const Text('Divisor = 3'),
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
    );
  }
}