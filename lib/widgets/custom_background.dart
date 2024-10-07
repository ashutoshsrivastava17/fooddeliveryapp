import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  final double cornerRadius;
  final Color backgroundColor;
  final Color? borderColor;
  final Gradient? gradient;
  final double? width;
  final double height;
  final Widget child;

  const CustomBackground({
    super.key,
    this.cornerRadius = 50.0, // Default corner radius
    this.backgroundColor = Colors.black, // Default background color
    this.borderColor, // Optional border color
    this.gradient, // Optional gradient
    this.width,
    this.height = 35.0, // Default height
    this.child = const SizedBox(),
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(cornerRadius),
        border: borderColor != null ? Border.all(color: borderColor!) : null,
        gradient: gradient ??
            LinearGradient(colors: [backgroundColor, backgroundColor]),
      ),
      child: Center(child: child),
    );
  }
}
