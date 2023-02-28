import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    //ShaderMask widget is used to apply a shader to its child widget
    //Helps to apply a gradient on text
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      //This property determines how the shader and the child widget will be blended together.
      //In this case, the srcIn blend mode
      shaderCallback: (bounds) => gradient.createShader(
        //Helps to restrict and fix gradient
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
