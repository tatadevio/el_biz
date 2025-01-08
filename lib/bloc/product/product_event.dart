part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class UpdateGridView extends ProductEvent {
  final bool gridView;
  const UpdateGridView(this.gridView);

  @override
  List<Object> get props => [gridView];
}

class UpdateShowCategories extends ProductEvent {
  final bool showCategories;
  const UpdateShowCategories(this.showCategories);

  @override
  List<Object> get props => [showCategories];
}

class UpdateKeywordSelected extends ProductEvent {
  final String keyword;
  const UpdateKeywordSelected(this.keyword);

  @override
  List<Object> get props => [keyword];
}

class UpdateMaterialSelected extends ProductEvent {
  final String material;
  const UpdateMaterialSelected(this.material);

  @override
  List<Object> get props => [material];
}

class PickImageDocs extends ProductEvent {}

class PickImageDocsCamera extends ProductEvent {}

class RemoveGallery extends ProductEvent {
  final XFile image;
  const RemoveGallery(this.image);

  @override
  List<Object> get props => [image];
}

class GetProductWithCat extends ProductEvent {
  final String id;
  final String name;
  const GetProductWithCat(this.id, this.name);

  @override
  List<Object> get props => [id, name];
}

class ChangeCityId extends ProductEvent {
  final String id;
  final String name;
  const ChangeCityId(this.id, this.name);

  @override
  List<Object> get props => [id, name];
}

class UpdateNameId extends ProductEvent {
  final String id;
  final String name;
  final bool callProduct;
  const UpdateNameId(this.id, this.name, {this.callProduct = false});

  @override
  List<Object> get props => [id, name, callProduct];
}

class SetSortType extends ProductEvent {
  final String id;
  const SetSortType(this.id);

  @override
  List<Object> get props => [id];
}

class AddProductFilterCategory extends ProductEvent {
  final CategoriesItem categoryItem;
  const AddProductFilterCategory(this.categoryItem);

  @override
  List<Object> get props => [categoryItem];
}

class RemoveFilterCategory extends ProductEvent {
  final CategoriesItem categoryItem;
  const RemoveFilterCategory(this.categoryItem);

  @override
  List<Object> get props => [categoryItem];
}

class ChangeCurrency extends ProductEvent {
  final String currency;
  const ChangeCurrency(this.currency);

  @override
  List<Object> get props => [currency];
}

class ChangeSlectedProduct extends ProductEvent {
  final int productId;
  const ChangeSlectedProduct(this.productId);

  @override
  List<Object> get props => [productId];
}

class ClearSelectedProduct extends ProductEvent {}
