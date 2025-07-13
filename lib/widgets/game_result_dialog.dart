import 'package:flutter/material.dart';
import '../configs/config.dart';

class GameResultDialog extends StatelessWidget {
  final bool isWin;
  final int finalScore;
  final int finalLevel;
  final List<String> wrongAnswers; // "number was not divisible by divisor"
  final VoidCallback onRestart;

  const GameResultDialog({
    super.key,
    required this.isWin,
    required this.finalScore,
    required this.finalLevel,
    required this.wrongAnswers,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        isWin ? '🎉 You Win!' : '💔 Game Over',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: isWin ? Colors.green : Colors.red,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Game summary
            Text(
              'Final Results:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('Score: $finalScore'),
            Text('Level: $finalLevel/${Config.totalLevels}'),
            
            if (wrongAnswers.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Wrong Answers:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 5),
              ...wrongAnswers.map((answer) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  '• $answer',
                  style: const TextStyle(fontSize: 14),
                ),
              )),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: onRestart,
          child: const Text(
            'Play Again',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}