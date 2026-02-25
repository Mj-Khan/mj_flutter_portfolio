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

    final borderCol = isDark
        ? AppColors.retroBorderDark
        : AppColors.retroBorderLight;
    final bgCol = isDark ? AppColors.retroBgDark : AppColors.retroBgLight;

    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100), // Quick snap
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: bgCol,
          border: Border.all(
            color: borderCol,
            width: 3, // chunky border
          ),
          boxShadow: [
            BoxShadow(
              color: borderCol,
              // Hard retro shadow that shifts on hover for a "pushed down" or "lifted" effect
              offset: hovered ? const Offset(8, 8) : const Offset(4, 4),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
