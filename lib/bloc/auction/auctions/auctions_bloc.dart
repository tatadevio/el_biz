import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/auction/auctions_repo.dart';

part 'auctions_event.dart';
part 'auctions_state.dart';

class AuctionsBloc extends Bloc<AuctionsEvent, AuctionsState> {
  final AuctionsRepo auctionsRepo;
  AuctionsBloc(this.auctionsRepo) : super(AuctionsInitial()) {
    on<AuctionsEvent>((event, emit) {});

    on<UpdateGridView>(_updateToggleShowGridView);
  }

  void _updateToggleShowGridView(
      UpdateGridView event, Emitter<AuctionsState> emit) {
    emit(state.copyWith(isGridView: event.isGridView));
  }
}
