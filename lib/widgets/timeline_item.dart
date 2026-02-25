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
                year,
                style: TextStyle(
                  color: isDark
                      ? AppColors.textMainDark
                      : AppColors.textMainLight,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                color: accent, // Chunky year separator
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
                  company,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '> $role',
                  style: TextStyle(color: accent, fontWeight: FontWeight.w600),
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
