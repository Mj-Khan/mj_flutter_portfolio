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

    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(
              alpha: hovered
                  ? AppColors.glassBorderHover
                  : AppColors.glassBorder,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: AppColors.glassDarkShadow)
                  : Colors.black.withValues(alpha: AppColors.glassLightShadow),
              blurRadius: hovered ? 40 : 20,
              offset: const Offset(0, 10),
            ),
          ],
          gradient: LinearGradient(
            colors: isDark
                ? [
                    Colors.white.withValues(alpha: 0.08),
                    Colors.white.withValues(alpha: 0.03),
                  ]
                : [
                    Colors.white.withValues(alpha: 0.35),
                    Colors.white.withValues(alpha: 0.15),
                  ],
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
