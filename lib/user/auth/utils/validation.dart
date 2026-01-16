// Utilitaires de validation pour l'authentification
class ValidationUtils {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'L\'email est requis';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Veuillez entrer un email valide';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le mot de passe est requis';
    }
    if (value.length < 8) {
      return 'Le mot de passe doit contenir au moins 8 caractères';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Le mot de passe doit contenir une lettre majuscule';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Le mot de passe doit contenir un chiffre';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le téléphone est requis';
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{10,}$');
    if (!phoneRegex.hasMatch(value.replaceAll(' ', ''))) {
      return 'Veuillez entrer un numéro de téléphone valide';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le nom est requis';
    }
    if (value.length < 2) {
      return 'Le nom doit contenir au moins 2 caractères';
    }
    return null;
  }
}
