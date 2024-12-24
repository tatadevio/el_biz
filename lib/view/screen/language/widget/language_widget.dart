import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../bloc/category/category_bloc.dart';
import '../../../../bloc/localization/localization_bloc.dart';
import '../../../../data/model/base/language_model.dart';
import '../../../../utils/appConstant.dart';
import '../../../../utils/color_resources.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  // final LocalizationBloc localizationController;
  final int index;
  final bool fromMenu;
  const LanguageWidget({
    super.key,
    required this.languageModel,
    // required this.localizationController,
    required this.index,
    required this.fromMenu,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, state) {
        return Column(
          children: [
            ListTile(
              onTap: () async {
                final SharedPreferences preferences = await SharedPreferences.getInstance();
                preferences.setBool("new", false);

                if (state.selectedIndex != index) {
                  context.read<LocalizationBloc>().add(SetLanguage(
                      Locale(
                        AppConstants.languages[index].languageCode,
                        AppConstants.languages[index].countryCode,
                      ),
                      fromMenu));
                  // state.setLanguage(
                  //   );
                  if (fromMenu) {
                    context.read<CategoryBloc>().add(GetCategory());
                    context.read<CategoryBloc>().add(GetCategoryFilter());
                  }
                  // state.setSelectIndex(index);
                  context.read<LocalizationBloc>().add(SetSelectIndex(index));
                  Get.back();
                } else {
                  Get.back();
                }
              },
              title: Center(
                child: Text(languageModel.languageName, style: TextStyle(fontSize: 18, color: state.selectedIndex == index ? ColorResources.primary : Colors.black, fontWeight: FontWeight.w500)),
              ),
              dense: true,
            ),
            Divider(
              thickness: 1,
            )
          ],
        );
      },
    );
  }
}
