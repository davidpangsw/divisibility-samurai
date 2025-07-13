import 'package:flutter/material.dart';
import 'widgets/homepage.dart';
import 'utils/sound_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SoundManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Homepage(),
    );
  }
}
