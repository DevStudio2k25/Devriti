import 'package:flutter/material.dart';
import '../../core/widgets/neumorphic_widgets.dart';
import 'widgets/report_header.dart';
import 'widgets/stats_grid.dart';
import 'widgets/progress_card.dart';
import 'widgets/insights_card.dart';

/// Reports Screen - Modular with separate widgets
class ReportsScreen extends StatefulWidget {
  final bool showBackButton;
  
  const ReportsScreen({
    super.key,
    this.showBackButton = false,
  });

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.getBackground(context),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header
            const SliverToBoxAdapter(child: ReportHeader()),

            // Stats Grid
            const SliverToBoxAdapter(child: StatsGrid()),

            // Progress Card
            const SliverToBoxAdapter(child: ProgressCard()),

            // Insights Card
            const SliverToBoxAdapter(child: InsightsCard()),

            // Bottom Spacing
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}
