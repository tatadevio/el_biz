import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/Images.dart';
import '../../utils/color_resources.dart';

class CustomListviewWidget extends StatelessWidget {
  final bool isSelected;
  final Function() onTap;
  const CustomListviewWidget({super.key, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: isSelected ? ColorResources.primary : null,
          border: Border.all(
            width: 1,
            color: isSelected ? ColorResources.primary : ColorResources.lgColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          Images.svgList,
          color: isSelected ? ColorResources.white : ColorResources.gray,
        ),
      ),
    );
  }
}
