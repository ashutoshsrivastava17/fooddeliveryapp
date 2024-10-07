import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/widgets/custom_background.dart';
import '../utils/data_extensions.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;

  const CustomBottomSheet({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    const double topHandleHeight = 5.0;
    const double topHandleWidth = 50.0;
    const double topMargin = 8.0;
    const double bottomSheetHeightReduction = 100.0;

    return Column(
      children: [
        // Handle at the top of the bottom sheet
        const CustomBackground(
          width: topHandleWidth,
          height: topHandleHeight,
          backgroundColor: Colors.white,
        ),
        // The main content of the bottom sheet
        CustomBackground(
          width: double.infinity,
          cornerRadiusTopLeft: true,
          backgroundColor: Colors.white,
          height: screenHeight - bottomSheetHeightReduction,
          child: child,
        ).addMarginLTRB(top: topMargin),
      ],
    );
  }
}
