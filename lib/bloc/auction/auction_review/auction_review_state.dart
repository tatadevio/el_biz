part of 'auction_review_bloc.dart';

sealed class AuctionReviewState extends Equatable {
  const AuctionReviewState();

  @override
  List<Object> get props => [];
}

final class AuctionReviewInitial extends AuctionReviewState {}

class AddAuctionReviewLoading extends AuctionReviewState {}

class AddAuctionReviewSuccess extends AuctionReviewState {}

class AddAuctionReviewError extends AuctionReviewState {
  final String message;
  const AddAuctionReviewError(this.message);
}
