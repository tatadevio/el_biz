import 'package:el_biz/data/model/response/auction/auctions_list_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/auction/auctions_repo.dart';

part 'auctions_event.dart';
part 'auctions_state.dart';

class AuctionsBloc extends Bloc<AuctionsEvent, AuctionsState> {
  final AuctionsRepo auctionsRepo;
  AuctionsBloc(this.auctionsRepo) : super(AuctionsInitial()) {
    on<AuctionsEvent>((event, emit) {});

    on<UpdateAuctionGridView>(_updateToggleShowGridView);
    on<GetAuctions>(_getAuctions);

  }

  void _updateToggleShowGridView(
      UpdateAuctionGridView event, Emitter<AuctionsState> emit) {
    emit(state.copyWith(isGridView: event.isGridView));
  }

  void _getAuctions(GetAuctions event, Emitter<AuctionsState> emit) async {
    if (event.isRefresh) {
      emit(state.copyWith(isLoading: true, currentPage: 1, auctions: []));
    } else {
      if (event.page == 1) {
        emit(state.copyWith(isLoading: true, currentPage: 1, auctions: []));
      } else {
        emit(state.copyWith(isLoadingMore: true));
      }
    }

    try {
      final response = await auctionsRepo.getAuctions(event.page);
      if (response.statusCode == 200) {
        AuctionsListModel auctions = AuctionsListModel.fromJson(response.body);
        List<AuctionListItem> auctionList = auctions.data?.items ?? [];
        // List<AuctionListItem> auctionList = (response.body['data']['data']
        //         as List)
        //     .map((e) => AuctionListItem.fromJson(e))
        //     .toList();

        // int totalPages = response.body['data']['last_page'] ?? 1;

        List<AuctionListItem> allAuctions = [];
        if (event.page == 1 || event.isRefresh) {
          allAuctions = auctionList;
        } else {
          allAuctions = [...state.auctions, ...auctionList];
        }

        emit(state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          auctions: allAuctions,
          currentPage: auctions.data?.currentPage ?? event.page,
          totalPages: auctions.data?.totalPages ?? state.totalPages,
        ));
      } else {
        emit(state.copyWith(isLoading: false, isLoadingMore: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, isLoadingMore: false));
    }
  }

  
}
