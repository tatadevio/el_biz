import 'package:flutter/material.dart';

import '../../utils/color_resources.dart';

class CustomCloseButton extends StatelessWidget {
  final Function onTap;
  const CustomCloseButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: height * 0.0517,
        width: width * 0.1375,
        decoration: BoxDecoration(color: ColorResources.primary,
            borderRadius: BorderRadius.circular(9.0)),
        child: const Padding(
          padding: EdgeInsets.fromLTRB(8.0,5.0,8.0,5.0),
          child: Icon(
            Icons.clear,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
