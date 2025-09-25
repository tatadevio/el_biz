part of 'auction_buy_offer_bloc.dart';

sealed class AuctionBuyOfferEvent extends Equatable {
  const AuctionBuyOfferEvent();

  @override
  List<Object> get props => [];
}

final class SubmitAuctionBuyOfferEvent extends AuctionBuyOfferEvent {
  final int auctionId;
  final double offerAmount;
  const SubmitAuctionBuyOfferEvent(this.auctionId, this.offerAmount);

  @override
  List<Object> get props => [auctionId, offerAmount];
}
