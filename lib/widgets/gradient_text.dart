import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final List<Color> colors;

  const GradientText(
    this.text, {
    super.key,
    required this.style,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          LinearGradient(colors: colors).createShader(bounds),
      child: Text(text, style: style.copyWith(color: Colors.white)),
    );
  }
}
