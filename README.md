# san_digi

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
architecture des pages 
# 📊 RECAP COMPLET DE L'ARCHITECTURE SAN DIGI

## 🏗️ **STRUCTURE GLOBALE DU PROJET**

```
lib/
├── main.dart                          # Point d'entrée
├── shared/                           # Fichiers partagés
│   ├── theme.dart                   # Configuration du thème
│   └── navigation.dart              # Gestion navigation
│
├── home/                             # Module Accueil
│   ├── home_screen.dart             # Écran principal
│   ├── models.dart                  # Modèles de données
│   ├── data.dart                    # Données statiques
│   ├── constants.dart               # Constantes spécifiques
│   └── widgets/                     # Widgets réutilisables
│       ├── welcome_section.dart     # Section bienvenue
│       ├── stats_cards.dart         # Cartes statistiques
│       ├── health_indicators.dart   # Indicateurs santé
│       ├── appointment_card.dart    # Carte rendez-vous
│       ├── treatments_section.dart  # Section traitements
│       ├── medication_card.dart     # Carte médicament
│       ├── prescription_card.dart   # Carte ordonnance
│       ├── activity_item.dart       # Item activité
│       └── fab_menu.dart           # Menu flottant
│
├── treatment/                        # Module Traitements
│   ├── treatment_screen.dart        # Écran traitements
│   ├── models.dart                  # Modèles spécifiques
│   ├── data.dart                    # Données traitements
│   ├── constants.dart               # Constantes traitements
│   └── widgets/                     # Widgets traitements
│       ├── alert_banner.dart        # Bannière alerte
│       ├── dose_card.dart           # Carte prise médicament
│       ├── adherence_section.dart   # Section observance
│       ├── treatment_card.dart      # Carte traitement
│       ├── treatment_history_section.dart # Historique
│       ├── upcoming_doses_section.dart    # Prises à venir
│       └── add_medication_form.dart       # Formulaire ajout
│
├── prescription/                     # Module Ordonnances
│   ├── prescription_screen.dart     # Écran liste ordonnances
│   ├── models.dart                  # Modèles ordonnances
│   ├── data.dart                    # Données ordonnances
│   ├── constants.dart               # Constantes ordonnances
│   └── widgets/                     # Widgets ordonnances
│       ├── stat_card.dart           # Carte statistique
│       ├── header_stats.dart        # En-tête stats
│       ├── prescription_card.dart   # Carte ordonnance
│       ├── empty_state.dart         # État vide
│       └── filter_dialog.dart       # Dialogue filtre
│
├── prescription_detail/              # Détail ordonnance
│   ├── screens/
│   │   └── prescription_detail_screen.dart  # Écran détail
│   └── widgets/                     # Widgets détail
│       ├── header_card.dart         # Carte en-tête
│       ├── info_section.dart        # Section infos
│       ├── medication_card.dart     # Carte médicament
│       ├── medications_section.dart # Section médicaments
│       ├── instructions_section.dart # Instructions
│       ├── qr_code_section.dart     # QR Code
│       ├── bottom_action_bar.dart   # Barre actions
│       └── dialogs/                 # Dialogues spécifiques
│           ├── renew_prescription_dialog.dart
│           └── mark_completed_dialog.dart
│
├── rendezvous/                      # Module Rendez-vous
│   ├── rendezvous_screen.dart       # Écran rendez-vous
│   ├── models.dart                  # Modèles RDV
│   ├── data.dart                    # Données RDV
│   ├── constants.dart               # Constantes RDV
│   └── widgets/                     # Widgets RDV
│       ├── today_section.dart       # Section aujourd'hui
│       ├── filter_section.dart      # Filtres
│       ├── appointment_card.dart    # Carte RDV
│       ├── empty_state.dart         # État vide
│       ├── detail_sheet.dart        # Détail RDV
│       ├── floating_action_button.dart # Bouton flottant
│       └── dialogs/                 # Dialogues RDV
│           ├── reminder_dialog.dart       # Rappel
│           ├── confirm_dialog.dart        # Confirmation
│           ├── cancel_dialog.dart         # Annulation
│           ├── medical_report_dialog.dart # Compte-rendu
│           └── new_appointment_sheet.dart # Nouveau RDV
│
└── profile/                         # Module Profil santé
    ├── profile_screen.dart          # Écran profil
    ├── models.dart                  # Modèles profil
    ├── data.dart                    # Données profil
    ├── constants.dart               # Constantes profil
    └── widgets/                     # Widgets profil
        ├── app_bar.dart             # AppBar personnalisée
        ├── qr_code_section.dart     # Section QR Code
        ├── medical_info_section.dart # Infos médicales
        ├── medical_info_row.dart    # Ligne info médicale
        ├── emergency_contacts_section.dart # Contacts urgence
        ├── contact_card.dart        # Carte contact
        ├── healthcare_institutions_section.dart # Établissements
        ├── institution_card.dart    # Carte établissement
        ├── emergency_button.dart    # Bouton urgence
        ├── share_button.dart        # Bouton partage
        └── dialogs/                 # Dialogues profil
            ├── edit_medical_info_sheet.dart   # Édition infos
            ├── call_contact_dialog.dart       # Appel contact
            ├── institution_details_sheet.dart  # Détail établissement
            └── emergency_mode_dialog.dart      # Mode urgence
```

