import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/view/screen/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controller/auth_controller.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

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
                  SvgPicture.asset(Images.done),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Пароль успешно обновлён!',
                    textAlign: TextAlign.center,
                    style: h24,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Ваш пароль был успешно обновлён, запомните или сохраните новый пароль',
                    style: body14,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const DashboardScreen());
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
                              "Готово".tr,
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
