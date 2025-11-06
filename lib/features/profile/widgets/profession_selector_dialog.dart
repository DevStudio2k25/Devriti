import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ProfessionSelectorDialog extends StatefulWidget {
  final String? selectedProfession;
  final String? gender;

  const ProfessionSelectorDialog({
    super.key,
    this.selectedProfession,
    this.gender,
  });

  @override
  State<ProfessionSelectorDialog> createState() =>
      _ProfessionSelectorDialogState();
}

class _ProfessionSelectorDialogState extends State<ProfessionSelectorDialog> {
  String? _selectedProfession;
  String _searchQuery = '';

  // Male Professions
  final List<Map<String, dynamic>> _maleProfessions = [
    {'name': 'Student', 'icon': Icons.school_rounded},
    {'name': 'Software Engineer', 'icon': Icons.computer_rounded},
    {'name': 'Doctor', 'icon': Icons.medical_services_rounded},
    {'name': 'Teacher', 'icon': Icons.menu_book_rounded},
    {'name': 'Business Owner', 'icon': Icons.business_center_rounded},
    {'name': 'Lawyer', 'icon': Icons.gavel_rounded},
    {'name': 'Accountant', 'icon': Icons.calculate_rounded},
    {'name': 'Engineer', 'icon': Icons.engineering_rounded},
    {'name': 'Architect', 'icon': Icons.architecture_rounded},
    {'name': 'Designer', 'icon': Icons.design_services_rounded},
    {'name': 'Marketing Manager', 'icon': Icons.campaign_rounded},
    {'name': 'Sales Executive', 'icon': Icons.trending_up_rounded},
    {'name': 'Chef', 'icon': Icons.restaurant_rounded},
    {'name': 'Photographer', 'icon': Icons.camera_alt_rounded},
    {'name': 'Pilot', 'icon': Icons.flight_rounded},
    {'name': 'Driver', 'icon': Icons.local_shipping_rounded},
    {'name': 'Mechanic', 'icon': Icons.build_rounded},
    {'name': 'Electrician', 'icon': Icons.electrical_services_rounded},
    {'name': 'Plumber', 'icon': Icons.plumbing_rounded},
    {'name': 'Carpenter', 'icon': Icons.handyman_rounded},
    {'name': 'Farmer', 'icon': Icons.agriculture_rounded},
    {'name': 'Police Officer', 'icon': Icons.local_police_rounded},
    {'name': 'Firefighter', 'icon': Icons.fire_truck_rounded},
    {'name': 'Army Officer', 'icon': Icons.military_tech_rounded},
    {'name': 'Banker', 'icon': Icons.account_balance_rounded},
    {'name': 'Consultant', 'icon': Icons.support_agent_rounded},
    {'name': 'Freelancer', 'icon': Icons.work_outline_rounded},
    {'name': 'Entrepreneur', 'icon': Icons.lightbulb_rounded},
    {'name': 'Retired', 'icon': Icons.elderly_rounded},
    {'name': 'Unemployed', 'icon': Icons.person_off_rounded},
    {'name': 'Other', 'icon': Icons.more_horiz_rounded},
  ];

