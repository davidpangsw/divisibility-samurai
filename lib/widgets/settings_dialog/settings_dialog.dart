import 'package:flutter/material.dart';
import '../../utils/sound_manager.dart';

class SettingsGameDialog extends StatefulWidget {
  const SettingsGameDialog({super.key});

  @override
  State<SettingsGameDialog> createState() => _SettingsGameDialogState();
}

class _SettingsGameDialogState extends State<SettingsGameDialog> {
  double _bgmVolume = 0.7;
  double _sfxVolume = 0.7;
  
  @override
  void initState() {
    super.initState();
    // Get current volumes from SoundManager
    _bgmVolume = SoundManager.bgmVolume;
    _sfxVolume = SoundManager.sfxVolume;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Settings'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // BGM Volume
          Row(
            children: [
              const Text('BGM Volume:'),
              const SizedBox(width: 16),
              Expanded(
                child: Slider(
                  value: _bgmVolume,
                  onChanged: (value) {
                    setState(() {
                      _bgmVolume = value;
                    });
                    SoundManager.setBgmVolume(value);
                  },
                  min: 0.0,
                  max: 1.0,
                ),
              ),
              Text('${(_bgmVolume * 100).round()}%'),
            ],
          ),
          
          // SFX Volume
          Row(
            children: [
              const Text('SFX Volume:'),
              const SizedBox(width: 16),
              Expanded(
                child: Slider(
                  value: _sfxVolume,
                  onChanged: (value) {
                    setState(() {
                      _sfxVolume = value;
                    });
                    SoundManager.setSfxVolume(value);
                  },
                  min: 0.0,
                  max: 1.0,
                ),
              ),
              Text('${(_sfxVolume * 100).round()}%'),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}