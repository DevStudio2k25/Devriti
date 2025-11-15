import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';

class EditEmergencyContactDialog extends StatefulWidget {
  final String? currentName;
  final String? currentPhone;
  final String? currentRelation;

  const EditEmergencyContactDialog({
    super.key,
    this.currentName,
    this.currentPhone,
    this.currentRelation,
  });

  @override
  State<EditEmergencyContactDialog> createState() =>
      _EditEmergencyContactDialogState();
}

class _EditEmergencyContactDialogState
    extends State<EditEmergencyContactDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _relationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName ?? '');
    _phoneController = TextEditingController(text: widget.currentPhone ?? '');
    _relationController = TextEditingController(
      text: widget.currentRelation ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _relationController.dispose();
    super.dispose();
  }

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      final contactData = {
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'relation': _relationController.text.trim(),
      };
      Navigator.pop(context, contactData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: NeumorphicColors.getBackground(context),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: NeumorphicColors.coral.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.emergency_rounded,
                          color: NeumorphicColors.coral,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Emergency Contact',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: NeumorphicColors.getTextPrimary(context),
                          ),
                        ),
                      ),
                      NeumorphicButton(
                        icon: Icons.close_rounded,
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Name Field
                  _buildLabel('Contact Name'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _nameController,
                    hint: 'e.g., John Doe',
                    icon: Icons.person_rounded,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter contact name';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Phone Field
                  _buildLabel('Phone Number'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _phoneController,
                    hint: 'e.g., +91 98765 43210',
                    icon: Icons.phone_rounded,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter phone number';
                      }
                      if (value.trim().length < 10) {
                        return 'Please enter valid phone number';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Relation Field
                  _buildLabel('Relationship'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _relationController,
                    hint: 'e.g., Father, Mother, Friend',
                    icon: Icons.family_restroom_rounded,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter relationship';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: NeumorphicColors.getCard(context),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(3, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              'Cancel',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: NeumorphicColors.getTextSecondary(
                                  context,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: _saveContact,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  NeumorphicColors.coral,
                                  NeumorphicColors.orange,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: NeumorphicColors.coral.withValues(
                                    alpha: 0.4,
                                  ),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Text(
                              'Save',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: NeumorphicColors.getTextPrimary(context),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return NeumorphicCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            color: NeumorphicColors.getTextSecondary(context),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              style: TextStyle(
                fontSize: 16,
                color: NeumorphicColors.getTextPrimary(context),
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: NeumorphicColors.getTextSecondary(context),
                  fontSize: 14,
                ),
                border: InputBorder.none,
                errorStyle: const TextStyle(fontSize: 11),
              ),
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}
