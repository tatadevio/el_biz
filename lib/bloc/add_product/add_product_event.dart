part of 'add_product_bloc.dart';

sealed class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object> get props => [];
}

class AddProduct extends AddProductEvent {
  final AddProductModel addProductModel;
  const AddProduct({required this.addProductModel});

  @override
  List<Object> get props => [addProductModel];
}
