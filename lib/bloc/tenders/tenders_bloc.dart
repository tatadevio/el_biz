import 'package:el_biz/bloc/tenders/tenders_event.dart';
import 'package:el_biz/data/repo/tenders_repo.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'tenders_state.dart';

class TendersBloc extends Bloc<TendersEvent, TendersState> {
  final TendersRepo tendersRepo;
  TendersBloc(this.tendersRepo) : super(const TendersState()) {
    on<UpdateGridView>(_updateToggleShowGridView);
    on<FetchAllTenders>(_fetchAllTenders);
  }

  void _updateToggleShowGridView(UpdateGridView event, Emitter<TendersState> emit) {
    emit(state.copywith(isGridView: event.isGridView));
  }

  void _fetchAllTenders(event, emit) async {
    emit(state.copywith(isLoading: true));
    try {
      // final response = await tendersRepo.fetchAllTenders(event.offset);
      // if (response.statusCode == 200) {
      //   print('API response = success');
      // } else {
      //   print('API response = failed');
      // }
    } catch (e) {
      print('Error fetching tenders: $e');
    }
    emit(state.copywith(isLoading: false));
  }
}
