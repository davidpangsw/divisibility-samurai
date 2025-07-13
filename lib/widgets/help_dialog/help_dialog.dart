import 'package:flutter/material.dart';
import 'game_rule_section.dart';
import 'example_section.dart';
import 'hint_card_section.dart';

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
            // Cute samurai image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'images/samurai/openart-image_oOwjbEGr_1752429681294_raw.jpg',
                  width: 200,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 200,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            const GameRuleSection(),
            const SizedBox(height: 20),
            const ExampleSection(),
            const SizedBox(height: 20),
            const HintCardSection(),
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