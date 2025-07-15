import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../../configs/config.dart';
import '../../configs/game_level.dart';
import '../../view_models/game_view_model.dart';
import '../number_blocks/animated_number_block_model.dart';
import '../../utils/physics_engine.dart';
import '../../utils/rectangle.dart';
import 'block_factory.dart';
import 'block_area.dart';

class PlayArea extends StatefulWidget {
  const PlayArea({super.key});

  @override
  State<PlayArea> createState() => _PlayAreaState();
}

class _PlayAreaState extends State<PlayArea> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late PhysicsEngine _physicsEngine;
  final List<AnimatedNumberBlock> _blocks = [];
  int _frameCounter = 0;
  static final int _blockGenerationInterval = (Config.blockGenerationInterval.inMilliseconds / (1000 / 60)).round();
  static const Rectangle _playAreaRectangle = Rectangle(Config.playAreaWidth, Config.playAreaHeight);
  static const Rectangle _blockRectangle = Rectangle(Config.numberBlockWidth, Config.numberBlockHeight);

  @override
  void initState() {
    super.initState();
    
    _physicsEngine = PhysicsEngine(
      playAreaRectangle: _playAreaRectangle,
      blockRectangle: _blockRectangle,
      bounceDamping: Config.bounceDamping,
    );
    
    _animationController = AnimationController(
      duration: const Duration(seconds: 60),
      vsync: this,
    )..repeat();
    
    _animationController.addListener(_updatePhysics);
    // Don't auto-generate blocks, wait for game to start
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _tryGenerateBlock() {
    final gameViewModel = Provider.of<GameViewModel>(context, listen: false);
    
    // Only generate blocks if game is active
    if (!gameViewModel.isGameActive) return;
    
    // Simple random generation up to max limit
    if (_blocks.length < Config.maxNumberBlocksInPlayArea && 
        Random().nextDouble() < Config.blockGenerationChance) {
      final gameLevel = GameLevel.getLevel(gameViewModel.gameState.level);
      final block = BlockFactory.createBlock(gameLevel.divisor, gameViewModel.gameState.level);
      
      setState(() {
        _blocks.add(block);
      });
    }
  }

  void _updatePhysics() {
    final gameViewModel = Provider.of<GameViewModel>(context, listen: false);
    final currentLevel = gameViewModel.gameState.level;
    final gameLevel = GameLevel.getLevel(currentLevel);
    const double deltaTime = Config.deltaTime;
    
    setState(() {
      // Update physics for each block and mark for removal if needed
      for (final block in _blocks) {
        if (!block.isRemoved) {
          // Update physics only for non-removed blocks
          final (newPosition, newVelocity) = _physicsEngine.updateSingleBlock(
            block.position, 
            block.velocity,
            gameLevel.gravity,
            deltaTime
          );
          block.position = newPosition;
          block.velocity = newVelocity;
          
          // Check if block fell off screen
          if (block.position.y > _playAreaRectangle.height) {
            block.isRemoved = true;
            // Notify game view model only if a CORRECT block disappeared
            if (block.isCorrect) {
              final gameViewModel = Provider.of<GameViewModel>(context, listen: false);
              gameViewModel.onCorrectBlockDisappeared();
            }
          }
        }
      }
      
      // Remove blocks that are marked as removed and not animating
      _blocks.removeWhere((block) => block.isRemoved && !block.isAnimating);
      
      // Increment frame counter and try to generate blocks periodically
      _frameCounter++;
      if (_frameCounter >= _blockGenerationInterval) {
        _frameCounter = 0;
        _tryGenerateBlock();
      }
    });
  }

  void stopAllAnimationsAndClearBlocks() {
    // Stop the physics animation controller to prevent new block generation
    _animationController.stop();
    
    setState(() {
      _blocks.clear();
    });
  }

  void resumeGame() {
    // Restart the physics animation controller
    _animationController.repeat();
  }

  void _handleBlockSlashed(AnimatedNumberBlock block) {
    final gameViewModel = Provider.of<GameViewModel>(context, listen: false);
    
    // Only process if game is active
    if (!gameViewModel.isGameActive) return;
    
    // Mark block as removed and animating
    block.isRemoved = true;
    block.isAnimating = true;
    
    // Notify game view model about the slash
    gameViewModel.onBlockSlashed(block.isCorrect, block.number);
    
    // Mark animation as done after duration
    // mounted check ensures widget hasn't been disposed
    Future.delayed(Config.blockCleanupDelay, () {
      if (mounted) {
        setState(() {
          block.isAnimating = false;
        });
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    final gameViewModel = Provider.of<GameViewModel>(context, listen: false);
    final currentLevel = gameViewModel.gameState.level;
    final gameLevel = GameLevel.getLevel(currentLevel);
    
    return SizedBox(
      width: _playAreaRectangle.width,
      height: _playAreaRectangle.height,
      child: BlockArea(
        areaRectangle: _playAreaRectangle,
        blockRectangle: _blockRectangle,
        blocks: _blocks,
        applyPhysics: false, // Physics handled by _updatePhysics
        physicsEngine: _physicsEngine,
        gravity: gameLevel.gravity,
        onBlockSlashed: _handleBlockSlashed,
      ),
    );
  }
}