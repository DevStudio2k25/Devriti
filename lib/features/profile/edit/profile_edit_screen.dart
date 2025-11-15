import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../../auth/models/user_profile_model.dart';
import '../../auth/services/firebase_auth_service.dart';
import '../../auth/widgets/custom_date_picker.dart';
import 'widgets/edit_text_field_widget.dart';
import 'widgets/gender_selector_widget.dart';
import 'widgets/profession_selector_widget.dart';

/// Modern Neumorphic Profile Edit Screen
class ProfileEditScreen extends StatefulWidget {
  final UserProfileModel profile;

  const ProfileEditScreen({super.key, required this.profile});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _professionController;
  late TextEditingController _addressController;
  late TextEditingController _emergencyNameController;
  late TextEditingController _emergencyRelationController;
  late TextEditingController _emergencyContactController;
  DateTime? _dateOfBirth;
  String? _selectedGender;
  bool _isLoading = false;
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

    _nameController = TextEditingController(text: widget.profile.name);
    _phoneController = TextEditingController(text: widget.profile.phone);
    _professionController = TextEditingController(
      text: widget.profile.profession,
    );
    _addressController = TextEditingController(text: widget.profile.address);
    _emergencyNameController = TextEditingController(
      text: widget.profile.emergencyContactName,
    );
    _emergencyRelationController = TextEditingController(
      text: widget.profile.emergencyContactRelation,
    );
    _emergencyContactController = TextEditingController(
      text: widget.profile.emergencyContactPhone,
    );
    _dateOfBirth = widget.profile.dateOfBirth;
    _selectedGender = widget.profile.gender;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _professionController.dispose();
    _addressController.dispose();
    _emergencyNameController.dispose();
    _emergencyRelationController.dispose();
    _emergencyContactController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (_formKey.currentState!.validate()) {
      if (_dateOfBirth == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Please select your date of birth'),
              backgroundColor: NeumorphicColors.coral,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
        return;
      }

      setState(() => _isLoading = true);

      try {
        final user = FirebaseAuthService.currentUser;
        if (user == null) throw Exception('User not logged in');

        final updatedProfile = UserProfileModel(
          name: _nameController.text.trim(),
          email: widget.profile.email,
          phone: _phoneController.text.trim(),
          dateOfBirth: _dateOfBirth,
          gender: _selectedGender,
          profession: _professionController.text.trim(),
          address: _addressController.text.trim(),
          emergencyContactName: _emergencyNameController.text.trim(),
          emergencyContactRelation: _emergencyRelationController.text.trim(),
          emergencyContactPhone: _emergencyContactController.text.trim(),
        );

        await FirebaseAuthService.updateUserProfile(user.uid, updatedProfile);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Profile updated successfully!'),
              backgroundColor: NeumorphicColors.mint,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error updating profile: $e'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [_buildAppBar(), _buildForm()],
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 80,
      floating: false,
      pinned: true,
      backgroundColor: NeumorphicColors.background,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NeumorphicButton(
          icon: Icons.close_rounded,
          onTap: () => Navigator.pop(context),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _isLoading
              ? const SizedBox(
                  width: 44,
                  height: 44,
                  child: Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: NeumorphicColors.purple,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                )
              : NeumorphicButton(
                  icon: Icons.check_rounded,
                  onTap: _handleSave,
                  gradient: const LinearGradient(
                    colors: [NeumorphicColors.mint, NeumorphicColors.blue],
                  ),
                ),
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: const FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: NeumorphicColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Personal Information', Icons.person_outline),
              const SizedBox(height: 16),
              EditTextFieldWidget(
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              EditTextFieldWidget(
                controller: _phoneController,
                label: 'Phone Number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomDatePicker(
                selectedDate: _dateOfBirth,
                onDateSelected: (date) {
                  setState(() => _dateOfBirth = date);
                },
                label: 'Date of Birth',
                hint: 'Select your date of birth',
              ),
              const SizedBox(height: 16),
              GenderSelectorWidget(
                selectedGender: _selectedGender,
                onGenderSelected: (gender) {
                  setState(() => _selectedGender = gender);
                },
              ),
              const SizedBox(height: 16),
              ProfessionSelectorWidget(
                selectedProfession: _professionController.text.isEmpty
                    ? null
                    : _professionController.text,
                gender: _selectedGender ?? 'Other',
                onProfessionSelected: (profession) {
                  if (profession != null) {
                    _professionController.text = profession;
                  }
                },
              ),
              const SizedBox(height: 16),
              EditTextFieldWidget(
                controller: _addressController,
                label: 'Address',
                icon: Icons.location_on_outlined,
                maxLines: 3,
              ),
              const SizedBox(height: 32),
              _buildSectionHeader(
                'Emergency Contact',
                Icons.emergency_outlined,
              ),
              const SizedBox(height: 16),
              EditTextFieldWidget(
                controller: _emergencyNameController,
                label: 'Contact Name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              EditTextFieldWidget(
                controller: _emergencyRelationController,
                label: 'Relation',
                icon: Icons.family_restroom_outlined,
              ),
              const SizedBox(height: 16),
              EditTextFieldWidget(
                controller: _emergencyContactController,
                label: 'Contact Phone',
                icon: Icons.phone_in_talk_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        NeumorphicContainer(
          width: 40,
          height: 40,
          child: Icon(icon, color: NeumorphicColors.purple, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: NeumorphicColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
