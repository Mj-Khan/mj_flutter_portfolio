import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;

  const SocialLink({
    super.key,
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  State<SocialLink> createState() => _SocialLinkState();
}

class _SocialLinkState extends State<SocialLink> {
  bool _hovered = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = _hovered
        ? (isDark ? Colors.white : Colors.black87)
        : Colors.grey.shade500;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _launch,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: color),
          child: Row(
            children: [
              Icon(widget.icon, size: 16, color: color),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
