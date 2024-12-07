import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';

PreferredSizeWidget CustomAddCompanyAppbar({
  required String title,
}) {
  double width = Get.currentRoute == "/AddCompanyScreen"
      ? 20
      : Get.currentRoute == "/CompanyDescriptionScreen"
          ? 60
          : Get.currentRoute == "/AttributeScreen"
              ? 90
              : Get.currentRoute == "/KeywordsTagsScreen"
                  ? 150
                  : Get.currentRoute == "/CompanyInfoScreen"
                      ? 200
                      : Get.currentRoute == "/CompanyContactInfoScreen"
                          ? 250
                          : Get.currentRoute == "/CompanyAccountInfoScreen"
                              ? 250
                              : Get.currentRoute == "/AddCompanyDocumentScreen"
                                  ? 250
                                  : Get.currentRoute == "/SelectCategoryAddProduct"
                                      ? 20
                                      : 20;

  double percentage = Get.currentRoute == "/AddCompanyScreen"
      ? 0
      : Get.currentRoute == "/CompanyDescriptionScreen"
          ? 20
          : Get.currentRoute == "/AttributeScreen"
              ? 40
              : Get.currentRoute == "/KeywordsTagsScreen"
                  ? 60
                  : Get.currentRoute == "/CompanyInfoScreen"
                      ? 80
                      : Get.currentRoute == "/CompanyContactInfoScreen"
                          ? 90
                          : Get.currentRoute == "/CompanyAccountInfoScreen"
                              ? 90
                              : Get.currentRoute == "/AddCompanyDocumentScreen"
                                  ? 90
                                  : Get.currentRoute == "/SelectCategoryAddProduct"
                                      ? 10
                                      : 10;

  return AppBar(
    backgroundColor: Colors.white,
    title: Text(title),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(30),
      child: Padding(
        padding: EdgeInsets.only(left: 12.0, bottom: 15, top: 10, right: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 9,
              width: Get.width * .8,
              decoration: BoxDecoration(color: ColorResources.background, borderRadius: BorderRadius.circular(12.0)),
              child: Row(
                children: [
                  Container(
                    height: 9,
                    width: width,
                    decoration: BoxDecoration(color: ColorResources.primary, borderRadius: BorderRadius.circular(12.0)),
                  ),
                ],
              ),
            ),
            Text(
              "${percentage.toStringAsFixed(0)}%",
              style: normalTextStyle.copyWith(color: Color(0xff646F7F)),
            )
          ],
        ),
      ),
    ),
  );
}