  // Female Professions
  final List<Map<String, dynamic>> _femaleProfessions = [
    {'name': 'Student', 'icon': Icons.school_rounded},
    {'name': 'Software Engineer', 'icon': Icons.computer_rounded},
    {'name': 'Doctor', 'icon': Icons.medical_services_rounded},
    {'name': 'Nurse', 'icon': Icons.local_hospital_rounded},
    {'name': 'Teacher', 'icon': Icons.menu_book_rounded},
    {'name': 'Business Owner', 'icon': Icons.business_center_rounded},
    {'name': 'Lawyer', 'icon': Icons.gavel_rounded},
    {'name': 'Accountant', 'icon': Icons.calculate_rounded},
    {'name': 'HR Manager', 'icon': Icons.people_rounded},
    {'name': 'Designer', 'icon': Icons.design_services_rounded},
    {'name': 'Fashion Designer', 'icon': Icons.checkroom_rounded},
    {'name': 'Interior Designer', 'icon': Icons.chair_rounded},
    {'name': 'Marketing Manager', 'icon': Icons.campaign_rounded},
    {'name': 'Content Writer', 'icon': Icons.edit_note_rounded},
    {'name': 'Journalist', 'icon': Icons.article_rounded},
    {'name': 'Chef', 'icon': Icons.restaurant_rounded},
    {'name': 'Beautician', 'icon': Icons.face_rounded},
    {'name': 'Makeup Artist', 'icon': Icons.brush_rounded},
    {'name': 'Photographer', 'icon': Icons.camera_alt_rounded},
    {'name': 'Social Worker', 'icon': Icons.volunteer_activism_rounded},
    {'name': 'Psychologist', 'icon': Icons.psychology_rounded},
    {'name': 'Counselor', 'icon': Icons.support_rounded},
    {'name': 'Pharmacist', 'icon': Icons.medication_rounded},
    {'name': 'Dentist', 'icon': Icons.medical_services_rounded},
    {'name': 'Physiotherapist', 'icon': Icons.accessibility_new_rounded},
    {'name': 'Yoga Instructor', 'icon': Icons.self_improvement_rounded},
    {'name': 'Fitness Trainer', 'icon': Icons.fitness_center_rounded},
    {'name': 'Banker', 'icon': Icons.account_balance_rounded},
    {'name': 'Receptionist', 'icon': Icons.desk_rounded},
    {'name': 'Flight Attendant', 'icon': Icons.flight_rounded},
    {'name': 'Homemaker', 'icon': Icons.home_rounded},
    {'name': 'Freelancer', 'icon': Icons.work_outline_rounded},
    {'name': 'Entrepreneur', 'icon': Icons.lightbulb_rounded},
    {'name': 'Retired', 'icon': Icons.elderly_rounded},
    {'name': 'Unemployed', 'icon': Icons.person_off_rounded},
    {'name': 'Other', 'icon': Icons.more_horiz_rounded},
  ];

  @override
  void initState() {
    super.initState();
    _selectedProfession = widget.selectedProfession;
  }

  List<Map<String, dynamic>> get _professions {
    return widget.gender == 'Female' ? _femaleProfessions : _maleProfessions;
  }

  List<Map<String, dynamic>> get _filteredProfessions {
    if (_searchQuery.isEmpty) {
      return _professions;
    }
    return _professions
        .where(
          (prof) =>
              prof['name'].toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 600),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.work_outline_rounded,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Profession',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.gender == 'Female'
                            ? 'Choose your profession'
                            : 'Choose your profession',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Search Bar
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search profession...',
                prefixIcon: const Icon(Icons.search_rounded, size: 20),
                filled: true,
                fillColor: AppColors.background.withValues(alpha: 0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Profession Chips
            Expanded(
              child: _filteredProfessions.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 48,
                            color: AppColors.textSecondary.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'No profession found',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _filteredProfessions
                            .map(
                              (prof) => _buildProfessionChip(
                                label: prof['name'],
                                icon: prof['icon'],
                              ),
                            )
                            .toList(),
                      ),
                    ),
            ),

            const SizedBox(height: 16),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color: AppColors.border.withValues(alpha: 0.5),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selectedProfession != null
                        ? () => Navigator.pop(context, _selectedProfession)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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

  Widget _buildProfessionChip({required String label, required IconData icon}) {
    final isSelected = _selectedProfession == label;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedProfession = label;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.15)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary,
                size: 16,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Helper function to show dialog
Future<String?> showProfessionSelector(
  BuildContext context, {
  String? currentProfession,
  String? gender,
}) async {
  return await showDialog<String>(
    context: context,
    builder: (context) => ProfessionSelectorDialog(
      selectedProfession: currentProfession,
      gender: gender,
    ),
  );
}
