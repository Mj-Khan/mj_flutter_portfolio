import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/app_colors.dart';
import '../portfolio_content.dart';

class ProjectCard extends StatefulWidget {
  final ProjectData project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.darkAccent1 : AppColors.lightAccent1;
    final p = widget.project;

    final borderCol = isDark
        ? AppColors.retroBorderDark
        : AppColors.retroBorderLight;
    final bgCol = isDark ? AppColors.retroBgDark : AppColors.retroBgLight;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100), // snap
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: bgCol,
          border: Border.all(color: borderCol, width: 3),
          boxShadow: [
            BoxShadow(
              color: borderCol,
              offset: _hovered ? const Offset(8, 8) : const Offset(4, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p.icon, size: 36, color: accent),
            const SizedBox(height: 24),
            Text(
              p.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              p.tagline,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: accent,
              ),
            ),
            const SizedBox(height: 16),
            Text(p.description, style: const TextStyle(height: 1.6)),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: p.chips.map((c) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkScaffold
                        : AppColors.lightScaffold,
                    border: Border.all(color: borderCol, width: 2),
                  ),
                  child: Text(
                    c,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
            if (p.link != null) ...[
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () async {
                  final uri = Uri.parse(p.link!);
                  if (await canLaunchUrl(uri)) launchUrl(uri);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '> ${p.linkLabel!}', // Retro typing indicator
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: accent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
