import 'package:flutter/material.dart';
import 'help_button.dart';
import 'game_widget/game_widget.dart';
import 'about_button.dart';
import 'settings_button.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Divisibility Samurai'),
        leading: const HelpButton(),
        actions: [
          AboutButton(),
          SettingsButton(),
        ],
      ),
      body: const Center(
        child: GameWidget(),
      ),
    );
  }
}