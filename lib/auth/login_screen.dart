import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Couleurs du thème
  static const Color primaryColor = Color(0xFF13EC13);
  static const Color primaryLight = Color(0xFF43F143);
  static const Color backgroundColorLight = Color(0xFFF6F8F6);
  static const Color backgroundColorDark = Color(0xFF102210);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1A2E1A);
  static const Color textMainLight = Color(0xFF111811);
  static const Color textMainDark = Color(0xFFFFFFFF);
  static const Color textSecondaryLight = Color(0xFF618961);
  static const Color textSecondaryDark = Color(0xFF8BAD8B);
  static const Color borderLight = Color(0xFFDBE6DB);
  static const Color borderDark = Color(0xFF374151);

  // Variables d'état
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _showBiometricPrompt = false;

  @override
  void initState() {
    super.initState();
    
    // Animation du prompt biométrique après délai
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showBiometricPrompt = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = screenWidth > 480 ? 480.0 : screenWidth;

    return Scaffold(
      backgroundColor: isDark ? backgroundColorDark : backgroundColorLight,
      body: Center(
        child: Container(
          width: maxWidth,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              // App Bar
              _buildAppBar(isDark),
              
              // Contenu principal avec défilement
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // Illustration/Header
                      _buildHeader(isDark),
                      
                      // Titre
                      _buildTitle(isDark),
                      
                      // Formulaire
                      _buildLoginForm(isDark),
                      
                      // Diviseur
                      _buildDivider(isDark),
                      
                      // Connexion sociale
                      _buildSocialLogin(isDark),
                      
                      // Pied de page
                      _buildFooter(isDark),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // App Bar
  Widget _buildAppBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          // Bouton retour
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: isDark ? textMainDark : textMainLight,
                ),
              ),
            ),
          ),
          
          Expanded(
            child: Center(
              child: Text(
                'Connexion',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? textMainDark : textMainLight,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ),
          
          // Espace vide pour équilibrer
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  // Header avec illustration
  Widget _buildHeader(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    primaryColor.withOpacity(0.1),
                    backgroundColorDark,
                    primaryColor.withOpacity(0.05),
                  ]
                : [
                    primaryColor.withOpacity(0.2),
                    backgroundColorLight,
                    primaryColor.withOpacity(0.05),
                  ],
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(isDark ? 0.1 : 0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: primaryColor.withOpacity(0.1),
                width: 4,
              ),
            ),
            child: Icon(
              Icons.medical_services,
              color: primaryColor,
              size: 64,
            ),
          ),
        ),
      ),
    );
  }

  // Titre
  Widget _buildTitle(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 24, left: 24, right: 24),
      child: Text(
        'Accédez à votre espace santé',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: isDark ? textMainDark : textMainLight,
          letterSpacing: -0.5,
          height: 1.2,
        ),
      ),
    );
  }

  // Formulaire de connexion
  Widget _buildLoginForm(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Champ email
          _buildEmailField(isDark),
          const SizedBox(height: 16),
          
          // Champ mot de passe
          _buildPasswordField(isDark),
          const SizedBox(height: 8),
          
          // Lien mot de passe oublié
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                // Navigation vers réinitialisation mot de passe
              },
              child: Text(
                'Mot de passe oublié ?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? textSecondaryDark : textSecondaryLight,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          
          // Bouton de connexion
          _buildLoginButton(isDark),
        ],
      ),
    );
  }

  // Champ email
  Widget _buildEmailField(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 4),
          child: Text(
            'Email ou téléphone',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? textMainDark : textMainLight,
            ),
          ),
        ),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: isDark ? surfaceDark : surfaceLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _emailFocus.hasFocus
                  ? primaryColor.withOpacity(0.5)
                  : isDark ? borderDark : borderLight,
              width: _emailFocus.hasFocus ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Icon(
                  Icons.mail_outline,
                  size: 20,
                  color: isDark ? textSecondaryDark : textSecondaryLight,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? textMainDark : textMainLight,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'email@exemple.com',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Champ mot de passe
  Widget _buildPasswordField(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mot de passe',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? textMainDark : textMainLight,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: isDark ? surfaceDark : surfaceLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _passwordFocus.hasFocus
                  ? primaryColor.withOpacity(0.5)
                  : isDark ? borderDark : borderLight,
              width: _passwordFocus.hasFocus ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Icon(
                  Icons.lock_outline,
                  size: 20,
                  color: isDark ? textSecondaryDark : textSecondaryLight,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  obscureText: _obscurePassword,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? textMainDark : textMainLight,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Votre mot de passe',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  size: 22,
                  color: isDark ? textSecondaryDark : textSecondaryLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Bouton de connexion
  Widget _buildLoginButton(bool isDark) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryLight],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: _isLoading ? null : _handleLogin,
          borderRadius: BorderRadius.circular(12),
          onTapDown: (_) {
            if (!_isLoading) {
              setState(() {});
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _isLoading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(
                            Colors.black.withOpacity(0.8),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Se connecter',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.login,
                            color: Colors.black,
                            size: 20,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Diviseur
  Widget _buildDivider(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: isDark ? borderDark : borderLight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Ou continuer avec',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? textSecondaryDark : textSecondaryLight,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: isDark ? borderDark : borderLight,
            ),
          ),
        ],
      ),
    );
  }

  // Connexion sociale
  Widget _buildSocialLogin(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: _buildSocialButton(
              icon: _buildGoogleIcon(),
              label: 'Google',
              isDark: isDark,
              onPressed: () => _handleSocialLogin('google'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSocialButton(
              icon: _buildAppleIcon(isDark),
              label: 'Apple',
              isDark: isDark,
              onPressed: () => _handleSocialLogin('apple'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required Widget icon,
    required String label,
    required bool isDark,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 48,
      child: Material(
        color: isDark ? surfaceDark : surfaceLight,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: isDark ? borderDark : borderLight,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark ? textMainDark : textMainLight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleIcon() {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(
        painter: GoogleIconPainter(),
      ),
    );
  }

  Widget _buildAppleIcon(bool isDark) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(
        painter: AppleIconPainter(
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  // Pied de page
  Widget _buildFooter(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(top: 48, bottom: 32),
      child: Column(
        children: [
          // Lien d'inscription
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pas encore de compte ?',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? textMainDark : textMainLight,
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () {
                  // Navigation vers l'inscription
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Text(
                  'Créer un compte',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Prompt biométrique (apparaît après délai)
          AnimatedOpacity(
            opacity: _showBiometricPrompt ? 0.8 : 0,
            duration: const Duration(milliseconds: 500),
            child: GestureDetector(
              onTap: _showBiometricPrompt ? _handleBiometricLogin : null,
              child: Icon(
                Icons.face,
                color: primaryColor,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Gestionnaires d'événements
  Future<void> _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showError('Veuillez remplir tous les champs');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulation de connexion
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Navigation vers l'écran principal
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
    
    _showSuccess('Connexion réussie');
  }

  Future<void> _handleSocialLogin(String provider) async {
    setState(() {
      _isLoading = true;
    });

    // Simulation de connexion sociale
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });

    // Navigation ou traitement
    _showSuccess('Connexion avec $provider');
  }

  Future<void> _handleBiometricLogin() async {
    // Implémentez la logique biométrique ici
    // Ex: Utilisez local_auth pour Face ID/Touch ID
    
    _showSuccess('Authentification biométrique');
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: primaryColor),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: isDark ? surfaceDark : surfaceLight,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }
}

// Peintre pour l'icône Google
class GoogleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;
    
    final path = Path();
    
    // Dessiner l'icône Google (version simplifiée)
    paint.color = const Color(0xFF4285F4);
    canvas.drawRect(
      Rect.fromPoints(
        Offset(size.width * 0.2, size.height * 0.1),
        Offset(size.width * 0.8, size.height * 0.5),
      ),
      paint,
    );
    
    paint.color = const Color(0xFF34A853);
    canvas.drawRect(
      Rect.fromPoints(
        Offset(size.width * 0.2, size.height * 0.5),
        Offset(size.width * 0.8, size.height * 0.9),
      ),
      paint,
    );
    
    paint.color = const Color(0xFFFBBC05);
    canvas.drawRect(
      Rect.fromPoints(
        Offset(size.width * 0.1, size.height * 0.3),
        Offset(size.width * 0.2, size.height * 0.7),
      ),
      paint,
    );
    
    paint.color = const Color(0xFFEA4335);
    canvas.drawRect(
      Rect.fromPoints(
        Offset(size.width * 0.1, size.height * 0.1),
        Offset(size.width * 0.2, size.height * 0.9),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Peintre pour l'icône Apple
class AppleIconPainter extends CustomPainter {
  final Color color;
  
  AppleIconPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    // Dessiner une icône Apple simplifiée
    final path = Path()
      ..moveTo(size.width * 0.5, size.height * 0.1)
      ..cubicTo(
        size.width * 0.4, size.height * 0.05,
        size.width * 0.2, size.height * 0.1,
        size.width * 0.2, size.height * 0.4,
      )
      ..cubicTo(
        size.width * 0.2, size.height * 0.7,
        size.width * 0.4, size.height * 0.95,
        size.width * 0.5, size.height * 0.9,
      )
      ..cubicTo(
        size.width * 0.6, size.height * 0.95,
        size.width * 0.8, size.height * 0.7,
        size.width * 0.8, size.height * 0.4,
      )
      ..cubicTo(
        size.width * 0.8, size.height * 0.1,
        size.width * 0.6, size.height * 0.05,
        size.width * 0.5, size.height * 0.1,
      )
      ..close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}