import 'package:flutter/material.dart';
import '../../../../shared/widgets/animated_wrapper.dart';
import '../../../../shared/widgets/responsive_section.dart';
import '../../../../core/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
                  "02. ",
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Flexible(
                  child: Text(
                    "Projects",
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
          AnimatedSectionWrapper(delayMs: 200, child: const ProjectGrid()),
        ],
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

    // final crossAxisCount = screenWidth > 900 ? 3 : (screenWidth > 600 ? 2 : 1);

    final projects = AppConstants.projects;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: 380, // Fixed height to prevent overflow
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      itemBuilder: (context, index) {
        return ProjectCard(project: projects[index]);
      },
    );
  }
}

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  void _openDetails() {
    showDialog(
      context: context,
      builder: (ctx) => ProjectDetailDialog(project: widget.project),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _openDetails,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          transform: Matrix4.identity()
            ..translate(0.0, isHovered ? -10.0 : 0.0),
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
                ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.folder_outlined,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Icon(
                    Icons.open_in_new,
                    size: 24,
                    color: isHovered
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                widget.project.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isHovered
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                flex: 3,
                child: Text(
                  widget.project.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: widget.project.techStack
                    .map(
                      (t) => Text(
                        t,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectDetailDialog extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailDialog({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
      child: Container(
        width: 800,
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Expanded(
                   child: Text(
                     project.title,
                     style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                           fontWeight: FontWeight.bold,
                           color: Theme.of(context).colorScheme.primary,
                         ),
                   ),
                 ),
                 IconButton(
                   icon: const Icon(Icons.close),
                   onPressed: () => Navigator.pop(context),
                 ),
               ],
             ),
             const SizedBox(height: 16),
             Expanded(
               child: SingleChildScrollView(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     _buildSectionTitle(context, "📌 Problem Statement"),
                     _buildBodyText(context, project.problemStatement),
                     
                     const SizedBox(height: 24),
                     _buildSectionTitle(context, "🎯 My Role"),
                     _buildBodyText(context, project.role),

                     const SizedBox(height: 24),
                     _buildSectionTitle(context, "⚙️ Tech Stack & Architecture"),
                     const SizedBox(height: 12),
                     Wrap(
                       spacing: 8,
                       runSpacing: 8,
                       children: project.techStack
                           .map((t) => Chip(
                                 label: Text(t, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                 backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                 side: BorderSide.none,
                               ))
                           .toList(),
                     ),
                     
                     const SizedBox(height: 24),
                     _buildSectionTitle(context, "🚀 Key Features"),
                     const SizedBox(height: 12),
                     ...project.features.map((f) => Padding(
                       padding: const EdgeInsets.only(bottom: 8),
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Icon(Icons.check_circle, size: 20, color: Theme.of(context).colorScheme.primary),
                           const SizedBox(width: 12),
                           Expanded(child: _buildBodyText(context, f, padding: 0)),
                         ],
                       ),
                     )).toList(),
                     
                     const SizedBox(height: 24),
                     _buildSectionTitle(context, "📊 Business Impact"),
                     _buildBodyText(context, project.impact),
                   ],
                 ),
               ),
             ),
             const SizedBox(height: 24),
             Wrap(
               spacing: 16,
               runSpacing: 16,
               children: [
                 ElevatedButton.icon(
                   onPressed: () async {
                     final uri = Uri.parse(project.liveUrl);
                     if (await canLaunchUrl(uri)) await launchUrl(uri);
                   },
                   icon: const Icon(Icons.open_in_new),
                   label: const Text("Live Demo"),
                   style: ElevatedButton.styleFrom(
                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                   ),
                 ),
                 OutlinedButton.icon(
                   onPressed: () async {
                     final uri = Uri.parse(project.githubUrl);
                     if (await canLaunchUrl(uri)) await launchUrl(uri);
                   },
                   icon: const Icon(Icons.code),
                   label: const Text("View Code"),
                   style: OutlinedButton.styleFrom(
                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                   ),
                 ),
               ],
             ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
  
  Widget _buildBodyText(BuildContext context, String text, {double padding = 8.0}) {
    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, height: 1.6, color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8)),
      ),
    );
  }
}
