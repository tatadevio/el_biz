import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repo/tin_repo.dart';
part 'tin_event.dart';
part 'tin_state.dart';

class TinBloc extends Bloc<TinEvent, TinState> {
  final TinRepo tinRepo;
  TinBloc(this.tinRepo) : super(TinInitial()) {
    // on<TinEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<VerifyTinNumber>(_onVerifyTinNumber);
  }

  Future<void> _onVerifyTinNumber(
      VerifyTinNumber event, Emitter<TinState> emit) async {
    emit(TinLoading());
    final res = await tinRepo.verifyTinNumber(event.tinNumber);
    if (res.statusCode == 200) {
      emit(TinSuccess(event.tinNumber));
    } else {
      emit(TinError(res.body['message']));
    }
  }
}
