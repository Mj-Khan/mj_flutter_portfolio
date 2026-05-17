class ExperienceRole {
  final String id;
  final String company;
  final String title;
  final String location;
  final String? workMode;
  final String startDate;
  final String endDate; // "Present" or "YYYY-MM"
  final String contextLine;
  final List<String> bullets;

  const ExperienceRole({
    required this.id,
    required this.company,
    required this.title,
    required this.location,
    this.workMode,
    required this.startDate,
    required this.endDate,
    required this.contextLine,
    required this.bullets,
  });

  bool get isCurrent => endDate == 'Present';

  factory ExperienceRole.fromJson(Map<String, dynamic> json) {
    return ExperienceRole(
      id: json['id'] as String,
      company: json['company'] as String,
      title: json['title'] as String,
      location: json['location'] as String,
      workMode: json['work_mode'] as String?,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      contextLine: json['context_line'] as String,
      bullets: (json['bullets'] as List<dynamic>).cast<String>(),
    );
  }
}
