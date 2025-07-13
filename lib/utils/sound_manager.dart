import 'package:universal_html/html.dart' as html;
import '../configs/config.dart';

class SoundManager {
  static bool _soundEnabled = true;
  static html.AudioElement? _audio;
  
  /// Initialize sound system  
  static Future<void> initialize() async {
    try {
      _audio = html.AudioElement('assets/${Config.slashSoundPath}');
      _audio!.preload = 'auto';
      _audio!.volume = 0.7;
    } catch (e) {
      _audio = null;
    }
  }
  
  /// Play slash sound effect when a block is hit
  static Future<void> playSlashSound() async {
    if (!_soundEnabled) return;
    
    try {
      if (_audio != null) {
        _audio!.currentTime = 0;
        await _audio!.play();
      }
    } catch (e) {
      // Silent fail
    }
  }
  
  /// Toggle sound on/off
  static void toggleSound() {
    _soundEnabled = !_soundEnabled;
  }
  
  /// Get current sound state
  static bool get isSoundEnabled => _soundEnabled;
}