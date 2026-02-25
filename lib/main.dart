// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mj_flutter_portfolio/portfolio_content.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ResumeApp());
}

class ResumeApp extends StatefulWidget {
  const ResumeApp({super.key});

  @override
  State<ResumeApp> createState() => _ResumeAppState();
}

class _ResumeAppState extends State<ResumeApp> {
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        fontFamily: 'Inter',
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.lightScaffold,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Inter',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkScaffold,
        useMaterial3: true,
      ),
      home: ResumeHome(
        isDark: isDark,
        onToggleTheme: (v) => setState(() => isDark = v),
      ),
    );
  }
}

/* =========================================================
   COLORS
========================================================= */

class AppColors {
  // ── Backgrounds ──────────────────────────────────────────
  static const lightScaffold = Color(0xFFF3F7F4); // warm white-green
  static const darkScaffold  = Color(0xFF0C1010); // deep forest black

  // ── Accents ───────────────────────────────────────────────
  static const lightAccent1 = Color(0xFF22C55E); // vibrant green
  static const lightAccent2 = Color(0xFF0EA5E9); // sky blue

  static const darkAccent1  = Color(0xFF4ADE80); // bright lime-green
  static const darkAccent2  = Color(0xFF38BDF8); // lighter sky blue

  // ── Background blobs ──────────────────────────────────────
  static const blob1a = Color(0x2822C55E); // green blob
  static const blob1b = Color(0x1022C55E);
  static const blob2a = Color(0x280EA5E9); // sky blob
  static const blob2b = Color(0x100EA5E9);
  static const blob3a = Color(0x1A4ADE80); // lime accent blob
  static const blob3b = Color(0x0A4ADE80);

  // Legacy blob aliases
  static const blobGradient1 = blob1a;
  static const blobGradient2 = blob2a;

  // ── Glass card ────────────────────────────────────────────
  static const glassBorder      = 0.15;
  static const glassBorderHover = 0.30;
  static const glassLightShadow = 0.12;
  static const glassDarkShadow  = 0.55;

  // ── Semantic text colors ──────────────────────────────────
  static const textMuted    = Color(0xFF9E9E9E); // ~grey.shade500
  static const textSub      = Color(0xFF757575); // ~grey.shade600
  static const drawerHandle = Color(0xFFBDBDBD); // ~grey.shade400

  // ── Status ────────────────────────────────────────────────
  static const available = Color(0xFF22C55E); // open to work green

  // ── Utility ───────────────────────────────────────────────
  static const white70 = Color(0xB3FFFFFF);
  static const black87 = Color(0xDD000000);
}


/* =========================================================
   HOME LAYOUT (LEFT RAIL + GRID)
========================================================= */

class ResumeHome extends StatefulWidget {
  final bool isDark;
  final void Function(bool) onToggleTheme;

