import 'package:flutter/material.dart';
import '../constants.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String _selectedFilter = 'Toutes';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return AlertDialog(
      title: Text(
        'Filtrer les ordonnances',
        style: TextStyle(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: theme.colorScheme.surface,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFilterOption('Toutes', primaryColor),
          _buildFilterOption('Actives seulement', primaryColor),
          _buildFilterOption('À renouveler', primaryColor),
          _buildFilterOption('Terminées', primaryColor),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Annuler',
            style: TextStyle(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, _selectedFilter);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Appliquer'),
        ),
      ],
    );
  }

  Widget _buildFilterOption(String label, Color primaryColor) {
    final isSelected = _selectedFilter == label;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: isSelected ? primaryColor : null,
        size: 20,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: isSelected ? primaryColor : null,
        ),
      ),
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
    );
  }
}