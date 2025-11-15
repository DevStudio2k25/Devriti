import 'package:flutter/material.dart';
import 'animated_mascot.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 40, top: 20, bottom: 20),
      child: Align(alignment: Alignment.centerLeft, child: AnimatedMascot()),
    );
  }
}
