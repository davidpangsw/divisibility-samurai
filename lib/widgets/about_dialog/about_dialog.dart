import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:universal_html/html.dart' as html;

class AboutGameDialog extends StatelessWidget {
  const AboutGameDialog({super.key});

  void _launchUrl(String url) {
    try {
      html.window.open(url, '_blank');
    } catch (e) {
      // Fallback if doesn't work
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('About'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Math Game',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Credits & Attributions:'),
            const SizedBox(height: 8),
            
            // Sound attributions
            _buildAttribution(
              'Sound Effect by ',
              'freesound_community',
              'https://pixabay.com/users/freesound_community-46691455/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=36274',
              ' from ',
              'Pixabay',
              'https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=36274',
            ),
            const SizedBox(height: 4),
            
            _buildAttribution(
              'Music by ',
              'Naveed Ul hassan',
              'https://pixabay.com/users/ulhassan123-24977311/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=309756',
              ' from ',
              'Pixabay',
              'https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=309756',
            ),
            const SizedBox(height: 4),
            
            _buildAttribution(
              'Music by ',
              'Ievgen Poltavskyi',
              'https://pixabay.com/users/hitslab-47305729/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=272176',
              ' from ',
              'Pixabay',
              'https://pixabay.com/music//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=272176',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildAttribution(
    String prefix,
    String linkText1,
    String url1,
    String middle,
    String linkText2,
    String url2,
  ) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black87, fontSize: 12),
        children: [
          TextSpan(text: prefix),
          TextSpan(
            text: linkText1,
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => _launchUrl(url1),
          ),
          TextSpan(text: middle),
          TextSpan(
            text: linkText2,
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => _launchUrl(url2),
          ),
        ],
      ),
    );
  }
}