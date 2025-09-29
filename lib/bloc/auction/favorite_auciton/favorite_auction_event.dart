part of 'favorite_auction_bloc.dart';

sealed class FavoriteAuctionEvent extends Equatable {
  const FavoriteAuctionEvent();

  @override
  List<Object> get props => [];
}

class ToggleAuctionDetailFavorite extends FavoriteAuctionEvent {
  final int auctionId;
  // final BuildContext context;
  const ToggleAuctionDetailFavorite({required this.auctionId});

  @override
  List<Object> get props => [auctionId];
}

class RemoveAuctionFromFavoriteList extends FavoriteAuctionEvent {
  final int auctionId;
  const RemoveAuctionFromFavoriteList({required this.auctionId});

  @override
  
  List<Object> get props => [auctionId];
}
