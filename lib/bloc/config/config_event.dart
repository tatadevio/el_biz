part of 'config_bloc.dart';

sealed class ConfigEvent extends Equatable {
  const ConfigEvent();

  @override
  List<Object> get props => [];
}

class GetPrivacy extends ConfigEvent {}

class GetTerms extends ConfigEvent {}

class GetAbout extends ConfigEvent {}

class GetConfig extends ConfigEvent {}

class ChangeIndex extends ConfigEvent {
  final int value;
  const ChangeIndex(this.value);

  @override
  List<Object> get props => [value];
}
