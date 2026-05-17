import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/app_colors.dart';
import '../core/animations.dart';
import '../core/icon_resolver.dart';
import '../data/app_data.dart';

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

    // Read profile + icon map from AppData
    final appData = AppData.of(context);
    final profile = appData.content.profile;
    final socialIconMap = appData.siteConfig.config.socialIconMap;

    final socialLinks = [
      (
        icon: iconFromName(socialIconMap['email'] ?? 'email_outlined'),
        url: profile.emailUrl,
      ),
      (
        icon: iconFromName(socialIconMap['github'] ?? 'code_rounded'),
        url: profile.githubUrl,
      ),
      (
        icon: iconFromName(socialIconMap['linkedin'] ?? 'work_outline_rounded'),
        url: profile.linkedInUrl,
      ),
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        final currentIsDark =
            Theme.of(sheetContext).brightness == Brightness.dark;
        final accent1 =
            currentIsDark ? AppColors.darkAccent1 : AppColors.lightAccent1;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
          decoration: BoxDecoration(
            color: currentIsDark
                ? AppColors.darkScaffold
                : AppColors.lightScaffold,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(
              color: currentIsDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.05),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 32),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                'NAVIGATION',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 16),
              ...navItems.map(
                (item) => GestureDetector(
                  onTap: () {
                    Navigator.pop(sheetContext);
                    onNavTap(item.$2);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          width: activeSection == item.$1 ? 20 : 12,
                          height: 2,
                          decoration: BoxDecoration(
                            color: activeSection == item.$1
                                ? accent1
                                : Colors.grey.shade500,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          item.$1,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: activeSection == item.$1
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: activeSection == item.$1
                                ? accent1
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Divider(color: Colors.grey.withValues(alpha: 0.15)),
              const SizedBox(height: 20),
              Row(
                children: [
                  ...socialLinks.map(
                    (s) => Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: _MobileIconLink(icon: s.icon, url: s.url),
                    ),
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
  }

  @override
  Widget build(BuildContext context) {
    final profile = AppData.of(context).content.profile;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        children: [
          Text(
            profile.displayName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => _openDrawer(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.menu_rounded,
                size: 24,
                color: Colors.grey.shade600,
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

  const _MobileIconLink({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) launchUrl(uri);
      },
      child: Icon(icon, size: 22, color: Colors.grey.shade500),
    );
  }
}
