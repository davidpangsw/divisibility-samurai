import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/homepage.dart';
import 'widgets/loading_screen.dart';
import 'utils/sound_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      await SoundManager.initialize();
    } catch (e) {
      // Handle initialization error gracefully
    } finally {
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
        textTheme: GoogleFonts.robotoTextTheme(),
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      home: _isLoading ? const LoadingScreen() : const Homepage(),
    );
  }
}
