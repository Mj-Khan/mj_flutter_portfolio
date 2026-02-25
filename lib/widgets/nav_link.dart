import 'package:flutter/material.dart';

class NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final Color accentColor;
  final VoidCallback onTap;

  const NavLink({
    super.key,
    required this.label,
    required this.isActive,
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<NavLink> with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late final AnimationController _blinkController;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final color = widget.isActive
        ? widget.accentColor
        : _hovered
        ? (isDark ? Colors.white : Colors.black)
        : Colors.grey.shade600;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              // Retro blinker for active, static for hover
              if (widget.isActive || _hovered)
                widget.isActive
                    ? AnimatedBuilder(
                        animation: _blinkController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _blinkController.value > 0.5 ? 1.0 : 0.0,
                            child: child,
                          );
                        },
                        child: Text(
                          '> ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: widget.accentColor,
                          ),
                        ),
                      )
                    : Text(
                        '> ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: color,
                        ),
                      )
              else
                const SizedBox(width: 18), // Spacer when inactive

              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: widget.isActive
                      ? FontWeight.w700
                      : FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
