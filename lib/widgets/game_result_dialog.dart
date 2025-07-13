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
  final VoidCallback onRestart;

  const GameResultDialog({
    super.key,
    required this.isWin,
    required this.finalScore,
    required this.finalLevel,
    required this.wrongAnswers,
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
          // Web platform: Trigger browser download
          final blob = html.Blob([pngBytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url);
          anchor.setAttribute('download', 'math_game_result.png');
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
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Game summary
              Text(
                'Final Results:',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text('Score: ${widget.finalScore}'),
              Text('Level: ${widget.finalLevel}/${Config.totalLevels}'),
              
              if (widget.wrongAnswers.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Text(
                  'Wrong Answers:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 5),
                ...widget.wrongAnswers.map((answer) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    '• $answer',
                    style: const TextStyle(fontSize: 14),
                  ),
                )),
              ],
            ],
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: _downloadImage,
            icon: const Icon(Icons.download),
            label: const Text('Save Image'),
          ),
          TextButton(
            onPressed: widget.onRestart,
            child: const Text(
              'Play Again',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}