// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:divisibility_samurai/main.dart';

void main() {
  testWidgets('Divisibility Samurai app loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    // Initially shows loading screen
    expect(find.text('Divisibility Samurai'), findsOneWidget);
    expect(find.text('Loading game assets...'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    
    // Wait for loading to complete and pump to show homepage
    await tester.pumpAndSettle(const Duration(seconds: 5));
    
    // After loading, should show the main game interface
    expect(find.text('Divisibility Samurai'), findsOneWidget); // App bar title
    expect(find.text('Help'), findsOneWidget); // Help button with text
    expect(find.text('Settings'), findsOneWidget); // Settings button with text
    expect(find.text('About'), findsOneWidget); // About button with text
  });
}
