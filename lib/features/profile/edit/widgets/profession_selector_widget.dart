import 'package:flutter/material.dart';
import '../../../../core/widgets/neumorphic_widgets.dart';
import '../../widgets/profession_selector_dialog.dart';

class ProfessionSelectorWidget extends StatelessWidget {
  final String? selectedProfession;
  final String gender;
  final Function(String?) onProfessionSelected;

  const ProfessionSelectorWidget({
    super.key,
    required this.selectedProfession,
    required this.gender,
    required this.onProfessionSelected,
  });

  IconData _getProfessionIcon(String? profession) {
    if (profession == null) return Icons.work_outline_rounded;

    if (profession.toLowerCase().contains('student')) {
      return Icons.school_outlined;
    } else if (profession.toLowerCase().contains('engineer')) {
      return Icons.engineering_outlined;
    } else if (profession.toLowerCase().contains('doctor')) {
      return Icons.medical_services_outlined;
    } else if (profession.toLowerCase().contains('teacher')) {
      return Icons.person_outline_rounded;
    } else if (profession.toLowerCase().contains('business')) {
      return Icons.business_outlined;
    }
    return Icons.work_outline_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await showProfessionSelector(
          context,
          currentProfession: selectedProfession,
          gender: gender,
        );
        if (result != null) {
          onProfessionSelected(result);
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
                _getProfessionIcon(selectedProfession),
                color: NeumorphicColors.orange,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Profession',
                    style: TextStyle(
                      fontSize: 12,
                      color: NeumorphicColors.textTertiary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedProfession ?? 'Select your profession',
                    style: TextStyle(
                      fontSize: 15,
                      color: selectedProfession != null
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
