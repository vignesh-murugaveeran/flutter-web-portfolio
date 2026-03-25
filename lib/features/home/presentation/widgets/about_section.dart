import 'package:flutter/material.dart';
import '../../../../shared/widgets/animated_wrapper.dart';
import '../../../../core/utils/constants.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
      color: isDark ? const Color(0xFF1E293B) : Colors.white,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.desktopMaxWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSectionWrapper(
                child: Row(
                  children: [
                    Text(
                      "01. ",
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "About Me",
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              AnimatedSectionWrapper(
                delayMs: 200,
                child: ResponsiveAboutLayout(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResponsiveAboutLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 900) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [AboutText(), const SizedBox(height: 40), SkillsList()],
            ),
          ),
          const SizedBox(width: 80),
          Expanded(flex: 2, child: ProfileImageContainer()),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileImageContainer(),
          const SizedBox(height: 60),
          AboutText(),
          const SizedBox(height: 40),
          SkillsList(),
        ],
      );
    }
  }
}

class ProfileImageContainer extends StatefulWidget {
  @override
  State<ProfileImageContainer> createState() => _ProfileImageContainerState();
}

class _ProfileImageContainerState extends State<ProfileImageContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.identity()
              ..translate(isHovered ? 15.0 : 20.0, isHovered ? 15.0 : 20.0),
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.identity()
              ..translate(isHovered ? -5.0 : 0.0, isHovered ? -5.0 : 0.0),
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              image: DecorationImage(
                image: AssetImage(AppConstants.profileImage),
                fit: BoxFit.cover,
              ),
            ),
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isHovered
                  ? Colors.transparent
                  : Theme.of(context).colorScheme.primary.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }
}

class AboutText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      AppConstants.aboutMeText +
          "\n\nI specialize in building visually appealing, highly interactive, and performant user interfaces. "
              "My passion lies in bridging the gap between elegant design and robust engineering—taking a project from a blank canvas to a fully realized, scalable application."
              "\n\nWith extensive experience in Flutter, I focus on clean architecture, state management best practices, and pushing the boundaries of what is possible on Web, iOS, and Android platforms. Whether it's adding delightful micro-interactions or architecting complex systems, I always strive for excellence.",
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        height: 1.8,
        color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8),
        fontSize: 18,
      ),
    );
  }
}

class SkillsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final skills = [
      "Flutter & Dart",
      "UI/UX Design",
      "State Management",
      "Animations (flutter_animate)",
      "Responsive Web Design",
      "Firebase / REST APIs",
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Here are a few technologies I've been working with recently:",
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: skills.map((s) => SkillChip(skill: s)).toList(),
        ),
      ],
    );
  }
}

class SkillChip extends StatelessWidget {
  final String skill;
  const SkillChip({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(skill, style: const TextStyle(fontWeight: FontWeight.w500)),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      side: BorderSide(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}
