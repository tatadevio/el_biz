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

class GetProductDetail extends ProductDetailEvent {
  final String productId;
  const GetProductDetail(this.productId);

  @override
  List<Object> get props => [productId];
}

class ToggleProductFavorite extends ProductDetailEvent {
  final BuildContext context;
  const ToggleProductFavorite(this.context);
  // final ProductDetailModel productDetailModel;
  // const ToggleProductFavorite(this.productDetailModel);

  // @override
  List<Object> get props => [context];
}
