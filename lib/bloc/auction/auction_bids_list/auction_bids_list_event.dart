part of 'auction_bids_list_bloc.dart';

sealed class AuctionBidsListEvent extends Equatable {
  const AuctionBidsListEvent();

  @override
  List<Object> get props => [];
}

 class GetAuctionBids extends AuctionBidsListEvent {
  final int auctionId;
  final bool isRefresh;

  const GetAuctionBids({required this.auctionId, this.isRefresh = true});

  @override
  List<Object> get props => [auctionId, isRefresh];
}

final class RemoveBidFromList extends AuctionBidsListEvent {
  final int bidId;

  const RemoveBidFromList({required this.bidId});

  @override
  List<Object> get props => [bidId];
}
