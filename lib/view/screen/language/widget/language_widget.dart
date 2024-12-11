import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../bloc/category/category_bloc.dart';
import '../../../../controller/localization_controller.dart';
import '../../../../data/model/base/language_model.dart';
import '../../../../utils/appConstant.dart';
import '../../../../utils/color_resources.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;
  final bool fromMenu;
  const LanguageWidget({super.key, required this.languageModel, required this.localizationController, required this.index, required this.fromMenu});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () async {
            final SharedPreferences preferences = await SharedPreferences.getInstance();
            preferences.setBool("new", false);

            if (localizationController.selectedIndex != index) {
              localizationController.setLanguage(
                  Locale(
                    AppConstants.languages[index].languageCode,
                    AppConstants.languages[index].countryCode,
                  ),
                  fromMenu);
              if (fromMenu) {
                context.read<CategoryBloc>().add(GetCategory());
                context.read<CategoryBloc>().add(GetCategoryFilter());
              }
              localizationController.setSelectIndex(index);
              Get.back();
            } else {
              Get.back();
            }
          },
          title: Center(
            child: Text(languageModel.languageName, style: TextStyle(fontSize: 18, color: localizationController.selectedIndex == index ? ColorResources.primary : Colors.black, fontWeight: FontWeight.w500)),
          ),
          dense: true,
        ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
