part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class UpdateShowCategories extends FavoriteEvent {
  final bool showCategories;
  const UpdateShowCategories(this.showCategories);

  @override
  List<Object> get props => [showCategories];
}

class UpdateShowGridView extends FavoriteEvent {
  final bool showGridView;
  const UpdateShowGridView(this.showGridView);

  @override
  List<Object> get props => [showGridView];
}
