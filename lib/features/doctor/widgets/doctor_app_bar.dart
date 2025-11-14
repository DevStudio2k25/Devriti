import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../../../core/localization/app_localizations.dart';

class DoctorAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppLocalizations l10n;

  const DoctorAppBar({super.key, required this.l10n});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: NeumorphicColors.background,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NeumorphicButton(
          icon: Icons.arrow_back_rounded,
          onTap: () => Navigator.pop(context),
        ),
      ),
      title: Row(
        children: [
          NeumorphicContainer(
            width: 40,
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [NeumorphicColors.blue, NeumorphicColors.purple],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.medical_services_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            l10n.consultDoctor,
            style: const TextStyle(
              color: NeumorphicColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
