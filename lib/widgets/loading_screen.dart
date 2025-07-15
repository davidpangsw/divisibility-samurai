import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Game title
            Text(
              'Divisibility Samurai',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade700,
              ),
            ),
            const SizedBox(height: 20),
            
            // Samurai emoji
            const Text(
              '🥷',
              style: TextStyle(fontSize: 64),
            ),
            const SizedBox(height: 30),
            
            // Loading indicator
            CircularProgressIndicator(
              color: Colors.deepPurple.shade600,
              strokeWidth: 3,
            ),
            const SizedBox(height: 20),
            
            // Loading text
            Text(
              'Loading game assets...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.deepPurple.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}