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

  const AuctionsState({
    this.isGridView = true,
    this.auctions = const [],
    this.filteredAuctions = const [],
    this.isFilterEnable = false,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.totalPages = 1,
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
        totalPages
      ];
}

final class AuctionsInitial extends AuctionsState {}

class AddAuctionBidLoading extends AuctionsState {}

class AddAuctionBidSuccess extends AuctionsState {}

class AddAuctionBidError extends AuctionsState {
  final String message;
  const AddAuctionBidError(this.message);
}

class CancelAuctionBidLoading extends AuctionsState {}

class CancelAuctionBidSuccess extends AuctionsState {}

class CancelAuctionBidError extends AuctionsState {
  final String message;
  const CancelAuctionBidError(this.message);
}
