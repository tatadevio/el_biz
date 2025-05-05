import 'package:el_biz/data/repo/public_tender_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'public_tender_event.dart';
part 'public_tender_state.dart';

class PublicTenderBloc extends Bloc<PublicTenderEvent, PublicTenderState> {
  final PublicTenderRepo publicTenderRepo;
  PublicTenderBloc(this.publicTenderRepo) : super(PublicTenderInitial()) {
    on<PublicTenderEvent>((event, emit) {});
  }
}
