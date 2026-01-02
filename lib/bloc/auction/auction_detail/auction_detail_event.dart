part of 'auction_detail_bloc.dart';

sealed class AuctionDetailEvent extends Equatable {
  const AuctionDetailEvent();

  @override
  List<Object> get props => [];
}

class GetAuctionDetail extends AuctionDetailEvent {
  final int auctionId;
  final BuildContext context;
  final bool isRefresh;
  const GetAuctionDetail(
      {required this.auctionId, required this.context, this.isRefresh = true});

  @override
  List<Object> get props => [auctionId, context, isRefresh];
}

class UpdateAuctionStatus extends AuctionDetailEvent {
  final String status;
  const UpdateAuctionStatus({required this.status});
  @override
  List<Object> get props => [status];
}

class AuctionBidClosed extends AuctionDetailEvent {
  final int auctionId;
  final BuildContext context;
  const AuctionBidClosed({required this.auctionId, required this.context});

  @override
  List<Object> get props => [auctionId, context];
}

class AuctionBidOpen extends AuctionDetailEvent {
  final int auctionId;
  final BuildContext context;
  const AuctionBidOpen({required this.auctionId, required this.context});

  @override
  List<Object> get props => [auctionId, context];
}
