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

### Configuration (lib/configs/config.dart)
- Tier-based game parameters (gravity, number ranges, physics constants)
- Audio asset paths organized by categories (BGM tiers, SFX)
- All configurable game mechanics (lives, block limits, scoring)

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

## Development Guidelines

- **Fixed PlayArea**: Maintain 360x480 dimensions for cross-platform consistency
- **Sound Integration**: Always test audio with user interaction requirements
- **Settings Persistence**: Use localStorage for web, ensure graceful fallbacks
- **Asset Organization**: Follow tier-based structure for audio/visual assets
- **Performance**: Maintain 60 FPS with efficient physics calculations