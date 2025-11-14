import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';

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
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _professions = [
    {'name': 'Student', 'icon': Icons.school_rounded},
    {'name': 'Software Engineer', 'icon': Icons.computer_rounded},
    {'name': 'Doctor', 'icon': Icons.medical_services_rounded},
    {'name': 'Nurse', 'icon': Icons.local_hospital_rounded},
    {'name': 'Teacher', 'icon': Icons.menu_book_rounded},
    {'name': 'Business Owner', 'icon': Icons.business_center_rounded},
    {'name': 'Lawyer', 'icon': Icons.gavel_rounded},
    {'name': 'Accountant', 'icon': Icons.calculate_rounded},
    {'name': 'Engineer', 'icon': Icons.engineering_rounded},
    {'name': 'Designer', 'icon': Icons.design_services_rounded},
    {'name': 'Marketing Manager', 'icon': Icons.campaign_rounded},
    {'name': 'Sales Executive', 'icon': Icons.trending_up_rounded},
    {'name': 'Chef', 'icon': Icons.restaurant_rounded},
    {'name': 'Photographer', 'icon': Icons.camera_alt_rounded},
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredProfessions {
    if (_searchQuery.isEmpty) return _professions;
    return _professions
        .where(
          (p) => p['name'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 600),
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
                    Icons.work_outline_rounded,
                    color: NeumorphicColors.orange,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Profession',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: NeumorphicColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Choose your profession',
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

            const SizedBox(height: 20),

            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: NeumorphicColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                style: const TextStyle(
                  color: NeumorphicColors.textPrimary,
                  fontSize: 15,
                ),
                decoration: const InputDecoration(
                  hintText: 'Search profession...',
                  hintStyle: TextStyle(color: NeumorphicColors.textTertiary),
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search_rounded,
                    color: NeumorphicColors.textTertiary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Profession List
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredProfessions.length,
                itemBuilder: (context, index) {
                  final profession = _filteredProfessions[index];
                  return _buildProfessionOption(
                    label: profession['name'],
                    icon: profession['icon'],
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

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
                    onTap: _selectedProfession != null
                        ? () => Navigator.pop(context, _selectedProfession)
                        : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        gradient: _selectedProfession != null
                            ? const LinearGradient(
                                colors: [
                                  NeumorphicColors.orange,
                                  Color(0xFFFFD700),
                                ],
                              )
                            : null,
                        color: _selectedProfession == null
                            ? NeumorphicColors.textTertiary
                            : null,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: _selectedProfession != null
                            ? [
                                BoxShadow(
                                  color: NeumorphicColors.orange.withValues(
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

  Widget _buildProfessionOption({
    required String label,
    required IconData icon,
  }) {
    final isSelected = _selectedProfession == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedProfession = label;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? NeumorphicColors.background
              : NeumorphicColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? NeumorphicColors.orange : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: NeumorphicColors.orange.withValues(alpha: 0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [
                          NeumorphicColors.orange.withValues(alpha: 0.3),
                          NeumorphicColors.orange.withValues(alpha: 0.1),
                        ],
                      )
                    : null,
                color: isSelected ? null : NeumorphicColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? NeumorphicColors.orange
                    : NeumorphicColors.textTertiary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  color: isSelected
                      ? NeumorphicColors.textPrimary
                      : NeumorphicColors.textSecondary,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: NeumorphicColors.orange,
                size: 20,
              ),
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
    barrierColor: Colors.black.withValues(alpha: 0.7),
    builder: (context) => ProfessionSelectorDialog(
      selectedProfession: currentProfession,
      gender: gender,
    ),
  );
}
