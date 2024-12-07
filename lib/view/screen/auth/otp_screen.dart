import 'dart:async';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/screen/auth/change_password_screen.dart';
import 'package:el_biz/view/screen/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/auth_controller.dart';
import '../../../utils/color_resources.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  final String type;
  final ValueNotifier<int> secondsNotifier = ValueNotifier(60);
  OtpScreen({super.key, required this.phone, required this.type});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController textEditingController = TextEditingController();
  var onTapRecognizer;
  late Timer timer;
  int seconds = 60;

  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    print("i am coming herer");

    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      widget.secondsNotifier.value -= 1;
      if (widget.secondsNotifier.value < 1) {
        timer.cancel();
        print("cancel notifier..");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // var height = Get.height;
    // var width = Get.width;

    return Scaffold(
        //extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: GetBuilder<AuthController>(builder: (authController) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Введите СМС код".tr,
                        style: h24,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.8,
                      child: Text(
                        "На ваш номер телефона был отправлен код для авторизации".tr,
                        style: body14,
                        textAlign: TextAlign.center,
                      ).paddingOnly(
                        top: 10,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                          child: PinCodeTextField(
                            autoFocus: true,
                            appContext: context,
                            pastedTextStyle: TextStyle(
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 4,
                            obscureText: false,
                            obscuringCharacter: '*',
                            animationType: AnimationType.fade,
                            validator: (v) {
                              return hasError ? "" : null;
                            },
                            pinTheme: PinTheme(
                              //inactiveColor: Colors.grey,
                              disabledColor: Colors.grey,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(14),
                              borderWidth: 1,
                              fieldHeight: 48,
                              fieldWidth: 48,
                              activeColor: ColorResources.blue,
                              selectedColor: ColorResources.primary,
                              activeFillColor: Colors.white,
                              errorBorderColor: Colors.red.withOpacity(0.3),
                              inactiveFillColor: ColorResources.lgColor,
                              inactiveColor: Colors.transparent,
                              selectedFillColor: Colors.white,
                            ),
                            enableActiveFill: true,
                            cursorColor: Colors.black,
                            enablePinAutofill: true,
                            animationDuration: const Duration(milliseconds: 300),
                            textStyle: const TextStyle(fontSize: 20, height: 1.6),
                            // backgroundColor: Colors.white,
                            errorAnimationController: errorController,
                            controller: textEditingController,
                            keyboardType: TextInputType.number,

                            onCompleted: (value) async {
                              final SharedPreferences _prefer = await SharedPreferences.getInstance();
                              setState(() {
                                currentText = value;
                              });
                              // authController.verifyOtp(textEditingController.text, context).then((value) {
                              //   if (value) {
                              //     if (widget.type == "1") {
                              //       authController.loginWithOtp().then((value) {
                              //         if (value.isSuccess) {
                              //           showShortToast(value.message);
                              //         } else {
                              //           showShortToast(value.message);
                              //         }
                              //       });
                              //     } else {
                              //       authController.loginWithExisting().then((value) {
                              //         if (value.isSuccess) {
                              //           showShortToast(value.message);
                              //         } else {
                              //           showShortToast(value.message);
                              //         }
                              //       });
                              //     }
                              //   } else {
                              //     showShortToast("enter_correct_otp".tr);
                              //   }
                              // });
                              // Get.offAll(() => EditProfileScreen());
                              Get.offAll(() => ChangePasswordScreen());
                            },
                            // onTap: () {
                            //   print("Pressed");
                            // },
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              print("Allowing to paste $text");

                              return true;
                            },
                          )),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: (widget.secondsNotifier.value == 0) ? ColorResources.blue : ColorResources.lgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(
                          //   'Повторно отправить код 0,15c',
                          //   style: button16.copyWith(color: ColorResources.gray),
                          // ),
                          ValueListenableBuilder(
                            valueListenable: widget.secondsNotifier,
                            builder: (ctx, seconds, _) => (Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Повторно отправить код $seconds sec',
                                  style: button16.copyWith(color: (widget.secondsNotifier.value == 0) ? Colors.white : ColorResources.gray),
                                ),
                              ],
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // ValueListenableBuilder(
                //   valueListenable: widget.secondsNotifier,
                //   builder: (ctx, seconds, _) => (Column(
                //     children: [
                //       Text(
                //         "${"resent_code".tr} $seconds sec",
                //         textAlign: TextAlign.center,
                //         style: const TextStyle(fontSize: 14, color: Colors.black54),
                //       ),
                //       const SizedBox(height: 16),
                //       if (widget.secondsNotifier.value == 0)
                //         SizedBox(
                //           width: MediaQuery.of(context).size.width * 0.8,
                //           child: TextButton(
                //             onPressed: () async {
                //               // try {
                //               //   widget.secondsNotifier.value = 60;
                //               //   timer = Timer.periodic(
                //               //       const Duration(seconds: 1), (timer) {
                //               //     widget.secondsNotifier.value -= 1;
                //               //     if (widget.secondsNotifier.value < 1) {
                //               //       timer.cancel();
                //               //       print("cancel notifier..");
                //               //     }
                //               //   });
                //               //   authController.updateOtpLoading(true);
                //               //   authController
                //               //       .phoneAuthentication(widget.phone, "1")
                //               //       .then((value) {
                //               //     authController.updateOtpLoading(false);
                //               //     /*authController.verifyOtp(textEditingController.text,context).then((value) {
                //               //     if(value){
                //               //       authController.loginWithOtp();
                //               //     }else{
                //               //       showShortToast("enter_correct_otp".tr);
                //               //       authController.updateOtpLoading(false);
                //               //     }
                //               //   });*/
                //               //   });
                //               // } on FirebaseException catch (e) {
                //               //   popUpAlert(context, '', Colors.red,
                //               //       firebaseError: true, code: e.code);
                //               // }
                //             },
                //             child: Text(
                //               "resent_code".tr,
                //               style: const TextStyle(color: Colors.blue, fontSize: 18),
                //             ),
                //           ),
                //         ),
                //       const SizedBox(height: 16),
                //     ],
                //   )),
                // ),
                // const SizedBox(
                //   height: 14,
                // ),
                if (authController.isOtpLoading) const CircularProgressIndicator(),
              ],
            ),
          );
        }));
  }
}
