import 'dart:io';

import 'package:el_biz/bloc/tenders/tenders_event.dart';
import 'package:el_biz/data/model/base/add_tender_model.dart';
import 'package:el_biz/data/repo/tenders_repo.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/model/response/category/categories_list_model.dart';
import '../../data/model/response/tender/tender_detail_model.dart';
import 'tenders_state.dart';

class TendersBloc extends Bloc<TendersEvent, TendersState> {
  final TendersRepo tendersRepo;
  TendersBloc(this.tendersRepo)
      : super(TendersState(
          newTenderModel: AddTenderModel(),
        )) {
    // add(GetTendersList());
    on<UpdateGridView>(_updateToggleShowGridView);
    on<FetchAllTenders>(_fetchAllTenders);
    on<PickImageDocs>(_onPickImageDocs);
    on<PickImageDocsCamera>(_onPickImageDocsCamera);
    on<RemoveGallery>(_onRemoveImage);
    on<ResetNewTenderModel>((event, emit) {
      emit(state.copywith(
        newTenderModel: AddTenderModel(),
      ));
    });
    //
    on<RemoveTenderImage>(_onRemoveTenderImage);
    on<UpdateTenderImages>(_onUpdateTenderImages);
    on<GetCategoryById>(_onGetCategoryById);
    on<SelectCategory>(_onSelectCategory);
    on<UpdateTenderCompany>(_onUpdateTenderCompany);

    on<ChangeSlectedTender>((event, emit) {
      emit(state.copywith(selectedTender: event.newTender));
    });
    on<ClearSelectedTender>((event, emit) {
      emit(state.copywith(selectedTender: null));
    });
  }

  void _updateToggleShowGridView(
      UpdateGridView event, Emitter<TendersState> emit) {
    emit(state.copywith(isGridView: event.isGridView));
  }

  void _fetchAllTenders(event, emit) async {
    emit(state.copywith(isLoading: true));
    try {
      // final response = await tendersRepo.fetchAllTenders(event.offset);
      // if (response.statusCode == 200) {
      //   print('API response = success');
      // } else {
      //   print('API response = failed');
      // }
    } catch (e) {
      print('Error fetching tenders: $e');
    }
    emit(state.copywith(isLoading: false));
  }

  // Future<void> _onPickImageDocs(
  //   PickImageDocs event,
  //   Emitter<TendersState> emit,
  // ) async {
  //   final picker = ImagePicker();
  //   final List<XFile>? value = await picker.pickMultiImage(maxWidth: 1024);

  //   if (value != null) {
  //     final List<XFile> newImages = [];
  //     for (var file in value) {
  //       final compressedImage = await _convertHEICtoJPG(File(file.path));
  //       newImages.add(compressedImage);
  //     }
  //     emit(TendersState(pickedLogo: [...state.pickedLogo, ...newImages]));
  //   }
  // }
  // Future<void> _onPickImageDocs(
  //   PickImageDocs event,
  //   Emitter<TendersState> emit,
  // ) async {
  //   final picker = ImagePicker();
  //   final List<XFile>? value = await picker.pickMultiImage(maxWidth: 1024);

  //   if (value != null) {
  //     final List<XFile> newImages = [];
  //     for (var file in value) {
  //       final compressedImage = await _convertHEICtoJPG(File(file.path));
  //       newImages.add(compressedImage);
  //     }
  //     // state.newTenderModel.images(newImages);
  //  emit(
  //   TendersState(newTenderModel: state.newTenderModel!.copyWith())
  //  );
  //       emit(CompanyState(
  //         addCompanyModel:
  //             state.addCompanyModel.copyWith(certificateDocument: xFile),
  //       ));

  //     // emit(TendersState(pickedLogo: state.newTenderModel.images ));
  //   }
  // }
  Future<void> _onPickImageDocs(
    PickImageDocs event,
    Emitter<TendersState> emit,
  ) async {
    final picker = ImagePicker();
    final List<XFile>? value = await picker.pickMultiImage(maxWidth: 1024);

    if (value != null) {
      final List<XFile> newImages = [];
      for (var file in value) {
        final compressedImage = await _convertHEICtoJPG(File(file.path));
        newImages.add(compressedImage);
      }

      // Get existing images or initialize a new list
      final updatedImages = [
        ...?state.newTenderModel.images,
        ...newImages,
      ];

      final updatedModel = state.newTenderModel.copyWith(images: updatedImages);
      //  ??
      //     AddTenderModel(images: updatedImages);

      emit(state.copywith(newTenderModel: updatedModel));
    }
  }

