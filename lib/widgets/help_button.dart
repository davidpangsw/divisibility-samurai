import 'package:flutter/material.dart';

class HelpButton extends StatelessWidget {
  const HelpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.help),
      onPressed: () {
        // No effect for now
      },
    );
  }
}