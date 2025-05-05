part of 'product_detail_bloc.dart';

class ProductDetailState extends Equatable {
  final bool isLoading;
  final bool showProductReviews;
  final ProductDetailModel? productDetailModel;

  const ProductDetailState({
    this.isLoading = false,
    this.showProductReviews = false,
    this.productDetailModel,
  });

  ProductDetailState copywith({
    bool? isLoading,
    bool? showProductReviews,
    ProductDetailModel? productDetailModel,
  }) {
    return ProductDetailState(
      isLoading: isLoading ?? this.isLoading,
      showProductReviews: showProductReviews ?? this.showProductReviews,
      productDetailModel: productDetailModel ?? this.productDetailModel,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        showProductReviews,
        productDetailModel!,
      ];
}

final class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoader extends ProductDetailState {}

class ProductDetailSuccess extends ProductDetailState {
  final ProductDetailModel productDetailModel;
  const ProductDetailSuccess(this.productDetailModel);
}

class ProductDetailError extends ProductDetailState {
  final String error;
  const ProductDetailError(this.error);
}
