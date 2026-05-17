class ProjectLink {
  final String type; // "play_store", "app_store", "website", etc.
  final String url;

  const ProjectLink({required this.type, required this.url});

  factory ProjectLink.fromJson(Map<String, dynamic> json) {
    return ProjectLink(
      type: json['type'] as String,
      url: json['url'] as String,
    );
  }
}

class StoreMetadata {
  final double? rating;
  final int? reviewCount;
  final String downloadsLabel;
  final String? lastUpdated;
  final String developer;

  const StoreMetadata({
    this.rating,
    this.reviewCount,
    required this.downloadsLabel,
    this.lastUpdated,
    required this.developer,
  });

  factory StoreMetadata.fromJson(Map<String, dynamic> json) {
    return StoreMetadata(
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: json['review_count'] as int?,
      downloadsLabel: json['downloads_label'] as String,
      lastUpdated: json['last_updated'] as String?,
      developer: json['developer'] as String,
    );
  }
}

class Project {
  final String id;
  final String name;
  final String? tagline;
  final bool featured;
  final String company;
  final String? client;
  final String? startDate; // null for status: "details_pending"
  final String? endDate;   // "Present", "YYYY-MM", or null
  final String status;     // "live" | "internal" | "regional_only" | "details_pending"
  final String? shortDescription;
  final String? longDescription;
  final String? problemSolved;
  final String? roleSummary;
  final List<String> contributionBullets;
  final List<String> techStack;
  final List<ProjectLink> links;
  final StoreMetadata? storeMetadata;
  final List<String> tags;

  const Project({
    required this.id,
    required this.name,
    this.tagline,
    required this.featured,
    required this.company,
    this.client,
    this.startDate,
    this.endDate,
    required this.status,
    this.shortDescription,
    this.longDescription,
    this.problemSolved,
    this.roleSummary,
    required this.contributionBullets,
    required this.techStack,
    required this.links,
    this.storeMetadata,
    required this.tags,
  });

  bool get isDetailsPending => status == 'details_pending';
  bool get isLive => status == 'live';
  ProjectLink? get primaryLink => links.isNotEmpty ? links.first : null;

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String,
      name: json['name'] as String,
      tagline: json['tagline'] as String?,
      featured: json['featured'] as bool,
      company: json['company'] as String,
      client: json['client'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      status: json['status'] as String,
      shortDescription: json['short_description'] as String?,
      longDescription: json['long_description'] as String?,
      problemSolved: json['problem_solved'] as String?,
      roleSummary: json['role_summary'] as String?,
      contributionBullets:
          (json['contribution_bullets'] as List<dynamic>).cast<String>(),
      techStack: (json['tech_stack'] as List<dynamic>).cast<String>(),
      links: (json['links'] as List<dynamic>)
          .map((l) => ProjectLink.fromJson(l as Map<String, dynamic>))
          .toList(),
      storeMetadata: json['store_metadata'] != null
          ? StoreMetadata.fromJson(
              json['store_metadata'] as Map<String, dynamic>)
          : null,
      tags: (json['tags'] as List<dynamic>).cast<String>(),
    );
  }
}
