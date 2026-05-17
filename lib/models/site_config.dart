// ── Leaf value types ──────────────────────────────────────────────────────

class MetricItem {
  final String value;
  final String label;

  const MetricItem({required this.value, required this.label});

  factory MetricItem.fromJson(Map<String, dynamic> json) =>
      MetricItem(value: json['value'] as String, label: json['label'] as String);
}

class FocusAreaConfig {
  final String icon; // icon name resolved via iconFromName()
  final String label;

  const FocusAreaConfig({required this.icon, required this.label});

  factory FocusAreaConfig.fromJson(Map<String, dynamic> json) =>
      FocusAreaConfig(icon: json['icon'] as String, label: json['label'] as String);
}

// ── Section configs ───────────────────────────────────────────────────────

class HeroConfig {
  final String label;
  final String headline;
  final String bio;
  final List<MetricItem> metrics;

  const HeroConfig({
    required this.label,
    required this.headline,
    required this.bio,
    required this.metrics,
  });

  factory HeroConfig.fromJson(Map<String, dynamic> json) => HeroConfig(
        label: json['label'] as String,
        headline: json['headline'] as String,
        bio: json['bio'] as String,
        metrics: (json['metrics'] as List<dynamic>)
            .map((m) => MetricItem.fromJson(m as Map<String, dynamic>))
            .toList(),
      );
}

class FocusConfig {
  final String areasTitle;
  final String availabilityLabel;
  final List<FocusAreaConfig> areas;

  const FocusConfig({
    required this.areasTitle,
    required this.availabilityLabel,
    required this.areas,
  });

  factory FocusConfig.fromJson(Map<String, dynamic> json) => FocusConfig(
        areasTitle: json['areasTitle'] as String,
        availabilityLabel: json['availabilityLabel'] as String,
        areas: (json['areas'] as List<dynamic>)
            .map((a) => FocusAreaConfig.fromJson(a as Map<String, dynamic>))
            .toList(),
      );
}

class ContactFooterConfig {
  final String headline;
  final String subtext;
  final String copyright; // e.g. "Built with Flutter" — year + name prepended at runtime

  const ContactFooterConfig({
    required this.headline,
    required this.subtext,
    required this.copyright,
  });

  factory ContactFooterConfig.fromJson(Map<String, dynamic> json) =>
      ContactFooterConfig(
        headline: json['headline'] as String,
        subtext: json['subtext'] as String,
        copyright: json['copyright'] as String,
      );
}

class IconMapConfig {
  /// project id → icon name string, e.g. "split-ev" → "electric_car_outlined"
  final Map<String, String> projects;

  /// skill category name → icon name string, e.g. "Core" → "code_rounded"
  final Map<String, String> skillCategories;

  const IconMapConfig({required this.projects, required this.skillCategories});

  factory IconMapConfig.fromJson(Map<String, dynamic> json) => IconMapConfig(
        projects: Map<String, String>.from(json['projects'] as Map),
        skillCategories:
            Map<String, String>.from(json['skill_categories'] as Map),
      );
}

// ── Root config ───────────────────────────────────────────────────────────

class SiteConfig {
  final HeroConfig hero;
  final FocusConfig focus;
  final ContactFooterConfig contactFooter;
  final List<String> navSections;

  /// Maps social link key → icon name, e.g. "email" → "email_outlined"
  final Map<String, String> socialIconMap;

  final IconMapConfig iconMap;

  const SiteConfig({
    required this.hero,
    required this.focus,
    required this.contactFooter,
    required this.navSections,
    required this.socialIconMap,
    required this.iconMap,
  });

  factory SiteConfig.fromJson(Map<String, dynamic> json) => SiteConfig(
        hero: HeroConfig.fromJson(json['hero'] as Map<String, dynamic>),
        focus: FocusConfig.fromJson(json['focus'] as Map<String, dynamic>),
        contactFooter: ContactFooterConfig.fromJson(
            json['contactFooter'] as Map<String, dynamic>),
        navSections: (json['navSections'] as List<dynamic>).cast<String>(),
        socialIconMap:
            Map<String, String>.from(json['socialIconMap'] as Map),
        iconMap:
            IconMapConfig.fromJson(json['iconMap'] as Map<String, dynamic>),
      );
}
