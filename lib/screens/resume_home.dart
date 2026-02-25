import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/animations.dart';
import '../widgets/left_rail.dart';
import '../widgets/mobile_top_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/expertise_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/background_blobs.dart'; // Which is actually now RetroBackground
import '../widgets/crt_effect.dart';

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

class _ResumeHomeState extends State<ResumeHome> with TickerProviderStateMixin {
  late AnimationController _blobController;
  late AnimationController _entranceController;

  // Entrance animations
  late Animation<double> _railFade;
  late Animation<Offset> _railSlide;
  late Animation<double> _contentFade;
  late Animation<Offset> _contentSlide;

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
      ('Contact', _contactKey),
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
    _blobController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _railFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    );
    _railSlide = Tween<Offset>(begin: const Offset(-0.04, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
          ),
        );
    _contentFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.15, 1.0, curve: Curves.easeOut),
    );
    _contentSlide =
        Tween<Offset>(begin: const Offset(0, 0.03), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: const Interval(0.15, 1.0, curve: Curves.easeOut),
          ),
        );

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
    final accent1 = widget.isDark
        ? AppColors.darkAccent1
        : AppColors.lightAccent1;
    final accent2 = widget.isDark
        ? AppColors.darkAccent2
        : AppColors.lightAccent2;

    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1000;

    return CrtEffect(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.isDark
                  ? AppColors.retroBorderDark
                  : AppColors.retroBorderLight,
              width: 8, // Chonky global frame
            ),
          ),
          child: Stack(
            children: [
              RetroBackground(controller: _blobController),
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
                                contactKey: _contactKey,
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
                                      child: SizedBox(
                                        key: _heroKey,
                                        child: HeroSection(
                                          accent1: accent1,
                                          accent2: accent2,
                                          isDesktop: isDesktop,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 120),
                                    RevealOnScroll(
                                      scrollController: _scrollController,
                                      delay: const Duration(milliseconds: 100),
                                      child: SizedBox(
                                        key: _expertiseKey,
                                        child: ExpertiseSection(
                                          isDesktop: isDesktop,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 120),
                                    RevealOnScroll(
                                      scrollController: _scrollController,
                                      delay: const Duration(milliseconds: 200),
                                      child: SizedBox(
                                        key: _experienceKey,
                                        child: const ExperienceSection(),
                                      ),
                                    ),
                                    const SizedBox(height: 120),
                                    RevealOnScroll(
                                      scrollController: _scrollController,
                                      delay: const Duration(milliseconds: 300),
                                      child: SizedBox(
                                        key: _projectsKey,
                                        child: ProjectsSection(
                                          isDesktop: isDesktop,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 120),
                                    RevealOnScroll(
                                      scrollController: _scrollController,
                                      delay: const Duration(milliseconds: 200),
                                      child: SizedBox(
                                        key: _contactKey,
                                        child: ContactSection(
                                          accent1: accent1,
                                          accent2: accent2,
                                        ),
                                      ),
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
      ),
    );
  }
}
