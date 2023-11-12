import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final Color? firstColor;
  final Color? secondColor;
  final double? fontSize;
  const GradientText(
    this.text, {
    super.key,
    this.firstColor,
    this.secondColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: ((bounds) => LinearGradient(
            colors: [
              firstColor ?? Theme.of(context).colorScheme.tertiary,
              secondColor ?? Theme.of(context).colorScheme.onTertiary,
            ],
          ).createShader(bounds)),
      child: Text(
        text,
        maxLines: 1,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
      ),
    );
  }
}
