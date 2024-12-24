import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';

class NoCompanyWidget extends StatelessWidget {
  const NoCompanyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.companiesIcon,
              width: width * 0.5,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'add_your_company_and_collaborate_with_trusted_companies'.tr,
          style: h24.copyWith(color: ColorResources.darkGray),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        // Text(
        //   'После регистрации вашей компании  вы можете:',
        //   style: body16.copyWith(color: ColorResources.gray),
        // ),
        RichText(
          text: TextSpan(
            style: body16.copyWith(color: ColorResources.gray, height: 1.6),
            children: [
              TextSpan(text: 'after_registering_your_company_you_can'.tr),
              const TextSpan(text: '• ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'create_a_tender'.tr),
              const TextSpan(text: '• ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'conclude_contracts_with_buyers'.tr),
              const TextSpan(text: '• ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'upload_your_products_and_sell_them_on_our_platform'.tr),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
