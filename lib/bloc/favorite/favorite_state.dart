part of 'favorite_bloc.dart';

class FavoriteState extends Equatable {
  final bool isLoading;
  final bool isShowCategories;
  const FavoriteState({this.isLoading = false, this.isShowCategories = false});

  FavoriteState copyWith({bool? isLoading, bool? isShowCategories}) {
    return FavoriteState(
      isLoading: isLoading ?? this.isLoading,
      isShowCategories: isShowCategories ?? this.isShowCategories,
    );
  }

  @override
  List<Object> get props => [isLoading, isShowCategories];
}

final class FavoriteInitial extends FavoriteState {}
