import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../../auth/models/user_profile_model.dart';
import '../../auth/services/firebase_auth_service.dart';
import '../edit/profile_edit_screen.dart';
import 'widgets/profile_header_widget.dart';
import 'widgets/profile_stats_widget.dart';
import 'widgets/profile_info_section_widget.dart';
import 'widgets/profile_action_buttons_widget.dart';

/// Modern Neumorphic Profile View Screen
class ProfileViewScreen extends StatefulWidget {
  final bool showBackButton;

  const ProfileViewScreen({super.key, this.showBackButton = false});

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen>
    with SingleTickerProviderStateMixin {
  UserProfileModel? _profile;
  bool _isLoading = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _loadProfile();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
          _animationController.forward();
        }
      } else {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading profile: $e'),
            backgroundColor: NeumorphicColors.coral,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_profile == null) {
      return _buildNoProfileState(context);
    }

    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildAppBar(context),
            _buildProfileHeader(),
            _buildStatsGrid(),
            _buildPersonalInfoSection(),
            _buildEmergencyContactSection(),
            _buildActionButtons(context),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NeumorphicContainer(
              width: 80,
              height: 80,
              child: const CircularProgressIndicator(
                color: NeumorphicColors.purple,
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Loading profile...',
              style: TextStyle(
                fontSize: 16,
                color: NeumorphicColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoProfileState(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NeumorphicContainer(
                width: 120,
                height: 120,
                isCircle: true,
                child: const Icon(
                  Icons.person_off_outlined,
                  size: 60,
                  color: NeumorphicColors.textTertiary,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'No Profile Found',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: NeumorphicColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Create your profile to get started',
                style: TextStyle(
                  fontSize: 15,
                  color: NeumorphicColors.textSecondary.withValues(alpha: 0.9),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/profile-setup'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        NeumorphicColors.purple,
                        NeumorphicColors.purpleLight,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: NeumorphicColors.purple.withValues(alpha: 0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Create Profile',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 80,
      floating: false,
      pinned: true,
      backgroundColor: NeumorphicColors.background,
      elevation: 0,
      leading: widget.showBackButton
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: NeumorphicButton(
                icon: Icons.arrow_back_rounded,
                onTap: () => Navigator.pop(context),
              ),
            )
          : const SizedBox.shrink(),
      flexibleSpace: const FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: NeumorphicColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: ProfileHeaderWidget(profile: _profile!),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: ProfileStatsWidget(profile: _profile!),
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: ProfileInfoSectionWidget(
          title: 'Personal Information',
          icon: Icons.person_outline_rounded,
          color: NeumorphicColors.purple,
          items: [
            if (_profile!.email != null)
              ProfileInfoItem(
                icon: Icons.email_outlined,
                label: 'Email',
                value: _profile!.email!,
                color: NeumorphicColors.blue,
              ),
            if (_profile!.phone != null)
              ProfileInfoItem(
                icon: Icons.phone_outlined,
                label: 'Phone',
                value: _profile!.phone!,
                color: NeumorphicColors.mint,
              ),
            if (_profile!.dateOfBirth != null)
              ProfileInfoItem(
                icon: Icons.cake_outlined,
                label: 'Date of Birth',
                value: DateFormat('dd MMM yyyy').format(_profile!.dateOfBirth!),
                color: NeumorphicColors.purple,
              ),
            if (_profile!.gender != null)
              ProfileInfoItem(
                icon: Icons.wc_outlined,
                label: 'Gender',
                value: _profile!.gender!,
                color: NeumorphicColors.coral,
              ),
            if (_profile!.profession != null)
              ProfileInfoItem(
                icon: Icons.work_outline_rounded,
                label: 'Profession',
                value: _profile!.profession!,
                color: NeumorphicColors.orange,
              ),
            if (_profile!.address != null)
              ProfileInfoItem(
                icon: Icons.location_on_outlined,
                label: 'Address',
                value: _profile!.address!,
                color: NeumorphicColors.blue,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyContactSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: ProfileInfoSectionWidget(
          title: 'Emergency Contact',
          icon: Icons.emergency_rounded,
          color: NeumorphicColors.coral,
          items: [
            if (_profile!.emergencyContactName != null)
              ProfileInfoItem(
                icon: Icons.person_outline_rounded,
                label: 'Name',
                value: _profile!.emergencyContactName!,
                color: NeumorphicColors.coral,
              ),
            if (_profile!.emergencyContactRelation != null)
              ProfileInfoItem(
                icon: Icons.family_restroom_outlined,
                label: 'Relation',
                value: _profile!.emergencyContactRelation!,
                color: NeumorphicColors.coral,
              ),
            if (_profile!.emergencyContactPhone != null)
              ProfileInfoItem(
                icon: Icons.phone_in_talk_outlined,
                label: 'Phone',
                value: _profile!.emergencyContactPhone!,
                color: NeumorphicColors.coral,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: ProfileActionButtonsWidget(
          onEditPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileEditScreen(profile: _profile!),
              ),
            );
            if (result == true && mounted) {
              _loadProfile();
            }
          },
          onLogoutPressed: () async {
            await FirebaseAuthService.logout();
            if (mounted) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            }
          },
        ),
      ),
    );
  }
}
