import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../../../core/localization/app_localizations.dart';
import '../widgets/doctor_app_bar.dart';
import '../widgets/doctor_header.dart';
import '../widgets/doctor_card.dart';
import '../widgets/motivational_footer.dart';

class DoctorConnectScreen extends StatefulWidget {
  final bool showBackButton;

  const DoctorConnectScreen({super.key, this.showBackButton = false});

  @override
  State<DoctorConnectScreen> createState() => _DoctorConnectScreenState();
}

class _DoctorConnectScreenState extends State<DoctorConnectScreen> {
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _professionals = [
    {
      'name': 'Dr. Priya Sharma',
      'specialization': 'Clinical Psychologist',
      'experience': '10 years',
      'rating': 4.8,
      'phone': '+91 98765 43210',
      'type': 'Counsellor',
      'available': true,
    },
    {
      'name': 'Dr. Rajesh Kumar',
      'specialization': 'Psychiatrist',
      'experience': '15 years',
      'rating': 4.9,
      'phone': '+91 98765 43211',
      'type': 'Psychiatrist',
      'available': true,
    },
    {
      'name': 'Dr. Anjali Mehta',
      'specialization': 'Counselling Psychologist',
      'experience': '8 years',
      'rating': 4.7,
      'phone': '+91 98765 43212',
      'type': 'Counsellor',
      'available': false,
    },
    {
      'name': 'Dr. Vikram Singh',
      'specialization': 'Child Psychologist',
      'experience': '12 years',
      'rating': 4.8,
      'phone': '+91 98765 43213',
      'type': 'Counsellor',
      'available': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredProfessionals {
    if (_selectedFilter == 'All') return _professionals;
    return _professionals
        .where((prof) => prof['type'] == _selectedFilter)
        .toList();
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  Widget _buildFilterChip(String label, IconData icon) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? NeumorphicColors.blue.withValues(alpha: 0.15)
              : NeumorphicColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? NeumorphicColors.blue
                : NeumorphicColors.textTertiary.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? NeumorphicColors.blue
                  : NeumorphicColors.textTertiary,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? NeumorphicColors.blue
                    : NeumorphicColors.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      appBar: DoctorAppBar(l10n: l10n, showBackButton: widget.showBackButton),
      body: CustomScrollView(
        slivers: [
          DoctorHeader(l10n: l10n),
          // Filter Chips
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All', Icons.people_rounded),
                    const SizedBox(width: 12),
                    _buildFilterChip(l10n.counsellor, Icons.psychology_rounded),
                    const SizedBox(width: 12),
                    _buildFilterChip(
                      l10n.psychiatrist,
                      Icons.local_hospital_rounded,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final professional = _filteredProfessionals[index];
                return DoctorCard(
                  professional: professional,
                  l10n: l10n,
                  onCall: () => _makePhoneCall(professional['phone']),
                );
              }, childCount: _filteredProfessionals.length),
            ),
          ),
          MotivationalFooter(l10n: l10n),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