  const ResumeHome({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<ResumeHome> createState() => _ResumeHomeState();
}

class _ResumeHomeState extends State<ResumeHome>
    with TickerProviderStateMixin {
  late AnimationController _blobController;
  late AnimationController _entranceController;

  // Entrance animations
  late Animation<double> _railFade;
  late Animation<Offset> _railSlide;
  late Animation<double> _contentFade;
  late Animation<Offset> _contentSlide;

  Offset mouseOffset = Offset.zero;
  Offset _cursorPos = Offset.zero;

  // Section keys for scroll-to-section
  final _heroKey = GlobalKey();
  final _expertiseKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

  final _scrollController = ScrollController();
  String _activeSection = 'About';

  void _scrollToSection(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _onScroll() {
    final sections = [
      ('About', _heroKey),
      ('Expertise', _expertiseKey),
      ('Experience', _experienceKey),
      ('Projects', _projectsKey),
    ];

    for (final (label, key) in sections.reversed) {
      final ctx = key.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final pos = box.localToGlobal(Offset.zero);
      if (pos.dy <= 200) {
        if (_activeSection != label) setState(() => _activeSection = label);
        return;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _blobController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..repeat();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _railFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    );
    _railSlide = Tween<Offset>(
      begin: const Offset(-0.04, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    ));
    _contentFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.15, 1.0, curve: Curves.easeOut),
    );
    _contentSlide = Tween<Offset>(
      begin: const Offset(0, 0.03),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.15, 1.0, curve: Curves.easeOut),
    ));

    _scrollController.addListener(_onScroll);

    // Start entrance after first frame
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _entranceController.forward(),
    );
  }

  @override
  void dispose() {
    _blobController.dispose();
    _entranceController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent1 =
        widget.isDark ? AppColors.darkAccent1 : AppColors.lightAccent1;
    final accent2 =
        widget.isDark ? AppColors.darkAccent2 : AppColors.lightAccent2;

    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1000;

    return Scaffold(
      body: MouseRegion(
        onHover: (e) {
          setState(() {
            _cursorPos = e.position;
            mouseOffset = Offset(
              (e.position.dx - size.width / 2) / size.width,
              (e.position.dy - size.height / 2) / size.height,
            );
          });
        },
        child: Stack(
          children: [
            BackgroundBlobs(
              controller: _blobController,
              mouseOffset: mouseOffset,
            ),
            // Cursor spotlight glow
            if (_cursorPos != Offset.zero)
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _CursorGlowPainter(
                      position: _cursorPos,
                      accent: widget.isDark
                          ? AppColors.darkAccent1
                          : AppColors.lightAccent1,
                    ),
                  ),
                ),
              ),
            Column(
              children: [
                // Mobile-only top bar
                if (!isDesktop)
                  MobileTopBar(
                    isDark: widget.isDark,
                    onToggleTheme: widget.onToggleTheme,
                    activeSection: _activeSection,
                    onNavTap: (key) => _scrollToSection(key),
                    heroKey: _heroKey,
                    expertiseKey: _expertiseKey,
                    experienceKey: _experienceKey,
                    projectsKey: _projectsKey,
                    contactKey: _contactKey,
                  ),
                Expanded(
                  child: Row(
                    children: [
                      if (isDesktop)
                        SlideTransition(
                          position: _railSlide,
                          child: FadeTransition(
                            opacity: _railFade,
                            child: LeftRail(
                              isDark: widget.isDark,
                              onToggleTheme: widget.onToggleTheme,
                              activeSection: _activeSection,
                              onNavTap: (key) => _scrollToSection(key),
                              heroKey: _heroKey,
                              expertiseKey: _expertiseKey,
                              experienceKey: _experienceKey,
                              projectsKey: _projectsKey,
                            ),
                          ),
                        ),
                      Expanded(
                        child: FadeTransition(
                          opacity: _contentFade,
                          child: SlideTransition(
                            position: _contentSlide,
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              padding: EdgeInsets.only(
                                left: isDesktop ? 80 : 32,
                                right: isDesktop ? 120 : 32,
                                top: isDesktop ? 80 : 40,
                                bottom: 0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RevealOnScroll(
                                    scrollController: _scrollController,
                                    delay: Duration.zero,
                                    child: SizedBox(key: _heroKey, child: _hero(accent1, accent2, isDesktop)),
                                  ),
                                  const SizedBox(height: 120),
                                  RevealOnScroll(
                                    scrollController: _scrollController,
                                    delay: const Duration(milliseconds: 100),
                                    child: SizedBox(key: _expertiseKey, child: _expertiseSection(isDesktop)),
                                  ),
                                  const SizedBox(height: 120),
                                  RevealOnScroll(
                                    scrollController: _scrollController,
                                    delay: const Duration(milliseconds: 200),
                                    child: SizedBox(key: _experienceKey, child: _experienceSection()),
                                  ),
                                  const SizedBox(height: 120),
                                  RevealOnScroll(
                                    scrollController: _scrollController,
                                    delay: const Duration(milliseconds: 300),
                                    child: SizedBox(key: _projectsKey, child: _projectsSection(isDesktop)),
                                  ),
                                  const SizedBox(height: 120),
                                  RevealOnScroll(
                                    scrollController: _scrollController,
                                    delay: const Duration(milliseconds: 200),
                                    child: SizedBox(key: _contactKey, child: _contactSection(accent1, accent2)),
                                  ),
                                  const SizedBox(height: 80),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /* =========================================================
     HERO
  ========================================================= */

  Widget _hero(Color a1, Color a2, bool isDesktop) {
    return LayoutBuilder(builder: (context, constraints) {
      final wide = constraints.maxWidth > 900;

      return wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _heroText(a1, a2)),
                const SizedBox(width: 80),
                Expanded(flex: 1, child: _heroSideCard()),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _heroText(a1, a2),
                const SizedBox(height: 60),
                _heroSideCard(),
              ],
            );
    });
  }

  Widget _heroText(Color a1, Color a2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PortfolioContent.heroLabel,
          style: const TextStyle(
            fontSize: 12,
            letterSpacing: 3,
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 24),
        GradientText(
          PortfolioContent.heroHeadline,
          style: const TextStyle(
            fontSize: 64,
            height: 1.1,
            fontWeight: FontWeight.w800,
          ),
          colors: [a1, a2],
        ),
        const SizedBox(height: 40),
        const Text(
          PortfolioContent.heroBio,
          style: TextStyle(fontSize: 18, height: 1.8),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 40,
          runSpacing: 20,
          children: PortfolioContent.metrics
              .map((m) => _Metric(m.value, m.label))
              .toList(),
        )
      ],
    );
  }

  Widget _heroSideCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.darkAccent1 : AppColors.lightAccent1;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                PortfolioContent.focusAreasTitle,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.available.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.available.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.available,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      PortfolioContent.availabilityLabel,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.available,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...PortfolioContent.focusAreas.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: accent.withValues(alpha: 0.12),
                    ),
                    child: Icon(item.icon, color: accent, size: 18),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      item.label,
                      style: const TextStyle(fontSize: 14, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* =========================================================
     EXPERTISE GRID
  ========================================================= */

  Widget _expertiseSection(bool isDesktop) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.darkAccent1 : AppColors.lightAccent1;
    final accent2 = isDark ? AppColors.darkAccent2 : AppColors.lightAccent2;
    final cats = PortfolioContent.skillCategories;

    // On desktop: 2-column grid; on mobile: single column
    final rows = <Widget>[];
    for (int i = 0; i < cats.length; i += (isDesktop ? 2 : 1)) {
      final left = cats[i];
      final right = (isDesktop && i + 1 < cats.length) ? cats[i + 1] : null;
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _skillCategoryCard(left, accent, accent2, isDark)),
            if (right != null) ...[
              const SizedBox(width: 24),
              Expanded(
                  child: _skillCategoryCard(right, accent, accent2, isDark)),
            ] else if (isDesktop)
              const Expanded(child: SizedBox()),
          ],
        ),
      );
      if (i + (isDesktop ? 2 : 1) < cats.length) {
        rows.add(const SizedBox(height: 24));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    PortfolioContent.expertiseTitle,
                    style: TextStyle(
                        fontSize: 36, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Technologies & tools I work with',
                    style: TextStyle(
                        fontSize: 15,
                        color: AppColors.textMuted,
                        height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 48),
        ...rows,
      ],
    );
  }

  Widget _skillCategoryCard(
    SkillCategory cat,
    Color accent,
    Color accent2,
    bool isDark,
  ) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category header
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: accent.withValues(alpha: 0.14),
                ),
                child: Icon(cat.icon, color: accent, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  cat.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Skill chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: cat.skills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.07)
                      : Colors.black.withValues(alpha: 0.05),
                  border: Border.all(
                    color: accent.withValues(alpha: 0.25),
                  ),
                ),
                child: Text(
                  skill,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.85)
                        : Colors.black.withValues(alpha: 0.75),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }


  /* =========================================================
     EXPERIENCE TIMELINE
  ========================================================= */

  Widget _experienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          PortfolioContent.experienceTitle,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 60),
        ...PortfolioContent.experienceItems.expand((e) => [
          TimelineItem(
            year: e.year,
            company: e.company,
            role: e.role,
            description: e.description,
          ),
          const SizedBox(height: 60),
        ]),
      ],
    );
  }

  /* =========================================================
     CONTACT
  ========================================================= */

  Widget _contactSection(Color a1, Color a2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [a1.withValues(alpha: 0.5), a2.withValues(alpha: 0.0)],
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
          colors: [a1, a2],
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
            _CtaButton(
              label: 'Send an Email',
              icon: Icons.email_outlined,
              url: PortfolioContent.emailUrl,
              filled: true,
              accent: a1,
            ),
            _CtaButton(
              label: 'GitHub',
              icon: Icons.code_rounded,
              url: PortfolioContent.githubUrl,
              filled: false,
              accent: a1,
            ),
            _CtaButton(
              label: 'LinkedIn',
              icon: Icons.work_outline_rounded,
              url: PortfolioContent.linkedInUrl,
              filled: false,
              accent: a1,
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

  /* =========================================================
     PROJECTS
  ========================================================= */

  Widget _projectsSection(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          PortfolioContent.projectsTitle,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 60),
        ...PortfolioContent.projects.map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: ProjectCard(project: p),
            )),
      ],
    );
  }
}

