import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/app_colors.dart';

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

    final borderCol = isDark
        ? AppColors.retroBorderDark
        : AppColors.retroBorderLight;

    final bg = widget.filled
        ? widget.accent
        : (isDark ? AppColors.retroBgDark : AppColors.retroBgLight);

    final textColor = widget.filled
        ? (isDark ? AppColors.darkScaffold : AppColors.lightScaffold)
        : widget.accent;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _launch,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100), // Snap hover
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            color: _hovered ? widget.accent : bg,
            border: Border.all(color: borderCol, width: 3),
            boxShadow: [
              BoxShadow(
                color: borderCol,
                offset: _hovered ? const Offset(8, 8) : const Offset(4, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 20,
                color: _hovered ? AppColors.darkScaffold : textColor,
              ),
              const SizedBox(width: 12),
              Text(
                widget.label.toUpperCase(), // Retro caps
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: _hovered ? AppColors.darkScaffold : textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
