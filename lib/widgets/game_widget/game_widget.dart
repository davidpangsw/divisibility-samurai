import 'package:flutter/material.dart';
import 'stats_bar.dart';
import 'play_area.dart';

class GameWidget extends StatelessWidget {
  const GameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatsBar(
          score: 0,
          level: 1,
          lives: 10,
          divisor: 3,
        ),
        const PlayArea(),
      ],
    );
  }
}