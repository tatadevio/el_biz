import 'package:bloc/bloc.dart';
import 'package:el_biz/data/repo/auction/auction_buy_offer_repo.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/response/auction/get_buy_offer_model.dart';

part 'auction_buy_offer_event.dart';
part 'auction_buy_offer_state.dart';

class AuctionBuyOfferBloc
    extends Bloc<AuctionBuyOfferEvent, AuctionBuyOfferState> {
  final AuctionBuyOfferRepo auctionBuyOfferRepo;
  AuctionBuyOfferBloc(this.auctionBuyOfferRepo)
      : super(AuctionBuyOfferInitial()) {
    on<AuctionBuyOfferEvent>((event, emit) {});
    on<SubmitAuctionBuyOfferEvent>(_onSubmitAuctionBuyOfferEvent);
    on<GetBuyOffersEvent>(_onGetBuyOffersEvent);
    on<RespondToBuyOfferEvent>(_onRespondToBuyOfferEvent);
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

  void _onGetBuyOffersEvent(
      GetBuyOffersEvent event, Emitter<AuctionBuyOfferState> emit) async {
    emit(AuctionGetBuyOffersLoading());
    try {
      final response = await auctionBuyOfferRepo.getBuyOffers(event.auctionId);
      if (response.statusCode == 200) {
        GetBuyOfferModel buyOfferModel =
            GetBuyOfferModel.fromJson(response.body);
        List<BuyOfferData> buyOffers = buyOfferModel.data ?? [];
        emit(AuctionGetBuyOffersLoaded(buyOffers));
      } else {
        emit(AuctionGetBuyOfferFailure(
            response.body['message'] ?? "Failed to load buy offers"));
      }
    } catch (e) {
      emit(AuctionGetBuyOfferFailure("Failed to load buy offers: $e"));
    }
  }

  void _onRespondToBuyOfferEvent(
      RespondToBuyOfferEvent event, Emitter<AuctionBuyOfferState> emit) async {
    emit(AuctionRespondToBuyOfferLoading());
    try {
      final response =
          await auctionBuyOfferRepo.respondToBuyOffer(event.offerId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AuctionRespondToBuyOfferSuccess(
            response.body['message'] ?? "Response submitted successfully"));
      } else {
        emit(AuctionResponsdToBuyOfferFailure(
            response.body['message'] ?? "Failed to submit response"));
      }
    } catch (e) {
      emit(AuctionResponsdToBuyOfferFailure("Failed to submit response: $e"));
    }
  }
}
