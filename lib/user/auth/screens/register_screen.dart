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
  bool _certificateDownloaded = false;

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

  void _savePassword(String password) {
    setState(() {
      _password = password;
      _userData['password'] = password;
      _validatePassword();
    });
    _authService.saveRegistrationStep(_userData);
  }

  void _handleCertificateDownloaded(bool downloaded) {
    setState(() {
      _certificateDownloaded = downloaded;
    });
  }

  void _validatePersonalInfo() {
    final hasFirstName = _userData['firstName']?.isNotEmpty ?? false;
    final hasLastName = _userData['lastName']?.isNotEmpty ?? false;
    final email = _userData['email'] ?? '';
    final hasValidEmail = email.isNotEmpty && 
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    final hasPhone = _userData['phone']?.isNotEmpty ?? false;
    final hasBirthDate = _userData['birthDate']?.isNotEmpty ?? false;
    final hasSocialSecurity = _userData['socialSecurityNumber']?.isNotEmpty ?? false;
    
    setState(() {
      _isPersonalInfoValid = hasFirstName && 
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
    final hasNumberOrSpecial = RegExp(r'^(?=.*\d|.*[!@#$%^&*(),.?":{}|<>])').hasMatch(password);
    
    setState(() {
      _isPasswordValid = hasMinLength && hasUpperLower && hasNumberOrSpecial;
      _isPasswordMatching = password == (_userData['confirmPassword'] ?? '');
    });
  }

  Future<void> _completeRegistration() async {
    try {
      // Parser les dates
      final birthDate = _parseDate(_userData['birthDate']!);
      final lastConsultation = _userData['lastConsultation'] != null
          ? _parseDate(_userData['lastConsultation']!)
          : null;
      
      if (birthDate == null) {
        _showError('Date de naissance invalide');
        return;
      }

      // Appeler l'inscription
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
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
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
        return true; // L'étape 3 peut toujours être validée
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

  void _showValidationError() {
    String message;
    switch (_currentStep) {
      case 0:
        message = 'Veuillez remplir tous les champs obligatoires';
        break;
      case 1:
        message = 'Le mot de passe ne respecte pas toutes les exigences de sécurité';
        break;
      default:
        message = 'Veuillez vérifier vos informations';
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark 
          ? AppColors.backgroundDark 
          : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _previousStep,
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: isDark ? AppColors.white : AppColors.textPrimary,
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Création de compte',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.white : AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Étape ${_currentStep + 1}/3',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? AppColors.mediumGray : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Pour équilibrer la largeur
                ],
              ),
            ),

            // Barre de progression
            _buildProgressBar(isDark),

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
                    onPasswordChanged: _savePassword,
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
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
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
                          foregroundColor: isDark ? AppColors.white : AppColors.textPrimary,
                          side: BorderSide(
                            color: isDark ? AppColors.borderDark : AppColors.borderLight,
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
    );
  }

  Widget _buildProgressBar(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [0, 1, 2].map((index) {
          final isActive = index <= _currentStep;
          return Expanded(
            child: Container(
              height: 4,
              margin: EdgeInsets.only(right: index < 2 ? 4 : 0),
              decoration: BoxDecoration(
                color: isActive ? 
                    AppColors.primaryBlue : 
                    (isDark ? AppColors.mediumGray : AppColors.lightGray),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}