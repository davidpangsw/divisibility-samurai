import 'package:universal_html/html.dart' as html;
import 'dart:math';
import '../configs/config.dart';

class SoundManager {
  static bool _soundEnabled = true;
  static final List<html.AudioElement> _slashAudios = [];
  static final Random _random = Random();
  static html.AudioElement? _currentBgm;
  static double _bgmVolume = 0.7;
  static double _sfxVolume = 0.7;
  static bool _userInteracted = false;
  static String? _pendingBgmTier;
  
  /// Initialize sound system  
  static Future<void> initialize() async {
    try {
      // Initialize all slash sounds
      for (String soundPath in Config.slashSoundPaths) {
        final audio = html.AudioElement('assets/$soundPath');
        audio.preload = 'auto';
        audio.volume = _sfxVolume;
        _slashAudios.add(audio);
      }
    } catch (e) {
      // Silent fail
    }
  }
  
  /// Play slash sound effect when a block is hit
  static Future<void> playSlashSound() async {
    if (!_soundEnabled || _slashAudios.isEmpty) return;
    
    // Mark user interaction and start pending BGM if needed
    if (!_userInteracted) {
      _userInteracted = true;
      if (_pendingBgmTier != null) {
        await _playBgmInternal(_pendingBgmTier!);
        _pendingBgmTier = null;
      }
    }
    
    try {
      // Randomly select a slash sound
      final audio = _slashAudios[_random.nextInt(_slashAudios.length)];
      audio.currentTime = 0;
      await audio.play();
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
  
  /// Get current BGM volume
  static double get bgmVolume => _bgmVolume;
  
  /// Get current SFX volume  
  static double get sfxVolume => _sfxVolume;
  
  /// Set volume for sound effects
  static void setSfxVolume(double volume) {
    try {
      _sfxVolume = volume.clamp(0.0, 1.0);
      for (html.AudioElement audio in _slashAudios) {
        audio.volume = _sfxVolume;
      }
    } catch (e) {
      // Silent fail
    }
  }
  
  /// Set volume for background music
  static void setBgmVolume(double volume) {
    try {
      _bgmVolume = volume.clamp(0.0, 1.0);
      if (_currentBgm != null) {
        _currentBgm!.volume = _bgmVolume;
      }
    } catch (e) {
      // Silent fail
    }
  }
  
  /// Play background music for a tier
  static Future<void> playBgmForTier(String tier) async {
    if (!_soundEnabled) return;
    
    if (!_userInteracted) {
      // Store the tier to play after user interaction
      _pendingBgmTier = tier;
      return;
    }
    
    await _playBgmInternal(tier);
  }
  
  /// Internal method to actually play BGM
  static Future<void> _playBgmInternal(String tier) async {
    try {
      // Stop current BGM
      if (_currentBgm != null) {
        _currentBgm!.pause();
        _currentBgm = null;
      }
      
      // Get music list for tier
      List<String> musicPaths;
      switch (tier.toLowerCase()) {
        case 'bronze':
          musicPaths = Config.bronzeBgmPaths;
          break;
        case 'silver':
          musicPaths = Config.silverBgmPaths;
          break;
        case 'gold':
          musicPaths = Config.goldBgmPaths;
          break;
        default:
          return;
      }
      
      if (musicPaths.isNotEmpty) {
        // Randomly select a music track
        final selectedPath = musicPaths[_random.nextInt(musicPaths.length)];
        _currentBgm = html.AudioElement('assets/$selectedPath');
        _currentBgm!.volume = _bgmVolume;
        _currentBgm!.loop = true; // Loop forever
        await _currentBgm!.play();
      }
    } catch (e) {
      // Silent fail
    }
  }
  
  /// Stop background music
  static void stopBgm() {
    try {
      if (_currentBgm != null) {
        _currentBgm!.pause();
        _currentBgm = null;
      }
    } catch (e) {
      // Silent fail
    }
  }
}