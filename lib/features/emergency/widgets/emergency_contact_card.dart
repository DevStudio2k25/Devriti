import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import 'edit_emergency_contact_dialog.dart';

class EmergencyContactCard extends StatelessWidget {
  final String contactName;
  final String contactPhone;
  final String contactRelation;
  final bool hasContact;

  const EmergencyContactCard({
    super.key,
    required this.contactName,
    required this.contactPhone,
    required this.contactRelation,
    required this.hasContact,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Emergency Contact',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: NeumorphicColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            NeumorphicContainer(
              padding: const EdgeInsets.all(20),
              child: hasContact
                  ? Row(
                      children: [
                        NeumorphicContainer(
                          width: 60,
                          height: 60,
                          isCircle: true,
                          child: const Icon(
                            Icons.person_rounded,
                            color: NeumorphicColors.teal,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contactName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: NeumorphicColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                contactRelation,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: NeumorphicColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                contactPhone,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: NeumorphicColors.teal,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        NeumorphicButton(
                          icon: Icons.edit_rounded,
                          onTap: () async {
                            final result =
                                await showDialog<Map<String, String>>(
                                  context: context,
                                  builder: (context) =>
                                      EditEmergencyContactDialog(
                                        currentName: contactName,
                                        currentPhone: contactPhone,
                                        currentRelation: contactRelation,
                                      ),
                                );

                            if (result != null && context.mounted) {
                              // TODO: Save to database/state management
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Contact updated: ${result['name']}',
                                  ),
                                  backgroundColor: NeumorphicColors.mint,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const Icon(
                          Icons.person_add_rounded,
                          color: NeumorphicColors.textSecondary,
                          size: 40,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'No emergency contact set',
                          style: TextStyle(
                            fontSize: 14,
                            color: NeumorphicColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () async {
                            final result =
                                await showDialog<Map<String, String>>(
                                  context: context,
                                  builder: (context) =>
                                      const EditEmergencyContactDialog(),
                                );

                            if (result != null && context.mounted) {
                              // TODO: Save to database/state management
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Contact added: ${result['name']}',
                                  ),
                                  backgroundColor: NeumorphicColors.mint,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  NeumorphicColors.teal,
                                  Color(0xFF00A896),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Add Contact',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
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
}
