import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/game_view_model.dart';
import 'help_button.dart';
import 'game_widget/game_widget.dart';
import 'about_button.dart';
import 'settings_button.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameViewModel(),
      child: Consumer<GameViewModel>(
        builder: (context, gameViewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Divisibility Samurai'),
              actions: [
                const HelpButton(),
                SettingsButton(gameViewModel: gameViewModel),
                const AboutButton(),
              ],
            ),
            body: Center(
              child: GameWidget(gameViewModel: gameViewModel),
            ),
          );
        },
      ),
    );
  }
}