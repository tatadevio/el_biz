import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/Images.dart';
import '../../utils/color_resources.dart';

class CustomFavoriteButton extends StatefulWidget {
  final Function()? onTap;
  final bool isFavorite;
  const CustomFavoriteButton({super.key, this.isFavorite = false, this.onTap});

  @override
  State<CustomFavoriteButton> createState() => _CustomFavoriteButtonState();
}

class _CustomFavoriteButtonState extends State<CustomFavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap!();
      },
      child: Container(
        height: 40,
        width: 40,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: ColorResources.lgColor),
          borderRadius: BorderRadius.circular(12),
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
        child: widget.isFavorite
            ? Icon(
                Icons.favorite,
                color: ColorResources.primaryRed,
              )
            : SvgPicture.asset(Images.svgHeartBorder),
      ),
    );
  }
}
