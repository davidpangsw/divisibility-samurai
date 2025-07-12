import 'package:flutter/material.dart';
import '../configs/config.dart';

class GameWidget extends StatelessWidget {
  const GameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Config.playAreaWidth,
      height: Config.playAreaHeight,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.grey[100],
      ),
      child: const Center(
        child: Text(
          'Game Area Placeholder',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}