part of 'favorite_bloc.dart';

class FavoriteState extends Equatable {
  final bool isLoading;
  final bool isShowCategories;
  final bool isShowGridView;
  const FavoriteState({this.isLoading = false, this.isShowCategories = false, this.isShowGridView = true});

  FavoriteState copyWith({bool? isLoading, bool? isShowCategories, bool? isShowGridView}) {
    return FavoriteState(
      isLoading: isLoading ?? this.isLoading,
      isShowCategories: isShowCategories ?? this.isShowCategories,
      isShowGridView: isShowGridView ?? this.isShowGridView,
    );
  }

  @override
  List<Object> get props => [isLoading, isShowCategories, isShowGridView];
}

// final class FavoriteInitial extends FavoriteState {}
