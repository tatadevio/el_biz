part of 'search_auction_bloc.dart';

sealed class SearchAuctionEvent extends Equatable {
  const SearchAuctionEvent();

  @override
  List<Object> get props => [];
}

class ClearSearchAuctionList extends SearchAuctionEvent {}

class SearchAuction extends SearchAuctionEvent {
  final String search;
  final int currentPage;

  const SearchAuction({required this.search, required this.currentPage});

  @override
  List<Object> get props => [search, currentPage];
}

class ToggleSearchAuctionsFavorite extends SearchAuctionEvent {
  final int auctionId;
  final BuildContext context;
  final bool isFavorite;

  const ToggleSearchAuctionsFavorite(
      {required this.auctionId,
      required this.context,
      required this.isFavorite});

  @override
  List<Object> get props => [auctionId, context, isFavorite];
}

class UpdateSearchAuctionInFavoriteList extends SearchAuctionEvent {
  final int auctionId;
  final bool isFavorite;

  const UpdateSearchAuctionInFavoriteList(
      {required this.auctionId, required this.isFavorite});

  @override
  List<Object> get props => [auctionId, isFavorite];
}
