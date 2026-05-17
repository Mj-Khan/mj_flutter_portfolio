import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/education.dart';
import '../models/experience.dart';
import '../models/profile.dart';
import '../models/project.dart';
import '../models/skill.dart';

/// Loads and exposes all 5 career-content JSON files.
///
/// Call [ContentRepository.load()] once at app start (before [runApp]).
/// The result is then passed into [AppData] and accessed via
/// [AppData.of(context).content] — no widget ever re-parses JSON.
class ContentRepository {
  final Profile profile;
  final List<SkillCategory> skills;
  final List<ExperienceRole> experience;
  final List<Education> education;

  /// All projects sorted: "Present" end_date first, then latest date desc.
  /// For ties on end_date, featured projects come before non-featured.
  final List<Project> _allProjects;

  const ContentRepository._({
    required this.profile,
    required this.skills,
    required this.experience,
    required this.education,
    required List<Project> allProjects,
  }) : _allProjects = allProjects;

  // ── Public accessors ───────────────────────────────────────────────────

  /// Every project in sort order.
  List<Project> get allProjects => _allProjects;

  /// Only projects with `featured: true`, in the same sort order.
  List<Project> get featuredProjects =>
      _allProjects.where((p) => p.featured).toList();

  // ── Factory ───────────────────────────────────────────────────────────

  static Future<ContentRepository> load() async {
    final results = await Future.wait([
      rootBundle.loadString('assets/content/profile.json'),
      rootBundle.loadString('assets/content/skills.json'),
      rootBundle.loadString('assets/content/experience.json'),
      rootBundle.loadString('assets/content/projects.json'),
      rootBundle.loadString('assets/content/education.json'),
    ]);

    final profile =
        Profile.fromJson(jsonDecode(results[0]) as Map<String, dynamic>);

    final skillsJson =
        (jsonDecode(results[1]) as Map<String, dynamic>)['categories']
            as List<dynamic>;
    final skills =
        skillsJson.map((c) => SkillCategory.fromJson(c as Map<String, dynamic>)).toList();

    final experienceJson =
        (jsonDecode(results[2]) as Map<String, dynamic>)['roles']
            as List<dynamic>;
    final experience = experienceJson
        .map((r) => ExperienceRole.fromJson(r as Map<String, dynamic>))
        .toList();

    final projectsJson =
        (jsonDecode(results[3]) as Map<String, dynamic>)['projects']
            as List<dynamic>;
    final rawProjects = projectsJson
        .map((p) => Project.fromJson(p as Map<String, dynamic>))
        .toList();

    final educationJson =
        (jsonDecode(results[4]) as Map<String, dynamic>)['qualifications']
            as List<dynamic>;
    final education = educationJson
        .map((e) => Education.fromJson(e as Map<String, dynamic>))
        .toList();

    final sorted = _sortProjects(rawProjects);

    return ContentRepository._(
      profile: profile,
      skills: skills,
      experience: experience,
      education: education,
      allProjects: sorted,
    );
  }

  // ── Sort logic ────────────────────────────────────────────────────────

  /// Sort projects by end_date descending.
  /// "Present" → sentinel DateTime(9999) so it always sorts first.
  /// For equal end_dates, featured projects come before non-featured.
  static List<Project> _sortProjects(List<Project> projects) {
    final copy = List<Project>.from(projects);
    copy.sort((a, b) {
      final dateA = _toSortableDate(a.endDate);
      final dateB = _toSortableDate(b.endDate);
      final cmp = dateB.compareTo(dateA); // descending
      if (cmp != 0) return cmp;
      // Same date: featured first
      if (a.featured && !b.featured) return -1;
      if (!a.featured && b.featured) return 1;
      return 0;
    });
    return copy;
  }

  /// Maps an end_date string to a [DateTime] for comparison.
  /// - "Present"  → DateTime(9999)   (sentinel — always latest)
  /// - "YYYY-MM"  → DateTime(year, month)
  /// - null       → DateTime(0)      (status: details_pending — sort last)
  static DateTime _toSortableDate(String? raw) {
    if (raw == null) return DateTime(0);
    if (raw == 'Present') return DateTime(9999);
    final parts = raw.split('-');
    if (parts.length == 2) {
      final year = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      if (year != null && month != null) return DateTime(year, month);
    }
    return DateTime(0);
  }
}
