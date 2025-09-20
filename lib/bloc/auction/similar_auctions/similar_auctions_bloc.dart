import 'package:el_biz/data/model/response/auction/auctions_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:el_biz/data/repo/auction/similar_auctions_repo.dart';

part 'similar_auctions_event.dart';
part 'similar_auctions_state.dart';

class SimilarAuctionsBloc
    extends Bloc<SimilarAuctionsEvent, SimilarAuctionsState> {
  final SimilarAuctionsRepo similarAuctionsRepo;
  SimilarAuctionsBloc(this.similarAuctionsRepo)
      : super(SimilarAuctionsInitial()) {
    on<SimilarAuctionsEvent>((event, emit) {});
    on<GetSimilarAuctions>(_onGetSimilarAuctions);
    on<ToggleFavoriteSimilarAuctionInList>(
        _onToggleFavoritePublicAuctionInList);
    on<ToggleFavoriteSimilarAuction>(_onTogglePublicAuctionFavorite);
  }

  Future<void> _onGetSimilarAuctions(
      GetSimilarAuctions event, Emitter<SimilarAuctionsState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isMoreLoading: true));
    }

    try {
      final response = await similarAuctionsRepo.getSimilarAuctions(
          event.auctionId, event.currentPage);

      if (response.statusCode == 200) {
        final companies = AuctionsListModel.fromJson(response.body);

        if (event.currentPage == 1) {
          emit(state.copyWith(similarAuctions: []));
        }
        emit(state.copyWith(
          similarAuctions: List<AuctionListItem>.from(state.similarAuctions)
            ..addAll(companies.data?.items ?? []),
        ));

        emit(state.copyWith(
            currentPage: companies.data?.currentPage ?? 1,
            totalPages: companies.data?.totalPages ?? 1,
            isLoading: false,
            isMoreLoading: false));
      } else {
        emit(state.copyWith(isLoading: false, isMoreLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, isMoreLoading: false));
    }
  }

  //
  Future<void> _onTogglePublicAuctionFavorite(
      ToggleFavoriteSimilarAuction event,
      Emitter<SimilarAuctionsState> emit) async {
    // final updatedProducts = state.similarAuctions.map((auction) {
    //   if (auction.id.toString() == event.auctionId) {
    //     return auction.copyWith(
    //       isFavorite: !(auction.isFavorite ?? false),
    //     );
    //   }
    //   return auction;
    // }).toList();

    // emit(state.copyWith(similarAuctions: updatedProducts));
    // try {
    //   final response = await similarAuctionsRepo
    //       .toggleFavorite(event.auctionId.toString(), type: "Auction");
    //   if (response.statusCode == 200) {
    //     // ignore: use_build_context_synchronously
    //     // event.context
    //     //     .read<FavoriteBloc>()
    //     //     .add(RemoveTenderFromFavoriteList(int.parse(event.tenderId)));
    //     // event.context.read<PublicTenderBloc>().add(
    //     //     ToggleFavoritePublicTenderInList(
    //     //         tenderId: int.parse(event.tenderId)));
    //   } else {
    //     final updatedProducts = state.similarAuctions.map((auction) {
    //       if (auction.id.toString() == event.auctionId) {
    //         return auction.copyWith(
    //           isFavorite: !(auction.isFavorite ?? false),
    //         );
    //       }
    //       return auction;
    //     }).toList();
    //     emit(state.copyWith(similarAuctions: updatedProducts));
    //   }
    // } catch (e) {
    //   final updatedProducts = state.similarAuctions.map((auction) {
    //     if (auction.id.toString() == event.auctionId) {
    //       return auction.copyWith(
    //         isFavorite: !(auction.isFavorite ?? false),
    //       );
    //     }
    //     return auction;
    //   }).toList();
    //   emit(state.copyWith(similarAuctions: updatedProducts));
    // }
  }

  Future<void> _onToggleFavoritePublicAuctionInList(
      ToggleFavoriteSimilarAuctionInList event,
      Emitter<SimilarAuctionsState> emit) async {
    // final updatedAuction = state.similarAuctions.map((auction) {
    //   if (auction.id.toString() == event.auctionId) {
    //     return auction.copyWith(
    //       isFavorite: !(auction.isFavorite ?? false),
    //     );
    //   }
    //   return auction;
    // }).toList();

    // emit(state.copyWith(similarAuctions: updatedAuction));
  }
}
