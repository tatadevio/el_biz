import 'package:el_biz/bloc/auth/auth_bloc.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_dialog.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/auth/otp_screen.dart';
import 'package:el_biz/view/screen/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';

class PasswordScreen extends StatefulWidget {
  final String phoneNumber;
  const PasswordScreen({super.key, required this.phoneNumber});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  // bool terms = false;
  final FocusNode _nodeText1 = FocusNode();
  // String phoneNumber = "";

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
      body: BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 20,
              ),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'enter_your_password'.tr,
                    style: h24,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField1(
                    controller: passwordController,
                    lableText: 'password'.tr,
                    hintColor: '',
                    inputType: TextInputType.visiblePassword,
                    leading: '',
                    readOnly: false,
                    isObsureText: true,
                  ),
                  const SizedBox(
                    height: 20,
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

                      // if (!authState.isLoading) {
                      //   authState.phoneAuthentication(authState.countryCode + passwordController.text, "1");
                      // } else {
                      //   showShortToast("invalid_phone_number".tr);
                      // }
                      // Get.to(() => p);
                      Get.offAll(() => const DashboardScreen());
                    },
                    child: Container(
                      width: Get.width * 0.9,
                      height: 48,
                      decoration: BoxDecoration(color: ColorResources.blue, borderRadius: BorderRadius.circular(12.0), boxShadow: const [
                        BoxShadow(color: Color.fromRGBO(16, 24, 40, 0.05), blurRadius: 2, spreadRadius: 0, offset: Offset(0, 1)),
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "send_code".tr,
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
                  !authState.isLoading
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.dialog(CustomDialog(
                              widget: AlertDialog(
                            content: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(Images.svgMailIcon),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'forgot_your_password'.tr,
                                      style: h16.copyWith(color: ColorResources.titleColor),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'a_one_time_SMS_code_has_been_sent_to_your_phone_number'.tr,
                                      style: body14,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomButton(
                                        width: Get.width,
                                        height: 44,
                                        onTap: () {
                                          Get.to(
                                            () => OtpScreen(phone: widget.phoneNumber, type: ''),
                                          );
                                        },
                                        title: 'continue'.tr),
                                  ],
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: ColorResources.gray,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )));
                        },
                        child: Text(
                          'forgot_your_password'.tr,
                          style: body14.copyWith(color: ColorResources.gray, decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () async {
                  Get.offAll(() => const DashboardScreen());
                  // final SharedPreferences prefers = await SharedPreferences.getInstance();
                  // prefers.clear();
                  // //   prefers.setBool(AppConstants.showLang, false);
                  // HomeScreen.loadData(true);
                  // Get.offAll(() => const DashboardScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "skip".tr,
                      style: button16.copyWith(color: ColorResources.gray),
                    ),
                  ],
                ),
              ).paddingOnly(bottom: 20),
            ],
          ),
        );
      }),
    );
  }
}
