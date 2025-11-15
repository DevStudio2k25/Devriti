import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/widgets/neumorphic_widgets.dart';
import '../../core/constants/app_constants.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.getBackground(context),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildAppBar(context),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildHeroSection(),
                    const SizedBox(height: 30),
                    _buildMissionSection(),
                    const SizedBox(height: 30),
                    _buildFeaturesSection(),
                    const SizedBox(height: 30),
                    _buildTechStackSection(),
                    const SizedBox(height: 30),
                    _buildTeamSection(),
                    const SizedBox(height: 30),
                    _buildContactSection(),
                    const SizedBox(height: 30),
                    _buildVersionInfo(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: NeumorphicColors.getBackground(context),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: NeumorphicColors.textPrimary),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'About DEVRITI',
          style: TextStyle(
            color: NeumorphicColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
    );
  }

  Widget _buildHeroSection() {
    return NeumorphicCard(
      child: Column(
        children: [
          // App Icon
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [NeumorphicColors.purple, NeumorphicColors.blue],
              ),
              boxShadow: [
                BoxShadow(
                  color: NeumorphicColors.purple.withValues(alpha: 0.4),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(
              Icons.favorite_rounded,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          // App Name
          Text(
            AppConstants.appName,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: NeumorphicColors.getTextPrimary(context),
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          // Tagline
          Text(
            AppConstants.appTagline,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: NeumorphicColors.getTextSecondary(context),
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 20),
          // Quote
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: NeumorphicColors.purple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: NeumorphicColors.purple.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              '"Instant help, no login needed — DEVRITI is here for you"',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: NeumorphicColors.getTextPrimary(context),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionSection() {
    return NeumorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [NeumorphicColors.mint, NeumorphicColors.blue],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.flag_rounded, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Text(
                'Our Mission',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: NeumorphicColors.getTextPrimary(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'DEVRITI is your mental health companion, providing instant AI-powered support through chat, mood tracking, self-care tools, and emergency help. We believe mental health support should be accessible, private, and available 24/7.',
            style: TextStyle(
              fontSize: 15,
              color: NeumorphicColors.getTextSecondary(context),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return NeumorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [NeumorphicColors.coral, NeumorphicColors.orange],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.star_rounded, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Text(
                'Key Features',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: NeumorphicColors.getTextPrimary(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildFeatureItem(
            icon: Icons.chat_bubble_rounded,
            title: 'AI Chat Support',
            description: '24/7 AI companion powered by Gemini 2.0 Flash',
            color: NeumorphicColors.purple,
          ),
          const SizedBox(height: 12),
          _buildFeatureItem(
            icon: Icons.self_improvement_rounded,
            title: 'Self-Care Tools',
            description:
                'Breathing exercises, meditation, and relaxation sounds',
            color: NeumorphicColors.mint,
          ),
          const SizedBox(height: 12),
          _buildFeatureItem(
            icon: Icons.calendar_today_rounded,
            title: 'Daily Routines',
            description: 'Build healthy habits with customizable routines',
            color: NeumorphicColors.blue,
          ),
          const SizedBox(height: 12),
          _buildFeatureItem(
            icon: Icons.emergency_rounded,
            title: 'Emergency Help',
            description: 'Quick access to helplines and emergency contacts',
            color: NeumorphicColors.coral,
          ),
          const SizedBox(height: 12),
          _buildFeatureItem(
            icon: Icons.lock_rounded,
            title: '100% Private',
            description: 'All data stays on your device, fully encrypted',
            color: NeumorphicColors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
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
                  description,
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

  Widget _buildTechStackSection() {
    return NeumorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [NeumorphicColors.blue, NeumorphicColors.purple],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.code_rounded, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Text(
                'Technology',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: NeumorphicColors.getTextPrimary(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTechItem('Flutter', 'Cross-platform framework'),
          _buildTechItem('Firebase', 'Authentication & Cloud Storage'),
          _buildTechItem('Gemini 2.0 Flash', 'AI-powered chat'),
          _buildTechItem('Hive', 'Local database'),
          _buildTechItem('Provider', 'State management'),
        ],
      ),
    );
  }

  Widget _buildTechItem(String name, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: NeumorphicColors.mint,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: NeumorphicColors.getTextPrimary(context),
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
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

  Widget _buildTeamSection() {
    return NeumorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [NeumorphicColors.orange, NeumorphicColors.coral],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.people_rounded, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Text(
                'Our Team',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: NeumorphicColors.getTextPrimary(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [NeumorphicColors.purple, NeumorphicColors.blue],
                    ),
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Made with ❤️ by',
                  style: TextStyle(
                    fontSize: 14,
                    color: NeumorphicColors.getTextSecondary(context),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'DEVRITI Team',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: NeumorphicColors.purple,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Dedicated to mental health awareness',
                  style: TextStyle(
                    fontSize: 13,
                    color: NeumorphicColors.getTextSecondary(context),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return NeumorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [NeumorphicColors.mint, NeumorphicColors.blue],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.contact_mail_rounded,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: NeumorphicColors.getTextPrimary(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildContactItem(
            icon: Icons.email_rounded,
            title: 'Email',
            value: 'support@devriti.app',
            onTap: () => _launchEmail('support@devriti.app'),
          ),
          const SizedBox(height: 12),
          _buildContactItem(
            icon: Icons.language_rounded,
            title: 'Website',
            value: 'www.devriti.app',
            onTap: () => _launchUrl('https://devriti.app'),
          ),
          const SizedBox(height: 12),
          _buildContactItem(
            icon: Icons.code_rounded,
            title: 'GitHub',
            value: 'github.com/DevStudio2k25/Devriti',
            onTap: () => _launchUrl('https://github.com/DevStudio2k25/Devriti'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: NeumorphicColors.getCard(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: NeumorphicColors.getTextTertiary(
              context,
            ).withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: NeumorphicColors.mint, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      color: NeumorphicColors.getTextSecondary(context),
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: NeumorphicColors.getTextPrimary(context),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: NeumorphicColors.mint,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVersionInfo() {
    return NeumorphicCard(
      child: Column(
        children: [
          Text(
            'Version ${AppConstants.appVersion}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: NeumorphicColors.getTextPrimary(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '© 2025 DEVRITI. All rights reserved.',
            style: TextStyle(
              fontSize: 12,
              color: NeumorphicColors.getTextSecondary(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Made in India 🇮🇳',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: NeumorphicColors.getTextPrimary(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=DEVRITI Support',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
