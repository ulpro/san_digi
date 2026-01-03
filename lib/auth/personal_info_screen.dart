import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  // Couleurs du thème - CHANGÉ EN BLEU pour cohérence
  static const Color primaryColor = Color(0xFF2A7DE1); // Changé en bleu
  static const Color primaryDark = Color(0xFF2A7DE1);
  static const Color backgroundColorLight = Color(0xFFF6F8F6);
  static const Color backgroundColorDark = Color(0xFF102210);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF162B16);
  static const Color borderLight = Color(0xFFDBE6DB);
  static const Color borderDark = Color(0xFF2A4A2A);
  static const Color textMainLight = Color(0xFF111811);
  static const Color textMainDark = Color(0xFFF0FDF0);
  static const Color textSecondaryLight = Color(0xFF618961);
  static const Color textSecondaryDark = Color(0xFF8BAD8B);

  // Contrôleurs pour les champs de formulaire
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _socialSecurityController =
      TextEditingController();
  final TextEditingController _lastConsultationController =
      TextEditingController();
  final TextEditingController _doctorController = TextEditingController();

  // État pour la validation
  final Map<String, String?> _errors = {};
  bool _isSubmitting = false;

  // Focus nodes pour la navigation
  final List<FocusNode> _focusNodes = List.generate(8, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    // Configurer les listeners pour la validation
    for (var node in _focusNodes) {
      node.addListener(_onFieldFocusChange);
    }
  }

  void _onFieldFocusChange() {
    // Valider le champ quand il perd le focus
    if (!_focusNodes.any((node) => node.hasFocus)) {
      _validateForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: isDark ? backgroundColorDark : backgroundColorLight,
        body: SafeArea(
          child: Column(
            children: [
              // App Bar
              _buildAppBar(isDark),

              // Indicateurs de progression
              _buildProgressIndicators(isDark),

              // Contenu principal avec défilement
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section: Identité
                      _buildIdentitySection(isDark),

                      // Divider
                      _buildDivider(isDark),

                      // Section: Coordonnées
                      _buildContactSection(isDark),

                      // Divider
                      _buildDivider(isDark),

                      // Section: Sécurité Médicale
                      _buildMedicalSecuritySection(isDark),

                      const SizedBox(height: 100), // Espace pour le bouton fixe
                    ],
                  ),
                ),
              ),

              // Bouton fixé en bas
              _buildBottomButton(isDark),
            ],
          ),
        ),
      ),
    );
  }

  // App Bar améliorée
  Widget _buildAppBar(bool isDark) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: BoxDecoration(
        color: isDark ? backgroundColorDark : backgroundColorLight,
        border: Border(
          bottom: BorderSide(color: isDark ? borderDark : Colors.transparent),
        ),
        boxShadow: [
          if (isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        children: [
          // Bouton retour avec animation
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark
                    ? surfaceDark.withOpacity(0.5)
                    : surfaceLight.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 18,
                  color: isDark ? textMainDark : textMainLight,
                ),
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: Text(
                'Informations Personnelles',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
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

  // Indicateurs de progression améliorés
  Widget _buildProgressIndicators(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
        color: isDark ? backgroundColorDark : backgroundColorLight,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            isDark ? backgroundColorDark : backgroundColorLight,
            (isDark ? backgroundColorDark : backgroundColorLight).withOpacity(
              0.95,
            ),
          ],
        ),
      ),
      child: Column(
        children: [
          // Barre de progression
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: isDark ? surfaceDark : surfaceLight,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Stack(
              children: [
                // Progression (25% pour étape 1/4)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, primaryDark],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Texte d'étape
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Identité',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                'Contact',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDark ? textSecondaryDark : textSecondaryLight,
                ),
              ),
              Text(
                'Sécurité',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDark ? textSecondaryDark : textSecondaryLight,
                ),
              ),
              Text(
                'Validation',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDark ? textSecondaryDark : textSecondaryLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Section: Identité
  Widget _buildIdentitySection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 20),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Identité',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isDark ? textMainDark : textMainLight,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),

        // Prénom et Nom
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                label: 'Prénom',
                hintText: 'Jean',
                controller: _firstNameController,
                focusNode: _focusNodes[0],
                errorText: _errors['firstName'],
                isDark: isDark,
                onChanged: (_) => _clearError('firstName'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                label: 'Nom',
                hintText: 'Dupont',
                controller: _lastNameController,
                focusNode: _focusNodes[1],
                errorText: _errors['lastName'],
                isDark: isDark,
                onChanged: (_) => _clearError('lastName'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Date de naissance avec sélecteur
        _buildDateField(
          label: 'Date de naissance',
          hintText: 'JJ/MM/AAAA',
          controller: _birthDateController,
          focusNode: _focusNodes[2],
          errorText: _errors['birthDate'],
          isDark: isDark,
        ),
      ],
    );
  }

  // Section: Coordonnées
  Widget _buildContactSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 20),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Coordonnées',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isDark ? textMainDark : textMainLight,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),

        // Email
        _buildTextFieldWithIcon(
          label: 'Email',
          hintText: 'jean.dupont@email.com',
          controller: _emailController,
          focusNode: _focusNodes[3],
          errorText: _errors['email'],
          icon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
          isDark: isDark,
          onChanged: (_) => _clearError('email'),
        ),
        const SizedBox(height: 20),

        // Numéro de téléphone
        _buildPhoneField(isDark),
      ],
    );
  }

  // Section: Sécurité Médicale
  Widget _buildMedicalSecuritySection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 20),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.shield_outlined, color: primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                'Sécurité Médicale',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isDark ? textMainDark : textMainLight,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),

        // Bandeau d'information
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                primaryColor.withOpacity(0.08),
                primaryColor.withOpacity(0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: primaryColor.withOpacity(0.15), width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: primaryColor,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Ces informations sont requises pour sécuriser votre accès et vérifier votre identité auprès de l\'Assurance Maladie.',
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? textSecondaryDark : textSecondaryLight,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Numéro de sécurité sociale
        _buildTextField(
          label: 'Numéro de sécurité sociale',
          hintText: '1 85 01 01 234 567 89',
          controller: _socialSecurityController,
          focusNode: _focusNodes[5],
          errorText: _errors['socialSecurity'],
          isDark: isDark,
          keyboardType: TextInputType.number,
          prefixText: '🇫🇷 ',
          onChanged: (value) {
            _clearError('socialSecurity');
            // Formatage automatique
            if (value.length == 13 && !value.contains(' ')) {
              final formatted =
                  '${value.substring(0, 1)} ${value.substring(1, 3)} ${value.substring(3, 5)} ${value.substring(5, 7)} ${value.substring(7, 10)} ${value.substring(10, 13)} ${value.substring(13)}';
              _socialSecurityController.value = TextEditingValue(
                text: formatted,
                selection: TextSelection.collapsed(offset: formatted.length),
              );
            }
          },
        ),
        const SizedBox(height: 20),

        // Dernière consultation
        _buildDateField(
          label: 'Dernière consultation (Date)',
          hintText: 'JJ/MM/AAAA',
          controller: _lastConsultationController,
          focusNode: _focusNodes[6],
          errorText: _errors['lastConsultation'],
          isDark: isDark,
        ),
        const SizedBox(height: 20),

        // Nom du praticien
        _buildTextField(
          label: 'Nom du Praticien ou Motif',
          hintText: 'Dr. Martin / Grippe...',
          controller: _doctorController,
          focusNode: _focusNodes[7],
          errorText: _errors['doctor'],
          isDark: isDark,
          onChanged: (_) => _clearError('doctor'),
        ),
      ],
    );
  }

  // Champ de téléphone avec drapeau
  Widget _buildPhoneField(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Numéro de téléphone',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? textMainDark : textMainLight,
          ),
        ),
        const SizedBox(height: 8),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Code pays avec drapeau
            GestureDetector(
              onTap: () => _showCountryPicker(isDark),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 100,
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDark ? surfaceDark : surfaceLight,
                  border: Border.all(
                    color: _errors.containsKey('phone')
                        ? Colors.red.withOpacity(0.6)
                        : isDark
                        ? borderDark
                        : borderLight,
                    width: _errors.containsKey('phone') ? 1.5 : 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('🇫🇷', style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '+33',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDark ? textMainDark : textMainLight,
                          ),
                        ),
                        Text(
                          'France',
                          style: TextStyle(
                            fontSize: 10,
                            color: isDark
                                ? textSecondaryDark
                                : textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Champ de numéro
            Expanded(
              child: TextField(
                controller: _phoneController,
                focusNode: _focusNodes[4],
                keyboardType: TextInputType.phone,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? textMainDark : textMainLight,
                ),
                decoration: InputDecoration(
                  hintText: '6 12 34 56 78',
                  hintStyle: TextStyle(
                    color: isDark ? textSecondaryDark : textSecondaryLight,
                  ),
                  errorText: _errors['phone'],
                  errorStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: isDark ? surfaceDark : surfaceLight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: isDark ? borderDark : borderLight,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red.withOpacity(0.6),
                      width: 1.5,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                onChanged: (value) {
                  _clearError('phone');
                  // Formatage automatique
                  if (value.length == 10 && !value.contains(' ')) {
                    final formatted =
                        '${value.substring(0, 1)} ${value.substring(1, 3)} ${value.substring(3, 5)} ${value.substring(5, 7)} ${value.substring(7, 9)} ${value.substring(9)}';
                    _phoneController.value = TextEditingValue(
                      text: formatted,
                      selection: TextSelection.collapsed(
                        offset: formatted.length,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Champ de date avec sélecteur
  Widget _buildDateField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required FocusNode focusNode,
    required String? errorText,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: () => _showDatePicker(context, controller, isDark),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? textMainDark : textMainLight,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: isDark ? surfaceDark : surfaceLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: errorText != null
                    ? Colors.red.withOpacity(0.6)
                    : focusNode.hasFocus
                    ? primaryColor
                    : isDark
                    ? borderDark
                    : borderLight,
                width: errorText != null || focusNode.hasFocus ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    enabled: false,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? textMainDark : textMainLight,
                    ),
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: isDark ? textSecondaryDark : textSecondaryLight,
                      ),
                      border: InputBorder.none,
                      errorText: errorText,
                      errorStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  color: errorText != null
                      ? Colors.red.withOpacity(0.6)
                      : isDark
                      ? textSecondaryDark
                      : textSecondaryLight,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Champ de texte générique amélioré
  Widget _buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required FocusNode focusNode,
    required String? errorText,
    required bool isDark,
    TextInputType keyboardType = TextInputType.text,
    String? prefixText,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? textMainDark : textMainLight,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          style: TextStyle(
            fontSize: 16,
            color: isDark ? textMainDark : textMainLight,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: isDark ? textSecondaryDark : textSecondaryLight,
            ),
            errorText: errorText,
            errorStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            filled: true,
            fillColor: isDark ? surfaceDark : surfaceLight,
            prefixText: prefixText,
            prefixStyle: TextStyle(
              fontSize: 16,
              color: isDark ? textMainDark : textMainLight,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? borderDark : borderLight,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.6),
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          onChanged: onChanged,
          onTapOutside: (_) => focusNode.unfocus(),
        ),
      ],
    );
  }

  // Champ de texte avec icône
  Widget _buildTextFieldWithIcon({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required FocusNode focusNode,
    required String? errorText,
    required IconData icon,
    required bool isDark,
    TextInputType keyboardType = TextInputType.text,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? textMainDark : textMainLight,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          style: TextStyle(
            fontSize: 16,
            color: isDark ? textMainDark : textMainLight,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: isDark ? textSecondaryDark : textSecondaryLight,
            ),
            errorText: errorText,
            errorStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            filled: true,
            fillColor: isDark ? surfaceDark : surfaceLight,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? borderDark : borderLight,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.6),
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            suffixIcon: Icon(
              icon,
              color: errorText != null
                  ? Colors.red.withOpacity(0.6)
                  : isDark
                  ? textSecondaryDark
                  : textSecondaryLight,
              size: 20,
            ),
          ),
          onChanged: onChanged,
          onTapOutside: (_) => focusNode.unfocus(),
        ),
      ],
    );
  }

  // Divider stylisé
  Widget _buildDivider(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Divider(
        color: isDark
            ? borderDark.withOpacity(0.5)
            : borderLight.withOpacity(0.5),
        height: 1,
        thickness: 1,
      ),
    );
  }

  // Bouton en bas avec animations
  Widget _buildBottomButton(bool isDark) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? backgroundColorDark : backgroundColorLight,
        border: Border(
          top: BorderSide(
            color: isDark ? borderDark : borderLight.withOpacity(0.5),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: _isSubmitting
                ? [primaryColor.withOpacity(0.7), primaryDark.withOpacity(0.7)]
                : [primaryColor, primaryDark],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: _isSubmitting ? null : _submitForm,
            borderRadius: BorderRadius.circular(16),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _isSubmitting
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(
                            backgroundColorDark.withOpacity(0.8),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Suivant',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: backgroundColorDark,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: backgroundColorDark,
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

  // Méthodes utilitaires
  void _showDatePicker(
    BuildContext context,
    TextEditingController controller,
    bool isDark,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              surface: isDark ? surfaceDark : surfaceLight,
              onSurface: isDark ? textMainDark : textMainLight,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: isDark ? surfaceDark : surfaceLight,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.text =
          '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
    }
  }

  void _showCountryPicker(bool isDark) {
    // Implémentez un sélecteur de pays ici
    // Pour l'instant, c'est juste un placeholder
  }

  void _clearError(String field) {
    if (_errors.containsKey(field)) {
      setState(() {
        _errors.remove(field);
      });
    }
  }

  // CORRECTION IMPORTANTE : Changé de void à bool
  bool _validateForm() {
    final errors = <String, String>{};

    if (_firstNameController.text.isEmpty) {
      errors['firstName'] = 'Le prénom est requis';
    }

    if (_lastNameController.text.isEmpty) {
      errors['lastName'] = 'Le nom est requis';
    }

    if (_birthDateController.text.isEmpty) {
      errors['birthDate'] = 'La date de naissance est requise';
    }

    if (_emailController.text.isEmpty) {
      errors['email'] = 'L\'email est requis';
    } else if (!RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(_emailController.text)) {
      errors['email'] = 'Email invalide';
    }

    if (_phoneController.text.isEmpty) {
      errors['phone'] = 'Le téléphone est requis';
    } else if (!RegExp(
      r'^[0-9\s]{10,}$',
    ).hasMatch(_phoneController.text.replaceAll(' ', ''))) {
      errors['phone'] = 'Numéro invalide';
    }

    if (_socialSecurityController.text.isEmpty) {
      errors['socialSecurity'] = 'Le numéro de sécurité sociale est requis';
    } else if (_socialSecurityController.text.replaceAll(' ', '').length !=
        15) {
      errors['socialSecurity'] = 'Numéro invalide (15 chiffres requis)';
    }

    setState(() {
      _errors.clear();
      _errors.addAll(errors);
    });

    return errors.isEmpty; // CORRECTION : Retourne bool
  }

  Future<void> _submitForm() async {
    // CORRECTION : Maintenant _validateForm() retourne bool
    if (!_validateForm()) {
      // Scroll vers la première erreur
      final firstErrorField = _errors.keys.first;
      final index = _getFieldIndex(firstErrorField);
      if (index != -1) {
        _focusNodes[index].requestFocus();
      }
      return;
    }

    setState(() => _isSubmitting = true);

    // Simuler un appel API
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isSubmitting = false);

    // Pour l'instant, juste un message de succès
    if (!mounted) return;

    // CORRECTION : Utiliser Theme.of(context) au lieu de isDark
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: primaryColor),
            const SizedBox(width: 12),
            const Text('Informations enregistrées avec succès'),
          ],
        ),
        backgroundColor: isDark ? surfaceDark : surfaceLight, // CORRIGÉ
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  int _getFieldIndex(String field) {
    switch (field) {
      case 'firstName':
        return 0;
      case 'lastName':
        return 1;
      case 'birthDate':
        return 2;
      case 'email':
        return 3;
      case 'phone':
        return 4;
      case 'socialSecurity':
        return 5;
      case 'lastConsultation':
        return 6;
      case 'doctor':
        return 7;
      default:
        return -1;
    }
  }

  @override
  void dispose() {
    // Nettoyage
    for (var node in _focusNodes) {
      node.removeListener(_onFieldFocusChange);
      node.dispose();
    }

    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _socialSecurityController.dispose();
    _lastConsultationController.dispose();
    _doctorController.dispose();

    super.dispose();
  }
}
