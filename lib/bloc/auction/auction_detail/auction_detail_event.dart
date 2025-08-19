part of 'auction_detail_bloc.dart';

sealed class AuctionDetailEvent extends Equatable {
  const AuctionDetailEvent();

  @override
  List<Object> get props => [];
}

class GetAuctionDetail extends AuctionDetailEvent {
  final String auctionId;
  const GetAuctionDetail({required this.auctionId});

  @override
  List<Object> get props => [auctionId];
}
