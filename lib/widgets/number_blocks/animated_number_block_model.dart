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