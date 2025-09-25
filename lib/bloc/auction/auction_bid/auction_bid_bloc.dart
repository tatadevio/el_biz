import 'package:el_biz/bloc/auction/auction_detail/auction_detail_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/auction/auction_bid_repo.dart';
import '../auction_bids_list/auction_bids_list_bloc.dart';

part 'auction_bid_event.dart';
part 'auction_bid_state.dart';

class AuctionBidBloc extends Bloc<AuctionBidEvent, AuctionBidState> {
  final AuctionBidRepo auctionBidRepo;
  AuctionBidBloc(this.auctionBidRepo) : super(AuctionBidInitial()) {
    on<AuctionBidEvent>((event, emit) {});
    on<AddAuctionBid>(_addAuctionBid);
    on<CancelAuctionBid>(_cancelAuctionBid);
  }

  void _addAuctionBid(
      AddAuctionBid event, Emitter<AuctionBidState> emit) async {
    emit(AddAuctionBidLoading());
    try {
      final response =
          await auctionBidRepo.addAuctionBid(event.auctionId, event.bidAmount);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddAuctionBidSuccess());
      } else {
        String errorMessage = response.body['message'] ?? 'Failed to place bid';

        emit(AddAuctionBidError(errorMessage));
      }
    } catch (e) {
      AddAuctionBidError('An error occurred while placing the bid $e');
    }
  }

  void _cancelAuctionBid(
      CancelAuctionBid event, Emitter<AuctionBidState> emit) async {
    emit(CancelAuctionBidLoading());
    try {
      final response =
          await auctionBidRepo.cancelAuctionBid(event.auctionId, event.bidId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(CancelAuctionBidSuccess());
        print('cancell success and now going to call remove bid from list');
        event.context
            .read<AuctionBidsListBloc>()
            .add(RemoveBidFromList(bidId: event.bidId));
        print('cancell success and now going to call auction detail');

        event.context.read<AuctionDetailBloc>().add(GetAuctionDetail(
            auctionId: event.auctionId,
            context: event.context,
            isRefresh: false));
      } else {
        String errorMessage =
            response.body['message'] ?? 'Failed to cancel bid';
        emit(CancelAuctionBidError(errorMessage));
      }
    } catch (e) {
      emit(CancelAuctionBidError(
          'An error occurred while cancelling the bid $e'));
    }
  }
}
