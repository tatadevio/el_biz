import 'package:el_biz/bloc/auction/favorite_auciton/favorite_auction_bloc.dart';
import 'package:el_biz/data/model/response/auction/auctions_list_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/auction/auctions_repo.dart';

part 'auctions_event.dart';
part 'auctions_state.dart';

class AuctionsBloc extends Bloc<AuctionsEvent, AuctionsState> {
  final AuctionsRepo auctionsRepo;
  AuctionsBloc(this.auctionsRepo) : super(AuctionsInitial()) {
    on<AuctionsEvent>((event, emit) {});

    on<UpdateAuctionGridView>(_updateToggleShowGridView);
    on<GetAuctions>(_getAuctions);
    on<TogglePublicAuctionsFavorite>(_onTogglePublicAuctionsFavorite);
    on<UpdateAuctionInFavoriteList>(_onUpdateAuctionInFavoriteList);
    on<UpdateAuctionsFilterEnable>(_onUpdateAuctionsFilterEnable);
    on<GetMyAuctions>(_getMyAuctions);
    on<GetMyBidAuctions>(_getMyBidAuctions);
  }

  void _updateToggleShowGridView(
      UpdateAuctionGridView event, Emitter<AuctionsState> emit) {
    emit(state.copyWith(isGridView: event.isGridView));
  }

  Future<void> _onUpdateAuctionsFilterEnable(
    UpdateAuctionsFilterEnable event,
    Emitter<AuctionsState> emit,
  ) async {
    emit(state.copyWith(isFilterEnable: event.isEnable));
  }

  void _getAuctions(GetAuctions event, Emitter<AuctionsState> emit) async {
    if (event.isRefresh) {
      emit(state.copyWith(isLoading: true, currentPage: 1, auctions: []));
    } else {
      if (event.page == 1) {
        emit(state.copyWith(isLoading: true, currentPage: 1, auctions: []));
      } else {
        emit(state.copyWith(isLoadingMore: true));
      }
    }

    try {
      final response = await auctionsRepo.getAuctions(event.page,
          orderBy: event.orderBy, direction: event.direction);
      if (response.statusCode == 200) {
        AuctionsListModel auctions = AuctionsListModel.fromJson(response.body);
        List<AuctionListItem> auctionList = auctions.data?.items ?? [];
        // List<AuctionListItem> auctionList = (response.body['data']['data']
        //         as List)
        //     .map((e) => AuctionListItem.fromJson(e))
        //     .toList();

        // int totalPages = response.body['data']['last_page'] ?? 1;

        List<AuctionListItem> allAuctions = [];
        if (event.page == 1 || event.isRefresh) {
          allAuctions = auctionList;
        } else {
          allAuctions = [...state.auctions, ...auctionList];
        }

        emit(state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          auctions: allAuctions,
          currentPage: auctions.data?.currentPage ?? event.page,
          totalPages: auctions.data?.totalPages ?? state.totalPages,
        ));
      } else {
        emit(state.copyWith(isLoading: false, isLoadingMore: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, isLoadingMore: false));
    }
  }

