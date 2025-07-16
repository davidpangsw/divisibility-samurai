import 'package:flutter/material.dart';
import 'help_dialog/help_dialog.dart';

class HelpButton extends StatelessWidget {
  const HelpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.help),
      label: const Text('How To Play'),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const HelpDialog(),
        );
      },
    );
  }
}