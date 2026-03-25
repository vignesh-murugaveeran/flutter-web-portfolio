import 'package:flutter/material.dart';
import '../../../../shared/widgets/animated_wrapper.dart';
import '../../../../core/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: AppConstants.desktopMaxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSectionWrapper(
                child: Row(
                  children: [
                    Text(
                      "02. ",
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Some Things I've Built",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
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
                child: const ProjectGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectGrid extends StatelessWidget {
  const ProjectGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 900 ? 3 : (screenWidth > 600 ? 2 : 1);

    final projects = [
      Project(title: "E-Commerce App", description: "A scalable e-commerce application built with Flutter & Firebase. Features real-time cart updates and payment integration.", tech: ["Flutter", "Firebase", "Stripe"]),
      Project(title: "Task Manager Pro", description: "Advanced productivity tool with offline-first capabilities using Isar Database and Riverpod.", tech: ["Flutter", "Isar", "Riverpod"]),
      Project(title: "Social Dashboard Web", description: "Responsive web dashboard for social media analytics, crafted with Flutter Web and interactive charts.", tech: ["Flutter Web", "Charts"]),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.1,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      itemBuilder: (context, index) {
        return ProjectCard(project: projects[index]);
      },
    );
  }
}

class Project {
  final String title;
  final String description;
  final List<String> tech;
  Project({required this.title, required this.description, required this.tech});
}

class ProjectCard extends StatefulWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  void _launchURL() async {
    final Uri url = Uri.parse(AppConstants.githubUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launchURL,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          transform: Matrix4.identity()..translate(0.0, isHovered ? -10.0 : 0.0),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              if (isHovered)
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              else
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
            ],
          ),
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.folder_outlined, size: 40, color: Theme.of(context).colorScheme.primary),
                  Icon(Icons.open_in_new, size: 24, color: isHovered ? Theme.of(context).colorScheme.primary : Colors.grey),
                ],
              ),
              const Spacer(),
              Text(
                widget.project.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isHovered ? Theme.of(context).colorScheme.primary : null,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.project.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Wrap(
                spacing: 12,
                children: widget.project.tech
                    .map((t) => Text(
                          t,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
