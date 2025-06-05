import 'package:bloc/bloc.dart';
import 'package:el_biz/data/repo/search_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/company/company_product_model.dart';
import '../public_product/public_product_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepo searchRepo;
  SearchBloc(this.searchRepo) : super(const SearchState()) {
    on<SearchEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<UpdateGridView>((event, emit) {
      emit(state.copyWith(isGridView: event.gridView));
    });

    on<ChangeStatusSearch>((event, emit) {
      emit(state.copyWith(isSearchProducts: event.showProducts));
    });

    on<SearchProduct>(_onSearchProduct);
    on<ClearSearchList>(_onClearSearchList);
    on<ToggleSearchProductFavorite>(_onToggleSearchProductFavorite);
  }

  Future<void> _onSearchProduct(
      SearchProduct event, Emitter<SearchState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isMoreLoading: true));
    }

    try {
      print('public products status code = start try');
      final response =
          await searchRepo.searchProduct(event.search, event.currentPage);
      print('public products status code =  ${response.statusCode}');

      if (response.statusCode == 200) {
        final companyProducts = CompanyProductModel.fromJson(response.body);
        print(
            'public products list length =  ${companyProducts.data?.items?.length}');

        if (event.currentPage == 1) {
          emit(state.copyWith(
            searchProducts: companyProducts.data?.items,
            isLoading: false,
          ));
        } else {
          emit(state.copyWith(
            searchProducts: List<ProductListItem>.from(state.searchProducts)
              ..addAll(companyProducts.data?.items ?? []),
          ));
        }

        emit(state.copyWith(
            currentPage: companyProducts.data?.currentPage ?? 1,
            pageSize: companyProducts.data?.totalPages ?? 1));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      print("public product catch part = ${e.toString()}");
    }
    emit(state.copyWith(isLoading: false, isMoreLoading: false));
  }

  Future<void> _onClearSearchList(
      ClearSearchList event, Emitter<SearchState> emit) async {
    emit(state.copyWith(searchProducts: []));
  }

  // toggle favorite
  Future<void> _onToggleSearchProductFavorite(
      ToggleSearchProductFavorite event, Emitter<SearchState> emit) async {
    final updatedProducts = state.searchProducts.map((product) {
      if (product.id == event.productId) {
        return product.copyWith(
          isFavorite: !(product.isFavorite ?? false),
        );
      }
      return product;
    }).toList();

    emit(state.copyWith(searchProducts: updatedProducts));
    try {
      final response =
          await searchRepo.toggleFavorite(event.productId.toString());
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        event.context
            .read<PublicProductBloc>()
            .add(ToggleFavoritePublicProductInList(event.productId));

        // ignore: use_build_context_synchronously
        // event.context
        //     .read<CompanyDetailBloc>()
        //     .add(ToggleFavoriteProductInList(event.productId));
      } else {
        final updatedProducts = state.searchProducts.map((product) {
          if (product.id == event.productId) {
            return product.copyWith(
              isFavorite: !(product.isFavorite ?? false),
            );
          }
          return product;
        }).toList();
        emit(state.copyWith(searchProducts: updatedProducts));
      }
    } catch (e) {
      final updatedProducts = state.searchProducts.map((product) {
        if (product.id == event.productId) {
          return product.copyWith(
            isFavorite: !(product.isFavorite ?? false),
          );
        }
        return product;
      }).toList();
      emit(state.copyWith(searchProducts: updatedProducts));
    }
  }
}
