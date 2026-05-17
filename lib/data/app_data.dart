import 'package:flutter/material.dart';

import '../data/content_repository.dart';
import '../data/site_config_repository.dart';

/// InheritedWidget that makes [ContentRepository] and [SiteConfigRepository]
/// available to the entire widget tree without prop drilling.
///
/// Inserted above [MaterialApp] in main.dart after both repositories are
/// fully loaded. Widgets read data via [AppData.of(context)].
class AppData extends InheritedWidget {
  final ContentRepository content;
  final SiteConfigRepository siteConfig;

  const AppData({
    super.key,
    required this.content,
    required this.siteConfig,
    required super.child,
  });

  /// Returns the nearest [AppData] ancestor.
  /// Throws if not found — this should never happen at runtime because
  /// [AppData] is always inserted above [MaterialApp].
  static AppData of(BuildContext context) {
    final data = context.dependOnInheritedWidgetOfExactType<AppData>();
    assert(data != null, 'No AppData found in context. '
        'Make sure AppData is inserted above MaterialApp in main.dart.');
    return data!;
  }

  /// [AppData] never needs to trigger rebuilds — the repositories are
  /// immutable after load. Return false always.
  @override
  bool updateShouldNotify(AppData oldWidget) => false;
}
