part of 'auction_cancel_bloc.dart';

sealed class AuctionCancelEvent extends Equatable {
  const AuctionCancelEvent();

  @override
  List<Object> get props => [];
}

class CancelAuction extends AuctionCancelEvent {
  final int auctionId;
  const CancelAuction({required this.auctionId});

  @override
  List<Object> get props => [auctionId];
}

class PublishCanceledAuction extends AuctionCancelEvent {
  final int auctionId;
  const PublishCanceledAuction({required this.auctionId});

  @override
  List<Object> get props => [auctionId];
}