## 🎯 **FONCTIONNALITÉS PAR MODULE**

### **1. HOME - Tableau de bord principal**
**Fichier principal**: `home_screen.dart`

**Widgets clés**:
- `WelcomeSection`: Accueil utilisateur et statut profil
- `StatsCards`: Statistiques (traitements, RDV, prescriptions)
- `HealthIndicators`: Indicateurs santé (glycémie, tension, etc.)
- `AppointmentCard`: Prochain rendez-vous avec animation
- `TreatmentsSection`: Traitements en cours avec onglets
- `PrescriptionCard`: Prescriptions actives
- `ActivityItem`: Activités récentes
- `FabMenu`: Menu flottant pour actions rapides

**Données**: `data.dart` - Contient les listes de traitements, prescriptions, indicateurs
**Constantes**: `constants.dart` - Définit les couleurs et valeurs réutilisables
**Modèles**: `models.dart` - Classes typées pour toutes les données

---

### **2. TREATMENT - Gestion des traitements**
**Fichier principal**: `treatment_screen.dart`

**Widgets clés**:
- `AlertBanner`: Alertes pour renouvellements urgents
- `DoseCard`: Carte de prise de médicament avec actions
- `AdherenceSection`: Taux d'observance du traitement
- `TreatmentCard`: Informations détaillées d'un traitement
- `TreatmentHistorySection`: Historique des traitements actifs
- `UpcomingDosesSection`: Prises de médicaments à venir
- `AddMedicationForm`: Formulaire d'ajout de médicament

**Fonctions principales**:
- Marquage des médicaments pris
- Suivi de l'observance
- Alertes de renouvellement
- Historique des traitements

---

### **3. PRESCRIPTION - Gestion des ordonnances**
**Fichier principal**: `prescription_screen.dart`

**Widgets clés**:
- `StatCard`: Statistiques (actives, à renouveler, total)
- `HeaderStats`: En-tête avec statistiques regroupées
- `PrescriptionCard`: Carte d'ordonnance avec statut
- `EmptyState`: État vide avec proposition d'action
- `FilterDialog`: Filtrage des ordonnances par statut

**Fonctions principales**:
- Vue liste des ordonnances
- Filtrage par statut (actives, terminées, etc.)
- Statistiques de suivi
- Navigation vers le détail

---

### **4. PRESCRIPTION_DETAIL - Détail d'une ordonnance**
**Fichier principal**: `prescription_detail_screen.dart`

**Widgets clés**:
- `HeaderCard`: En-tête avec infos principales et statut
- `InfoSection`: Informations générales (renouvellements, etc.)
- `MedicationCard`: Détail d'un médicament prescrit
- `MedicationsSection`: Liste des médicaments prescrits
- `InstructionsSection`: Instructions particulières
- `QRCodeSection`: QR Code pour pharmacie
- `BottomActionBar`: Actions (renouveler, terminer, partager)

**Fonctions principales**:
- Vue détaillée d'une ordonnance
- QR Code pour présentation en pharmacie
- Renouvellement d'ordonnance
- Partage des informations

---

### **5. RENDEZVOUS - Gestion des rendez-vous**
**Fichier principal**: `rendezvous_screen.dart`

**Widgets clés**:
- `TodaySection`: Rendez-vous du jour
- `FilterSection`: Filtres (à venir, passés, annulés)
- `AppointmentCard`: Carte détaillée d'un RDV
- `EmptyState`: État vide adapté au filtre
- `DetailSheet`: Détail complet d'un RDV
- `AppointmentFAB`: Bouton pour nouveau RDV

**Dialogues**:
- `ReminderDialog`: Programmation de rappel
- `ConfirmDialog`: Confirmation de RDV
- `CancelDialog`: Annulation de RDV
- `MedicalReportDialog`: Compte-rendu médical
- `NewAppointmentSheet`: Formulaire nouveau RDV

**Fonctions principales**:
- Agenda médical complet
- Confirmation/annulation de RDV
- Rappels programmables
- Détails et compte-rendus

---

### **6. PROFILE - Code santé et informations**
**Fichier principal**: `profile_screen.dart`

