import 'package:el_biz/data/repo/category_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/category/categories_list_model.dart';

// import '../../data/model/response/category/category_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepo categoryRepo;
  CategoryBloc(this.categoryRepo) : super(const CategoryState()) {
    on<UpdateFilterSelectedCategory>(_updateFilterSelectedCategory);
    on<GetCategory>(_fetchCategory);

    // on<GetCategoryById>(_onGetCategoryById);
    // on<GetCategoryFilter>(_getCategoryFilter);
    // on<AddSingleCat>(
    //   (event, emit) {
    //     final updatedList = List<CategoriesItem>.from(state.singleCategoryItem)
    //       ..add(event.singleCategory);
    //     emit(state.copyWith(singleCategoryItem: updatedList));
    //   },
    // );
  }
  void _updateFilterSelectedCategory(
      UpdateFilterSelectedCategory event, Emitter<CategoryState> emit) {
    final updatedCategories = List<CategoryItem>.from(state.filterCategories);
    bool isPresent = updatedCategories.any(
      (item) =>
          item.id == event.category.id && item.name == event.category.name,
    );
    if (isPresent) {
      updatedCategories.removeWhere(
        (item) =>
            item.id == event.category.id && item.name == event.category.name,
      );
    } else {
      updatedCategories.add(event.category);
    }
    emit(state.copyWith(filterCategories: updatedCategories));
  }

  void _fetchCategory(GetCategory event, Emitter<CategoryState> emit) async {
    if (state.categoryItem.isEmpty || event.currentPage == 1) {
      emit(state.copyWith(isLoading: true, categoryItem: []));
    } else {
      emit(state.copyWith(isLoadingMore: true));
    }

    try {
      final response = await categoryRepo.getCategory(event.currentPage);

      if (response.statusCode == 200) {
        final categoryItems =
            // CategoryListModel.fromJson(response.body).data.items;
            CategoriesListModel.fromJson(response.body).data?.items;
        // if(event.currentPage == 1) {

        emit(state.copyWith(
          categoryItem: List<CategoryItem>.from(state.categoryItem)
            ..addAll(categoryItems ?? []),
          // categoryItems,
          isLoading: false,
        ));
        // }else {

        // }
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
    emit(state.copyWith(isLoading: false, isLoadingMore: false));
  }

  // Future<void> _onGetCategoryById(GetCategoryById event, Emitter<CategoryState> emit)  async {
  //   try{

  //   }catch(e){

  //   }
  // }
}
