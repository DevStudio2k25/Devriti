import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/neumorphic_widgets.dart';
import '../../shared/providers/language_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();

    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      appBar: AppBar(
        backgroundColor: NeumorphicColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: NeumorphicColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: NeumorphicColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Appearance Section
              const Text(
                'Appearance',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: NeumorphicColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),

              // Dark Mode (Disabled)
              _buildDisabledTile(
                context: context,
                icon: Icons.dark_mode_rounded,
                title: 'Dark Mode',
                subtitle: 'Coming soon',
                color: NeumorphicColors.purple,
              ),

              const SizedBox(height: 30),

              // Language Section
              const Text(
                'Language',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: NeumorphicColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),

              _buildDisabledTile(
                context: context,
                icon: Icons.language_rounded,
                title: 'Language',
                subtitle: 'Coming soon',
                color: NeumorphicColors.mint,
              ),

              const SizedBox(height: 30),

              // Data Section
              const Text(
                'Data',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: NeumorphicColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),

              _buildDisabledTile(
                context: context,
                icon: Icons.download_rounded,
                title: 'Export Data',
                subtitle: 'Coming soon',
                color: NeumorphicColors.blue,
              ),

              const SizedBox(height: 12),

              _buildDisabledTile(
                context: context,
                icon: Icons.delete_rounded,
                title: 'Clear Data',
                subtitle: 'Coming soon',
                color: NeumorphicColors.coral,
              ),

              const SizedBox(height: 30),

              // About Section
              const Text(
                'About',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: NeumorphicColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),

              _buildMenuTile(
                context: context,
                icon: Icons.info_rounded,
                title: 'About DEVRITI',
                subtitle: 'App information',
                onTap: () {
                  Navigator.pushNamed(context, '/about');
                },
                color: NeumorphicColors.orange,
              ),

              const SizedBox(height: 12),

              _buildDisabledTile(
                context: context,
                icon: Icons.privacy_tip_rounded,
                title: 'Privacy Policy',
                subtitle: 'Coming soon',
                color: NeumorphicColors.purple,
              ),

              const SizedBox(height: 12),

              _buildDisabledTile(
                context: context,
                icon: Icons.description_rounded,
                title: 'Terms of Service',
                subtitle: 'Coming soon',
                color: NeumorphicColors.blue,
              ),

              const SizedBox(height: 30),

              // Version Info
              Center(
                child: NeumorphicCard(
                  child: Column(
                    children: [
                      const Text(
                        'Version 1.0.0',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: NeumorphicColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '© 2025 DEVRITI',
                        style: TextStyle(
                          fontSize: 12,
                          color: NeumorphicColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: NeumorphicCard(
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
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: NeumorphicColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: NeumorphicColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: color),
          ],
        ),
      ),
    );
  }

  Widget _buildDisabledTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Opacity(
      opacity: 0.5,
      child: NeumorphicCard(
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
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: NeumorphicColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: NeumorphicColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.lock_outline,
              size: 16,
              color: NeumorphicColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(
    BuildContext context,
    LanguageProvider languageProvider,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: NeumorphicColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: NeumorphicColors.mint.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.language_rounded,
                color: NeumorphicColors.mint,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Choose Language',
              style: TextStyle(
                color: NeumorphicColors.textPrimary,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption(
              context: context,
              languageProvider: languageProvider,
              languageCode: 'en',
              languageName: 'English',
              flag: '🇬🇧',
            ),
            const SizedBox(height: 12),
            _buildLanguageOption(
              context: context,
              languageProvider: languageProvider,
              languageCode: 'hi',
              languageName: 'हिंदी',
              flag: '🇮🇳',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required LanguageProvider languageProvider,
    required String languageCode,
    required String languageName,
    required String flag,
  }) {
    final isSelected = languageProvider.languageCode == languageCode;
    final isDisabled = languageCode == 'hi';

    return GestureDetector(
      onTap: isDisabled
          ? null
          : () {
              languageProvider.changeLanguage(languageCode);
              Navigator.pop(context);
            },
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1.0,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? NeumorphicColors.mint.withValues(alpha: 0.2)
                : NeumorphicColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? NeumorphicColors.mint
                  : NeumorphicColors.textTertiary.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Text(flag, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      languageName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isSelected
                            ? NeumorphicColors.mint
                            : NeumorphicColors.textPrimary,
                      ),
                    ),
                    if (isDisabled)
                      const Text(
                        'Coming in future updates',
                        style: TextStyle(
                          fontSize: 11,
                          color: NeumorphicColors.textTertiary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: NeumorphicColors.mint,
                  size: 24,
                ),
              if (isDisabled && !isSelected)
                const Icon(
                  Icons.lock_outline,
                  color: NeumorphicColors.textTertiary,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
