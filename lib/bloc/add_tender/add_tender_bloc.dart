import 'package:el_biz/data/model/base/add_tender_model.dart';
import 'package:el_biz/data/model/response/tender/tender_detail_model.dart';
import 'package:el_biz/data/repo/add_tender_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/category/categories_list_model.dart';
import '../../data/model/response/company/my_companies_model.dart';

part 'add_tender_event.dart';
part 'add_tender_state.dart';

class AddTenderBloc extends Bloc<AddTenderEvent, AddTenderState> {
  final AddTenderRepo addTenderRepo;
  AddTenderBloc(this.addTenderRepo)
      : super(AddTenderState(
            isLoading: false, addTenderModel: AddTenderModel())) {
    // on<AddTenderEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<AddNewTender>(_onAddNewTender);
    on<RemoveTenderImage>(_onRemoveTenderImage);
    on<UpdateTenderImages>(_onUpdateTenderImages);
    on<GetCategoryById>(_onGetCategoryById);
    on<SelectCategory>(_onSelectCategory);
    on<UpdateTenderCompany>(_onUpdateTenderCompany);
  }

  Future<void> _onSelectCategory(
      SelectCategory event, Emitter<AddTenderState> emit) async {
    emit(state.copyWith(
        addTenderModel:
            state.addTenderModel?.copyWith(categories: [event.category])));
  }

  Future<void> _onUpdateTenderCompany(
      UpdateTenderCompany event, Emitter<AddTenderState> emit) async {
    print('this is the company data ${event.company.toJson()}');
    emit(state.copyWith(
        addTenderModel:
            state.addTenderModel!.copyWith(selectedCompany: event.company)));
  }

  Future<void> _onAddNewTender(
      AddNewTender event, Emitter<AddTenderState> emit) async {
    // emit()
    emit(AddTenderLoader());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await addTenderRepo.addNewTender(event.addTenderModel);
      if (response.statusCode == 200) {
        emit(AddTenderSuccess());
      } else {
        emit(AddTenderError());
      }
    } catch (e) {
      emit(AddTenderError());
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _onRemoveTenderImage(
      RemoveTenderImage event, Emitter<AddTenderState> emit) async {
    final updatedDeletedImages = List<Media>.from(
      state.addTenderModel!.deleteImages ?? [],
    )..add(event.tenderImage);
    final updatedImages =
        List<Media>.from(state.addTenderModel!.uploadedImages!)
          ..remove(event.tenderImage);

    emit(state.copyWith(
      addTenderModel: state.addTenderModel!.copyWith(
        uploadedImages: updatedImages,
        deleteImages: updatedDeletedImages,
      ),
    ));
  }

  Future<void> _onUpdateTenderImages(
      UpdateTenderImages event, Emitter<AddTenderState> emit) async {
    final updateImages =
        state.addTenderModel!.copyWith(uploadedImages: event.images);
    print('called this on update tender = ${event.images.length}');
    emit(state.copyWith(addTenderModel: updateImages));
  }

  Future<void> _onGetCategoryById(
      GetCategoryById event, Emitter<AddTenderState> emit) async {
    try {
      final response = await addTenderRepo.getCategoryById(event.categoryId);
      if (response.statusCode == 200) {
        final category = CategoryItem.fromJson(response.body['data']);
        final categories =
            List<CategoryItem>.from(state.addTenderModel!.categories ?? [])
              ..add(category);
        emit(state.copyWith(
            addTenderModel:
                state.addTenderModel?.copyWith(categories: categories)));
      }
    } catch (e) {}
  }
}
