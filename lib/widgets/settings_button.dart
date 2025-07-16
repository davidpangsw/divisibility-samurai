import 'package:flutter/material.dart';
import 'settings_dialog/settings_dialog.dart';
import '../view_models/game_view_model.dart';

class SettingsButton extends StatelessWidget {
  final GameViewModel gameViewModel;
  
  const SettingsButton({
    super.key,
    required this.gameViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.settings),
      label: const Text('Settings'),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => SettingsGameDialog(gameViewModel: gameViewModel),
        );
      },
    );
  }
}