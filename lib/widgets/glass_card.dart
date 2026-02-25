import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class GlassCard extends StatefulWidget {
  final Widget child;

  const GlassCard({super.key, required this.child});

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Classic JRPG styling
    final outerBorder = isDark ? Colors.white : Colors.black87;
    final innerBorder = isDark ? Colors.black : Colors.white;

    // SNES Final Fantasy style gradient for dark mode, solid pastel for light
    final boxGradient = isDark
        ? const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E3C72), // Retro deep blue
              Color(0xFF2A5298), // Lighter retro blue
            ],
          )
        : LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.retroBgLight, AppColors.retroBgLight],
          );

    // Hard retro shadow that shifts on hover for "pushed down" or "lifted" effect
    final retroShadowColor = isDark ? Colors.black : AppColors.retroBorderLight;

    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100), // Quick snap
        padding: const EdgeInsets.all(
          4,
        ), // Outer margin for the double border effect
        decoration: BoxDecoration(
          color: outerBorder, // Outer border color fills backing
          boxShadow: [
            BoxShadow(
              color: retroShadowColor,
              offset: hovered ? const Offset(8, 8) : const Offset(4, 4),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: innerBorder, // Inner border color fills this layer
            border: Border.all(
              color: innerBorder,
              width: 2,
            ), // The width of the inner border
          ),
          child: Container(
            padding: const EdgeInsets.all(36),
            decoration: BoxDecoration(
              gradient: boxGradient, // The actual content background
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
