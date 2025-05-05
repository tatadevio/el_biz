part of 'product_review_bloc.dart';

sealed class ProductReviewEvent extends Equatable {
  const ProductReviewEvent();

  @override
  List<Object> get props => [];
}


class GetProductReviews extends ProductReviewEvent {
  final String productId;
  final int currentPage;
  const GetProductReviews(this.productId, this.currentPage);

  @override
  List<Object> get props => [productId, currentPage];
}

class AddProductReviewReply extends ProductReviewEvent {
  final String reviewId;
  final String reply;
  final int index;
  const AddProductReviewReply(this.reviewId, this.reply, this.index);

  @override
  List<Object> get props => [reviewId, reply, index];
}

class DeleteProductReview extends ProductReviewEvent {
  final String reviewId;
  final String productId;
  const DeleteProductReview(this.reviewId, this.productId);

  @override
  List<Object> get props => [reviewId, productId];
}
