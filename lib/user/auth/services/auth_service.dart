// lib/user/auth/services/auth_service.dart
import '../../../models/user_model.dart';

class AuthService {
  // Singleton
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // État
  User? _currentUser;
  Map<String, dynamic> _registrationData = {};

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  Map<String, dynamic> get registrationData => Map.from(_registrationData);

  // Initialisation
  Future<void> initialize() async {
    // Pour l'instant, juste initialiser
    _currentUser = null;
    _registrationData = {};
  }

  // ========== GESTION DE L'INSCRIPTION ==========

  // Sauvegarder une étape de l'inscription
  void saveRegistrationStep(Map<String, dynamic> data) {
    _registrationData.addAll(data);
    print('Registration data saved: $_registrationData');
  }

  // Récupérer les données d'inscription
  Map<String, dynamic>? getRegistrationProgress() {
    return _registrationData.isNotEmpty ? Map.from(_registrationData) : null;
  }

  // Effacer les données d'inscription
  void clearRegistrationProgress() {
    _registrationData.clear();
    print('Registration data cleared');
  }

  // ========== INSCRIPTION FINALE ==========

  Future<bool> registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
    required DateTime birthDate,
    required String socialSecurityNumber,
    DateTime? lastConsultation,
    String? doctorName,
  }) async {
    try {
      print('Starting registration for: $email');

      // Simuler un appel API
      await Future.delayed(const Duration(seconds: 1));

      // Créer l'utilisateur
      _currentUser = User(
        id: _generateUserId(),
        email: email,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        birthDate: birthDate,
        socialSecurityNumber: socialSecurityNumber,
        lastConsultation: lastConsultation,
        doctorName: doctorName,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );

      // Effacer les données temporaires
      _registrationData.clear();

      print('User registered successfully: ${_currentUser!.email}');
      return true;
    } catch (e) {
      print('Registration error: $e');
      return false;
    }
  }

  // ========== CONNEXION ==========

  Future<bool> login(String email, String password) async {
    try {
      print('Attempting login for: $email');

      // Simuler un appel API
      await Future.delayed(const Duration(seconds: 1));

      // Pour la démo, créer un utilisateur de test
      _currentUser = User(
        id: 'test_user_123',
        email: email,
        firstName: 'Jean',
        lastName: 'Dupont',
        phone: '+33 6 12 34 56 78',
        birthDate: DateTime(1985, 5, 15),
        socialSecurityNumber: '1 85 05 15 123 456 78',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        lastLogin: DateTime.now(),
      );

      print('Login successful for: $email');
      return true;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  // ========== DÉCONNEXION ==========

  Future<void> logout() async {
    _currentUser = null;
    _registrationData.clear();
    print('User logged out');
  }

  // ========== UTILITAIRES ==========

  String _generateUserId() {
    return 'user_${DateTime.now().millisecondsSinceEpoch}';
  }

  // Validation d'email
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Validation de mot de passe
  bool isPasswordValid(String password) {
    return password.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[a-z]').hasMatch(password);
  }

  // Parser une date
  DateTime? parseDate(String dateStr) {
    try {
      final parts = dateStr.split('/');
      if (parts.length == 3) {
        final day = int.tryParse(parts[0]);
        final month = int.tryParse(parts[1]);
        final year = int.tryParse(parts[2]);

        if (day != null && month != null && year != null) {
          return DateTime(year, month, day);
        }
      }
    } catch (e) {
      print('Date parsing error: $e');
    }
    return null;
  }

  // Formater une date
  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
