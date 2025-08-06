import 'package:bloc/bloc.dart';
import 'package:el_biz/bloc/public_tender/public_tender_bloc.dart';
import 'package:el_biz/data/model/response/tender/tender_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/company/company_tenders_model.dart';
import '../../data/repo/similar_tenders_repo.dart';
import '../favorite/favorite_bloc.dart';

part 'similar_tenders_event.dart';
part 'similar_tenders_state.dart';

class SimilarTendersBloc
    extends Bloc<SimilarTendersEvent, SimilarTendersState> {
  final SimilarTendersRepo similarTenderRepo;
  SimilarTendersBloc(this.similarTenderRepo) : super(SimilarTendersInitial()) {
    on<SimilarTendersEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetSimilarTenders>(_onGetSimilarTenders);
    on<ToggleFavoriteSimilarTenderInList>(_onToggleFavoritePublicTenderInList);
    on<ToggleFavoriteSimilarTender>(_onTogglePublicTenderFavorite);
  }

  Future<void> _onGetSimilarTenders(
      GetSimilarTenders event, Emitter<SimilarTendersState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isMoreLoading: true));
    }

    try {
      final response = await similarTenderRepo.getSimilarTenders(
          event.tenderId, event.currentPage);
      print(
          'this is the response code of similar tender ${response.statusCode}');
      print('this is the response body of similar tender ${response.body}');
      if (response.statusCode == 200) {
        final companies = CompanyTendersModel.fromJson(response.body);
        print('these are companies ${companies.data?.items}');

        if (event.currentPage == 1) {
          emit(state.copyWith(similarTenders: []));
        }
        emit(state.copyWith(
          similarTenders: List<TenderItem>.from(state.similarTenders)
            ..addAll(companies.data?.items ?? []),
        ));

        emit(state.copyWith(
            currentPage: companies.data?.currentPage ?? 1,
            totalPages: companies.data?.totalPages ?? 1));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, isMoreLoading: false));
    }
  }

  //
  Future<void> _onTogglePublicTenderFavorite(ToggleFavoriteSimilarTender event,
      Emitter<SimilarTendersState> emit) async {
    final updatedProducts = state.similarTenders.map((tender) {
      if (tender.id.toString() == event.tenderId) {
        return tender.copyWith(
          isFavorite: !(tender.isFavorite ?? false),
        );
      }
      return tender;
    }).toList();

    emit(state.copyWith(similarTenders: updatedProducts));
    try {
      final response = await similarTenderRepo
          .toggleFavorite(event.tenderId.toString(), type: "Tender");
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        event.context
            .read<FavoriteBloc>()
            .add(RemoveTenderFromFavoriteList(int.parse(event.tenderId)));
        event.context.read<PublicTenderBloc>().add(
            ToggleFavoritePublicTenderInList(
                tenderId: int.parse(event.tenderId)));
      } else {
        final updatedProducts = state.similarTenders.map((product) {
          if (product.id.toString() == event.tenderId) {
            return product.copyWith(
              isFavorite: !(product.isFavorite ?? false),
            );
          }
          return product;
        }).toList();
        emit(state.copyWith(similarTenders: updatedProducts));
      }
    } catch (e) {
      final updatedProducts = state.similarTenders.map((product) {
        if (product.id.toString() == event.tenderId) {
          return product.copyWith(
            isFavorite: !(product.isFavorite ?? false),
          );
        }
        return product;
      }).toList();
      emit(state.copyWith(similarTenders: updatedProducts));
    }
  }

  Future<void> _onToggleFavoritePublicTenderInList(
      ToggleFavoriteSimilarTenderInList event,
      Emitter<SimilarTendersState> emit) async {
    final updatedTender = state.similarTenders.map((tender) {
      if (tender.id.toString() == event.tenderId) {
        return tender.copyWith(
          isFavorite: !(tender.isFavorite ?? false),
        );
      }
      return tender;
    }).toList();

    emit(state.copyWith(similarTenders: updatedTender));
  }
}
