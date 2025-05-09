part of 'filter_fields_bloc.dart';

class FilterFieldsState extends Equatable {
  final bool isLoading;
  final FilterFieldsModel? filterFieldsModel;
  const FilterFieldsState({this.isLoading = false, this.filterFieldsModel});

  FilterFieldsState copyWith(
      {bool? isLoading, FilterFieldsModel? filterFieldsModel}) {
    return FilterFieldsState(
      isLoading: isLoading ?? this.isLoading,
      filterFieldsModel: filterFieldsModel ?? this.filterFieldsModel,
    );
  }

  @override
  List<Object> get props => [isLoading, filterFieldsModel!];
}

final class FilterFieldsInitial extends FilterFieldsState {
  FilterFieldsInitial()
      : super(isLoading: false, filterFieldsModel: FilterFieldsModel());
}
