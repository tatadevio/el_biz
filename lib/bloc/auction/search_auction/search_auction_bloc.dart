import 'package:el_biz/bloc/auction/auctions/auctions_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/response/auction/auctions_list_model.dart';
import '../../../data/repo/auction/search_auction_repo.dart';

part 'search_auction_event.dart';
part 'search_auction_state.dart';

class SearchAuctionBloc extends Bloc<SearchAuctionEvent, SearchAuctionState> {
  final SearchAuctionRepo searchAuctionRepo;
  SearchAuctionBloc(this.searchAuctionRepo) : super(SearchAuctionInitial()) {
    on<SearchAuctionEvent>((event, emit) {});
    on<ClearSearchAuctionList>(_onClearSearchAuctionList);
    on<SearchAuction>(_onSearchAuction);
    on<ToggleSearchAuctionsFavorite>(_onToggleSearchAuctionsFavorite);
    on<UpdateSearchAuctionInFavoriteList>(_onUpdateSearchAuctionInFavoriteList);
  }

  Future<void> _onClearSearchAuctionList(
      ClearSearchAuctionList event, Emitter<SearchAuctionState> emit) async {
    emit(state.copyWith(searchAuctions: []));
  }

  Future<void> _onSearchAuction(
      SearchAuction event, Emitter<SearchAuctionState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isMoreLoading: true));
    }

    try {
      final response = await searchAuctionRepo.searchAuction(
          event.search, event.currentPage);

      if (response.statusCode == 200) {
        final auctions = AuctionsListModel.fromJson(response.body);

        if (event.currentPage == 1) {
          emit(state.copyWith(
            searchAuctions: auctions.data?.items,
            isLoading: false,
          ));
        } else {
          emit(state.copyWith(
            searchAuctions: List<AuctionListItem>.from(state.searchAuctions)
              ..addAll(auctions.data?.items ?? []),
          ));
        }

        emit(state.copyWith(
            currentPage: auctions.data?.currentPage ?? 1,
            pageSize: auctions.data?.totalPages ?? 1));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      print("public product catch part = ${e.toString()}");
    }
    emit(state.copyWith(isLoading: false, isMoreLoading: false));
  }

  Future<void> _onToggleSearchAuctionsFavorite(
      ToggleSearchAuctionsFavorite event,
      Emitter<SearchAuctionState> emit) async {
    print('this is the auction id in the list = ${event.auctionId}');
    final updatedAuctions = state.searchAuctions.map((auciton) {
      if (auciton.id == event.auctionId) {
        return auciton.copyWith(
          isFavorite: event.isFavorite,
        );
      }
      return auciton;
    }).toList();

    emit(state.copyWith(searchAuctions: updatedAuctions));

    //  _onUpdateAuctionInFavoriteList(
    //       auctionId: event.auctionId, isFavorite: event.isFavorite);
    try {
      final response = await searchAuctionRepo.toggleFavorite(
        event.auctionId.toString(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // ignore: use_build_context_synchronously
        event.context.read<AuctionsBloc>().add(UpdateAuctionInFavoriteList(
            auctionId: event.auctionId, isFavorite: event.isFavorite));
        // event.context
        //     .read<FavoriteAuctionBloc>()
        //     .add(RemoveAuctionFromFavoriteList(auctionId: event.auctionId));
      } else {
        final updatedAuctions = state.searchAuctions.map((auciton) {
          if (auciton.id == event.auctionId) {
            return auciton.copyWith(
              isFavorite: !event.isFavorite,
            );
          }
          return auciton;
        }).toList();

        emit(state.copyWith(searchAuctions: updatedAuctions));
        // add(UpdateAuctionInFavoriteList(
        //     auctionId: event.auctionId, isFavorite: !event.isFavorite));
      }
    } catch (e) {
      final updatedAuctions = state.searchAuctions.map((auciton) {
        if (auciton.id == event.auctionId) {
          return auciton.copyWith(
            isFavorite: !event.isFavorite,
          );
        }
        return auciton;
      }).toList();

      emit(state.copyWith(searchAuctions: updatedAuctions));
      // add(UpdateAuctionInFavoriteList(
      //     auctionId: event.auctionId, isFavorite: !event.isFavorite));
    }
  }

  // Future<void> _onUpdateAuctionInFavoriteList(
  //     UpdateAuctionInFavoriteList event, Emitter<AuctionsState> emit) async {
  //   print('this is the auction id in the list = ${event.auctionId}');
  //   final updatedAuctions = state.auctions.map((auciton) {
  //     if (auciton.id == event.auctionId) {
  //       return auciton.copyWith(
  //         isFavorite: event.isFavorite,
  //       );
  //     }
  //     return auciton;
  //   }).toList();

  //   emit(state.copyWith(auctions: updatedAuctions));

  //   if (state.isFilterEnable) {
  //     final filteredAuctions = state.filteredAuctions.map((auction) {
  //       if (auction.id == event.auctionId) {
  //         return auction.copyWith(
  //           isFavorite: event.isFavorite,
  //         );
  //       }
  //       return auction;
  //     }).toList();

  //     emit(state.copyWith(filteredAuctions: filteredAuctions));
  //   }
  // }

  Future<void> _onUpdateSearchAuctionInFavoriteList(
      UpdateSearchAuctionInFavoriteList event,
      Emitter<SearchAuctionState> emit) async {
    final updatedAuctions = state.searchAuctions.map((auciton) {
      if (auciton.id == event.auctionId) {
        return auciton.copyWith(
          isFavorite: event.isFavorite,
        );
      }
      return auciton;
    }).toList();

    emit(state.copyWith(searchAuctions: updatedAuctions));
  }
}
