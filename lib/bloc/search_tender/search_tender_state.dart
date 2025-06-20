part of 'search_tender_bloc.dart';

class SearchTenderState extends Equatable {
  final bool isLoading;
  final List<TenderItem> searchTenders;
  final bool isMoreLoading;
  final int currentPage;
  final int pageSize;
  const SearchTenderState({
    this.isLoading = false,
    this.searchTenders = const [],
    this.isMoreLoading = false,
    this.currentPage = 1,
    this.pageSize = 1,
  });
  SearchTenderState copyWith({
    bool? isLoading,
    List<TenderItem>? searchTenders,
    bool? isMoreLoading,
    int? currentPage,
    int? pageSize,
  }) {
    return SearchTenderState(
      isLoading: isLoading ?? this.isLoading,
      searchTenders: searchTenders ?? this.searchTenders,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        searchTenders,
        isMoreLoading,
        currentPage,
        pageSize,
      ];
}

final class SearchTenderInitial extends SearchTenderState {}
