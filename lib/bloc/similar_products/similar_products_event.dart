part of 'similar_products_bloc.dart';

sealed class SimilarProductsEvent extends Equatable {
  const SimilarProductsEvent();

  @override
  List<Object> get props => [];
}

class GetSimilarProducts extends SimilarProductsEvent {
  final String productId;
  final int currentPage;
  const GetSimilarProducts(
      {required this.productId, required this.currentPage});

  @override
  List<Object> get props => [productId, currentPage];
}

class ToggleSimilarProductFavorite extends SimilarProductsEvent {
  final BuildContext context;
  final int productId;
  const ToggleSimilarProductFavorite(
      {required this.context, required this.productId});

  @override
  List<Object> get props => [context, productId];
}
