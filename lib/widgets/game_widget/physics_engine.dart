import '../../configs/config.dart';
import '../../utils/vector.dart';

class PhysicsEngine {
  static const double deltaTime = 1.0 / 60.0; // 60 FPS

  /// Updates physics for a single block
  /// Returns new position and velocity after physics calculations
  static (Vector position, Vector velocity) updateSingleBlock(
    Vector position, 
    Vector velocity
  ) {
    // Apply gravity
    final newVelocity = velocity + Vector(0, Config.gravity * deltaTime);
    
    // Update position
    var newPosition = position + (newVelocity * deltaTime);
    var finalVelocity = newVelocity;
    
    // Bounce off left/right edges
    if (newPosition.x <= 0) {
      newPosition = Vector(0, newPosition.y);
      finalVelocity = Vector(-finalVelocity.x * Config.bounceDamping, finalVelocity.y);
    } else if (newPosition.x >= Config.playAreaWidth - Config.numberBlockWidth) {
      newPosition = Vector(Config.playAreaWidth - Config.numberBlockWidth, newPosition.y);
      finalVelocity = Vector(-finalVelocity.x * Config.bounceDamping, finalVelocity.y);
    }
    
    return (newPosition, finalVelocity);
  }

  /// Checks if a block should be removed (fell below play area)
  static bool shouldRemoveBlock(Vector position) {
    return position.y > Config.playAreaHeight;
  }
}