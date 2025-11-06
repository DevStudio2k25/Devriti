import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'gender_selector_dialog.dart';

class GenderSelectorField extends StatelessWidget {
  final String? selectedGender;
  final Function(String?) onGenderSelected;
  final String? Function(String?)? validator;

  const GenderSelectorField({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
    this.validator,
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
        return Colors.blue;
      case 'Female':
        return Colors.pink;
      case 'Other':
        return Colors.purple;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: selectedGender,
      validator: validator,
      builder: (formFieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                final result = await showGenderSelector(
                  context,
                  currentGender: selectedGender,
                );
                if (result != null) {
                  onGenderSelected(result);
                  formFieldState.didChange(result);
                }
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.background.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: formFieldState.hasError
                        ? AppColors.error
                        : AppColors.border.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getGenderIcon(selectedGender),
                      color: selectedGender != null
                          ? _getGenderColor(selectedGender)
                          : AppColors.textSecondary,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gender',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary.withValues(
                                alpha: 0.7,
                              ),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            selectedGender ?? 'Select your gender',
                            style: TextStyle(
                              fontSize: 15,
                              color: selectedGender != null
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                              fontWeight: selectedGender != null
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: AppColors.textSecondary.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
            ),
            if (formFieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Text(
                  formFieldState.errorText!,
                  style: const TextStyle(fontSize: 12, color: AppColors.error),
                ),
              ),
          ],
        );
      },
    );
  }
}
