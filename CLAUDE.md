# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter math game where players identify numbers divisible by a given divisor. Numbers appear as blocks with physics-based movement (gravity, bouncing) in a fixed PlayArea. Players "slash" correct numbers to score points.

## Development Phases

The project follows a structured phase-based development approach:

1. **Phase 1**: Basic layout with Homepage, HelpButton, and GameWidget placeholder
2. **Phase 2**: GameViewModel (ChangeNotifier) and GameStateViewModel architecture
3. **Phase 3**: NumberBlockViewModel generation with physics movement
4. **Phase 4**: GravityAnimation and NumberBlock UI revamp
5. **Phase 5**: Slashing animation and game logic implementation
6. **Phase 6**: Level progression and win conditions
7. **Phase 7**: Firebase deployment

## Architecture

### View Models (lib/view_models/)
- **GameViewModel**: Only ChangeNotifier in the app, controls game lifecycle and runs fixed-interval game loop calling `gameIteration(timeDelta)`
- **GameStateViewModel**: Contains single game state (scores, lives, level), provides `update(timeDelta)` method, does NOT extend ChangeNotifier
- **NumberBlockViewModel**: Represents individual number blocks with position, velocity, acceleration, and physics calculations

### Widgets (lib/widgets/)
- **Homepage**: Contains game title, HelpButton, and GameWidget
- **GameWidget**: Contains StatsBar and PlayArea with fixed size for mobile/web compatibility
- **PlayArea**: Fixed-size area where number blocks move and bounce
- **NumberBlock**: Static number display without animation or position logic
- **MovingNumberBlock**: Handles movement and reads from NumberBlockViewModel
- **SlashingNumberBlock**: Wraps NumberBlock with slashing animation (3-second line drawing)
- **GravityAnimation**: Animates gravity physics for child widgets
- **HelpDialog**: Organized help content with game rules and examples

### Configuration (lib/configs/)
- **config.dart**: All configurable parameters including game loop interval, max blocks, level thresholds

### Utilities (lib/util/)
- **Line**: Utility for slashing animations with `randomSlashing(width, height)` and `evaluate(t)` methods

## Game Mechanics

- 5 levels with divisors 2-6 (configurable)
- 10 lives total, lose life for incorrect slashes
- 10 correct blocks needed per level (configurable)
- Max 3 blocks on screen simultaneously (configurable)
- Physics: blocks start at bottom with upward velocity + random horizontal component, subject to gravity, bounce off top/left/right edges

## Development Notes

- Game starts automatically, no pause functionality
- Fixed PlayArea size for cross-platform compatibility
- All animations use timeDelta-based physics calculations
- Minimal UI changes between phases - avoid unnecessary features/buttons
- HelpDialog uses divisor=3 examples only for simplicity