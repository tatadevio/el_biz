part of 'similar_auctions_bloc.dart';

sealed class SimilarAuctionsEvent extends Equatable {
  const SimilarAuctionsEvent();

  @override
  List<Object> get props => [];
}

class GetSimilarAuctions extends SimilarAuctionsEvent {
  final String auctionId;
  final int currentPage;
  const GetSimilarAuctions(
      {required this.auctionId, required this.currentPage});

  @override
  List<Object> get props => [auctionId, currentPage];
}

class ToggleFavoriteSimilarAuctionInList extends SimilarAuctionsEvent {
  final String auctionId;
  const ToggleFavoriteSimilarAuctionInList({required this.auctionId});

  @override
  List<Object> get props => [auctionId];
}

class ToggleFavoriteSimilarAuction extends SimilarAuctionsEvent {
  final String auctionId;
  final BuildContext context;
  const ToggleFavoriteSimilarAuction(
      {required this.auctionId, required this.context});

  @override
  List<Object> get props => [auctionId, context];
}
