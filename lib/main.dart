import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      title: 'Divisibility Samurai',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.robotoTextTheme(),
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      home: const Homepage(),
    );
  }
}
