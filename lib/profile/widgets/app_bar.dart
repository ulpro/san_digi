import 'package:flutter/material.dart';
import '../constants.dart';

class ProfileAppBar extends StatelessWidget {
  final bool isDark;
  final double screenWidth;
  final VoidCallback onBack;
  final Function(String) onMenuAction;

  const ProfileAppBar({
    super.key,
    required this.isDark,
    required this.screenWidth,
    required this.onBack,
    required this.onMenuAction,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = screenWidth < 360 ? 20.0 : 24.0;
    final fontSize = screenWidth < 360 ? 18.0 : 20.0;
    final padding = screenWidth < 360 
        ? const EdgeInsets.fromLTRB(12, 40, 12, 12)
        : const EdgeInsets.fromLTRB(16, 48, 16, 16);
    final buttonSize = screenWidth < 360 ? 44.0 : 48.0;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: isDark ? ProfileColors.backgroundColorDark : ProfileColors.backgroundColorLight,
        border: Border(
          bottom: BorderSide(
            color: isDark ? ProfileColors.borderDark : ProfileColors.borderLight,
          ),
        ),
      ),
      child: Row(
        children: [
          // Bouton retour
          _buildIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onPressed: onBack,
            size: buttonSize,
            isDark: isDark,
          ),
          const Spacer(),
          // Titre
          Flexible(
            child: Text(
              'Mon Code Santé',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                color: isDark ? ProfileColors.textLight : ProfileColors.textMainColor,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          // Bouton options
          Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? ProfileColors.cardDark : const Color(0xFFF3F4F6),
            ),
            child: PopupMenuButton<String>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ProfileConstants.smallCardBorderRadius),
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit_rounded, size: iconSize),
                      const SizedBox(width: 8),
                      const Flexible(
                        child: Text(
                          'Modifier les informations',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'share',
                  child: Row(
                    children: [
                      Icon(Icons.share_rounded, size: iconSize),
                      const SizedBox(width: 8),
                      const Flexible(
                        child: Text(
                          'Partager mon code santé',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'export',
                  child: Row(
                    children: [
                      Icon(Icons.download_rounded, size: iconSize),
                      const SizedBox(width: 8),
                      const Flexible(
                        child: Text(
                          'Exporter mes données',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              onSelected: onMenuAction,
              child: Icon(
                Icons.more_vert_rounded,
                color: isDark ? ProfileColors.textLight : ProfileColors.textMainColor,
                size: iconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    required double size,
    required bool isDark,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark ? ProfileColors.cardDark : const Color(0xFFF3F4F6),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: isDark ? ProfileColors.textLight : ProfileColors.textMainColor,
          size: size * 0.4,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }
}