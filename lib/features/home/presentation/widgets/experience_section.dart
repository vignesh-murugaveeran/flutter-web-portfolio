import 'package:flutter/material.dart';
import '../../../../shared/widgets/animated_wrapper.dart';
import '../../../../shared/widgets/responsive_section.dart';
import '../../../../core/utils/constants.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSectionWrapper(
            child: Row(
              children: [
                Text(
                  "03. ",
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Flexible(
                  child: Text(
                    "Experience",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 1,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          ...AppConstants.experiences.asMap().entries.map((entry) {
            final index = entry.key;
            final exp = entry.value;
            return AnimatedSectionWrapper(
              delayMs: 200 + (index * 100),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 48),
                child: _ExperienceCard(experience: exp),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final ExperienceModel experience;

  const _ExperienceCard({required this.experience});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience.role,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      experience.company,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                experience.duration,
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.color?.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            experience.description,
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Theme.of(
                context,
              ).textTheme.bodyMedium?.color?.withOpacity(0.8),
            ),
          ),
          // if (experience.challengesSolved.isNotEmpty) ...[
          //   const SizedBox(height: 24),
          //   const Text(
          //     "🧠 Key Challenges Solved",
          //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          //   ),
          //   const SizedBox(height: 12),
          //   ...experience.challengesSolved
          //       .map(
          //         (challenge) => Padding(
          //           padding: const EdgeInsets.only(bottom: 8),
          //           child: Row(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.only(top: 4.0),
          //                 child: Icon(
          //                   Icons.arrow_right,
          //                   color: Theme.of(context).colorScheme.primary,
          //                 ),
          //               ),
          //               const SizedBox(width: 8),
          //               Expanded(
          //                 child: Text(
          //                   challenge,
          //                   style: TextStyle(
          //                     fontSize: 15,
          //                     height: 1.5,
          //                     color: Theme.of(
          //                       context,
          //                     ).textTheme.bodyMedium?.color?.withOpacity(0.8),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       )
          //       .toList(),
          // ],
        ],
      ),
    );
  }
}
