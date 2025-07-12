import 'package:flutter/material.dart';
import 'help_button.dart';
import 'game_widget.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Game'),
        leading: const HelpButton(),
      ),
      body: const Center(
        child: GameWidget(),
      ),
    );
  }
}