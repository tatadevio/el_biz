import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/company/widgets/show_llc_issue_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_dialog.dart';

class FillCompanyDataBox extends StatefulWidget {
  const FillCompanyDataBox({super.key});

  @override
  State<FillCompanyDataBox> createState() => _FillCompanyDataBoxState();
}

class _FillCompanyDataBoxState extends State<FillCompanyDataBox> {
  final TextEditingController llcNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ИНН',
            style: h16.copyWith(color: ColorResources.darkGray),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Пожалуйста заполните ИНН вашей компании ',
            style: body14.copyWith(color: ColorResources.gray),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(controller: llcNumberController, hintColor: '', inputType: TextInputType.name, leading: '', readOnly: false),
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
                    side: BorderSide(color: ColorResources.lgColor, width: 1),
                  ),

                  onPressed: () {
                    Get.back();
                  },
                  color: ColorResources.white,
                  child: Text(
                    "no".tr,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ColorResources.gray),
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
                      CustomDialog(
                        widget: AlertDialog(
                          backgroundColor: Colors.white,
                          titlePadding: const EdgeInsets.all(0),
                          contentPadding: const EdgeInsets.all(5),
                          content: Padding(
                            padding: const EdgeInsets.all(0),
                            child: ShowLlcIssueBox(),
                          ),
                        ),
                      ),
                    );
                  },
                  color: ColorResources.primary,
                  child: Text(
                    "yes".tr,
                    style: TextStyle(letterSpacing: 0.5, fontSize: 16, color: Colors.white),
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
