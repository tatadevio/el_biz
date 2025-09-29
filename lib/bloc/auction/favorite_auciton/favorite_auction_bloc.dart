import 'package:el_biz/data/repo/auction/favorite_auction_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_auction_event.dart';
part 'favorite_auction_state.dart';

class FavoriteAuctionBloc
    extends Bloc<FavoriteAuctionEvent, FavoriteAuctionState> {
  final FavoriteAuctionRepo favoriteAuctionRepo;
  FavoriteAuctionBloc(this.favoriteAuctionRepo)
      : super(FavoriteAuctionInitial()) {
    on<FavoriteAuctionEvent>((event, emit) {});
    on<ToggleAuctionDetailFavorite>(_onToggleAuctionDetailFavorite);
    on<RemoveAuctionFromFavoriteList>(_onRemoveAuctionFromFavoriteList);
  }

  Future<void> _onToggleAuctionDetailFavorite(ToggleAuctionDetailFavorite event,
      Emitter<FavoriteAuctionState> emit) async {
    emit(AuctionDetailFavoriteLoading());
    try {
      final response =
          await favoriteAuctionRepo.toggleFavorite(event.auctionId.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AuctionDetailFavoriteSuccess(response.body['message']));
      } else {
        emit(AuctionDetailFavoriteError(response.body['message']));
      }
    } catch (e) {
      emit(AuctionDetailFavoriteError(e.toString()));
    }
  }

  Future<void> _onRemoveAuctionFromFavoriteList(
    RemoveAuctionFromFavoriteList event,
    Emitter<FavoriteAuctionState> emit,
  ) async {
    // List<AuctionDetailData> allTenders = List.from(state.auctions);

    // final index =
    //     allAuctions.indexWhere((tender) => tender.id == event.tenderId);

    // if (index != -1) {
    //   allTenders.removeAt(index);
    //   emit(state.copyWith(favoriteTenders: allTenders));
    // } else {
    //   // Product not found, no action needed, optionally re-emit same state
    //   emit(state);
    // }
  }
}
