import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../portfolio_content.dart';
import 'glass_card.dart';

class ExpertiseSection extends StatelessWidget {
  final bool isDesktop;

  const ExpertiseSection({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.darkAccent1 : AppColors.lightAccent1;
    final accent2 = isDark ? AppColors.darkAccent2 : AppColors.lightAccent2;
    final cats = PortfolioContent.skillCategories;

    // On desktop: 2-column grid; on mobile: single column
    final rows = <Widget>[];
    for (int i = 0; i < cats.length; i += (isDesktop ? 2 : 1)) {
      final left = cats[i];
      final right = (isDesktop && i + 1 < cats.length) ? cats[i + 1] : null;
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _SkillCategoryCard(
                cat: left,
                accent: accent,
                accent2: accent2,
                isDark: isDark,
              ),
            ),
            if (right != null) ...[
              const SizedBox(width: 24),
              Expanded(
                child: _SkillCategoryCard(
                  cat: right,
                  accent: accent,
                  accent2: accent2,
                  isDark: isDark,
                ),
              ),
            ] else if (isDesktop)
              const Expanded(child: SizedBox()),
          ],
        ),
      );
      if (i + (isDesktop ? 2 : 1) < cats.length) {
        rows.add(const SizedBox(height: 24));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    PortfolioContent.expertiseTitle,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Technologies & tools I work with',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textMuted,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 48),
        ...rows,
      ],
    );
  }
}

class _SkillCategoryCard extends StatelessWidget {
  final SkillCategory cat;
  final Color accent;
  final Color accent2;
  final bool isDark;

  const _SkillCategoryCard({
    required this.cat,
    required this.accent,
    required this.accent2,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category header
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: accent.withValues(alpha: 0.14),
                ),
                child: Icon(cat.icon, color: accent, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  cat.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Skill chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: cat.skills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.07)
                      : Colors.black.withValues(alpha: 0.05),
                  border: Border.all(color: accent.withValues(alpha: 0.25)),
                ),
                child: Text(
                  skill,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.85)
                        : Colors.black.withValues(alpha: 0.75),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
