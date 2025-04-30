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
  }

  Future<void> _onGetTenderDetail(
      GetTenderDetail event, Emitter<TenderDetailState> emit) async {
    emit(TenderDetailLoading());
    try {
      final response = await tenderDetailRepo.getTenderDetail(event.tenderId);
      if (response.statusCode == 200) {
        final tenderDetail = TenderDetailModel.fromJson(response.body);
        emit(TenderDetailSuccess(
          tenderDetailModel: tenderDetail,
        ));
      } else {
        emit(TenderDetailError());
      }
    } catch (e) {
      emit(TenderDetailError());
    }
  }
}
