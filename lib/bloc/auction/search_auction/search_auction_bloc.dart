import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/auction/search_auction_repo.dart';

part 'search_auction_event.dart';
part 'search_auction_state.dart';

class SearchAuctionBloc extends Bloc<SearchAuctionEvent, SearchAuctionState> {
  final SearchAuctionRepo searchAuctionRepo;
  SearchAuctionBloc(this.searchAuctionRepo) : super(SearchAuctionInitial()) {
    on<SearchAuctionEvent>((event, emit) {});
    on<ClearSearchAuctionList>(_onClearSearchAuctionList);
    on<SearchAuction>(_onSearchAuction);
  }

  Future<void> _onClearSearchAuctionList(
      ClearSearchAuctionList event, Emitter<SearchAuctionState> emit) async {
    emit(state.copyWith(searchAuctions: []));
  }

  Future<void> _onSearchAuction(
      SearchAuction event, Emitter<SearchAuctionState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isMoreLoading: true));
    }

    try {
      final response = await searchAuctionRepo.searchAuction(
          event.search, event.currentPage);

      if (response.statusCode == 200) {
        // final companyProducts = CompanyTendersModel.fromJson(response.body);

        // if (event.currentPage == 1) {
        //   emit(state.copyWith(
        //     searchTenders: companyProducts.data?.items,
        //     isLoading: false,
        //   ));
        // } else {
        //   emit(state.copyWith(
        //     searchTenders: List<TenderItem>.from(state.searchTenders)
        //       ..addAll(companyProducts.data?.items ?? []),
        //   ));
        // }

        // emit(state.copyWith(
        //     currentPage: companyProducts.data?.currentPage ?? 1,
        //     pageSize: companyProducts.data?.totalPages ?? 1));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      print("public product catch part = ${e.toString()}");
    }
    emit(state.copyWith(isLoading: false, isMoreLoading: false));
  }
}
