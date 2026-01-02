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
    on<UpdateAuctionStatus>(_onUpdateAuctionStatus);
    on<AuctionBidClosed>(_onAuctionBidClosed);
    on<AuctionBidOpen>(_onAuctionBidOpen);
  }

  void _onGetAuctionDetail(
      GetAuctionDetail event, Emitter<AuctionDetailState> emit) async {
    emit(AuctionDetailLoading());
    // if (event.isRefresh == true) {
    // } else {
    //   emit(AuctionDetailLoaderInvisible());
    // }
    event.context.read<AuctionBidsListBloc>().add(
        GetAuctionBids(auctionId: event.auctionId, isRefresh: event.isRefresh));
    // try {
    final response = await auctionDetailRepo.getAuctionDetail(event.auctionId);
    if (response.statusCode == 200) {
      emit(AuctionDetailSuccess(AuctionDetailModel.fromJson(response.body)));
    } else {
      emit(AuctionDetailError(
          response.body['message'] ?? "Something went wrong"));
    }
    // } catch (e) {
    //   emit(AuctionDetailError(e.toString()));
    // }
  }

  void _onUpdateAuctionStatus(
      UpdateAuctionStatus event, Emitter<AuctionDetailState> emit) {
    if (state is AuctionDetailSuccess) {
      final currentState = state as AuctionDetailSuccess;
      final updatedAuction = currentState.auctionDetailModel.data;
      // updatedAuction?.status = event.status;
      updatedAuction?.copyWith(status: event.status);
      emit(AuctionDetailSuccess(AuctionDetailModel(data: updatedAuction)));
    }
  }

  void _onAuctionBidClosed(
      AuctionBidClosed event, Emitter<AuctionDetailState> emit) async {
    emit(AuctionDetailLoading());
    final response = await auctionDetailRepo.closeAuctionBid(event.auctionId);
    if (response.statusCode == 200) {
      event.context.read<AuctionDetailBloc>().add(
          GetAuctionDetail(auctionId: event.auctionId, context: event.context));
    } else {
      emit(AuctionDetailError(
          response.body['message'] ?? "Something went wrong"));
    }
  }

  void _onAuctionBidOpen(
      AuctionBidOpen event, Emitter<AuctionDetailState> emit) async {
    emit(AuctionDetailLoading());
    final response = await auctionDetailRepo.openAuctionBid(event.auctionId);
    if (response.statusCode == 200) {
      event.context.read<AuctionDetailBloc>().add(
          GetAuctionDetail(auctionId: event.auctionId, context: event.context));
    } else {
      emit(AuctionDetailError(
          response.body['message'] ?? "Something went wrong"));
    }
  }
}
