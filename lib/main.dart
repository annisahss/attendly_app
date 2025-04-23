import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './core/services/preference_service.dart';
import './core/utils/theme_manager.dart';
import './presentation/providers/theme_provider.dart';
import './presentation/pages/auth/login_page.dart';
import './presentation/pages/dashboard/dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceService.init(); // Initialize shared preferences

  final isLoggedIn = PreferenceService.getLoginStatus();
  final themeMode = PreferenceService.getThemeMode();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(themeMode)),
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
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Attendly',
          theme: ThemeManager.lightTheme,
          darkTheme: ThemeManager.darkTheme,
          themeMode: themeProvider.themeMode,
          home: isLoggedIn ? DashboardPage() : const LoginPage(),
        );
      },
    );
  }
}
