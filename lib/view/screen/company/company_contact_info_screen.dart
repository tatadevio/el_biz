import 'package:el_biz/utils/appConstant.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/company/company_account_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../utils/color_resources.dart';
import '../../base/custom_button.dart';
import 'widgets/custom_add_company_appbar.dart';

class CompanyContactInfoScreen extends StatefulWidget {
  const CompanyContactInfoScreen({super.key});

  @override
  State<CompanyContactInfoScreen> createState() =>
      _CompanyContactInfoScreenState();
}

class _CompanyContactInfoScreenState extends State<CompanyContactInfoScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController textController = TextEditingController();
  final TextEditingController textController1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
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
              Text(
                "phone_number".tr,
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'public_phone_numbers_One_per_field'.tr,
                style: body14.copyWith(color: ColorResources.gray),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                // height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: const Color.fromRGBO(208, 213, 221, 1),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 26,
                      height: 16,
                      color: ColorResources.primaryRed,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        Images.svgPhoneFieldLogo,
                        height: 25,
                        width: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      Images.arrowForward,
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Aligns both text and input in the center
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text(
                              AppConstants.countryCode,
                              style: body16,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: TextFormField(
                              maxLength: 10,
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                counterText: "",
                                isDense: true,
                                isCollapsed: true,

                                contentPadding: EdgeInsets.symmetric(
                                    vertical:
                                        5), // Adjust vertical padding as needed
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                              ),
                              style: body16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButtonWithIcon(
                title: 'add_a_number'.tr,
                svgIcon: Images.svgPlus,
                isMaxSize: false,
                textColor: ColorResources.gray,
                svgIconColor: ColorResources.gray,
                buttonColor: ColorResources.lgColor,
                borderColor: ColorResources.lgColor,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'email_address'.tr,
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'official_public_e_mail_of_the_company'.tr,
                style: body14.copyWith(color: ColorResources.gray),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                  controller: emailController,
                  hintColor: '@gmail.com',
                  inputType: TextInputType.emailAddress,
                  leading: Images.svgMail,
                  readOnly: false),
              const SizedBox(
                height: 5,
              ),
              Text(
                'optional_field'.tr,
                style: body12.copyWith(color: ColorResources.gray),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'other_contacts'.tr,
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomTextField1(
                          controller: textController,
                          hintColor: 'Telegram',
                          inputType: TextInputType.text,
                          lableText: 'contact_name'.tr,
                          leading: '',
                          readOnly: false)),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CustomTextField1(
                          controller: textController,
                          hintColor: '@Telegram',
                          inputType: TextInputType.text,
                          lableText: 'contacts'.tr,
                          leading: '',
                          readOnly: false)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButtonWithIcon(
                title: 'add_contacts'.tr,
                svgIcon: Images.svgPlus,
                isMaxSize: false,
                textColor: ColorResources.gray,
                svgIconColor: ColorResources.gray,
                buttonColor: ColorResources.lgColor,
                borderColor: ColorResources.lgColor,
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
          child: CustomButton(
            width: size.width * .9,
            height: 50,
            title: "continue".tr,
            onTap: () {
              Get.to(() => const CompanyAccountInfoScreen());
            },
          ),
        ),
      ),
    );
  }
}
