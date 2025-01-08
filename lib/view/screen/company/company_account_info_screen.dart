import 'dart:convert';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../utils/color_resources.dart';
import 'widgets/custom_add_company_appbar.dart';
import 'widgets/select_currency_widget.dart';

class CompanyAccountInfoScreen extends StatefulWidget {
  const CompanyAccountInfoScreen({super.key});

  @override
  State<CompanyAccountInfoScreen> createState() =>
      _CompanyAccountInfoScreenState();
}

class _CompanyAccountInfoScreenState extends State<CompanyAccountInfoScreen> {
  final TextEditingController accountName = TextEditingController();
  final TextEditingController bikController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController textController1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: customAddCompanyAppbar(title: ''),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "details".tr,
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'view_banks'.tr,
                        style: button16.copyWith(color: ColorResources.blue),
                      ),
                      SvgPicture.asset(Images.svgArrowForwardIcon),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'account_no_1'.tr,
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField1(
                  controller: accountName,
                  hintColor: '',
                  inputType: TextInputType.name,
                  lableText: 'give_a_name_for_your_account'.tr,
                  leading: '',
                  readOnly: false),
              const SizedBox(
                height: 20,
              ),
              CustomTextField1(
                  controller: bikController,
                  hintColor: '',
                  inputType: TextInputType.text,
                  lableText: 'БИК',
                  leading: '',
                  readOnly: false),
              const SizedBox(
                height: 20,
              ),
              CustomTextField1(
                  controller: accountNumberController,
                  hintColor: '',
                  inputType: TextInputType.number,
                  lableText: 'account_number'.tr,
                  leading: '',
                  readOnly: false),
              const SizedBox(
                height: 15,
              ),
              CustomButtonWithIcon(
                title: 'add_props'.tr,
                svgIcon: Images.svgPlus,
                isMaxSize: false,
                textColor: ColorResources.gray,
                buttonColor: ColorResources.lgColor,
                borderColor: ColorResources.lgColor,
                svgIconColor: ColorResources.gray,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  // height: 48,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorResources.primary,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 0,
                        offset: Offset(0, 1),
                        color: Color.fromRGBO(16, 24, 40, 0.05),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'skip'.tr,
                    style: textMd.copyWith(color: ColorResources.blue),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      backgroundColor: Colors.white,
                      const SelectCurrencyWidget(),
                    );
                  },
                  child: Container(
                    // height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorResources.primary,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: ColorResources.primary,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 0,
                          offset: Offset(0, 1),
                          color: Color.fromRGBO(16, 24, 40, 0.05),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'continue'.tr,
                      style: textMd.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Map<String, List<String>> convertContactsToMap(List<List<String>> contacts) {
  Map<String, List<String>> contactMap = {};

  // Populate the contactMap with the contact details
  if (contacts.isNotEmpty) {
    contactMap['whatsapp'] = contacts[0]; // Assuming first list is WhatsApp
    contactMap['telegram'] = contacts[1]; // Assuming second list is Telegram
    contactMap['instagram'] = contacts[2]; // Assuming third list is Instagram
    contactMap['vk'] = contacts[3]; // Assuming fourth list is VK
    contactMap['email'] = contacts[4]; // Assuming fifth list is Email
    contactMap['website'] = contacts[5]; // Assuming sixth list is Website
  }

  return contactMap;
}

Map<String, String> convertContactsToMapString(
    Map<String, List<String>> contactMap) {
  Map<String, String> mapString = {};

  contactMap.forEach((key, value) {
    // Join the list items into a single string with comma separator
    mapString[key] = value.join(', ');
  });

  return mapString;
}

String convertScheduleToString(List<dynamic> scheduleTiming) {
  // Convert each schedule to JSON format
  List<String> schedules =
      scheduleTiming.map((schedule) => jsonEncode(schedule.toJson())).toList();

  // Join JSON strings with a delimiter (e.g., newline or comma)
  return schedules.join(', ');
}
