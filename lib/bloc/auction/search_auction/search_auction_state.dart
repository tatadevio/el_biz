part of 'search_auction_bloc.dart';

class SearchAuctionState extends Equatable {
  final List<AuctionListItem> searchAuctions;
  final int currentPage;
  final int pageSize;
  final bool isLoading;
  final bool isMoreLoading;
  const SearchAuctionState({
    this.searchAuctions = const [],
    this.currentPage = 1,
    this.pageSize = 1,
    this.isLoading = false,
    this.isMoreLoading = false,
  });

  SearchAuctionState copyWith({
    List<AuctionListItem>? searchAuctions,
    int? currentPage,
    int? pageSize,
    bool? isLoading,
    bool? isMoreLoading,
  }) {
    return SearchAuctionState(
      searchAuctions: searchAuctions ?? this.searchAuctions,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      isLoading: isLoading ?? this.isLoading,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
    );
  }

  @override
  List<Object> get props =>
      [searchAuctions, currentPage, pageSize, isLoading, isMoreLoading];
}

final class SearchAuctionInitial extends SearchAuctionState {}
