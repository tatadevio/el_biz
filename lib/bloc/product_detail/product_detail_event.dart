part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class ToggleShowProductReview extends ProductDetailEvent {
  final bool isShowReview;
  const ToggleShowProductReview(this.isShowReview);

  @override
  List<Object> get props => [isShowReview];
}
