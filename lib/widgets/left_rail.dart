import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/animations.dart';
import '../portfolio_content.dart' hide SocialLink;
import 'avatar_widget.dart';
import 'nav_link.dart';
import 'social_link.dart';

class LeftRail extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onToggleTheme;
  final String activeSection;
  final void Function(GlobalKey) onNavTap;
  final GlobalKey heroKey;
  final GlobalKey expertiseKey;
  final GlobalKey experienceKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;

  const LeftRail({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
    required this.activeSection,
    required this.onNavTap,
    required this.heroKey,
    required this.expertiseKey,
    required this.experienceKey,
    required this.projectsKey,
    required this.contactKey,
  });

  @override
  Widget build(BuildContext context) {
    final accent1 = isDark ? AppColors.darkAccent1 : AppColors.lightAccent1;

    final navItems = [
      ('About', heroKey),
      ('Expertise', expertiseKey),
      ('Experience', experienceKey),
      ('Projects', projectsKey),
      ('Contact', contactKey),
    ];

    return Container(
      width: 320,
      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 56),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: AppColors.textMuted.withValues(alpha: 0.2)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Avatar + Identity ──
          Row(
            children: [
              const AvatarWidget(size: 52),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    PortfolioContent.displayName,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    PortfolioContent.role,
                    style: TextStyle(fontSize: 13, color: AppColors.textMuted),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 48),

          // ── Navigation ──
          const Text(
            'NAVIGATION',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 2.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 20),
          ...navItems.map(
            (item) => NavLink(
              label: item.$1,
              isActive: activeSection == item.$1,
              accentColor: accent1,
              onTap: () => onNavTap(item.$2),
            ),
          ),

          const SizedBox(height: 40),

          // ── Connect ──
          const Text(
            'CONNECT',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 2.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 20),
          ...PortfolioContent.socialLinks.expand(
            (s) => [
              SocialLink(icon: s.icon, label: s.label, url: s.url),
              const SizedBox(height: 14),
            ],
          ),

          const Spacer(),

          // ── Theme Switch ──
          Row(
            children: [
              Icon(
                isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                size: 18,
                color: AppColors.textMuted,
              ),
              const SizedBox(width: 14),
              AnimatedThemeSwitch(isDark: isDark, onChanged: onToggleTheme),
            ],
          ),
        ],
      ),
    );
  }
}
