import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/app_colors.dart';
import '../core/animations.dart';

class MobileTopBar extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onToggleTheme;
  final String activeSection;
  final void Function(GlobalKey) onNavTap;
  final GlobalKey heroKey;
  final GlobalKey expertiseKey;
  final GlobalKey experienceKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;

  const MobileTopBar({
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

  void _openDrawer(BuildContext context) {
    final navItems = [
      ('About', heroKey),
      ('Expertise', expertiseKey),
      ('Experience', experienceKey),
      ('Projects', projectsKey),
      ('Contact', contactKey),
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        final currentIsDark =
            Theme.of(sheetContext).brightness == Brightness.dark;

        // Retro styling
        final borderCol = currentIsDark
            ? AppColors.retroBorderDark
            : AppColors.retroBorderLight;
        final bgCol = currentIsDark
            ? AppColors.retroBgDark
            : AppColors.retroBgLight;
        final accent = currentIsDark
            ? AppColors.darkAccent1
            : AppColors.lightAccent1;

        return LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
              margin: const EdgeInsets.all(12), // Floating retro menu
              decoration: BoxDecoration(
                color: bgCol,
                border: Border.all(color: borderCol, width: 4),
                boxShadow: [
                  BoxShadow(color: borderCol, offset: const Offset(6, 6)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '--- SYSTEM MENU ---',
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w800,
                      color: currentIsDark
                          ? AppColors.textMainDark
                          : AppColors.textMainLight,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...navItems.map(
                    (item) => GestureDetector(
                      onTap: () {
                        Navigator.pop(sheetContext);
                        onNavTap(item.$2);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 12,
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: activeSection == item.$1
                              ? accent.withValues(alpha: 0.15)
                              : Colors.transparent,
                          border: activeSection == item.$1
                              ? Border.all(color: accent, width: 2)
                              : Border.all(color: Colors.transparent, width: 2),
                        ),
                        child: Row(
                          children: [
                            if (activeSection == item.$1)
                              Text(
                                '> ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: accent,
                                ),
                              )
                            else
                              const SizedBox(width: 18),
                            Text(
                              item.$1.toUpperCase(), // Retro terminal caps
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: activeSection == item.$1
                                    ? FontWeight.w800
                                    : FontWeight.w600,
                                color: activeSection == item.$1
                                    ? accent
                                    : (currentIsDark
                                          ? AppColors.textMainDark
                                          : AppColors.textMainLight),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(height: 4, color: borderCol), // Retro divider
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _MobileIconLink(
                        icon: Icons.email_outlined,
                        url: 'mailto:mjkhan7124@gmail.com',
                        color: accent,
                      ),
                      const SizedBox(width: 24),
                      _MobileIconLink(
                        icon: Icons.code_rounded,
                        url: 'https://github.com/Mj-Khan',
                        color: accent,
                      ),
                      const SizedBox(width: 24),
                      _MobileIconLink(
                        icon: Icons.work_outline_rounded,
                        url: 'https://linkedin.com/in/abdul-mujeeb-khan',
                        color: accent,
                      ),
                      const Spacer(),
                      AnimatedThemeSwitch(
                        isDark: currentIsDark,
                        onChanged: onToggleTheme,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final borderCol = isDark
        ? AppColors.retroBorderDark
        : AppColors.retroBorderLight;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkScaffold : AppColors.lightScaffold,
        border: Border(
          bottom: BorderSide(
            color: borderCol,
            width: 4,
          ), // Chunky bottom border
        ),
      ),
      child: Row(
        children: [
          Text(
            'ABDUL_MUJEEB',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => _openDrawer(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: borderCol, width: 2), // Boxy button
              ),
              child: Icon(
                Icons.menu_rounded,
                size: 24,
                color: isDark
                    ? AppColors.textMainDark
                    : AppColors.textMainLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileIconLink extends StatelessWidget {
  final IconData icon;
  final String url;
  final Color color;

  const _MobileIconLink({
    required this.icon,
    required this.url,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) launchUrl(uri);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 2), // Boxy social links
        ),
        child: Icon(icon, size: 22, color: color),
      ),
    );
  }
}
