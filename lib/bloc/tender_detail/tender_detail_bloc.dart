import 'package:el_biz/bloc/public_tender/public_tender_bloc.dart';
import 'package:el_biz/data/model/response/tender/tender_detail_model.dart';
import 'package:el_biz/data/repo/tender_detail_repo.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../company_detail/company_detail_bloc.dart';

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
    on<ToggleTenderDetailFavorite>(_onToggleTenderDetailFavorite);
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
    emit(state.copyWith(statusUpdating: true));
    try {
      final response = await tenderDetailRepo.changeTenderStatus(
          event.tenderId, event.status);
      if (response.statusCode == 200) {
        final updatedProductDetail = state.tenderDetailModel!.data!.copyWith(
          status: event.status,
        );

        emit(state.copyWith(
          tenderDetailModel:
              state.tenderDetailModel?.copyWith(data: updatedProductDetail),
        ));
      } else {
        // emit(ProductDetailError(response.body['message']));
        showShortToast(response.body['message']);
      }
    } catch (e) {
      // emit(TenderDetailError(e.toString()));
      showShortToast(e.toString());
    }

    emit(state.copyWith(statusUpdating: false));
  }

  Future<void> _onToggleTenderDetailFavorite(
      ToggleTenderDetailFavorite event, Emitter<TenderDetailState> emit) async {
    final currentModel = state.tenderDetailModel!;
    final updatedData = currentModel.data!.copyWith(
      isFavorite: !(currentModel.data!.isFavorite ?? false),
    );
    final updatedModel = currentModel.copyWith(data: updatedData);
    emit(state.copyWith(tenderDetailModel: updatedModel));

    try {
      final response = await tenderDetailRepo
          .toggleFavorite(state.tenderDetailModel!.data!.id.toString());
      if (response.statusCode == 200) {
        // update favorite

        // ignore: use_build_context_synchronously
        event.context.read<CompanyDetailBloc>().add(ToggleFavoriteTenderInList(
            tenderId: state.tenderDetailModel!.data!.id!));

        event.context.read<PublicTenderBloc>().add(
            ToggleFavoritePublicTenderInList(
                tenderId: state.tenderDetailModel!.data!.id!));
      } else {
        final currentModel = state.tenderDetailModel!;
        final updatedData = currentModel.data!.copyWith(
          isFavorite: !(currentModel.data!.isFavorite ?? false),
        );
        final updatedModel = currentModel.copyWith(data: updatedData);
        emit(state.copyWith(tenderDetailModel: updatedModel));
      }
    } catch (e) {
      final currentModel = state.tenderDetailModel!;
      final updatedData = currentModel.data!.copyWith(
        isFavorite: !(currentModel.data!.isFavorite ?? false),
      );
      final updatedModel = currentModel.copyWith(data: updatedData);
      emit(state.copyWith(tenderDetailModel: updatedModel));
    }
  }
}
