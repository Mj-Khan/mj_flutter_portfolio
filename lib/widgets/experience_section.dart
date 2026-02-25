import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../portfolio_content.dart';
import 'timeline_item.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? AppColors.textMainDark : AppColors.textMainLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '[ QUEST LOG ]',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: color,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 60),
        ...PortfolioContent.experienceItems.expand(
          (e) => [
            TimelineItem(
              year: e.year,
              company: e.company,
              role: e.role,
              description: e.description,
            ),
            const SizedBox(height: 60),
          ],
        ),
      ],
    );
  }
}
