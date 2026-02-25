import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../portfolio_content.dart';
import 'project_card.dart';

class ProjectsSection extends StatelessWidget {
  final bool isDesktop;

  const ProjectsSection({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '[ SAVE DATA ]',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 60),
        ...PortfolioContent.projects.map(
          (p) => Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: ProjectCard(project: p),
          ),
        ),
      ],
    );
  }
}
