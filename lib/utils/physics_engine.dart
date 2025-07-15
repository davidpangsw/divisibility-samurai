import '../../utils/vector.dart';
import '../../utils/rectangle.dart';

class PhysicsEngine {
  final Rectangle playAreaRectangle;
  final Rectangle blockRectangle;
  final double bounceDamping;

  PhysicsEngine({
    required this.playAreaRectangle,
    required this.blockRectangle,
    required this.bounceDamping,
  });

  /// Updates physics for a single block
  /// Returns new position and velocity after physics calculations
  (Vector position, Vector velocity) updateSingleBlock(
    Vector position, 
    Vector velocity,
    double gravity,
    double deltaTime
  ) {
    // Apply gravity
    final newVelocity = velocity + Vector(0, gravity * deltaTime);
    
    // Update position
    var newPosition = position + (newVelocity * deltaTime);
    var finalVelocity = newVelocity;
    
    // Bounce off left/right edges
    if (newPosition.x <= 0) {
      newPosition = Vector(0, newPosition.y);
      finalVelocity = Vector(-finalVelocity.x * bounceDamping, finalVelocity.y);
    } else if (newPosition.x >= playAreaRectangle.width - blockRectangle.width) {
      newPosition = Vector(playAreaRectangle.width - blockRectangle.width, newPosition.y);
      finalVelocity = Vector(-finalVelocity.x * bounceDamping, finalVelocity.y);
    }
    
    return (newPosition, finalVelocity);
  }
}