**Widgets clés**:
- `ProfileAppBar`: AppBar personnalisée avec menu
- `QRCodeSection`: QR Code santé responsive
- `MedicalInfoSection`: Informations médicales vitales
- `EmergencyContactsSection`: Contacts d'urgence
- `HealthcareInstitutionsSection`: Établissements de suivi
- `EmergencyButton`: Bouton mode urgence
- `ShareButton`: Boutons de partage

**Dialogues et Sheets**:
- `EditMedicalInfoSheet`: Édition des infos médicales
- `CallContactDialog`: Appel d'un contact d'urgence
- `InstitutionDetailsSheet`: Détail d'un établissement
- `EmergencyModeDialog`: Activation du mode urgence

**Fonctions principales**:
- Code santé QR pour urgences
- Informations médicales vitales
- Contacts d'urgence rapides
- Mode urgence intégré

## 🔧 **ARCHITECTURE COMMUNE À TOUS LES MODULES**

### **Pattern Structure**
Chaque module suit le même pattern:

```
Module/
├── module_screen.dart          # Écran principal (Stateful)
├── models.dart                 # Classes typées
├── data.dart                   # Données statiques/mock
├── constants.dart              # Constantes spécifiques
└── widgets/                    # Composants réutilisables
    ├── small_widget.dart      # Petits widgets
    ├── sections.dart          # Sections complexes
    └── dialogs/               # Dialogues spécifiques
```

### **Avantages de cette architecture**

1. **Séparation des responsabilités**
   - UI dans les widgets
   - Logique dans les modèles
   - Données dans data.dart
   - Constantes centralisées

2. **Réutilisabilité**
   - Widgets indépendants
   - Composants testables
   - Code DRY (Don't Repeat Yourself)

3. **Maintenabilité**
   - Fichiers courts et ciblés
   - Navigation facile
   - Modifications locales

4. **Évolutivité**
   - Ajout facile de nouvelles fonctionnalités
   - Tests unitaires simplifiés
   - Intégration d'APIs future

## 🎨 **DESIGN SYSTEM UNIFIÉ**

### **Couleurs principales** (dans chaque constants.dart)
```dart
static const Color primaryColor = Color(0xFF2A7DE1);
static const Color healthGreen = Color(0xFF4CD964);
static const Color warningOrange = Color(0xFFFF9500);
static const Color alertRed = Color(0xFFFF3B30);
static const Color successGreen = Color(0xFF34C759);
```

### **Espacements cohérents**
```dart
static const double defaultPadding = 16.0;
static const double mediumPadding = 12.0;
static const double smallPadding = 8.0;
static const double cardBorderRadius = 16.0;
```

## 📱 **RESPONSIVE DESIGN**

Chaque widget gère:
- **Adaptation aux tailles d'écran** via `MediaQuery`
- **Layouts conditionnels** pour mobile/tablette
- **Tailles dynamiques** basées sur la largeur d'écran
- **Mode sombre/clair** supporté partout

## 🔄 **NAVIGATION ENTRE MODULES**

```
HomeScreen
    ├── TreatmentScreen
    │   └── (Gestion médicaments)
    ├── PrescriptionScreen
    │   └── PrescriptionDetailScreen
    │       ├── Partage
    │       ├── Renouvellement
    │       └── Marquage terminé
    ├── RendezVousScreen
    │   ├── Détail RDV
    │   ├── Confirmation
    │   └── Nouveau RDV
    └── ProfileScreen
        ├── Édition infos
        ├── Contacts urgence
        └── Mode urgence
```

## 🚀 **NEXT STEPS POSSIBLES**

1. **Intégration API**
   - Connexion backend
   - Synchronisation données
   - Authentification

2. **Notifications**
   - Rappels médicaments
   - Alertes RDV
   - Notifications push

3. **Analytics**
   - Suivi observance
   - Statistiques santé
   - Rapports

4. **Internationalisation**
   - Multi-langues
   - Adaptation régionale

5. **Accessibilité**
   - Support VoiceOver
   - Taille texte dynamique
   - Contrastes élevés

---

## ✅ **RÉSUMÉ DES AVANTAGES**

| Aspect | Avantage |
|--------|----------|
| **Organisation** | Structure claire et prévisible |
| **Maintenance** | Fichiers courts, responsabilités uniques |
| **Équipe** | Travail parallèle possible |
| **Tests** | Composants isolés testables |
| **Performance** | Build séparé, hot reload rapide |
| **Évolution** | Ajout facile de nouvelles features |

Votre application San Digi est maintenant **parfaitement structurée, scalable et maintenable** ! 🎉 Chaque module est autonome tout en partageant une architecture commune, ce qui facilite grandement le développement, les tests et l'évolution future.