import 'package:flutter/material.dart';

class VPNCertificateScreen extends StatefulWidget {
  const VPNCertificateScreen({super.key});

  @override
  State<VPNCertificateScreen> createState() => _VPNCertificateScreenState();
}

class _VPNCertificateScreenState extends State<VPNCertificateScreen> {
  // Couleurs du thème - CHANGÉ EN BLEU pour cohérence
  static const Color primaryColor = Color(0xFF2A7DE1); // Changé en bleu
  static const Color primaryDark = Color(0xFF2A7DE1);
  static const Color backgroundColorLight = Color(0xFFF6F8F6);
  static const Color backgroundColorDark = Color(0xFF102210);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1A2E1A);
  static const Color textMainLight = Color(0xFF111811);
  static const Color textMainDark = Color(0xFFFFFFFF);
  static const Color textSecondaryLight = Color(0xFF618961);
  static const Color textSecondaryDark = Color(0xFF8BAD8B);
  static const Color blueLight = Color(0xFFDBEAFE);
  static const Color blueDark = Color(0xFF1E3A8A);
  static const Color blueTextLight = Color(0xFF1E40AF);
  static const Color blueTextDark = Color(0xFF60A5FA);

  bool _isDownloading = false;
  double _downloadProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? backgroundColorDark : backgroundColorLight,
      body: SafeArea(
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
                    // Icône de succès avec effet de glow
                    _buildSuccessIcon(isDark),
                    
                    // Titre et description
                    _buildHeaderText(isDark),
                    
                    // Carte du certificat VPN
                    _buildCertificateCard(isDark),
                    
                    // Bannière d'information
                    _buildInfoBanner(isDark),
                    
                    // Timeline de progression
                    _buildProgressTimeline(isDark),
                    
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            
            // Bouton de retour
            _buildBottomButton(isDark),
          ],
        ),
      ),
    );
  }

  // App Bar
  Widget _buildAppBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: BoxDecoration(
        color: isDark ? backgroundColorDark.withOpacity(0.95) : surfaceLight,
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.white.withOpacity(0.1) : const Color(0xFFDBE6DB),
            width: 1,
          ),
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        children: [
          // Bouton retour
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withOpacity(0.1) : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          
          Expanded(
            child: Center(
              child: Text(
                'Confirmation',
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

  // Icône de succès avec effet
  Widget _buildSuccessIcon(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Effet de glow
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
          ),
          
          // Cercle principal
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.check,
                size: 40,
                color: Colors.white,
                weight: 700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Texte d'en-tête
  Widget _buildHeaderText(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            'Accès VPN validé',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: isDark ? textMainDark : textMainLight,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Vérification terminée. Ce certificat est nécessaire pour établir une connexion sécurisée et protéger l\'accès à vos données médicales.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: isDark ? textSecondaryDark : textSecondaryLight,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // Carte du certificat
  Widget _buildCertificateCard(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? surfaceDark : surfaceLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.1) : const Color(0xFFF3F4F6),
          width: 1,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // En-tête de la carte
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icône VPN
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isDark 
                            ? const Color(0xFF1E3A8A).withOpacity(0.2)
                            : const Color(0xFFDBEAFE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.vpn_key_outlined,
                          size: 28,
                          color: isDark ? blueTextDark : blueTextLight,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // Infos du certificat
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Certificat VPN',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark ? textMainDark : textMainLight,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Fichier de configuration • 48 KB',
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? textSecondaryDark : textSecondaryLight,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.lock_outline,
                                size: 14,
                                color: const Color(0xFF10B981),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Accès Sécurisé',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF10B981),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Bouton de téléchargement
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: _isDownloading
                        ? LinearGradient(
                            colors: [
                              primaryColor.withOpacity(0.7),
                              primaryDark.withOpacity(0.7),
                            ],
                          )
                        : LinearGradient(
                            colors: [primaryColor, primaryDark],
                          ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: _isDownloading
                        ? []
                        : [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      onTap: _isDownloading ? null : _downloadCertificate,
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        children: [
                          // Barre de progression
                          if (_isDownloading)
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: MediaQuery.of(context).size.width * _downloadProgress,
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          
                          // Contenu du bouton
                          Center(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: _isDownloading
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation(
                                              Colors.white.withOpacity(0.8),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${(_downloadProgress * 100).toStringAsFixed(0)}%',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.download_outlined,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Télécharger le certificat',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Pied de carte
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.05) : const Color(0xFFF9FAFB),
              border: Border(
                top: BorderSide(
                  color: isDark ? Colors.white.withOpacity(0.05) : const Color(0xFFF3F4F6),
                ),
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.security_outlined,
                  size: 18,
                  color: isDark ? textSecondaryDark : textSecondaryLight,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Usage personnel strict. Expire dans 30 jours.',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? textSecondaryDark : textSecondaryLight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bannière d'information
  Widget _buildInfoBanner(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark 
            ? const Color(0xFF1E3A8A).withOpacity(0.1)
            : const Color(0xFFDBEAFE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark 
              ? const Color(0xFF1E3A8A).withOpacity(0.3)
              : const Color(0xFF93C5FD),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: isDark ? blueTextDark : blueTextLight,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pourquoi ce certificat ?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? const Color(0xFFE5E7EB) : const Color(0xFF1E40AF),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ce fichier agit comme une clé numérique pour chiffrer votre connexion. Il est indispensable pour garantir la confidentialité absolue des données patients lors de l\'accès aux services.',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF3B82F6),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Timeline de progression
  Widget _buildProgressTimeline(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ÉTAT DE LA DEMANDE',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? textSecondaryDark : textSecondaryLight,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 20),
          
          // Timeline
          Column(
            children: [
              // Étape 1
              _buildTimelineStep(
                number: 1,
                title: 'Demande soumise',
                description: 'Envoyé le 24 Oct, 09:30',
                isCompleted: true,
                isLast: false,
                isDark: isDark,
              ),
              
              // Étape 2
              _buildTimelineStep(
                number: 2,
                title: 'Vérification complétée',
                description: 'Validé par le service IT',
                isCompleted: true,
                isLast: false,
                isDark: isDark,
              ),
              
              // Étape 3 (actuelle)
              _buildTimelineStep(
                number: 3,
                title: 'Certificat VPN prêt',
                description: 'Disponible au téléchargement',
                isCompleted: true,
                isCurrent: true,
                isLast: true,
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep({
    required int number,
    required String title,
    required String description,
    required bool isCompleted,
    bool isCurrent = false,
    required bool isLast,
    required bool isDark,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ligne verticale et icône
        Column(
          children: [
            // Ligne supérieure (sauf pour le premier)
            if (number > 1)
              Container(
                width: 2,
                height: 20,
                color: isCompleted ? primaryColor : (isDark ? Colors.grey[700] : Colors.grey[300]),
              ),
            
            // Cercle avec icône
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isCurrent
                    ? primaryColor
                    : (isCompleted
                        ? primaryColor.withOpacity(0.2)
                        : (isDark ? Colors.grey[700] : Colors.grey[200])),
                shape: BoxShape.circle,
                border: isCurrent
                    ? Border.all(
                        color: primaryColor.withOpacity(0.3),
                        width: 4,
                      )
                    : null,
                boxShadow: isCurrent
                    ? [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.2),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: isCurrent
                    ? Icon(
                        Icons.vpn_lock_outlined,
                        size: 16,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.check,
                        size: 16,
                        color: isCompleted
                            ? primaryColor
                            : (isDark ? Colors.grey[500] : Colors.grey[400]),
                      ),
              ),
            ),
            
            // Ligne inférieure (sauf pour le dernier)
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? primaryColor : (isDark ? Colors.grey[700] : Colors.grey[300]),
              ),
          ],
        ),
        
        const SizedBox(width: 12),
        
        // Texte
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: isLast ? 0 : 40,
              top: 6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? textMainDark : textMainLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? textSecondaryDark : textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Bouton de retour en bas
  Widget _buildBottomButton(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? backgroundColorDark : surfaceLight,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.white.withOpacity(0.1) : const Color(0xFFDBE6DB),
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: () {
              // Retour à l'accueil
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            borderRadius: BorderRadius.circular(16),
            child: Center(
              child: Text(
                'Retour à l\'accueil',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDark ? textMainDark : textMainLight,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Simuler le téléchargement
  Future<void> _downloadCertificate() async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
    });

    // Simulation de téléchargement progressif
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        _downloadProgress = i / 100;
      });
    }

    // Téléchargement terminé
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _isDownloading = false;
    });

    // Afficher une notification de succès
    if (!mounted) return;
    
    // CORRECTION : Récupérer isDark localement
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: primaryColor),
            const SizedBox(width: 12),
            const Text('Certificat téléchargé avec succès'),
          ],
        ),
        backgroundColor: isDark ? surfaceDark : surfaceLight, // CORRIGÉ
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}