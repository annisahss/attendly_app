import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:attendly_app/main.dart';
import 'package:attendly_app/presentation/providers/auth_provider.dart';
import 'package:attendly_app/presentation/providers/attendance_provider.dart';
import 'package:attendly_app/presentation/providers/theme_provider.dart';

void main() {
  setUpAll(() async {
    // ✅ Mock SharedPreferences before initializing
    SharedPreferences.setMockInitialValues({}); // <- This line fixes the error
  });

  testWidgets('App starts and shows login screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider(ThemeMode.light)),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => AttendanceProvider()),
        ],
        child: const AttendlyApp(isLoggedIn: false),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
  });
}
