import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/screen/company/company_page_screen.dart';
import 'package:el_biz/view/screen/company/widgets/custom_add_company_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../base/custom_button.dart';

class AddCompanyDocumentScreen extends StatelessWidget {
  const AddCompanyDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAddCompanyAppbar(title: ""),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'certificate_of_state_registration_of_a_legal_entity'.tr,
              style: h16.copyWith(color: ColorResources.darkGray),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'upload_your_certificate_document'.tr,
              style: body14.copyWith(color: ColorResources.gray),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: ColorResources.backgroundColor,
                    border: Border.all(
                      width: 6,
                      color: ColorResources.lightBlue,
                    ),
                    shape: BoxShape.circle),
                alignment: Alignment.center,
                child: SvgPicture.asset(Images.svgDownload),
              ),
              title: Text(
                'upload_document'.tr,
                style: body14.copyWith(color: ColorResources.gray),
              ),
              subtitle: Text(
                'SVG, PNG, JPG',
                style: textXS.copyWith(color: ColorResources.gray),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'other_documents_and_certificates'.tr,
              style: h16.copyWith(color: ColorResources.darkGray),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'you_can_only_upload_up_to_10_documents'.tr,
              style: body14.copyWith(color: ColorResources.gray),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: ColorResources.backgroundColor,
                    border: Border.all(
                      width: 6,
                      color: ColorResources.lightBlue,
                    ),
                    shape: BoxShape.circle),
                alignment: Alignment.center,
                child: SvgPicture.asset(Images.svgDownload),
              ),
              title: Text(
                'upload_document'.tr,
                style: body14.copyWith(color: ColorResources.gray),
              ),
              subtitle: Text(
                'SVG, PNG, JPG',
                style: textXS.copyWith(color: ColorResources.gray),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: CustomButton(
            width: Get.width,
            height: 44,
            onTap: () {
              Get.to(() => CompanyPageScreen());
            },
            title: 'continue'.tr),
      ),
    );
  }
}
