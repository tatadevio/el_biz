import 'dart:io';

import 'package:el_biz/data/repo/product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/model/response/product/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo productRepo;
  ProductBloc(this.productRepo) : super(const ProductState()) {
    on<UpdateGridView>((event, emit) {
      emit(state.copywith(isGridView: event.gridView));
    });

    on<UpdateShowCategories>((event, emit) {
      emit(state.copywith(isShowCategories: event.showCategories));
    });

    on<UpdateKeywordSelected>((event, emit) {
      if (state.selectedKeywords.isEmpty) {
        emit(state.copywith(selectedKeywords: state.selectedKeywords..add(event.keyword)));
      } else {
        if (state.selectedKeywords.contains(event.keyword)) {
          emit(
            state.copywith(
              selectedKeywords: state.selectedKeywords..remove(event.keyword),
            ),
          );
        } else {
          emit(state.copywith(
            selectedKeywords: state.selectedKeywords..add(event.keyword),
          ));
        }
      }
    });

    on<UpdateMaterialSelected>((event, emit) {
      final currentMaterials = List<String>.from(state.selectedMaterial);

      if (currentMaterials.contains(event.material)) {
        currentMaterials.remove(event.material);
      } else {
        currentMaterials.add(event.material);
      }

      emit(state.copywith(selectedMaterial: currentMaterials));
    });

    on<ChangeCityId>((event, emit) {
      emit(state.copywith(selectedCity: event.id, selectedCityName: event.name));
    });

    on<UpdateNameId>((event, emit) {
      emit(state.copywith(
        selectedSubCatId: event.id,
        selectedSubCatName: event.name,
      ));
      if (event.callProduct) {
        add(GetProductWithCat(event.id, event.name));
      }
    });

    on<SetSortType>((event, emit) {
      emit(state.copywith(sortType: event.id));
    });

    on<PickImageDocs>(_onPickImageDocs);
    on<PickImageDocsCamera>(_onPickImageDocsCamera);
    on<RemoveGallery>(_onRemoveImage);

    on<GetProductWithCat>(_onGetProductWithCat);
  }

  Future<void> _onPickImageDocs(
    PickImageDocs event,
    Emitter<ProductState> emit,
  ) async {
    final picker = ImagePicker();
    final List<XFile>? value = await picker.pickMultiImage(maxWidth: 1024);

    if (value != null) {
      final List<XFile> newImages = [];
      for (var file in value) {
        final compressedImage = await _convertHEICtoJPG(File(file.path));
        newImages.add(compressedImage);
      }
      emit(ProductState(pickedLogo: [...state.pickedLogo, ...newImages]));
    }
  }

  Future<void> _onPickImageDocsCamera(
    PickImageDocsCamera event,
    Emitter<ProductState> emit,
  ) async {
    final picker = ImagePicker();
    final XFile? value = await picker.pickImage(source: ImageSource.camera, maxWidth: 1024);

    if (value != null) {
      final compressedImage = await _convertHEICtoJPG(File(value.path));
      emit(ProductState(pickedLogo: [...state.pickedLogo, compressedImage]));
    }
  }

  void _onRemoveImage(
    RemoveGallery event,
    Emitter<ProductState> emit,
  ) {
    final updatedImages = List<XFile>.from(state.pickedLogo)..remove(event.image);
    emit(ProductState(pickedLogo: updatedImages));
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

  Future<void> _onGetProductWithCat(
    GetProductWithCat event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copywith(
      selectedSubCatId: event.id,
      selectedSubCatName: event.name,
      isLoading: true,
    ));

    try {
      final response = await productRepo.getProductWithCatId(event.id);

      if (response.statusCode == 200) {
        emit(state.copywith(
          currentQuery: "?category_id=${event.id}",
          catProductItem: [],
        ));
        final productList = ProductListModel.fromJson(response.body).data.items;

        emit(state.copywith(
          catProductItem: state.catProductItem..addAll(productList),
          isLoading: false,
        ));
      } else {
        emit(state.copywith(isLoading: false));
      }
    } catch (e) {
      emit(state.copywith(isLoading: false));
      // Handle error appropriately (e.g., logging or adding an error state)
    }
  }
}
