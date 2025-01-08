import 'package:el_biz/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/color_resources.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final String title;
  final String svgIcon;
  final Color? borderColor;
  final Color buttonColor;
  final Color textColor;
  final Color svgIconColor;
  final Function()? onTap;
  final bool isMaxSize;
  const CustomButtonWithIcon(
      {super.key,
      required this.title,
      required this.svgIcon,
      this.borderColor,
      this.buttonColor = ColorResources.green,
      this.textColor = Colors.white,
      this.svgIconColor = Colors.white,
      this.onTap,
      this.isMaxSize = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: isMaxSize ? 0 : 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: borderColor == null
              ? null
              : Border.all(
                  width: 1,
                  color: borderColor!,
                ),
          color: buttonColor,
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 0,
              offset: Offset(0, 1),
              color: Color.fromRGBO(16, 24, 40, 0.05),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: isMaxSize ? MainAxisSize.max : MainAxisSize.min,
          children: [
            SvgPicture.asset(
              svgIcon,
              color: svgIconColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: button16.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
