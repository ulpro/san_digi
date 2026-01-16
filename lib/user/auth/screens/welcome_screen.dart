import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'dart:async';
import '../../../shared/app_colors.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Timer? _autoSlideTimer;
  final math.Random _random = math.Random();

  final List<Map<String, dynamic>> _onboardingData = [
    {
      'title': 'Bienvenue sur San Digi',
      'description': 'Votre partenaire santé numérique pour une gestion simplifiée de votre bien-être',
      'icon': Icons.medical_services_rounded,
      'color': AppColors.primaryBlue,
      'gradient': [Color(0xFF2A7DE1), Color(0xFF4A90E2)],
    },
    {
      'title': 'Sécurité & Confidentialité',
      'description': 'Vos données médicales sont chiffrées et protégées selon les normes les plus strictes',
      'icon': Icons.security_rounded,
      'color': Color(0xFF34C759),
      'gradient': [Color(0xFF34C759), Color(0xFF4CD964)],
    },
    {
      'title': 'Accès 24h/24',
      'description': 'Consultez vos documents médicaux, traitements et rendez-vous où que vous soyez',
      'icon': Icons.access_time_filled_rounded,
      'color': Color(0xFFFF9500),
      'gradient': [Color(0xFFFF9500), Color(0xFFFFB800)],
    },
    {
      'title': 'Suivi Personnalisé',
      'description': 'Recevez des rappels intelligents et des conseils adaptés à votre profil santé',
      'icon': Icons.insights_rounded,
      'color': Color(0xFFAF52DE),
      'gradient': [Color(0xFFAF52DE), Color(0xFFD669E2)],
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < _onboardingData.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _autoSlideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 375;
    final isLargeScreen = size.width > 600;
    final isPortrait = size.height > size.width;
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;
            
            return Stack(
              children: [
                // Background gradient dots
                Positioned.fill(
                  child: CustomPaint(
                    painter: _BackgroundPainter(_random),
                  ),
                ),
                
                Column(
                  children: [
                    // Skip button - Ajusté selon la taille de l'écran
                    Padding(
                      padding: EdgeInsets.only(
                        right: isSmallScreen ? 16 : 24,
                        top: isSmallScreen ? 12 : 16,
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: _currentPage < _onboardingData.length - 1
                            ? TextButton(
                                onPressed: () {
                                  _pageController.animateToPage(
                                    _onboardingData.length - 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  'Passer',
                                  style: TextStyle(
                                    color: isDark ? Colors.white70 : AppColors.textSecondary,
                                    fontSize: isSmallScreen ? 14 : 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : SizedBox(height: isSmallScreen ? 40 : 48),
                      ),
                    ),
                    
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                          _animationController.forward(from: 0.0);
                        },
                        itemCount: _onboardingData.length,
                        itemBuilder: (context, index) {
                          final data = _onboardingData[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 20.0 : isLargeScreen ? 48.0 : 32.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Animated icon container - Responsive size
                                AnimatedBuilder(
                                  animation: _fadeAnimation,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: _fadeAnimation.value,
                                      child: child,
                                    );
                                  },
                                  child: Container(
                                    width: isSmallScreen 
                                      ? screenWidth * 0.35
                                      : isLargeScreen
                                        ? screenWidth * 0.25
                                        : screenWidth * 0.4,
                                    height: isSmallScreen 
                                      ? screenWidth * 0.35
                                      : isLargeScreen
                                        ? screenWidth * 0.25
                                        : screenWidth * 0.4,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: data['gradient'],
                                      ),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: data['gradient'][0].withOpacity(0.3),
                                          blurRadius: isLargeScreen ? 30 : 20,
                                          spreadRadius: isLargeScreen ? 8 : 5,
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      data['icon'],
                                      size: isSmallScreen ? 60 : isLargeScreen ? 100 : 80,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                
                                SizedBox(height: isPortrait 
                                  ? (isSmallScreen ? 24 : isLargeScreen ? 48 : 40)
                                  : (isSmallScreen ? 16 : 24)
                                ),
                                
                                // Animated title - Taille de police responsive
                                AnimatedBuilder(
                                  animation: _fadeAnimation,
                                  builder: (context, child) {
                                    return Opacity(
                                      opacity: _fadeAnimation.value,
                                      child: Transform.translate(
                                        offset: Offset(0, 20 * (1 - _fadeAnimation.value)),
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    data['title']!,
                                    style: TextStyle(
                                      fontSize: isSmallScreen 
                                        ? 22 
                                        : isLargeScreen
                                          ? 32
                                          : 28,
                                      fontWeight: FontWeight.w800,
                                      color: isDark ? Colors.white : AppColors.textPrimary,
                                      letterSpacing: -0.5,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                
                                SizedBox(height: isPortrait 
                                  ? (isSmallScreen ? 12 : isLargeScreen ? 24 : 16)
                                  : (isSmallScreen ? 8 : 12)
                                ),
                                
                                // Animated description - Taille de police responsive
                                AnimatedBuilder(
                                  animation: _fadeAnimation,
                                  builder: (context, child) {
                                    return Opacity(
                                      opacity: _fadeAnimation.value,
                                      child: Transform.translate(
                                        offset: Offset(0, 20 * (1 - _fadeAnimation.value)),
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    data['description']!,
                                    style: TextStyle(
                                      fontSize: isSmallScreen 
                                        ? 14 
                                        : isLargeScreen
                                          ? 18
                                          : 16,
                                      height: isPortrait ? 1.6 : 1.4,
                                      color: isDark ? Colors.white70 : AppColors.textSecondary,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: isPortrait ? 3 : 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // Pagination indicators
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 20.0 : isLargeScreen ? 48.0 : 32.0,
                        vertical: isPortrait 
                          ? (isSmallScreen ? 20 : isLargeScreen ? 40 : 32)
                          : (isSmallScreen ? 12 : 20),
                      ),
                      child: Column(
                        children: [
                          // Custom pagination dots
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _onboardingData.length,
                              (index) {
                                final isActive = index == _currentPage;
                                return GestureDetector(
                                  onTap: () {
                                    _pageController.animateToPage(
                                      index,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: EdgeInsets.symmetric(
                                      horizontal: isSmallScreen ? 4 : 6,
                                    ),
                                    width: isActive 
                                      ? (isSmallScreen ? 24 : isLargeScreen ? 40 : 32)
                                      : (isSmallScreen ? 6 : 8),
                                    height: isSmallScreen ? 6 : 8,
                                    decoration: BoxDecoration(
                                      gradient: isActive
                                          ? LinearGradient(
                                              colors: _onboardingData[index]['gradient'],
                                            )
                                          : null,
                                      color: isActive ? null : Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          
                          SizedBox(height: isPortrait 
                            ? (isSmallScreen ? 24 : isLargeScreen ? 48 : 40)
                            : (isSmallScreen ? 16 : 24)
                          ),
                          
                          // Next/Get Started button - Hauteur responsive
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_currentPage < _onboardingData.length - 1) {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                } else {
                                  _navigateToRegister(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _onboardingData[_currentPage]['color'],
                                foregroundColor: Colors.white,
                                minimumSize: Size(
                                  double.infinity, 
                                  isPortrait
                                    ? (isSmallScreen ? 50 : isLargeScreen ? 70 : 60)
                                    : (isSmallScreen ? 45 : 55)
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    isSmallScreen ? 12 : 16,
                                  ),
                                ),
                                elevation: 0,
                                shadowColor: Colors.transparent,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _currentPage == _onboardingData.length - 1
                                        ? 'Commencer l\'aventure'
                                        : 'Continuer',
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 15 : isLargeScreen ? 19 : 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: isSmallScreen ? 6 : 8),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: _currentPage == _onboardingData.length - 1
                                        ? Icon(
                                            Icons.rocket_launch_rounded, 
                                            size: isSmallScreen ? 18 : 20,
                                          )
                                        : Icon(
                                            Icons.arrow_forward_rounded, 
                                            size: isSmallScreen ? 18 : 20,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                          SizedBox(height: isPortrait 
                            ? (isSmallScreen ? 12 : isLargeScreen ? 24 : 16)
                            : (isSmallScreen ? 8 : 12)
                          ),
                          
                          // Previous button (only show if not first page)
                          if (_currentPage > 0)
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: isDark ? Colors.white70 : AppColors.textSecondary,
                                  minimumSize: Size(
                                    double.infinity, 
                                    isPortrait
                                      ? (isSmallScreen ? 48 : isLargeScreen ? 64 : 56)
                                      : (isSmallScreen ? 42 : 50)
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      isSmallScreen ? 12 : 16,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_back_rounded, 
                                      size: isSmallScreen ? 18 : 20,
                                    ),
                                    SizedBox(width: isSmallScreen ? 6 : 8),
                                    Text(
                                      'Retour',
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 15 : 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          
                          SizedBox(height: isPortrait 
                            ? (isSmallScreen ? 8 : isLargeScreen ? 16 : 8)
                            : (isSmallScreen ? 4 : 8)
                          ),
                          
                          // Already have an account
                          if (_currentPage == _onboardingData.length - 1)
                            Padding(
                              padding: EdgeInsets.only(
                                top: isPortrait 
                                  ? (isSmallScreen ? 12 : isLargeScreen ? 20 : 16)
                                  : (isSmallScreen ? 8 : 12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Déjà un compte ? ',
                                    style: TextStyle(
                                      color: isDark ? Colors.white70 : AppColors.textSecondary,
                                      fontSize: isSmallScreen ? 14 : 16,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => _navigateToRegister(context),
                                    child: Text(
                                      'Se connecter',
                                      style: TextStyle(
                                        color: _onboardingData[_currentPage]['color'],
                                        fontWeight: FontWeight.w600,
                                        fontSize: isSmallScreen ? 14 : 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          
                          // Espace supplémentaire pour les petits écrans en portrait
                          SizedBox(height: isSmallScreen && isPortrait ? 16 : 0),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const RegisterScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final math.Random _random;
  
  _BackgroundPainter(this._random);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.03)
      ..style = PaintingStyle.fill;
    
    // Ajuster le nombre de points en fonction de la taille de l'écran
    final numberOfDots = (size.width * size.height / 5000).round();
    
    // Draw random dots
    for (int i = 0; i < numberOfDots; i++) {
      final x = size.width * _random.nextDouble();
      final y = size.height * _random.nextDouble();
      final radius = 1.5 + _random.nextDouble() * 4;
      
      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}