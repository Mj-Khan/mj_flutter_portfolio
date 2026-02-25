import 'package:flutter/material.dart';

class RetroText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color color;
  final Color shadowColor;

  const RetroText(
    this.text, {
    super.key,
    required this.style,
    required this.color,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        color: color,
        shadows: [
          Shadow(
            color: shadowColor,
            offset: const Offset(3, 3), // Chonky shadow
            blurRadius: 0, // Zero blur = Retro sharp look
          ),
        ],
      ),
    );
  }
}
