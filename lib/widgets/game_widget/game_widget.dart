import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/game_view_model.dart';
import 'stats_bar.dart';
import 'play_area.dart';

class GameWidget extends StatelessWidget {
  const GameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameViewModel(),
      child: Consumer<GameViewModel>(
        builder: (context, gameViewModel, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StatsBar(
                score: gameViewModel.gameState.score,
                level: gameViewModel.gameState.level,
                lives: gameViewModel.gameState.lives,
                divisor: gameViewModel.gameState.divisor,
              ),
              const PlayArea(),
            ],
          );
        },
      ),
    );
  }
}