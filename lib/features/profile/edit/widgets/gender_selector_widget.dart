import 'package:flutter/material.dart';
import '../../../../core/widgets/neumorphic_widgets.dart';
import '../../widgets/gender_selector_dialog.dart';

class GenderSelectorWidget extends StatelessWidget {
  final String? selectedGender;
  final Function(String?) onGenderSelected;

  const GenderSelectorWidget({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  IconData _getGenderIcon(String? gender) {
    switch (gender) {
      case 'Male':
        return Icons.male_rounded;
      case 'Female':
        return Icons.female_rounded;
      case 'Other':
        return Icons.transgender_rounded;
      default:
        return Icons.wc_outlined;
    }
  }

  Color _getGenderColor(String? gender) {
    switch (gender) {
      case 'Male':
        return NeumorphicColors.blue;
      case 'Female':
        return NeumorphicColors.coral;
      case 'Other':
        return NeumorphicColors.purple;
      default:
        return NeumorphicColors.textTertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await showGenderSelector(
          context,
          currentGender: selectedGender,
        );
        if (result != null) {
          onGenderSelected(result);
        }
      },
      child: NeumorphicCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            NeumorphicContainer(
              width: 40,
              height: 40,
              child: Icon(
                _getGenderIcon(selectedGender),
                color: _getGenderColor(selectedGender),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gender',
                    style: TextStyle(
                      fontSize: 12,
                      color: NeumorphicColors.textTertiary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedGender ?? 'Select your gender',
                    style: TextStyle(
                      fontSize: 15,
                      color: selectedGender != null
                          ? NeumorphicColors.textPrimary
                          : NeumorphicColors.textTertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: NeumorphicColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
