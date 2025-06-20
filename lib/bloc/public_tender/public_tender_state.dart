part of 'public_tender_bloc.dart';

class PublicTenderState extends Equatable {
  final bool isLoading;
  final List<TenderItem> publicTenders;
  final List<TenderItem> filterTenders;
  final bool isMoreLoading;
  final int tenderCurrentPage;
  final int tenderPageSize;
  final int filterTenderCurrentPage;
  final int filterTenderPageSize;
  final bool isFilterEnable;
  final TenderFilterValuesModel? tenderFilterValuesModel;

  const PublicTenderState({
    this.isLoading = false,
    this.publicTenders = const [],
    this.filterTenders = const [],
    this.isMoreLoading = false,
    this.tenderCurrentPage = 1,
    this.tenderPageSize = 1,
    this.filterTenderCurrentPage = 1,
    this.filterTenderPageSize = 1,
    this.isFilterEnable = false,
    this.tenderFilterValuesModel,
  });

  PublicTenderState copyWith({
    bool? isLoading,
    List<TenderItem>? publicTenders,
    List<TenderItem>? filterTenders,
    bool? isMoreLoading,
    int? tenderCurrentPage,
    int? tenderPageSize,
    int? filterTenderCurrentPage,
    int? filterTenderPageSize,
    bool? isFilterEnable,
    TenderFilterValuesModel? tenderFilterValuesModel,
  }) {
    return PublicTenderState(
      isLoading: isLoading ?? this.isLoading,
      publicTenders: publicTenders ?? this.publicTenders,
      filterTenders: filterTenders ?? this.filterTenders,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      tenderCurrentPage: tenderCurrentPage ?? this.tenderCurrentPage,
      tenderPageSize: tenderPageSize ?? this.tenderPageSize,
      filterTenderCurrentPage:
          filterTenderCurrentPage ?? this.filterTenderCurrentPage,
      filterTenderPageSize: filterTenderPageSize ?? this.filterTenderPageSize,
      isFilterEnable: isFilterEnable ?? this.isFilterEnable,
      tenderFilterValuesModel:
          tenderFilterValuesModel ?? this.tenderFilterValuesModel,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        publicTenders,
        filterTenders,
        isMoreLoading,
        tenderCurrentPage,
        tenderPageSize,
        filterTenderCurrentPage,
        filterTenderPageSize,
        isFilterEnable,
        tenderFilterValuesModel,
      ];
}

final class PublicTenderInitial extends PublicTenderState {}
