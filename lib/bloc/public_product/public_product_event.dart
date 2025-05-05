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
