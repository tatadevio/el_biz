part of 'product_review_bloc.dart';

class ProductReviewState extends Equatable {
  final bool isLoading;
  final List<ProductReviewItem> productReviews;
  final ProductReviewsModel productReviewsModel;
  final bool isMoreLoading;
  final int currentPage;
  final int pageSize;
  const ProductReviewState({
    this.isLoading = false,
    required this.productReviewsModel,
    this.productReviews = const [],
    this.isMoreLoading = false,
    this.currentPage = 1,
    this.pageSize = 1,
  });

  ProductReviewState copyWith({
    bool? isLoading,
    List<ProductReviewItem>? productReviews,
    ProductReviewsModel? productReviewsModel,
    bool? isMoreLoading,
    int? currentPage,
    int? pageSize,
  }) {
    return ProductReviewState(
      isLoading: isLoading ?? this.isLoading,
      productReviews: productReviews ?? this.productReviews,
      productReviewsModel: productReviewsModel ?? this.productReviewsModel,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        productReviews,
        productReviewsModel,
        isMoreLoading,
        currentPage,
        pageSize,
      ];
}

// final class ProductReviewInitial extends ProductReviewState {}
