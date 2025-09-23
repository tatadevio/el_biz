part of 'auction_bids_list_bloc.dart';

sealed class AuctionBidsListEvent extends Equatable {
  const AuctionBidsListEvent();

  @override
  List<Object> get props => [];
}

final class GetAuctionBids extends AuctionBidsListEvent {
  final int auctionId;

  const GetAuctionBids({required this.auctionId});

  @override
  List<Object> get props => [auctionId];
}

final class RemoveBidFromList extends AuctionBidsListEvent {
  final int bidId;

  const RemoveBidFromList({required this.bidId});

  @override
  List<Object> get props => [bidId];
}
