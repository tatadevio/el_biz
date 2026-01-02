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

class GetBuyOffersEvent extends AuctionBuyOfferEvent {
  final int auctionId;
  const GetBuyOffersEvent(this.auctionId);

  @override
  List<Object> get props => [auctionId];
}

class RespondToBuyOfferEvent extends AuctionBuyOfferEvent {
  final int offerId;
  // final bool isAccepted;
  const RespondToBuyOfferEvent(
    this.offerId,
  );

  @override
  List<Object> get props => [offerId];
}
