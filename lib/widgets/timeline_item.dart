import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'glass_card.dart'; // RetroContainer alias

class TimelineItem extends StatelessWidget {
  final String year;
  final String company;
  final String role;
  final String description;

  const TimelineItem({
    super.key,
    required this.year,
    required this.company,
    required this.role,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.darkAccent1 : AppColors.lightAccent1;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'STAGE:\n$year',
                style: TextStyle(
                  color: isDark
                      ? AppColors.textMainDark
                      : AppColors.textMainLight,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 1.5,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: accent,
                  border: Border.all(
                    color: isDark
                        ? AppColors.retroBorderDark
                        : AppColors.retroBorderLight,
                    width: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'QUEST: ${company.toUpperCase()}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: isDark
                        ? AppColors.neoYellow
                        : AppColors.lightAccent2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'ROLE: ${role.toUpperCase()}',
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 16),
                Text(description, style: const TextStyle(height: 1.6)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
