import 'tier.dart';

/// Asset configuration with folder-based mapping
class AssetPaths {
  
  // Non-tier specific assets
  static const String slashSounds = 'sounds/effects/slash';
  static const String campfireBgm = 'sounds/music/campfire-bgm';
  static const String samuraiImages = 'images/samurai';
  
  // Tier-based asset mappings
  static const Map<Tier, String> tierBackgrounds = {
    Tier.study: 'images/study-background',
    Tier.bronze: 'images/bronze-background',
    Tier.silver: 'images/silver-background',
    Tier.gold: 'images/gold-background',
  };
  
  static const Map<Tier, String> tierBgm = {
    Tier.study: 'sounds/music/study-bgm',
    Tier.bronze: 'sounds/music/bronze-bgm',
    Tier.silver: 'sounds/music/silver-bgm',
    Tier.gold: 'sounds/music/gold-bgm',
  };
  
  /// Map of folder paths to file lists
  static const Map<String, List<String>> assetMap = {
    'images/study-background': ['japanese-garden-4313104_1280.jpg'],
    'images/bronze-background': ['mountains-8892397_1280.jpg'],
    'images/silver-background': ['forest-6122667_1280.jpg'],
    'images/gold-background': ['fantasy-5077455_1280.jpg'],
    'sounds/effects/slash': ['sword-sound-2-36274.mp3'],
    'sounds/music/study-bgm': ['sedative-110241.mp3', 'jazz-lounge-elevator-music-332339.mp3'],
    'sounds/music/bronze-bgm': ['adventure-cinematic-music-faith-journey-324896.mp3'],
    'sounds/music/silver-bgm': ['battle-fight-music-dynamic-warrior-background-intro-theme-272176.mp3'],
    'sounds/music/gold-bgm': ['battle-background-music-309756.mp3'],
    'sounds/music/campfire-bgm': ['campfire-crackling-fireplace-sound-119594.mp3'],
    'images/samurai': ['openart-image_oOwjbEGr_1752429681294_raw.jpg'],
  };
}