  Future<void> _onPickImageDocsCamera(
    PickImageDocsCamera event,
    Emitter<TendersState> emit,
  ) async {
    final picker = ImagePicker();
    final XFile? value =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 1024);

    if (value != null) {
      final compressedImage = await _convertHEICtoJPG(File(value.path));

      List<XFile> updatedImages = [
        ...?state.newTenderModel.images,
        ...[compressedImage],
      ];

      final updatedModel = state.newTenderModel.copyWith(images: updatedImages);

      emit(state.copywith(newTenderModel: updatedModel));
    }
  }

  // void _onRemoveImage(
  //   RemoveGallery event,
  //   Emitter<TendersState> emit,
  // ) {
  //   final updatedImages = List<XFile>.from(state.pickedLogo)
  //     ..remove(event.image);
  //   emit(TendersState(pickedLogo: updatedImages));
  // }
  Future<void> _onRemoveImage(
    RemoveGallery event,
    Emitter<TendersState> emit,
  ) async {
    final updatedImages = List<XFile>.from(state.newTenderModel.images ?? []);
    updatedImages.removeWhere((image) => image.path == event.image.path);

    final updatedModel = state.newTenderModel.copyWith(images: updatedImages);
    //  ??
    //     AddTenderModel(images: updatedImages);

    emit(state.copywith(newTenderModel: updatedModel));
  }

  Future<XFile> _convertHEICtoJPG(File heicFile) async {
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;

    final result = await FlutterImageCompress.compressAndGetFile(
      heicFile.path,
      '$tempPath/${DateTime.now().millisecondsSinceEpoch}.jpg',
      quality: 100,
      format: CompressFormat.jpeg,
    );
    return XFile(result!.path);
  }
  //

  Future<void> _onSelectCategory(
      SelectCategory event, Emitter<TendersState> emit) async {
    emit(state.copywith(
        newTenderModel:
            state.newTenderModel.copyWith(categories: [event.category])));
  }

  Future<void> _onUpdateTenderCompany(
      UpdateTenderCompany event, Emitter<TendersState> emit) async {
    print('this is the company data ${event.company.toJson()}');
    emit(state.copywith(
        newTenderModel:
            state.newTenderModel.copyWith(selectedCompany: event.company)));
  }

  Future<void> _onRemoveTenderImage(
      RemoveTenderImage event, Emitter<TendersState> emit) async {
    final updatedDeletedImages = List<Media>.from(
      state.newTenderModel.deleteImages ?? [],
    )..add(event.tenderImage);
    final updatedImages = List<Media>.from(state.newTenderModel.uploadedImages!)
      ..remove(event.tenderImage);

    emit(state.copywith(
      newTenderModel: state.newTenderModel.copyWith(
        uploadedImages: updatedImages,
        deleteImages: updatedDeletedImages,
      ),
    ));
  }

  Future<void> _onUpdateTenderImages(
      UpdateTenderImages event, Emitter<TendersState> emit) async {
    final updateImages =
        state.newTenderModel.copyWith(uploadedImages: event.images);
    print('called this on update tender = ${event.images.length}');
    emit(state.copywith(newTenderModel: updateImages));
  }

  Future<void> _onGetCategoryById(
      GetCategoryById event, Emitter<TendersState> emit) async {
    try {
      final response = await tendersRepo.getCategoryById(event.categoryId);
      if (response.statusCode == 200) {
        final category = CategoryItem.fromJson(response.body['data']);
        final categories =
            List<CategoryItem>.from(state.newTenderModel.categories ?? [])
              ..add(category);
        emit(state.copywith(
            newTenderModel:
                state.newTenderModel.copyWith(categories: categories)));
      }
    } catch (e) {}
  }
}
