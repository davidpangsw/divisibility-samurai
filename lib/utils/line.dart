import 'dart:math';

class Line {
  final double x1;
  final double y1;
  final double x2;
  final double y2;

  Line(this.x1, this.y1, this.x2, this.y2);

  factory Line.randomSlashing(double width, double height) {
    final random = Random();
    
    // Select one of the four corners randomly
    final corner = random.nextInt(4);
    final oppositeCorner = (corner + 2) % 4;
    
    // Generate start and end points
    final (startX, startY) = _randomPointNearCorner(corner, width, height, random);
    final (endX, endY) = _randomPointNearCorner(oppositeCorner, width, height, random);
    
    return Line(startX, startY, endX, endY);
  }

  static (double, double) _randomPointNearCorner(int corner, double width, double height, Random random) {
    switch (corner) {
      case 0: // Top-left
        return random.nextBool()
            ? (random.nextDouble() * (width / 2), 0.0) // Top edge
            : (0.0, random.nextDouble() * (height / 2)); // Left edge
      case 1: // Top-right
        return random.nextBool()
            ? (width / 2 + random.nextDouble() * (width / 2), 0.0) // Top edge
            : (width, random.nextDouble() * (height / 2)); // Right edge
      case 2: // Bottom-left
        return random.nextBool()
            ? (random.nextDouble() * (width / 2), height) // Bottom edge
            : (0.0, height / 2 + random.nextDouble() * (height / 2)); // Left edge
      case 3: // Bottom-right
        return random.nextBool()
            ? (width / 2 + random.nextDouble() * (width / 2), height) // Bottom edge
            : (width, height / 2 + random.nextDouble() * (height / 2)); // Right edge
      default:
        return (0.0, 0.0);
    }
  }

  (double, double) evaluate(double t) {
    final x = x1 + (x2 - x1) * t;
    final y = y1 + (y2 - y1) * t;
    return (x, y);
  }
}