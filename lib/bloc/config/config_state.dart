part of 'config_bloc.dart';

class ConfigState extends Equatable {
  final bool isLoading;
  final PagesModel? privacy;
  final PagesModel? terms;
  final PagesModel? about;
  final int selectedIndex;
  final ConfigModel? configModel;

  const ConfigState({this.isLoading = false, this.privacy, this.terms, this.about, this.selectedIndex = 0, this.configModel});

  ConfigState copywith({bool? isLoading, PagesModel? privacy, PagesModel? terms, PagesModel? about, int? selectedIndex, ConfigModel? configModel}) {
    return ConfigState(
      isLoading: isLoading ?? this.isLoading,
      privacy: privacy ?? this.privacy,
      terms: terms ?? this.terms,
      about: about ?? this.about,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      configModel: configModel ?? this.configModel,
    );
  }

  @override
  // List<Object> get props => [isLoading, privacy!, terms!, about!, selectedIndex, configModel!];
  List<Object> get props => [isLoading, selectedIndex];
}

// final class ConfigInitial extends ConfigState {}
