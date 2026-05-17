import 'package:flutter/material.dart';
import '../data/app_data.dart';
import 'timeline_item.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final roles = AppData.of(context).content.experience;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Experience',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 60),
        ...roles.expand(
          (role) => [
            TimelineItem(role: role),
            const SizedBox(height: 60),
          ],
        ),
      ],
    );
  }
}
