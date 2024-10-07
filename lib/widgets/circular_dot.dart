import 'package:flutter/material.dart';

class CircleDot extends StatelessWidget {
  final double diameter;
  final Color backgroundColor;

  const CircleDot({
    super.key,
    required this.diameter, // Circle diameter
    this.backgroundColor = Colors.white, // Default background color
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle, // Circular shape
      ),
    );
  }
}