  Future<void> _onTogglePublicAuctionsFavorite(
      TogglePublicAuctionsFavorite event, Emitter<AuctionsState> emit) async {
    add(UpdateAuctionInFavoriteList(
        auctionId: event.auctionId, isFavorite: event.isFavorite));
    try {
      final response = await auctionsRepo.toggleFavorite(
        event.auctionId.toString(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // ignore: use_build_context_synchronously
        event.context
            .read<FavoriteAuctionBloc>()
            .add(RemoveAuctionFromFavoriteList(auctionId: event.auctionId));
      } else {
        add(UpdateAuctionInFavoriteList(
            auctionId: event.auctionId, isFavorite: !event.isFavorite));
      }
    } catch (e) {
      add(UpdateAuctionInFavoriteList(
          auctionId: event.auctionId, isFavorite: !event.isFavorite));
    }
  }

  Future<void> _onUpdateAuctionInFavoriteList(
      UpdateAuctionInFavoriteList event, Emitter<AuctionsState> emit) async {
    print('this is the auction id in the list = ${event.auctionId}');
    final updatedAuctions = state.auctions.map((auciton) {
      if (auciton.id == event.auctionId) {
        return auciton.copyWith(
          isFavorite: event.isFavorite,
        );
      }
      return auciton;
    }).toList();

    emit(state.copyWith(auctions: updatedAuctions));

    if (state.isFilterEnable) {
      final filteredAuctions = state.filteredAuctions.map((auction) {
        if (auction.id == event.auctionId) {
          return auction.copyWith(
            isFavorite: event.isFavorite,
          );
        }
        return auction;
      }).toList();

      emit(state.copyWith(filteredAuctions: filteredAuctions));
    }
  }

  void _getMyAuctions(GetMyAuctions event, Emitter<AuctionsState> emit) async {
    if (event.isRefresh) {
      emit(state.copyWith(
          myAuctionsLoading: true, myAuctionsCurrentPage: 1, myAuctions: []));
    } else {
      if (event.page == 1) {
        emit(state.copyWith(
            myAuctionsLoading: true, myAuctionsCurrentPage: 1, myAuctions: []));
      } else {
        emit(state.copyWith(myAuctionsLoadingMore: true));
      }
    }

    try {
      final response = await auctionsRepo.getMyAuctions(event.page,
          orderBy: event.orderBy, direction: event.direction);
      if (response.statusCode == 200) {
        AuctionsListModel auctions = AuctionsListModel.fromJson(response.body);
        List<AuctionListItem> auctionList = auctions.data?.items ?? [];
        // List<AuctionListItem> auctionList = (response.body['data']['data']
        //         as List)
        //     .map((e) => AuctionListItem.fromJson(e))
        //     .toList();

        // int totalPages = response.body['data']['last_page'] ?? 1;

        List<AuctionListItem> allAuctions = [];
        if (event.page == 1 || event.isRefresh) {
          allAuctions = auctionList;
        } else {
          allAuctions = [...state.myAuctions, ...auctionList];
        }

        emit(state.copyWith(
          myAuctionsLoading: false,
          myAuctionsLoadingMore: false,
          myAuctions: allAuctions,
          myAuctionsCurrentPage: auctions.data?.currentPage ?? event.page,
          myAuctionsTotalPages: auctions.data?.totalPages ?? state.totalPages,
        ));
      } else {
        emit(state.copyWith(
            myAuctionsLoading: false, myAuctionsLoadingMore: false));
      }
    } catch (e) {
      emit(state.copyWith(
          myAuctionsLoading: false, myAuctionsLoadingMore: false));
    }
  }

  void _getMyBidAuctions(
      GetMyBidAuctions event, Emitter<AuctionsState> emit) async {
    if (event.isRefresh) {
      emit(state.copyWith(
          myBidAuctionsLoading: true,
          myBidAuctionsCurrentPage: 1,
          myBidAuctions: []));
    } else {
      if (event.page == 1) {
        emit(state.copyWith(
            myBidAuctionsLoading: true,
            myBidAuctionsCurrentPage: 1,
            myBidAuctions: []));
      } else {
        emit(state.copyWith(myBidAuctionsLoadingMore: true));
      }
    }

    try {
      final response = await auctionsRepo.getMyBidAuctions(event.page,
          orderBy: event.orderBy, direction: event.direction);
      if (response.statusCode == 200) {
        AuctionsListModel auctions = AuctionsListModel.fromJson(response.body);
        List<AuctionListItem> auctionList = auctions.data?.items ?? [];

        List<AuctionListItem> allAuctions = [];
        if (event.page == 1 || event.isRefresh) {
          allAuctions = auctionList;
        } else {
          allAuctions = [...state.myBidAuctions, ...auctionList];
        }

        emit(state.copyWith(
          myBidAuctionsLoading: false,
          myBidAuctionsLoadingMore: false,
          myBidAuctions: allAuctions,
          myBidAuctionsCurrentPage: auctions.data?.currentPage ?? event.page,
          myBidAuctionsTotalPages:
              auctions.data?.totalPages ?? state.totalPages,
        ));
      } else {
        emit(state.copyWith(
            myBidAuctionsLoading: false, myBidAuctionsLoadingMore: false));
      }
    } catch (e) {
      emit(state.copyWith(
          myBidAuctionsLoading: false, myBidAuctionsLoadingMore: false));
    }
  }
}
