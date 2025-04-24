import 'dart:async';
import 'package:el_biz/bloc/auth/auth_bloc.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../utils/color_resources.dart';
import 'change_password_screen.dart';

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

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

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
        body: BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
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
                        "enter_sms_code".tr,
                        style: h24,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.8,
                      child: Text(
                        "an_authorization_code_has_been_sent_to_your_phone_number"
                            .tr,
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 5),
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
                            animationDuration:
                                const Duration(milliseconds: 300),
                            textStyle:
                                const TextStyle(fontSize: 20, height: 1.6),
                            // backgroundColor: Colors.white,
                            errorAnimationController: errorController,
                            controller: textEditingController,
                            keyboardType: TextInputType.number,

                            onCompleted: (value) async {
                              // final SharedPreferences _prefer = await SharedPreferences.getInstance();
                              setState(() {
                                currentText = value;
                              });

                              context.read<AuthBloc>().add(VerifyOtp(
                                    widget.type,
                                    widget.phone,
                                        
                                    currentText,
                                  ));

                              // Get.offAll(() => const ChangePasswordScreen());
                              // context
                              //     .read<AuthBloc>()
                              //     .add(VerifyOTP(widget.type, currentText));
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
                    ValueListenableBuilder(
                      valueListenable: widget.secondsNotifier,
                      builder: (ctx, seconds, _) => Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: (widget.secondsNotifier.value == 0)
                              ? ColorResources.blue
                              : ColorResources.lgColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: (Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              (widget.secondsNotifier.value == 0)
                                  ? 'resend_code'.tr
                                  : '${"resend_code".tr} $seconds sec',
                              style: button16.copyWith(
                                  color: (widget.secondsNotifier.value == 0)
                                      ? Colors.white
                                      : ColorResources.gray),
                            ),
                          ],
                        )),
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
                //               //   authState.updateOtpLoading(true);
                //               //   authState
                //               //       .phoneAuthentication(widget.phone, "1")
                //               //       .then((value) {
                //               //     authState.updateOtpLoading(false);
                //               //     /*authState.verifyOtp(textEditingController.text,context).then((value) {
                //               //     if(value){
                //               //       authState.loginWithOtp();
                //               //     }else{
                //               //       showShortToast("enter_correct_otp".tr);
                //               //       authState.updateOtpLoading(false);
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
                // if (authState.isOtpLoading) const CircularProgressIndicator(),
              ],
            ),
          );
        }));
  }
}
