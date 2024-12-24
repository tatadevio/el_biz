import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/company/widgets/show_company_detail_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_dialog.dart';

class ShowLlcIssueBox extends StatefulWidget {
  const ShowLlcIssueBox({super.key});

  @override
  State<ShowLlcIssueBox> createState() => _ShowLlcIssueBoxState();
}

class _ShowLlcIssueBoxState extends State<ShowLlcIssueBox> {
  final TextEditingController llcNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(254, 228, 226, 1),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  Images.svgAlertCircle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'nothing_was_found_for_this_TIN'.tr,
            style: h16.copyWith(color: ColorResources.darkGray),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'check_that_the_TIN_entered_is_correct_and_try_again'.tr,
            style: body14.copyWith(color: ColorResources.gray),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField1(
            controller: llcNumberController,
            hintColor: '',
            inputType: TextInputType.name,
            leading: '',
            readOnly: false,
            lableText: 'TIN_of_your_company'.tr,
          ),
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
                    Get.dialog(
                      const CustomDialog(
                        widget: AlertDialog(
                          backgroundColor: Colors.white,
                          titlePadding: EdgeInsets.all(0),
                          contentPadding: EdgeInsets.all(5),
                          content: Padding(
                            padding: EdgeInsets.all(0),
                            child: ShowCompanyDetailBox(),
                          ),
                        ),
                      ),
                    );
                  },
                  color: ColorResources.primary,
                  child: Text(
                    "submit".tr,
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
