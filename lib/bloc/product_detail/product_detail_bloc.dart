import 'package:el_biz/data/model/response/product/product_detail_model.dart';
import 'package:el_biz/data/repo/product_detail_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../company_detail/company_detail_bloc.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailRepo productDetailRepo;
  ProductDetailBloc(this.productDetailRepo)
      : super(const ProductDetailState()) {
    on<ToggleShowProductReview>((event, emit) {
      emit(state.copywith(showProductReviews: event.isShowReview));
    });

    on<GetProductDetail>(_onGetProductDetail);
    on<ToggleProductFavorite>(_onToggleProductFavorite);
    on<ChangeProductStatus>(_onChangeProductStatus);
  }
  Future<void> _onGetProductDetail(
      GetProductDetail event, Emitter<ProductDetailState> emit) async {
    // emit(state.copywith(isLoading: true));
    emit(ProductDetailLoader());
    try {
      final response = await productDetailRepo.getDetail(event.productId);
      if (response.statusCode == 200) {
        final detail = ProductDetailModel.fromJson(response.body);
        emit(state.copywith(productDetailModel: detail));
        // emit(ProductDetailSuccess(detail));
      } else {
        emit(ProductDetailError(response.body['message']));
      }
    } catch (e) {
      print(e.toString());
      emit(ProductDetailError(e.toString()));
    }
    // emit(state.copywith(isLoading: false));
  }

  Future<void> _onToggleProductFavorite(
      ToggleProductFavorite event, Emitter<ProductDetailState> emit) async {
    final currentModel = state.productDetailModel!;
    final updatedData = currentModel.data!.copyWith(
      isFavorite: !(currentModel.data!.isFavorite ?? false),
    );
    final updatedModel = currentModel.copyWith(data: updatedData);
    emit(state.copywith(productDetailModel: updatedModel));

    try {
      final response = await productDetailRepo
          .toggleFavorite(state.productDetailModel!.data!.id.toString());
      if (response.statusCode == 200) {
        // update favorite

        // ignore: use_build_context_synchronously
        event.context.read<CompanyDetailBloc>().add(
            ToggleFavoriteProductInList(state.productDetailModel!.data!.id!));
      } else {
        final currentModel = state.productDetailModel!;
        final updatedData = currentModel.data!.copyWith(
          isFavorite: !(currentModel.data!.isFavorite ?? false),
        );
        final updatedModel = currentModel.copyWith(data: updatedData);
        emit(state.copywith(productDetailModel: updatedModel));
      }
    } catch (e) {
      final currentModel = state.productDetailModel!;
      final updatedData = currentModel.data!.copyWith(
        isFavorite: !(currentModel.data!.isFavorite ?? false),
      );
      final updatedModel = currentModel.copyWith(data: updatedData);
      emit(state.copywith(productDetailModel: updatedModel));
    }
  }

  Future<void> _onChangeProductStatus(
      ChangeProductStatus event, Emitter<ProductDetailState> emit) async {
    // emit(ProductDetailLoader());
    emit(state.copywith(statusUpdating: true));
    try {
      final response = await productDetailRepo.changeProductStatus(
          event.productId, event.status);
      if (response.statusCode == 200) {
        final updatedProductDetail = state.productDetailModel!.data!.copyWith(
          status: event.status,
        );

        emit(state.copywith(
          productDetailModel:
              state.productDetailModel?.copyWith(data: updatedProductDetail),
        ));
      } else {
        emit(ProductDetailError(response.body['message']));
      }
    } catch (e) {
      emit(ProductDetailError(e.toString()));
    }

    emit(state.copywith(statusUpdating: false));
  }
}
