import 'package:el_biz/data/repo/category_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/category/category_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepo categoryRepo;
  CategoryBloc(this.categoryRepo) : super(const CategoryState()) {
    on<UpdateFilterSelectedCategory>(_updateFilterSelectedCategory);
    on<GetCategory>(_fetchCategory);
    on<GetCategoryFilter>(_getCategoryFilter);
    on<AddSingleCat>(
      (event, emit) {
        final updatedList = List<CategoriesItem>.from(state.singleCategoryItem)..add(event.singleCategory);
        emit(state.copyWith(singleCategoryItem: updatedList));
      },
    );
  }
  void _updateFilterSelectedCategory(UpdateFilterSelectedCategory event, Emitter<CategoryState> emit) {
    final updatedCategories = List<CategoriesItem>.from(state.filterCategories);
    bool isPresent = updatedCategories.any(
      (item) => item.id == event.category.id && item.name == event.category.name,
    );
    if (isPresent) {
      updatedCategories.removeWhere(
        (item) => item.id == event.category.id && item.name == event.category.name,
      );
    } else {
      updatedCategories.add(event.category);
    }
    emit(state.copyWith(filterCategories: updatedCategories));
  }

  void _fetchCategory(CategoryEvent event, Emitter<CategoryState> emit) async {
    if (state.categoryItem.isEmpty) {
      emit(state.copyWith(isLoading: true));
    }

    try {
      final response = await categoryRepo.getCategory();
      if (response.statusCode == 200) {
        final categoryItems = CategoryListModel.fromJson(response.body).data.items;
        emit(state.copyWith(
          categoryItem: categoryItems,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      print('Error fetching categories: $e');
      emit(state.copyWith(isLoading: false));
    }
  }

  void _getCategoryFilter(CategoryEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final response = await categoryRepo.getCategoryFilter();
      if (response.statusCode == 200) {
        final categoryItemFilter = CategoryListModel.fromJson(response.body).data.items;
        emit(state.copyWith(
          categoryItemFilter: categoryItemFilter,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      print('Error fetching category filter: $e');
      emit(state.copyWith(isLoading: false));
    }
  }

  // void _addSingleCategory(CategoryEvent event, Emitter<CategoryState> emit) {
  //   final updatedList = List<CategoriesItem>.from(state.singleCategoryItem)..add(event.singleCategory);
  //   emit(state.copyWith(singleCategoryItem: updatedList));
  // }
}
