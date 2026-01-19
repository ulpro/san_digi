import 'package:flutter/material.dart';
import 'user/auth/screens/welcome_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SanDigiApp());
}

class SanDigiApp extends StatelessWidget {
  const SanDigiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SanDigi',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}
