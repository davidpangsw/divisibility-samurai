import 'package:flutter/material.dart';
import '../number_blocks/animated_number_block_model.dart';
import '../number_blocks/number_block_animation.dart';
import '../number_blocks/number_block.dart';
import '../../utils/rectangle.dart';
import '../../utils/physics_engine.dart';

class BlockArea extends StatefulWidget {
  final Rectangle areaRectangle;
  final Rectangle blockRectangle;
  final List<AnimatedNumberBlock> blocks;
  final bool applyPhysics;
  final PhysicsEngine? physicsEngine;
  final double? gravity;
  final Function(AnimatedNumberBlock)? onBlockSlashed;

  const BlockArea({
    super.key,
    required this.areaRectangle,
    required this.blockRectangle,
    required this.blocks,
    this.applyPhysics = false,
    this.physicsEngine,
    this.gravity,
    this.onBlockSlashed,
  });

  @override
  State<BlockArea> createState() => _BlockAreaState();
}

class _BlockAreaState extends State<BlockArea> {
  void _handlePointerEvent(PointerEvent event) {
    final localPosition = event.localPosition;
    
    for (final block in widget.blocks) {
      if (block.isContain(localPosition)) {
        _triggerBlockSlash(block);
      }
    }
  }

  void _triggerBlockSlash(AnimatedNumberBlock block) {
    // Skip if block is already removed or animating
    if (block.isRemoved || block.isAnimating) return;
    
    final blockWidget = _findBlockWidget(block);
    if (blockWidget != null) {
      blockWidget.trySlash();
    }
  }

  NumberBlockAnimationState? _findBlockWidget(AnimatedNumberBlock block) {
    final context = this.context;
    NumberBlockAnimationState? foundState;
    
    void visitor(Element element) {
      if (element.widget is NumberBlockAnimation) {
        if (element is StatefulElement) {
          final state = element.state;
          if (state is NumberBlockAnimationState) {
            final blockKey = element.widget.key;
            if (blockKey is ValueKey && blockKey.value.toString().contains(block.id)) {
              foundState = state;
              return;
            }
          }
        }
      }
      element.visitChildren(visitor);
    }
    
    context.visitChildElements(visitor);
    return foundState;
  }

  void _updatePhysics() {
    if (!widget.applyPhysics || widget.physicsEngine == null || widget.gravity == null) {
      return;
    }

    const double deltaTime = 1.0 / 60.0;
    
    for (final block in widget.blocks) {
      if (!block.isRemoved) {
        final (newPosition, newVelocity) = widget.physicsEngine!.updateSingleBlock(
          block.position,
          block.velocity,
          widget.gravity!,
          deltaTime,
        );
        block.position = newPosition;
        block.velocity = newVelocity;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.applyPhysics) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updatePhysics();
      });
    }

    return Listener(
      onPointerDown: _handlePointerEvent,
      onPointerMove: _handlePointerEvent,
      onPointerHover: _handlePointerEvent,
      child: MouseRegion(
        onHover: (event) => _handlePointerEvent(event),
        child: SizedBox(
          width: widget.areaRectangle.width,
          height: widget.areaRectangle.height,
          child: Stack(
            children: widget.blocks.map((block) {
              return Positioned(
                key: ValueKey(block.id),
                left: block.x,
                top: block.y,
                child: NumberBlock(
                  key: ValueKey('${block.id}_block'),
                  number: block.number,
                  isCorrect: block.isCorrect,
                  onSlashed: () => widget.onBlockSlashed?.call(block),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}