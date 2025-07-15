import 'package:flutter/material.dart';
import 'settings_dialog/settings_dialog.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.settings),
      label: const Text('Settings'),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const SettingsGameDialog(),
        );
      },
    );
  }
}