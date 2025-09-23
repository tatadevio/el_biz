part of 'auction_detail_bloc.dart';

sealed class AuctionDetailEvent extends Equatable {
  const AuctionDetailEvent();

  @override
  List<Object> get props => [];
}

class GetAuctionDetail extends AuctionDetailEvent {
  final int auctionId;
  final BuildContext context;
  const GetAuctionDetail({required this.auctionId, required this.context});

  @override
  List<Object> get props => [auctionId, context];
}
