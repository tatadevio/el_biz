import 'package:bloc/bloc.dart';
import 'package:el_biz/data/repo/post_ad_repo.dart';
import 'package:equatable/equatable.dart';

part 'post_ad_event.dart';
part 'post_ad_state.dart';

class PostAdBloc extends Bloc<PostAdEvent, PostAdState> {
  final PostAdRepo postAdRepo;

  PostAdBloc(this.postAdRepo) : super(const PostAdState()) {
    on<UpdateCategoryId>((event, emit) {
      emit(state.copyWith(selectedCategoryId: event.value, selectedCategory: event.name));
    });

    on<UpdateCityId>((event, emit) {
      emit(state.copyWith(selectedCityId: event.value, selectedCityName: event.name));
    });

    on<AddCategoryName>((event, emit) {
      emit(state.copyWith(selectedCategoryName: event.name));
    });
  }
}
