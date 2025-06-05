import 'package:bloc/bloc.dart';
import 'package:el_biz/bloc/company_detail/company_detail_bloc.dart';
import 'package:el_biz/data/repo/similar_product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/company/company_product_model.dart';
import '../public_product/public_product_bloc.dart';

part 'similar_products_event.dart';
part 'similar_products_state.dart';

class SimilarProductsBloc
    extends Bloc<SimilarProductsEvent, SimilarProductsState> {
  final SimilarProductRepo similarProductRepo;
  SimilarProductsBloc(this.similarProductRepo)
      : super(SimilarProductsInitial()) {
    on<SimilarProductsEvent>((event, emit) {});
    on<GetSimilarProducts>(_onGetSimilarProducts);
    on<ToggleSimilarProductFavorite>(_onToggleSimilarProductFavorite);
  }

  Future<void> _onGetSimilarProducts(
      GetSimilarProducts event, Emitter<SimilarProductsState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isMoreLoading: true));
    }

    try {
      final response = await similarProductRepo.getSimilarProducts(
          event.productId, event.currentPage);

      if (response.statusCode == 200) {
        final similarProduct = CompanyProductModel.fromJson(response.body);

        if (event.currentPage == 1) {
          emit(state.copyWith(
            similarProduct: similarProduct.data?.items,
            isLoading: false,
          ));
        } else {
          emit(state.copyWith(
            similarProduct: List<ProductListItem>.from(state.similarProduct)
              ..addAll(similarProduct.data?.items ?? []),
          ));
        }

        emit(state.copyWith(
            currentPage: similarProduct.data?.currentPage ?? 1,
            pageSize: similarProduct.data?.totalPages ?? 1));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      print("public product catch part = ${e.toString()}");
    }
    emit(state.copyWith(isLoading: false, isMoreLoading: false));
  }

  // toggle favorite
  Future<void> _onToggleSimilarProductFavorite(
      ToggleSimilarProductFavorite event,
      Emitter<SimilarProductsState> emit) async {
    final updatedProducts = state.similarProduct.map((product) {
      if (product.id == event.productId) {
        return product.copyWith(
          isFavorite: !(product.isFavorite ?? false),
        );
      }
      return product;
    }).toList();

    emit(state.copyWith(similarProduct: updatedProducts));
    try {
      final response =
          await similarProductRepo.toggleFavorite(event.productId.toString());
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        event.context
            .read<PublicProductBloc>()
            .add(ToggleFavoritePublicProductInList(event.productId));

        // ignore: use_build_context_synchronously
        event.context
            .read<CompanyDetailBloc>()
            .add(ToggleFavoriteProductInList(event.productId));
      } else {
        final updatedProducts = state.similarProduct.map((product) {
          if (product.id == event.productId) {
            return product.copyWith(
              isFavorite: !(product.isFavorite ?? false),
            );
          }
          return product;
        }).toList();
        emit(state.copyWith(similarProduct: updatedProducts));
      }
    } catch (e) {
      final updatedProducts = state.similarProduct.map((product) {
        if (product.id == event.productId) {
          return product.copyWith(
            isFavorite: !(product.isFavorite ?? false),
          );
        }
        return product;
      }).toList();
      emit(state.copyWith(similarProduct: updatedProducts));
    }
  }
}
