import 'package:flutter/material.dart';
import '../../utils/vector.dart';
import '../../configs/config.dart';

class AnimatedNumberBlock {
  final int number;
  final bool isCorrect;
  final String id;
  Vector position;
  Vector velocity;
  bool isRemoved = false; // Block is logically removed
  bool isAnimating = false; // Block is playing animation
  
  AnimatedNumberBlock({
    required this.number,
    required this.isCorrect,
    required double x,
    required double y,
    required double velocityX,
    required double velocityY,
  }) : position = Vector(x, y),
       velocity = Vector(velocityX, velocityY),
       id = '${number}_${DateTime.now().millisecondsSinceEpoch}_${x.toStringAsFixed(1)}';
  
  // Convenience getters for backward compatibility
  double get x => position.x;
  double get y => position.y;
  double get velocityX => velocity.x;
  double get velocityY => velocity.y;

  // Check if the block contains the given offset
  bool isContain(Offset offset) {
    return offset.dx >= position.x &&
           offset.dx <= position.x + Config.numberBlockWidth &&
           offset.dy >= position.y &&
           offset.dy <= position.y + Config.numberBlockHeight;
  }
}