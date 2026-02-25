import 'package:flutter/material.dart';
import 'app_colors.dart';

/* =========================================================
   REVEAL ON SCROLL (BLOCKY/GLITCH STYLE)
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
  late final Animation<double> _visibility;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    // Faster, snappier retro animation
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    // Instead of a smooth curve fade, we step it
    _visibility = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.linear));

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

    if (pos.dy < viewportHeight * 0.95) {
      _revealed = true;
      widget.scrollController.removeListener(_check);
      Future.delayed(widget.delay, () {
        if (mounted) _animController.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _visibility,
      builder: (context, child) {
        // Step function visibility to simulate retro frame rate drawing
        final double opacity = _visibility.value > 0.5 ? 1.0 : 0.0;

        return Opacity(opacity: opacity, child: child);
      },
      child: widget.child,
    );
  }
}

/* =========================================================
   THEME SWITCH (CHUNKY PIXEL STYLE)
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
    final borderCol = isDark
        ? AppColors.retroBorderDark
        : AppColors.retroBorderLight;
    final bgCol = isDark ? AppColors.retroBgDark : AppColors.retroBgLight;
    final thumbCol = isDark ? AppColors.neoGreen : AppColors.neoMagenta;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onChanged(!isDark),
        child: Container(
          width: 50,
          height: 24,
          decoration: BoxDecoration(
            color: bgCol,
            border: Border.all(color: borderCol, width: 2),
            boxShadow: [
              BoxShadow(
                color: borderCol,
                offset: const Offset(2, 2), // hard shadow
              ),
            ],
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 100), // snap
                curve: Curves.linear,
                left: isDark ? 26 : 0,
                top: 0,
                bottom: 0,
                child: Container(width: 20, color: thumbCol),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
