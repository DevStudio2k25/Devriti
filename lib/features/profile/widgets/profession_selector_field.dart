import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'profession_selector_dialog.dart';

class ProfessionSelectorField extends StatelessWidget {
  final String? selectedProfession;
  final String? gender;
  final Function(String?) onProfessionSelected;
  final String? Function(String?)? validator;

  const ProfessionSelectorField({
    super.key,
    required this.selectedProfession,
    required this.gender,
    required this.onProfessionSelected,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: selectedProfession,
      validator: validator,
      builder: (formFieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                if (gender == null || gender!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Please select gender first'),
                      backgroundColor: AppColors.error,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                  return;
                }

                final result = await showProfessionSelector(
                  context,
                  currentProfession: selectedProfession,
                  gender: gender,
                );
                if (result != null) {
                  onProfessionSelected(result);
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
                      selectedProfession != null
                          ? Icons.work_rounded
                          : Icons.work_outline_rounded,
                      color: selectedProfession != null
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profession',
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
                            selectedProfession ?? 'Select your profession',
                            style: TextStyle(
                              fontSize: 15,
                              color: selectedProfession != null
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                              fontWeight: selectedProfession != null
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
