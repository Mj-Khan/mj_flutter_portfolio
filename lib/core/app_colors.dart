import 'package:flutter/material.dart';

class AppColors {
  // ── Backgrounds ──────────────────────────────────────────
  static const lightScaffold = Color(
    0xFFEBE5CE,
  ); // Soft retro paper / Gameboy beige
  static const darkScaffold = Color(
    0xFF1E1E24,
  ); // Muted dark slate, not pure black

  // ── Accents (Muted Retro / SNES / GameBoy Palette) ───────
  static const neoGreen = Color(
    0xFF4CAF50,
  ); // Softer, pastel green instead of neon
  static const neoMagenta = Color(0xFFE57373); // Soft salmon/coral pink
  static const neoCyan = Color(0xFF64B5F6); // Soft sky blue
  static const neoYellow = Color(0xFFFFD54F); // Muted retro gold

  // Kept for signature compatibility across app, mapped to retro
  static const lightAccent1 = Color(0xFF388E3C); // Muted dark green
  static const lightAccent2 = Color(0xFFD32F2F); // Muted dark red/coral

  static const darkAccent1 = neoGreen;
  static const darkAccent2 = neoMagenta;

  // ── Card & Container Styling ─────────────────────────────
  // Instead of pure black or pure neon green borders, we use dark shades
  static const retroBorderLight = Color(0xFF424242); // Dark grey chunky border
  static const retroBorderDark = Color(0xFF616161); // Medium grey chunky border

  static const retroBgLight = Color(0xFFF5F0E1); // Off-white for cards
  static const retroBgDark = Color(
    0xFF2D2D36,
  ); // Slighter lighter slate for cards

  // ── Semantic text colors ──────────────────────────────────
  static const textMuted = Color(0xFF8D8D8D);
  static const textSub = Color(0xFFA1A1A1);

  static const textMainLight = Color(0xFF2C2C2C); // Soft off-black
  static const textMainDark = Color(0xFFDCDCDC); // Soft off-white

  // ── Status ────────────────────────────────────────────────
  static const available = neonGreen; // open to work
  static const neonGreen = neoGreen; // alias

  // ── Utility ───────────────────────────────────────────────
  static const white70 = Color(0xB3FFFFFF);
  static const black87 = Color(0xDD000000);
}
