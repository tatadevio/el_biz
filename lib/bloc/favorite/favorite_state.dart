part of 'favorite_bloc.dart';

class FavoriteState extends Equatable {
  final bool isLoading;
  final bool isShowCategories;
  final bool isShowGridView;
  final List<CompanyProductItem> favoriteProducts;
  final bool isProductsLoadingMore;
  final int productsCurrentPage;
  final int productsPageSize;
  const FavoriteState(
      {this.isLoading = false,
      this.isShowCategories = false,
      this.isShowGridView = true,
      this.favoriteProducts = const [],
      this.isProductsLoadingMore = false,
      this.productsCurrentPage = 1,
      this.productsPageSize = 1});

  FavoriteState copyWith({
    bool? isLoading,
    bool? isShowCategories,
    bool? isShowGridView,
    List<CompanyProductItem>? favoriteProducts,
    bool? isProductsLoadingMore,
    int? productsCurrentPage,
    int? productsPageSize,
  }) {
    return FavoriteState(
      isLoading: isLoading ?? this.isLoading,
      isShowCategories: isShowCategories ?? this.isShowCategories,
      isShowGridView: isShowGridView ?? this.isShowGridView,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      isProductsLoadingMore:
          isProductsLoadingMore ?? this.isProductsLoadingMore,
      productsCurrentPage: productsCurrentPage ?? this.productsCurrentPage,
      productsPageSize: productsPageSize ?? this.productsPageSize,
    );
  }

  @override
  List<Object> get props =>
      [isLoading, isShowCategories, isShowGridView, favoriteProducts];
}

final class FavoriteInitial extends FavoriteState {}

class FavoriteProductsError extends FavoriteState {
  final String error;
  const FavoriteProductsError(this.error);
}
