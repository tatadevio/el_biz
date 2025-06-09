import 'package:el_biz/bloc/auth/auth_bloc.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';
import '../../base/custom_toast.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();

  bool rememberPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
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
                    'set_a_new_password'.tr,
                    style: h24,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomTextField1(
                    controller: passwordController,
                    lableText: 'new_password'.tr,
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
                    lableText: 'repeat_new_password'.tr,
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
                      'remember_this_password'.tr,
                      style: body14.copyWith(color: ColorResources.darkGray),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if (passwordController.text.isEmpty ||
                          confPasswordController.text.isEmpty) {
                        showCustomSnackBar("Please enter password");
                        return;
                      }
                      context.read<AuthBloc>().add(ChangePassword(
                          passwordController.text,
                          confPasswordController.text, context));
                      // Get.to(() => PasswordChangedScreen());
                    },
                    child: Container(
                      width: Get.width * 0.9,
                      height: 48,
                      decoration: BoxDecoration(
                          color: ColorResources.blue,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            const BoxShadow(
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
                              "reset_password".tr,
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
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
