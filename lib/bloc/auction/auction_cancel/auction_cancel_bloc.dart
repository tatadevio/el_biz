import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/auction/auction_cancel_repo.dart';

part 'auction_cancel_event.dart';
part 'auction_cancel_state.dart';

class AuctionCancelBloc extends Bloc<AuctionCancelEvent, AuctionCancelState> {
  final AuctionCancelRepo auctionCancelRepo;
  AuctionCancelBloc(this.auctionCancelRepo) : super(AuctionCancelInitial()) {
    on<AuctionCancelEvent>((event, emit) {});

    on<CancelAuction>(_onCancelAuction);
  }

  void _onCancelAuction(
      CancelAuction event, Emitter<AuctionCancelState> emit) async {
    emit(CancelAuctionLoading());
    try {
      final response = await auctionCancelRepo.cancelAuction(event.auctionId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(CancelAuctionSuccess());
      } else {
        String errorMessage =
            response.body['message'] ?? 'Failed to cancel auction';
        emit(CancelAuctionError(errorMessage));
      }
      // Assuming the operation is successful
    } catch (e) {
      emit(CancelAuctionError(
          'An error occurred while cancelling the auction: $e'));
    }
  }
}
