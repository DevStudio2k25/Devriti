import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'models/user_profile_model.dart';
import 'services/firebase_auth_service.dart';
import 'widgets/auth_background.dart';
import 'widgets/auth_card.dart';
import 'widgets/auth_button.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/custom_date_picker.dart';

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
        final signupData = widget.signupData;
        if (signupData == null) {
          throw Exception('Signup data not found');
        }

        // Create profile model
        final profile = UserProfileModel(
          name: signupData['name']!,
          email: signupData['email']!,
          phone: _phoneController.text.trim(),
          dateOfBirth: _dateOfBirth,
          gender: _selectedGender,
          profession: _professionController.text.trim(),
          address: _addressController.text.trim(),
          emergencyContactName: _emergencyNameController.text.trim(),
          emergencyContactRelation: _emergencyRelationController.text.trim(),
          emergencyContactPhone: _emergencyContactController.text.trim(),
        );

        // Sign up with Firebase
        await FirebaseAuthService.signUp(
          email: signupData['email']!,
          password: signupData['password']!,
          profile: profile,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Profile created successfully! 🎉'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );

          // Navigate to home
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
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
    final signupData = widget.signupData;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            const AuthBackground(),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Header
                    const Icon(
                      Icons.person_add_rounded,
                      size: 60,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Complete Your Profile',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Hello ${signupData?['name'] ?? 'there'}! Let\'s set up your profile',
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // Form Card
                    AuthCard(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Phone Number
                            AuthTextField(
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

                            // Date of Birth Picker
                            CustomDatePicker(
                              label: 'Date of Birth',
                              hint: 'Select your date of birth',
                              selectedDate: _dateOfBirth,
                              onDateSelected: (date) {
                                setState(() => _dateOfBirth = date);
                              },
                            ),

                            const SizedBox(height: 16),

                            // Gender Dropdown
                            DropdownButtonFormField<String>(
                              value: _selectedGender,
                              decoration: InputDecoration(
                                labelText: 'Gender',
                                hintText: 'Select your gender',
                                prefixIcon: const Icon(Icons.person_outline),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: AppColors.border,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: AppColors.primary,
                                    width: 2,
                                  ),
                                ),
                              ),
                              items: ['Male', 'Female', 'Other']
                                  .map(
                                    (gender) => DropdownMenuItem(
                                      value: gender,
                                      child: Text(gender),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() => _selectedGender = value);
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
                            AuthTextField(
                              controller: _professionController,
                              label: 'Profession',
                              hint: 'e.g., Student, Engineer, Doctor',
                              icon: Icons.work_outline,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your profession';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            // Address
                            AuthTextField(
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

                            const SizedBox(height: 24),

                            // Emergency Contact Section Header
                            const Text(
                              'Emergency Contact Details',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Emergency Contact Name
                            AuthTextField(
                              controller: _emergencyNameController,
                              label: 'Emergency Contact Name',
                              hint: 'Full name',
                              icon: Icons.person_outline,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter emergency contact name';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            // Emergency Contact Relation
                            AuthTextField(
                              controller: _emergencyRelationController,
                              label: 'Relation',
                              hint: 'e.g., Father, Mother, Spouse',
                              icon: Icons.family_restroom_outlined,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter relation';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            // Emergency Contact Phone
                            AuthTextField(
                              controller: _emergencyContactController,
                              label: 'Emergency Contact Phone',
                              hint: '+91 98765 43210',
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter emergency contact phone';
                                }
                                if (value.length < 10) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 24),

                            // Complete Button
                            AuthButton(
                              text: 'Complete Profile',
                              onPressed: _handleComplete,
                              isLoading: _isLoading,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
