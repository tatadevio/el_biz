part of 'auction_bids_list_bloc.dart';

class AuctionBidsListState extends Equatable {
  final bool isLoading;
  final List<AuctionBidItem> auctionBids;
  const AuctionBidsListState({
    this.isLoading = false,
    this.auctionBids = const [],
  });

  AuctionBidsListState copyWith({
    bool? isLoading,
    List<AuctionBidItem>? auctionBids,
    int? currentPage,
    int? totalPages,
    bool? isLoadingMore,
  }) {
    return AuctionBidsListState(
      isLoading: isLoading ?? this.isLoading,
      auctionBids: auctionBids ?? this.auctionBids,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        auctionBids,
      ];
}

final class AuctionBidsListInitial extends AuctionBidsListState {}
