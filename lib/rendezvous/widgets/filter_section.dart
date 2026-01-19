import 'package:flutter/material.dart';
import '../constants.dart';
import '../../models/appointment_model.dart';

class FilterSection extends StatefulWidget {
  final int selectedFilterIndex;
  final Function(int) onFilterChanged;

  const FilterSection({
    super.key,
    required this.selectedFilterIndex,
    required this.onFilterChanged,
  });

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tous les rendez-vous',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: isDark
                ? RendezVousColors.textPrimaryLight
                : RendezVousColors.textPrimaryDark,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: RendezVousConstants.mediumPadding),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: AppointmentFilter.filters.map((filter) {
              final isSelected = widget.selectedFilterIndex == filter.index;

              return Padding(
                padding: EdgeInsets.only(
                  right: filter.index < AppointmentFilter.filters.length - 1
                      ? RendezVousConstants.smallPadding
                      : 0,
                ),
                child: FilterChip(
                  label: Text(
                    filter.label,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : RendezVousColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    widget.onFilterChanged(filter.index);
                  },
                  backgroundColor: isDark
                      ? RendezVousColors.cardDark
                      : Colors.white,
                  selectedColor: RendezVousColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected
                          ? RendezVousColors.primaryColor
                          : (isDark
                                ? RendezVousColors.borderDark
                                : RendezVousColors.borderLight),
                    ),
                  ),
                  checkmarkColor: Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
