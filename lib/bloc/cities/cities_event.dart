part of 'cities_bloc.dart';

sealed class CitiesEvent extends Equatable {
  const CitiesEvent();

  @override
  List<Object> get props => [];
}

class GetCitites extends CitiesEvent {
  final int pageSize;
  final bool reload;
  const GetCitites(this.pageSize, this.reload);

  @override
  List<Object> get props => [pageSize, reload];
}

class ShowBottomLoader extends CitiesEvent {}

class ChangeCity extends CitiesEvent {
  final String id;
  final String name;
  const ChangeCity(this.id, this.name);

  @override
  List<Object> get props => [id, name];
}
