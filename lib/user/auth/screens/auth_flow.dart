// lib/user/auth/screens/auth_flow.dart
import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'register_screen.dart';
import 'login_screen.dart';

/// Écran parent qui gère le flux d'authentification
/// (Bienvenue -> Inscription -> Connexion)
class AuthFlow extends StatefulWidget {
  const AuthFlow({super.key});

  @override
  State<AuthFlow> createState() => _AuthFlowState();
}

class _AuthFlowState extends State<AuthFlow> {
  int _currentStep = 0; // 0: Welcome, 1: Register, 2: Login

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _currentStep,
      children: [
        const WelcomeScreen(),
        const RegisterScreen(),
        const LoginScreen(),
      ],
    );
  }
}
