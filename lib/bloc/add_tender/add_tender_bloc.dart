import 'package:el_biz/data/model/base/add_tender_model.dart';
import 'package:el_biz/data/repo/add_tender_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_tender_event.dart';
part 'add_tender_state.dart';

class AddTenderBloc extends Bloc<AddTenderEvent, AddTenderState> {
  final AddTenderRepo addTenderRepo;
  AddTenderBloc(this.addTenderRepo)
      : super(AddTenderState(
            isLoading: false, addTenderModel: AddTenderModel())) {
    // on<AddTenderEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<AddNewTender>(_onAddNewTender);
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
      } else {
        emit(AddTenderError());
      }
    } catch (e) {
      emit(AddTenderError());
    }
    emit(state.copyWith(isLoading: false));
  }
}
