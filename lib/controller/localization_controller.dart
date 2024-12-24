// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../data/api/api_client.dart';
// import '../data/model/base/language_model.dart';
// import '../utils/appConstant.dart';

// class LocalizationController extends GetxController implements GetxService {
//   final SharedPreferences sharedPreferences;
//   final ApiClient apiClient;

//   LocalizationController({required this.sharedPreferences, required this.apiClient}) {
//     loadCurrentLanguage();
//   }

//   Locale _locale = Locale(AppConstants.languages[0].languageCode, AppConstants.languages[0].countryCode);
//   bool _isLtr = true;
//   List<LanguageModel> _languages = [];

//   Locale get locale => _locale;
//   bool get isLtr => _isLtr;
//   List<LanguageModel> get languages => _languages;

//   void setLanguage(Locale locale, bool fromMenu) {
//     Get.updateLocale(locale);
//     _locale = locale;
//     saveLanguage(_locale, fromMenu);
//     update();
//   }

//   void loadCurrentLanguage() async {
//     _locale = Locale(sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? AppConstants.languages[0].languageCode, sharedPreferences.getString(AppConstants.COUNTRY_CODE) ?? AppConstants.languages[0].countryCode);
//     _isLtr = _locale.languageCode != 'ar';
//     for (int index = 0; index < AppConstants.languages.length; index++) {
//       if (AppConstants.languages[index].languageCode == _locale.languageCode) {
//         _selectedIndex = index;
//         break;
//       }
//     }
//     print("current lang is$_locale");
//     _languages = [];
//     _languages.addAll(AppConstants.languages);
//     update();
//   }

//   void saveLanguage(Locale locale, bool fromMenu) async {
//     String? token = sharedPreferences.getString("token");
//     sharedPreferences.setString(AppConstants.LANGUAGE_CODE, locale.languageCode);
//     String? lang = sharedPreferences.getString(AppConstants.LANGUAGE_CODE);
//     print("lang is $lang");
//     apiClient.updateHeader(token ?? "", lang ?? "ru");
//     bool reload = true;
//     // if (fromMenu) {
//     /// Refreshing application while changing languages
//     ///
//     // context.read<CategoryBloc>().

//     // Get.find<CategoryController>().getCategory();
//     // Get.find<CategoryController>().getCategoryFilter();
//     // }

//     //sharedPreferences.setString(AppConstants.COUNTRY_CODE, locale.countryCode);
//   }

//   int _selectedIndex = 0;

//   int get selectedIndex => _selectedIndex;

//   void setSelectIndex(int index) {
//     _selectedIndex = index;
//     update();
//   }

//   void searchLanguage(String query) {
//     if (query.isEmpty) {
//       _languages = [];
//       _languages = AppConstants.languages;
//     } else {
//       _selectedIndex = -1;
//       _languages = [];
//       AppConstants.languages.forEach((language) async {
//         if (language.languageName.toLowerCase().contains(query.toLowerCase())) {
//           _languages.add(language);
//         }
//       });
//     }
//     update();
//   }
// }
