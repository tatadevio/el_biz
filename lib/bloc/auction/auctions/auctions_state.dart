part of 'auctions_bloc.dart';

class AuctionsState extends Equatable {
  final bool isGridView;
  final List<AuctionListItem> auctions;
  final List<AuctionListItem> filteredAuctions;
  final bool isFilterEnable;
  final bool isLoading;
  final bool isLoadingMore;
  final int currentPage;
  final int totalPages;
  final int filteredCurrentpage;
  final int filteredTotalPages;
  final List<AuctionListItem> myAuctions;
  final bool myAuctionsLoading;
  final bool myAuctionsLoadingMore;
  final int myAuctionsCurrentPage;
  final int myAuctionsTotalPages;

    final List<AuctionListItem> myBidAuctions;
  final bool myBidAuctionsLoading;
  final bool myBidAuctionsLoadingMore;
  final int myBidAuctionsCurrentPage;
  final int myBidAuctionsTotalPages;

  const AuctionsState({
    this.isGridView = true,
    this.auctions = const [],
    this.filteredAuctions = const [],
    this.isFilterEnable = false,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.totalPages = 1,
    this.filteredCurrentpage = 1,
    this.filteredTotalPages = 1,
    this.myAuctions = const [],
    this.myAuctionsLoading = false,
    this.myAuctionsLoadingMore = false,
    this.myAuctionsCurrentPage = 1,
    this.myAuctionsTotalPages = 1,
        this.myBidAuctions = const [],
    this.myBidAuctionsLoading = false,
    this.myBidAuctionsLoadingMore = false,
    this.myBidAuctionsCurrentPage = 1,
    this.myBidAuctionsTotalPages = 1,
  });

  AuctionsState copyWith({
    bool? isGridView,
    List<AuctionListItem>? auctions,
    List<AuctionListItem>? filteredAuctions,
    bool? isFilterEnable,
    bool? isLoading,
    bool? isLoadingMore,
    int? currentPage,
    int? totalPages,
    int? filteredCurrentpage,
    int? filteredTotalPages,
    List<AuctionListItem>? myAuctions,
    bool? myAuctionsLoading,
    bool? myAuctionsLoadingMore,
    int? myAuctionsCurrentPage,
    int? myAuctionsTotalPages,
       List<AuctionListItem>? myBidAuctions,
    bool? myBidAuctionsLoading,
    bool? myBidAuctionsLoadingMore,
    int? myBidAuctionsCurrentPage,
    int? myBidAuctionsTotalPages,
  }) {
    return AuctionsState(
      isGridView: isGridView ?? this.isGridView,
      auctions: auctions ?? this.auctions,
      filteredAuctions: filteredAuctions ?? this.filteredAuctions,
      isFilterEnable: isFilterEnable ?? this.isFilterEnable,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      filteredCurrentpage: filteredCurrentpage ?? this.filteredCurrentpage,
      filteredTotalPages: filteredTotalPages ?? this.filteredTotalPages,
      myAuctions: myAuctions ?? this.myAuctions,
      myAuctionsLoading: myAuctionsLoading ?? this.myAuctionsLoading,
      myAuctionsLoadingMore:
          myAuctionsLoadingMore ?? this.myAuctionsLoadingMore,
      myAuctionsCurrentPage:
          myAuctionsCurrentPage ?? this.myAuctionsCurrentPage,
      myAuctionsTotalPages: myAuctionsTotalPages ?? this.myAuctionsTotalPages,
        myBidAuctions: myBidAuctions ?? this.myBidAuctions,
      myBidAuctionsLoading: myBidAuctionsLoading ?? this.myBidAuctionsLoading,
      myBidAuctionsLoadingMore:
          myBidAuctionsLoadingMore ?? this.myBidAuctionsLoadingMore,
      myBidAuctionsCurrentPage:
          myBidAuctionsCurrentPage ?? this.myBidAuctionsCurrentPage,
      myBidAuctionsTotalPages:  myBidAuctionsTotalPages ?? this.myBidAuctionsTotalPages,

    );
  }

  @override
  List<Object> get props => [
        isGridView,
        auctions,
        filteredAuctions,
        isFilterEnable,
        isLoading,
        isLoadingMore,
        currentPage,
        totalPages,
        filteredCurrentpage,
        filteredTotalPages,
        myAuctions,
        myAuctionsLoading,
        myAuctionsLoadingMore,
        myAuctionsCurrentPage,
        myAuctionsTotalPages,
        myBidAuctions,
        myBidAuctionsLoading,
        myBidAuctionsLoadingMore,
        myBidAuctionsCurrentPage,
        myBidAuctionsTotalPages,
      ];
}

final class AuctionsInitial extends AuctionsState {}
