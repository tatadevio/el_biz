import 'package:el_biz/data/model/response/auction/auction_bids_model.dart';
import 'package:el_biz/data/repo/auction/auction_bids_list_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_connect/http/src/response/response.dart';

part 'auction_bids_list_event.dart';
part 'auction_bids_list_state.dart';

class AuctionBidsListBloc
    extends Bloc<AuctionBidsListEvent, AuctionBidsListState> {
  final AuctionBidsListRepo auctionBidsListRepo;
  AuctionBidsListBloc(this.auctionBidsListRepo)
      : super(AuctionBidsListInitial()) {
    on<AuctionBidsListEvent>((event, emit) {});
    on<GetAuctionBids>(_onGetAuctionBids);
    on<RemoveBidFromList>(_onRemoveBidFromList);
  }

  void _onGetAuctionBids(
      GetAuctionBids event, Emitter<AuctionBidsListState> emit) async {
    emit(state.copyWith(isLoading: true, auctionBids: []));

    // try {
    Response response =
        await auctionBidsListRepo.getAuctionBids(event.auctionId);
    print('list of bids is ${response.body} ');
    print('list of bids is code ${response.statusCode} ');
    if (response.statusCode == 200 || response.statusCode == 201) {
      AuctionBidsModel auctionBids = AuctionBidsModel.fromJson(response.body);
      List<AuctionBidItem> fetchedBids = auctionBids.data?.items ?? [];

      // List<AuctionBidItem> allBids = [];
      // if (event.currentPage == 1) {
      //   allBids = fetchedBids;
      // } else {
      //   allBids = [...state.auctionBids, ...fetchedBids];
      // }

      emit(state.copyWith(
        isLoading: false,
        auctionBids: fetchedBids,
      ));
    }
    // } catch (e) {
    //   emit(state.copyWith(isLoading: false, isLoadingMore: false));
    // }
  }

  void _onRemoveBidFromList(
      RemoveBidFromList event, Emitter<AuctionBidsListState> emit) {
    List<AuctionBidItem> updatedBids = state.auctionBids
        .where((bid) => bid.id != event.bidId)
        .toList();

    emit(state.copyWith(auctionBids: updatedBids));
  }
}
