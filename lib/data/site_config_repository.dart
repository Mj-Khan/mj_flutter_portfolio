import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/site_config.dart';

/// Loads and exposes the presentation config from assets/presentation/site_config.json.
///
/// Call [SiteConfigRepository.load()] once at app start (before [runApp]).
/// Accessed in widgets via [AppData.of(context).siteConfig].
class SiteConfigRepository {
  final SiteConfig config;

  const SiteConfigRepository._({required this.config});

  static Future<SiteConfigRepository> load() async {
    final raw =
        await rootBundle.loadString('assets/presentation/site_config.json');
    final config =
        SiteConfig.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    return SiteConfigRepository._(config: config);
  }
}
