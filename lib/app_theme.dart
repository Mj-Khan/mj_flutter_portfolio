import 'package:flutter/material.dart';

class AppColors {
  // Light Theme
  static const lightScaffold = Color(0xFFF4F5F7);
  static const lightAccent1 = Color(0xFF7D9484);
  static const lightAccent2 = Color(0xFF6F7C8C);

  // Dark Theme
  static const darkScaffold = Color(0xFF0E0F11);
  static const darkAccent1 = Color(0xFF8FAE9A);
  static const darkAccent2 = Color(0xFF8C98AD);

  // Neutral
  static const white = Colors.white;
  static const black = Colors.black;

  static const blobGradient1 = Color(0x337D9484);
  static const blobGradient2 = Color(0x336F7C8C);

  // ============================
  // GLASS SYSTEM
  // ============================

  // Light glass
  static const lightGlassFill = Color(0x33FFFFFF); // 20% white
  static const lightGlassBorder = Color(0x55FFFFFF); // 33% white

  // Dark glass
  static const darkGlassFill = Color(0x1AFFFFFF); // subtle white tint
  static const darkGlassBorder = Color(0x33FFFFFF);

  // ============================
  // GLASS OPACITY TOKENS
  // ============================

  static const glassLightGradientStart = 0.35;
  static const glassLightGradientEnd = 0.15;

  static const glassDarkGradientStart = 0.08;
  static const glassDarkGradientEnd = 0.03;

  static const glassBorder = 0.15;
  static const glassBorderHover = 0.30;

  static const glassLightShadow = 0.15;
  static const glassDarkShadow = 0.60;

  static const navbarBackground = 0.6;
  static const navbarBorder = 0.1;
}
