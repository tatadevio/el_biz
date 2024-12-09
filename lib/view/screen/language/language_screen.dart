import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/localization_controller.dart';
import 'widget/language_widget.dart';

class ChooseLanguageScreen extends StatefulWidget {
  final bool fromMenu;
  const ChooseLanguageScreen({super.key, required this.fromMenu});

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(builder: (localizationController) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          SizedBox(height: MediaQuery.of(context).size.height / 2.8),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
            child: Center(
              child: Center(
                  child: SizedBox(
                // width: 1170,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Column(
                      //mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /*Center(child: Image.asset(Images.logo, width: 100)),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),*/
                        //Center(child: Image.asset(Images.logo_name, width: 100)),

                        /*Container(

                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                              color: ColorResources.primary,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.0),topRight: Radius.circular(12.0))
                          ),
                          child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Image.asset(Images.language,color: Colors.white,height: 30,),
                              SizedBox(width: 15,),
                              Text('select_language'.tr,
                                  style: TextStyle(color: Colors.white,fontSize: 20)),
                            ],
                          )),
                        ),*/
                        //Center(child: Text(AppConstants.APP_NAME, style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE))),

                        const SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: localizationController.languages.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => LanguageWidget(languageModel: localizationController.languages[index], localizationController: localizationController, index: index, fromMenu: true),
                          ),
                        ),

                        /*Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,bottom: 12),
                            child: Text('you_can_change_language'.tr, style: TextStyle(
                              fontSize: 16, color: Colors.grey,
                            )),
                          ),
                        ),*/
                      ]),
                ),
              )),
            ),
          ),
        ]),
      );
    });
  }
}
