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
    final borderCol = isDark
        ? AppColors.retroBorderDark
        : AppColors.retroBorderLight;

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
        color: isDark ? AppColors.darkScaffold : AppColors.lightScaffold,
        border: Border(
          right: BorderSide(color: borderCol, width: 4), // Chunky boundary
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
                children: [
                  Text(
                    PortfolioContent.displayName.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? AppColors.textMainDark
                          : AppColors.textMainLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    PortfolioContent.role,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 60),

          // ── Navigation ──
          Text(
            '[ NAVIGATION ]',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 2.5,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
            ),
          ),
          const SizedBox(height: 24),
          ...navItems.map(
            (item) => NavLink(
              label: item.$1.toUpperCase(),
              isActive: activeSection == item.$1,
              accentColor: accent1,
              onTap: () => onNavTap(item.$2),
            ),
          ),

          const SizedBox(height: 60),

          // ── Connect ──
          Text(
            '[ CONNECT ]',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 2.5,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
            ),
          ),
          const SizedBox(height: 24),
          ...PortfolioContent.socialLinks.expand(
            (s) => [
              SocialLink(
                icon: s.icon,
                label: s.label.toUpperCase(),
                url: s.url,
                accentColor: accent1,
              ),
              const SizedBox(height: 12),
            ],
          ),

          const Spacer(),

          // ── Theme Switch ──
          Row(
            children: [
              Icon(Icons.light_mode, size: 18, color: AppColors.textMuted),
              const SizedBox(width: 12),
              AnimatedThemeSwitch(isDark: isDark, onChanged: onToggleTheme),
              const SizedBox(width: 12),
              Icon(Icons.dark_mode, size: 18, color: AppColors.textMuted),
            ],
          ),
        ],
      ),
    );
  }
}
