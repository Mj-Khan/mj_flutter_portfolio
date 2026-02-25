import 'package:flutter/material.dart';

// =============================================================
// DATA MODELS
// =============================================================

class ExpertiseItem {
  final String title;
  final String description;
  final String? proof;

  const ExpertiseItem(this.title, this.description, this.proof);
}

class ExperienceItem {
  final String year;
  final String company;
  final String role;
  final String description;

  const ExperienceItem({
    required this.year,
    required this.company,
    required this.role,
    required this.description,
  });
}

class SkillCategory {
  final IconData icon;
  final String name;
  final List<String> skills;

  const SkillCategory({
    required this.icon,
    required this.name,
    required this.skills,
  });
}


class ProjectData {
  final String title;
  final String tagline;
  final String description;
  final List<String> chips;
  final String? link;
  final String? linkLabel;
  final IconData icon;

  const ProjectData({
    required this.title,
    required this.tagline,
    required this.description,
    required this.chips,
    required this.link,
    required this.linkLabel,
    required this.icon,
  });
}

class MetricItem {
  final String value;
  final String label;

  const MetricItem(this.value, this.label);
}

class FocusArea {
  final IconData icon;
  final String label;

  const FocusArea(this.icon, this.label);
}

class SocialLink {
  final IconData icon;
  final String label;
  final String url;

  const SocialLink({
    required this.icon,
    required this.label,
    required this.url,
  });
}

// =============================================================
// PORTFOLIO CONTENT — edit here to update any portfolio copy
// =============================================================

class PortfolioContent {
  PortfolioContent._(); // prevent instantiation

  // ── Identity ──────────────────────────────────────────────
  static const String displayName = 'Abdul Mujeeb';
  static const String fullName = 'Abdul Mujeeb Khan';
  static const String initials = 'MK';
  static const String role = 'Mobile Engineer';

  // ── Contact / Socials ─────────────────────────────────────
  static const String email = 'mjkhan7124@gmail.com';
  static const String emailUrl = 'mailto:mjkhan7124@gmail.com';

  static const String githubUrl = 'https://github.com/Mj-Khan';
  static const String githubLabel = 'github.com/Mj-Khan';

  static const String linkedInUrl =
      'https://linkedin.com/in/abdul-mujeeb-khan';
  static const String linkedInLabel = 'linkedin.com/in/abdul-mujeeb-khan';

  static const String playStoreBaseUrl =
      'https://play.google.com/store/apps/details';

  // ── Hero ──────────────────────────────────────────────────
  static const String heroLabel = 'MOBILE ENGINEER';
  static const String heroHeadline =
      'Building Production-\nGrade Mobile Systems';
  static const String heroBio =
      'Flutter-focused engineer delivering scalable architectures, '
      'clean state management, and real-world deployments.';

  static const List<MetricItem> metrics = [
    MetricItem('5+ Apps', 'Production Deployments'),
    MetricItem('BLoC + DI', 'Scalable Architecture'),
    MetricItem('CI/CD', 'Automated Builds'),
  ];

  // ── Focus Areas ───────────────────────────────────────────
  static const List<FocusArea> focusAreas = [
    FocusArea(Icons.speed_rounded, 'Performance Optimization'),
    FocusArea(Icons.account_tree_outlined, 'State Management Systems'),
    FocusArea(Icons.cloud_outlined, 'API Integration & Services'),
    FocusArea(Icons.devices_outlined, 'Cross-Platform Architecture'),
  ];

  static const String focusAreasTitle = 'Focus Areas';
  static const String availabilityLabel = 'Open to Work';

  // ── Expertise / Skills ────────────────────────────────────
  static const String expertiseTitle = 'Skills & Expertise';

  static const List<SkillCategory> skillCategories = [
    SkillCategory(
      icon: Icons.code_rounded,
      name: 'Programming Languages',
      skills: ['Dart', 'Kotlin'],
    ),
    SkillCategory(
      icon: Icons.layers_outlined,
      name: 'Frameworks & State Management',
      skills: [
        'Flutter',
        'Jetpack Compose',
        'FlutterFlow',
        'BLoC',
        'GetX',
        'Riverpod',
      ],
    ),
    SkillCategory(
      icon: Icons.cloud_outlined,
      name: 'Backend & Integrations',
      skills: [
        'RESTful APIs',
        'Firebase',
        'GraphQL',
        'Stripe API',
        'Razorpay',
      ],
    ),
    SkillCategory(
      icon: Icons.merge_type_rounded,
      name: 'Version Control',
      skills: ['Git', 'GitHub', 'GitLab'],
    ),
    SkillCategory(
      icon: Icons.build_outlined,
      name: 'Development Tools',
      skills: [
        'Android Studio',
        'Xcode',
        'VS Code',
        'IntelliJ IDEA',
        'Postman',
        'Swagger',
        'Unity',
      ],
    ),
  ];

