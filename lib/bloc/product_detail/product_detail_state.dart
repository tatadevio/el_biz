part of 'product_detail_bloc.dart';

class ProductDetailState extends Equatable {
  final bool isLoading;
  final bool showProductReviews;

  const ProductDetailState({this.isLoading = false, this.showProductReviews = false});

  ProductDetailState copywith({bool? isLoading, bool? showProductReviews}) {
    return ProductDetailState(
      isLoading: isLoading ?? this.isLoading,
      showProductReviews: showProductReviews ?? this.showProductReviews,
    );
  }

  @override
  List<Object> get props => [isLoading, showProductReviews];
}

// final class ProductDetailInitial extends ProductDetailState {}
