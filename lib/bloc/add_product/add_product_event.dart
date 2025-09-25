part of 'add_product_bloc.dart';

sealed class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object> get props => [];
}

class AddProduct extends AddProductEvent {
  final AddProductModel addProductModel;
  final String productFrom;
  const AddProduct({required this.addProductModel, required this.productFrom});

  @override
  List<Object> get props => [addProductModel, productFrom];
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

class RemoveProductImage extends AddProductEvent {
  final ProductDetailImages productImage;
  const RemoveProductImage(this.productImage);

  @override
  List<Object> get props => [productImage];
}

class UpdateProduct extends AddProductEvent {
  final AddProductModel addProductModel;
  final String productId;
  const UpdateProduct(this.addProductModel, this.productId);

  @override
  List<Object> get props => [addProductModel, productId];
}

class DeleteProductImage extends AddProductEvent {
  final String productId;
  final String imageId;

  const DeleteProductImage(this.productId, this.imageId);

  @override
  List<Object> get props => [productId, imageId];
}

class GetCategoryById extends AddProductEvent {
  final String categoryId;
  const GetCategoryById(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

