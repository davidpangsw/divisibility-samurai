import 'package:flutter/material.dart';
import '../../../configs/config.dart';
import '../../../utils/asset_manager.dart';
import '../../help_dialog/help_dialog.dart';

/// Start screen overlay when game is not started
class StartGameOverlay extends StatelessWidget {
  final VoidCallback onStartGame;
  
  const StartGameOverlay({
    super.key,
    required this.onStartGame,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Config.playAreaWidth,
      height: Config.playAreaHeight,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '⚔️ Divisibility Samurai',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            // Samurai image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                AssetManager.samuraiImagePath,
                width: 200,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Find numbers divisible by the given divisor!',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: onStartGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Start Game'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const HelpDialog(),
                    );
                  },
                  icon: const Icon(Icons.help),
                  label: const Text('How To Play'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}