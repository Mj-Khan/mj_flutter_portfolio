import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class AvatarWidget extends StatelessWidget {
  final double size;
  const AvatarWidget({super.key, this.size = 52});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final c1 = isDark ? AppColors.darkAccent1 : AppColors.lightAccent1;
    final c2 = isDark ? AppColors.darkAccent2 : AppColors.lightAccent2;

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _AvatarPainter(color1: c1, color2: c2),
      ),
    );
  }
}

class _AvatarPainter extends CustomPainter {
  final Color color1;
  final Color color2;
  _AvatarPainter({required this.color1, required this.color2});

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width / 2;
    final center = Offset(r, r);

    // Background circle
    final bgPaint = Paint()
      ..shader = RadialGradient(
        colors: [color1, color2],
        center: Alignment.topLeft,
      ).createShader(Rect.fromCircle(center: center, radius: r));
    canvas.drawCircle(center, r, bgPaint);

    final personPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.92)
      ..style = PaintingStyle.fill;

    // Head
    final headRadius = r * 0.30;
    final headCenter = Offset(r, r * 0.72);
    canvas.drawCircle(headCenter, headRadius, personPaint);

    // Shoulders / body shape (clipped to circle)
    final bodyPath = Path();
    final bodyTop = headCenter.dy + headRadius * 0.7;
    final bodyWidth = r * 0.80;
    bodyPath.moveTo(center.dx - bodyWidth, size.height + 2);
    bodyPath.quadraticBezierTo(
      center.dx - bodyWidth * 0.5,
      bodyTop,
      center.dx,
      bodyTop,
    );
    bodyPath.quadraticBezierTo(
      center.dx + bodyWidth * 0.5,
      bodyTop,
      center.dx + bodyWidth,
      size.height + 2,
    );
    bodyPath.close();

    // Clip body to the circle
    canvas.save();
    canvas.clipPath(
      Path()..addOval(Rect.fromCircle(center: center, radius: r)),
    );
    canvas.drawPath(bodyPath, personPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _AvatarPainter old) =>
      old.color1 != color1 || old.color2 != color2;
}
