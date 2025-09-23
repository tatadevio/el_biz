import 'package:el_biz/bloc/auction/auction_bids_list/auction_bids_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:el_biz/data/repo/auction/auction_detail_repo.dart';

import '../../../data/model/response/auction/auction_detail_model.dart';

part 'auction_detail_event.dart';
part 'auction_detail_state.dart';

class AuctionDetailBloc extends Bloc<AuctionDetailEvent, AuctionDetailState> {
  final AuctionDetailRepo auctionDetailRepo;
  AuctionDetailBloc(this.auctionDetailRepo) : super(AuctionDetailInitial()) {
    on<AuctionDetailEvent>((event, emit) {});
    on<GetAuctionDetail>(_onGetAuctionDetail);
  }

  void _onGetAuctionDetail(
      GetAuctionDetail event, Emitter<AuctionDetailState> emit) async {
    emit(AuctionDetailLoading());
    event.context
        .read<AuctionBidsListBloc>()
        .add(GetAuctionBids(auctionId: event.auctionId));
    try {
      final response =
          await auctionDetailRepo.getAuctionDetail(event.auctionId);
      if (response.statusCode == 200) {
        emit(AuctionDetailSuccess(AuctionDetailModel.fromJson(response.body)));
      } else {
        emit(AuctionDetailError(
            response.body['message'] ?? "Something went wrong"));
      }
    } catch (e) {
      emit(AuctionDetailError(e.toString()));
    }
  }
}
