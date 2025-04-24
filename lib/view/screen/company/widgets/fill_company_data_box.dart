import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/company/widgets/show_llc_issue_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../bloc/tin_number/tin_bloc.dart';
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
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TIN',
            style: h16.copyWith(color: ColorResources.darkGray),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'please_fill_in_the_TIN_of_your_company'.tr,
            style: body14.copyWith(color: ColorResources.gray),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
              controller: llcNumberController,
              hintColor: '',
              inputType: TextInputType.name,
              leading: '',
              readOnly: false),
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
                    side: const BorderSide(
                        color: ColorResources.lgColor, width: 1),
                  ),

                  onPressed: () {
                    Get.back();
                  },
                  color: ColorResources.white,
                  child: Text(
                    "cancel".tr,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorResources.gray),
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  onPressed: () async {
                    if (llcNumberController.text.isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Please enter a valid TIN number',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } else {
                      Get.back();
                      context.read<TinBloc>().add(
                          VerifyTinNumber(tinNumber: llcNumberController.text));
                    }
                    // Get.back();
                    // Get.dialog(
                    //   const CustomDialog(
                    //     widget: AlertDialog(
                    //       backgroundColor: Colors.white,
                    //       titlePadding: EdgeInsets.all(0),
                    //       contentPadding: EdgeInsets.all(5),
                    //       content: Padding(
                    //         padding: EdgeInsets.all(0),
                    //         child: ShowLlcIssueBox(),
                    //       ),
                    //     ),
                    //   ),
                    // );
                  },
                  color: ColorResources.primary,
                  child: Text(
                    "send".tr,
                    style: const TextStyle(
                        letterSpacing: 0.5, fontSize: 16, color: Colors.white),
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
