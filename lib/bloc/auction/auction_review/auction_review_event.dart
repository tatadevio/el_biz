part of 'auction_review_bloc.dart';

sealed class AuctionReviewEvent extends Equatable {
  const AuctionReviewEvent();

  @override
  List<Object> get props => [];
}

final class AddAuctionReview extends AuctionReviewEvent {
  final int auctionId;
  final String review;

  const AddAuctionReview({
    required this.auctionId,
    required this.review,
  });

  @override
  List<Object> get props => [auctionId, review];
}
