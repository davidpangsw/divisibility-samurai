import 'dart:math';
import '../configs/asset_paths.dart';
import '../configs/tier.dart';

/// Centralized asset management to handle Flutter's inconsistent asset loading
/// between local development and web builds, and avoid the assets/assets/ bug
class AssetManager {
  
  /// Get a random asset from a folder path
  /// 
  /// Example: getRandomAsset('images/study-background') returns a random file from that folder
  static String getRandomAsset(String folderPath) {
    final files = AssetPaths.assetMap[folderPath];
    if (files == null || files.isEmpty) {
      throw ArgumentError('No files found for folder: $folderPath');
    }
    
    final random = Random();
    final selectedFile = files[random.nextInt(files.length)];
    return 'assets/$folderPath/$selectedFile';
  }
  
  /// Get a random asset path for Image.asset() widget
  /// 
  /// Handles different path requirements for web vs local development
  static String getRandomImageAsset(String folderPath) {
    final files = AssetPaths.assetMap[folderPath];
    if (files == null || files.isEmpty) {
      throw ArgumentError('No files found for folder: $folderPath');
    }
    
    final random = Random();
    final selectedFile = files[random.nextInt(files.length)];
    
    // For web builds, Image.asset() needs the assets/ prefix
    // For local development, it works both ways but assets/ prefix is safer
    return 'assets/$folderPath/$selectedFile';
  }
  
  /// Get a random background image path for the given tier
  static String getBackgroundImagePath(Tier tier) {
    return getRandomImageAsset(AssetPaths.tierBackgrounds[tier]!);
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
    return getRandomImageAsset(AssetPaths.samuraiImages);
  }
}