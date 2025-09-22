part of 'auctions_bloc.dart';

sealed class AuctionsEvent extends Equatable {
  const AuctionsEvent();

  @override
  List<Object> get props => [];
}

class UpdateAuctionGridView extends AuctionsEvent {
  final bool isGridView;

  const UpdateAuctionGridView(this.isGridView);

  @override
  List<Object> get props => [isGridView];
}

class GetAuctions extends AuctionsEvent {
  final int page;
  final bool isRefresh;

  const GetAuctions({this.page = 1, this.isRefresh = false});

  @override
  List<Object> get props => [page, isRefresh];
}

class AddAuctionBid extends AuctionsEvent {
  final int auctionId;
  final double bidAmount;

  const AddAuctionBid({required this.auctionId, required this.bidAmount});

  @override
  List<Object> get props => [auctionId, bidAmount];
}

class CancelAuctionBid extends AuctionsEvent {
  final int auctionId;
  final int bidId;

  const CancelAuctionBid({required this.auctionId, required this.bidId});

  @override
  List<Object> get props => [auctionId, bidId];
}
