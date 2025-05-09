part of 'filter_fields_bloc.dart';

sealed class FilterFieldsEvent extends Equatable {
  const FilterFieldsEvent();

  @override
  List<Object> get props => [];
}

class GetFilterFields extends FilterFieldsEvent {}
