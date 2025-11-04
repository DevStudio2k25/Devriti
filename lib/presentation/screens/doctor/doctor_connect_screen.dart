import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/localization/app_localizations.dart';

class DoctorConnectScreen extends StatefulWidget {
  const DoctorConnectScreen({super.key});

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
    },
    {
      'name': 'Dr. Rajesh Kumar',
      'specialization': 'Psychiatrist',
      'experience': '15 years',
      'rating': 4.9,
      'phone': '+91 98765 43211',
      'type': 'Psychiatrist',
    },
    {
      'name': 'Dr. Anjali Mehta',
      'specialization': 'Counselling Psychologist',
      'experience': '8 years',
      'rating': 4.7,
      'phone': '+91 98765 43212',
      'type': 'Counsellor',
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.consultDoctor)),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            color: AppColors.skyBlue.withOpacity(0.1),
            child: Column(
              children: [
                Text(
                  l10n.findHelpNearYou,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('All'),
                      _buildFilterChip(l10n.counsellor),
                      _buildFilterChip(l10n.psychiatrist),
                      _buildFilterChip(l10n.helpline),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: _filteredProfessionals.length,
              itemBuilder: (context, index) {
                final professional = _filteredProfessionals[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: AppColors.skyBlue,
                              child: Text(
                                professional['name'][4],
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.lg),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    professional['name'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    professional['specialization'],
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${professional['rating']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: AppSpacing.md),
                                      Text(
                                        professional['experience'],
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () =>
                                    _makePhoneCall(professional['phone']),
                                icon: const Icon(Icons.phone),
                                label: Text(l10n.call),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Booking feature coming soon',
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.calendar_today),
                                label: Text(l10n.bookOnline),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.pastelGreen.withOpacity(0.2),
            ),
            child: Text(
              l10n.reachingOutIsStrength,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() => _selectedFilter = label);
        },
        selectedColor: AppColors.skyBlue,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}
