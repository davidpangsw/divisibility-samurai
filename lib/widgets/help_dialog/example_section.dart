import 'package:flutter/material.dart';
import '../number_blocks/animated_number_block_model.dart';
import '../game_widget/block_area.dart';
import '../../utils/rectangle.dart';
import '../../configs/config.dart';

class ExampleSection extends StatefulWidget {
  const ExampleSection({super.key});

  @override
  State<ExampleSection> createState() => _ExampleSectionState();
}

class _ExampleSectionState extends State<ExampleSection> {

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
        _buildExampleBlockArea(),
      ],
    );
  }

  Widget _buildExampleBlockArea() {
    final exampleBlocks = [
      AnimatedNumberBlock(
        number: 12, 
        isCorrect: true, 
        x: 10, 
        y: 10, 
        velocityX: 0, 
        velocityY: 0
      ),
      AnimatedNumberBlock(
        number: 21, 
        isCorrect: true, 
        x: 90, 
        y: 10, 
        velocityX: 0, 
        velocityY: 0
      ),
      AnimatedNumberBlock(
        number: 13, 
        isCorrect: false, 
        x: 170, 
        y: 10, 
        velocityX: 0, 
        velocityY: 0
      ),
      AnimatedNumberBlock(
        number: 25, 
        isCorrect: false, 
        x: 250, 
        y: 10, 
        velocityX: 0, 
        velocityY: 0
      ),
    ];

    return Column(
      children: [
        SizedBox(
          height: 80,
          child: BlockArea(
            areaRectangle: const Rectangle(320, 60),
            blockRectangle: const Rectangle(Config.numberBlockWidth, Config.numberBlockHeight),
            blocks: exampleBlocks,
          ),
        ),
      ],
    );
  }
}