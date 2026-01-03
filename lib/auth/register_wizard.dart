import 'package:flutter/material.dart';
import 'personal_info_screen.dart';
import 'create_password_screen.dart';
import 'vpn_certificate_screen.dart';

class RegisterWizardScreen extends StatefulWidget {
  const RegisterWizardScreen({super.key});

  @override
  State<RegisterWizardScreen> createState() => _RegisterWizardScreenState();
}

class _RegisterWizardScreenState extends State<RegisterWizardScreen> {
  int _currentStep = 0;

  // Données partagées entre tous les écrans
  final Map<String, dynamic> _registrationData = {};

  // État partagé pour la validation
  bool _isCurrentStepValid = false;

  // Liste des écrans avec leurs clés
  final List<Map<String, dynamic>> _steps = [
    {
      'title': 'Informations Personnelles',
      'screen': PersonalInfoScreen(),
      'key': GlobalKey<State<PersonalInfoScreen>>(),
    },
    {
      'title': 'Sécurité du Compte',
      'screen': CreatePasswordScreen(),
      'key': GlobalKey<State<CreatePasswordScreen>>(),
    },
    {
      'title': 'Confirmation',
      'screen': VPNCertificateScreen(),
      'key': GlobalKey<State<VPNCertificateScreen>>(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF121A26)
            : const Color(0xFFF8F9FA),
        body: SafeArea(
          child: Column(
            children: [
              // En-tête avec progression
              _buildHeader(isDark),

              // Écran actuel - SANS Scaffold ici
              Expanded(child: _buildCurrentScreen()),

              // Barre de navigation en bas
              _buildNavigationBar(isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    final step = _steps[_currentStep];

    // Wrapper pour injecter les données partagées et les callbacks
    return _StepWrapper(
      key: step['key'],
      child: step['screen'],
      onDataUpdate: (data) {
        _registrationData.addAll(data);
        _updateStepValidity();
      },
    );
  }

  Widget _buildHeader(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C2536) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [
          // Bouton retour
          GestureDetector(
            onTap: _goToPreviousStep,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                size: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Titre de l'étape
          Expanded(
            child: Text(
              _steps[_currentStep]['title'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),

          // Indicateur d'étape
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${_currentStep + 1}/${_steps.length}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C2536) : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.grey.shade200,
          ),
        ),
      ),
      child: Column(
        children: [
          // Indicateur de progression
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _steps.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentStep == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentStep >= index
                        ? const Color(0xFF2A7DE1)
                        : Colors.grey.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Bouton précédent
              if (_currentStep > 0)
                SizedBox(
                  width: 120,
                  child: OutlinedButton.icon(
                    onPressed: _goToPreviousStep,
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 16,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    label: Text(
                      'Précédent',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color: isDark
                            ? Colors.white.withOpacity(0.3)
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                )
              else
                const SizedBox(width: 120),

              // Texte de l'étape
              Text(
                'Étape ${_currentStep + 1} sur ${_steps.length}',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark
                      ? Colors.white.withOpacity(0.7)
                      : Colors.grey.shade600,
                ),
              ),

              // Bouton suivant/terminer
              SizedBox(
                width: 120,
                child: ElevatedButton.icon(
                  onPressed: _isCurrentStepValid ? _goToNextStep : null,
                  icon: Icon(
                    _currentStep == _steps.length - 1
                        ? Icons.check_rounded
                        : Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                  label: Text(
                    _currentStep == _steps.length - 1 ? 'Terminer' : 'Suivant',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isCurrentStepValid
                        ? const Color(0xFF2A7DE1)
                        : const Color(0xFF2A7DE1).withOpacity(0.5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _goToPreviousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
        _updateStepValidity();
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _goToNextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
        _updateStepValidity();
      });
    } else {
      _completeRegistration();
    }
  }

  void _updateStepValidity() {
    // Appeler la validation du step actuel via sa clé
    setState(() {
      _isCurrentStepValid = _validateCurrentStep();
    });
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0: // Informations personnelles
        // Vérifier via les données collectées
        return _registrationData.containsKey('firstName') &&
            _registrationData.containsKey('lastName');
      case 1: // Mot de passe
        return _registrationData.containsKey('password') &&
            _registrationData.containsKey('confirmPassword') &&
            _registrationData['password'] ==
                _registrationData['confirmPassword'];
      case 2: // Certificat VPN - Toujours valide
        return true;
      default:
        return false;
    }
  }

  void _completeRegistration() {
    print('Inscription terminée avec les données suivantes:');
    print(_registrationData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Inscription réussie !'),
          ],
        ),
        backgroundColor: const Color(0xFF2A7DE1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    });
  }

  Future<bool> _onWillPop() async {
    if (_currentStep > 0) {
      _goToPreviousStep();
      return false;
    }

    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quitter l\'inscription ?'),
        content: const Text('Toutes les données saisies seront perdues.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Quitter', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }
}

// Wrapper pour injecter les callbacks dans les écrans
class _StepWrapper extends StatelessWidget {
  final Widget child;
  final Function(Map<String, dynamic>) onDataUpdate;

  const _StepWrapper({
    super.key,
    required this.child,
    required this.onDataUpdate,
  });

  @override
  Widget build(BuildContext context) {
    // Injecter le callback via InheritedWidget ou autre méthode
    return child;
  }
}
