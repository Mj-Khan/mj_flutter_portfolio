import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../models/experience.dart';
import 'glass_card.dart';

/// Renders a single experience role in the timeline.
/// Accepts an [ExperienceRole] model which includes structured bullets,
/// context_line, and date fields — not flat strings.
class TimelineItem extends StatelessWidget {
  final ExperienceRole role;

  const TimelineItem({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.darkAccent1 : AppColors.lightAccent1;

    // Format "YYYY-MM" → "MMM YYYY", keep "Present" as-is
    final startLabel = _formatDate(role.startDate);
    final endLabel = role.isCurrent ? 'Present' : _formatDate(role.endDate);
    final dateRange = '$startLabel – $endLabel';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dateRange,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              if (role.workMode != null) ...[
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: accent.withValues(alpha: 0.1),
                  ),
                  child: Text(
                    role.workMode!,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: accent,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Company + location
                Text(
                  role.company,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  role.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: accent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  role.location,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                ),
                // Context line (italic summary)
                const SizedBox(height: 12),
                Text(
                  role.contextLine,
                  style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade500,
                    height: 1.5,
                  ),
                ),
                // Bullet points
                const SizedBox(height: 16),
                ...role.bullets.map(
                  (b) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: accent.withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            b,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.65,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Converts "YYYY-MM" → "Jun 2024". Returns raw string for anything else.
  static String _formatDate(String raw) {
    final parts = raw.split('-');
    if (parts.length == 2) {
      final year = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      if (year != null && month != null) {
        const months = [
          '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
        ];
        return '${months[month]} $year';
      }
    }
    return raw;
  }
}
