part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final bool isLoading;
  final List<CategoryItem> categoryItem;
  final List<CategoryItem> categoryItemFilter;
  final List<CategoryItem> singleCategoryItem;
  final List<CategoryItem> filterCategories;
  final bool isLoadingMore;
  final int categoryCurrentPage;
  final int categoryPageSize;
  const CategoryState({
    this.isLoading = false,
    this.categoryItem = const [],
    this.categoryItemFilter = const [],
    this.singleCategoryItem = const [],
    this.filterCategories = const [],
    this.isLoadingMore = false,
    this.categoryCurrentPage = 1,
    this.categoryPageSize = 1,
  });

  CategoryState copyWith({
    bool? isLoading,
    List<CategoryItem>? categoryItem,
    List<CategoryItem>? categoryItemFilter,
    List<CategoryItem>? singleCategoryItem,
    List<CategoryItem>? filterCategories,
    bool? isLoadingMore,
    int? categoryCurrentPage,
    int? categoryPageSize,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      categoryItem: categoryItem ?? this.categoryItem,
      categoryItemFilter: categoryItemFilter ?? this.categoryItemFilter,
      singleCategoryItem: singleCategoryItem ?? this.singleCategoryItem,
      filterCategories: filterCategories ?? this.filterCategories,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      categoryCurrentPage: categoryCurrentPage ?? this.categoryCurrentPage,
      categoryPageSize: categoryPageSize ?? this.categoryPageSize,
    );
  }

  bool isFilterSelectedCategory(CategoryItem category) {
    return filterCategories.contains(category);
  }

  @override
  List<Object> get props => [
        isLoading,
        categoryItem,
        categoryItemFilter,
        singleCategoryItem,
        filterCategories,
        isLoadingMore,
        categoryCurrentPage,
        categoryPageSize,
      ];
}

// final class CategoryInitial extends CategoryState {}
