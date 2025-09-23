part of 'auction_bid_bloc.dart';

sealed class AuctionBidEvent extends Equatable {
  const AuctionBidEvent();

  @override
  List<Object> get props => [];
}


class AddAuctionBid extends AuctionBidEvent {
  final int auctionId;
  final double bidAmount;

  const AddAuctionBid({required this.auctionId, required this.bidAmount});

  @override
  List<Object> get props => [auctionId, bidAmount];
}

class CancelAuctionBid extends AuctionBidEvent {
  final int auctionId;
  final int bidId;
  final BuildContext context;

  const CancelAuctionBid({required this.auctionId, required this.bidId, required this.context});

  @override
  List<Object> get props => [auctionId, bidId, context];
}
