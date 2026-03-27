import 'package:flutter/material.dart';
import '../../../../shared/widgets/animated_wrapper.dart';
import '../../../../shared/widgets/responsive_section.dart';
import '../../../../core/utils/constants.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ResponsiveSection(
      backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final double imageSize = screenWidth < 400 ? 220.0 : 300.0;

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
            width: imageSize,
            height: imageSize,
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
            width: imageSize,
            height: imageSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              image: const DecorationImage(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.aboutMeText,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.8,
            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8),
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          AppConstants.aboutGoalText,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.8,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class SkillsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Core Competencies",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.5),
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 650;
            return Wrap(
              spacing: 24,
              runSpacing: 24,
              children: AppConstants.categorizedSkills.entries.map((category) {
                return SizedBox(
                  width: isDesktop 
                    ? (constraints.maxWidth - 24) / 2 
                    : constraints.maxWidth,
                  child: _CategoryCard(
                    title: category.key,
                    skills: category.value,
                  ),
                );
              }).toList(),
            );
          }
        ),
      ],
    );
  }
}

class _CategoryCard extends StatefulWidget {
  final String title;
  final List<String> skills;

  const _CategoryCard({required this.title, required this.skills});

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool isHovered = false;

  IconData _getIconForCategory(String title) {
    final lower = title.toLowerCase();
    if (lower.contains("front")) return Icons.web_rounded;
    if (lower.contains("back")) return Icons.dns_rounded;
    if (lower.contains("state")) return Icons.account_tree_rounded;
    if (lower.contains("data")) return Icons.storage_rounded;
    return Icons.build_circle_outlined;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHovered 
                ? Theme.of(context).colorScheme.primary.withOpacity(0.5) 
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (isHovered)
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(isDark ? 0.2 : 0.1),
                blurRadius: 20,
                spreadRadius: 2,
              )
            else
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getIconForCategory(widget.title),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.skills.map((s) => SkillChip(skill: s)).toList(),
            ),
          ],
        ),
      ),
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
