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
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: NeumorphicCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                NeumorphicContainer(
                  width: 70,
                  height: 70,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          NeumorphicColors.blue,
                          NeumorphicColors.purple,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: NeumorphicColors.blue.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        professional['name'][4],
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        professional['name'],
                        style: const TextStyle(
                          fontSize: 18,
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
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: professional['available']
                                ? [
                                    NeumorphicColors.mint.withValues(
                                      alpha: 0.3,
                                    ),
                                    NeumorphicColors.mint.withValues(
                                      alpha: 0.1,
                                    ),
                                  ]
                                : [
                                    NeumorphicColors.textTertiary.withValues(
                                      alpha: 0.2,
                                    ),
                                    NeumorphicColors.textTertiary.withValues(
                                      alpha: 0.1,
                                    ),
                                  ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.circle,
                              size: 8,
                              color: professional['available']
                                  ? NeumorphicColors.mint
                                  : NeumorphicColors.textTertiary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              professional['available'] ? 'Available' : 'Busy',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: professional['available']
                                    ? NeumorphicColors.mint
                                    : NeumorphicColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStatItem(
                  Icons.star_rounded,
                  '${professional['rating']}',
                  NeumorphicColors.orange,
                ),
                const SizedBox(width: 20),
                _buildStatItem(
                  Icons.work_outline_rounded,
                  professional['experience'],
                  NeumorphicColors.blue,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onCall,
                    child: NeumorphicContainer(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.phone_rounded,
                            size: 18,
                            color: NeumorphicColors.blue,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.call,
                            style: const TextStyle(
                              color: NeumorphicColors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Booking feature coming soon'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: NeumorphicColors.card,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            NeumorphicColors.blue,
                            NeumorphicColors.purple,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: NeumorphicColors.blue.withValues(alpha: 0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_today_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.bookOnline,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
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

  Widget _buildStatItem(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: NeumorphicColors.textSecondary.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }
}
