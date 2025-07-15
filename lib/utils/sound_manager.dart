import 'package:universal_html/html.dart' as html;
import 'package:flutter/services.dart';
import 'dart:math';
import '../configs/config.dart';

class SoundManager {
  static bool _soundEnabled = true;
  static final List<html.AudioElement> _slashAudios = [];
  static final Map<String, String> _audioUrls = {}; // Cache for asset URLs
  static final Random _random = Random();
  static html.AudioElement? _currentBgm;
  static double _bgmVolume = 0.25; // Default 25%
  static double _sfxVolume = 0.5; // Default 50%
  static bool _userInteracted = false;
  static String? _pendingBgmTier;
  static String? _currentBgmTier; // Track current tier to prevent restarts
  
  /// Initialize sound system  
  static Future<void> initialize() async {
    try {
      // Load persisted volume settings
      _loadVolumeSettings();
      
      // Initialize only the first few slash sounds for faster loading
      final slashSoundPaths = Config.slashSoundPaths;
      final initialLoadCount = (slashSoundPaths.length * 0.5).round(); // Load 50% initially
      
      for (int i = 0; i < initialLoadCount && i < slashSoundPaths.length; i++) {
        final soundPath = slashSoundPaths[i];
        final audioUrl = await _getAssetUrl('assets/$soundPath');
        if (audioUrl != null) {
          final audio = html.AudioElement(audioUrl);
          audio.preload = 'auto';
          audio.volume = _sfxVolume;
          _slashAudios.add(audio);
        }
      }
      
      // Load remaining sounds in background
      _loadRemainingSlashSounds(slashSoundPaths, initialLoadCount);
    } catch (e) {
      // Silent fail
    }
  }
  
  /// Load remaining slash sounds in background
  static void _loadRemainingSlashSounds(List<String> allPaths, int startIndex) {
    Future.delayed(const Duration(milliseconds: 100), () async {
      for (int i = startIndex; i < allPaths.length; i++) {
        try {
          final soundPath = allPaths[i];
          final audioUrl = await _getAssetUrl('assets/$soundPath');
          if (audioUrl != null) {
            final audio = html.AudioElement(audioUrl);
            audio.preload = 'auto';
            audio.volume = _sfxVolume;
            _slashAudios.add(audio);
          }
        } catch (e) {
          // Silent fail for background loading
        }
      }
    });
  }
  
  /// Get proper asset URL using Flutter's asset bundle
  static Future<String?> _getAssetUrl(String assetPath) async {
    try {
      // Check cache first
      if (_audioUrls.containsKey(assetPath)) {
        return _audioUrls[assetPath];
      }
      
      // Load asset using Flutter's asset bundle
      final bytes = await rootBundle.load(assetPath);
      final blob = html.Blob([bytes.buffer.asUint8List()]);
      final url = html.Url.createObjectUrl(blob);
      
      // Cache the URL
      _audioUrls[assetPath] = url;
      return url;
    } catch (e) {
      // If Flutter asset loading fails, try direct path (fallback)
      return 'assets/$assetPath';
    }
  }
  
