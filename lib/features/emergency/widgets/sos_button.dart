import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../../../core/localization/app_localizations.dart';
import '../../auth/models/user_profile_model.dart';

class SOSButton extends StatelessWidget {
  final AnimationController animationController;
  final UserProfileModel? profile;
  final String contactName;
  final String contactPhone;
  final String contactRelation;

  const SOSButton({
    super.key,
    required this.animationController,
    required this.profile,
    required this.contactName,
    required this.contactPhone,
    required this.contactRelation,
  });

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              barrierColor: Colors.black.withValues(alpha: 0.8),
              builder: (context) => _buildSOSDialog(context, l10n),
            );
          },
          child: Container(
            height: 160,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: NeumorphicColors.getBackground(context),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                // Dark shadow
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.6)
                      : Colors.black.withValues(alpha: 0.2),
                  offset: const Offset(8, 8),
                  blurRadius: 16,
                  spreadRadius: 0,
                ),
                // Light highlight
                BoxShadow(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.white.withValues(alpha: 0.9),
                  offset: const Offset(-8, -8),
                  blurRadius: 16,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              children: [
                // Left side - Space for Lottie animation
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: NeumorphicColors.coral.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: NeumorphicColors.coral.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.emergency_share_rounded,
                      size: 60,
                      color: NeumorphicColors.coral,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // Right side - Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.sos,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: NeumorphicColors.getTextPrimary(context),
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Emergency Alert',
                        style: TextStyle(
                          fontSize: 14,
                          color: NeumorphicColors.getTextSecondary(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              NeumorphicColors.coral.withValues(alpha: 0.2),
                              NeumorphicColors.coral.withValues(alpha: 0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Tap to Send Alert',
                          style: TextStyle(
                            fontSize: 12,
                            color: NeumorphicColors.coral,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSOSDialog(BuildContext context, AppLocalizations l10n) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: NeumorphicColors.card,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.8),
              blurRadius: 30,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NeumorphicContainer(
              width: 80,
              height: 80,
              isCircle: true,
              child: const Icon(
                Icons.emergency_rounded,
                color: NeumorphicColors.coral,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.sos,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: NeumorphicColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              profile?.emergencyContactName != null
                  ? 'This will send an emergency message to $contactName ($contactRelation).'
                  : 'Please set up your emergency contact in profile first.',
              style: const TextStyle(
                fontSize: 14,
                color: NeumorphicColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
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
                      ),
                      child: Text(
                        l10n.cancel,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: NeumorphicColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                if (profile?.emergencyContactPhone != null)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _sendSMS(contactPhone, l10n.iNeedHelpNow);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Emergency alert sent to $contactName!',
                            ),
                            backgroundColor: NeumorphicColors.coral,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF3B3B), Color(0xFFE51A1A)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: NeumorphicColors.coral.withValues(
                                alpha: 0.5,
                              ),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          l10n.yes,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
}
