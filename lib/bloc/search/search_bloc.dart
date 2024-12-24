import 'package:bloc/bloc.dart';
import 'package:el_biz/data/repo/search_repo.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepo searchRepo;
  SearchBloc(this.searchRepo) : super(const SearchState()) {
    on<SearchEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ChangeStatusSearch>((event, emit) {
      emit(state.copyWith(isSearchProducts: event.showProducts));
    });
  }
}
