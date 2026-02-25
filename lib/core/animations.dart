import 'package:flutter/material.dart';
import 'app_colors.dart';

/* =========================================================
   REVEAL ON SCROLL
========================================================= */

class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final Duration delay;

  const RevealOnScroll({
    super.key,
    required this.child,
    required this.scrollController,
    this.delay = Duration.zero,
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fade = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    // Check immediately (for sections already in view at load time)
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
    widget.scrollController.addListener(_check);
  }

  @override
  void dispose() {
    _animController.dispose();
    widget.scrollController.removeListener(_check);
    super.dispose();
  }

  void _check() {
    if (_revealed || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;

    final viewportHeight = MediaQuery.of(context).size.height;
    final pos = box.localToGlobal(Offset.zero);

    // Trigger when top of widget appears within the viewport
    if (pos.dy < viewportHeight * 0.92) {
      _revealed = true;
      widget.scrollController.removeListener(_check);
      Future.delayed(widget.delay, () {
        if (mounted) _animController.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

/* =========================================================
   CURSOR GLOW PAINTER
========================================================= */

class CursorGlowPainter extends CustomPainter {
  final Offset position;
  final Color accent;

  CursorGlowPainter({required this.position, required this.accent});

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 500.0;
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          accent.withValues(alpha: 0.10),
          accent.withValues(alpha: 0.04),
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 1.0],
      ).createShader(Rect.fromCircle(center: position, radius: radius));
    canvas.drawCircle(position, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CursorGlowPainter old) =>
      old.position != position || old.accent != accent;
}

/* =========================================================
   THEME SWITCH
========================================================= */

class AnimatedThemeSwitch extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onChanged;

  const AnimatedThemeSwitch({
    super.key,
    required this.isDark,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final accent1 = isDark ? AppColors.darkAccent1 : AppColors.lightAccent1;
    final accent2 = isDark ? AppColors.darkAccent2 : AppColors.lightAccent2;

    return GestureDetector(
      onTap: () => onChanged(!isDark),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: 70,
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(colors: [accent1, accent2]),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 400),
          alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
