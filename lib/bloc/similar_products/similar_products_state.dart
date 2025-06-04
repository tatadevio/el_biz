part of 'similar_products_bloc.dart';

class SimilarProductsState extends Equatable {
  final bool isLoading;
  final List<ProductListItem> similarProduct;
  final bool isMoreLoading;
  final int currentPage;
  final int pageSize;

  const SimilarProductsState({
    this.isLoading = false,
    this.isMoreLoading = false,
    this.currentPage = 1,
    this.pageSize = 1,
    this.similarProduct = const [],
  });

  SimilarProductsState copyWith({
    bool? isLoading,
    bool? isMoreLoading,
    int? currentPage,
    int? pageSize,
    List<ProductListItem>? similarProduct,
  }) {
    return SimilarProductsState(
      isLoading: isLoading ?? this.isLoading,
      similarProduct: similarProduct ?? this.similarProduct,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        similarProduct,
        isMoreLoading,
        currentPage,
        pageSize,
      ];
}

final class SimilarProductsInitial extends SimilarProductsState {}
