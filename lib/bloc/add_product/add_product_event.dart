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

class SelectCategory extends AddProductEvent {
  final CategoryItem category;
  const SelectCategory({required this.category});

  @override
  List<Object> get props => [category];
}

class SelectMaterial extends AddProductEvent {
  final MaterialItem materialItem;
  const SelectMaterial(this.materialItem);

  @override
  List<Object> get props => [materialItem];
}
