import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;
  final double radius;
  final EdgeInsets margin;

  const CustomDivider({
    Key? key,
    required this.width,
    required this.height,
    this.color,
    this.radius = 30,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? theme.primaryColor,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
