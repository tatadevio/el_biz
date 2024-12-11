part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class UpdateFilterSelectedCategory extends CategoryEvent {
  final CategoriesItem category;
  const UpdateFilterSelectedCategory(this.category);

  @override
  List<Object> get props => [category];
}

class GetCategory extends CategoryEvent {}

class GetCategoryFilter extends CategoryEvent {}

class AddSingleCat extends CategoryEvent {
  final CategoriesItem singleCategory;
  const AddSingleCat(this.singleCategory);

  @override
  List<Object> get props => [singleCategory];
}
