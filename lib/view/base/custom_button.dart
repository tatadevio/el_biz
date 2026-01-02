import 'package:el_biz/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import '../../utils/color_resources.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Function onTap;
  final Color color;
  final String title;
  final double radius;
  final Color textColor;
  final Widget? child;
  const CustomButton({
    Key? key,
    required this.width,
    required this.height,
    required this.onTap,
    this.color = ColorResources.primary,
    required this.title,
    this.radius = 10.0,
    this.textColor = Colors.white,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      height: height,
      minWidth: width,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      onPressed: () {
        onTap();
      },
      color: color,
      // color: Colors.transparent,
      // splashColor: Colors.transparent,
      child: child ??
          Text(
            title,
            style: button16.copyWith(color: textColor),
            // const TextStyle(
            // color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
          ),
    );
  }
}

class CustomButtonLoader extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  const CustomButtonLoader({
    Key? key,
    required this.width,
    required this.height,
    this.color = ColorResources.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: ColorResources.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: MaterialButton(
        elevation: 0,
        height: height,
        minWidth: width,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onPressed: () {},
        // color: color,
        child: SizedBox(
            height: 24,
            width: 24,
            child: const CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 3,
            )),
      ),
    );
  }
}
