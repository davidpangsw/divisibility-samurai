# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter math game called "Divisibility Samurai" where players identify numbers divisible by given divisors. Numbers appear as blocks with physics-based movement in a fixed PlayArea. Players "slash" correct numbers to score points and progress through tiers and levels.

## Game Structure

### Tier System (36 Total Levels)
- **📚 Study Tier**: 9 levels, divisors 2-12, numbers 1-50 range (varies by divisor)
- **🥉 Bronze Tier**: 9 levels, divisors 2-12, numbers 10-99 (2-digit)
- **🥈 Silver Tier**: 9 levels, divisors 2-12, numbers 100-999 (3-digit) 
- **🥇 Gold Tier**: 9 levels, divisors 2-12, numbers 1000-9999 (4-digit)

### Physics System
- Tier-based gravity: Study (250) → Bronze (200) → Silver (150) → Gold (100)
- Calculated velocities for 50-80% screen height reach
- Fixed PlayArea: 360x480 for mobile/web compatibility
- Block bounce physics with boundary collision detection

## Architecture

### View Models (lib/view_models/)
- **GameViewModel**: Only ChangeNotifier, controls game lifecycle with 60 FPS game loop
- **GameStateViewModel**: Game state management (scores, lives, tier/level progression)

### Core Game Components (lib/widgets/game_widget/)
- **GameWidget**: Main game container with StatsBar and PlayArea
- **PlayArea**: Fixed-size physics area with block movement
- **StatsBar**: Displays current tier, level, score, lives, progress
- **BlockFactory**: Intelligent number generation with configurable correct/incorrect ratios
- **PhysicsEngine**: Centralized 2D physics calculations with Vector math

### Number Block System (lib/widgets/number_blocks/)
- **NumberBlock**: Static number display component
- **AnimatedNumberBlockModel**: Physics-based block with Vector position/velocity
- **NumberBlockAnimation**: Base class for block animations
- **CorrectNumberBlockAnimation**: Green checkmark effect for correct answers
- **WrongNumberBlockAnimation**: Red X effect for wrong answers

### UI Components (lib/widgets/)
- **Homepage**: Game title with AppBar containing navigation buttons
- **HelpButton/HelpDialog**: Comprehensive game rules with samurai theming
- **SettingsButton/SettingsDialog**: Volume controls for BGM/SFX with localStorage persistence
- **AboutButton/AboutDialog**: Sound/music attributions with external links
- **GameResultDialog**: End-game statistics with screenshot download functionality

### Sound System (lib/utils/sound_manager.dart)
- **Tier-based BGM**: Different background music for Study/Bronze/Silver/Gold/Campfire
- **Slash SFX**: Random sound effects for block interactions
- **Volume Controls**: Separate BGM/SFX volume with browser localStorage
- **Web Compliance**: User interaction detection for audio playback

### Utilities (lib/utils/)
- **Vector**: 2D physics calculations for position/velocity/acceleration
- **Line**: Slashing animation paths with `randomSlashing()` and `evaluate(t)`
- **SoundManager**: Audio system management with web browser integration
- **AssetManager**: Centralized asset path management for Flutter web compatibility

### Configuration (lib/configs/)
- **config.dart**: Tier-based game parameters (gravity, number ranges, physics constants)
- **asset_paths.dart**: Centralized asset path configuration with folder-to-file mappings
- **tier.dart**: Tier enum with embedded name and emoji properties
- **game_level.dart**: Level progression and tier management

## Game Mechanics

### Core Gameplay
- **Lives**: 10 total, lose 1 for incorrect slashes
- **Level Progression**: Complete 10 correct blocks per level
- **Tier Progression**: Complete all 9 levels to advance tier
- **Block Management**: Max 3 blocks on screen, configurable spawn timing

### Scoring & Analytics
- **Score Tracking**: Points per correct answer
- **Statistics**: Track answers by level with emoji indicators (✅❌)
- **Screenshots**: Auto-download game results for sharing
- **Answer History**: Comprehensive tracking of right/wrong answers per level

### Audio Integration
- **Background Music**: Tier-appropriate BGM with smooth transitions
- **Sound Effects**: Random slash sounds for tactile feedback
- **Settings**: Persistent volume controls stored in browser localStorage

## Technical Implementation

### State Management
- **Single ChangeNotifier**: GameViewModel handles all state changes
- **Game States**: notStarted, playing, paused, levelCompleted, tierCompleted, gameWon, gameLost
- **Physics Integration**: 60 FPS delta time calculations for smooth animations

### Web Optimization
- **Fixed Dimensions**: Optimized for mobile viewport (360x480)
- **Asset Management**: Proper Flutter web asset compilation
- **Browser Features**: localStorage for settings, download API for screenshots
- **Audio Handling**: HTML AudioElement with user interaction compliance

