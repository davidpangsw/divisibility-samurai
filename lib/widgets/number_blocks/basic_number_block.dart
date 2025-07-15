import 'package:flutter/material.dart';

class BasicNumberBlock extends StatelessWidget {
  final int number;
  final Color color;

  const BasicNumberBlock({
    super.key,
    required this.number,
    this.color = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFD2B48C), // Light wood color
            Color(0xFFCD853F), // Peru brown
            Color(0xFFA0522D), // Sienna
            Color(0xFF8B4513), // Saddle brown
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        ),
        border: Border.all(color: const Color(0xFF654321), width: 2),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Wood grain effect using multiple gradient overlays
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.brown.withValues(alpha: 0.1),
                  Colors.brown.withValues(alpha: 0.3),
                  Colors.brown.withValues(alpha: 0.1),
                  Colors.brown.withValues(alpha: 0.2),
                ],
                stops: const [0.0, 0.2, 0.6, 1.0],
              ),
            ),
          ),
          // Vertical wood grain lines
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.transparent,
                  Colors.brown.withValues(alpha: 0.2),
                  Colors.transparent,
                  Colors.brown.withValues(alpha: 0.15),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
              ),
            ),
          ),
          // Number text
          Center(
            child: Text(
              '$number',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F1B14), // Dark brown text
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    color: Colors.black26,
                    blurRadius: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}