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
        color: color,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Center(
        child: Text(
          '$number',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}