import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CtaButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final String url;
  final bool filled;
  final Color accent;

  const CtaButton({
    super.key,
    required this.label,
    required this.icon,
    required this.url,
    required this.filled,
    required this.accent,
  });

  @override
  State<CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<CtaButton> {
  bool _hovered = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg = widget.filled
        ? widget.accent.withValues(alpha: _hovered ? 1.0 : 0.85)
        : Colors.transparent;

    final border = widget.filled
        ? Colors.transparent
        : widget.accent.withValues(alpha: _hovered ? 0.7 : 0.35);

    final textColor = widget.filled
        ? Colors.white
        : _hovered
        ? widget.accent
        : (isDark ? Colors.white70 : Colors.black87);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _launch,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: border, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 18, color: textColor),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
