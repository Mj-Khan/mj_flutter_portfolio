import 'package:flutter/material.dart';
import '../portfolio_content.dart';
import 'timeline_item.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          PortfolioContent.experienceTitle,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
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
