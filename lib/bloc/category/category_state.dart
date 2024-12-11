part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final bool isLoading;
  final List<CategoriesItem> categoryItem;
  final List<CategoriesItem> categoryItemFilter;
  final List<CategoriesItem> singleCategoryItem;
  final List<CategoriesItem> filterCategories;
  const CategoryState({
    this.isLoading = false,
    this.categoryItem = const [],
    this.categoryItemFilter = const [],
    this.singleCategoryItem = const [],
    this.filterCategories = const [],
  });

  CategoryState copyWith({
    bool? isLoading,
    List<CategoriesItem>? categoryItem,
    List<CategoriesItem>? categoryItemFilter,
    List<CategoriesItem>? singleCategoryItem,
    List<CategoriesItem>? filterCategories,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      categoryItem: categoryItem ?? this.categoryItem,
      categoryItemFilter: categoryItemFilter ?? this.categoryItemFilter,
      singleCategoryItem: singleCategoryItem ?? this.singleCategoryItem,
      filterCategories: filterCategories ?? this.filterCategories,
    );
  }

  bool isFilterSelectedCategory(CategoriesItem category) {
    return filterCategories.contains(category);
  }

  @override
  List<Object> get props => [isLoading, categoryItem, categoryItemFilter, singleCategoryItem, filterCategories];
}

// final class CategoryInitial extends CategoryState {}
