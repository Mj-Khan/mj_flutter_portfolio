class SkillCategory {
  final String name;
  final List<String> skills;

  const SkillCategory({required this.name, required this.skills});

  /// Parses one entry from skills.json `categories[]`.
  /// Each skill object has at minimum a `name` field; `years_used` and
  /// `proficiency` are intentionally ignored at this layer — they can be
  /// surfaced in a future detail view without changing this model.
  factory SkillCategory.fromJson(Map<String, dynamic> json) {
    return SkillCategory(
      name: json['name'] as String,
      skills: (json['skills'] as List<dynamic>)
          .map((s) => (s as Map<String, dynamic>)['name'] as String)
          .toList(),
    );
  }
}
