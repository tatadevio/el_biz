part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final bool isLoading;
  final List<CategoryItem> categoryItem;
  final List<CategoryItem> categoryItemFilter;
  final List<CategoryItem> singleCategoryItem;
  final List<CategoryItem> filterCategories;
  const CategoryState({
    this.isLoading = false,
    this.categoryItem = const [],
    this.categoryItemFilter = const [],
    this.singleCategoryItem = const [],
    this.filterCategories = const [],
  });

  CategoryState copyWith({
    bool? isLoading,
    List<CategoryItem>? categoryItem,
    List<CategoryItem>? categoryItemFilter,
    List<CategoryItem>? singleCategoryItem,
    List<CategoryItem>? filterCategories,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      categoryItem: categoryItem ?? this.categoryItem,
      categoryItemFilter: categoryItemFilter ?? this.categoryItemFilter,
      singleCategoryItem: singleCategoryItem ?? this.singleCategoryItem,
      filterCategories: filterCategories ?? this.filterCategories,
    );
  }

  bool isFilterSelectedCategory(CategoryItem category) {
    return filterCategories.contains(category);
  }

  @override
  List<Object> get props => [isLoading, categoryItem, categoryItemFilter, singleCategoryItem, filterCategories];
}

// final class CategoryInitial extends CategoryState {}
