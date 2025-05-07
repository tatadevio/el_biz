import 'package:el_biz/data/model/response/tender/tender_detail_model.dart';
import 'package:el_biz/data/repo/tender_detail_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tender_detail_event.dart';
part 'tender_detail_state.dart';

class TenderDetailBloc extends Bloc<TenderDetailEvent, TenderDetailState> {
  final TenderDetailRepo tenderDetailRepo;
  TenderDetailBloc(this.tenderDetailRepo) : super(TenderDetailInitial()) {
    // on<TenderDetailEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<GetTenderDetail>(_onGetTenderDetail);
    on<ChangeTenderStatus>(_onChangeTenderStatus);
  }

  Future<void> _onGetTenderDetail(
      GetTenderDetail event, Emitter<TenderDetailState> emit) async {
    emit(TenderDetailLoading());
    try {
      final response = await tenderDetailRepo.getTenderDetail(event.tenderId);
      if (response.statusCode == 200) {
        final tenderDetail = TenderDetailModel.fromJson(response.body);
        // emit(TenderDetailSuccess(
        //   tenderDetailModel: tenderDetail,
        // ));
        emit(state.copyWith(tenderDetailModel: tenderDetail));
      } else {
        emit(TenderDetailError());
      }
    } catch (e) {
      emit(TenderDetailError());
    }
  }

  Future<void> _onChangeTenderStatus(
      ChangeTenderStatus event, Emitter<TenderDetailState> emit) async {
    // emit(state.copyWith(statusUpdating: true));
    try {
      final response = await tenderDetailRepo.changeTenderStatus(
          event.tenderId, event.status);
      if (response.statusCode == 200) {
        // final updatedProductDetail = state.productDetailModel!.data!.copyWith(
        //   status: event.status,
        // );

        // emit(state.copywith(
        //   productDetailModel:
        //       state.productDetailModel?.copyWith(data: updatedProductDetail),
        // ));
      } else {
        // emit(ProductDetailError(response.body['message']));
      }
    } catch (e) {
      // emit(ProductDetailError(e.toString()));
    }

    // emit(state.copywith(statusUpdating: false));
  }
}
