import 'package:flutter/material.dart';
import '../../core/widgets/neumorphic_widgets.dart';

class AIProfileScreen extends StatelessWidget {
  const AIProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      appBar: AppBar(
        backgroundColor: NeumorphicColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: NeumorphicColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'AI Companion',
          style: TextStyle(
            color: NeumorphicColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // AI Avatar
              NeumorphicContainer(
                width: 120,
                height: 120,
                isCircle: true,
                child: const Icon(
                  Icons.psychology_rounded,
                  size: 60,
                  color: NeumorphicColors.purple,
                ),
              ),

              const SizedBox(height: 20),

              // AI Name
              const Text(
                'DEVRITI AI',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: NeumorphicColors.textPrimary,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 8),

              // AI Tagline
              Text(
                'Your Mental Health Companion',
                style: TextStyle(
                  fontSize: 14,
                  color: NeumorphicColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: 30),

              // About AI Section
              NeumorphicCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: NeumorphicColors.purple.withValues(
                              alpha: 0.15,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.info_rounded,
                            color: NeumorphicColors.purple,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'About Me',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: NeumorphicColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'I am DEVRITI AI, powered by Google\'s Gemini 2.0 Flash. I\'m here to provide you with compassionate support, helpful guidance, and a listening ear whenever you need it. Available 24/7 to help you navigate your mental health journey.',
                      style: TextStyle(
                        fontSize: 14,
                        color: NeumorphicColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Capabilities Section
              NeumorphicCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: NeumorphicColors.mint.withValues(
                              alpha: 0.15,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.star_rounded,
                            color: NeumorphicColors.mint,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'What I Can Do',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: NeumorphicColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildCapabilityItem(
                      icon: Icons.chat_bubble_rounded,
                      title: 'Supportive Conversations',
                      description:
                          'Have meaningful chats about your feelings and thoughts',
                      color: NeumorphicColors.purple,
                    ),
                    const SizedBox(height: 12),
                    _buildCapabilityItem(
                      icon: Icons.lightbulb_rounded,
                      title: 'Helpful Suggestions',
                      description:
                          'Get personalized tips for managing stress and anxiety',
                      color: NeumorphicColors.orange,
                    ),
                    const SizedBox(height: 12),
                    _buildCapabilityItem(
                      icon: Icons.favorite_rounded,
                      title: 'Emotional Support',
                      description:
                          'A safe space to express yourself without judgment',
                      color: NeumorphicColors.coral,
                    ),
                    const SizedBox(height: 12),
                    _buildCapabilityItem(
                      icon: Icons.psychology_rounded,
                      title: 'Mental Health Guidance',
                      description:
                          'Learn coping strategies and wellness techniques',
                      color: NeumorphicColors.blue,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Tech Info Section
              NeumorphicCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: NeumorphicColors.blue.withValues(
                              alpha: 0.15,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.memory_rounded,
                            color: NeumorphicColors.blue,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Technology',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: NeumorphicColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTechItem('Model', 'Gemini 2.0 Flash'),
                    _buildTechItem('Provider', 'Google AI'),
                    _buildTechItem('Availability', '24/7'),
                    _buildTechItem('Privacy', '100% Confidential'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Important Note
              NeumorphicCard(
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      color: NeumorphicColors.orange,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'I\'m here to support you, but I\'m not a replacement for professional medical advice. For emergencies, please contact a healthcare professional.',
                        style: TextStyle(
                          fontSize: 12,
                          color: NeumorphicColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCapabilityItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: NeumorphicColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: NeumorphicColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: NeumorphicColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: NeumorphicColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
