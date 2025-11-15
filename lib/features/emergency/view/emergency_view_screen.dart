import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../../../core/localization/app_localizations.dart';
import '../../auth/services/firebase_auth_service.dart';
import '../../auth/models/user_profile_model.dart';
import '../widgets/emergency_app_bar.dart';
import '../widgets/warning_banner.dart';
import '../widgets/sos_button.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/emergency_contact_card.dart';
import '../widgets/helplines_section.dart';
import '../widgets/motivational_message.dart';

/// Modern Neumorphic Emergency Screen with 3D Depth
class EmergencyScreen extends StatefulWidget {
  final bool showBackButton;

  const EmergencyScreen({super.key, this.showBackButton = false});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen>
    with SingleTickerProviderStateMixin {
  UserProfileModel? _profile;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animationController.repeat(reverse: true);
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
          });
        }
      } else {
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final emergencyContactName =
        _profile?.emergencyContactName ?? 'Emergency Contact';
    final emergencyContactPhone =
        _profile?.emergencyContactPhone ?? '1234567890';
    final emergencyContactRelation =
        _profile?.emergencyContactRelation ?? 'Contact';

    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          EmergencyAppBar(l10n: l10n, showBackButton: widget.showBackButton),
          const WarningBanner(),
          SOSButton(
            animationController: _animationController,
            profile: _profile,
            contactName: emergencyContactName,
            contactPhone: emergencyContactPhone,
            contactRelation: emergencyContactRelation,
          ),
          QuickActionsGrid(
            profile: _profile,
            contactName: emergencyContactName,
            contactPhone: emergencyContactPhone,
          ),
          EmergencyContactCard(
            contactName: emergencyContactName,
            contactPhone: emergencyContactPhone,
            contactRelation: emergencyContactRelation,
            hasContact: _profile?.emergencyContactPhone != null,
          ),
          HelplinesSection(l10n: l10n),
          const MotivationalMessage(),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
