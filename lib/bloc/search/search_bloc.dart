import 'package:bloc/bloc.dart';
import 'package:el_biz/data/repo/search_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/model/response/company/company_product_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepo searchRepo;
  SearchBloc(this.searchRepo) : super(const SearchState()) {
    on<SearchEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ChangeStatusSearch>((event, emit) {
      emit(state.copyWith(isSearchProducts: event.showProducts));
    });

    on<SearchProduct>(_onSearchProduct);
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
}
