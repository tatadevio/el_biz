part of 'search_company_bloc.dart';

class SearchCompanyState extends Equatable {
  final bool isLoading;
  final List<CompanyItem> searchProducts;
  final bool isMoreLoading;
  final int currentPage;
  final int pageSize;
  const SearchCompanyState(
      {this.isLoading = false,
      this.isMoreLoading = false,
      this.currentPage = 1,
      this.pageSize = 1,
      this.searchProducts = const []});
  SearchCompanyState copyWith({
    bool? isLoading,
    bool? isMoreLoading,
    int? currentPage,
    int? pageSize,
    List<CompanyItem>? searchProducts,
  }) {
    return SearchCompanyState(
      isLoading: isLoading ?? this.isLoading,
      searchProducts: searchProducts ?? this.searchProducts,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        searchProducts,
        isMoreLoading,
        currentPage,
        pageSize,
      ];
}

final class SearchCompanyInitial extends SearchCompanyState {}
