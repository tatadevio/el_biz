part of 'localization_bloc.dart';

sealed class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class SetLanguage extends LocalizationEvent {
  final Locale locale;
  final bool fromMenu;
  const SetLanguage(this.locale, this.fromMenu);

  @override
  List<Object> get props => [locale, fromMenu];
}

class LoadCurrentLanguage extends LocalizationEvent {}

class SaveLanguage extends LocalizationEvent {
  final Locale locale;
  final bool fromMenu;
  const SaveLanguage(this.locale, this.fromMenu);

  @override
  List<Object> get props => [locale, fromMenu];
}

class SearchLanguage extends LocalizationEvent {
  final String query;
  const SearchLanguage(this.query);

  @override
  List<Object> get props => [query];
}

class SetSelectIndex extends LocalizationEvent {
  final int index;
  const SetSelectIndex(this.index);

  @override
  List<Object> get props => [index];
}
