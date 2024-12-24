import 'package:el_biz/bloc/localization/localization_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/route_helper.dart';
import '../../../utils/Images.dart';
import '../../../utils/appConstant.dart';
import '../../../utils/color_resources.dart';
import '../../base/custom_button.dart';
import 'language_screen.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({Key? key}) : super(key: key);

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: ColorResources.background,
      body: BlocBuilder<LocalizationBloc, LocalizationState>(builder: (context, localizationController) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: (kIsWeb && width > 600) ? width * 0.1 : 18, vertical: 18),
          // padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              Text(
                "choose_language".tr,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10.0), border: Border.all(color: ColorResources.grey11, width: 0.5)),
                child: ListTile(
                  dense: false,
                  onTap: () {
                    Get.bottomSheet(
                        isScrollControlled: true,
                        const ChooseLanguageScreen(
                          fromMenu: false,
                        ));
                  },
                  leading: Image.asset(
                    Images.language,
                    height: 30,
                  ),
                  title: Text(
                    AppConstants.languages[localizationController.selectedIndex].languageName,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_down_outlined),
                ),
              ),
              SizedBox(
                height: Get.height * 0.045,
              ),
              CustomButton(
                width: Get.width * 0.96,
                height: 52,
                onTap: () async {
                  final SharedPreferences preferences = await SharedPreferences.getInstance();
                  preferences.setBool("new", false);
                  Get.offAllNamed(RouteHelper.getLoginRoute());
                },
                title: 'confirm'.tr,
              )
            ],
          ),
        );
      }),
    );
  }
}
