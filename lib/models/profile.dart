class Profile {
  final String fullName;
  final String tagline;
  final String shortSummary;
  final String longSummary;
  final String location;
  final String availableFor;
  final String email;
  final String phone;
  final String linkedInUrl;
  final String githubUrl;
  final String? portfolioUrl;

  const Profile({
    required this.fullName,
    required this.tagline,
    required this.shortSummary,
    required this.longSummary,
    required this.location,
    required this.availableFor,
    required this.email,
    required this.phone,
    required this.linkedInUrl,
    required this.githubUrl,
    this.portfolioUrl,
  });

  // ── Derived fields ────────────────────────────────────────────────────────

  /// "Abdul Mujeeb" — first two space-separated tokens.
  String get displayName {
    final parts = fullName.trim().split(' ');
    return parts.length >= 2 ? '${parts[0]} ${parts[1]}' : fullName;
  }

  /// "MK" — derived from the last two initials of the full name.
  /// "Abdul Mujeeb Khan" → M (Mujeeb) + K (Khan)
  String get initials {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.length >= 3) return '${parts[1][0]}${parts[2][0]}';
    if (parts.length == 2) return '${parts[0][0]}${parts[1][0]}';
    return parts[0][0];
  }

  /// "Senior Flutter Developer" — text before the first "·" in tagline.
  String get role {
    final idx = tagline.indexOf('·');
    return idx != -1 ? tagline.substring(0, idx).trim() : tagline;
  }

  /// "mailto:mjkhan7124@gmail.com"
  String get emailUrl => 'mailto:$email';

  /// "github.com/Mj-Khan"
  String get githubLabel => githubUrl.replaceFirst(RegExp(r'https?://'), '');

  /// "linkedin.com/in/abdul-mujeeb-khan"
  String get linkedInLabel => linkedInUrl.replaceFirst(RegExp(r'https?://'), '');

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      fullName: json['name'] as String,
      tagline: json['tagline'] as String,
      shortSummary: json['short_summary'] as String,
      longSummary: json['long_summary'] as String,
      location: json['location'] as String,
      availableFor: json['available_for'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      linkedInUrl: json['linkedin_url'] as String,
      githubUrl: json['github_url'] as String,
      portfolioUrl: json['portfolio_url'] as String?,
    );
  }
}
