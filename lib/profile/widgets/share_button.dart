import 'package:flutter/material.dart';
import '../constants.dart';

class ShareButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isDark;
  final double size;

  const ShareButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.isDark,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark ? ProfileColors.cardDark : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.1 : 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: ProfileColors.primaryColor, size: size * 0.45),
        padding: EdgeInsets.zero,
      ),
    );
  }
}