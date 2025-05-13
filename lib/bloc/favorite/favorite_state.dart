part of 'favorite_bloc.dart';

class FavoriteState extends Equatable {
  final bool isLoading;
  final bool isShowCategories;
  final bool isShowGridView;
  final List<ProductListItem> favoriteProducts;
  final List<TenderItem> favoriteTenders;
  final bool isProductsLoadingMore;
  final int productsCurrentPage;
  final int productsPageSize;

  const FavoriteState(
      {this.isLoading = false,
      this.isShowCategories = false,
      this.isShowGridView = true,
      this.favoriteProducts = const [],
      this.favoriteTenders = const [],
      this.isProductsLoadingMore = false,
      this.productsCurrentPage = 1,
      this.productsPageSize = 1});

  FavoriteState copyWith({
    bool? isLoading,
    bool? isShowCategories,
    bool? isShowGridView,
    List<ProductListItem>? favoriteProducts,
    List<TenderItem>? favoriteTenders,
    bool? isProductsLoadingMore,
    int? productsCurrentPage,
    int? productsPageSize,
  }) {
    return FavoriteState(
      isLoading: isLoading ?? this.isLoading,
      isShowCategories: isShowCategories ?? this.isShowCategories,
      isShowGridView: isShowGridView ?? this.isShowGridView,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      favoriteTenders: favoriteTenders ?? this.favoriteTenders,
      isProductsLoadingMore:
          isProductsLoadingMore ?? this.isProductsLoadingMore,
      productsCurrentPage: productsCurrentPage ?? this.productsCurrentPage,
      productsPageSize: productsPageSize ?? this.productsPageSize,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isShowCategories,
        isShowGridView,
        favoriteProducts,
        favoriteTenders,
        isProductsLoadingMore,
        productsCurrentPage,
        productsPageSize,
      ];
}

final class FavoriteInitial extends FavoriteState {
  const FavoriteInitial() : super();
}

class FavoriteProductsError extends FavoriteState {
  final String error;
  const FavoriteProductsError(this.error);
}

class FavoriteTendersError extends FavoriteState {
  final String error;
  const FavoriteTendersError(this.error);
}
