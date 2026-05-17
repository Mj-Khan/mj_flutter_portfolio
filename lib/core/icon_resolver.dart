import 'package:flutter/material.dart';

/// Maps icon name strings (stored in site_config.json) to Flutter [IconData].
///
/// If a name is not found, returns [Icons.circle_outlined] and emits a
/// [debugPrint] warning so silent missing icons are visible during development.
///
/// Add new entries here whenever a new icon string is added to site_config.json.
IconData iconFromName(String name) {
  const map = <String, IconData>{
    // ── Focus area icons ──────────────────────────────────────────────────
    'speed_rounded': Icons.speed_rounded,
    'account_tree_outlined': Icons.account_tree_outlined,
    'cloud_outlined': Icons.cloud_outlined,
    'devices_outlined': Icons.devices_outlined,

    // ── Social / contact icons ────────────────────────────────────────────
    'email_outlined': Icons.email_outlined,
    'code_rounded': Icons.code_rounded,
    'work_outline_rounded': Icons.work_outline_rounded,

    // ── Project icons ─────────────────────────────────────────────────────
    'auto_awesome_outlined': Icons.auto_awesome,         // svarupa
    'bar_chart_outlined': Icons.bar_chart,               // trailer-analytics
    'camera_alt_outlined': Icons.camera_alt_outlined,   // vhub-inspection
    'sim_card_outlined': Icons.sim_card_outlined,        // zetsim
    'electric_car_outlined': Icons.electric_car_outlined, // split-ev
    'construction_outlined': Icons.construction,         // super-construct
    'mosque_outlined': Icons.account_balance_outlined,   // falek-tayyeb
    'school_outlined': Icons.school_outlined,            // inspire-aba
    'directions_walk_outlined': Icons.directions_walk,   // feet-first
    'touch_app_outlined': Icons.touch_app_outlined,      // magic-shake

    // ── Skill category icons ──────────────────────────────────────────────
    'map_outlined': Icons.map_outlined,
    'build_outlined': Icons.build_outlined,
  };

  final icon = map[name];
  if (icon == null) {
    debugPrint(
      '[IconResolver] Warning: unknown icon name "$name". '
      'Add it to lib/core/icon_resolver.dart. Falling back to circle_outlined.',
    );
    return Icons.circle_outlined;
  }
  return icon;
}
