import 'dart:developer';

import 'package:el_biz/data/model/base/add_tender_model.dart';
import 'package:el_biz/data/repo/add_tender_repo.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_connect/http/src/response/response.dart';

part 'add_tender_event.dart';
part 'add_tender_state.dart';

class AddTenderBloc extends Bloc<AddTenderEvent, AddTenderState> {
  final AddTenderRepo addTenderRepo;
  AddTenderBloc(this.addTenderRepo)
      : super(AddTenderState(
          isLoading: false,
          // addTenderModel: AddTenderModel(),
        )) {
    // on<AddTenderEvent>((event, emit) {
    // });

    on<AddNewTender>(_onAddNewTender);

    on<UpdateTender>(_onUpdateTender);
    on<DeleteTenderImage>(_onDeleteTenderImage);
  }

  Future<void> _onAddNewTender(
      AddNewTender event, Emitter<AddTenderState> emit) async {
    // emit()
    emit(AddTenderLoader());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await addTenderRepo.addNewTender(event.addTenderModel);
      if (response.statusCode == 200) {
        emit(AddTenderSuccess());
        //  event. context.read<TendersBloc>().add(ResetNewTendersData());
      } else {
        emit(AddTenderError(response.body['message']));
      }
    } catch (e) {
      emit(AddTenderError(e.toString()));
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _onUpdateTender(
      UpdateTender event, Emitter<AddTenderState> emit) async {
    emit(AddTenderLoader());
    emit(state.copyWith(isLoading: true));
    // emit(AddProductState(productData: state.productData));
    try {
      Response response = await addTenderRepo.addNewTender(event.addTenderModel,
          isUpdate: true, tenderId: event.tenderId.toString());

      if (response.statusCode == 200) {
        if (event.addTenderModel.deleteImages != null &&
            event.addTenderModel.deleteImages!.isNotEmpty) {
          for (var delImage in event.addTenderModel.deleteImages!) {
            add(DeleteTenderImage(
                event.tenderId.toString(), delImage.id.toString()));
          }
        }
        emit(AddTenderSuccess());
        // emit(state.copyWith(addTenderModel: AddTenderModel()));
      } else {
        showShortToast(response.body['message']);
        emit(AddTenderError(response.body['message']));
      }
    } catch (e) {
      log('update product catch = $e');
      showShortToast(e.toString());
      emit(AddTenderError(e.toString()));
      // emit(AddProductFailure(e.toString()));
      // emit(AddProductState(productData: event.addProductModel, error: e.toString()));
    }
  }

  Future<void> _onDeleteTenderImage(
      DeleteTenderImage event, Emitter<AddTenderState> emit) async {
    try {
      Response response =
          await addTenderRepo.deleteTenderImage(event.tenderId, event.imageId);
      if (kDebugMode) {
        print(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print('update product catch = $e');
      }
    }
  }
}
