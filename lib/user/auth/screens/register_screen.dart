import 'package:flutter/material.dart';
import '../../../shared/app_colors.dart';
import '../../../shared/navigation.dart';
import '../services/auth_service.dart';
import 'personal_info_screen.dart';
import 'create_password_screen.dart';
import 'vpn_certificate_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  final AuthService _authService = AuthService();
  Map<String, dynamic> _userData = {};
  String _password = '';

  // Ajout de variables de validation
  bool _isPersonalInfoValid = false;
  bool _isPasswordValid = false;
  bool _isPasswordMatching = false;

  @override
  void initState() {
    super.initState();
    _loadRegistrationProgress();
  }

  void _loadRegistrationProgress() {
    final progress = _authService.getRegistrationProgress();
    if (progress != null) {
      setState(() {
        _userData = progress;
        _password = progress['password'] ?? '';
        // Valider les données existantes
        _validatePersonalInfo();
        _validatePassword();
      });
    }
  }

  void _savePersonalInfo(Map<String, dynamic> data) {
    setState(() {
      _userData.addAll(data);
      _validatePersonalInfo();
    });
    _authService.saveRegistrationStep(_userData);
  }

  void _handlePasswordChanged(String password, String confirmPassword) {
    setState(() {
      _password = password;
      _userData['password'] = password;
      _userData['confirmPassword'] = confirmPassword;
      _validatePassword();
    });
    _authService.saveRegistrationStep(_userData);
  }

  void _handleCertificateDownloaded(bool downloaded) {
    // Certificate download status tracking removed as it's optional
  }

  void _showValidationError() {
    String message;
    switch (_currentStep) {
      case 0:
        final missing = _getMissingFields();
        if (missing.isNotEmpty) {
          message = 'Champs manquants ou invalides : ${missing.join(", ")}';
        } else {
          message = 'Veuillez remplir tous les champs obligatoires';
        }
        break;
      case 1:
        if (!_isPasswordValid) {
          message =
              'Le mot de passe doit contenir 8+ caractères, majuscule, minuscule et chiffre/spécial';
        } else if (!_isPasswordMatching) {
          message = 'Les mots de passe ne correspondent pas';
        } else {
          message = 'Veuillez vérifier votre mot de passe';
        }
        break;
      default:
        message = 'Veuillez vérifier vos informations';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  List<String> _getMissingFields() {
    final List<String> missing = [];
    final data = _userData;

    if ((data['firstName']?.isEmpty ?? true)) missing.add('Prénom');
    if ((data['lastName']?.isEmpty ?? true)) missing.add('Nom');

    final email = data['email'] ?? '';
    // Relaxed email regex
    final isEmailValid =
        email.isNotEmpty && email.contains('@') && email.contains('.');
    if (!isEmailValid) missing.add('Email vide ou invalide');

    if ((data['phone']?.isEmpty ?? true)) missing.add('Téléphone');
    if ((data['birthDate']?.isEmpty ?? true)) missing.add('Date de naissance');
    if ((data['socialSecurityNumber']?.isEmpty ?? true))
      missing.add('Numéro de sécurité sociale');

    return missing;
  }

  void _validatePersonalInfo() {
    final hasFirstName = _userData['firstName']?.isNotEmpty ?? false;
    final hasLastName = _userData['lastName']?.isNotEmpty ?? false;
    final email = _userData['email'] ?? '';
    final hasValidEmail =
        email.isNotEmpty && email.contains('@') && email.contains('.');
    final hasPhone = _userData['phone']?.isNotEmpty ?? false;
    final hasBirthDate = _userData['birthDate']?.isNotEmpty ?? false;
    final hasSocialSecurity =
        _userData['socialSecurityNumber']?.isNotEmpty ?? false;

    setState(() {
      _isPersonalInfoValid =
          hasFirstName &&
          hasLastName &&
          hasValidEmail &&
          hasPhone &&
          hasBirthDate &&
          hasSocialSecurity;
    });
  }

  void _validatePassword() {
    final password = _password;
    final hasMinLength = password.length >= 8;
    final hasUpperLower = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])').hasMatch(password);
    final hasNumberOrSpecial = RegExp(
      r'^(?=.*\d|.*[!@#$%^&*(),.?":{}|<>])',
    ).hasMatch(password);

    setState(() {
      _isPasswordValid = hasMinLength && hasUpperLower && hasNumberOrSpecial;
      _isPasswordMatching = password == (_userData['confirmPassword'] ?? '');
    });
  }

  Future<void> _completeRegistration() async {
    try {
      final birthDate = _parseDate(_userData['birthDate']!);
      final lastConsultation = _userData['lastConsultation'] != null
          ? _parseDate(_userData['lastConsultation']!)
          : null;

      if (birthDate == null) {
        _showError('Date de naissance invalide');
        return;
      }

      final success = await _authService.registerUser(
        email: _userData['email']!,
        password: _password,
        firstName: _userData['firstName']!,
        lastName: _userData['lastName']!,
        phone: _userData['phone']!,
        birthDate: birthDate,
        socialSecurityNumber: _userData['socialSecurityNumber']!,
        lastConsultation: lastConsultation,
        doctorName: _userData['doctorName'],
      );

      if (success) {
        _authService.clearRegistrationProgress();
        _navigateToHome();
      } else {
        _showError('Erreur lors de l\'inscription');
      }
    } catch (e) {
      _showError('Erreur: ${e.toString()}');
    }
  }

  DateTime? _parseDate(String dateStr) {
    try {
      final parts = dateStr.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
    } catch (e) {
      print('Erreur de parsing de date: $e');
    }
    return null;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _navigateToHome() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainNavigation()),
      (route) => false,
    );
  }

  void _nextStep() {
    if (_currentStep < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep++);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep--);
    } else {
      Navigator.of(context).pop();
    }
  }

  String _getButtonText() {
    switch (_currentStep) {
      case 0:
        return 'Continuer';
      case 1:
        return 'Continuer';
      case 2:
        return 'Terminer l\'inscription';
      default:
        return 'Continuer';
    }
  }

  bool _canProceedToNextStep() {
    switch (_currentStep) {
      case 0:
        return _isPersonalInfoValid;
      case 1:
        return _isPasswordValid && _isPasswordMatching;
      case 2:
        return true;
      default:
        return false;
    }
  }

  void _handleContinue() {
    if (!_canProceedToNextStep()) {
      _showValidationError();
      return;
    }

    if (_currentStep < 2) {
      _nextStep();
    } else {
      _completeRegistration();
    }
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Profil Patient';
      case 1:
        return 'Sécurité';
      case 2:
        return 'Certificat';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                // Custom AppBar
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.backgroundDark : Colors.white,
                    boxShadow: [
                      if (!isDark)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                    ],
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: _previousStep,
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.primaryBlue,
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Vérification d'Identité",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                        // Placeholder for balance or hidden icon to center title
                        const SizedBox(width: 40),
                      ],
                    ),
                  ),
                ),

                // Step Indicator and Progress
                Container(
                  color: isDark ? AppColors.backgroundDark : Colors.white,
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ÉTAPE ${_currentStep + 1} SUR 3',
                            style: const TextStyle(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 1.0,
                            ),
                          ),
                          Text(
                            _getStepTitle(),
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white54
                                  : Colors.grey.shade500,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Continuous Progress Bar
                      Stack(
                        children: [
                          Container(
                            height: 6,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 6,
                            width:
                                MediaQuery.of(context).size.width *
                                ((_currentStep + 1) / 3),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Contenu
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      PersonalInfoScreen(
                        onDataChanged: _savePersonalInfo,
                        initialData: _userData,
                      ),
                      CreatePasswordScreen(
                        onPasswordChanged: _handlePasswordChanged,
                        initialPassword: _password,
                      ),
                      VPNCertificateScreen(
                        onCertificateDownloaded: _handleCertificateDownloaded,
                      ),
                    ],
                  ),
                ),

                // Boutons de navigation (UNIQUEMENT ICI)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      if (_currentStep > 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _previousStep,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: isDark
                                  ? AppColors.white
                                  : AppColors.textPrimary,
                              side: BorderSide(
                                color: isDark
                                    ? AppColors.borderDark
                                    : AppColors.borderLight,
                              ),
                              minimumSize: const Size(0, 56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text('Retour'),
                          ),
                        ),
                      if (_currentStep > 0) const SizedBox(width: 12),
                      Expanded(
                        flex: _currentStep > 0 ? 1 : 2,
                        child: ElevatedButton(
                          onPressed: _handleContinue,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _canProceedToNextStep()
                                ? AppColors.primaryBlue
                                : AppColors.primaryBlue.withOpacity(0.5),
                            foregroundColor: AppColors.white,
                            minimumSize: const Size(0, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            _getButtonText(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
