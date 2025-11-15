import 'package:flutter/material.dart';
import '../../core/widgets/neumorphic_widgets.dart';
import '../profile/edit/widgets/gender_selector_widget.dart';
import '../profile/edit/widgets/profession_selector_widget.dart';
import 'models/user_profile_model.dart';
import 'services/firebase_auth_service.dart';
import 'widgets/custom_date_picker.dart';

/// Neumorphic Profile Setup Screen
class ProfileSetupScreen extends StatefulWidget {
  final Map<String, String>? signupData;

  const ProfileSetupScreen({super.key, this.signupData});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _professionController = TextEditingController();
  final _addressController = TextEditingController();
  final _emergencyNameController = TextEditingController();
  final _emergencyRelationController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  DateTime? _dateOfBirth;
  String? _selectedGender;
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _professionController.dispose();
    _addressController.dispose();
    _emergencyNameController.dispose();
    _emergencyRelationController.dispose();
    _emergencyContactController.dispose();
    super.dispose();
  }

  Future<void> _handleComplete() async {
    if (_formKey.currentState!.validate()) {
      if (_dateOfBirth == null) {
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
        return;
      }

      if (_selectedGender == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please select your gender'),
            backgroundColor: NeumorphicColors.coral,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        return;
      }

      setState(() => _isLoading = true);

      try {
        final user = FirebaseAuthService.currentUser;
        if (user == null) throw Exception('User not logged in');

        final profile = UserProfileModel(
          name: widget.signupData?['name'] ?? user.displayName ?? 'User',
          email: widget.signupData?['email'] ?? user.email ?? '',
          phone: _phoneController.text.trim(),
          dateOfBirth: _dateOfBirth,
          gender: _selectedGender,
          profession: _professionController.text.trim(),
          address: _addressController.text.trim(),
          emergencyContactName: _emergencyNameController.text.trim(),
          emergencyContactRelation: _emergencyRelationController.text.trim(),
          emergencyContactPhone: _emergencyContactController.text.trim(),
          createdAt: DateTime.now(),
        );

        await FirebaseAuthService.saveUserProfile(user.uid, profile);

        if (mounted) {
          Navigator.pushReplacementNamed(context, '/main');
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
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
      backgroundColor: NeumorphicColors.getBackground(context),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [_buildAppBar(), _buildForm()],
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 100,
      floating: false,
      pinned: true,
      backgroundColor: NeumorphicColors.getBackground(context),
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'Complete Your Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: NeumorphicColors.getTextPrimary(context),
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

              // Phone
              _buildTextField(
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

              // Date of Birth
              CustomDatePicker(
                selectedDate: _dateOfBirth,
                onDateSelected: (date) {
                  setState(() => _dateOfBirth = date);
                },
                label: 'Date of Birth',
                hint: 'Select your date of birth',
              ),
              const SizedBox(height: 16),

              // Gender Selector
              GenderSelectorWidget(
                selectedGender: _selectedGender,
                onGenderSelected: (gender) {
                  setState(() => _selectedGender = gender);
                },
              ),
              const SizedBox(height: 16),

              // Profession Selector
              ProfessionSelectorWidget(
                selectedProfession: _professionController.text.isEmpty
                    ? null
                    : _professionController.text,
                gender: _selectedGender ?? 'Other',
                onProfessionSelected: (profession) {
                  if (profession != null) {
                    setState(() {
                      _professionController.text = profession;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Address
              _buildTextField(
                controller: _addressController,
                label: 'Address (Optional)',
                icon: Icons.location_on_outlined,
                maxLines: 3,
              ),
              const SizedBox(height: 32),

              _buildSectionHeader(
                'Emergency Contact',
                Icons.emergency_outlined,
              ),
              const SizedBox(height: 16),

              // Emergency Name
              _buildTextField(
                controller: _emergencyNameController,
                label: 'Contact Name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),

              // Emergency Relation
              _buildTextField(
                controller: _emergencyRelationController,
                label: 'Relation',
                icon: Icons.family_restroom_outlined,
              ),
              const SizedBox(height: 16),

              // Emergency Phone
              _buildTextField(
                controller: _emergencyContactController,
                label: 'Contact Phone',
                icon: Icons.phone_in_talk_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 32),

              // Complete Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: NeumorphicColors.purple,
                        ),
                      )
                    : NeumorphicButton(
                        label: 'Complete Setup',
                        onTap: _handleComplete,
                        gradient: const LinearGradient(
                          colors: [
                            NeumorphicColors.purple,
                            NeumorphicColors.blue,
                          ],
                        ),
                      ),
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
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: NeumorphicColors.getTextPrimary(context),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: NeumorphicColors.getTextSecondary(context),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: NeumorphicColors.getBackground(context),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.6)
                    : Colors.black.withValues(alpha: 0.2),
                offset: const Offset(6, 6),
                blurRadius: 12,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.white.withValues(alpha: 0.9),
                offset: const Offset(-6, -6),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            style: TextStyle(
              fontSize: 15,
              color: NeumorphicColors.getTextPrimary(context),
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              hintText: 'Enter $label',
              hintStyle: TextStyle(
                color: NeumorphicColors.getTextTertiary(context),
                fontWeight: FontWeight.w400,
              ),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
