import 'package:bloc/bloc.dart';
import 'package:el_biz/data/model/response/auction/auctions_list_model.dart';
import 'package:el_biz/data/repo/auction/add_auction_repo.dart';
import 'package:el_biz/helper/api_error_service.dart';
import 'package:equatable/equatable.dart';

part 'add_auction_event.dart';
part 'add_auction_state.dart';

class AddAuctionBloc extends Bloc<AddAuctionEvent, AddAuctionState> {
  final AddAuctionRepo addAuctionRepo;
  AddAuctionBloc(this.addAuctionRepo) : super(AddAuctionInitial()) {
    on<AddAuctionEvent>((event, emit) {});
    on<AddNewAuction>(_addNewAuction);
  }

  Future _addNewAuction(
      AddNewAuction event, Emitter<AddAuctionState> emit) async {
    emit(AddAuctionLoader());
    try {
      final response = await addAuctionRepo.addNewAuction(event.auctionData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        AuctionListItem auctionItem =
            AuctionListItem.fromJson(response.body['data']);
        emit(AddAuctionSuccess(auctionItem));
      } else {
        // final apiError = ApiErrorService.normalize(response.body);
        if (response.statusCode == 422) {
          String? error;
          error = ApiErrorService.toUserMessage(
              ApiErrorService.normalize(response.body));

          emit(AddAuctionError(error));
        } else {
          emit(AddAuctionError(response.body['message'] ??
              'Failed to add auction. Please try again later.'));
        }
      }
    } catch (e) {
      emit(AddAuctionError(e.toString()));
    }
  }
}
