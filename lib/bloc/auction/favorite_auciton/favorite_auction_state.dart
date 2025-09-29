part of 'favorite_auction_bloc.dart';

sealed class FavoriteAuctionState extends Equatable {
  const FavoriteAuctionState();

  @override
  List<Object> get props => [];
}

final class FavoriteAuctionInitial extends FavoriteAuctionState {}

class AuctionDetailFavoriteLoading extends FavoriteAuctionState {}

class AuctionDetailFavoriteError extends FavoriteAuctionState {
  final String error;
  const AuctionDetailFavoriteError(this.error);
}

class AuctionDetailFavoriteSuccess extends FavoriteAuctionState {
  final String message;
  const AuctionDetailFavoriteSuccess(this.message);
}
