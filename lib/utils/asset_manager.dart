import 'dart:math';
import 'package:flutter/services.dart';
import 'package:universal_html/html.dart' as html;
import '../configs/asset_paths.dart';
import '../configs/tier.dart';

/// Centralized asset management to handle Flutter's inconsistent asset loading
/// between local development and web builds, and avoid the assets/assets/ bug
///
/// ⚠️ CRITICAL WARNING: DO NOT MODIFY getRandomAsset() WITHOUT EXTREME CARE
/// 
/// This class solves the Flutter web asset path problem that caused multiple failures:
/// - Local development and Firebase deploy have different asset path requirements
/// - The current implementation with 'assets/' prefix works for BOTH platforms
/// - Changing the asset path logic has repeatedly broken the app
/// 
/// TESTED AND WORKING FOR:
/// - flutter run (local development)
/// - firebase deploy (web production)
/// 
/// If you modify this class, you MUST test both local AND Firebase deploy!
class AssetManager {
  static final Map<String, String> _preloadedAssets = {};
  
  /// Preload all images (except music)
  static Future<void> preloadImages() async {
    final List<String> imagePaths = [];
    
    // Add all tier backgrounds
    for (final tier in Tier.values) {
      final files = AssetPaths.assetMap[AssetPaths.tierBackgrounds[tier]!];
      if (files != null) {
        for (final file in files) {
          imagePaths.add('${AssetPaths.tierBackgrounds[tier]!}/$file');
        }
      }
    }
    
    // Add samurai images
    final samuraiFiles = AssetPaths.assetMap[AssetPaths.samuraiImages];
    if (samuraiFiles != null) {
      for (final file in samuraiFiles) {
        imagePaths.add('${AssetPaths.samuraiImages}/$file');
      }
    }
    
    // Preload all images
    for (final imagePath in imagePaths) {
      try {
        final fullPath = 'assets/$imagePath';
        final bytes = await rootBundle.load(fullPath);
        final blob = html.Blob([bytes.buffer.asUint8List()]);
        final url = html.Url.createObjectUrl(blob);
        _preloadedAssets[fullPath] = url;
      } catch (e) {
        // Continue loading other assets if one fails
      }
    }
  }
  
  /// Preload all sound effects (except music)
  static Future<void> preloadSoundEffects() async {
    final List<String> soundPaths = [];
    
    // Add slash sounds
    final slashFiles = AssetPaths.assetMap[AssetPaths.slashSounds];
    if (slashFiles != null) {
      for (final file in slashFiles) {
        soundPaths.add('${AssetPaths.slashSounds}/$file');
      }
    }
    
    // Preload all sounds
    for (final soundPath in soundPaths) {
      try {
        final fullPath = 'assets/$soundPath';
        final bytes = await rootBundle.load(fullPath);
        final blob = html.Blob([bytes.buffer.asUint8List()]);
        final url = html.Url.createObjectUrl(blob);
        _preloadedAssets[fullPath] = url;
      } catch (e) {
        // Continue loading other assets if one fails
      }
    }
  }
  
  /// Preload all music in order: study -> bronze -> silver -> gold
  static Future<void> preloadSoundMusics() async {
    final List<String> musicPaths = [];
    
    // Add music in order: study -> bronze -> silver -> gold
    final orderedTiers = [Tier.study, Tier.bronze, Tier.silver, Tier.gold];
    
    for (final tier in orderedTiers) {
      final files = AssetPaths.assetMap[AssetPaths.tierBgm[tier]!];
      if (files != null) {
        for (final file in files) {
          musicPaths.add('${AssetPaths.tierBgm[tier]!}/$file');
        }
      }
    }
    
    // Add campfire music
    final campfireFiles = AssetPaths.assetMap[AssetPaths.campfireBgm];
    if (campfireFiles != null) {
      for (final file in campfireFiles) {
        musicPaths.add('${AssetPaths.campfireBgm}/$file');
      }
    }
    
    // Preload all music
    for (final musicPath in musicPaths) {
      try {
        final fullPath = 'assets/$musicPath';
        final bytes = await rootBundle.load(fullPath);
        final blob = html.Blob([bytes.buffer.asUint8List()]);
        final url = html.Url.createObjectUrl(blob);
        _preloadedAssets[fullPath] = url;
      } catch (e) {
        // Continue loading other assets if one fails
      }
    }
  }
  
  /// Get preloaded asset URL or null if not preloaded
  static String? getPreloadedAssetUrl(String assetPath) {
    return _preloadedAssets[assetPath];
  }
  
  /// Get proper asset URL using Flutter's asset bundle
  static Future<String?> getAssetUrl(String assetPath) async {
    try {
      // Check if asset is preloaded
      final preloadedUrl = getPreloadedAssetUrl(assetPath);
      if (preloadedUrl != null) {
        return preloadedUrl;
      }
      
      // Load asset using Flutter's asset bundle
      final bytes = await rootBundle.load(assetPath);
      final blob = html.Blob([bytes.buffer.asUint8List()]);
      final url = html.Url.createObjectUrl(blob);
      
      return url;
    } catch (e) {
      // If Flutter asset loading fails, try direct path (fallback)
      return assetPath;
    }
  }
  
  /// Get random sound path from folder
  static String getRandomSoundPath(String folderPath) {
    final files = AssetPaths.assetMap[folderPath];
    if (files == null || files.isEmpty) {
      throw ArgumentError('No sound files found for folder: $folderPath');
    }
    
    final random = Random();
    final selectedFile = files[random.nextInt(files.length)];
    return 'assets/$folderPath/$selectedFile';
  }
  
  /// Get a random asset from a folder path
  /// 
  /// ⚠️ CRITICAL: This method MUST return paths with 'assets/' prefix!
  /// 
  /// Example: getRandomAsset('images/study-background') 
  /// Returns: 'assets/images/study-background/japanese-garden-4313104_1280.jpg'
  /// 
  /// This matches Flutter web's AssetManifest.json expectations and works for both:
  /// - Local development (flutter run)
  /// - Firebase web deploy (firebase deploy)
  /// 
  /// DO NOT REMOVE THE 'assets/' PREFIX - it will break image loading!
  static String getRandomAsset(String folderPath) {
    final files = AssetPaths.assetMap[folderPath];
    if (files == null || files.isEmpty) {
      throw ArgumentError('No files found for folder: $folderPath');
    }
    
    final random = Random();
    final selectedFile = files[random.nextInt(files.length)];
    // CRITICAL: Always include 'assets/' prefix for Flutter web compatibility
    return 'assets/$folderPath/$selectedFile';
  }
  
  /// Get a random background image path for the given tier
  static String getBackgroundImagePath(Tier tier) {
    return getRandomAsset(AssetPaths.tierBackgrounds[tier]!);
  }
  
  /// Get a random sound path for slash effects
  static String getRandomSlashSound() {
    return getRandomSoundPath(AssetPaths.slashSounds);
  }
  
  /// Get a random BGM path for the given tier
  static String getRandomBgmPath(Tier tier) {
    return getRandomSoundPath(AssetPaths.tierBgm[tier]!);
  }
  
  /// Get campfire BGM path
  static String getCampfireBgmPath() {
    return getRandomSoundPath(AssetPaths.campfireBgm);
  }
  
  /// Get the samurai image path
  static String get samuraiImagePath {
    return getRandomAsset(AssetPaths.samuraiImages);
  }
}