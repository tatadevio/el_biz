import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/screen/company/company_page_screen.dart';
import 'package:el_biz/view/screen/company/my_companies_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddCompanyBottomSheet extends StatefulWidget {
  const AddCompanyBottomSheet({super.key});

  @override
  State<AddCompanyBottomSheet> createState() => _AddCompanyBottomSheetState();
}

class _AddCompanyBottomSheetState extends State<AddCompanyBottomSheet> {
  String? _selectedOption;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Container(
      height: height * 0.6,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      // decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 3,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(217, 217, 217, 1),
                    borderRadius: BorderRadius.circular(3),
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Личный профиль',
                      style: h16.copyWith(color: ColorResources.darkGray),
                    ),
                  ),
                  RadioListTile<String>(
                    contentPadding: const EdgeInsets.all(0),
                    title: accountInfo('Имя Фамилия', 'ОсОО...'),
                    value: 'user',
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                      Get.back();
                      Get.to(() => CompanyPageScreen());
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Мои компании',
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RadioListTile<String>(
                    contentPadding: const EdgeInsets.all(0),
                    title: accountInfo('Садовая мебель Loft', 'ОсОО...'),
                    value: 'company1',
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    contentPadding: const EdgeInsets.all(0),
                    title: accountInfo('Посуда Loft', 'ОсОО...'),
                    value: 'company2',
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // addNewCompanyButton(),
                  CustomButtonWithIcon(
                    title: 'Добавить компанию',
                    svgIcon: Images.svgPlus,
                    borderColor: ColorResources.green,
                    onTap: () {
                      Get.back();
                      Get.to(() => MyCompaniesScreen());
                    },
                  ),
                  // CustomButton(width: Get.width, height: 44, onTap: () {}, title: 'Добавить компанию'),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget accountInfo(String title, String subTitle) {
    return Container(
      // padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorResources.lightBlue,
        border: Border.all(width: 1, color: ColorResources.lgColor),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: -2,
            offset: Offset(0, 4),
            color: Color.fromRGBO(16, 24, 40, 0.1),
          ),
        ],
      ),
      child: ListTile(
        dense: true,
        leading: CustomImage(image: '', height: 40, width: 40, radius: 40),
        title: Text(
          title,
          style: h16.copyWith(color: ColorResources.darkGray),
        ),
        subtitle: Text(
          subTitle,
          style: body14.copyWith(color: ColorResources.darkGray),
        ),
      ),
    );
  }

  // Widget addNewCompanyButton() {
  //   return InkWell(
  //     borderRadius: BorderRadius.circular(12),
  //     onTap: () {
  //       Get.to(() => MyCompaniesScreen());
  //     },
  //     child: Container(
  //       height: 48,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(12),
  //         border: Border.all(
  //           width: 1,
  //           color: ColorResources.green,
  //         ),
  //         color: ColorResources.green,
  //         boxShadow: const [
  //           BoxShadow(
  //             blurRadius: 2,
  //             spreadRadius: 0,
  //             offset: Offset(0, 1),
  //             color: Color.fromRGBO(16, 24, 40, 0.05),
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           SvgPicture.asset(Images.svgPlus),
  //           const SizedBox(
  //             width: 10,
  //           ),
  //           Text(
  //             'Добавить компанию',
  //             style: button16,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
