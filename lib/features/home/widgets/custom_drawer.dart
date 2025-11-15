import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
// import '../../../shared/providers/theme_provider.dart'; // Hidden - theme switch disabled
import '../../../shared/providers/language_provider.dart';
import '../../auth/services/firebase_auth_service.dart';
import '../../auth/models/user_profile_model.dart';
import '../../about/about_screen.dart';

/// Neumorphic Redesigned Custom Drawer
class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  UserProfileModel? _profile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final user = FirebaseAuthService.currentUser;
      if (user != null) {
        final profile = await FirebaseAuthService.getUserProfile(user.uid);
        if (mounted) {
          setState(() {
            _profile = profile;
            _isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final themeProvider = context.watch<ThemeProvider>(); // Hidden - not needed
    final languageProvider = context.watch<LanguageProvider>();
    // final isDark = Theme.of(context).brightness == Brightness.dark; // Hidden - not needed

    return Drawer(
      backgroundColor: NeumorphicColors.getBackground(context),
      child: SafeArea(
        child: Column(
          children: [
            // Profile Section
            _buildProfileSection(),

            const SizedBox(height: 20),

            // Menu Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                children: [
                  // Dark Mode Switch - HIDDEN (commented out)
                  // _buildSwitchTile(
                  //   context: context,
                  //   icon: isDark
                  //       ? Icons.dark_mode_rounded
                  //       : Icons.light_mode_rounded,
                  //   title: isDark ? 'Dark Mode' : 'Light Mode',
                  //   subtitle: 'Toggle theme',
                  //   value: isDark,
                  //   onChanged: (value) {
                  //     themeProvider.toggleTheme();
                  //   },
                  //   color: isDark
                  //       ? NeumorphicColors.purple
                  //       : NeumorphicColors.orange,
                  // ),
                  //
                  // const SizedBox(height: 12),

                  // Language Selection
                  _buildMenuTile(
                    context: context,
                    icon: Icons.language_rounded,
                    title: 'Language',
                    subtitle: languageProvider.languageCode == 'en'
                        ? 'English'
                        : 'हिंदी',
                    onTap: () {
                      _showLanguageDialog(context, languageProvider);
                    },
                    color: NeumorphicColors.mint,
                  ),

                  const SizedBox(height: 12),

                  // Export Data - Coming Soon
                  _buildMenuTile(
                    context: context,
                    icon: Icons.download_rounded,
                    title: 'Export Data',
                    subtitle: 'Coming Soon',
                    onTap: () {
                      print('🔵 [EXPORT DATA] Button clicked');
                      final messenger = ScaffoldMessenger.of(context);
                      Navigator.pop(context);
                      print('🔵 [EXPORT DATA] Drawer closed');
                      Future.delayed(const Duration(milliseconds: 300), () {
                        print('🔵 [EXPORT DATA] Showing snackbar');
                        messenger.showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Feature coming soon! 🚀',
                              style: TextStyle(color: Colors.white),
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                        print('🔵 [EXPORT DATA] Snackbar shown');
                      });
                    },
                    color: NeumorphicColors.blue,
                  ),

                  const SizedBox(height: 12),

                  // About DEVRITI
                  _buildMenuTile(
                    context: context,
                    icon: Icons.info_rounded,
                    title: 'About DEVRITI',
                    subtitle: 'App information',
                    onTap: () {
                      print('🟢 [ABOUT] Button clicked');
                      final navigator = Navigator.of(context);
                      Navigator.pop(context);
                      print('🟢 [ABOUT] Drawer closed');
                      Future.delayed(const Duration(milliseconds: 300), () {
                        print('🟢 [ABOUT] Navigating to About screen');
                        try {
                          navigator.push(
                            MaterialPageRoute(
                              builder: (context) {
                                print('🟢 [ABOUT] Building AboutScreen');
                                return const AboutScreen();
                              },
                            ),
                          );
                          print('🟢 [ABOUT] Navigation successful');
                        } catch (e) {
                          print('❌ [ABOUT] Navigation error: $e');
                        }
                      });
                    },
                    color: NeumorphicColors.coral,
                  ),

                  const SizedBox(height: 24),

                  // Made by DEVRITI Team
                  Center(
                    child: Column(
                      children: [
                        NeumorphicContainer(
                          width: 60,
                          height: 60,
                          isCircle: true,
                          child: const Icon(
                            Icons.favorite,
                            color: NeumorphicColors.coral,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Made with ❤️ by',
                          style: TextStyle(
                            fontSize: 13,
                            color: NeumorphicColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'DEVRITI Team',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: NeumorphicColors.purple,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Version 1.0.0',
                          style: TextStyle(
                            fontSize: 12,
                            color: NeumorphicColors.textTertiary,
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
      ),
    );
  }

  Widget _buildProfileSection() {
    if (_isLoading) {
      return Container(
        padding: const EdgeInsets.all(24),
        child: const Center(
          child: CircularProgressIndicator(color: NeumorphicColors.purple),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: NeumorphicCard(
        child: Row(
          children: [
            // Profile Avatar
            NeumorphicContainer(
              width: 60,
              height: 60,
              isCircle: true,
              child: Center(
                child: Text(
                  _profile?.name?.substring(0, 1).toUpperCase() ?? 'U',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: NeumorphicColors.purple,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Profile Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _profile?.name ?? 'User',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: NeumorphicColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _profile?.email ?? 'user@devriti.app',
                    style: const TextStyle(
                      fontSize: 13,
                      color: NeumorphicColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Color color,
  }) {
    return NeumorphicCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          NeumorphicContainer(
            width: 48,
            height: 48,
            isCircle: true,
            backgroundColor: NeumorphicColors.getCard(context),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: NeumorphicColors.getTextPrimary(context),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: NeumorphicColors.getTextSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged, activeTrackColor: color),
        ],
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
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            NeumorphicContainer(
              width: 48,
              height: 48,
              isCircle: true,
              backgroundColor: NeumorphicColors.getCard(context),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: NeumorphicColors.getTextPrimary(context),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: NeumorphicColors.getTextSecondary(context),
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
            NeumorphicContainer(
              width: 40,
              height: 40,
              isCircle: true,
              child: const Icon(
                Icons.language_rounded,
                color: NeumorphicColors.mint,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Choose Language',
              style: TextStyle(color: NeumorphicColors.textPrimary),
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
    final isDisabled = languageCode == 'hi'; // Hindi is disabled

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
                ? NeumorphicColors.purple.withValues(alpha: 0.2)
                : NeumorphicColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? NeumorphicColors.purple
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
                            ? NeumorphicColors.purple
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
                  color: NeumorphicColors.purple,
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
