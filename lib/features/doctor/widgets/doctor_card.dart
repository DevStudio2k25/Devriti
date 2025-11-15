import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../../../core/localization/app_localizations.dart';

class DoctorCard extends StatelessWidget {
  final Map<String, dynamic> professional;
  final AppLocalizations l10n;
  final VoidCallback onCall;

  const DoctorCard({
    super.key,
    required this.professional,
    required this.l10n,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    final isAvailable = professional['available'] as bool;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: NeumorphicCard(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Avatar with status indicator
            Stack(
              children: [
                NeumorphicContainer(
                  width: 70,
                  height: 70,
                  isCircle: true,
                  child: Center(
                    child: Text(
                      professional['name'][4],
                      style: const TextStyle(
                        fontSize: 28,
                        color: NeumorphicColors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: isAvailable
                          ? NeumorphicColors.mint
                          : NeumorphicColors.coral,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: NeumorphicColors.card,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            // Doctor Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    professional['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: NeumorphicColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    professional['specialization'],
                    style: const TextStyle(
                      color: NeumorphicColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: NeumorphicColors.orange.withValues(
                            alpha: 0.15,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 12,
                              color: NeumorphicColors.orange,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${professional['rating']}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: NeumorphicColors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: NeumorphicColors.blue.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.work_outline_rounded,
                              size: 12,
                              color: NeumorphicColors.blue,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              professional['experience'],
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: NeumorphicColors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Call Button
            GestureDetector(
              onTap: onCall,
              child: NeumorphicContainer(
                width: 50,
                height: 50,
                isCircle: true,
                child: const Icon(
                  Icons.phone_rounded,
                  color: NeumorphicColors.blue,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
