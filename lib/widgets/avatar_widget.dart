import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class AvatarWidget extends StatelessWidget {
  final double size;
  const AvatarWidget({super.key, this.size = 52});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final c1 = isDark ? AppColors.darkAccent1 : AppColors.lightAccent1;
    final borderCol = isDark
        ? AppColors.retroBorderDark
        : AppColors.retroBorderLight;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: c1, // background color
        border: Border.all(color: borderCol, width: 3), // Chonky frame
      ),
      child: CustomPaint(
        painter: _RetroAvatarPainter(
          color: isDark ? AppColors.darkScaffold : AppColors.lightScaffold,
        ),
      ),
    );
  }
}

class _RetroAvatarPainter extends CustomPainter {
  final Color color;
  _RetroAvatarPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw a blocky 8-bit style person
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Head (Square)
    final headRect = Rect.fromLTWH(
      size.width * 0.35,
      size.height * 0.2,
      size.width * 0.3,
      size.height * 0.3,
    );
    canvas.drawRect(headRect, paint);

    // Body (Rectangle with chopped corners)
    final bodyRect = Rect.fromLTWH(
      size.width * 0.2,
      size.height * 0.55,
      size.width * 0.6,
      size.height * 0.45,
    );
    canvas.drawRect(bodyRect, paint);
  }

  @override
  bool shouldRepaint(covariant _RetroAvatarPainter old) => old.color != color;
}
