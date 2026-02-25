import 'dart:math';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class BackgroundBlobs extends StatelessWidget {
  final AnimationController controller;
  final Offset mouseOffset;

  const BackgroundBlobs({
    super.key,
    required this.controller,
    required this.mouseOffset,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final t = controller.value * 2 * pi;
        return Stack(
          children: [
            // Blob 1 — large green-teal, top-left
            _blob(
              t: t,
              x: -360,
              y: -260,
              index: 0,
              size: 680,
              colorA: AppColors.blob1a,
              colorB: AppColors.blob1b,
            ),
            // Blob 2 — medium blue-slate, lower-left
            _blob(
              t: t,
              x: 100,
              y: 500,
              index: 1,
              size: 560,
              colorA: AppColors.blob2a,
              colorB: AppColors.blob2b,
            ),
            // Blob 3 — smaller rose-grey, upper-mid
            _blob(
              t: t,
              x: 600,
              y: 100,
              index: 2,
              size: 550,
              colorA: AppColors.blob3a,
              colorB: AppColors.blob3b,
            ),
            // Blob 4 — far right edge, upper
            _blob(
              t: t,
              x: 1150,
              y: -50,
              index: 3,
              size: 520,
              colorA: AppColors.blob4a,
              colorB: AppColors.blob4b,
            ),
            // Blob 5 — middle right edge
            _blob(
              t: t,
              x: 1300,
              y: 400,
              index: 4,
              size: 600,
              colorA: AppColors.blob5a,
              colorB: AppColors.blob5b,
            ),
            // Blob 6 — lower right edge
            _blob(
              t: t,
              x: 900,
              y: 800,
              index: 5,
              size: 450,
              colorA: AppColors.blob6a,
              colorB: AppColors.blob6b,
            ),
            // Blob 7 — far bottom right corner
            _blob(
              t: t,
              x: 1350,
              y: 1200,
              index: 6,
              size: 640,
              colorA: AppColors.blob7a,
              colorB: AppColors.blob7b,
            ),
          ],
        );
      },
    );
  }

  Widget _blob({
    required double t,
    required double x,
    required double y,
    required int index,
    required double size,
    required Color colorA,
    required Color colorB,
  }) {
    final dx = sin(t + index * 1.8) * 55;
    final dy = cos(t + index * 1.8) * 55;

    return Positioned(
      left: x + dx + mouseOffset.dx * 80,
      top: y + dy + mouseOffset.dy * 80,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [colorA, colorB],
            stops: const [0.0, 1.0],
          ),
        ),
      ),
    );
  }
}