/* =========================================================
   LEFT RAIL
========================================================= */

class LeftRail extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onToggleTheme;
  final String activeSection;
  final void Function(GlobalKey) onNavTap;
  final GlobalKey heroKey;
  final GlobalKey expertiseKey;
  final GlobalKey experienceKey;
  final GlobalKey projectsKey;

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
  });

  @override
  Widget build(BuildContext context) {
    final accent1 = isDark ? AppColors.darkAccent1 : AppColors.lightAccent1;

    final navItems = [
      ('About', heroKey),
      ('Expertise', expertiseKey),
      ('Experience', experienceKey),
      ('Projects', projectsKey),
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
              AvatarWidget(size: 52),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    PortfolioContent.displayName,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  const Text(
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
            (item) => _NavLink(
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
          ...PortfolioContent.socialLinks.expand((s) => [
            _SocialLink(icon: s.icon, label: s.label, url: s.url),
            const SizedBox(height: 14),
          ]),

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

/* =========================================================
   MOBILE TOP BAR
========================================================= */

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
    final accent1 = isDark ? AppColors.darkAccent1 : AppColors.lightAccent1;
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
      builder: (_) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkScaffold : AppColors.lightScaffold,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
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
                  Navigator.pop(context);
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
                _MobileIconLink(
                  icon: Icons.email_outlined,
                  url: 'mailto:mjkhan7124@gmail.com',
                ),
                const SizedBox(width: 24),
                _MobileIconLink(
                  icon: Icons.code_rounded,
                  url: 'https://github.com/Mj-Khan',
                ),
                const SizedBox(width: 24),
                _MobileIconLink(
                  icon: Icons.work_outline_rounded,
                  url: 'https://linkedin.com/in/abdul-mujeeb-khan',
                ),
                const Spacer(),
                AnimatedThemeSwitch(isDark: isDark, onChanged: onToggleTheme),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        children: [
          const Text(
            'Abdul Mujeeb',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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

/* =========================================================
   CTA BUTTON
========================================================= */

class _CtaButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final String url;
  final bool filled;
  final Color accent;

  const _CtaButton({
    required this.label,
    required this.icon,
    required this.url,
    required this.filled,
    required this.accent,
  });

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton> {
  bool _hovered = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg = widget.filled
        ? widget.accent.withValues(alpha: _hovered ? 1.0 : 0.85)
        : Colors.transparent;

    final border = widget.filled
        ? Colors.transparent
        : widget.accent.withValues(alpha: _hovered ? 0.7 : 0.35);

    final textColor = widget.filled
        ? Colors.white
        : _hovered
            ? widget.accent
            : (isDark ? Colors.white70 : Colors.black87);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _launch,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: border, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 18, color: textColor),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* =========================================================
   NAV LINK
========================================================= */

class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final Color accentColor;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = widget.isActive
        ? widget.accentColor
        : _hovered
            ? (isDark ? Colors.white70 : Colors.black87)
            : Colors.grey.shade500;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: widget.isActive ? 24 : 14,
                height: 2,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 17,
                  fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
                  color: color,
                ),
                child: Text(widget.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* =========================================================
   SOCIAL LINK
========================================================= */

class _SocialLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;

  const _SocialLink({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  State<_SocialLink> createState() => _SocialLinkState();
}

class _SocialLinkState extends State<_SocialLink> {
  bool _hovered = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = _hovered
        ? (isDark ? Colors.white : Colors.black87)
        : Colors.grey.shade500;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _launch,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: color,
          ),
          child: Row(
            children: [
              Icon(widget.icon, size: 16, color: color),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* =========================================================
   COMPONENTS
========================================================= */

/* =========================================================
   CURSOR GLOW PAINTER
========================================================= */

class _CursorGlowPainter extends CustomPainter {
  final Offset position;
  final Color accent;

  _CursorGlowPainter({required this.position, required this.accent});

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 500.0;
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          accent.withValues(alpha: 0.10),
          accent.withValues(alpha: 0.04),
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 1.0],
      ).createShader(Rect.fromCircle(center: position, radius: radius));
    canvas.drawCircle(position, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _CursorGlowPainter old) =>
      old.position != position || old.accent != accent;
}

/* =========================================================
   AVATAR WIDGET
========================================================= */

class AvatarWidget extends StatelessWidget {
  final double size;
  const AvatarWidget({super.key, this.size = 52});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final c1 = isDark ? AppColors.darkAccent1 : AppColors.lightAccent1;
    final c2 = isDark ? AppColors.darkAccent2 : AppColors.lightAccent2;

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _AvatarPainter(color1: c1, color2: c2),
      ),
    );
  }
}

class _AvatarPainter extends CustomPainter {
  final Color color1;
  final Color color2;
  _AvatarPainter({required this.color1, required this.color2});

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width / 2;
    final center = Offset(r, r);

    // Background circle
    final bgPaint = Paint()
      ..shader = RadialGradient(
        colors: [color1, color2],
        center: Alignment.topLeft,
      ).createShader(Rect.fromCircle(center: center, radius: r));
    canvas.drawCircle(center, r, bgPaint);

    final personPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.92)
      ..style = PaintingStyle.fill;

    // Head
    final headRadius = r * 0.30;
    final headCenter = Offset(r, r * 0.72);
    canvas.drawCircle(headCenter, headRadius, personPaint);

    // Shoulders / body shape (clipped to circle)
    final bodyPath = Path();
    final bodyTop = headCenter.dy + headRadius * 0.7;
    final bodyWidth = r * 0.80;
    bodyPath.moveTo(center.dx - bodyWidth, size.height + 2);
    bodyPath.quadraticBezierTo(
      center.dx - bodyWidth * 0.5, bodyTop,
      center.dx, bodyTop,
    );
    bodyPath.quadraticBezierTo(
      center.dx + bodyWidth * 0.5, bodyTop,
      center.dx + bodyWidth, size.height + 2,
    );
    bodyPath.close();

    // Clip body to the circle
    canvas.save();
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: center, radius: r)));
    canvas.drawPath(bodyPath, personPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _AvatarPainter old) =>
      old.color1 != color1 || old.color2 != color2;
}

