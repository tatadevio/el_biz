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
  final String orderBy;
  final String direction;

  const GetAuctions(
      {this.page = 1,
      this.isRefresh = false,
      this.orderBy = 'created_at',
      this.direction = 'desc'});

  @override
  List<Object> get props => [page, isRefresh, orderBy, direction];
}

class TogglePublicAuctionsFavorite extends AuctionsEvent {
  final int auctionId;
  final BuildContext context;
  final bool isFavorite;

  const TogglePublicAuctionsFavorite(
      {required this.auctionId,
      required this.context,
      required this.isFavorite});

  @override
  List<Object> get props => [auctionId, context, isFavorite];
}

class UpdateAuctionInFavoriteList extends AuctionsEvent {
  final int auctionId;
  final bool isFavorite;

  const UpdateAuctionInFavoriteList(
      {required this.auctionId, required this.isFavorite});

  @override
  List<Object> get props => [auctionId, isFavorite];
}

class UpdateAuctionsFilterEnable extends AuctionsEvent {
  final bool isEnable;
  const UpdateAuctionsFilterEnable(this.isEnable);

  @override
  List<Object> get props => [isEnable];
}

class GetMyAuctions extends AuctionsEvent {
  final int page;
  final bool isRefresh;
  final String orderBy;
  final String direction;

  const GetMyAuctions(
      {this.page = 1,
      this.isRefresh = false,
      this.orderBy = 'created_at',
      this.direction = 'desc'});

  @override
  List<Object> get props => [page, isRefresh, orderBy, direction];
}


class GetMyBidAuctions extends AuctionsEvent {
  final int page;
  final bool isRefresh;
  final String orderBy;
  final String direction;

  const GetMyBidAuctions(
      {this.page = 1,
      this.isRefresh = false,
      this.orderBy = 'created_at',
      this.direction = 'desc'});

  @override
  List<Object> get props => [page, isRefresh, orderBy, direction];
}