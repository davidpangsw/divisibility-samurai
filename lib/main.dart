import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'widgets/homepage.dart';
import 'utils/sound_manager.dart';
import 'utils/asset_manager.dart';

void main() async {
  var binding = WidgetsFlutterBinding.ensureInitialized();
  
  // Preserve native splash until assets are loaded
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Preload images and sound effects first
      await AssetManager.preloadImages();
      await AssetManager.preloadSoundEffects();
      AssetManager.preloadSoundMusics();
      
      // Initialize sound manager
      await SoundManager.initialize();
      
    } finally {
      // Remove native splash now that critical assets are loaded
      FlutterNativeSplash.remove();
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Divisibility Samurai',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: _isLoading ? const Scaffold(body: Center(child: CircularProgressIndicator())) : const Homepage(),
    );
  }
}
