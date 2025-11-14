import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';

class WarningBanner extends StatelessWidget {
  const WarningBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                NeumorphicColors.coral.withValues(alpha: 0.3),
                NeumorphicColors.coral.withValues(alpha: 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: NeumorphicColors.coral.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.warning_rounded,
                color: NeumorphicColors.coral,
                size: 24,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Emergency support available 24/7. You are not alone.',
                  style: TextStyle(
                    fontSize: 14,
                    color: NeumorphicColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