  // Keep the old expertiseItems for backward compatibility (unused in UI now)
  static const List<ExpertiseItem> expertiseItems = [];


  // ── Experience ────────────────────────────────────────────
  static const String experienceTitle = 'Experience';

  static const List<ExperienceItem> experienceItems = [
    ExperienceItem(
      year: '2023 – Present',
      company: 'ZETEXA GLOBAL',
      role: 'Member of Technical Staff – L2',
      description:
          'Optimized performance & refined UX for global eSIM platform.',
    ),
    ExperienceItem(
      year: '2021 – 2023',
      company: 'TYNYBAY Inc',
      role: 'Mobile Application Developer',
      description:
          'Delivered Flutter applications across SaaS, EV & LMS domains.',
    ),
  ];

  // ── Projects ──────────────────────────────────────────────
  static const String projectsTitle = 'Projects';

  static const List<ProjectData> projects = [
    ProjectData(
      title: 'ZetSim',
      tagline: 'eSIM for 180+ Countries',
      description:
          'Your travel companion for global connectivity. Buy, activate, and manage eSIM plans across 180+ countries — '
          'all without a physical SIM card. Features include real-time data usage tracking, activate/deactivate controls, '
          'a loyalty coins rewards system, and WhatsApp-ready data plans. Dual SIM support keeps your original number active.',
      chips: ['Flutter', 'Dart', 'REST APIs', 'Firebase'],
      link:
          'https://play.google.com/store/apps/details?id=com.zetexa.zet_b2c',
      linkLabel: 'Play Store',
      icon: Icons.sim_card_outlined,
    ),
    ProjectData(
      title: 'SplitEV',
      tagline: 'Smart EV Charging Cost Splitter',
      description:
          'A Flutter app that simplifies cost-sharing for electric vehicle charging sessions. '
          'Users can log charging stops, split costs fairly among multiple EV owners, and track spending history — '
          'built on Firebase for real-time sync and integrated with third-party charging network SDKs.',
      chips: ['Flutter', 'Dart', 'Firebase', '3rd-Party SDK'],
      link: null,
      linkLabel: null,
      icon: Icons.electric_car_outlined,
    ),
    ProjectData(
      title: 'Inspire ABA',
      tagline: 'LMS Portal for Students & Faculty',
      description:
          'A full-featured Learning Management System for higher education. Students can mark attendance, review '
          'attendance history, access lectures, and consume four study material formats: text, PDF, PPT, and video. '
          'Includes assignment submission and a college community feed where students and faculty share educational articles.',
      chips: ['Flutter', 'Dart', 'REST APIs'],
      link: null,
      linkLabel: null,
      icon: Icons.school_outlined,
    ),
  ];

  // ── Contact / Footer ──────────────────────────────────────
  static const String contactHeadline = "Let's Build\nSomething Together";
  static const String contactSubtext =
      'Open to full-time roles, freelance projects, and interesting collabs.';

  static String get copyrightLine =>
      '© ${DateTime.now().year} $fullName · Built with Flutter';

  // ── Social Links (used in LeftRail, MobileTopBar, Contact) ─
  static List<SocialLink> get socialLinks => [
        SocialLink(
          icon: Icons.email_outlined,
          label: email,
          url: emailUrl,
        ),
        SocialLink(
          icon: Icons.code_rounded,
          label: githubLabel,
          url: githubUrl,
        ),
        SocialLink(
          icon: Icons.work_outline_rounded,
          label: linkedInLabel,
          url: linkedInUrl,
        ),
      ];

  // ── Navigation section names ───────────────────────────────
  static const List<String> navSections = [
    'About',
    'Expertise',
    'Experience',
    'Projects',
    'Contact',
  ];
}
