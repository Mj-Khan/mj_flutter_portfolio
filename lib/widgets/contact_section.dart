import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../portfolio_content.dart';
import 'gradient_text.dart';
import 'cta_button.dart';

class ContactSection extends StatelessWidget {
  final Color accent1;
  final Color accent2;

  const ContactSection({
    super.key,
    required this.accent1,
    required this.accent2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                accent1.withValues(alpha: 0.5),
                accent2.withValues(alpha: 0.0),
              ],
            ),
          ),
        ),
        const SizedBox(height: 80),
        GradientText(
          PortfolioContent.contactHeadline,
          style: const TextStyle(
            fontSize: 52,
            height: 1.15,
            fontWeight: FontWeight.w800,
          ),
          colors: [accent1, accent2],
        ),
        const SizedBox(height: 24),
        const Text(
          PortfolioContent.contactSubtext,
          style: TextStyle(fontSize: 17, height: 1.8),
        ),
        const SizedBox(height: 48),
        Wrap(
          spacing: 20,
          runSpacing: 16,
          children: [
            CtaButton(
              label: 'Send an Email',
              icon: Icons.email_outlined,
              url: PortfolioContent.emailUrl,
              filled: true,
              accent: accent1,
            ),
            CtaButton(
              label: 'GitHub',
              icon: Icons.code_rounded,
              url: PortfolioContent.githubUrl,
              filled: false,
              accent: accent1,
            ),
            CtaButton(
              label: 'LinkedIn',
              icon: Icons.work_outline_rounded,
              url: PortfolioContent.linkedInUrl,
              filled: false,
              accent: accent1,
            ),
          ],
        ),
        const SizedBox(height: 80),
        Text(
          PortfolioContent.copyrightLine,
          style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
        ),
      ],
    );
  }
}