class _Metric extends StatelessWidget {
  final String value;
  final String label;

  const _Metric(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade500)),
      ],
    );
  }
}


class ExpertiseCard extends StatelessWidget {
  final ExpertiseItem item;

  const ExpertiseCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          Text(item.description, style: const TextStyle(height: 1.6)),
          if (item.proof != null) ...[
            const SizedBox(height: 20),
            Text(
              '→ ${item.proof!}',
              style: const TextStyle(color: AppColors.textMuted),
            ),
          ]
        ],
      ),
    );
  }
}

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
          child: Text(year,
              style: TextStyle(color: Colors.grey.shade500)),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(company,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(role,
                    style: TextStyle(color: Colors.grey.shade500)),
                const SizedBox(height: 16),
                Text(description),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ProjectCard extends StatefulWidget {
  final ProjectData project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.darkAccent1 : AppColors.lightAccent1;
    final p = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(
                alpha: _hovered
                    ? AppColors.glassBorderHover
                    : AppColors.glassBorder),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: AppColors.glassDarkShadow)
                  : Colors.black.withValues(alpha: AppColors.glassLightShadow),
              blurRadius: _hovered ? 40 : 20,
              offset: const Offset(0, 10),
            )
          ],
          gradient: LinearGradient(
            colors: isDark
                ? [
                    Colors.white.withValues(alpha: 0.08),
                    Colors.white.withValues(alpha: 0.03)
                  ]
                : [
                    Colors.white.withValues(alpha: 0.35),
                    Colors.white.withValues(alpha: 0.15)
                  ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Icon + Titles ──
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: accent.withValues(alpha: 0.15),
                  ),
                  child: Icon(p.icon, color: accent, size: 22),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        p.tagline,
                        style:
                            TextStyle(fontSize: 13, color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ── Description ──
            Text(
              p.description,
              style: const TextStyle(fontSize: 15, height: 1.75),
            ),
            const SizedBox(height: 28),

            // ── Tech Chips ──
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: p.chips
                  .map(
                    (chip) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: accent.withValues(alpha: 0.10),
                        border: Border.all(
                          color: accent.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Text(
                        chip,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: accent),
                      ),
                    ),
                  )
                  .toList(),
            ),

            // ── Link Button ──
            if (p.link != null) ...[
              const SizedBox(height: 28),
              GestureDetector(
                onTap: () async {
                  final uri = Uri.parse(p.link!);
                  if (await canLaunchUrl(uri)) launchUrl(uri);
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.open_in_new_rounded, size: 14, color: accent),
                      const SizedBox(width: 6),
                      Text(
                        p.linkLabel!,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: accent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/* =========================================================
   GLASS CARD
========================================================= */

class GlassCard extends StatefulWidget {
  final Widget child;

  const GlassCard({super.key, required this.child});

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(alpha:
                hovered ? AppColors.glassBorderHover : AppColors.glassBorder),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha:AppColors.glassDarkShadow)
                  : Colors.black.withValues(alpha:AppColors.glassLightShadow),
              blurRadius: hovered ? 40 : 20,
              offset: const Offset(0, 10),
            )
          ],
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.white.withValues(alpha:0.08), Colors.white.withValues(alpha:0.03)]
                : [Colors.white.withValues(alpha:0.35), Colors.white.withValues(alpha:0.15)],
          ),
        ),
        child: widget.child,
      ),
    );
  }
}

