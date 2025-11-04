import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/localization/app_localizations.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  Future<void> _sendSMS(String phoneNumber, String message) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: {'body': message},
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.emergency),
        backgroundColor: AppColors.emergencyRed,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SOS Button
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFCDD2), Color(0xFFEF5350)],
                ),
                borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.emergencyRed.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(l10n.sos),
                        content: const Text(
                          'This will send an emergency message to your emergency contact. Continue?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(l10n.cancel),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _sendSMS('1234567890', l10n.iNeedHelpNow);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.emergencyRed,
                            ),
                            child: Text(l10n.yes),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.emergency,
                          size: 80,
                          color: Colors.white,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          l10n.sos,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxxl),

            // Emergency Options
            Text(
              'Quick Actions',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.lg),

            _buildActionCard(
              icon: Icons.phone,
              title: l10n.callEmergencyContact,
              subtitle: 'Call your saved emergency contact',
              color: AppColors.skyBlue,
              onTap: () => _makePhoneCall('1234567890'),
            ),

            _buildActionCard(
              icon: Icons.location_on,
              title: l10n.shareLocation,
              subtitle: 'Share your current location',
              color: AppColors.pastelGreen,
              onTap: () {
                _sendSMS(
                  '1234567890',
                  'I need help. My location: [Location will be shared]',
                );
              },
            ),

            const SizedBox(height: AppSpacing.xxl),

            // Helplines
            Text(
              l10n.mentalHealthHelplines,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.lg),

            ...AppConstants.helplines.entries.map((entry) {
              return Card(
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.skyBlue,
                    child: Icon(Icons.phone, color: Colors.white),
                  ),
                  title: Text(entry.key),
                  subtitle: Text(entry.value),
                  trailing: IconButton(
                    icon: const Icon(Icons.call),
                    color: AppColors.skyBlue,
                    onPressed: () => _makePhoneCall(entry.value),
                  ),
                ),
              );
            }),

            const SizedBox(height: AppSpacing.xxl),

            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.skyBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              ),
              child: const Text(
                '💙 Remember: You are not alone. Help is always available. Reaching out is a sign of strength.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
