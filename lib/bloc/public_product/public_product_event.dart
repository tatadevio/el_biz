part of 'public_product_bloc.dart';

sealed class PublicProductEvent extends Equatable {
  const PublicProductEvent();

  @override
  List<Object> get props => [];
}

class GetPublicProduct extends PublicProductEvent {
  final int currentPage;
  const GetPublicProduct(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

class RemoveProductFromFavoriteList extends PublicProductEvent {
  final int productId;
  const RemoveProductFromFavoriteList(this.productId);

  @override
  List<Object> get props => [productId];
}

class ToggleFavoritePublicProductInList extends PublicProductEvent {
  final int productId;
  const ToggleFavoritePublicProductInList(this.productId);

  @override
  List<Object> get props => [productId];
}

class ToggleFavoritePublicProduct extends PublicProductEvent {
  final BuildContext context;
  final int productId;
  const ToggleFavoritePublicProduct(this.context, this.productId);

  @override
  List<Object> get props => [context, productId];
}

class UpdateFilterEnable extends PublicProductEvent {
  final bool isEnable;
  const UpdateFilterEnable(this.isEnable);

  @override
  List<Object> get props => [isEnable];
}

class FilterPublicProduct extends PublicProductEvent {
  final ProductFilterValuesModel productFilterValuesModel;
  final int currentPage;
  const FilterPublicProduct({
    required this.productFilterValuesModel,
    required this.currentPage,
  });

  @override
  List<Object> get props => [
        productFilterValuesModel,
        currentPage,
      ];
}