/* =========================================================
   REVEAL ON SCROLL
========================================================= */

class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final Duration delay;

  const RevealOnScroll({
    super.key,
    required this.child,
    required this.scrollController,
    this.delay = Duration.zero,
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fade = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    ));

    // Check immediately (for sections already in view at load time)
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
    widget.scrollController.addListener(_check);
  }

  @override
  void dispose() {
    _animController.dispose();
    widget.scrollController.removeListener(_check);
    super.dispose();
  }

  void _check() {
    if (_revealed || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;

    final viewportHeight =
        MediaQuery.of(context).size.height;
    final pos = box.localToGlobal(Offset.zero);

    // Trigger when top of widget appears within the viewport
    if (pos.dy < viewportHeight * 0.92) {
      _revealed = true;
      widget.scrollController.removeListener(_check);
      Future.delayed(widget.delay, () {
        if (mounted) _animController.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}

/* =========================================================
   BACKGROUND BLOBS
========================================================= */

class BackgroundBlobs extends StatelessWidget {
  final AnimationController controller;
  final Offset mouseOffset;

  const BackgroundBlobs({
    super.key,
    required this.controller,
    required this.mouseOffset,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final t = controller.value * 2 * pi;
        return Stack(
          children: [
            // Blob 1 — large green-teal, top-left
            _blob(
              t: t, x: -360, y: -260, index: 0,
              size: 680,
              colorA: AppColors.blob1a,
              colorB: AppColors.blob1b,
            ),
            // Blob 2 — medium blue-slate, right-center
            _blob(
              t: t, x: 500, y: 20, index: 1,
              size: 560,
              colorA: AppColors.blob2a,
              colorB: AppColors.blob2b,
            ),
            // Blob 3 — smaller rose-grey, bottom-center
            _blob(
              t: t, x: 160, y: 620, index: 2,
              size: 480,
              colorA: AppColors.blob3a,
              colorB: AppColors.blob3b,
            ),
          ],
        );
      },
    );
  }

  Widget _blob({
    required double t,
    required double x,
    required double y,
    required int index,
    required double size,
    required Color colorA,
    required Color colorB,
  }) {
    final dx = sin(t + index * 1.8) * 55;
    final dy = cos(t + index * 1.8) * 55;

    return Positioned(
      left: x + dx + mouseOffset.dx * 80,
      top: y + dy + mouseOffset.dy * 80,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [colorA, colorB],
            stops: const [0.0, 1.0],
          ),
        ),
      ),
    );
  }
}

/* =========================================================
   GRADIENT TEXT
========================================================= */

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final List<Color> colors;

  const GradientText(
    this.text, {
    super.key,
    required this.style,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          LinearGradient(colors: colors).createShader(bounds),
      child: Text(text, style: style.copyWith(color: Colors.white)),
    );
  }
}

/* =========================================================
   THEME SWITCH
========================================================= */

class AnimatedThemeSwitch extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onChanged;

  const AnimatedThemeSwitch({
    super.key,
    required this.isDark,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final accent1 =
        isDark ? AppColors.darkAccent1 : AppColors.lightAccent1;
    final accent2 =
        isDark ? AppColors.darkAccent2 : AppColors.lightAccent2;

    return GestureDetector(
      onTap: () => onChanged(!isDark),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: 70,
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(colors: [accent1, accent2]),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 400),
          alignment:
              isDark ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
