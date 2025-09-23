part of 'auctions_bloc.dart';

sealed class AuctionsEvent extends Equatable {
  const AuctionsEvent();

  @override
  List<Object> get props => [];
}

class UpdateAuctionGridView extends AuctionsEvent {
  final bool isGridView;

  const UpdateAuctionGridView(this.isGridView);

  @override
  List<Object> get props => [isGridView];
}

class GetAuctions extends AuctionsEvent {
  final int page;
  final bool isRefresh;

  const GetAuctions({this.page = 1, this.isRefresh = false});

  @override
  List<Object> get props => [page, isRefresh];
}

