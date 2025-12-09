part of 'localization_bloc.dart';

class LocalizationState extends Equatable {
  final Locale locale;
  final bool isLtr;
  final int selectedIndex;
  final List<LanguageModel> languages;

  const LocalizationState(
      {required this.locale,
      this.isLtr = true,
      this.selectedIndex = 0,
      this.languages = const []});

  LocalizationState copyWith(
      {Locale? locale, bool? isLtr, int? selectedIndex, languages}) {
    return LocalizationState(
        locale: locale ?? this.locale,
        isLtr: isLtr ?? this.isLtr,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        languages: languages ?? this.languages);
  }

  @override
  List<Object> get props => [locale, isLtr, selectedIndex, languages];
}
