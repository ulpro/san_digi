# Module User - Documentation

## Structure du module

```
lib/user/
├── auth/
│   ├── models/
│   │   └── user.dart                 # Modèle utilisateur
│   ├── services/
│   │   └── auth_service.dart         # Service d'authentification (singleton)
│   ├── utils/
│   │   └── validation.dart           # Validation des inputs
│   ├── screens/
│   │   ├── welcome_screen.dart       # Écran d'accueil avec onboarding
│   │   ├── register_screen.dart      # Gestionnaire d'inscription (4 étapes)
│   │   ├── personal_info_screen.dart # Étape 1: Infos personnelles
│   │   ├── create_password_screen.dart # Étape 3: Mot de passe
│   │   ├── vpn_certificate_screen.dart # Étape 4: Confirmation/Certificat
│   │   └── auth_flow.dart            # Gestionnaire du flux d'auth (À venir)
│   └── widgets/
│       └── (widgets réutilisables)
├── profile/
│   ├── screens/
│   └── widgets/
├── register/
│   └── (À implémenter)
├── shared/
│   ├── constants.dart                # Constantes du module
│   └── styles.dart                   # Styles réutilisables
└── user.dart                         # Fichier d'export

```

## Services disponibles

### AuthService
Singleton pour gérer l'authentification utilisateur.

```dart
final authService = AuthService();

// Login
bool success = await authService.login(email, password);

// Signup
bool success = await authService.signup(email, password, firstName, lastName);

// Logout
await authService.logout();

// État
if (authService.isLoggedIn) {
  User user = authService.currentUser!;
}
```

## Validation

```dart
import 'package:san_digi/user/auth/utils/validation.dart';

// Valider un email
String? error = ValidationUtils.validateEmail(email);

// Valider un mot de passe
String? error = ValidationUtils.validatePassword(password);

// Valider un numéro de téléphone
String? error = ValidationUtils.validatePhone(phone);

// Valider un nom
String? error = ValidationUtils.validateName(name);
```

## Flux d'inscription

1. **WelcomeScreen** - Onboarding avec 3 pages
2. **RegisterScreen** - Gestionnaire des 4 étapes:
   - Étape 1: PersonalInfoScreen (Identité)
   - Étape 2: (À implémenter - Contact)
   - Étape 3: CreatePasswordScreen (Sécurité)
   - Étape 4: VPNCertificateScreen (Confirmation)

## Utilisation

### Navigation vers l'inscription
```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => const RegisterScreen(),
  ),
);
```

### Utiliser le modèle User
```dart
User user = User(
  id: '123',
  email: 'user@example.com',
  firstName: 'John',
  lastName: 'Doe',
  phone: '+33 6 12 34 56 78',
  createdAt: DateTime.now(),
);

// Utiliser fullName getter
print(user.fullName); // "John Doe"

// CopyWith
User updatedUser = user.copyWith(
  phone: '+33 6 87 65 43 21',
);
```

## Thèmes supportés

- ✅ Mode clair (Light)
- ✅ Mode sombre (Dark)
- ✅ Pagination unifiée
- ✅ Animations fluides

## À faire

- [ ] Implémenter LoginScreen
- [ ] Implémenter Contact/Email verification screen
- [ ] Implémenter Password Reset flow
- [ ] Intégrer SharedPreferences pour la persistance
- [ ] Implémenter Profile management screens
- [ ] Ajouter widgets réutilisables au module auth/widgets/
- [ ] Tests unitaires pour AuthService et ValidationUtils
