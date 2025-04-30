import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/services/preference_service.dart';
import 'core/utils/theme_manager.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/attendance_provider.dart';
import 'presentation/pages/auth/login_page.dart';
import 'presentation/pages/dashboard/dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceService.init();
  await initializeDateFormatting('en_US', null); 

  final isLoggedIn = PreferenceService.getLoginStatus();
  final themeMode = PreferenceService.getThemeMode();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(themeMode)),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AttendanceProvider()),
      ],
      child: AttendlyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class AttendlyApp extends StatelessWidget {
  final bool isLoggedIn;

  const AttendlyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendly',
      theme: ThemeManager.lightTheme,
      darkTheme: ThemeManager.darkTheme,
      themeMode: themeProvider.themeMode,
      home: isLoggedIn ? const DashboardPage() : const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(), // needed for logout redirect
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
