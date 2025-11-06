import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../auth/models/user_profile_model.dart';
import '../auth/services/firebase_auth_service.dart';
import '../auth/widgets/custom_date_picker.dart';
import 'widgets/gender_selector_field.dart';
import 'widgets/profession_selector_field.dart';

class ProfileEditScreen extends StatefulWidget {
  final UserProfileModel profile;

  const ProfileEditScreen({super.key, required this.profile});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
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

  @override
  void initState() {
    super.initState();
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please select your date of birth'),
            backgroundColor: AppColors.error,
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
              content: const Text('Profile updated successfully! 🎉'),
              backgroundColor: AppColors.success,
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.calmGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Update your information',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Form Content
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      padding: const EdgeInsets.all(24),
                      children: [
                        // Personal Information Section
                        _buildSectionHeader(
                          icon: Icons.person_outline,
                          title: 'Personal Information',
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 16),

                        // Name
                        _buildTextField(
                          controller: _nameController,
                          label: 'Full Name',
                          hint: 'Enter your name',
                          icon: Icons.person_outline,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Phone Number
                        _buildTextField(
                          controller: _phoneController,
                          label: 'Phone Number',
                          hint: '+91 98765 43210',
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (value.length < 10) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Date of Birth
                        CustomDatePicker(
                          label: 'Date of Birth',
                          hint: 'Select your date of birth',
                          selectedDate: _dateOfBirth,
                          onDateSelected: (date) {
                            setState(() => _dateOfBirth = date);
                          },
                        ),

                        const SizedBox(height: 16),

                        // Gender
                        GenderSelectorField(
                          selectedGender: _selectedGender,
                          onGenderSelected: (gender) {
                            setState(() {
                              _selectedGender = gender;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select your gender';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Profession
                        ProfessionSelectorField(
                          selectedProfession: _professionController.text.isEmpty
                              ? null
                              : _professionController.text,
                          gender: _selectedGender,
                          onProfessionSelected: (profession) {
                            setState(() {
                              _professionController.text = profession ?? '';
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select your profession';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Address
                        _buildTextField(
                          controller: _addressController,
                          label: 'Address',
                          hint: 'Your full address',
                          icon: Icons.location_on_outlined,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 32),

                        // Emergency Contact Section
                        _buildSectionHeader(
                          icon: Icons.emergency_outlined,
                          title: 'Emergency Contact',
                          color: AppColors.error,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This person will be contacted in case of emergency',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Emergency Contact Card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.error.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.error.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              // Emergency Contact Name
                              _buildTextField(
                                controller: _emergencyNameController,
                                label: 'Contact Name',
                                hint: 'Full name',
                                icon: Icons.person_outline,
                                fillColor: Colors.white,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter contact name';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 16),

                              // Relation & Phone Row
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTextField(
                                      controller: _emergencyRelationController,
                                      label: 'Relation',
                                      hint: 'e.g., Father',
                                      icon: Icons.family_restroom_outlined,
                                      fillColor: Colors.white,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter relation';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _buildTextField(
                                      controller: _emergencyContactController,
                                      label: 'Phone',
                                      hint: '+91 98765',
                                      icon: Icons.phone_outlined,
                                      keyboardType: TextInputType.phone,
                                      fillColor: Colors.white,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter phone';
                                        }
                                        if (value.length < 10) {
                                          return 'Invalid phone';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Save Button
                        _buildSaveButton(),

                        const SizedBox(height: 16),
                      ],
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

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    Color? fillColor,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 20),
        filled: true,
        fillColor: fillColor ?? AppColors.background.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: AppColors.calmGradient),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isLoading ? null : _handleSave,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: _isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save_outlined, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Save Changes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
