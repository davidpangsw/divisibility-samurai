import '../../utils/vector.dart';

class AnimatedNumberBlock {
  final int number;
  final bool isCorrect;
  final String id;
  Vector position;
  Vector velocity;
  bool isRemoved = false; // Block is logically removed
  bool isAnimating = false; // Block is playing animation
  bool hasBeenCounted = false; // Track if block has been counted for disappearing
  
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
}