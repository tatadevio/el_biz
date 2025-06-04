part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool isSearchProducts;
  final bool isLoading;
  final bool isGridView;
  final List<ProductListItem> searchProducts;
  final bool isMoreLoading;
  final int currentPage;
  final int pageSize;
  const SearchState({
    this.isSearchProducts = true,
    this.isLoading = false,
    this.isGridView = true,
    this.isMoreLoading = false,
    this.currentPage = 1,
    this.pageSize = 1,
    this.searchProducts = const [],
  });

  SearchState copyWith({
    bool? isSearchProducts,
    bool? isLoading,
    bool? isMoreLoading,
    int? currentPage,
    int? pageSize,
    List<ProductListItem>? searchProducts,
    bool? isGridView,
  }) {
    return SearchState(
      isSearchProducts: isSearchProducts ?? this.isSearchProducts,
      isLoading: isLoading ?? this.isLoading,
      searchProducts: searchProducts ?? this.searchProducts,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      isGridView: isGridView ?? this.isGridView,
    );
  }

  @override
  List<Object> get props => [
        isSearchProducts,
        isLoading,
        searchProducts,
        isMoreLoading,
        currentPage,
        pageSize,
        isGridView,
      ];
}

// final class SearchInitial extends SearchState {}
