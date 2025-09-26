part of 'auction_cancel_bloc.dart';

sealed class AuctionCancelState extends Equatable {
  const AuctionCancelState();

  @override
  List<Object> get props => [];
}

final class AuctionCancelInitial extends AuctionCancelState {}

final class CancelAuctionLoading extends AuctionCancelState {}

final class CancelAuctionSuccess extends AuctionCancelState {}

final class CancelAuctionError extends AuctionCancelState {
  final String message;
  const CancelAuctionError(this.message);
}

// final class PublishCanceledAuction extends AuctionCancelState {}

final class PublishCanceledAuctionLoading extends AuctionCancelState {}

final class PublishCanceledAuctionSuccess extends AuctionCancelState {}

final class PublishCanceledAuctionError extends AuctionCancelState {
  final String message;
  const PublishCanceledAuctionError(this.message);
}
