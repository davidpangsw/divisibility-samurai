# Divisibility Samurai - Project Summary

## Project Status: MAINTENANCE MODE ✅

This Flutter web math game is now in a stable, well-architected state with excellent code organization and maintainability.

## What You Need to Tell Claude Next Time

> **"This is the Divisibility Samurai Flutter web game project. Read the CLAUDE.md file for complete project context, then read this PROJECT_SUMMARY.md file to understand what was accomplished and the current architecture. The project is in maintenance mode with clean, well-organized code."**

## Recent Session Accomplishments (Phase 22-23)

### Phase 22: Lazy Loading Implementation ✅
- **Native Splash Screen**: Implemented with samurai image and spinning circle
- **Progressive Asset Loading**: Images, sounds, and music loaded efficiently
- **Web Performance**: Optimized for slow networks with proper loading states
- **Flutter Web Compatibility**: Solved asset loading issues between dev and production

### Phase 23: UI/UX Improvements ✅
- **Responsive Design**: Fixed BasicNumberBlock layout for small screens (vertical layout)
- **Enhanced Help System**: 
  - Changed help button to "How To Play"
  - Added How To Play button to start screen
  - Used BasicNumberBlock for dividend display in hints
- **Code Organization**: Refactored game overlays into modular components
- **Sound Architecture**: Completely refactored to follow proper separation of concerns

## Current Architecture Excellence

### 1. Sound Management Architecture (CRITICAL)
```
Widget Layer → GameViewModel → GameStateViewModel (with callbacks) → SoundManager
```
- **✅ Single Responsibility**: Only GameViewModel touches SoundManager
- **✅ Loose Coupling**: GameStateViewModel accepts sound functions as parameters
- **✅ Testable**: Easy to mock sound functionality
- **✅ Maintainable**: Changes isolated to GameViewModel

### 2. Widget Architecture
```
Homepage (ChangeNotifierProvider) → GameWidget → Components
├── SettingsButton (requires GameViewModel)
├── HelpButton (standalone)
├── AboutButton (standalone)
└── GameOverlays (modular components)
```

### 3. Game Overlay Refactoring
```
lib/widgets/game_widget/game_overlays/
├── start_game_overlay.dart
├── level_transition_overlay.dart
├── tier_transition_overlay.dart
└── game_overlays.dart (barrel export)
```

## Key Files & Responsibilities

### Core Architecture
- **`lib/view_models/game_view_model.dart`**: Central orchestrator, only ChangeNotifier
- **`lib/view_models/game_state_view_model.dart`**: Pure model, no external dependencies
- **`lib/utils/sound_manager.dart`**: Sound implementation (only accessed by GameViewModel)

### Asset Management (CRITICAL - DO NOT MODIFY)
- **`lib/utils/asset_manager.dart`**: THE ONLY place for asset paths
- **`lib/configs/asset_paths.dart`**: Asset declarations
- **⚠️ WARNING**: AssetManager.getRandomAsset() works for both dev and production

### UI Components
- **`lib/widgets/homepage.dart`**: Root with ChangeNotifierProvider
- **`lib/widgets/game_widget/game_widget.dart`**: Main game container
- **`lib/widgets/number_blocks/basic_number_block.dart`**: **DO NOT MODIFY** - Wood texture styling
- **`lib/widgets/help_dialog/`**: Modular help system with BasicNumberBlock integration

## Critical Development Rules

### 1. Sound Management
- **✅ DO**: Use GameViewModel methods for all sound operations
- **❌ DON'T**: Call SoundManager directly from widgets or other ViewModels
- **Pattern**: Pass sound functions as parameters to GameStateViewModel methods

### 2. Asset Management
- **✅ DO**: Always use AssetManager methods for asset paths
- **❌ DON'T**: Hardcode asset paths or bypass AssetManager
- **⚠️ CRITICAL**: Don't modify AssetManager.getRandomAsset() without extreme care

### 3. BasicNumberBlock Usage
- **✅ DO**: Use BasicNumberBlock as-is for consistent wood texture styling
- **❌ DON'T**: Modify the BasicNumberBlock class itself
- **Pattern**: Wrap in BlockArea with same-sized rectangle for proper display

## Game Structure Overview

### Tiers & Levels
- **📚 Study**: 9 levels, divisors 2-12, numbers 1-50
- **🥉 Bronze**: 9 levels, divisors 2-12, numbers 10-99
- **🥈 Silver**: 9 levels, divisors 2-12, numbers 100-999
- **🥇 Gold**: 9 levels, divisors 2-12, numbers 1000-9999

### Physics System
- **Fixed PlayArea**: 360x480 for mobile/web compatibility
- **Tier-based Gravity**: Study (250) → Bronze (200) → Silver (150) → Gold (100)
- **60 FPS Game Loop**: Smooth animations with delta time calculations

## Deployment
```bash
firebase deploy
```
- Auto-builds before deploy (configured in firebase.json)
- No manual build steps needed

## Common Issues & Solutions

### 1. Asset Loading Problems
- **Issue**: Assets not loading in production
- **Solution**: Use AssetManager methods, never hardcode paths

### 2. Sound Not Working
- **Issue**: Sound management scattered across components
- **Solution**: All sound calls must go through GameViewModel

### 3. BasicNumberBlock Layout Issues
- **Issue**: Numbers not displaying correctly
- **Solution**: Wrap in BlockArea with proper Rectangle dimensions

## Future Development Guidelines

1. **Architecture**: Maintain the current sound management pattern
2. **Testing**: GameViewModel methods are now easily mockable
3. **Features**: Add new functionality through GameViewModel
4. **UI**: Use existing component patterns and BasicNumberBlock styling
5. **Performance**: Maintain 60 FPS with current physics system

## Project Health: EXCELLENT ✅

The codebase is now in excellent condition with:
- **Clean Architecture**: Proper separation of concerns
- **Maintainable Code**: Well-organized, modular components
- **Good Performance**: Optimized for web deployment
- **Consistent Styling**: Unified samurai theme throughout
- **Robust Error Handling**: Graceful fallbacks for asset loading

---

**Next Session Context**: This project has clean, well-architected code following Flutter best practices. The sound management architecture is exemplary and should be maintained. All major technical debt has been resolved.