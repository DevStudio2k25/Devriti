import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/localization/app_localizations.dart';
import '../../shared/providers/language_provider.dart';
import '../../shared/providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeProvider = context.watch<ThemeProvider>();
    final languageProvider = context.watch<LanguageProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        children: [
          // App Header - No login needed!
          Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: AppColors.calmGradient),
            ),
            child: const Column(
              children: [
                Icon(Icons.favorite, size: 80, color: Colors.white),
                SizedBox(height: AppSpacing.lg),
                Text(
                  'DEVRITI',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Your Mental Health Companion',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                SizedBox(height: 8),
                Text(
                  '🔒 100% Private - No Login Required',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Appearance Section
          _buildSectionHeader(l10n.settings),
          SwitchListTile(
            title: Text(
              themeProvider.isDarkMode ? l10n.darkMode : l10n.lightMode,
            ),
            subtitle: const Text('Toggle dark/light theme'),
            secondary: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
          ),

          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.language),
            subtitle: Text(
              languageProvider.languageCode == 'en' ? 'English' : 'हिंदी',
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(l10n.chooseLanguage),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text('English'),
                        leading: Radio<String>(
                          value: 'en',
                          groupValue: languageProvider.languageCode,
                          onChanged: (value) {
                            languageProvider.changeLanguage(value!);
                            Navigator.pop(context);
                          },
                        ),
                        onTap: () {
                          languageProvider.changeLanguage('en');
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text('हिंदी'),
                        leading: Radio<String>(
                          value: 'hi',
                          groupValue: languageProvider.languageCode,
                          onChanged: (value) {
                            languageProvider.changeLanguage(value!);
                            Navigator.pop(context);
                          },
                        ),
                        onTap: () {
                          languageProvider.changeLanguage('hi');
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const Divider(),

          // Privacy Section
          _buildSectionHeader(l10n.privacy),
          ListTile(
            leading: const Icon(Icons.download),
            title: Text(l10n.exportData),
            subtitle: const Text('Download your data'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exporting data...')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: Text(
              l10n.deleteData,
              style: const TextStyle(color: Colors.red),
            ),
            subtitle: const Text('Permanently delete all your data'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete All Data?'),
                  content: const Text(
                    'This will permanently delete all your data. This action cannot be undone.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(l10n.cancel),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Data deleted')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text(l10n.delete),
                    ),
                  ],
                ),
              );
            },
          ),

          const Divider(),

          // About Section
          _buildSectionHeader('About'),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(l10n.aboutSukoon),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'DEVRITI',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(
                  Icons.favorite,
                  size: 48,
                  color: AppColors.skyBlue,
                ),
                children: const [
                  Text(
                    "Instant help, no login needed — DEVRITI is here for you",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'DEVRITI is your mental health companion, providing instant AI-powered support through chat, mood tracking, self-care tools, and emergency help. All data stays private on your device.',
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
