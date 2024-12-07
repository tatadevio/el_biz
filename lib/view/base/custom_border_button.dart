import 'package:flutter/material.dart';

class CustomBorderButton extends StatelessWidget {
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;

  final BoxBorder border;
  final BorderRadiusGeometry borderRadius;
  final List<BoxShadow> boxShaow;
  final Widget child;
  final Function() onTap;
  const CustomBorderButton({super.key, required this.height, required this.width, required this.padding, required this.border, required this.borderRadius, required this.boxShaow, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(border: border, boxShadow: boxShaow, borderRadius: borderRadius),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
