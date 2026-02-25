import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class RetroBackground extends StatelessWidget {
  final AnimationController controller;

  const RetroBackground({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gridCol = isDark
        ? AppColors.neoGreen.withValues(alpha: 0.15)
        : AppColors.textMainLight.withValues(alpha: 0.1);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return CustomPaint(
          painter: _RetroGridPainter(
            gridColor: gridCol,
            offset: controller.value, // value from 0 to 1
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class _RetroGridPainter extends CustomPainter {
  final Color gridColor;
  final double offset; // 0.0 to 1.0 for continuous scrolling

  _RetroGridPainter({required this.gridColor, required this.offset});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const double gridSize = 60.0;

    // Vertical lines
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines (scrolling downwards to simulate forward motion)
    final scrollOffset = offset * gridSize;

    for (double y = -gridSize; y <= size.height + gridSize; y += gridSize) {
      canvas.drawLine(
        Offset(0, y + scrollOffset),
        Offset(size.width, y + scrollOffset),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RetroGridPainter old) {
    return old.offset != offset || old.gridColor != gridColor;
  }
}
