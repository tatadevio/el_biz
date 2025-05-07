import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/company/company_product_model.dart';
import '../../data/repo/public_product_repo.dart';

part 'public_product_event.dart';
part 'public_product_state.dart';

class PublicProductBloc extends Bloc<PublicProductEvent, PublicProductState> {
  final PublicProductRepo publicProductRepo;
  PublicProductBloc(this.publicProductRepo) : super(PublicProductState()) {
    on<PublicProductEvent>((event, emit) {});

    on<GetPublicProduct>(_onGetPublicProduct);
    on<RemoveProductFromFavoriteList>(_onRemoveProductFromFavoriteList);
    on<ToggleFavoritePublicProductInList>(_onToggleFavoriteProductInList);
    on<ToggleFavoritePublicProduct>(_onToggleFavoriteProduct);
  }

  Future<void> _onGetPublicProduct(
      GetPublicProduct event, Emitter<PublicProductState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isMoreLoading: true));
    }
    try {
      final response =
          await publicProductRepo.getPublicProducts(event.currentPage);

      if (response.statusCode == 200) {
        final companyProducts = CompanyProductModel.fromJson(response.body);

        if (event.currentPage == 1) {
          emit(state.copyWith(
            publicProducts: companyProducts.data?.items,
            isLoading: false,
          ));
        } else {
          emit(state.copyWith(
            publicProducts: List<ProductListItem>.from(state.publicProducts)
              ..addAll(companyProducts.data?.items ?? []),

            // [
            //   ...state.publicProducts ,
            //   ...companyProducts.data?.items ?? []
            // ]
          ));
        }

        emit(state.copyWith(
            currentPage: companyProducts.data?.currentPage ?? 1,
            pageSize: companyProducts.data?.totalPages ?? 1));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      print(e.toString());
    }
    emit(state.copyWith(isLoading: false, isMoreLoading: false));
  }

  Future<void> _onToggleFavoriteProductInList(
      ToggleFavoritePublicProductInList event,
      Emitter<PublicProductState> emit) async {
    final updatedProducts = state.publicProducts.map((product) {
      if (product.id == event.productId) {
        return product.copyWith(
          isFavorite: !(product.isFavorite ?? false),
        );
      }
      return product;
    }).toList();

    emit(state.copyWith(publicProducts: updatedProducts));
  }

  Future<void> _onToggleFavoriteProduct(ToggleFavoritePublicProduct event,
      Emitter<PublicProductState> emit) async {
    final updatedProducts = state.publicProducts.map((product) {
      if (product.id == event.productId) {
        return product.copyWith(
          isFavorite: !(product.isFavorite ?? false),
        );
      }
      return product;
    }).toList();

    emit(state.copyWith(publicProducts: updatedProducts));
    try {
      final response =
          await publicProductRepo.toggleFavorite(event.productId.toString());
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        // event.context
        //     .read<PublicProductBloc>()
        //     .add(RemoveProductFromFavoriteList(event.productId));
      } else {
        final updatedProducts = state.publicProducts.map((product) {
          if (product.id == event.productId) {
            return product.copyWith(
              isFavorite: !(product.isFavorite ?? false),
            );
          }
          return product;
        }).toList();
        emit(state.copyWith(publicProducts: updatedProducts));
      }
    } catch (e) {
      final updatedProducts = state.publicProducts.map((product) {
        if (product.id == event.productId) {
          return product.copyWith(
            isFavorite: !(product.isFavorite ?? false),
          );
        }
        return product;
      }).toList();
      emit(state.copyWith(publicProducts: updatedProducts));
    }
  }

  Future<void> _onRemoveProductFromFavoriteList(
    RemoveProductFromFavoriteList event,
    Emitter<PublicProductState> emit,
  ) async {
    List<ProductListItem> allFavorites = List.from(state.publicProducts);

    final index =
        allFavorites.indexWhere((product) => product.id == event.productId);

    if (index != -1) {
      allFavorites.removeAt(index);
      emit(state.copyWith(publicProducts: allFavorites));
    } else {
      // Product not found, no action needed, optionally re-emit same state
      emit(state);
    }
  }
}
