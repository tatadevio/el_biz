import 'package:el_biz/bloc/auth/auth_bloc.dart';
import 'package:el_biz/view/screen/auth/password_screen.dart';
import 'package:el_biz/view/screen/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../bloc/config/config_bloc.dart';
import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';
import '../settings/privacy_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextEditingController _controller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool terms = false;
  final FocusNode phoneFocus = FocusNode();
  String phoneNumber = "";

  // KeyboardActionsConfig _buildConfig(BuildContext context) {
  //   return KeyboardActionsConfig(
  //     keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
  //     keyboardBarColor: Colors.grey[200],
  //     nextFocus: true,
  //     defaultDoneWidget: Text("next".tr),
  //     actions: [
  //       if (GetPlatform.isIOS) KeyboardActionsItem(displayArrows: false, displayDoneButton: true, focusNode: _nodeText1),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.sizeOf(context).height;
    // var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Stack(
            children: [
              Column(
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
                        'login_to_your_personal_account'.tr,
                        style: h24,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Enter_your_phone_number_to_receive_an_authorization_code'
                            .tr,
                        textAlign: TextAlign.center,
                        style: body14,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'phone_number'.tr,
                            style: body14,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        // height: 64,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 6),
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
                                      authState.countryCode,
                                      style: body16,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: TextFormField(
                                      maxLength: 10,
                                      controller: phoneController,
                                      focusNode: phoneFocus,
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
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.zero,
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.zero,
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.zero,
                                            borderSide: BorderSide(
                                                color: Colors.white)),
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
                      InkWell(
                        onTap: () {
                          print(
                              'this is phone number : ${authState.countryCode + phoneController.text}');
                          // context.read<AuthBloc>().add(PhoneAuthentication(
                          //       authState.countryCode + phoneController.text,
                          //     ));
                          // PhoneAuthentication
                          // if (phoneController.text.isEmpty || phoneController.text.length < 9) {
                          //   showShortToast("Please enter correct phone number");
                          //   return;
                          // }
                          // if (!terms) {
                          //   showShortToast("Accept terms and condition".tr);
                          //   return;
                          // }

                          // if (!authState.isLoading) {
                          //   authState.phoneAuthentication(authState.countryCode + phoneController.text, "1");
                          // } else {
                          //   showShortToast("invalid_phone_number".tr);
                          // }
                          Get.to(() => PasswordScreen(
                                phoneNumber: phoneController.text,
                              ));
                          // Get.to(
                          //   () => OtpScreen(phone: phoneController.text, type: ''),
                          // );
                        },
                        child: Container(
                          width: Get.width * 0.9,
                          height: 48,
                          decoration: BoxDecoration(
                              color: ColorResources.blue,
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(16, 24, 40, 0.05),
                                    blurRadius: 2,
                                    spreadRadius: 0,
                                    offset: Offset(0, 1)),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "continue".tr,
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
                        height: 20,
                      ),
                      CheckboxListTile(
                        value: terms,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: ColorResources.primary,
                        onChanged: (value) {
                          setState(() {
                            terms = !terms;
                          });
                        },
                        title: InkWell(
                          onTap: () {
                            context.read<ConfigBloc>().add(GetPrivacy());
                            // Get.find<ConfigController>().getPrivacy();
                            Get.to(() => const Privacy());
                          },
                          child: Text(
                            'i_agree_to_the_terms_of_use_and_privacy_policy'.tr,
                            style:
                                body14.copyWith(color: ColorResources.darkGray),
                          ),
                        ),
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
              if (authState.isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        );
      }),
    );
  }
}
