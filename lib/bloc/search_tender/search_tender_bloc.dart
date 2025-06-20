import 'package:el_biz/bloc/public_tender/public_tender_bloc.dart';
import 'package:el_biz/data/model/response/tender/tender_item_model.dart';
import 'package:el_biz/data/repo/search_tender_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/company/company_tenders_model.dart';
import '../favorite/favorite_bloc.dart';

part 'search_tender_event.dart';
part 'search_tender_state.dart';

class SearchTenderBloc extends Bloc<SearchTenderEvent, SearchTenderState> {
  final SearchTenderRepo searchTenderRepo;
  SearchTenderBloc(this.searchTenderRepo) : super(SearchTenderInitial()) {
    on<SearchTenderEvent>((event, emit) {});
    on<SearchTender>(_onSearchTender);
    on<ClearSearchTenderList>(_onClearSearchTenderList);
    on<ToggleSearchTenderFavorite>(_onToggleSearchTenderFavorite);
  }

  Future<void> _onSearchTender(
      SearchTender event, Emitter<SearchTenderState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isMoreLoading: true));
    }

    try {
      final response =
          await searchTenderRepo.searchTender(event.search, event.currentPage);

      if (response.statusCode == 200) {
        final companyProducts = CompanyTendersModel.fromJson(response.body);

        if (event.currentPage == 1) {
          emit(state.copyWith(
            searchTenders: companyProducts.data?.items,
            isLoading: false,
          ));
        } else {
          emit(state.copyWith(
            searchTenders: List<TenderItem>.from(state.searchTenders)
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

  Future<void> _onClearSearchTenderList(
      ClearSearchTenderList event, Emitter<SearchTenderState> emit) async {
    emit(state.copyWith(searchTenders: []));
  }

  Future<void> _onToggleSearchTenderFavorite(
      ToggleSearchTenderFavorite event, Emitter<SearchTenderState> emit) async {
    final updatedProducts = state.searchTenders.map((tender) {
      if (tender.id == event.tenderId) {
        return tender.copyWith(
          isFavorite: !(tender.isFavorite ?? false),
        );
      }
      return tender;
    }).toList();

    emit(state.copyWith(searchTenders: updatedProducts));
    try {
      final response = await searchTenderRepo
          .toggleFavorite(event.tenderId.toString(), type: "Tender");
      if (response.statusCode == 200) {
        event.context
            .read<PublicTenderBloc>()
            .add(ToggleFavoritePublicTenderInList(tenderId: event.tenderId));
        // ignore: use_build_context_synchronously
        event.context
            .read<FavoriteBloc>()
            .add(RemoveTenderFromFavoriteList(event.tenderId));
      } else {
        final updatedProducts = state.searchTenders.map((product) {
          if (product.id == event.tenderId) {
            return product.copyWith(
              isFavorite: !(product.isFavorite ?? false),
            );
          }
          return product;
        }).toList();
        emit(state.copyWith(searchTenders: updatedProducts));
      }
    } catch (e) {
      final updatedProducts = state.searchTenders.map((product) {
        if (product.id == event.tenderId) {
          return product.copyWith(
            isFavorite: !(product.isFavorite ?? false),
          );
        }
        return product;
      }).toList();
      emit(state.copyWith(searchTenders: updatedProducts));
    }
  }
}
