import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';

class GenderSelectorDialog extends StatefulWidget {
  final String? selectedGender;

  const GenderSelectorDialog({super.key, this.selectedGender});

  @override
  State<GenderSelectorDialog> createState() => _GenderSelectorDialogState();
}

class _GenderSelectorDialogState extends State<GenderSelectorDialog> {
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.selectedGender;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: NeumorphicColors.card,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              offset: const Offset(4, 4),
              blurRadius: 20,
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.05),
              offset: const Offset(-4, -4),
              blurRadius: 20,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                NeumorphicContainer(
                  width: 48,
                  height: 48,
                  child: const Icon(
                    Icons.wc_rounded,
                    color: NeumorphicColors.purple,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Gender',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: NeumorphicColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Choose your gender',
                        style: TextStyle(
                          fontSize: 14,
                          color: NeumorphicColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Gender Options
            _buildGenderOption(
              label: 'Male',
              icon: Icons.male_rounded,
              color: NeumorphicColors.blue,
            ),
            const SizedBox(height: 12),
            _buildGenderOption(
              label: 'Female',
              icon: Icons.female_rounded,
              color: NeumorphicColors.coral,
            ),
            const SizedBox(height: 12),
            _buildGenderOption(
              label: 'Other',
              icon: Icons.transgender_rounded,
              color: NeumorphicColors.purple,
            ),

            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: NeumorphicColors.background,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.4),
                            offset: const Offset(2, 2),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: const Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: NeumorphicColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: _selectedGender != null
                        ? () => Navigator.pop(context, _selectedGender)
                        : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        gradient: _selectedGender != null
                            ? const LinearGradient(
                                colors: [
                                  NeumorphicColors.purple,
                                  NeumorphicColors.purpleLight,
                                ],
                              )
                            : null,
                        color: _selectedGender == null
                            ? NeumorphicColors.textTertiary
                            : null,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: _selectedGender != null
                            ? [
                                BoxShadow(
                                  color: NeumorphicColors.purple.withValues(
                                    alpha: 0.4,
                                  ),
                                  offset: const Offset(0, 4),
                                  blurRadius: 12,
                                ),
                              ]
                            : null,
                      ),
                      child: const Text(
                        'Confirm',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderOption({
    required String label,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = _selectedGender == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = label;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? NeumorphicColors.background
              : NeumorphicColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    offset: const Offset(2, 2),
                    blurRadius: 6,
                  ),
                ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [
                          color.withValues(alpha: 0.3),
                          color.withValues(alpha: 0.1),
                        ],
                      )
                    : null,
                color: isSelected ? null : NeumorphicColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? color : NeumorphicColors.textTertiary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  color: isSelected
                      ? NeumorphicColors.textPrimary
                      : NeumorphicColors.textSecondary,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: color, size: 24),
          ],
        ),
      ),
    );
  }
}

// Helper function to show dialog
Future<String?> showGenderSelector(
  BuildContext context, {
  String? currentGender,
}) async {
  return await showDialog<String>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.7),
    builder: (context) => GenderSelectorDialog(selectedGender: currentGender),
  );
}
