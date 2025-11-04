import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/localization/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/home/feature_card.dart';
import '../../widgets/home/quick_stats_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _getRandomQuote() {
    final random = Random();
    return AppConstants.quotes[random.nextInt(AppConstants.quotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final authProvider = context.watch<AuthProvider>();
    final userName = authProvider.userName ?? 'Guest';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.skyBlue, AppColors.backgroundLight],
            stops: [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${l10n.hello}, $userName 👋',
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                l10n.howAreYouFeeling,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 28,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/settings');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusMedium,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.format_quote,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Text(
                                _getRandomQuote(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
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
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: QuickStatsCard(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                  ),
                  delegate: SliverChildListDelegate([
                    FeatureCard(
                      title: l10n.chatNow,
                      icon: Icons.chat_bubble,
                      gradientColors: AppColors.calmGradient,
                      onTap: () => Navigator.pushNamed(context, '/chat'),
                    ),
                    FeatureCard(
                      title: l10n.trackMood,
                      icon: Icons.mood,
                      gradientColors: AppColors.peacefulGradient,
                      onTap: () =>
                          Navigator.pushNamed(context, '/mood-tracker'),
                    ),
                    FeatureCard(
                      title: l10n.selfCareTools,
                      icon: Icons.spa,
                      gradientColors: AppColors.serenityGradient,
                      onTap: () => Navigator.pushNamed(context, '/self-care'),
                    ),
                    FeatureCard(
                      title: l10n.consultDoctor,
                      icon: Icons.medical_services,
                      gradientColors: const [
                        Color(0xFFB4E7CE),
                        Color(0xFF87CEEB),
                      ],
                      onTap: () =>
                          Navigator.pushNamed(context, '/doctor-connect'),
                    ),
                    FeatureCard(
                      title: l10n.emergencyHelp,
                      icon: Icons.emergency,
                      gradientColors: const [
                        Color(0xFFFFCDD2),
                        Color(0xFFEF5350),
                      ],
                      onTap: () => Navigator.pushNamed(context, '/emergency'),
                    ),
                    FeatureCard(
                      title: l10n.reports,
                      icon: Icons.analytics,
                      gradientColors: const [
                        Color(0xFFE1BEE7),
                        Color(0xFFBA68C8),
                      ],
                      onTap: () => Navigator.pushNamed(context, '/reports'),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
