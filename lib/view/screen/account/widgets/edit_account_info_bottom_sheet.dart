import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAccountInfoBottomSheet extends StatefulWidget {
  const EditAccountInfoBottomSheet({super.key});

  @override
  State<EditAccountInfoBottomSheet> createState() => _EditAccountInfoBottomSheetState();
}

class _EditAccountInfoBottomSheetState extends State<EditAccountInfoBottomSheet> {
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
                    decoration: BoxDecoration(
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
                      'Реквизит',
                      style: h16.copyWith(color: ColorResources.darkGray),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField1(controller: accountNameController, hintColor: 'Optima USD', inputType: TextInputType.text, lableText: 'Дайте название для вашего счёта', leading: '', readOnly: false),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField1(controller: accountBIKController, hintColor: '0202020202002', inputType: TextInputType.text, lableText: 'БИК', leading: '', readOnly: false),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField1(controller: accountNameController, hintColor: '0202020202002', inputType: TextInputType.text, lableText: 'Номер счёта', leading: '', readOnly: false),
                    const SizedBox(
                      height: 30,
                    ),
                    // CustomButton(width: Get.width * 0.7, height: 45, onTap: onTap, title: title)
                    CustomButtonWithIcon(
                      title: 'Удалить реквизит',
                      svgIcon: Images.svgTrash,
                      buttonColor: ColorResources.red,
                      borderColor: ColorResources.red,
                      isMaxSize: false,
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(width: Get.width, height: 48, onTap: () {}, title: 'Сохранить'),
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
