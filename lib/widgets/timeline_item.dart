import 'package:flutter/material.dart';
import 'glass_card.dart';

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Text(year, style: TextStyle(color: Colors.grey.shade500)),
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
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(role, style: TextStyle(color: Colors.grey.shade500)),
                const SizedBox(height: 16),
                Text(description),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
