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
  static final int _blockGenerationInterval = (Config.blockGenerationIntervalMs / (1000 / 60)).round(); // Convert ms to frames at 60fps

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 60),
      vsync: this,
    )..repeat();
    
    _animationController.addListener(_updatePhysics);
    // Start with one block
    _tryGenerateBlock();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _tryGenerateBlock() {
    // Generate blocks up to max limit, with higher chance when fewer blocks exist
    if (_blocks.length < Config.maxNumberBlocksInPlayArea) {
      // Always generate if no blocks exist, otherwise use chance
      bool shouldGenerate = _blocks.isEmpty || Random().nextDouble() < Config.blockGenerationChance;
      
      if (shouldGenerate) {
        final gameViewModel = Provider.of<GameViewModel>(context, listen: false);
        final block = BlockFactory.createBlock(gameViewModel.gameState.divisor);
        
        setState(() {
          _blocks.add(block);
        });
      }
    }
  }

  void _updatePhysics() {
    setState(() {
      PhysicsEngine.updatePhysics(_blocks);
      
      // Remove blocks that have fallen below the play area
      for (int i = _blocks.length - 1; i >= 0; i--) {
        if (PhysicsEngine.shouldRemoveBlock(_blocks[i])) {
          _blocks.removeAt(i);
        }
      }
      
      // Increment frame counter and try to generate blocks periodically
      _frameCounter++;
      if (_frameCounter >= _blockGenerationInterval) {
        _frameCounter = 0;
        _tryGenerateBlock();
      }
    });
  }

  void _removeBlock(AnimatedNumberBlock block) {
    setState(() {
      _blocks.remove(block);
      // Don't immediately generate a new block - let the timer handle it
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
            left: block.x,
            top: block.y,
            child: NumberBlock(
              number: block.number,
              isCorrect: block.isCorrect,
              onSlashed: () {
                if (!block.isAnimating) {
                  block.isAnimating = true;
                  // Notify game view model about the slash
                  final gameViewModel = Provider.of<GameViewModel>(context, listen: false);
                  gameViewModel.onBlockSlashed(block.isCorrect);
                  // Remove block after animation duration
                  Future.delayed(Duration(milliseconds: Config.numberBlockAnimationDurationMs), () {
                    if (mounted) {
                      _removeBlock(block);
                    }
                  });
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}