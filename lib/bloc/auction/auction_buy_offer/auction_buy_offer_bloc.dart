import 'package:bloc/bloc.dart';
import 'package:el_biz/data/repo/auction/auction_buy_offer_repo.dart';
import 'package:equatable/equatable.dart';

part 'auction_buy_offer_event.dart';
part 'auction_buy_offer_state.dart';

class AuctionBuyOfferBloc
    extends Bloc<AuctionBuyOfferEvent, AuctionBuyOfferState> {
  final AuctionBuyOfferRepo auctionBuyOfferRepo;
  AuctionBuyOfferBloc(this.auctionBuyOfferRepo)
      : super(AuctionBuyOfferInitial()) {
    on<AuctionBuyOfferEvent>((event, emit) {});
    on<SubmitAuctionBuyOfferEvent>(_onSubmitAuctionBuyOfferEvent);
  }

  void _onSubmitAuctionBuyOfferEvent(SubmitAuctionBuyOfferEvent event,
      Emitter<AuctionBuyOfferState> emit) async {
    emit(AuctionBuyOfferLoading());
    try {
      final resposne = await auctionBuyOfferRepo.buyOffer(
          event.auctionId, event.offerAmount);
      if (resposne.statusCode == 200 || resposne.statusCode == 201) {
        emit(AuctionBuyOfferSuccess(
            resposne.body['message'] ?? "Buy offer submitted successfully"));
      } else {
        emit(AuctionBuyOfferFailure(
            resposne.body['message'] ?? "Failed to submit buy offer"));
      }
    } catch (e) {
      emit(AuctionBuyOfferFailure("Failed to submit buy offer: $e"));
    }
  }
}
