import 'package:flutter/material.dart';
import '../portfolio_content.dart';
import 'project_card.dart';

class ProjectsSection extends StatelessWidget {
  final bool isDesktop;

  const ProjectsSection({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          PortfolioContent.projectsTitle,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 60),
        ...PortfolioContent.projects.map(
          (p) => Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: ProjectCard(project: p),
          ),
        ),
      ],
    );
  }
}
