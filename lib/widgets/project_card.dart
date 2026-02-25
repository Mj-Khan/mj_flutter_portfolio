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

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(
              alpha: _hovered
                  ? AppColors.glassBorderHover
                  : AppColors.glassBorder,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: AppColors.glassDarkShadow)
                  : Colors.black.withValues(alpha: AppColors.glassLightShadow),
              blurRadius: _hovered ? 40 : 20,
              offset: const Offset(0, 10),
            ),
          ],
          gradient: LinearGradient(
            colors: isDark
                ? [
                    Colors.white.withValues(alpha: 0.08),
                    Colors.white.withValues(alpha: 0.03),
                  ]
                : [
                    Colors.white.withValues(alpha: 0.35),
                    Colors.white.withValues(alpha: 0.15),
                  ],
          ),
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
                fontSize: 16,
                fontWeight: FontWeight.w500,
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
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.black.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    c,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
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
                    Icon(Icons.link, size: 18, color: accent),
                    const SizedBox(width: 8),
                    Text(
                      p.linkLabel!,
                      style: TextStyle(
                        fontSize: 13,
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
