import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/auction/auction_review_repo.dart';

part 'auction_review_event.dart';
part 'auction_review_state.dart';

class AuctionReviewBloc extends Bloc<AuctionReviewEvent, AuctionReviewState> {
  final AuctionReviewRepo auctionReviewRepo;
  AuctionReviewBloc(this.auctionReviewRepo) : super(AuctionReviewInitial()) {
    on<AuctionReviewEvent>((event, emit) {});
    on<AddAuctionReview>(_onAddAuctionReview);
  }

  void _onAddAuctionReview(
      AddAuctionReview event, Emitter<AuctionReviewState> emit) async {
    emit(AddAuctionReviewLoading());
    try {
      final response = await auctionReviewRepo.addAuctionReview(
          event.auctionId, event.review);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddAuctionReviewSuccess());
      } else {
        emit(AddAuctionReviewError(
            response.body['message'] ?? 'Failed to add review'));
      }
      // If successful
    } catch (e) {
      emit(AddAuctionReviewError(e.toString()));
    }
  }
}
