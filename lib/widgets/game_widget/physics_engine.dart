import '../../configs/config.dart';
import '../number_blocks/animated_number_block_model.dart';

class PhysicsEngine {
  static const double deltaTime = 1.0 / 60.0; // 60 FPS

  static void updatePhysics(List<AnimatedNumberBlock> blocks) {
    for (int i = blocks.length - 1; i >= 0; i--) {
      final block = blocks[i];
      
      // Skip physics if block is animating
      if (block.isAnimating) continue;
      
      // Apply gravity
      block.velocityY += Config.gravity * deltaTime;
      
      // Update position
      block.x += block.velocityX * deltaTime;
      block.y += block.velocityY * deltaTime;
      
      // Bounce off left/right edges
      if (block.x <= 0) {
        block.x = 0;
        block.velocityX = -block.velocityX * Config.bounceDamping;
      } else if (block.x >= Config.playAreaWidth - Config.numberBlockWidth) {
        block.x = Config.playAreaWidth - Config.numberBlockWidth;
        block.velocityX = -block.velocityX * Config.bounceDamping;
      }
    }
  }

  static bool shouldRemoveBlock(AnimatedNumberBlock block) {
    return block.y > Config.playAreaHeight;
  }
}