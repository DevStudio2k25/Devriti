import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../../../core/localization/app_localizations.dart';

class HelplinesSection extends StatelessWidget {
  final AppLocalizations l10n;

  const HelplinesSection({super.key, required this.l10n});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mental Health Helplines',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: NeumorphicColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            _HelplineCard(
              name: 'National Suicide Prevention',
              number: '988',
              description: '24/7 Crisis support',
              icon: Icons.support_agent_rounded,
              color: NeumorphicColors.coral,
              onTap: () => _makePhoneCall('988'),
            ),
            const SizedBox(height: 12),
            _HelplineCard(
              name: 'Crisis Text Line',
              number: 'Text HOME to 741741',
              description: 'Free 24/7 text support',
              icon: Icons.chat_rounded,
              color: NeumorphicColors.purple,
              onTap: () async {
                final Uri launchUri = Uri(
                  scheme: 'sms',
                  path: '741741',
                  queryParameters: {'body': 'HOME'},
                );
                if (await canLaunchUrl(launchUri)) {
                  await launchUrl(launchUri);
                }
              },
            ),
            const SizedBox(height: 12),
            _HelplineCard(
              name: 'SAMHSA Helpline',
              number: '1-800-662-4357',
              description: 'Mental health & substance abuse',
              icon: Icons.health_and_safety_rounded,
              color: NeumorphicColors.teal,
              onTap: () => _makePhoneCall('18006624357'),
            ),
          ],
        ),
      ),
    );
  }
}

class _HelplineCard extends StatelessWidget {
  final String name;
  final String number;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _HelplineCard({
    required this.name,
    required this.number,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: NeumorphicContainer(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: NeumorphicColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    number,
                    style: TextStyle(
                      fontSize: 13,
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: NeumorphicColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.phone_rounded, color: color, size: 20),
          ],
        ),
      ),
    );
  }
}
