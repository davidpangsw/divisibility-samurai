import 'package:flutter/material.dart';
import 'dart:math';
import '../../configs/config.dart';
import '../number_blocks/number_block.dart';

class AnimatedNumberBlock {
  final int number;
  final bool isCorrect;
  double x;
  double y;
  double velocityX;
  double velocityY;
  bool isAnimating = false;
  
  AnimatedNumberBlock({
    required this.number,
    required this.isCorrect,
    required this.x,
    required this.y,
    required this.velocityX,
    required this.velocityY,
  });
}

class PlayArea extends StatefulWidget {
  const PlayArea({super.key});

  @override
  State<PlayArea> createState() => _PlayAreaState();
}

class _PlayAreaState extends State<PlayArea> with TickerProviderStateMixin {
  late AnimationController _animationController;
  final List<AnimatedNumberBlock> _blocks = [];
  final Random _random = Random();
  
  static const double gravity = 500.0; // pixels per second squared
  static const double bounceDamping = 0.8;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 60),
      vsync: this,
    )..repeat();
    
    _animationController.addListener(_updatePhysics);
    _generateNumberBlock();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _generateNumberBlock() {
    if (_blocks.length < Config.maxNumberBlocksInPlayArea) {
      final number = Config.minNumber + _random.nextInt(Config.maxNumber - Config.minNumber + 1);
      final divisor = 3; // Using divisor 3 for now
      final isCorrect = number % divisor == 0;
      
      final block = AnimatedNumberBlock(
        number: number,
        isCorrect: isCorrect,
        x: _random.nextDouble() * (Config.playAreaWidth - Config.numberBlockWidth),
        y: Config.playAreaHeight - Config.numberBlockHeight,
        velocityX: (_random.nextDouble() - 0.5) * 200, // -100 to 100 pixels/second
        velocityY: -450 - _random.nextDouble() * 180, // -450 to -630 pixels/second (upper half to top)
      );
      
      setState(() {
        _blocks.add(block);
      });
    }
  }

  void _updatePhysics() {
    const deltaTime = 1.0 / 60.0; // 60 FPS
    
    setState(() {
      for (int i = _blocks.length - 1; i >= 0; i--) {
        final block = _blocks[i];
        
        // Skip physics if block is animating
        if (block.isAnimating) continue;
        
        // Apply gravity
        block.velocityY += gravity * deltaTime;
        
        // Update position
        block.x += block.velocityX * deltaTime;
        block.y += block.velocityY * deltaTime;
        
        // Bounce off left/right edges
        if (block.x <= 0) {
          block.x = 0;
          block.velocityX = -block.velocityX * bounceDamping;
        } else if (block.x >= Config.playAreaWidth - Config.numberBlockWidth) {
          block.x = Config.playAreaWidth - Config.numberBlockWidth;
          block.velocityX = -block.velocityX * bounceDamping;
        }
        
        // Remove block if it drops below bottom
        if (block.y > Config.playAreaHeight) {
          _blocks.removeAt(i);
          _generateNumberBlock();
        }
      }
    });
  }

  void _removeBlock(AnimatedNumberBlock block) {
    setState(() {
      _blocks.remove(block);
      _generateNumberBlock();
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
            child: MouseRegion(
              onEnter: (_) {
                if (!block.isAnimating) {
                  block.isAnimating = true;
                  // Remove block after animation duration
                  Future.delayed(const Duration(milliseconds: 400), () {
                    if (mounted) {
                      _removeBlock(block);
                    }
                  });
                }
              },
              child: NumberBlock(
                number: block.number,
                isCorrect: block.isCorrect,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}