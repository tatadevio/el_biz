import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAccountInfoBottomSheet extends StatefulWidget {
  final bool isAddNew;
  const EditAccountInfoBottomSheet({super.key, this.isAddNew = false});

  @override
  State<EditAccountInfoBottomSheet> createState() =>
      _EditAccountInfoBottomSheetState();
}

class _EditAccountInfoBottomSheetState
    extends State<EditAccountInfoBottomSheet> {
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController accountBIKController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                    width: 35,
                    decoration: const BoxDecoration(
                      color: ColorResources.lgColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'props'.tr,
                      style: h16.copyWith(color: ColorResources.darkGray),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField1(
                        controller: accountNameController,
                        hintColor: 'Optima USD',
                        inputType: TextInputType.text,
                        lableText: 'give_a_name_for_your_account'.tr,
                        leading: '',
                        readOnly: false),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField1(
                        controller: accountBIKController,
                        hintColor: '0202020202002',
                        inputType: TextInputType.text,
                        lableText: 'bic'.tr,
                        leading: '',
                        readOnly: false),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField1(
                        controller: accountNameController,
                        hintColor: '0202020202002',
                        inputType: TextInputType.text,
                        lableText: 'account_number'.tr,
                        leading: '',
                        readOnly: false),
                    const SizedBox(
                      height: 30,
                    ),
                    // CustomButton(width: Get.width * 0.7, height: 45, onTap: onTap, title: title)
                    if (!widget.isAddNew)
                      CustomButtonWithIcon(
                        title: 'delete_props'.tr,
                        svgIcon: Images.svgTrash,
                        buttonColor: ColorResources.red,
                        borderColor: ColorResources.red,
                        isMaxSize: false,
                        onTap: () {},
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                        width: Get.width,
                        height: 48,
                        onTap: () {
                          Get.back();
                        },
                        title: 'save'.tr),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