  /// Play slash sound effect when a block is hit
  static Future<void> playSlashSound() async {
    if (!_soundEnabled || _slashAudios.isEmpty) return;
    
    // Mark user interaction and start pending BGM if needed
    if (!_userInteracted) {
      _userInteracted = true;
      if (_pendingBgmTier != null) {
        final pendingTier = _pendingBgmTier!;
        _pendingBgmTier = null;
        await _playBgmInternal(pendingTier);
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
      _saveVolumeSettings();
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
      _saveVolumeSettings();
    } catch (e) {
      // Silent fail
    }
  }
  
  /// Play background music for a tier
  static Future<void> playBgmForTier(String tier) async {
    if (!_soundEnabled) return;
    
    // Don't restart BGM if same tier is already playing
    if (_currentBgmTier == tier && _currentBgm != null && !_currentBgm!.paused) {
      return;
    }
    
    // Try to play immediately, store as pending if it fails due to user interaction policy
    try {
      await _playBgmInternal(tier);
    } catch (e) {
      // If it fails due to user interaction policy, store as pending
      _pendingBgmTier = tier;
    }
  }
  
  /// Internal method to actually play BGM
  static Future<void> _playBgmInternal(String tier) async {
    try {
      // Stop current BGM completely
      if (_currentBgm != null) {
        _currentBgm!.pause();
        _currentBgm!.currentTime = 0; // Reset to beginning
        _currentBgm = null;
      }
      
      // Get music list for tier
      List<String> musicPaths;
      switch (tier.toLowerCase()) {
        case 'study':
          musicPaths = Config.studyBgmPaths;
          break;
        case 'bronze':
          musicPaths = Config.bronzeBgmPaths;
          break;
        case 'silver':
          musicPaths = Config.silverBgmPaths;
          break;
        case 'gold':
          musicPaths = Config.goldBgmPaths;
          break;
        case 'campfire':
          musicPaths = Config.campfireBgmPaths;
          break;
        default:
          _currentBgmTier = null;
          return;
      }
      
      if (musicPaths.isNotEmpty) {
        // Randomly select a music track
        final selectedPath = musicPaths[_random.nextInt(musicPaths.length)];
        final audioUrl = await _getAssetUrl('assets/$selectedPath');
        if (audioUrl != null) {
          _currentBgm = html.AudioElement(audioUrl);
          _currentBgm!.volume = _bgmVolume;
          _currentBgm!.loop = true; // Loop forever
        
          // Add event listeners to handle audio events
          _currentBgm!.onEnded.listen((_) {
            // In case loop fails, restart manually
            if (_currentBgm != null && _currentBgmTier == tier) {
              _currentBgm!.currentTime = 0;
              _currentBgm!.play();
            }
          });
          
          _currentBgm!.onError.listen((_) {
            // Handle audio errors
            _currentBgm = null;
            _currentBgmTier = null;
          });
          
          await _currentBgm!.play();
          _currentBgmTier = tier; // Set current tier after successful play
        }
      }
    } catch (e) {
      // Silent fail
      _currentBgm = null;
      _currentBgmTier = null;
    }
  }
  
  /// Stop background music
  static void stopBgm() {
    try {
      if (_currentBgm != null) {
        _currentBgm!.pause();
        _currentBgm!.currentTime = 0;
        _currentBgm = null;
      }
      _currentBgmTier = null;
    } catch (e) {
      // Silent fail
    }
  }
  
  /// Reset sound manager state (for game restart)
  static void reset() {
    stopBgm();
    _userInteracted = false;
    _pendingBgmTier = null;
  }
  
  /// Load volume settings from browser localStorage
  static void _loadVolumeSettings() {
    try {
      final storage = html.window.localStorage;
      
      // Load BGM volume
      final bgmVolumeStr = storage['divisibility_samurai_bgm_volume'];
      if (bgmVolumeStr != null) {
        final bgmVolume = double.tryParse(bgmVolumeStr);
        if (bgmVolume != null) {
          _bgmVolume = bgmVolume.clamp(0.0, 1.0);
        }
      }
      
      // Load SFX volume
      final sfxVolumeStr = storage['divisibility_samurai_sfx_volume'];
      if (sfxVolumeStr != null) {
        final sfxVolume = double.tryParse(sfxVolumeStr);
        if (sfxVolume != null) {
          _sfxVolume = sfxVolume.clamp(0.0, 1.0);
        }
      }
    } catch (e) {
      // Silent fail - use defaults
    }
  }
  
  /// Save volume settings to browser localStorage
  static void _saveVolumeSettings() {
    try {
      final storage = html.window.localStorage;
      storage['divisibility_samurai_bgm_volume'] = _bgmVolume.toString();
      storage['divisibility_samurai_sfx_volume'] = _sfxVolume.toString();
    } catch (e) {
      // Silent fail
    }
  }
}