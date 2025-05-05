import 'dart:developer';

import 'package:el_biz/data/model/response/category/categories_list_model.dart';
import 'package:el_biz/data/model/response/product/product_detail_model.dart';
import 'package:el_biz/data/repo/add_product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../data/model/base/add_product_model.dart';
import '../../data/model/response/materials_model.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final AddProductRepo addProductRepo;
  AddProductBloc(this.addProductRepo)
      : super(AddProductState(productData: AddProductModel())) {
    // on<AddProductEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<AddProduct>(_onAddProduct);
    on<SelectCategory>(_onSelectCategory);
    on<SelectMaterial>(_onSelectMaterial);
    on<RemoveProductImage>(_onRemoveProductImage);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProductImage>(_onDeleteProductImage);
    on<GetCategoryById>(_onGetCategoryById);
  }

  Future<void> _onSelectCategory(
      SelectCategory event, Emitter<AddProductState> emit) async {
    emit(state.copyWith(
        productData: state.productData?.copyWith(category: event.category)));
  }

  Future<void> _onSelectMaterial(
      SelectMaterial event, Emitter<AddProductState> emit) async {
    emit(state.copyWith(
        productData:
            state.productData?.copyWith(material: event.materialItem)));
  }

  Future<void> _onRemoveProductImage(
      RemoveProductImage event, Emitter<AddProductState> emit) async {
    final updatedDeletedImages = List<ProductDetailImages>.from(
      state.productData!.deleteProductImages ?? [],
    )..add(event.productImage);
    final updatedImages = List<ProductDetailImages>.from(
        state.productData!.productUploadedImages!)
      ..remove(event.productImage);

    emit(state.copyWith(
      productData: state.productData!.copyWith(
        productUploadedImages: updatedImages,
        deleteProductImages: updatedDeletedImages,
      ),
    ));
  }

  Future<void> _onAddProduct(
      AddProduct event, Emitter<AddProductState> emit) async {
    emit(AddProductLoading());
    // emit(AddProductState(productData: event.addProductModel));
    try {
      Response response =
          await addProductRepo.addNewProduct(event.addProductModel);
      if (response.statusCode == 200) {
        emit(AddProductSuccess());
        emit(state.copyWith(productData: AddProductModel()));
      } else {
        emit(AddProductFailure(response.body));
      }
    } catch (e) {
      emit(AddProductFailure(e.toString()));
      // emit(AddProductState(productData: event.addProductModel, error: e.toString()));
    }
  }

  Future<void> _onUpdateProduct(
      UpdateProduct event, Emitter<AddProductState> emit) async {
    emit(AddProductLoading());
    // emit(AddProductState(productData: state.productData));
    try {
      Response response = await addProductRepo.addNewProduct(
          event.addProductModel,
          isUpdate: true,
          productId: event.productId);

      if (response.statusCode == 200) {
        if (event.addProductModel.deleteProductImages != null &&
            event.addProductModel.deleteProductImages!.isNotEmpty) {
          for (var delImage in event.addProductModel.deleteProductImages!) {
            add(DeleteProductImage(event.productId, delImage.id.toString()));
          }
        }
        emit(AddProductSuccess());
        emit(state.copyWith(productData: AddProductModel()));
      } else {
        emit(AddProductFailure(response.body));
      }
    } catch (e) {
      log('update product catch = $e');
      emit(AddProductFailure(e.toString()));
      // emit(AddProductState(productData: event.addProductModel, error: e.toString()));
    }
  }

  Future<void> _onDeleteProductImage(
      DeleteProductImage event, Emitter<AddProductState> emit) async {
    try {
      Response response = await addProductRepo.deleteProductImage(
          event.productId, event.imageId);
      if (kDebugMode) {
        print(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print('update product catch = $e');
      }
    }
  }

  Future<void> _onGetCategoryById(
      GetCategoryById event, Emitter<AddProductState> emit) async {
    try {
      final response = await addProductRepo.getCategoryById(event.categoryId);
      if (response.statusCode == 200) {
        final category = CategoryItem.fromJson(response.body['data']);
        emit(state.copyWith(
            productData: state.productData?.copyWith(category: category)));
      }
    } catch (e) {}
  }
}
