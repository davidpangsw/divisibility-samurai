import 'dart:math';
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
    return getRandomAsset(AssetPaths.slashSounds);
  }
  
  /// Get a random BGM path for the given tier
  static String getRandomBgmPath(Tier tier) {
    return getRandomAsset(AssetPaths.tierBgm[tier]!);
  }
  
  /// Get campfire BGM path
  static String getCampfireBgmPath() {
    return getRandomAsset(AssetPaths.campfireBgm);
  }
  
  /// Get the samurai image path
  static String get samuraiImagePath {
    return getRandomAsset(AssetPaths.samuraiImages);
  }
}