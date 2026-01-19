import 'package:flutter/material.dart';
import '../../../shared/app_colors.dart';
import 'register_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _navigateToRegister(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const RegisterScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSmallScreen = size.width < 375;
    final isTablet = size.width > 768;
    final isPortrait = size.height > size.width;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            constraints: BoxConstraints(minHeight: size.height),
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen
                  ? 16.0
                  : isTablet
                  ? 40.0
                  : 24.0,
              vertical: isSmallScreen ? 16.0 : 24.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo Section
                _buildLogoSection(isDark, isSmallScreen, isTablet),

                SizedBox(
                  height: isSmallScreen
                      ? 24
                      : isTablet
                      ? 48
                      : 32,
                ),

                // Hero Card
                _buildHeroCard(isSmallScreen, isTablet),

                SizedBox(
                  height: isSmallScreen
                      ? 24
                      : isTablet
                      ? 48
                      : 32,
                ),

                // Welcome Text
                Column(
                  children: [
                    Text(
                      "Bienvenue sur SanDigi",
                      style: TextStyle(
                        fontSize: isSmallScreen
                            ? 22
                            : isTablet
                            ? 36
                            : 28,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.textPrimary,
                        letterSpacing: -0.5,
                        height: isSmallScreen ? 1.2 : 1.1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: isSmallScreen ? 8 : 12),
                    Text(
                      "Gérez vos rendez-vous, accédez à vos documents et communiquez avec vos praticiens en toute sécurité.",
                      style: TextStyle(
                        fontSize: isSmallScreen
                            ? 14
                            : isTablet
                            ? 18
                            : 16,
                        color: isDark
                            ? Colors.white70
                            : AppColors.textSecondary,
                        height: isSmallScreen ? 1.4 : 1.5,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: isPortrait ? 3 : 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),

                SizedBox(
                  height: isSmallScreen
                      ? 32
                      : isTablet
                      ? 64
                      : 48,
                ),

                // Buttons
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: isSmallScreen
                          ? 50
                          : isTablet
                          ? 70
                          : 56,
                      child: ElevatedButton(
                        onPressed: () => _navigateToLogin(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              isSmallScreen ? 10 : 12,
                            ),
                          ),
                          elevation: 4,
                          shadowColor: AppColors.primaryBlue.withOpacity(0.4),
                        ),
                        child: Text(
                          "Se connecter",
                          style: TextStyle(
                            fontSize: isSmallScreen
                                ? 15
                                : isTablet
                                ? 18
                                : 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 12 : 16),
                    SizedBox(
                      width: double.infinity,
                      height: isSmallScreen
                          ? 50
                          : isTablet
                          ? 70
                          : 56,
                      child: OutlinedButton(
                        onPressed: () => _navigateToRegister(context),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: isDark
                              ? Colors.white.withOpacity(0.05)
                              : const Color(0xFFF1F5F9),
                          side: BorderSide.none,
                          foregroundColor: AppColors.primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              isSmallScreen ? 10 : 12,
                            ),
                          ),
                        ),
                        child: Text(
                          "Créer un compte",
                          style: TextStyle(
                            fontSize: isSmallScreen
                                ? 15
                                : isTablet
                                ? 18
                                : 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: isSmallScreen
                      ? 24
                      : isTablet
                      ? 48
                      : 32,
                ),

                // Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: isSmallScreen ? 14 : 16,
                      color: isDark ? Colors.white38 : Colors.grey.shade400,
                    ),
                    SizedBox(width: isSmallScreen ? 6 : 8),
                    Flexible(
                      child: Text(
                        "Hébergeur de Données de Santé (HDS) certifié",
                        style: TextStyle(
                          fontSize: isSmallScreen
                              ? 11
                              : isTablet
                              ? 14
                              : 12,
                          color: isDark ? Colors.white38 : Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection(bool isDark, bool isSmallScreen, bool isTablet) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(
            isSmallScreen
                ? 12
                : isTablet
                ? 20
                : 16,
          ),
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.blue.shade50,
            borderRadius: BorderRadius.circular(
              isSmallScreen
                  ? 16
                  : isTablet
                  ? 24
                  : 20,
            ),
          ),
          child: Icon(
            Icons.health_and_safety,
            color: AppColors.primaryBlue,
            size: isSmallScreen
                ? 32
                : isTablet
                ? 48
                : 40,
          ),
        ),
        SizedBox(height: isSmallScreen ? 8 : 12),
        Text(
          "SanDigi",
          style: TextStyle(
            fontSize: isSmallScreen
                ? 20
                : isTablet
                ? 28
                : 24,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroCard(bool isSmallScreen, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isSmallScreen
            ? 20
            : isTablet
            ? 40
            : 32,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          isSmallScreen
              ? 20
              : isTablet
              ? 32
              : 28,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withOpacity(0.25),
            blurRadius: isSmallScreen ? 15 : 25,
            offset: const Offset(0, 10),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E88E5), Color(0xFF0D47A1)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 10 : 12,
              vertical: isSmallScreen ? 6 : 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  color: Colors.white,
                  size: isSmallScreen ? 14 : 16,
                ),
                SizedBox(width: isSmallScreen ? 6 : 8),
                Text(
                  "ESPACE SÉCURISÉ",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.95),
                    fontSize: isSmallScreen
                        ? 11
                        : isTablet
                        ? 14
                        : 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: isSmallScreen
                ? 20
                : isTablet
                ? 40
                : 32,
          ),
          Text(
            "Votre santé,\nentre de bonnes mains.",
            style: TextStyle(
              color: Colors.white,
              fontSize: isSmallScreen
                  ? 24
                  : isTablet
                  ? 40
                  : 32,
              fontWeight: FontWeight.bold,
              height: 1.1,
              letterSpacing: -0.5,
            ),
          ),
          if (isTablet) SizedBox(height: 24),
          if (isTablet)
            Row(
              children: [
                _buildDecorativeCircle(Colors.white.withOpacity(0.3), 10),
                SizedBox(width: 20),
                _buildDecorativeCircle(Colors.white.withOpacity(0.2), 8),
                SizedBox(width: 20),
                _buildDecorativeCircle(Colors.white.withOpacity(0.1), 6),
              ],
            ),
          SizedBox(
            height: isSmallScreen
                ? 20
                : isTablet
                ? 40
                : 32,
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
