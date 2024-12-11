import 'package:el_biz/bloc/config/config_bloc.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../settings/privacy_page.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController familyNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool terms = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: Navigator.canPop(context) ? AppBar() : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              Text(
                'Регистрация',
                style: h24,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                'У вас еще нет аккаунта, заполните личные данные',
                style: body14,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              CustomTextField1(controller: nameController, hintColor: 'Имя', lableText: 'Имя', inputType: TextInputType.name, leading: '', readOnly: false),
              SizedBox(
                height: height * 0.03,
              ),
              CustomTextField1(controller: familyNameController, hintColor: 'Фамилия', lableText: 'Фамилия', inputType: TextInputType.name, leading: '', readOnly: false),
              SizedBox(
                height: height * 0.03,
              ),
              CustomTextField1(
                controller: emailController,
                hintColor: 'Адрес электронной почты',
                lableText: 'Адрес электронной почты',
                inputType: TextInputType.emailAddress,
                leading: '',
                readOnly: false,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              CustomTextField1(
                controller: passwordController,
                hintColor: 'Пароль',
                lableText: 'Пароль',
                inputType: TextInputType.visiblePassword,
                leading: '',
                readOnly: false,
                isObsureText: true,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              CheckboxListTile(
                value: terms,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: ColorResources.primary,
                onChanged: (value) {
                  setState(() {
                    terms = !terms;
                  });
                },
                title: InkWell(
                  onTap: () {
                    // Get.find<ConfigController>().getPrivacy();
                    context.read<ConfigBloc>().add(GetPrivacy());
                    Get.to(() => const Privacy());
                  },
                  child: Text(
                    'Я соглашаюсь с условиями пользования \nи политикой конфиденциальности'.tr,
                    style: body14.copyWith(color: ColorResources.darkGray),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              CustomButton(
                width: width * 0.9,
                height: 44,
                onTap: () {
                  Get.offAll(() => const DashboardScreen());
                },
                title: 'Зарегистрироваться',
              ),
              SizedBox(
                height: height * 0.09,
              ),
              Text(
                'skip'.tr,
                style: button16.copyWith(color: ColorResources.gray),
              ),
              SizedBox(
                height: height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
