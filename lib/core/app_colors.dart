import 'package:flutter/material.dart';

class AppColors {
  // ── Backgrounds ──────────────────────────────────────────
  static const lightScaffold = Color(0xFFF3F7F4); // warm white-green
  static const darkScaffold = Color(0xFF0C1010); // deep forest black

  // ── Accents ───────────────────────────────────────────────
  static const lightAccent1 = Color(0xFF22C55E); // vibrant green
  static const lightAccent2 = Color(0xFF0EA5E9); // sky blue

  static const darkAccent1 = Color(0xFF4ADE80); // bright lime-green
  static const darkAccent2 = Color(0xFF38BDF8); // lighter sky blue

  // ── Background blobs ──────────────────────────────────────
  static const blob1a = Color(0x2822C55E); // green blob
  static const blob1b = Color(0x1022C55E);
  static const blob2a = Color(0x280EA5E9); // sky blob
  static const blob2b = Color(0x100EA5E9);
  static const blob3a = Color(0x1A4ADE80); // lime accent blob
  static const blob3b = Color(0x0A4ADE80);

  // New scattered blobs (Right side emphasis)
  static const blob4a = Color(0x1A0EA5E9); // light blue
  static const blob4b = Color(0x050EA5E9);
  static const blob5a = Color(0x1522C55E); // pale green
  static const blob5b = Color(0x0522C55E);
  static const blob6a = Color(0x1538BDF8); // sky accent
  static const blob6b = Color(0x0538BDF8);
  static const blob7a = Color(0x104ADE80); // faint lime
  static const blob7b = Color(0x024ADE80);

  // Legacy blob aliases
  static const blobGradient1 = blob1a;
  static const blobGradient2 = blob2a;

  // ── Glass card ────────────────────────────────────────────
  static const glassBorder = 0.15;
  static const glassBorderHover = 0.30;
  static const glassLightShadow = 0.12;
  static const glassDarkShadow = 0.55;

  // ── Semantic text colors ──────────────────────────────────
  static const textMuted = Color(0xFF9E9E9E); // ~grey.shade500
  static const textSub = Color(0xFF757575); // ~grey.shade600
  static const drawerHandle = Color(0xFFBDBDBD); // ~grey.shade400

  // ── Status ────────────────────────────────────────────────
  static const available = Color(0xFF22C55E); // open to work green

  // ── Utility ───────────────────────────────────────────────
  static const white70 = Color(0xB3FFFFFF);
  static const black87 = Color(0xDD000000);
}
