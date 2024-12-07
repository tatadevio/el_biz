import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utils/Images.dart';
import '../../utils/color_resources.dart';

class NoDataWidget extends StatelessWidget {
  final String title;
  final String description;
  final String btnTxt;
  final String image;
  final Function onTap;
  final Widget? imageWidget;
  const NoDataWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.btnTxt,
    required this.image,
    required this.onTap,
    this.imageWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 1, 12, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height * 0.16,
          ),

          if (image == "")
            SvgPicture.asset(
              Images.emptySvg,
              height: 200,
            )
          else
            Image.asset(
              image,
              color: title == "authorize".tr ? ColorResources.primary : null,
            ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
            ],
          ),
          // Text(
          //   description,
          //   style: const TextStyle(
          //       color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          //   textAlign: TextAlign.center,
          // ),
          // SizedBox(
          //   height: Get.height * 0.02,
          // ),
          if (title == "authorize".tr)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: MaterialButton(
                elevation: 0,
                height: 48,
                color: ColorResources.primary,
                minWidth: Get.width * 0.95,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                onPressed: () {
                  onTap();
                },
                // color: ColorResources.primary,
                child: Text(
                  btnTxt,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          SizedBox(
            height: Get.height * 0.3,
          ),
        ],
      ),
    );
  }
}

class NoDataWidget1 extends StatelessWidget {
  final String title;
  final String description;
  final String btnTxt;
  final String image;
  final Function onTap;
  final Widget? imageWidget;
  const NoDataWidget1({
    Key? key,
    required this.title,
    required this.description,
    required this.btnTxt,
    required this.image,
    required this.onTap,
    this.imageWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 1, 18, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height * 0.16,
          ),
          if (image == "")
            SvgPicture.asset(
              Images.emptySvg,
              height: 200,
            )
          else
            SvgPicture.asset(
              image,
              color: title == "authorize".tr ? ColorResources.primary : null,
              height: 48,
              width: 48,
            ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Text(
            title,
            style: const TextStyle(color: Color.fromRGBO(33, 32, 32, 1), fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
            ],
          ),
          Text(
            description,
            style: const TextStyle(color: Color.fromRGBO(100, 111, 127, 1), fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Inter'),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          // if (title == "authorize".tr)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: MaterialButton(
              elevation: 0,
              height: 48,
              color: ColorResources.primary,
              minWidth: Get.width * 0.95,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              onPressed: () {
                onTap();
              },
              // color: ColorResources.primary,
              child: Text(
                btnTxt,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.3,
          ),
        ],
      ),
    );
  }
}
