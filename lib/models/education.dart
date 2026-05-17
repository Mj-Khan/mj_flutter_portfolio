class Education {
  final String id;
  final String degree;
  final String institution;
  final String? location;
  final String startDate;
  final String? endDate; // null when status == "in_progress"
  final String status;   // "in_progress" | "completed"

  const Education({
    required this.id,
    required this.degree,
    required this.institution,
    this.location,
    required this.startDate,
    this.endDate,
    required this.status,
  });

  bool get isInProgress => status == 'in_progress';

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'] as String,
      degree: json['degree'] as String,
      institution: json['institution'] as String,
      location: json['location'] as String?,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String?,
      status: json['status'] as String,
    );
  }
}
