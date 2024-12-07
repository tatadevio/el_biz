import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/auth/password_changed_screen.dart';
import 'package:el_biz/view/screen/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import '../../../controller/auth_controller.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  // bool terms = false;
  final FocusNode _nodeText1 = FocusNode();
  bool rememberPassword = false;

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      defaultDoneWidget: Text("next".tr),
      actions: [
        if (GetPlatform.isIOS) KeyboardActionsItem(displayArrows: false, displayDoneButton: true, focusNode: _nodeText1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.sizeOf(context).height;
    // var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: GetBuilder<AuthController>(builder: (authController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Установите новый пароль',
                    style: h24,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomTextField1(
                    controller: passwordController,
                    lableText: 'Новый пароль',
                    hintColor: '',
                    inputType: TextInputType.visiblePassword,
                    leading: '',
                    readOnly: false,
                    isObsureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField1(
                    controller: confPasswordController,
                    lableText: 'Повторите новый пароль',
                    hintColor: '',
                    inputType: TextInputType.visiblePassword,
                    leading: '',
                    readOnly: false,
                    isObsureText: true,
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    activeColor: ColorResources.primary,
                    value: rememberPassword,
                    onChanged: (val) {
                      setState(() {
                        rememberPassword = val!;
                      });
                    },
                    title: Text(
                      'Запомнить этот пароль',
                      style: body14.copyWith(color: ColorResources.darkGray),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      // if (passwordController.text.isEmpty || passwordController.text.length < 9) {
                      //   showShortToast("Please enter correct phone number");
                      //   return;
                      // }
                      // if (!terms) {
                      //   showShortToast("Accept terms and condition".tr);
                      //   return;
                      // }

                      // if (!authController.isLoading) {
                      //   authController.phoneAuthentication(authController.countryCode + passwordController.text, "1");
                      // } else {
                      //   showShortToast("invalid_phone_number".tr);
                      // }
                      // Get.to(() => p);
                      Get.to(() => PasswordChangedScreen());
                    },
                    child: Container(
                      width: Get.width * 0.9,
                      height: 48,
                      decoration: BoxDecoration(color: ColorResources.blue, borderRadius: BorderRadius.circular(12.0), boxShadow: [
                        const BoxShadow(color: Color.fromRGBO(16, 24, 40, 0.05), blurRadius: 2, spreadRadius: 0, offset: Offset(0, 1)),
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Сбросить пароль".tr,
                              style: button16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  !authController.isLoading
                      ? const SizedBox()
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
