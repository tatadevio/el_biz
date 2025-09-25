part of 'auction_buy_offer_bloc.dart';

sealed class AuctionBuyOfferState extends Equatable {
  const AuctionBuyOfferState();

  @override
  List<Object> get props => [];
}

final class AuctionBuyOfferInitial extends AuctionBuyOfferState {}

class AuctionBuyOfferLoading extends AuctionBuyOfferState {}

class AuctionBuyOfferSuccess extends AuctionBuyOfferState {
  final String message;
  const AuctionBuyOfferSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AuctionBuyOfferFailure extends AuctionBuyOfferState {
  final String errorMessage;
  const AuctionBuyOfferFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
