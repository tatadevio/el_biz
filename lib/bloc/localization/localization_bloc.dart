import 'dart:ui';

import 'package:el_biz/data/api/api_client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/base/language_model.dart';
import '../../utils/appConstant.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;
  LocalizationBloc(this.sharedPreferences, this.apiClient)
      : super(LocalizationState(
          locale: Locale(AppConstants.languages[0].languageCode,
              AppConstants.languages[0].countryCode),
          languages: AppConstants.languages,
        )) {
    on<SetSelectIndex>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });

    on<SetLanguage>((event, emit) {
      Get.updateLocale(event.locale);
      emit(state.copyWith(locale: event.locale));
      add(SaveLanguage(event.locale, event.fromMenu));
    });

    on<LoadCurrentLanguage>((event, emit) {
      // emit(state.copyWith())
      final languageCode =
          sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ??
              AppConstants.languages[0].languageCode;
      final countryCode =
          sharedPreferences.getString(AppConstants.COUNTRY_CODE) ??
              AppConstants.languages[0].countryCode;
      final locale = Locale(languageCode, countryCode);
      final isLtr = languageCode != 'ar';

      int selectedIndex = 0;
      for (int index = 0; index < AppConstants.languages.length; index++) {
        if (AppConstants.languages[index].languageCode == languageCode) {
          selectedIndex = index;
          break;
        }
      }

      emit(state.copyWith(
        locale: locale,
        isLtr: isLtr,
        languages: AppConstants.languages,
        selectedIndex: selectedIndex,
      ));
    });

    on<SaveLanguage>(_onSaveLanguage);
    on<SearchLanguage>(_onSearchLanguage);
  }

  Future<void> _onSaveLanguage(
      SaveLanguage event, Emitter<LocalizationState> emit) async {
    final locale = event.locale;
    final fromMenu = event.fromMenu;

    await sharedPreferences.setString(
        AppConstants.LANGUAGE_CODE, locale.languageCode);

    final String? lang =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE);
    final String? token = sharedPreferences.getString("token");
    apiClient.updateHeader(token ?? "", lang ?? "ru");
    if (fromMenu) {}
    emit(state.copyWith(locale: locale, isLtr: locale.languageCode != 'ar'));
  }

  void _onSearchLanguage(
      SearchLanguage event, Emitter<LocalizationState> emit) {
    final query = event.query;

    if (query.isEmpty) {
      emit(state.copyWith(
        languages: AppConstants.languages,
        // selectedIndex: -1,
      ));
    } else {
      final filteredLanguages = AppConstants.languages
          .where((language) =>
              language.languageName.toLowerCase().contains(query.toLowerCase()))
          .toList();

      emit(state.copyWith(
        languages: filteredLanguages,
        selectedIndex: -1,
      ));
    }
  }
}
