import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../portfolio_content.dart';
import 'gradient_text.dart'; // RetroText
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 4, // Chunky retro divider
          color: isDark
              ? AppColors.retroBorderDark
              : AppColors.retroBorderLight,
        ),
        const SizedBox(height: 80),
        RetroText(
          PortfolioContent.contactHeadline,
          style: const TextStyle(
            fontSize: 52,
            height: 1.15,
            fontWeight: FontWeight.w900,
          ),
          color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
          shadowColor: accent1,
        ),
        const SizedBox(height: 24),
        Text(
          PortfolioContent.contactSubtext,
          style: TextStyle(
            fontSize: 17,
            height: 1.8,
            color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
          ),
        ),
        const SizedBox(height: 48),
        Wrap(
          spacing: 20,
          runSpacing: 20,
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
        // Footer text
        Center(
          child: Text(
            PortfolioContent.copyrightLine.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textMuted,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ],
    );
  }
}
