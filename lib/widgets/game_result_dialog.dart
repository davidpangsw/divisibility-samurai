import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import '../configs/config.dart';

// Import for web download functionality
import 'dart:html' as html;

class GameResultDialog extends StatefulWidget {
  final bool isWin;
  final int finalScore;
  final int finalLevel;
  final List<String> wrongAnswers; // "number was not divisible by divisor"
  final Map<String, List<int>> correctAnswersByLevel; // Track correct answers by level
  final Map<String, List<int>> wrongAnswersByLevel; // Track wrong answers by level
  final int totalBlocksMissed; // Total blocks that fell off screen
  final VoidCallback onRestart;

  const GameResultDialog({
    super.key,
    required this.isWin,
    required this.finalScore,
    required this.finalLevel,
    required this.wrongAnswers,
    required this.correctAnswersByLevel,
    required this.wrongAnswersByLevel,
    required this.totalBlocksMissed,
    required this.onRestart,
  });

  @override
  State<GameResultDialog> createState() => _GameResultDialogState();
}

class _GameResultDialogState extends State<GameResultDialog> {
  final GlobalKey _screenshotKey = GlobalKey();

  Future<void> _downloadImage() async {
    try {
      // Capture the screenshot
      RenderRepaintBoundary boundary =
          _screenshotKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
      if (byteData != null) {
        final pngBytes = byteData.buffer.asUint8List();
        
        if (kIsWeb) {
          // Web platform: Trigger browser download with timestamp
          final now = DateTime.now();
          final timestamp = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
          final filename = 'divisibility_samurai_result_$timestamp.png';
          
          final blob = html.Blob([pngBytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url);
          anchor.setAttribute('download', filename);
          html.document.body?.children.add(anchor);
          anchor.click();
          html.document.body?.children.remove(anchor);
          html.Url.revokeObjectUrl(url);
          
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Image saved! 📸 Check your downloads folder.'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        } else {
          // Non-web platforms
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Image generated! 🖼️\n(File saving on mobile/desktop requires additional packages)'),
                duration: Duration(seconds: 3),
              ),
            );
          }
        }
      }
      
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to generate image: $e')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _screenshotKey,
      child: AlertDialog(
        title: Text(
          widget.isWin ? '🎉 You Win!' : '💔 Game Over',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: widget.isWin ? Colors.green : Colors.red,
          ),
        ),
        content: SizedBox(
          width: 400,
          height: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stats Section
                _buildStatsSection(),
                const SizedBox(height: 20),
                
                // Correct Answers Section
                if (widget.correctAnswersByLevel.isNotEmpty) ...[
                  _buildCorrectAnswersSection(),
                  const SizedBox(height: 20),
                ],
                
                // Wrong Answers Section
                if (widget.wrongAnswersByLevel.isNotEmpty) ...[
                  _buildWrongAnswersSection(),
                ],
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: widget.onRestart,
            child: const Text('Play Again'),
          ),
          ElevatedButton.icon(
            onPressed: _downloadImage,
            icon: const Icon(Icons.download),
            label: const Text('Save Image'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    String tierEmoji = '';
    String tier = Config.getLevelTier(widget.finalLevel);
    if (tier == 'Study') {
      tierEmoji = '📚';
    } else if (tier == 'Bronze') {
      tierEmoji = '🥉';
    } else if (tier == 'Silver') {
      tierEmoji = '🥈';
    } else if (tier == 'Gold') {
      tierEmoji = '🥇';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Score: ${widget.finalScore}', style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Text('Total blocks missed: ${widget.totalBlocksMissed}', style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Text('Last level: $tierEmoji${Config.getDivisorForLevel(widget.finalLevel)}', style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildCorrectAnswersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Correct Answers:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 8),
        ...widget.correctAnswersByLevel.entries.map((entry) {
          String tierEmoji = '';
          if (entry.key.startsWith('Study')) {
            tierEmoji = '📚';
          } else if (entry.key.startsWith('Bronze')) {
            tierEmoji = '🥉';
          } else if (entry.key.startsWith('Silver')) {
            tierEmoji = '🥈';
          } else if (entry.key.startsWith('Gold')) {
            tierEmoji = '🥇';
          }
          
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              '$tierEmoji${entry.key.split(' ').last} | ${entry.value.join(',')}',
              style: const TextStyle(fontSize: 14, fontFamily: 'monospace'),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildWrongAnswersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Wrong Answers:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 8),
        ...widget.wrongAnswersByLevel.entries.map((entry) {
          String tierEmoji = '';
          if (entry.key.startsWith('Study')) {
            tierEmoji = '📚';
          } else if (entry.key.startsWith('Bronze')) {
            tierEmoji = '🥉';
          } else if (entry.key.startsWith('Silver')) {
            tierEmoji = '🥈';
          } else if (entry.key.startsWith('Gold')) {
            tierEmoji = '🥇';
          }
          
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              '$tierEmoji${entry.key.split(' ').last} ∤ ${entry.value.join(',')}',
              style: const TextStyle(fontSize: 14, fontFamily: 'monospace'),
            ),
          );
        }),
      ],
    );
  }
}