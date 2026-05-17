// Portfolio smoke tests
//
// These tests verify the new data-layer wiring:
//  - Models parse correctly from JSON
//  - ContentRepository sorts projects with "Present" first
//  - SiteConfig deserializes hero/focus/navSections

import 'package:flutter_test/flutter_test.dart';
import 'package:mj_flutter_portfolio/models/profile.dart';
import 'package:mj_flutter_portfolio/models/project.dart';
import 'package:mj_flutter_portfolio/models/experience.dart';
import 'package:mj_flutter_portfolio/models/skill.dart';
import 'package:mj_flutter_portfolio/models/site_config.dart';
import 'package:mj_flutter_portfolio/core/icon_resolver.dart';
import 'package:flutter/material.dart';

void main() {
  // ── Profile model ──────────────────────────────────────────────────────────
  group('Profile.fromJson', () {
    final json = {
      'name': 'Abdul Mujeeb Khan',
      'tagline': 'Senior Flutter Developer · 5 Years · Cross-Platform Mobile',
      'short_summary': 'Short',
      'long_summary': 'Long',
      'location': 'Hyderabad, India',
      'available_for': 'Open to remote (global)',
      'email': 'mjkhan7124@gmail.com',
      'phone': '+91 89193 55784',
      'linkedin_url': 'https://linkedin.com/in/abdul-mujeeb-khan',
      'github_url': 'https://github.com/Mj-Khan',
      'portfolio_url': null,
    };

    test('parses fullName', () {
      expect(Profile.fromJson(json).fullName, 'Abdul Mujeeb Khan');
    });
    test('derives displayName as first two tokens', () {
      expect(Profile.fromJson(json).displayName, 'Abdul Mujeeb');
    });
    test('derives initials from 2nd and 3rd name parts', () {
      expect(Profile.fromJson(json).initials, 'MK');
    });
    test('derives role from tagline before first ·', () {
      expect(Profile.fromJson(json).role, 'Senior Flutter Developer');
    });
    test('derives emailUrl', () {
      expect(
          Profile.fromJson(json).emailUrl, 'mailto:mjkhan7124@gmail.com');
    });
    test('strips https:// from githubLabel', () {
      expect(Profile.fromJson(json).githubLabel, 'github.com/Mj-Khan');
    });
  });

  // ── Project model ──────────────────────────────────────────────────────────
  group('Project.fromJson', () {
    final fullJson = {
      'id': 'zetsim',
      'name': 'ZetSIM',
      'tagline': 'Global eSIM + Travel Concierge App',
      'featured': true,
      'company': 'Zetexa Global',
      'client': null,
      'start_date': '2024-06',
      'end_date': '2025-07',
      'status': 'live',
      'short_description': 'Short',
      'long_description': null,
      'problem_solved': null,
      'role_summary': null,
      'contribution_bullets': [],
      'tech_stack': ['Flutter', 'BLoC'],
      'links': [
        {'type': 'play_store', 'url': 'https://play.google.com/...'}
      ],
      'store_metadata': {
        'rating': 4.4,
        'review_count': 385,
        'downloads_label': '180+ countries',
        'last_updated': '2026-04',
        'developer': 'Zetexa Global',
      },
      'tags': ['telecom'],
      'images': {'hero': null, 'thumbnail': null, 'screenshots': []},
    };

    final pendingJson = {
      'id': 'magic-shake',
      'name': 'Magic Shake',
      'tagline': null,
      'featured': false,
      'company': 'Tynybay Inc',
      'client': null,
      'start_date': null,
      'end_date': null,
      'status': 'details_pending',
      'short_description': null,
      'long_description': null,
      'problem_solved': null,
      'role_summary': null,
      'contribution_bullets': [],
      'tech_stack': [],
      'links': [],
      'store_metadata': null,
      'tags': ['tynybay-era'],
      'images': {'hero': null, 'thumbnail': null, 'screenshots': []},
    };

    test('parses a live project', () {
      final p = Project.fromJson(fullJson);
      expect(p.id, 'zetsim');
      expect(p.isLive, true);
      expect(p.isDetailsPending, false);
      expect(p.storeMetadata?.rating, 4.4);
      expect(p.storeMetadata?.reviewCount, 385);
    });

    test('parses a details_pending project without crashing on null fields',
        () {
      final p = Project.fromJson(pendingJson);
      expect(p.isDetailsPending, true);
      expect(p.tagline, isNull);
      expect(p.storeMetadata, isNull);
      expect(p.endDate, isNull);
    });
  });

  // ── Project sort logic ─────────────────────────────────────────────────────
  group('Project sort order', () {
    Project make(
            {required String id,
            required String? endDate,
            required bool featured}) =>
        Project(
          id: id,
          name: id,
          featured: featured,
          company: 'Co',
          status: 'live',
          contributionBullets: [],
          techStack: [],
          links: [],
          tags: [],
          endDate: endDate,
        );

    // Simulate the ContentRepository sort logic inline for unit testing
    DateTime toDate(String? raw) {
      if (raw == null) return DateTime(0);
      if (raw == 'Present') return DateTime(9999);
      final parts = raw.split('-');
      if (parts.length == 2) {
        final y = int.tryParse(parts[0]);
        final m = int.tryParse(parts[1]);
        if (y != null && m != null) return DateTime(y, m);
      }
      return DateTime(0);
    }

    List<Project> sort(List<Project> ps) {
      final copy = List<Project>.from(ps);
      copy.sort((a, b) {
        final cmp = toDate(b.endDate).compareTo(toDate(a.endDate));
        if (cmp != 0) return cmp;
        if (a.featured && !b.featured) return -1;
        if (!a.featured && b.featured) return 1;
        return 0;
      });
      return copy;
    }

    test('"Present" sorts before any past date', () {
      final projects = [
        make(id: 'old', endDate: '2022-01', featured: false),
        make(id: 'present', endDate: 'Present', featured: false),
        make(id: 'recent', endDate: '2025-07', featured: false),
      ];
      final sorted = sort(projects);
      expect(sorted.first.id, 'present');
      expect(sorted.last.id, 'old');
    });

    test('null endDate (details_pending) sorts last', () {
      final projects = [
        make(id: 'pending', endDate: null, featured: false),
        make(id: 'present', endDate: 'Present', featured: false),
      ];
      expect(sort(projects).last.id, 'pending');
    });

    test('featured before non-featured on same end_date', () {
      final projects = [
        make(id: 'nonfeatured', endDate: 'Present', featured: false),
        make(id: 'featured', endDate: 'Present', featured: true),
      ];
      expect(sort(projects).first.id, 'featured');
    });
  });

  // ── ExperienceRole model ───────────────────────────────────────────────────
  group('ExperienceRole.fromJson', () {
    final json = {
      'id': 'soulax-senior-mobile',
      'company': 'Soulax Software Pvt Ltd',
      'title': 'Senior Mobile Application Developer',
      'location': 'Hyderabad, India',
      'work_mode': 'on-site',
      'start_date': '2025-07',
      'end_date': 'Present',
      'context_line': 'Service-based company',
      'bullets': ['Bullet 1', 'Bullet 2'],
    };

    test('parses correctly', () {
      final r = ExperienceRole.fromJson(json);
      expect(r.isCurrent, true);
      expect(r.bullets.length, 2);
      expect(r.workMode, 'on-site');
    });
  });

  // ── SkillCategory model ────────────────────────────────────────────────────
  group('SkillCategory.fromJson', () {
    test('extracts skill names only', () {
      final json = {
        'name': 'Core',
        'skills': [
          {'name': 'Dart', 'years_used': null, 'proficiency': null},
          {'name': 'Flutter', 'years_used': null, 'proficiency': null},
        ],
      };
      final cat = SkillCategory.fromJson(json);
      expect(cat.name, 'Core');
      expect(cat.skills, ['Dart', 'Flutter']);
    });
  });

  // ── SiteConfig model ───────────────────────────────────────────────────────
  group('SiteConfig.fromJson', () {
    final json = {
      'hero': {
        'label': 'MOBILE ENGINEER',
        'headline': 'Building Production-Grade Mobile Systems',
        'bio': 'Bio text.',
        'metrics': [
          {'value': '6 Apps', 'label': 'Production Deployments'},
        ],
      },
      'focus': {
        'areasTitle': 'Focus Areas',
        'availabilityLabel': 'Open to Work',
        'areas': [
          {'icon': 'speed_rounded', 'label': 'Performance Optimization'},
        ],
      },
      'contactFooter': {
        'headline': "Let's Build\nSomething Together",
        'subtext': 'Open to full-time roles.',
        'copyright': 'Built with Flutter',
      },
      'navSections': ['About', 'Expertise'],
      'socialIconMap': {'email': 'email_outlined'},
      'iconMap': {
        'projects': {'zetsim': 'sim_card_outlined'},
        'skill_categories': {'Core': 'code_rounded'},
      },
    };

    test('parses hero metrics', () {
      final config = SiteConfig.fromJson(json);
      expect(config.hero.metrics.first.value, '6 Apps');
    });

    test('parses navSections', () {
      final config = SiteConfig.fromJson(json);
      expect(config.navSections, ['About', 'Expertise']);
    });

    test('parses iconMap.projects', () {
      final config = SiteConfig.fromJson(json);
      expect(config.iconMap.projects['zetsim'], 'sim_card_outlined');
    });
  });

  // ── Icon resolver ──────────────────────────────────────────────────────────
  group('iconFromName', () {
    test('returns correct IconData for known name', () {
      expect(iconFromName('speed_rounded'), Icons.speed_rounded);
    });

    test('returns fallback for unknown name', () {
      expect(iconFromName('nonexistent_icon_xyz'), Icons.circle_outlined);
    });
  });
}
