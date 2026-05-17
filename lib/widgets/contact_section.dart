import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/icon_resolver.dart';
import '../data/app_data.dart';
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
    final appData = AppData.of(context);
    final footer = appData.siteConfig.config.contactFooter;
    final socialIconMap = appData.siteConfig.config.socialIconMap;
    final profile = appData.content.profile;

    // Build the copyright line at runtime so the year stays current.
    final copyrightLine =
        '© ${DateTime.now().year} ${profile.fullName} · ${footer.copyright}';

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
          footer.headline,
          style: const TextStyle(
            fontSize: 52,
            height: 1.15,
            fontWeight: FontWeight.w800,
          ),
          colors: [accent1, accent2],
        ),
        const SizedBox(height: 24),
        Text(
          footer.subtext,
          style: const TextStyle(fontSize: 17, height: 1.8),
        ),
        const SizedBox(height: 48),
        Wrap(
          spacing: 20,
          runSpacing: 16,
          children: [
            CtaButton(
              label: 'Send an Email',
              icon: iconFromName(socialIconMap['email'] ?? 'email_outlined'),
              url: profile.emailUrl,
              filled: true,
              accent: accent1,
            ),
            CtaButton(
              label: 'GitHub',
              icon: iconFromName(socialIconMap['github'] ?? 'code_rounded'),
              url: profile.githubUrl,
              filled: false,
              accent: accent1,
            ),
            CtaButton(
              label: 'LinkedIn',
              icon: iconFromName(
                  socialIconMap['linkedin'] ?? 'work_outline_rounded'),
              url: profile.linkedInUrl,
              filled: false,
              accent: accent1,
            ),
          ],
        ),
        const SizedBox(height: 80),
        Text(
          copyrightLine,
          style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
        ),
      ],
    );
  }
}
