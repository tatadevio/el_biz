import 'package:el_biz/view/screen/company/add_company_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';

class ShowCompanyDetailBox extends StatelessWidget {
  const ShowCompanyDetailBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TIN_information'.tr,
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'TIN_NP',
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                ),
                Expanded(
                  child: Text(
                    '03010201310131',
                    style: body14.copyWith(color: ColorResources.gray),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'UGNS_code'.tr,
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Первомайский р-н',
                    style: body14.copyWith(color: ColorResources.gray),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'ФИО/Наименование НП',
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                ),
                Expanded(
                  child: Text(
                    'ОсОО "Группа Компаний Сиерра"',
                    style: body14.copyWith(color: ColorResources.gray),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),

          // CustomTextField(controller: llcNumberController, hintColor: '', inputType: TextInputType.none, leading: '', readOnly: false),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: MaterialButton(
                  elevation: 0,
                  height: 44,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: ColorResources.lgColor, width: 1),
                  ),

                  onPressed: () {
                    Get.back();
                  },
                  color: ColorResources.white,
                  child: Text(
                    "cancel".tr,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ColorResources.gray),
                  ),
                  //  Colors.grey[300],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: MaterialButton(
                  elevation: 0,
                  height: 44,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  onPressed: () async {
                    Get.back();
                    Get.to(() => const AddCompanyScreen());
                  },
                  color: ColorResources.primary,
                  child: Text(
                    "continue".tr,
                    style: const TextStyle(letterSpacing: 0.5, fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
