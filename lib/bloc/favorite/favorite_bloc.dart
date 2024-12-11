import 'package:el_biz/data/repo/favorite_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepo favoriteRepo;
  FavoriteBloc(this.favoriteRepo) : super(const FavoriteState()) {
    on<UpdateShowCategories>((event, emit) {
      emit(state.copyWith(isShowCategories: event.showCategories));
    });
  }
}
