import 'package:flutter/material.dart';
import 'about_dialog/about_dialog.dart';

class AboutButton extends StatelessWidget {
  const AboutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.info_outline),
      label: const Text('About'),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const AboutGameDialog(),
        );
      },
    );
  }
}