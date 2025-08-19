import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:el_biz/data/repo/auction/auction_detail_repo.dart';

part 'auction_detail_event.dart';
part 'auction_detail_state.dart';

class AuctionDetailBloc extends Bloc<AuctionDetailEvent, AuctionDetailState> {
  final AuctionDetailRepo auctionDetailRepo;
  AuctionDetailBloc(this.auctionDetailRepo) : super(AuctionDetailInitial()) {
    on<AuctionDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
