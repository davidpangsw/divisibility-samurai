import 'package:flutter/material.dart';

class PartitioningMethodHintCard extends StatelessWidget {
  const PartitioningMethodHintCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        border: Border.all(color: Colors.orange[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Icon(
                Icons.view_module,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Partitioning Method',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Split a number into parts. If each part is divisible by d, then the whole number is divisible by d.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Example: Is 1236 divisible by 3?',
                        style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Split: 1236 = 12 and 36',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 13,
                          fontFamily: 'monospace',
                        ),
                      ),
                      Text(
                        'Check: 3|12 ✓ and 3|36 ✓',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 13,
                          fontFamily: 'monospace',
                        ),
                      ),
                      Text(
                        'Result: 3|1236 ✓',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 13,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Reason: 1236 = 12×100 + 36',
                        style: TextStyle(
                          color: Colors.green[600],
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Important: Is 1335 divisible by 3?',
                        style: TextStyle(
                          color: Colors.orange[800],
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Split: 1335 = 13 and 35',
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontSize: 13,
                          fontFamily: 'monospace',
                        ),
                      ),
                      Text(
                        'Check: 3∤13 ✗ and 3∤35 ✗',
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontSize: 13,
                          fontFamily: 'monospace',
                        ),
                      ),
                      Text(
                        'But actually: 3|1335 ✓ (1+3+3+5=12)',
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontSize: 13,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Converse not true: method failure ≠ not divisible',
                        style: TextStyle(
                          color: Colors.orange[600],
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Why this works:',
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Take 1236 = 12×100 + 36',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 12,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Since 3 divides both 12 and 36, we can take out groups of 3:',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '• From 12: take out 4 groups of 3 (no remainder)',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '• From 36: take out 12 groups of 3 (no remainder)',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '• Total: 4×100 + 12 = 412 groups of 3',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 12,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'So 3 divides 1236 with no remainder left!',
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}