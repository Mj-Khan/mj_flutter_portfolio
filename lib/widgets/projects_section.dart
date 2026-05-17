import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../core/icon_resolver.dart';
import 'project_card.dart';

class ProjectsSection extends StatelessWidget {
  final bool isDesktop;

  const ProjectsSection({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final appData = AppData.of(context);
    // Home screen shows featured projects only, sorted by end_date desc.
    final projects = appData.content.featuredProjects;
    final projectIconMap = appData.siteConfig.config.iconMap.projects;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Projects',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 60),
        ...projects.map(
          (p) => Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: ProjectCard(
              project: p,
              icon: iconFromName(projectIconMap[p.id] ?? 'circle_outlined'),
            ),
          ),
        ),
      ],
    );
  }
}