### Animation System
- **Physics-Based**: All movements use delta time calculations
- **Modular Design**: Separate animation classes for different effects
- **Custom Painters**: Line drawing for slash effects
- **Smooth Transitions**: Tier progression with appropriate visual feedback

## Asset Management System

### Critical Asset Path Handling
The AssetManager class in `lib/utils/asset_manager.dart` is the ONLY place that should handle asset path construction. This system was created to solve Flutter web's inconsistent asset loading between local development and production builds.

**⚠️ WARNING: DO NOT MODIFY AssetManager.getRandomAsset() WITHOUT EXTREME CARE**

The current implementation works for both:
- Local development (`flutter run`)
- Firebase web deployment (`firebase deploy`)

### How It Works
1. **AssetPaths Configuration** (`lib/configs/asset_paths.dart`):
   - Maps folder paths to file lists: `'images/samurai' -> ['file1.png', 'file2.png']`
   - Centralizes all asset declarations in one place
   - Must be updated when adding new asset files

2. **AssetManager Methods** (`lib/utils/asset_manager.dart`):
   - `getRandomAsset(folderPath)`: Returns `'assets/folderPath/randomFile'` with assets/ prefix
   - All image and sound methods use this single method for consistency
   - **ALWAYS** includes `assets/` prefix to match Flutter web's AssetManifest.json

3. **Usage Pattern**:
   ```dart
   // Background images
   AssetManager.getBackgroundImagePath(Tier.study) 
   // Returns: 'assets/images/study-background/japanese-garden-4313104_1280.jpg'
   
   // Samurai images (now includes 5 images for variety)
   AssetManager.samuraiImagePath
   // Returns: 'assets/images/samurai/[random_samurai_image]'
   ```

### Asset File Organization
```
assets/
├── images/
│   ├── study-background/      # Study tier backgrounds
│   ├── bronze-background/     # Bronze tier backgrounds  
│   ├── silver-background/     # Silver tier backgrounds
│   ├── gold-background/       # Gold tier backgrounds
│   └── samurai/              # Samurai character images (5 total)
└── sounds/
    ├── effects/slash/        # Slash sound effects
    └── music/               # Tier-based background music
```

### Samurai Images Enhancement
- Added 4 new PNG images: `9x16_Create_a_5_second_2D_cartoon_ani_00-03.png`
- AssetManager randomly selects from all 5 samurai images for variety
- All samurai images properly configured in AssetPaths.assetMap

## Development Guidelines

- **Fixed PlayArea**: Maintain 360x480 dimensions for cross-platform consistency
- **Sound Integration**: Always test audio with user interaction requirements
- **Settings Persistence**: Use localStorage for web, ensure graceful fallbacks
- **Asset Organization**: Follow tier-based structure for audio/visual assets
- **Performance**: Maintain 60 FPS with efficient physics calculations
- **Asset Management**: NEVER bypass AssetManager - always use its methods for asset paths
- **BasicNumberBlock**: NEVER modify BasicNumberBlock class - use it exactly as-is

## Sound Management Architecture (CRITICAL)

**⚠️ IMPORTANT**: This project follows a strict sound management hierarchy that must be maintained:

```
Widget Layer → GameViewModel → GameStateViewModel (with callbacks) → SoundManager
```

### Rules:
1. **Only GameViewModel** should directly call SoundManager methods
2. **Widgets** should call GameViewModel sound methods (setBgmVolume, setSfxVolume, etc.)
3. **GameStateViewModel** accepts sound functions as parameters (onPlaySlashSound, onPlayBgmForTier, etc.)
4. **Never** call SoundManager directly from widgets or other ViewModels

### Implementation Pattern:
```dart
// In GameViewModel
void playSlashSound() => SoundManager.playSlashSound();

// In GameStateViewModel  
void increaseScore(int number, {Function? onPlaySlashSound}) {
  // game logic
  onPlaySlashSound?.call();
}

// In Widget
gameViewModel.setBgmVolume(0.5); // ✅ Correct
SoundManager.setBgmVolume(0.5);  // ❌ Wrong
```

## Project Status: MAINTENANCE MODE

This project is in excellent condition with clean architecture, proper separation of concerns, and optimized performance. All major technical debt has been resolved.

## Deployment

Firebase is configured with a predeploy hook to automatically build before deployment:

```bash
firebase deploy
```

- Automatically runs `flutter build web` before deploy
- Configured in `firebase.json` with `"predeploy": ["flutter build web"]`
- Ensures you never deploy stale builds
- No need for manual build steps or custom scripts