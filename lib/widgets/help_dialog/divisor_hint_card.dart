import 'package:flutter/material.dart';
import '../number_blocks/basic_number_block.dart';
import '../game_widget/block_area.dart';
import '../../utils/rectangle.dart';
import '../../configs/config.dart';
import '../number_blocks/animated_number_block_model.dart';

class DivisorHintCard extends StatelessWidget {
  final String divisor;
  final String rule;
  final String positiveExample;
  final String negativeExample;
  final String explanation;

  const DivisorHintCard({
    super.key,
    required this.divisor,
    required this.rule,
    required this.positiveExample,
    required this.negativeExample,
    required this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                divisor,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rule,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                _buildExampleRow(positiveExample, true),
                const SizedBox(height: 4),
                _buildExampleRow(negativeExample, false),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    explanation,
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleRow(String exampleText, bool isPositive) {
    // Extract the dividend number from examples like "123: 1+2+3=6 and 3|6 ⇒ 3|123"
    int? dividendNumber = _extractDividendNumber(exampleText);
    
    if (dividendNumber != null) {
      return Row(
        children: [
          SizedBox(
            width: Config.numberBlockWidth,
            height: Config.numberBlockHeight,
            child: BlockArea(
              areaRectangle: Rectangle(Config.numberBlockWidth, Config.numberBlockHeight),
              blockRectangle: const Rectangle(Config.numberBlockWidth, Config.numberBlockHeight),
              blocks: [
                AnimatedNumberBlock(
                  number: dividendNumber,
                  isCorrect: isPositive,
                  x: 0,
                  y: 0,
                  velocityX: 0,
                  velocityY: 0,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            isPositive ? '✓' : '✗',
            style: TextStyle(
              color: isPositive ? Colors.green[700] : Colors.red[700],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              exampleText,
              style: TextStyle(
                color: isPositive ? Colors.green[700] : Colors.red[700],
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      );
    } else {
      // Fallback to original text display if number extraction fails
      return Row(
        children: [
          Expanded(
            child: Text(
              '$exampleText ${isPositive ? '✓' : '✗'}',
              style: TextStyle(
                color: isPositive ? Colors.green[700] : Colors.red[700],
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      );
    }
  }

  int? _extractDividendNumber(String text) {
    // Extract the first number from examples like "123: 1+2+3=6 and 3|6 ⇒ 3|123"
    final RegExp numberRegex = RegExp(r'^\d+');
    final match = numberRegex.firstMatch(text);
    if (match != null) {
      return int.tryParse(match.group(0)!);
    }
    return null;
  }
}