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