part of 'my_products_bloc.dart';

sealed class MyProductsEvent extends Equatable {
  const MyProductsEvent();

  @override
  List<Object> get props => [];
}

class GetMyProducts extends MyProductsEvent {
  final int page;
  final String orderBy;
  final String direction;

  const GetMyProducts(
      {this.page = 1, this.orderBy = 'date', this.direction = 'desc'});

  @override
  List<Object> get props => [page, orderBy, direction];
}
