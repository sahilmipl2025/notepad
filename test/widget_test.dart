import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notepad/main.dart';
import 'package:notepad/screens/home_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:io';

void main() {
  TestWidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter plugins are initialized

  setUpAll(() async {
    // Mock path_provider to return a temp directory
    const MethodChannel('plugins.flutter.io/path_provider')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      return Directory.systemTemp.path;
    });

    // Initialize Hive in a temp directory
    final tempDir = await getApplicationDocumentsDirectory();
    Hive.init(tempDir.path);

    // Open a mock Hive box
    await Hive.openBox('notes');
  });

  tearDownAll(() async {
    await Hive.close(); // Close Hive after tests
  });

  testWidgets('Notepad app loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Ensure HomeScreen is loaded
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
