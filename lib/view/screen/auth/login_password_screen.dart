import 'package:el_biz/bloc/auth/auth_bloc.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';
import '../../base/custom_dialog.dart';
import '../../base/custom_textfield.dart';
import '../../base/custom_toast.dart';

class LoginPasswordScreen extends StatefulWidget {
  final String phone;
  const LoginPasswordScreen({super.key, required this.phone});

  @override
  State<LoginPasswordScreen> createState() => _LoginPasswordScreenState();
}

class _LoginPasswordScreenState extends State<LoginPasswordScreen> {
  // TextEditingController textEditingController = TextEditingController();
  // var onTapRecognizer;
  // late Timer timer;
  // int seconds = 60;

  // StreamController<ErrorAnimationType> errorController =
  //     StreamController<ErrorAnimationType>();

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();

  // @override
  // void initState() {
  //   print("i am coming herer");

  //   super.initState();
  //   timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     widget.secondsNotifier.value -= 1;
  //     if (widget.secondsNotifier.value < 1) {
  //       timer.cancel();
  //       print("cancel notifier..");
  //     }
  //   });
  // }

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
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Введите пароль".tr,
                            style: h24,
                          ),
                        ),
                        // SizedBox(
                        //   width: Get.width * 0.8,
                        //   child: Text(
                        //     "an_authorization_code_has_been_sent_to_your_phone_number"
                        //         .tr,
                        //     style: body14,
                        //     textAlign: TextAlign.center,
                        //   ).paddingOnly(
                        //     top: 10,
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 5),
                            child:
                                // here need to add the password field
                                CustomTextField1(
                              controller: passwordController,
                              lableText: 'password'.tr,
                              hintColor: '',
                              inputType: TextInputType.visiblePassword,
                              leading: '',
                              readOnly: false,
                              isObsureText: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        InkWell(
                          onTap: () {
                            if (passwordController.text.isEmpty) {
                              showCustomSnackBar(
                                  "Пожалуйста, введите пароль".tr);
                              return;
                            }

                            context.read<AuthBloc>().add(Login(widget.phone,
                                passwordController.text, context));
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
                                    "Войти".tr,
                                    style: button16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.dialog(CustomDialog(
                                widget: AlertDialog(
                              backgroundColor: Colors.white,
                              title: Row(
                                children: [
                                  Container(
                                    height: 48,
                                    width: 48,
                                    decoration: const BoxDecoration(
                                        color: ColorResources.lightBlue,
                                        shape: BoxShape.circle),
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(Images.svgMail),
                                  ),
                                ],
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${"Забыли пароль".tr}?',
                                    style: h16.copyWith(
                                      color:
                                          const Color.fromRGBO(16, 24, 40, 1),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'На ваш номер телефона был отправлен одноразовый СМС код ',
                                    style: body14,
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: Get.width,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MaterialButton(
                                          elevation: 0,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                          onPressed: () async {
                                            Get.back();
                                            context
                                                .read<AuthBloc>()
                                                .add(SendOtp(widget.phone));
                                          },
                                          color: ColorResources.primary,
                                          child: Text(
                                            "Продолжить".tr,
                                            style: const TextStyle(
                                                letterSpacing: 0.5,
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )));
                          },
                          child: Text('Забыли пароль?',
                              style: body14.copyWith(
                                  decoration: TextDecoration.underline)),
                        ),
                      ],
                    ),
                  ],
                ),
                if (authState.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          );
        }));
  }
}
