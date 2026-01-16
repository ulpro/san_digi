// lib/user/shared/README.md

# Module Shared - Documentation

## Fichiers

### constants.dart
Constantes utilisées dans tout le module user.

```dart
import 'package:san_digi/user/shared/constants.dart';

// Accès aux constantes
String name = UserConstants.appName; // "San Digi"
String version = UserConstants.appVersion; // "1.0.0"
```

### styles.dart
Styles réutilisables pour l'interface utilisateur.

```dart
import 'package:san_digi/user/shared/styles.dart';

// TextStyles
TextStyle titleStyle = UserStyles.pageTitle;
TextStyle sectionStyle = UserStyles.sectionTitle;
TextStyle bodyStyle = UserStyles.bodyText;
TextStyle captionStyle = UserStyles.caption;

// ButtonStyles
ButtonStyle primaryBtn = UserStyles.primaryButton(context);
ButtonStyle secondaryBtn = UserStyles.secondaryButton(context);
```

## Couleurs disponibles

Les couleurs sont définies dans `lib/shared/app_colors.dart`:

### Primaires
- `primaryBlue` - #2A7DE1
- `successGreen` - #34C759
- `alertRed` - #FF3B30

### Thème Light
- `backgroundColorLight` - #F6F8F6
- `surfaceLight` - #FFFFFF
- `textMainLight` - #111811
- `textSecondaryLight` - #618961
- `borderLight` - #DBE6DB

### Thème Dark
- `backgroundColorDark` - #102210
- `surfaceDark` - #1A2E1A
- `textMainDark` - #FFFFFF
- `textSecondaryDark` - #8BAD8B
- `borderDark` - #374151

### Gradients
- `primaryGradient` - Dégradé bleu principal

## Pagination unifiée

Système unifié de pagination réutilisable dans tous les écrans.

```dart
import 'package:san_digi/shared/pagination_utils.dart';

// Pagination par points
UnifiedPagination(
  manager: PaginationManager(
    currentPage: 0,
    totalPages: 4,
    type: PaginationType.dots,
    activeColor: AppColors.primaryBlue,
    isDarkMode: isDark,
  ),
)

// Pagination par barre de progression
UnifiedPagination(
  manager: PaginationManager(
    currentPage: 0,
    totalPages: 4,
    type: PaginationType.progressBar,
    activeColor: AppColors.primaryBlue,
    isDarkMode: isDark,
  ),
)

// Pagination par étapes
UnifiedPagination(
  manager: PaginationManager(
    currentPage: 0,
    totalPages: 4,
    type: PaginationType.steps,
    activeColor: AppColors.primaryBlue,
    isDarkMode: isDark,
    pageLabels: {
      0: 'Identité',
      1: 'Contact',
      2: 'Sécurité',
      3: 'Validation',
    },
  ),
)
```
