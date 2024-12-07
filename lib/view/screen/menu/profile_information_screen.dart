import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/appConstant.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  State<ProfileInformationScreen> createState() => _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController familyNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Личные данные',
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Заполните личные данные',
                style: body14.copyWith(color: ColorResources.gray),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField1(
                controller: nameController,
                hintColor: 'Имя',
                inputType: TextInputType.name,
                lableText: 'Имя',
                leading: '',
                readOnly: false,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField1(
                controller: familyNameController,
                hintColor: 'Фамилия',
                inputType: TextInputType.name,
                lableText: 'Фамилия',
                leading: '',
                readOnly: false,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField1(
                controller: emailController,
                hintColor: 'Адрес электронной почты',
                inputType: TextInputType.emailAddress,
                lableText: 'Адрес электронной почты',
                leading: Images.svgMail,
                readOnly: false,
              ),
              const SizedBox(
                height: 10,
              ),
              // CustomTextField1(
              //   controller: nameController,
              //   hintColor: 'Фамилия',
              //   inputType: TextInputType.number,
              //   lableText: 'Фамилия',
              //   leading: Images.svgFlag,
              //   readOnly: false,
              // ),
              Text(
                'Номер телефона',
                style: body14,
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
                        crossAxisAlignment: CrossAxisAlignment.center, // Aligns both text and input in the center
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

                                contentPadding: EdgeInsets.symmetric(vertical: 5), // Adjust vertical padding as needed
                                border: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: Colors.white)),
                                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: Colors.white)),
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
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13), color: Colors.white, child: CustomButton(width: Get.width, height: 44, onTap: () {}, title: 'Сохранить изменения'),

        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        //   decoration: BoxDecoration(color: Colors.white),
        // ),
      ),
    );
  }
}
