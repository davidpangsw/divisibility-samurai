import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../../configs/config.dart';
import '../../view_models/game_view_model.dart';
import '../number_blocks/number_block.dart';
import '../number_blocks/animated_number_block_model.dart';
import 'physics_engine.dart';
import 'block_factory.dart';

class PlayArea extends StatefulWidget {
  const PlayArea({super.key});

  @override
  State<PlayArea> createState() => _PlayAreaState();
}

class _PlayAreaState extends State<PlayArea> with TickerProviderStateMixin {
  late AnimationController _animationController;
  final List<AnimatedNumberBlock> _blocks = [];
  int _frameCounter = 0;
  static final int _blockGenerationInterval = (Config.blockGenerationInterval.inMilliseconds / (1000 / 60)).round();

  @override
  void initState() {
    super.initState();
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
      final block = BlockFactory.createBlock(gameViewModel.gameState.divisor, gameViewModel.gameState.level);
      
      setState(() {
        _blocks.add(block);
      });
    }
  }

  void _updatePhysics() {
    final gameViewModel = Provider.of<GameViewModel>(context, listen: false);
    final currentLevel = gameViewModel.gameState.level;
    final gravity = Config.getGravityForLevel(currentLevel);
    
    setState(() {
      // Update physics for each block and mark for removal if needed
      for (final block in _blocks) {
        if (!block.isRemoved) {
          // Update physics only for non-removed blocks
          final (newPosition, newVelocity) = PhysicsEngine.updateSingleBlock(
            block.position, 
            block.velocity,
            gravity
          );
          block.position = newPosition;
          block.velocity = newVelocity;
          
          // Check if block fell off screen
          if (PhysicsEngine.shouldRemoveBlock(block.position)) {
            block.isRemoved = true;
            // Notify game view model only if a CORRECT block disappeared (only once per block)
            if (!block.hasBeenCounted && block.isCorrect) {
              block.hasBeenCounted = true;
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
    
    block.isRemoved = true;
    block.isAnimating = true;
    block.hasBeenCounted = true; // Mark as counted to prevent double-counting
    
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
    return Container(
      width: Config.playAreaWidth,
      height: Config.playAreaHeight,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.grey[100],
      ),
      child: Stack(
        children: _blocks.map((block) {
          return Positioned(
            key: ValueKey(block.id), // Preserve widget identity during rebuilds
            left: block.x,
            top: block.y,
            child: NumberBlock(
              key: ValueKey('${block.id}_block'), // Preserve NumberBlock identity
              number: block.number,
              isCorrect: block.isCorrect,
              onSlashed: () => _handleBlockSlashed(block),
            ),
          );
        }).toList(),
      ),
    );
  }
}