import 'package:flutter/material.dart';
import 'help_dialog.dart';

class HelpButton extends StatelessWidget {
  const HelpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.help),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const HelpDialog(),
        );
      },
    );
  }
}