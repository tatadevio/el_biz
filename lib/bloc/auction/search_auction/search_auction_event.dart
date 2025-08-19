part of 'search_auction_bloc.dart';

sealed class SearchAuctionEvent extends Equatable {
  const SearchAuctionEvent();

  @override
  List<Object> get props => [];
}

class ClearSearchAuctionList extends SearchAuctionEvent{}

class SearchAuction extends SearchAuctionEvent {
  final String search;
  final int currentPage;

  const SearchAuction({required this.search, required this.currentPage});

  @override
  List<Object> get props => [search, currentPage];
}
