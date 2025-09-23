part of 'auction_bid_bloc.dart';

sealed class AuctionBidState extends Equatable {
  const AuctionBidState();
  
  @override
  List<Object> get props => [];
}

final class AuctionBidInitial extends AuctionBidState {}

class AddAuctionBidLoading extends AuctionBidState {}

class AddAuctionBidSuccess extends AuctionBidState {}

class AddAuctionBidError extends AuctionBidState {
  final String message;
  const AddAuctionBidError(this.message);
}

class CancelAuctionBidLoading extends AuctionBidState {}

class CancelAuctionBidSuccess extends AuctionBidState {}

class CancelAuctionBidError extends AuctionBidState {
  final String message;
  const CancelAuctionBidError(this.message);
}
