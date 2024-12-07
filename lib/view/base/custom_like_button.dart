import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/Images.dart';
import '../../utils/color_resources.dart';

class CustomLikeButton extends StatelessWidget {
  final bool isFavorite;
  const CustomLikeButton({super.key, this.isFavorite = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 0,
            offset: Offset(0, 1),
            color: Color.fromRGBO(16, 24, 40, 0.05),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        isFavorite ? Images.svgHeart : Images.svgHeartBorder,
        color: isFavorite ? ColorResources.primaryRed : null,
      ),
    );
  }
}
