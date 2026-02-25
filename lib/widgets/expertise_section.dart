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
                  Text(
                    PortfolioContent.expertiseTitle.toUpperCase(),
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: isDark
                          ? AppColors.textMainDark
                          : AppColors.textMainLight,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '[ UNLOCKED SKILL TREES ]', // Gamified title
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: accent,
                      letterSpacing: 1.5,
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
    final borderCol = isDark
        ? AppColors.retroBorderDark
        : AppColors.retroBorderLight;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: borderCol, width: 2), // Boxy icon
                  color: isDark
                      ? AppColors.darkScaffold
                      : AppColors.lightScaffold,
                ),
                child: Icon(cat.icon, color: accent, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  cat.name.toUpperCase(), // Retro caps
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Skill chips
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: cat.skills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkScaffold
                      : AppColors.lightScaffold,
                  border: Border.all(color: borderCol, width: 2), // Boxy chips
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      skill,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? AppColors.textMainDark
                            : AppColors.textMainLight,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Lv.99 ',
                          style: TextStyle(
                            fontSize: 10,
                            color: accent,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 4,
                          decoration: BoxDecoration(
                            color: accent,
                            border: Border.all(color: borderCol, width: 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
