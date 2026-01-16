import 'package:flutter/material.dart';
import '../../prescription/constants.dart';

class BottomActionBar extends StatelessWidget {
  final bool isCompleted;
  final bool canRenew;
  final VoidCallback onRenew;
  final VoidCallback onMarkCompleted;
  final VoidCallback onShare;

  const BottomActionBar({
    super.key,
    required this.isCompleted,
    required this.canRenew,
    required this.onRenew,
    required this.onMarkCompleted,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(PrescriptionConstants.mediumPadding),
      decoration: BoxDecoration(
        color: isDark 
            ? PrescriptionColors.cardDark 
            : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark
                ? PrescriptionColors.borderDark
                : PrescriptionColors.dividerLight,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isCompleted)
            Container(
              padding: const EdgeInsets.all(PrescriptionConstants.mediumPadding),
              decoration: BoxDecoration(
                color: PrescriptionColors.successColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(PrescriptionConstants.smallCardBorderRadius),
                border: Border.all(
                  color: PrescriptionColors.successColor.withOpacity(0.2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_rounded, 
                      color: PrescriptionColors.successColor, 
                      size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Ordonnance terminée',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: PrescriptionColors.successColor,
                    ),
                  ),
                ],
              ),
            )
          else
            Row(
              children: [
                if (canRenew)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onRenew,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(
                          color: PrescriptionColors.primaryColor.withOpacity(0.3),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              PrescriptionConstants.buttonBorderRadius),
                        ),
                      ),
                      icon: Icon(
                        Icons.autorenew_rounded,
                        color: PrescriptionColors.primaryColor,
                      ),
                      label: Text(
                        'Renouveler',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: PrescriptionColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 12),
                Expanded(
                  flex: canRenew ? 1 : 2,
                  child: ElevatedButton.icon(
                    onPressed: onMarkCompleted,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrescriptionColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            PrescriptionConstants.buttonBorderRadius),
                      ),
                      elevation: 2,
                      shadowColor: PrescriptionColors.primaryColor.withOpacity(0.3),
                    ),
                    icon: const Icon(Icons.check_rounded, size: 20),
                    label: Text(
                      'Terminer',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}