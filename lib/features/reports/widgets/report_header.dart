import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';

class ReportHeader extends StatelessWidget {
  const ReportHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          NeumorphicContainer(
            width: 50,
            height: 50,
            isCircle: true,
            child: Icon(
              Icons.analytics_rounded,
              color: NeumorphicColors.purple,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reports',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: NeumorphicColors.getTextPrimary(context),
                  ),
                ),
                Text(
                  'Your wellness insights',
                  style: TextStyle(
                    fontSize: 13,
                    color: NeumorphicColors.getTextSecondary(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
